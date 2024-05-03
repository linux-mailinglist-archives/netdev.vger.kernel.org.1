Return-Path: <netdev+bounces-93219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B28BAA96
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE001F21A6C
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84AC14F9FA;
	Fri,  3 May 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNlX9Hcl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234CE14F9EC
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731511; cv=none; b=ESutDQAZ/8DFilS5QHyQHJIKVQEh9RVEG0deEQuADk52HXd6IvIXSKTdim4G0uqsQCdWtKbHfgZwlxi9kWQvrMtqhJ/TF/UKOOljke3t8Y04j96XlDtT684uijctx5rjm7HWwRDhg2PbMeI0CdByrPINZjAqicFEB09+1bGGfnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731511; c=relaxed/simple;
	bh=hZsgorkXexD82VLI4x5O41FP6H3sgMjC8JwAsaeaSY8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=m4SNjuJ06vIfuLAxJShxPrLgAAKlffcCzPuXjrTzSRHLdAZdH5JvtSnwWtRzRXbDhla63BwzWzo5AEop/64U4snUMIz4BBcLZQWALnLg+2y+lMu0EeWmaaks+oy7gWRISV616XiQHDihUSkcRjoXmIrRiaWKs0GeZkf1l4JEAEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNlX9Hcl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b869326daso51169175e9.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714731508; x=1715336308; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hZsgorkXexD82VLI4x5O41FP6H3sgMjC8JwAsaeaSY8=;
        b=FNlX9HclO13i2IrNTU9VNGT+d2nycPhNUBM+tIS+2WN8vGGAkQqXePyMuq1JJrDgeX
         fAJvKMSnG7AT6/0P26TS0RBJXDLJozNGi+cKOSiWWQSlK5gmB181H/xiOIRo/nx+I4V5
         LqWFrHsOGXxiBmlrOQKVV/r2uXKMfJKEnozUVipLPSPeDHWeZL1QxtmtfjIiT1qGV8Z+
         Kp0Wn4uvhlJXnqKPecoJlZiod3LrvmU9cmC3jDgwqJ16dWeTyM84155vptPSuCiLUQYM
         vWA5ArXlpdEi1QE94iyNe7AkKaGyEWeWcffSfwmEGQf9k6psdKF3IJSXEpODpJE+ESVD
         Kclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714731508; x=1715336308;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZsgorkXexD82VLI4x5O41FP6H3sgMjC8JwAsaeaSY8=;
        b=JXLlpKmPoukip/iFUTgcyYjVnkGqRL+rXaR+9p5hYYd00nqtv+yYPjR/3gfNCuMFN8
         6Jdb1HSJmMmBzDN73UlkomZ56S7gokYXOLDe+Pa55lae1O+6i6lh5WfJFTL7MEQGh6bZ
         sGUrNtsYPGTZq0QHxbIDd+ajJf6UhqkI4dLNndDYqIt8/YPkVP5bfqhCm1IqDMkKRE6D
         OJ+rNponHcJgaCxTjc2RWa0eOBCBsNY/tdV5ugyBlk8xaDlVK5G9OabgqCjHsz97LepU
         xEGCeKIJwYcMitmTSHWInivBZLHk/D0XtHHQ7dVlM1igllWqcR6JtTiOj/CWP0ZazVRv
         BZOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz12KfS8qOMANUIui/1M3i1YJXHo84Jn4X/XiJ9DPdpDi87C12b9IBoIxcD+feMVZEP9A3YXmMIRA1PvftNXfNAupxQIH6
X-Gm-Message-State: AOJu0YyzQuXgzDK+isTtwd6uTPA7AObgjremn4rgHmF2z6njetR1/0oZ
	d2Kys6c1qaYb6YFojagLXwZzFmJQ1nTPSn9B3IaOc53KrZV0iEOn4wLv0w==
X-Google-Smtp-Source: AGHT+IH4pIr0Qfqz6XGs6qqOoKIbRFPnpAdwdQsG+IEw2R6mMpdzuFx/RrsUCr3nxoQ7Cz6ftgpk2g==
X-Received: by 2002:a05:600c:3587:b0:41b:935:2492 with SMTP id p7-20020a05600c358700b0041b09352492mr2063188wmq.36.1714731507991;
        Fri, 03 May 2024 03:18:27 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:fd6b:a058:1d70:6e1a])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b00418f99170f2sm5121263wmg.32.2024.05.03.03.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:18:27 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Roded Zats <rzats@paloaltonetworks.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  orcohen@paloaltonetworks.com,  netdev@vger.kernel.org
Subject: Re: [PATCH net] rtnetlink: Correct nested IFLA_VF_VLAN_LIST
 attribute validation
In-Reply-To: <20240502155751.75705-1-rzats@paloaltonetworks.com> (Roded Zats's
	message of "Thu, 2 May 2024 18:57:51 +0300")
Date: Fri, 03 May 2024 11:06:27 +0100
Message-ID: <m2jzkbfbvg.fsf@gmail.com>
References: <20240502064226.633cd9de@kernel.org>
	<20240502155751.75705-1-rzats@paloaltonetworks.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roded Zats <rzats@paloaltonetworks.com> writes:

> Each attribute inside a nested IFLA_VF_VLAN_LIST is assumed to be a
> struct ifla_vf_vlan_info so the size of such attribute needs to be at least
> of sizeof(struct ifla_vf_vlan_info) which is 14 bytes.
> The current size validation in do_setvfinfo is against NLA_HDRLEN (4 bytes)
> which is less than sizeof(struct ifla_vf_vlan_info) so this validation
> is not enough and a too small attribute might be cast to a
> struct ifla_vf_vlan_info, this might result in an out of bands
> read access when accessing the saved (casted) entry in ivvl.
>
> Fixes: 79aab093a0b5 ("net: Update API for VF vlan protocol 802.1ad support")
> Signed-off-by: Roded Zats <rzats@paloaltonetworks.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>


