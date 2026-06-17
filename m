Return-Path: <netdev+bounces-300195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4TbsBqy8Mmrg4wUAu9opvQ
	(envelope-from <netdev+bounces-300195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:26:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F869AFB2
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:26:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=B12XWX4n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300195-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300195-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FE8331CCC3D
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2D481FC2;
	Wed, 17 Jun 2026 15:01:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543648A2B9
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 15:01:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708493; cv=none; b=Iq2hpxv2ZL7LN9ElRuZ+WVbTm+3Oac7xnngrh0yU4s49GAVKO/SZFLES6HuYPGG8DuTUujIGeyg5dckDhiUwAlixlMJRJoeASBg+bPkexDouCxGPvmm3GIQKyiSfqFaTfY/rlDnyoj0xF1kyF4IFguqn9qPJlmSjG9c+3Uq2iiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708493; c=relaxed/simple;
	bh=RQp9uEv93kI8iZkpqyY3L6CqlE2G1eFeYluVkOsQb3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDXfGynQvEqs9UMFA9DGyyZEpFx05cW6BWg7BjUbaAiS4lwjv7ARnLdOxgDMzYRtGNTtFQIQ0B9y56nJECzWY0C3QcLAKvjWWiCM12m9F1u61ouZGv7+TsPgdfZ10oPclBhgZN4QnMDmLS4LVBSN66PkcX/mU1blgWsCZFmL0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=B12XWX4n; arc=none smtp.client-ip=74.125.82.47
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-13721dfd471so6660572c88.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781708488; x=1782313288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl2juPMHrGTU7dXENgItGlnDEG1RNcgfN30nZHsFEQM=;
        b=B12XWX4nPkSqmdfD8EPHgV4XeZ5H7ZkPzVPYyQQD8aLr65nPtYboB/p5r3L0q53wWY
         c2bIYv4diU4O8h2TZHPPQnF+qrsQHpY26vfC7os3+wzT3CsvqDfwF5LxCZRMz+uxIyjd
         36ZtIAttimdg5ojsJ+Q3SxIg4F+FmOW9BRiG1T+8XjW0AMVR0a2SxSUpI3XBv+Tip/m5
         sQC328mBRfsO5zTNpl1rPdgjLMYmCafQ07A2cdF5NESLrmumzg6hzPrFIZh/8P8mqOxA
         fLad+tlgKWY7DSi3xiGBW/9Nw7l0wuLvxqw5W8AtRRV5BacPvYj9Hsi5LZUUcmrr2E6m
         cYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708488; x=1782313288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wl2juPMHrGTU7dXENgItGlnDEG1RNcgfN30nZHsFEQM=;
        b=e8IhM77+hwaXKEPKY8GbypL7BBoZHIdtV2ul/4XnsHNWEFL6xWtRih1lDRKhcmQOED
         HenBgFJGusPMOVfBXhrP+N3lUtSvn5H+i6yI78wvGY1306ISmRAjDufiuoRLIYLCYd8u
         O9PugSZCyhSaAU0bcFoqgRs2u1DVwoKLKCCUNHDOpwnNv1K5tZihvhfOETIpxTx7RLBU
         8n8ywP0UcJZ7D0N+Ojky/qlqaMibX2iQojccTxISJJ+2r3VQmZjA3p66FEsRqLs1iaxt
         FfmMrNTvNiAZocKlribhwUjEx3h9ZyxQBmT1Q5GT4mOl6NwFwFoj7tnSVXuqaZSOIoSL
         bkqQ==
X-Gm-Message-State: AOJu0YyZndFSAZeeUgTCpV/RNk7yx6mW0sFEcfXaNKEby8gQzguXpcOo
	cbAdkmCUB8x06Hpinp5J0EygghAI395kkAsZ0IXy6B1jea5ZoPRXiiNUXWVOIX/fXoU=
X-Gm-Gg: AfdE7cl0/beJghYgjEMRbwsuhiSWxuToftJjctqb+BiIO0zGRnQinXewtQrvLLHjjTb
	+dlCbGxcDjUePmCKbOOPJChEoL1YcV9jCgIemJ3joUfAFG+gwwWIiuz+7Lfxu4OFikMIVYmSSMk
	rl6xiwnYs5Da0gzc8GgdaboJSW4Pa9eHTsOMqMKJjJGDV0zvL6AfNWzXs02r/cciO8KaHEq5/6J
	3AQ20JBI0PogLPvGHgbODtIGEicL/n58RJ5XrFxu+ATuL+AKbGOhyc5pihruPaDDO1De0b3CHEn
	/pY0rIhMGLo+Z1rfjbF6AWPfi/hgZSJub+ut0a0Umc9EgF1tN6FGzIoPvVfdkc7uTnI2SPjhSNv
	eCr8f5OTmnOBDxzobU9p95UI741I3tWP09LgDcP0Cy4B4BEiomLJG3AS1/ogd+yB4DVYUMaiU10
	0mJXOqjBPa8euLnV3MwPt/yUp4ORg9XEd6IaIYgtMXh9MJ3Rp88me/Dg==
X-Received: by 2002:a05:7301:1298:b0:306:f474:738c with SMTP id 5a478bee46e88-30bc9f0cc12mr1914330eec.13.1781708487666;
        Wed, 17 Jun 2026 08:01:27 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30be0c45a16sm1529152eec.14.2026.06.17.08.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:01:27 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:01:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, jv@jvosburgh.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, fbl@redhat.com,
 andy@greyhouse.net, shemminger@vyatta.com, maheshb@google.com,
 jonas.gorski@gmail.com, horms@kernel.org
Subject: Re: [PATCH iproute2-next v4] ip/bond: add lacp_strict support
Message-ID: <20260617080123.3afba0aa@phoenix.local>
In-Reply-To: <20260617130314.3893243-1-louis.scalbert@6wind.com>
References: <20260617130314.3893243-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300195-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:louis.scalbert@6wind.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:jv@jvosburgh.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:fbl@redhat.com,m:andy@greyhouse.net,m:shemminger@vyatta.com,m:maheshb@google.com,m:jonas.gorski@gmail.com,m:horms@kernel.org,m:andrew@lunn.ch,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,phoenix.local:mid,6wind.com:email,networkplumber.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 654F869AFB2

On Wed, 17 Jun 2026 15:03:14 +0200
Louis Scalbert <louis.scalbert@6wind.com> wrote:

> +		} else if (matches(*argv, "lacp_strict") == 0) {
> +			NEXT_ARG();
> +			if (get_index(lacp_strict_tbl, *argv) < 0)
> +				invarg("invalid lacp_strict", *argv);
> +
> +			lacp_strict = get_index(lacp_strict_tbl, *argv);
> +			addattr8(n, 1024, IFLA_BOND_LACP_STRICT, lacp_strict);
>  		} else if (matches(*argv, "tlb_dynamic_lb") == 0) {
>  			NEXT_ARG();
>  			if (get_u8(&tlb_dynamic_lb, *argv, 0)) {

Why not use parse_on_off like other code in this file.


> @@ -642,6 +658,15 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
>  			   "all_slaves_active %u ",
>  			   rta_getattr_u8(tb[IFLA_BOND_ALL_SLAVES_ACTIVE]));
>  
> +	if (tb[IFLA_BOND_LACP_STRICT]) {
> +		__u8 lacp_strict = rta_getattr_u8(tb[IFLA_BOND_LACP_STRICT]);
> +		print_string(PRINT_FP,
> +			     "lacp_strict",
> +			     "lacp_strict %s ",
> +			     get_name(lacp_strict_tbl, lacp_strict));
> +		print_bool(PRINT_JSON, "lacp_strict", NULL, lacp_strict);
> +	}
> +

Why not use print_on_off like other options

