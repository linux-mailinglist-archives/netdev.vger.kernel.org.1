Return-Path: <netdev+bounces-304065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yB/YEKIyRmp0LgsAu9opvQ
	(envelope-from <netdev+bounces-304065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:42:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D316F5687
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:42:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=V6vgeYNK;
	dkim=pass header.d=redhat.com header.s=google header.b=bDmuncsp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304065-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304065-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E487430293F8
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790D342E8ED;
	Thu,  2 Jul 2026 09:31:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36242B32B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:31:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984678; cv=none; b=emwU+EAPksCd27xmjpfprkitWYLKVFKJaIr3FY7XJYJitPy3u5uGF2u2sdAQ/QKu6lomcl4Wl2AjNsRqw4mrVgiar44ChDSHf89/wdwxYxSDB6oz7/XDliZ8nr3MPacpztopv81tahK7xmbFXXblYTvesB+r054rvd2kGxyWWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984678; c=relaxed/simple;
	bh=uvmHYdFDEg29rC8jzNaYq/WmhxrWzqXPqb3CVRqaLjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhPVJGamVntCaQ99n7LKsxfg7S8tqEiWdaqy5Z315KWTFs3AMxwi1OiHWYDghEvVW5OPvbzPvs/BDXfesIVz305uH8UwKmh2moEE41xfmK5KQmnK4H5fIIUYw/JZDL5ZeoNMHn9mGMoVIkXoAKfhIexvQrC9OXqBddqlE0LI/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6vgeYNK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDmuncsp; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782984676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/nDx7pjrcz/KW26AbScVGQ0CT7iiEDCd7GJ1vuSzgM=;
	b=V6vgeYNKZJ6324Bj/4O4AZR/hOxBiz+JNd1gANoiB1WTC5gt1dkDMc045vQPatC9p0QtXp
	gdhQAJbW5tPvmoIAVCt2YJvpgSwOXlZjA6tUmwlgb6UELUHZsRxn0q5H0QjRql9qj8Usi0
	7uCVXF9kxRanr6ZfL/K7aMDujmZz/sc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-OaZ-ixDFMzewD6iP4PtrQg-1; Thu, 02 Jul 2026 05:31:14 -0400
X-MC-Unique: OaZ-ixDFMzewD6iP4PtrQg-1
X-Mimecast-MFC-AGG-ID: OaZ-ixDFMzewD6iP4PtrQg_1782984674
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47780faf8cfso823925f8f.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 02:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782984674; x=1783589474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/nDx7pjrcz/KW26AbScVGQ0CT7iiEDCd7GJ1vuSzgM=;
        b=bDmuncspSEl4Z7bor9DhT112yezvhZOLfuz1dTlyH+eY6AEXMeanems3oFw1ZX1VXJ
         Pt0v4BosesqDDIsBAt8q7XTHzMmUpip83D0uytuvPpCqpOyASYT+ae6klroaB7/qR9YQ
         LzE+6WM2N1vXgM2TgKmxWAtoezkejSBnjsXfFIQsetxT31Fv2mdB+c4yDGmhjRi9G/cW
         afmZzkSAvJWAH32rUoNO7IKOcvWbBxNnpHrA0HCcIRSd3snu8FTwK9qYZ9pTiqeDVkIL
         /a70rbozBEYR0CerbWsTchbtNNeQSiSR7X/1MrTr5+nsWq+1UO6NgaspvLrUKZsIAbSz
         0Nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782984674; x=1783589474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/nDx7pjrcz/KW26AbScVGQ0CT7iiEDCd7GJ1vuSzgM=;
        b=nHelq89XHGCIwqJ6ebQCa6THZC74SEIdJlKeK55KFPlkxHEjSJ/CMF/oTPEDFrHzMC
         /dIswkIJqlNaCmUNl7V+HTlqMzTbvh/TX9s2WJQRIS1jQO4BSlLLdVHroW25WQ8LRVjJ
         vIGWpQ9EefuS+VK6FL/07AJYkEEIbnbp8J2MBe8AAMS0vFuKRqEtBJQaHSzk4SUOvrxF
         Bq0afg6zZ1LAt6m/e2Ex4oTA7L6QHORlfyBCRS4/GMv2ejFFlsIe6GJx6OlwQ+mNtz4K
         zcKRFAm5hlYq7YncF7vZJtj61VkutUKf2u4HKq68eXpz+8oEt4PMgpFO2l1SaVnR6zAI
         mVEQ==
X-Gm-Message-State: AOJu0Yy6kzldUHUwGzRvePrUVQJ55O4FObHj4X78bCBWw4zBfq0Xb+ef
	6GVUiihx/Pt4C8Qyype9h6zvTNe2FhxR5S5635+1Dam5Ox4Xf6dFuU/PFq+EdLjJKNmK/y4x6kT
	7Yv4pzxJzuqzK/H8RMOScco/1P/Pb9oj8scPSx7szacP0s30flR172/2LXg==
X-Gm-Gg: AfdE7clVBc3QZBM0PcHwF4uqKtuTDp6MkCL1mtjRZk7UNyRTkQoViRE1GcROt2ikGx0
	FnzoR+jZI4dYQ99G9wq+KFkMOwTGA1eiVVbGoV4/gWBJIv+lfbATf3g069oIcE0lbFNILYu4x0q
	xwleCDy0Wwe+26obIj52/5ZZXbPE1YpvLYzmWbKcMFof2/QWy1ZLv7akbUTKlzTgruvwtNSQCGE
	BJRb3cUDXMGZBkmHInBc6oEG+Ob6cOyyyb6YYknwBFUKvEO/4ed1QN0AsDx5Lz1UjqcJVEfcjBa
	kkgZzZlGjnag7Vc4+lovlID12TW/LE4sNn8oO2bT/oGLDmxl7Xxeo33bJPkuTbZRsphu6rymaLZ
	qdyF+TWhUVQwzp/KY2PeCORmtM447plqQgCeo2RDoZthwO2J/NQU8pQ2VgfW7m0Lg/PtabVah4c
	4IzhuRiF4Txg==
X-Received: by 2002:a05:6000:29d7:b0:475:c946:36c5 with SMTP id ffacd0b85a97d-47757e5789dmr6188423f8f.9.1782984673788;
        Thu, 02 Jul 2026 02:31:13 -0700 (PDT)
X-Received: by 2002:a05:6000:29d7:b0:475:c946:36c5 with SMTP id ffacd0b85a97d-47757e5789dmr6188373f8f.9.1782984673253;
        Thu, 02 Jul 2026 02:31:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94c9b5sm7497697f8f.20.2026.07.02.02.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 02:31:10 -0700 (PDT)
Message-ID: <f76a238f-baee-477a-ae7c-42a412b38533@redhat.com>
Date: Thu, 2 Jul 2026 11:31:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] net: dsa: realtek: rtl8366rb: Use DSA
 port iterators
To: Linus Walleij <linusw@kernel.org>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
References: <20260630-rtl8366rb-improvements-v2-0-05eb9d6a37f5@kernel.org>
 <20260630-rtl8366rb-improvements-v2-3-05eb9d6a37f5@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630-rtl8366rb-improvements-v2-3-05eb9d6a37f5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304065-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:luizluca@gmail.com,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,bang-olufsen.dk,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93D316F5687

On 6/30/26 1:19 PM, Linus Walleij wrote:
> @@ -895,17 +898,47 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
>  	if (ret)
>  		return ret;
>  
> -	/* Isolate all user ports so they can only send packets to itself and the CPU port */
> -	for (i = 0; i < RTL8366RB_PORT_NUM_CPU; i++) {
> -		ret = rtl8366rb_port_set_isolation(priv, i, BIT(RTL8366RB_PORT_NUM_CPU));
> +	/* Start with all ports blocked, including unused ports */
> +	dsa_switch_for_each_port(dp, ds) {
> +		/* Start with all ports completely isolated */
> +		ret = rtl8366rb_port_set_isolation(priv, dp->index, 0);

Sashiko (sigh!) noted that the above actually disables isolation entirely.

Since I guess/think/hope there will be at least a CPU port and an user
port per DSA, and later loops will finalize the setup correctly in such
a case, I think this is better handled as a follow-up.

/P


