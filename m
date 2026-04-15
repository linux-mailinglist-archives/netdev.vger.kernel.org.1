Return-Path: <netdev+bounces-278608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACMwJ27k3mmiMAAAu9opvQ
	(envelope-from <netdev+bounces-278608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 03:05:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B1F3FF6F4
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 03:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2DFB3015718
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6A17A30A;
	Wed, 15 Apr 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZC7qgFa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B5199D8
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776215147; cv=none; b=idw2l4rTT0T4YLseBThWN9ooA0h/LTBRTjLQN4ZzoYlgtq0gpueE9Ta31h5iZgr7AOyxY9aeei+UG9K7bDKBiH4RbqhHxXhWR4FierDIoRegQduWLjpZEJVYw9c2OSXUyN1LfaKH8w+SzCOuevasfOs6fYg2DReJ5NRrfcNVUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776215147; c=relaxed/simple;
	bh=BsG8+Oe8+psG7NYsx/xpVbw90E9zPpAcmX+DyQIcITc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1s+1alO0Y2hHUuEhp0rIJ1YnF+00ikNxTHDB+Y6/VdwwdIG+2qyS/L8pe6dBTLrJCJqlC/MtYY6pbwwdFBM9UU3aL+41qt1WTFA59A/o26cpaPw8gqJpcOcYdgOZ5X9X9wLY7v0udOXs3twwJtDDKDsa19ispR7cp9Qy6Xpw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZC7qgFa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d75312379so1912107f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 18:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776215144; x=1776819944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mXBTzw12R6m0VO5N9uDeP+i5xgELPTWIByaKlPH1K8=;
        b=qZC7qgFarOjcTAFpbvH/Zj90QhM+qoElccJjeE5ruMiNK65MrhRvtQgU+wb6lq4AmM
         MjarFZhv4t/4ta1yQvRYbzWS6bFPt4rKxurtHdeuLRJ1fxZ3FR+wWiRm0syDofDO6wCO
         5VsRlQqtuMKym2uowokiIsAQOVq1ePCoAyLoZ5oq2ySXZitQqNR1ILzOHopzF+5DIWC4
         1Tj9h2BVrUTTrJNVRe8EooVG3Ee9vTfa/XrsUSHKdnxeVx/tq51hKYcTP5oc7/UTWcAk
         P7QgU8aBAGZAcEQChDBoGoNq8ZY20MoodtrYJtcIUq5h10SJbUgOrNwBWcpSqKtXo+G2
         tOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776215144; x=1776819944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5mXBTzw12R6m0VO5N9uDeP+i5xgELPTWIByaKlPH1K8=;
        b=nIHDMW8KUoaUI2YxHAUIXHkpusGnskbw9MUp33OPg0j3pODBY7M18uhNy3TBu8YDMR
         U2q5FmvU5u4e582mG8pu0OxrAwRc3lYBkElva+ahenxAZa+Whsg50moJdpAN4VvLT2JP
         +5INQvOgvLKMmyCT2KUpzZ4/s43pz24hStiJi+4DfAiGo6mpAsc4jpCYk073MIJ53zkf
         /Bje/p3tshgKFmet2CytRhc8+hC8fi6TvFOjeRgMDCHW19Zid9YsakqQGOG4zhBYU2Vm
         mV7ZEWrqgyxYU95buPMYpupKP4wvCiLElIUSlMWkdv/s0MUuE3Kez63f354nS/oEP67j
         SKAg==
X-Forwarded-Encrypted: i=1; AFNElJ9bHJs9uBGtWWhukqAtRiLjFQnrx+wdRcKU/6WZvCzuv9J/VES+Xi0k0WeXi3l1/FokD0BI6u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0kcU9cYsL7G484JnMqy/iR4ZfaxrtN2tMOxqVT1fSBmRg/3h
	Up9eg+6pvP4FWVq/LSaXeGVZ/NK9MVh5ssdAX5kHCLFSGqNPb0Y7t/DN
X-Gm-Gg: AeBDieudYKfDDoM0irtEPyanWBLvPHh567Ax6lwtal2XqURB9NEYfRcZPWiefoGTl16
	/d5DPr2aLUIud8dbkYiFHC3rmQh1eghUkPWCgUN4BYaPdgNMqmyu7HTiTVzHFc93CxI1qxJ4NVC
	noho4KWWysg6lcz+ktZilBre/+HBKI1huMKWFevC6WfdZQeCEWziMy6Jn6+HvDPp9GrYuwSn/GN
	yYwi+h3GeiA/HuXS5KLUdNBrxL6uBcO/PQOeGBrzHUbcr6c/xPs7V65GI/Y0AnBYV81tFcrBgBx
	7Aazuke0Um/iyCQqS3y4MRxrrxIFwRS6u1U29sxrwrCriABMUNz2A213aeflMSEmvjgkvsSE0XI
	UtsEvFUYSQt96g6hWjUMwuAFvENjhcY06HeuLcq78uatXdYYxR8x/G1tx5BJIa2wmgahLkRKo4N
	0cyhrC8lLieq+n8ldgE6gT3RW45GZeX8MnvUV1nuC5TFoSW2mPrTX/Fm5XkbeUWey7lUKHdr+3k
	lfwDgtXl0A0HqC1H6scYOHFweKyz1Qpr4SSyVAsgw==
X-Received: by 2002:a05:6000:42ca:b0:43d:7086:b03 with SMTP id ffacd0b85a97d-43d70860b78mr11045470f8f.1.1776215144142;
        Tue, 14 Apr 2026 18:05:44 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5c8fsm489879f8f.19.2026.04.14.18.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 18:05:42 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Carolina Jubran <cjubran@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] net/mlx5: Fix OOB access and stack information leak in PTP event handling
Date: Wed, 15 Apr 2026 02:05:19 +0100
Message-ID: <20260415010535.34855-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413144610.GJ21470@unreal>
References: <20260413144610.GJ21470@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278608-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4B1F3FF6F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 05:46:10PM +0300, Leon Romanovsky wrote:
> On Sun, Apr 12, 2026 at 01:04:10AM +0100, Prathamesh Deshpande wrote:
> > In mlx5_pps_event(), several critical issues were identified:
> > 
> > 1. The 'pin' index from the hardware event was used without bounds
> >    checking to index 'pin_config' and 'pps_info->start'. Check against
> >    MAX_PIN_NUM to prevent out-of-bounds access.
> 
> You were told more than once that this is impossible.
> 
> <...>
> 
> > +	if (WARN_ON_ONCE(pin >= MAX_PIN_NUM))
> > +		return NOTIFY_OK;
> 
> Let's not add useless checks in fast path.

Hi Leon,

Thanks for the feedback. I've addressed this in v5 by dropping the 
redundant pin bounds and pin_config checks to keep the fast path clean, 
focusing strictly on the stack leak and NULL clock guard fixes.

Thanks,
Prathamesh

