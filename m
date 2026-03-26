Return-Path: <netdev+bounces-271979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOWmCz4MxWma5wQAu9opvQ
	(envelope-from <netdev+bounces-271979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:36:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A89333828
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66FF2301E5E2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1F23CB2C2;
	Thu, 26 Mar 2026 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSnWP2XV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A953CEB86
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521226; cv=none; b=G3UMprv3/udcaPestlFupQq8xsyfv6YQuyVuv9SgzFof7YA9F3N3SZnkRv3i2M7Cr1mr3MmTlUDDeIsRVVH3B/QFdL5zN68RunpdEEfxfX0QdLRVc7oOOviDelI0+tDBFxOsc1w+z6//gqhMjzxH2VcK6oagkrQHnptaq3XMgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521226; c=relaxed/simple;
	bh=hDHeKh5UP11J7zbSmc57Z+N0VgWcHEj2ig25U8RExRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9soFAkDGY8Q3pA8NpSwwGHLg9qwM1/sTLaRX+0NsPS3J+8IQE3oJgjVbSObVqrcw0F5yBa6BelbvpeGhHWZNLHkwE8Sj+Zze2zgXVtXE3Z9FOZ92Pbs4u4H5oe+gCT5EnlbU3EndmchXK6IAv1KU/ZPur3wryt0Zo+6KYnBffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSnWP2XV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so1203055e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774521220; x=1775126020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CDjZjGo2EazkWqzZ3eP7AIgqn/KEE6+hcLYoJnpSpE=;
        b=fSnWP2XV3m2NZIxBNRoYxbF63SCkjsgdLPvXdRAl67oXAUL3YvgdZxo/GsnaOSuYhg
         JKYjyml7qlAd4UT00M7awHsX7LsxsaKUIpkRVe82rxQP0SAhOQP/Gh02KOl0Jbujah5m
         HAMiEauwOeMB2NIidG2U/T6xjdKQiIadVaozwYxZYzDSExDaHUHZojKxl6TVS/C7RERg
         ozWFpoqSgdWfFFI3eBm2AtYdosDhOZmhyhlJuJeOZFDJWJh6U74mJOThrzZo3TpNXzk0
         1RVxbtne8ZuEl3EAPq0JztOFFCyeWHmP2aBkEb9eJVVHcFLuG3U1cetUgcqxC8yU/hPP
         HxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774521220; x=1775126020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CDjZjGo2EazkWqzZ3eP7AIgqn/KEE6+hcLYoJnpSpE=;
        b=qilq6UUaLhqEFLELudh28rZnW3eLO7lhqOjNf/QWomyOKCnbSw0foJJTFLTN+Qn2Iw
         86pm2YIvyZff4H0Hpan8kWx4sRrG1LB4iFkLKGl+O0EJeqQYFa0Sqwc2IEijxtip92kY
         SN6MIWr8LNpxOE6UL6KUeRt+Cw/Olz/7SsWHiIJbDXyQjXJ3FcPUXmngQuRWq/H7sPTx
         ssWUvBuevTh2aZQ/pMEX3YHzFL2ysp47CoZiPPL532d3LdcoUo/cmqNiYgZwjVFXENBT
         LvHJuvKRLAHJdMd3b1+gF3cGL9lQXxbZ4dZa+gzIfaHvlmwAZpv2F1K/Tb/qtc+ae8Tv
         BhBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ydzYNdqYImdk+vHEhfhYJ6vYW6ydJauj56JlTRz9S+AssAkKEAZyRpofAv8wdY31NMGhKgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77TCTNfx4FjYQcb1lw+B7DTmlNrRijofleRGCPEs5VmszlNbl
	JojGXMLQTtoh+GlG+oB5GgBTc7xLupMbOncK7bLLSkvo+Qis889oPTb0
X-Gm-Gg: ATEYQzwrjBxH4a0OpDFJmhh3PS6lZiz/vtagR4p+Z+ibfZOdesjHTVrzi0PixGvUyP+
	xsZMDYkp/O8UgaJ00isnr0sRWejgz4XSidi3fdGnEvC+NXck3MdvrFXmuRGNIqCGY7kuA3KMs0a
	ogy+TD2ItyOoATNFoGKXViNWZiK7STcOR0qBf+rSRpH9ZFcHYEUznt93vbdopS2v+w9avqDQLGR
	zyqk06uGbRsdXjzOGnUgsbl/vDLtbiVze3cMeqtzxQL9W/umyf62161rhHITeOM1iVFq0vNluTM
	RCLvKR/Sl0XB1iYH+njIA+wiWC208atCMtcZtQhj/4Te7evj7anCNYpmHif2pZTOd7RmAB6mY4j
	7oDX0B+M/jKZKH7XHxtgX1fmQZCwAFQXCWZyZx0qsUVVFi+C3KpqtH9t+ZyXnSgoESquNYiqaR+
	cyZKm+DHja20Oenjw=
X-Received: by 2002:a05:600c:3106:b0:483:79af:ca1e with SMTP id 5b1f17b1804b1-4871609d11fmr65788035e9.5.1774521220496;
        Thu, 26 Mar 2026 03:33:40 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:cf79:b8bb:14ce:d80f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c65dc4sm23017975e9.3.2026.03.26.03.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 03:33:39 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:33:37 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v4 0/4] net: dsa: ks8995: Post-move fixes
Message-ID: <20260326103337.wl2zzbmbikg2wvnl@skbuf>
References: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271979-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8A89333828
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:57:31AM +0100, Linus Walleij wrote:
> Changes in v4:
> - Drop the final "port isolation" (should be better named "port separation")
>   patch, due to lack of time to revise the patch. Let's keep this one
>   for later.
> - Hope we can merge this first round of fixups so the driver is in some
>   reasonable state.
> - Link to v3: https://lore.kernel.org/r/20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org

Hmm, ok...

Andrew, do we have some sort of policy regarding how should DSA_TAG_PROTO_NONE
drivers behave in terms of forwarding? Currently even with this series applied,
this driver doesn't respect the forwarding domains configured using bridges,
even though it marks them as offloaded. But the non-offloading path doesn't
work either, because there is no tagging protocol implemented for software
processing. Not sure at which point we should consider the driver quality
'good enough' for the current release vs the next one.

