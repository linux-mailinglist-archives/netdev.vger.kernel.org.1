Return-Path: <netdev+bounces-263188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOrcDrfWpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:40:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9314B1EF96E
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6B7E30DE198
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FAD33F5A7;
	Tue,  3 Mar 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JswCGXIA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196333F595
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540905; cv=none; b=UOEJ9c2j3nTdzJdNGyA8Z33TUmb/pt+ulerFDOPqsNrSIFkYZ+yJRl/0Fiw/xCLiptkwTqUn93jik0dGrQStcsb3TMzc+yi7TSMsok1jts4LcW4vl1wWHXWQna1jjza2wnBT5rE3rfF0dMRI1tiwa1LOE8jTmtQLAxSHR4iIfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540905; c=relaxed/simple;
	bh=kBBdX6mJ7Qn/upAsEMLjY/CJQO8dS9V1ueDqkwwlumI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R73xIuWhdYal8EuOt38aLtiG3G1r4uWbfMY9HmRA1CcGZdNGnbEerRSxA9mLkNqOIqfFHw2B6iyjJgz/eq+eave1sIG0m+pnp2qly8gkVt7PPltnjWoRF2nUfM2qf9ccsYZuzC153uUAxt4wMBRD5MULVHi8DeoNac+gfp4S/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JswCGXIA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65f92a597a1so7654503a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 04:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772540901; x=1773145701; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDlk2CxhN/+s7UbyKiiidNIbM6SpyinQ7RPlUl1FFQU=;
        b=JswCGXIAdEx8ydgswZpjnkbbrP39x9YwbGqkfhk7H5m9+ffH9ovHtv2B42X5W1Vmfw
         cB76pbcwNdJOJMrUEFu+UcjqHQx/H+p21theUF4qmZ/RzF9JI2XD5f/yjsrHc4zRiAI1
         U1ErB9ic5G44/O/xmFN4Psy8hCWAvyYT36hQJWW7Dl49lGA1W9SglvQJwDf9ec6KxbMw
         Yx1fSQUHDsv4DF3fWt0uDNJ7eFQZKt8+r3YdTyLlMAVLPRNbv3MeI9tUOEVE5drdfhM5
         ZLDCJZ1mYjG/sls2ZNgPdiXgGaW50PCwakCpUJ4ad+QS2OyvXlprqz3rsBvyHHtdTIN/
         GiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772540901; x=1773145701;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDlk2CxhN/+s7UbyKiiidNIbM6SpyinQ7RPlUl1FFQU=;
        b=JBeQWwGMSf0SJatbPMESFZdOukdCt1VXuMEMnUfoz8JbXy9ejlxlVDCYLPMFS9iDrj
         +NK1WY8VOSVAp3Y5m5sR9cVMsjildEj5sNp0L4Om/fYbe5KdR6AcOlj7KFzjwRoXVCAl
         vFrBH95044va/4rSL8xgikLP1M/eGpa4Ps/WXAv+zdUBbAA6u9HS3Vfipg8WizM/VRHr
         fYBvam9h1Gyzn+F5LRbO6GBy2p19tY0wYql13xVP8eurb3C8Ro41bkSX5XSlglqdzmSy
         BdD9Zp0DfOexA3LN96gBHcCxdDiDgTDyobHGu6S9FB9ziT/9zQ0WsFz+Tv6AlWLqnUa6
         U4CA==
X-Forwarded-Encrypted: i=1; AJvYcCXn77h8xjzVZppAx5ilTeyDi/1W4N7Aic+9qYd1qC+Mz54HN6+/FAqWlKOL11Xgt9mW14HJu0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+dv2Na8mnfNuCGkMGe4OpMNR5oSDIaxb/k0tzWv0f990mW2g
	RswC6JXdWIgEiefX6PZ3kD0Mz04EDBdgL6+RUJQ4zan6mTe1eeiBDRU0SASNRaq8RyE=
X-Gm-Gg: ATEYQzzlAiG9ke2Rx/8mtIEs8tgAbUEHxaIgU64eBrWDfMuqJ2Sa490dzCFoYTxHXY3
	h8NVdRrkJ85GK20C7zayJJGb7c7HKkb23ET+HYM9AH6NRVz28oIBGqT2Jvl+9F4pYXrhMQkzKPl
	fHfK0TWeza4oJVw8kqmf/dCqiAS9LYYZsOupcdOmnF1D62zNQXvZRvjoiSzP5yPKJ1NboR3vN08
	aRK6cQPUtmBhhO4gmCiVKT+7FMilogrsoNRidmkvT1aHqpWToCGLb5eH/MMJObgfH4CWzCFRKF4
	8rmdrCbML5g2tlZsVyCYBG0oi9SUi4+56VgQbE+4L1JKnGhRUpAGygBbtJdjc06PbjCL2+O9auK
	YD6wQjtHWnMFx9mhlBLWMqsIZL+tdxE73k7DYZz6HL3FarOi52gBgVfMaMM96fWn3JcdugQrHOs
	aAYLXDd1c6V8PougoP4C0M/OG5ZZs=
X-Received: by 2002:a17:907:9450:b0:b93:6bb6:cb3d with SMTP id a640c23a62f3a-b9376573d38mr1103711666b.58.1772540901273;
        Tue, 03 Mar 2026 04:28:21 -0800 (PST)
Received: from cloudflare.com ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec39fdsm581834166b.54.2026.03.03.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 04:28:20 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,  Neal Cardwell
 <ncardwell@google.com>,  "David S . Miller" <davem@davemloft.net>,  David
 Ahern <dsahern@kernel.org>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Kuniyuki Iwashima <kuniyu@google.com>,  Simon
 Horman <horms@kernel.org>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2] tcp: shrink per-packet memset in
 __tcp_transmit_skb()
In-Reply-To: <20260303100439.3172296-1-kmta1236@gmail.com> (Keita Morisaki's
	message of "Tue, 3 Mar 2026 19:04:39 +0900")
References: <20260303100439.3172296-1-kmta1236@gmail.com>
Date: Tue, 03 Mar 2026 13:28:19 +0100
Message-ID: <87bjh5drmk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 9314B1EF96E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263188-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 07:04 PM +09, Keita Morisaki wrote:
> Use struct_group() to group the three fields in tcp_out_options that are
> read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
> (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
> with a targeted memset of only that group.
>
> struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> CONFIG_MPTCP=y (typical distro config). Every remaining field is either
> assigned before first use by tcp_established_options()/tcp_syn_options(),
> or gated behind its OPTION_* flag in tcp_options_write(). This memset
> runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> bytes to 4 bytes reduces per-packet overhead on the hot path.
>
> Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=y):
>
>   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
>   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
>
> Also add opts->options = 0 at the top of tcp_syn_options(), which
> already used |= without a prior clear. tcp_established_options() already
> clears opts->options at its top.
>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
> ---

Loosely related, noticed while reviewing - tcp_out_options.hash_size
looks unused:

 * MD5 - always 16
 * AO - uses tcp_ao_maclen()

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

