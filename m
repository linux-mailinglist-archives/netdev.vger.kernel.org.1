Return-Path: <netdev+bounces-122066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A865195FCAF
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535431F2268A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF219CD0B;
	Mon, 26 Aug 2024 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzHUtZJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1E13FD66
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711033; cv=none; b=NojP8C2KuMpLBJX5S/AIdyEj9NwjJEicnwl/DpSYgWnLHJAV22VXIq1pw2YRopZlefPI0g+qSleUqRimBDcHgXG3YPTaAOMHMk48O5DVacVzxGVEYfMmgSbGnphqaYoJXXlDoHsgylF2EJC+xm1tJdUH1l5TJ/P2uJZntyMGSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711033; c=relaxed/simple;
	bh=z/z0o9iRKt3+OtB5EzY+Gcp4sRfypaMiTZX+U/GA0uM=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=i+n64nZqj4zrMl9kP9kycpp2sodpueo1cdAU5KskCsGyo5K3oChMmdh3cWZs0vRU6RGyes8mSuGowNR4JrOQC9jiOQi1s6TJOlGxqSQn591/lm/ypM6ra4XgV6rn8d0D6uo5IdJMv7pVcjphdbxOb66ujNG6766hQHG65oA2vOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzHUtZJz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71423704ef3so3918014b3a.3
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724711031; x=1725315831; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NS9QQj5ezS4buH/TDpgpRgKeMHTB95UPnF3c6Kl2WbM=;
        b=GzHUtZJzY2VMs7vlqvZw7ByD1fkOxskekdAjK6NRGvjublRg6+yW0Qa4qREkpOCyQS
         Sdcq2fM1UAXPqPSXENnTg18/U7Ln2SupvBvp7p4kUlZcbx2IxVSBEajhAFOMeuyZtJrY
         ACPGzpSa5wpHDnhMcRQ6AHlJtIQCUYTmuiCOAUuh+hZu3IWU16Cw4h2FGr/WNceOcHH7
         JwTyJ+zS5B8n9yrS7NYM0FGv7lzD1TF+Yg3aDf/uz2MZCDLiIyEbp0sy5LZxAo3RiM4K
         D/vYMb5EThQdsen4fa6sKnEcqc03TzDjq0kse3kIS4AizzXZ8Po8ZtTqtUIc9aFpx/gI
         BrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724711031; x=1725315831;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NS9QQj5ezS4buH/TDpgpRgKeMHTB95UPnF3c6Kl2WbM=;
        b=WKWcfmIHTvGpz2lqDu6a3SJozurJXfRQnhdRAK4u3O2zUJGVcFJHLswEcRGVTEviNU
         cVZojAI0XDUhnCFnoUcsaWPs7BkDGSp55h1HtB33znbBuFmFg5r7pMvb/oa1xAuQLa7E
         AcGFFW5VGUgrVi2IJpWFUti+Txnr4uc8bBmBvCq4evSWNFohZ2o4av2NKbzj+/E/uqI0
         CWHR2hFGnVxoTiRpj9Jvzn9tg9fwvRSydpVrtKvzZlddHX+Us0+zJ6ZCzVvQVvcPIOSq
         EBP46/8Fk42Jz94Z4RpUYfob+ps/JbcGL67N/Pat3ftUtYIj7+zMoHECzDPdPamp1ntj
         jNLw==
X-Gm-Message-State: AOJu0YwgoppPqLZWrsRS7oYOYumPstdX5vllwH8CGiun7XJapqptEqzn
	y3loK192xFSIsiGa4uMy7HniP1TPJ1+JB5mGDle1D7ZHjWJvWJFH89S2RQ==
X-Google-Smtp-Source: AGHT+IEj4uIQHENE90r61JQvXRtaBMLtXG/e4bLMu9q3FbaiOt6RRwxA3I/rY19fhpWwIuG1cglE5Q==
X-Received: by 2002:a05:6a00:1a89:b0:714:3822:143c with SMTP id d2e1a72fcca58-71445e106b4mr11325148b3a.23.1724711030765;
        Mon, 26 Aug 2024 15:23:50 -0700 (PDT)
Received: from smtpclient.apple ([2600:381:a500:a491:22:fcd1:e84f:ce7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143432ee26sm7468746b3a.188.2024.08.26.15.23.50
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 15:23:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: SIMON BABY <simonkbaby@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Mon, 26 Aug 2024 15:23:39 -0700
Subject: Query on sample configuration to test network trqffic between two different networks with dsa enumerated ports 
Message-Id: <B4EB051B-5E69-46A1-8A72-AB3D1F9B6736@gmail.com>
To: netdev@vger.kernel.org
X-Mailer: iPhone Mail (21F90)


Hello Team ,
This is a basic networking related test for testing DSA enumerated ports for=
 traffic.=20

My requirement is .=20

I have eth0 as the  dsa master port ( cpu port ) and the slave ports are lan=
1, lan2 =E2=80=A6. lan7 . =20

I have two PCs. One (PC1) connected to lan1 and the other one (PC2) connecte=
d to lan2.=20
 PC1 and PC2 are in different networks.=20
I have to long between PC1 and PC2 .=20
What changes are required at the system to route traffic between lan1 and la=
n2 . Do I need to configure a layer2 bridge or we could do with L3 routing ?=


Regards
Simon



