Return-Path: <netdev+bounces-258752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGqZLSgckWlRfQEAu9opvQ
	(envelope-from <netdev+bounces-258752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 02:06:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C19B13DD9B
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 02:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C07B7301703C
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 01:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050931D618E;
	Sun, 15 Feb 2026 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vb+Jzbmg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6619CC28
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771117598; cv=none; b=Vvvfi7miND7gM8+SwPVJB6Jt3AP44ML/H3LAEcTAmM4hw9S6eqOD5+PJmYyspnHwLXBDx1UPVBAE/E96+zqv2rsy4dj/3ma0pA047LiRxg4PoBEvFmu835abeMvS0bBxcV6vrP23l1iabGJJeoMO1wHD6pMvgHqmkjpvK+Annyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771117598; c=relaxed/simple;
	bh=lu0RBEWKjIEJnmsOLIdWPF/JVFWKvY5L4v0aQ1RN8AM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gr9yJcELUs6jT5z/uxCWmjz2+WlPURNzVYrws/h0vfMViZy11pl4mb1+YzxE+fGFCbCuzlRP2PU5OCWn1ylr3PI3nLCmJkRK1BvcMch3RdcBbjeTTMtR06j5aYX3JvDEkuW8owpw3I7/+Be1HAZJn1u0MlpBo74lKVROU2Nj7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vb+Jzbmg; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4044d3ff57bso980222fac.0
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 17:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771117595; x=1771722395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJ/Afk3bypA9GyZrFiet2Pfeppld0QGw+7P47/14WNc=;
        b=vb+JzbmgcUi/IDTlfJ4Oz8ReIaf6eNFQvff+4wyIFvQ9343++klSEx8tZMthizG1Em
         pTljjYmDxU0yJRQwfq5+lwTyqz677VuZ7bn0QnuhV7n20DKng55qGsAXl+hwhMPWAadK
         g7nidMk8dC4B0DP8UO5VmtRM4aa9mxZJt/58UtFRypfLaxkv4M5coFqSB3o3mDkJeQ27
         zN57RbOWaguQSU11vkVvJI08j2gTcRfgajb5ACumMPvOnpLCPkVCIH9Km9F/DpYPKjPo
         k8fmNXP9SeGTYtRU27jyXD1/WHe/fDO1JXNjlyEYis2CXnYQxY1hVrMbpgiXyFSvY0yW
         sdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771117595; x=1771722395;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VJ/Afk3bypA9GyZrFiet2Pfeppld0QGw+7P47/14WNc=;
        b=KKoZmpbK96ZjwtJ8/35HMi6WvdsD42HcOs9qfAYsTXpOEjViJYDbK5+MzoEpCIducM
         LUweZEqqxQS7GfjNIoRB6xYjLh2bWOWklg5RkEGiOhhKJ/Uln1vTBBrGBjZOTk17EnAG
         S2uuC7EvrinxassU/cFDMHPYMSl5DMP88SPF14Qig3ZGJZydSvrYjnyMikf0yxLFeubS
         A51xEVGs2+noIwqGx0f3GEQs/frQJ2zhJVufi/t4kf+/6hH8IkacIGzNEJ59eqdTnzOl
         GIVnB01Pc+/IKNTkTOec1hPAEhrC5JohJTGeR3XTrkkMVg1NpuYJY9XczV3/kX34+FD0
         1++g==
X-Gm-Message-State: AOJu0YwyzsXOWXKYPr1fgfdzyC1XsmNx2dZ0Z1+z84JoWePkOkwQmtMV
	RK84APX5e6b+dMrlsqUSMR8oZFSPH7fL0SxeN7iDtHePWDSKQ+1gXiGXybyp2VSVH8FUu46fp2S
	EPOJh
X-Gm-Gg: AZuq6aIDLHshwvBSFPYsLrQNoLoybwCNM8v30fSgbzF2umS6VRl1+0SRcB1mWixtBGs
	dpiEDW4qgfD7nScF8kpJ4t8sT8YPjCoxPgphM8f7kGeln3/Zy05j+wI1XFIOphaJXMFhRISr9Dx
	XydvkF5ncfgCF7JDchQxHa7N+QhHAi+nq0QpCRY0S2pEI84jAD0xTuolHl5IpUzgocSLd3nfq6t
	bZaHk/T2FA3J7En86QYwXMsX0UD9XSNzgtNqFNSVNk6/MD83IrtoIBbAjRnd1iumtYZicfCsnz5
	UqbEIV5MvRkoCHZLHRYiL4nbFdbP3HSeykBE7rwcaS3B1lqCYgnBJa0s48uxijdTrmhmSjwzW8C
	+vH4ZAXpDgVndTo5jmMI6/sRFqtswmvln0npdAi30PSgi813ErFLQjkExoeo+2xn1747Wp9GHLa
	VPwT2r/lqjjVfBwejZrzb8G9O3err8K8X+g9YLe9CAU35PeTkErH/WyhZMsABQ9FPJG9AHpS2LG
	/QG
X-Received: by 2002:a05:6870:84c7:b0:404:4157:3dc9 with SMTP id 586e51a60fabf-40f0d9581e5mr2219778fac.42.1771117595194;
        Sat, 14 Feb 2026 17:06:35 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaf1e858bsm10583097fac.19.2026.02.14.17.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 17:06:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <de01fd4111d3f89ddbddb70bdd427c741f0cda46.1771091730.git.asml.silence@gmail.com>
References: <de01fd4111d3f89ddbddb70bdd427c741f0cda46.1771091730.git.asml.silence@gmail.com>
Subject: Re: [PATCH 1/1] io_uring/zcrx: fix sgtable leak on mapping
 failures
Message-Id: <177111759401.436334.18359471040201613553.b4-ty@kernel.dk>
Date: Sat, 14 Feb 2026 18:06:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258752-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1C19B13DD9B
X-Rspamd-Action: no action


On Sat, 14 Feb 2026 22:19:32 +0000, Pavel Begunkov wrote:
> In an unlikely case when io_populate_area_dma() fails, which could only
> happen on a PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA machine,
> io_zcrx_map_area() will have an initialised and not freed table. It was
> supposed to be cleaned up in the error path, but !is_mapped prevents
> that.
> 
> 
> [...]

Applied, thanks!

[1/1] io_uring/zcrx: fix sgtable leak on mapping failures
      commit: a983aae397767e9da931128ff2b5bf9066513ce3

Best regards,
-- 
Jens Axboe




