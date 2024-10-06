Return-Path: <netdev+bounces-132573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A1E992264
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 01:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DA01F21771
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1698A18BB8A;
	Sun,  6 Oct 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGaZDlpc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10418A6B8
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728258632; cv=none; b=YF2z3YonFLTkXII8X0ckb5bOzystNMgDeGik/K+qGNExAzGCqgXOfOplooZBCTYlS4n9FAP9ehg03+hqOia0hGEt3+AoWUMmQzGoWc3PmsEVmXv0/Ke8u0UXSVI8MxM5DjP14eO+RG3QbWNnyjoPYp7IQrPPOSaClpMlyYb2NWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728258632; c=relaxed/simple;
	bh=2TZolgmWK6/jlnvYTztJLzMvK4aDMuCnDiutAc7qArE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=enhYR6YPDeGcociBWic55ANiTlZNSCHaFCTPgR8QTcKSrNPUX4r85sgdcpsUeOmCuxO3Z+kJ3yawHHaeUKw1hJyFG1rukzsNoBZHdymMf5ZDogUx/ZMjXGJ/n0O1srHQf5RhFANbhwIK7oBXfekhZ5PN2Ly4KuUwdLSpF+KffRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGaZDlpc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7ae3fcec5feso426758385a.0
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 16:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728258629; x=1728863429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdBgx7tex37BzxQKyHYGsuCNiYAggdX//vlHvGcLdqM=;
        b=FGaZDlpcA21hSvC/bm+Pm0106dBFm+owpivCSJ3ZMu2GH8/1ik7iC427/AgDwyW32o
         q4OheTEqkKP9WbXc/RIY6ldOJY6vEu14StptzKGofvXe9VX9U5tSbBDtiJ3+sllJZfUT
         awpW+mWhFNy3hA8VlJMJdWSrGHKXmeEGgcKfKmu1cZVVlWxDu7r4aBuu4jSVqzWF+RsC
         9TtfeDW07Ci3HKBiYarPRbZO5ed5JnF38ZB06a646oCw/lPjCcs1pC8t6UPzrPiXDfQi
         U4kDOg6VNIknfRl8KXqwHF/+D3DuAyWcdPG5uIOjA80iTiS4GFWM7apYlBs1Uz4rz+ip
         +j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728258629; x=1728863429;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OdBgx7tex37BzxQKyHYGsuCNiYAggdX//vlHvGcLdqM=;
        b=J0Duk58yFGleCmDAe76uZdTbc+VaVGvBa4ZIkLZeC6DDvkdDlI4I7SfefT8ujl1Ebj
         JMu4Q3gJaXnMyegK281FX9oXWBv21qxW1MhUzS6NKsYmyPyyM5N6G7AK1Ef6/2+M78om
         dgf4F98OoCdLsbAHFU2+3MCWuhx/so8lsN1c5ZluhoJOSDxEpKTmZAiP2w3U6Xe7XC2c
         aZsAVIRTeaQeqUdXhtyLL0RuZHDBTktI4VviiK2h+T3pcDXyiOMqk28I5lAPkpwM7Ajk
         tr8d4ah2BTudLXKk7W+hkzdGirrc81bHaTj+0ee2dKbcOyf2vKWVdpJdenlqKy/uMkZO
         cwcg==
X-Gm-Message-State: AOJu0YzaO8OSXxlqhvhmEmRiw8EAevVckTLyqooguIaQkLIGe3Scmcr0
	G+ZfJ4jhUhds/4bFB6Wut+1r1rBSKUh/CAG/mIpSX+GCZXsOb8wo
X-Google-Smtp-Source: AGHT+IFwkfrrxBLFkoAfwkpYMNoVGT++oT8ApTCss2zN9GHzvVYNd2uxg1MmzxpihCoF1h55BItfhw==
X-Received: by 2002:a05:620a:24d4:b0:7a9:bf31:dbc9 with SMTP id af79cd13be357-7ae6f421caamr1723367685a.4.1728258629459;
        Sun, 06 Oct 2024 16:50:29 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7562e04fsm203020685a.35.2024.10.06.16.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 16:50:27 -0700 (PDT)
Date: Sun, 06 Oct 2024 19:50:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 kuniyu@amazon.com
Cc: netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67032243d753_13547929449@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241005222609.94980-1-kerneljasonxing@gmail.com>
References: <20241005222609.94980-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v4] net-timestamp: namespacify the
 sysctl_tstamp_allow_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Let it be tuned in per netns by admins.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

