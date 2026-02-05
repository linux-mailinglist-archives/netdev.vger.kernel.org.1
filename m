Return-Path: <netdev+bounces-256892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YId9Iu7ng2n+vQMAu9opvQ
	(envelope-from <netdev+bounces-256892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:44:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A629BED798
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 01:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 486BA3004622
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 00:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329721EF39E;
	Thu,  5 Feb 2026 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaidY3ll"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085F1E5B73
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 00:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770252264; cv=none; b=nXrtJRbUzupWnJGecetFOeaDtY1BDrznQn/m1CbfpQWx+vcil0vLTnItBx/gHVDmoDnqMGoXzGoOP1cmGbPMVBZs3jODVEueZBkEuGLvivThl+DRwsQ6cVhPhAZYxmNZMlyk2VL5CmwDSQbJ1bzFVfmUv6VM/2ApIN+R2AgxxMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770252264; c=relaxed/simple;
	bh=AKFp10G4mwqHuX2vHl8YA9U4zRMWSKwsOVSa6IPNtjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQzVBqq33IXdhWVHyQp2LmjIuuIta6AcgQiZq3cNj2IapWfN/XSTHWEnA/RzSHfyjELxju2ypcwmnsQ1vcfFWsWDNS3ncmKic+BkZdGQa45EbGw8ANULNu0fM8n+wuj2+jF8rUCxV0OLYaJ6G57jn7ayBhGS4FbnopSLjvOkEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaidY3ll; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-40438380b88so267742fac.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 16:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770252263; x=1770857063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKFp10G4mwqHuX2vHl8YA9U4zRMWSKwsOVSa6IPNtjg=;
        b=RaidY3llxnJDrFxImzIXHTLGn5gjL/id3vFglNRZuv4VPp6RwSyjUKxRoSrogmk8Rx
         gEaOMUth18hH8cPZ5gCh6PjOJ5AvOxKejOgNNtH39kgYzA2RdpEbsng0sXih/1CbOoW9
         nf2ai0/TrY4cME1kekZnuQnGN2+al42OSfmd3wBjreYRQdcQpG9xSjAi3rr15GXvbsJC
         WOXbEuoe0UTjyD8DHfImXYMr1sq9pqKsN16Ridf6ZmzDecHT/BLUl8XEbpqNn2VQuMXj
         cqnX9aMKqPC3Q74nnbssRHgEYf+dqozSrUW2BwJdF1KSkVFmrMxo9y5zG7Yforkz+Rvr
         vKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770252263; x=1770857063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AKFp10G4mwqHuX2vHl8YA9U4zRMWSKwsOVSa6IPNtjg=;
        b=u+oTX4/tAJ70mKoo5C2mqOoJfRTgLtr468ybX+RgeLnyml8vHMciGTpDPgp/Fu95L3
         z+cg0QpEYswkWq6rrG9BKu70crL1C+joOldxzb4+n1YSd5t6hR2aGq24utihBWaqxv3l
         pEY8Osejs7/70CCAN5w3LrMlCfQJkA/PJnpCIiWfyyG3N+ypb+sn+ozDypPtuJLOhPBY
         uIVeZMJD4paE5l2yiCiPGUzZxoCyhB0zRsWQ/wDfVMnjG05p45EPlaVY82BnrczbhB7l
         wdP7NY8EQ07kXOhdCe35Xd5YAZN4OBqF3bQmrOP6hdUQrPZucYpxdOL+DeSZrZflpYUZ
         fKiw==
X-Forwarded-Encrypted: i=1; AJvYcCVPh2LQQ++K5eV1yix9su5OOHfsqklHKKoaTRStdCSk1k+eg0XM+xHhhuBzd4Fy2cDFbbcQVxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFBh5zyFIWOFXAczJNmIcZugtXYVQKsBDG6Rb0bqtV893LqfJI
	hKv8JvLqFWui/dz4zx+nyNaqcJ3Gu5Ia54e1nECfrUZuflyjk+D2Pa/A
X-Gm-Gg: AZuq6aL5i6vnNxBHf+ReY6PjYuhX34tQvLc8aBeJuCiXlwl2s/tdQrHc9pFwrySGOdW
	vlAM9BYhEkZLVfC2W42+DJw9Xm8kQSItlglxCtSRf2ll6LJp+axXotZ+L2Z60Ix6L46+wSSP00m
	ayg0eWdhKT8mgdivkDMrH3mLWrhZD3icLUfIOxpQZo3ecDwqC/7RV/ZFGyqPhIzrwxW91mqBgKA
	WZVQ6bmo4y+qFDDdUGRpdbmXdu1LQR4jFuxQl/arbmH3LPNUhpCMSJ1K937LUw32m3AgZrX2JhW
	V+xi6PJHkD39zKBtdssUo1xC4zZqUDOWDa9qN9zMc4pIS8eGloavy9lWeA3Yml30QkwFLu8UYvn
	mef45XV9Pw+aPky1awP2ow+pmQoYMGeNm2qJRGcRopfocpE9kbMEG4kUjPyrP28QJ+pkLUsDVNq
	rr/xAuQyw1lXZ5TyWeCKGa6/PHuQXCsgAkX1iQwv+qAYUnoSokT/X2aAWnJ8MK/3PLyLI5FW7tR
	nN3S9wvp9fvkeILq/1ouYtmwRSbVI6623Btg6VJNL+mONNE4X5E8LeesrddQdI7ZHanphE8qHYQ
	F/ZBVRh0dlWx
X-Received: by 2002:a05:6870:a1a7:b0:3f1:6d93:4386 with SMTP id 586e51a60fabf-40a53acd027mr2383518fac.1.1770252262713;
        Wed, 04 Feb 2026 16:44:22 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a544243c0sm2680863fac.10.2026.02.04.16.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 16:44:22 -0800 (PST)
From: OnesuchDev <enelsonmoore@gmail.com>
X-Google-Original-From: OnesuchDev <onesuchdev@gmail.com>
To: macro@orcam.me.uk
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pcnet32@frontier.com,
	tsbogend@alpha.franken.de
Subject: Re: [PATCH net-next v2] net: ethernet: pcnet32: remove VLB support
Date: Wed,  4 Feb 2026 16:44:20 -0800
Message-ID: <20260205004420.13667-1-onesuchdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <alpine.DEB.2.21.2602050003510.12532@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2602050003510.12532@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com,frontier.com,alpha.franken.de];
	TAGGED_FROM(0.00)[bounces-256892-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A629BED798
X-Rspamd-Action: no action

Hi, Maciej,

It was not my intention to spread FUD - I had simply forgotten the previous conversation when I sent this follow-up.
As can be seen from my previous message where I said "I don't think [removing pcnet32] going to happen anytime soon, given what people have said about its uses", I agree with your reasons for wanting to keep the driver, and I'm glad to hear it works on recent kernels on real hardware.

Do you have any issues with short stalls under high network load, like I do in QEMU?

Ethan

