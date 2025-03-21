Return-Path: <netdev+bounces-176747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A03A6BEE0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DB23B88D9
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438C61F1511;
	Fri, 21 Mar 2025 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B35U4dZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5542A94;
	Fri, 21 Mar 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572530; cv=none; b=l6jzQlilHQ0ayEMADocZvwL3C1+8TVVAaKXNIQt3iGB8Gnue2hfXPv/53TC4J4FwyRYw6xA6qYbLLH/DTU4CAkaSy3BpEuzusy62YsWhCRBbltUCfRRoUNt0QaXKYbV4VCiDJcY3xJkJ1QRurBVZZ5CtRKwC0ucHu313n8V/Lb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572530; c=relaxed/simple;
	bh=AIjDplhk7wchit7yazvFfxh+y7x80Sg5IxVpq7O6yWI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Dll1GYTzMXKwIDqk2WQ2t6oesVcccQ7yhGHsXWOB/mktcm89H8NRx8EWffPlwJsc/DRsOm8q/zRh2CMdbb590UGiHYJQy5Z8bPUq1eVyi8WJou7nFUu8P+6tDdEGT/6Jonsy7fUADR8LugcWb4qioYEIvbqn3Kz3HFe50qR2kKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B35U4dZF; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e86b92d3b0so17515686d6.2;
        Fri, 21 Mar 2025 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742572527; x=1743177327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+koC8KnJGIb6PxjCwp2vUv/FTPsB/nBErjP42zRihk=;
        b=B35U4dZF5MawUuVm7hK2Tvy2B/7qxEXNbF11nA9OuGeO5eNzzkJWef6/qLbphgMgsn
         j4rs9W2PUTvZ/InhlaCd5JwM02YitcV2EKMq0osewIZD9D1zd7/iyqLU7TrtmaoxqMmi
         jfcqLsF3OKtAr9QuqJJkzc9F2oL2Ctz2DNioACZfdEfT7+uhByykXaiQSCDEuZ4Whb3q
         brHsbiBGEQ1cDCuJfB9XuvKxZX+1Qt4qg3qv6D5PA8yaZhjZ01nCa49BtDBsPgOgMWk4
         yLMl5ZGA6P+TtKh2lk1ZHyDIF2zjtP6t53oCVTvDlTaLaiZvc/WfF/0iufwEj+haU0Hs
         5KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572527; x=1743177327;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z+koC8KnJGIb6PxjCwp2vUv/FTPsB/nBErjP42zRihk=;
        b=IeMWPwZmR22J+hYVuGsL/oxfejwsc8iSeU6AI+QP2xK4yHmAHYVOipoaUfGBIANwal
         Zs5pJ+xFVT6DOoOMKsbVcO6HGAjI68WmCWc5wNOvkQp0sA+hNB9iIWEY2yphA5wKuvY2
         4NKQAly1ussGbZphCJxnOlLpSh5pClbbfDmBHVV2RXLCNxfg527nj/Eu6sA8W43C0JaG
         Aq2qdqpgelo0L308cCtJyu1iY2wYFxh4uOrRYmlOwEl78Ri8/GKnQkKm1RbHBI5IxLE4
         kBtQR2Nq4j8SoUkz/5dFUJQ0izXvDNIJ42NsiGAx3u1VhWlAABIg7mONFCUzXKrpUbY2
         5WHA==
X-Forwarded-Encrypted: i=1; AJvYcCWdSGhaRwnzoJ+7HCUoBcYZ9299KVkRAvvtsUFxf84E5B+sLq5Xi8OzJN2+9IZsGJzNl0RgGH/HgVakI/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyENBcW2bItIj/lyROeSLraQjjYTUGxhDZb/5gZznUjc42CFLps
	AD5zJgXrlyGWnrhLpZnavSCB1YkdvObfeTJQxjpwUbzT4Zgv7aGurc0ffA==
X-Gm-Gg: ASbGncvS4pU5XNvybyhk9XrPFzL1lSgT2IuYGR3UDYA0wavhS2f1Nn2XfT9C+MXTX3B
	P8CyZEo9D9wqT9HUFKZTk4NFHdt7dwh72ccBvb5ckizc3QkqmWBRRxs8ts2Ee7ehNJ0EjjcFU75
	KsNezo1yk8naWaJ1IKbd5bq6ctF8vawYqsmILQUWsCgUCgfzUKKHJ/mc9wDWWAXsY2lMjA0NQ51
	5mTKvTZEtE2i/7hsJsqt+1MCwkyVQQwx6bom8os2QWi1feHOeoR/wfHyN342kMnXaVrXFCAEcXU
	3LJB2RrmTOAiBZexF8XC1TDiro/iFQnVI6KTODezZ02kcK1ecmQoVHIKjbkPYLUBl4m5dmNrsWl
	fPHqoI+JB8fnEpXE5w2h8CA==
X-Google-Smtp-Source: AGHT+IFR2d1Q5glgHdLf/N5JMUFj+919MSQwMdXHPW3MrHechQBbpRE0MTU9+5K5UHOo/ce1JR1LBQ==
X-Received: by 2002:ad4:5cad:0:b0:6d4:19a0:202 with SMTP id 6a1803df08f44-6eb3f339763mr63530006d6.33.1742572527254;
        Fri, 21 Mar 2025 08:55:27 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f81dsm12471996d6.38.2025.03.21.08.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:55:26 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:55:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pranjal Shrivastava <praan@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, 
 linux-parisc@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Pranjal Shrivastava <praan@google.com>
Message-ID: <67dd8beeeff3_14b14029476@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250321103848.550689-1-praan@google.com>
References: <20250321103848.550689-1-praan@google.com>
Subject: Re: [PATCH] net: Fix the devmem sock opts and msgs for parisc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pranjal Shrivastava wrote:
> The devmem socket options and socket control message definitions
> introduced in the TCP devmem series[1] incorrectly continued the socket
> definitions for arch/parisc.
> 
> The UAPI change seems safe as there are currently no drivers that
> declare support for devmem TCP RX via PP_FLAG_ALLOW_UNREADABLE_NETMEM.
> Hence, fixing this UAPI should be safe.
> 
> Fix the devmem socket options and socket control message definitions to
> reflect the series followed by arch/parisc.
> 
> [1]
> https://lore.kernel.org/lkml/20240910171458.219195-10-almasrymina@google.com/
> 
> Fixes: 8f0b3cc9a4c10 ("tcp: RX path for devmem TCP")
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

This patch is already marked in patchwork as not applicable.

Because it is not correctly marked as [PATCH net]?

Patchwork interpreted it as not a local patch.

It affects parisc, but the patch referenced in Fixes also went in
through net-next. So I think this should go through net.

