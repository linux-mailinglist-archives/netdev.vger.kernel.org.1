Return-Path: <netdev+bounces-166511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C35A363D8
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 18:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F487A28E8
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6F3267B18;
	Fri, 14 Feb 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeLxhHaa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395224291F
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552613; cv=none; b=YUFSmGxSxYs1LR9nw9VRQ2rG/XVuJ4I+0W3r6C/xZA+5DwVTp6c5H0/Q8GUrUA/SCWkxEouf0bqP7fW1yiAHiuVs79DGfhalw4dHyv1rErS7wNkcK4RHCB6ltyG44L7ZvxZ4iZLvh33WtYJuRU1qsxsDHZ+WWrMBUmwFOLJ04DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552613; c=relaxed/simple;
	bh=BlJTXi4YrMYiFwdW0nq8J2qfnIvEmq5Q7QNxw1zC3dM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jlYsuAoD3BXDk8xMSM5GjyU5CIYWqN7TPSut4OBTxFSHZWAKG4k+5wtt6pB5P6N2tufanQCTc7dSRGT5WuXd16xeeM7u2jNLeGWZp9qy76UyEBmlMV5MSXykjcanPg0kzIaeezXb73lJAsYTPLEV5GmSDHtTZXUhmKLCtCr/MWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeLxhHaa; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-545097ff67cso2275077e87.2
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 09:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739552610; x=1740157410; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BlJTXi4YrMYiFwdW0nq8J2qfnIvEmq5Q7QNxw1zC3dM=;
        b=FeLxhHaa36GCN8Ha9nfJ8eM61W+d8Bul0uFe/FqWoVECVAnL7VHQAmdNbOhhnsWiJh
         S8ff4LnrBcvepYnzZuVWqIg+7wpKhcVM/mI1MdDJHPi11azP1ol+e1LGoNY70RgOopIR
         SLWWiwYSLfl+7OrUKMbdEEEz2c2T8+4TL2skQMJWY4oIWV44uH0IttnY3beWMfbJ8Nd1
         vluRrUjIyFs9xr93NAh3o2f7se2bdODcwTRUMEvJQuV/OKAxhPzDDqbJRABXkpymbSue
         uE/Hx2wixdend42yHRMkGGowhEFrg/92Mlz6w4z2Wm/pn6vt0Pah4YpAucUwv2/iHhg4
         Gl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739552610; x=1740157410;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlJTXi4YrMYiFwdW0nq8J2qfnIvEmq5Q7QNxw1zC3dM=;
        b=em826zopUhtTex+y4OFBoKQsIyI6bjRoa+ApLjkMPCFX8BgfGDtDovErJSiC8SGNAv
         Zr1ijVK1xA+7a5fbpq9bBSl1mqBEWzAeSUtyz/7CPkcAw+KuEthEG94f5BkWKiwUN275
         qx3dD0kLSdkb4sA6bNUZPNzQpA+Z9CJtYfdZJSsuI7n+SaM0awg1oNa3V9+amW5O84F+
         YAouCfEK4QTpUHZFD8l2DLN4SSV9YhxSjh1W0ENTEnUlXO41IxEDE2OiQZo7QryBTgj4
         AiywT37sn9/eZRD9kB0YqgyOwq14R46AUcYRSYMFxM5nWaTx+zVMQw29uUlJRLE77Kqo
         7NZA==
X-Gm-Message-State: AOJu0YwZsvfcwNdei6waLvuTXQD+eBBPBGOAvXHhTBSlMCS68Z/JpeGi
	oSJd9DiPdQKmxN2rYHW93ioWEGS3Si4aYnZNrOllEdt5e5ZvMXyJ2ugfacjCmTXHHNM2z4LqNrj
	J1Z9K9pgoJGXNsIm/OyAqfG+0DqwwoRPS
X-Gm-Gg: ASbGncsFCOyZehdxb9glSj8nR82NMqJzD/FSDknHGIJ4IFVWtieiERlBOyx/nYBUfrD
	KJA2WAewvdrYT5jPocc4Lw7YKkkr2xL0gQUA8mQATZ468S0XQmT8hkCghAd9Pbc/ZkAuWC8FDKU
	/NkuK97e0oKX/1dJZUatiPF9ccNDlJEbc=
X-Google-Smtp-Source: AGHT+IHW8UFQ7l28FKJM0BlUoAwBJqhvAquivamjc7bnV1r7OJ58TPcDBeuphXT8uXGYUumK81xa+AQLKO7JHMWBMuQ=
X-Received: by 2002:a05:6512:3051:b0:545:ae6:d740 with SMTP id
 2adb3069b0e04-5452fe8bf35mr20643e87.41.1739552609372; Fri, 14 Feb 2025
 09:03:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?7KCc7J6E7Iqk?= <jaymaacton@gmail.com>
Date: Fri, 14 Feb 2025 12:03:17 -0500
X-Gm-Features: AWEUYZnfF_Tk7dG2cnSv-o3zuYAmdel0Fogpae7pu6Amq-U3IJNjVIal0poNKkI
Message-ID: <CAPpvP8+0KftCR7WOFTf2DEOc1q_hszCHHb6pE2R-bhXMOub6Rw@mail.gmail.com>
Subject: Question about TCP delayed-ack and PUSH flag behavior
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi netdev,

When tcp stack receives a segment with PUSH flag set, does the stack
immediately send out for the corresponding ACK with ignoring delay-ack
timer?
Or regardless of the PUSH flag, delay-ack is always enforced?

Thanks,
JY

