Return-Path: <netdev+bounces-264093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IPRAc7EqGlaxAAAu9opvQ
	(envelope-from <netdev+bounces-264093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:48:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ABB209201
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF4E7303A4AA
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE434D902;
	Wed,  4 Mar 2026 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAh8O95W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3B3382E7
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668102; cv=none; b=okHSZXhQgxpSs3p/6wSu1ZbqcDYQrn1xtAVAPSUH5Pr47ZRdQ2q26b/y/RnprcZwKHF+KQ7vImevVJZ9u8TyhDYyutIn0eEixHyMym9nh6D/VXlkhbTYZmou2eUVngNCkzknILozwq8ayPQkIIYnzKGd8DwhYPzK4PbzPweWmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668102; c=relaxed/simple;
	bh=gQZA4VyD57UEiZd0Im6sXhICW0i1Hw90ECCJj5wbPcY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=A9d51fwSME31y2AyjY6ZI3xPHRMSE6JEAQQ+9YN+HX7HwM8+CzHeGYURaSMXji5NWB2q2PNSo7Z6D1yUY993cd17DCbnyTBONJEf+TNTp6BhMjkQoFr9L9Rouio8+9OlCD851HqG5gbKJe4o8veiu/qBJl37IQcoooCCi50YOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAh8O95W; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ad8435f46so7081139d50.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772668100; x=1773272900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTfN7Kdw2uDWmWP2MPCQ81Cs0QrBTRruM2tmDixgOLA=;
        b=GAh8O95W7fpQcSfRGb43E9LH5ul895AnKq+roLxOPjmReFsSuOAzKbcjV9af4mlnWT
         DaP7hTIQk81zZYnKBqZGxEQx78UyoOIPlW077IWwydNJEJFRGyFFzwsk/R5ADefc5BtC
         ChWQvl3yaPNMpOCRXUum9W+bp4TfOKF6fCipCtQhjU0BLoo2ccVXPs+iHbNsmyicAydj
         AXx8o0sRWWBG4oXUdoRajcKQ5q+dajjO6yjpI0QMk84nYdIJSzRztSbKTgOOwYi8hUKQ
         GmDv6rv6Tf/kxPNd9C8B4MZPOrV6m3MhXNj+0eVCsJkfUnyBz2yywnPNcnpYT1I+djmN
         X8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668100; x=1773272900;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OTfN7Kdw2uDWmWP2MPCQ81Cs0QrBTRruM2tmDixgOLA=;
        b=XRCqRVDKTA63ms1lmRJnjQgvdc0SnHP2ChfJPBp1jx5ZUBGwlDuJtqi2Bj47J6ueXy
         zbC8reFAuOdw/VHlj08hvXR4fXF7FjwJNIhZL/NNPaEfug1ciobMdsHKR5BfGHrCA7UL
         HkXApIdvFQfn1pTB2kLbKedW255EZ8mDo4zj6stqZP8iiZCxUo8V+31A1PzA4kH/8vJt
         NwOzmivKdnCXfxHR/3YCckLKeXokPHqoqt1OGVcExzdAzO6YcYkpT7T/cIlp+kMAkU9r
         4h+YYeWK5cHpiwqq59rhehDCmhpHOIvASgxACuyb87s39mXamQ6D0SMS8Pb2Mp3nbtlx
         dpeQ==
X-Gm-Message-State: AOJu0YyOF3+fCZAs+jAgadhxySBNKYbNx5X/qZM3eiPPgSizdhOHDDvP
	6oxhyA9tyjyMOd/A7OOvn88edHd1L7S2UEKryz40OaLLsxFEU7AhimxJ
X-Gm-Gg: ATEYQzydt36dpkTQhokq6VTRaX5bs99FX5L8hH+JM968rzG/ufuleISIJNKrsWyLI/6
	mkjZr+7n0iZ8rxyhbpzafwpQonYWPiU5n1qRu4jKF+v51cdtqlYBiz8AFjmm+AeGf6iEEPdnFkU
	8Uj3ThJjzBLYCMEdLh9NJBiT/nqYNdUnNMcR7WAq8JSsm0G/qrAdlS3BKGiPlp0hcpsQRE1cvVv
	BCEb0tGSZytIZO9b2mx52Plaj4tsv/IXVi27ZOD8/tcn0llg6WQw3Ou/O/hxUgsFU9DIYPbFC8P
	FyUNky/hQqX7EkyNHEUptiildtrQOJJbtEzut04bz08Eaexa4uiXPDMuPwq4FBHhmCIeq/zitOq
	dvlE3OPRzflB9ZVp2VY5B1V/sD89h1eW083tIoTCnmTSj4YuspKDgY1ojX/U4C9NtcyTFe+ht5V
	BA1xQYIy83cMcdFMyrMh9ZlD0HAA05xTVNYevx128yf8BjEm4Limlt4qlW3iCEhRB8KRwvfRI=
X-Received: by 2002:a05:690e:444c:b0:649:be95:aada with SMTP id 956f58d0204a3-64cf9bd901bmr2375679d50.69.1772668100579;
        Wed, 04 Mar 2026 15:48:20 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64cb75a1157sm8670552d50.6.2026.03.04.15.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:48:20 -0800 (PST)
Date: Wed, 04 Mar 2026 18:48:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>
Message-ID: <willemdebruijn.kernel.1f5b6b3e8c22d@gmail.com>
In-Reply-To: <20260304161255.VV_7vPBw@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <20260204-hsr_ptp-v1-1-b421c69a77da@linutronix.de>
 <willemdebruijn.kernel.2d4b5c08dd442@gmail.com>
 <20260304145821.TQhzhhjF@linutronix.de>
 <willemdebruijn.kernel.1d699189fce58@gmail.com>
 <20260304161255.VV_7vPBw@linutronix.de>
Subject: Re: [PATCH RFC net-next 1/2] hsr: Allow to send a specific port and
 with HSR header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 77ABB209201
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264093-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Sebastian Andrzej Siewior wrote:
> On 2026-03-04 10:56:16 [-0500], Willem de Bruijn wrote:
> > Sebastian Andrzej Siewior wrote:
> > > Would it be okay if I occupy three bits in sk_buff which look unused?
> > 
> > Have you looked into using skb_extensions?
> 
> Yes. I would have allocate memory via __skb_ext_alloc() and attach it to
> the skb via __skb_ext_set(). That would on receive and while sending
> (via af_packet).
> Looking at the current allocations as of skb_ext_type_len, they all need
> a bit of memory, the smallest is mctp_flow with just a pointer the other
> are a fair amount larger. For the three bits, I was hoping to avoid it.

But this is not a performance sensitive path, right? Nor is it very
complicated to add?

I understand your preference. It's just that if every protocol and
feature, let alone their cross-product, adds a few bits to struct
sk_buff, it grows to become unmangeable. A classic tragedy of the
commons. For this reason pushback is common.

Devil's advocate, an alternative would be to add a few bits, then
maybe union them so that other users can use the same bits as long
as their code does not overlaps. This quickly becomes hard to analyze
for correctness. In a sense skb extensions resolved some of this.

That said, happy to hear other opinions or implementation concerns
that I may have underappreciated, e.g., it may not address the HSR
specific needs for AF_PACKET.



