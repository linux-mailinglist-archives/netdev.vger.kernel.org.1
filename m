Return-Path: <netdev+bounces-260443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLsONaZ6nWmAQAQAu9opvQ
	(envelope-from <netdev+bounces-260443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:17:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 424FC185343
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F6E23002768
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B4376BC8;
	Tue, 24 Feb 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7x50uWa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A706376496
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928004; cv=pass; b=bp1meC/e3BOyVQYikHw7RMwHAKyBVFTpTTpqvfw0Gj0Vs0lAXSsnIHukH6X5qhlajWM+CCmciPKALjuGskU2fYpDf5Bx1qAIJT/o9SEcAM8VCRInzlNQdcjaVKBL1RGy8kzqgiSQMrrWvRAQ0t6Fu4TDwcWHbInpEMM5FNVtNz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928004; c=relaxed/simple;
	bh=d0mfGlNjIQR/pptqP2vIVW80q542uQSSoqMLUbno824=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6Mptz0ET7vpm1aY0ZvcTJ9GJutjWIpK2qrAGKYRZ5gBTrGVbhXWbDZOpnQPD5q8er2BeyIIWJMm8tjFR+H+HfY1HCIhMsf6at776jGVLU1ZZlNaV/KA6IYD5Ziyb5olsmrUng0TabwH2QIGW8Cx1WCquw0yKprlZrEhIaWuXW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7x50uWa; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2adae92249eso2308705ad.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:13:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771928003; cv=none;
        d=google.com; s=arc-20240605;
        b=Dr+rtIFh4ldvxNLYGHAAgBmBvdF9bmZLviNGaJZPN9uh0gP1NMAV6azLJKXPb/DsYW
         oQZ0E0Co3OO9s8aS3bTrVMDFHM/uT+nRGdW/fud/ttkoEJPNyItgx3mhSQ2pD+Ju84GL
         26B68/Km1REputvR2kr/QQ0j2pXQoj2w1jzvvGztG69IuNh0MU70fcXcjL5++9JMIIr7
         +2RdBhvVL3Gn6ule85GOswflv3/7l81zIsZ8aOhxG90fbmMAsSMKlDp95sjjOFADm7rT
         6qCiUtV7ywFrEWXQdPdSuD0EtRIgSGu21/PPE076vidwYoWAPFCxIijLX87Yr9bHNc8O
         TtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d0mfGlNjIQR/pptqP2vIVW80q542uQSSoqMLUbno824=;
        fh=UvGkBQFEZNkktOK68E6auk1/cjSsnb6TMze8T6dMQD4=;
        b=kNUywVXZ74+VnasrGmgwp7rDnlGq4+5Uk+lF4JhPgPKV5wEUEMAnTfyj5GAVC64Bhs
         MQXejR5BklpXr14wOTa1aWsML0J8D7WET/811oiG4nrNz488E6z2aqYnret+7eb+4IaN
         vA3O5CGng52umO9zpDQ9qVUAr6OOAgjdhKg5oY2ktvhXr7LejmdqDZaK7Ijg356l1AOd
         byyuhImBpAj/NY5iqLvfEyK9fuKalgK357E8U0hTk4PFh3IeViMdZlbArSFK/6kTBp+d
         REswTa4NYgspIUVr/CjHRm5TT5PJFIyJhloLbxowKCin4c8fN3NqaMT887n6zZSNucaQ
         lllg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771928003; x=1772532803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d0mfGlNjIQR/pptqP2vIVW80q542uQSSoqMLUbno824=;
        b=E7x50uWauMKW9ep6osiiSWj4vSTFotxHJ4RREtyuCAmfy8ifJLwf0F04+6XNNP9lJW
         o+MNKd8lBiP7d0FAnIJlQoVCWTkv8C5BoPVKXMifeark+wUJqKl8QQEAjaf2bokN9N7t
         ty20AqFtfC44wR+tx7PoNXHV9b6xFr073LtInehJlMdulAH4YPqKaxBkAMPhX60YUaRL
         mclIpKPsSZgF4b8wqluxKiIpsnmXwSeTwb8ZrZ6GWWEpXTMX0etz0cb3tjt681PHgweC
         TYYWuYXL5u78Cfj22UIpZQ+ujc/uupkHIs9dUb8cutAYnL/spR1MufsvnkCBR6C0qUfc
         vjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771928003; x=1772532803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0mfGlNjIQR/pptqP2vIVW80q542uQSSoqMLUbno824=;
        b=nfJJw0myoCEmsFvJPbDU1aKxRYBW/JF5ImzGExUpT94GR5YGtS38VBFqwqBhj/B4ux
         rKlzzQHhpwRhXk0UN/1eZsc/iKqxP5G6SMRGJApquDjwHVTio7Wpu3meaEAfk8u16OYL
         FYEZDqqnOIh3RekTxId94WfKo6TbebAKefjOnsk39JTwPLG3UAPQNj57etd6iZahzVKE
         XRg6JxpxwpTTMdxW4EE7C6R8h2O8c5rUKUt1TRaK/R8ohO3KjdwwuBLuUE/65vUKfF9+
         /+wC9meUAIXU3qq9ozOB8V5Kym/gvecGLXE2k0aLo/4TrMFdN9ugBZ78OCKQo7Mkbqmx
         vN/g==
X-Forwarded-Encrypted: i=1; AJvYcCWL8p0GSkf8HPtl0qDA60PcoGMtgRkNBJWqDKTCTpwRSSYf/r8AYlZqA0JAc4EdxrMgUXpM/3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtqC/n+oiqp9Rc7+AzsHzr924Fu6qFQD2LigkM+QYfT8EPptw
	U0O5d9KFRyf0V+ZU02fPAGsnXfIebGfBALqXUmLzqQQSnSNC2hRFVVa4Tqw9dr2JCafpQu2z2sU
	WfnTLt9uX6iYLPIUWQTge2PddkjmFxis=
X-Gm-Gg: ATEYQzyi5CXn0YXzkTN8IysHhGhHC9FnlrUL2MxEceEW88r8mMbXhKqegFGeCCaOuzo
	+T2ukVCnjYIAFvzUqJFVkjYeQMGD8UdSWkuZla4UHP1FGBRDEK5AD3ydIadgDeWEwrxrGh6bhdj
	AVgvwt2ZkjbcmINORSIsGVUoCdEKoWzoqXenAhRhUggoo6V2di8aCbSn8naosGFEh37CY2R7o6x
	AfyHu2y0nDPEx3avRoPHEggCNh+MAyfP/cDjHINXuhgMiLlgORWIMIKVCo0ua+cVjyhRDLuj2d1
	Bmlm+YaK6Picz1bgXYp+Yj/tO4CycSb6PFb4i++X
X-Received: by 2002:a17:903:3b8f:b0:2aa:f2f3:bca1 with SMTP id
 d9443c01a7336-2ad743e304emr110809035ad.9.1771928002758; Tue, 24 Feb 2026
 02:13:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-dpll-v1-1-d99f18c12bae@gmail.com> <d0a3a425-689a-4d97-8940-05bf83b7b513@redhat.com>
In-Reply-To: <d0a3a425-689a-4d97-8940-05bf83b7b513@redhat.com>
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 24 Feb 2026 18:13:10 +0800
X-Gm-Features: AaiRm508WQm3Cupvs60IoJb6_RASyGlhrjEHm_IPXkZu4cEk288ag9CMJj_Wnh4
Message-ID: <CAN4SLj3eAw8aXo78AZg6O4p5qFKK8YYdV9RMmd_OcSKvdxsMvg@mail.gmail.com>
Subject: Re: [PATCH] dpll: zl3073x: Remove redundant cleanup in devm_dpll_init()
To: Ivan Vecera <ivecera@redhat.com>
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jakub Kicinski <kuba@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260443-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ustcgu@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 424FC185343
X-Rspamd-Action: no action

> Please use:
>
> return devm_add_action_or_reset(...);
>
> Otherwise, LGTM. With this change:
>
> Reviewed-by: Ivan Vecera <ivecera@redhat.com>
>

Hi Ivan,

Thanks for the review.
I will update it in V2.

Best regards,
Felix

