Return-Path: <netdev+bounces-263858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHTIILlQqGnUtAAAu9opvQ
	(envelope-from <netdev+bounces-263858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:33:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C851202C77
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FF283004438
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6190B331A43;
	Wed,  4 Mar 2026 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jha4+EjQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B5331F983
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637714; cv=none; b=dMjAPXx8acEangxFfuH6qb43Dt/YKHArmC0M8yjzOBhPPp1jecuKU3f//p9taHP/igrtemeebcE4CWUyIzsOfxtAetylRKjx0pj+LMDSiy6ndjfYzYQOgKMIQj/5DSJL/P/AJCXxbhm72wV9SuAq5X6oEk9Dfyy0fcYDdOZeC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637714; c=relaxed/simple;
	bh=X+MrOn8A3alDK6hokfy5pbgtE/0qQg0SeeRk65wPZrw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YNQEUY/QKS1IwnzDdOUYj48JtzS5wXQtg7hWTAeegbCpvgrJ1VaHjUMsghGo+7F4FtkvLf4s4ND+3uuDVJQ6lu2ms8mK/mK1dDHnaHI+WP6Xz6PD3qMEN+TiaM0M866edumofdWiOq1SLmUZbWYxYXgqbZ4Br1TK021/wDFXb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jha4+EjQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78fc4425b6bso68484137b3.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 07:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772637712; x=1773242512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv/wdgzsTRsWDy11eN8RXuT/n3lWh4LTwHzB4w5y18Y=;
        b=Jha4+EjQRRAdqAk0fENlsbOyi9PdX7SSOal1DZS49i4zah4cY0+UzoO0ero8rbG+71
         ZZ8hj1M7Dp0Cxbcy908cLFBqvAoFaQRrcCWrUw0MLKCC4S2ZZJt65rf+vZizmWODTO7+
         sF+oT6kcmG/t2Z2nwzkx8lwx/SjulyOUJVJD6XM52P4hovnFqn6rV8DMA1hk5nZfPEuZ
         eK3Fl/ceMK5QsDRIJJx0n5Ua3tthOHEYjhD43hmNnnDj7YtEDaVi3i8HWmhJbPYkq+Id
         i7Kpgh9BQjcdlRjmZdV+phW0kF7vawGq1XwFKaU81qtk5rH6pmI/GV/bFW3LHN7RQSki
         uBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772637712; x=1773242512;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tv/wdgzsTRsWDy11eN8RXuT/n3lWh4LTwHzB4w5y18Y=;
        b=SoBdk3cbIcTA6AdeYsL93PBlPtUs4+SGl3U9dO/A+N7W1yQIwLHrP6T3WSMWQTMvyo
         wnRX76AuMvptintMBB3MghE7laQEefNczgM+hoSbHQVn148x83FOJCFfWLuHY7AocRkJ
         HS6E/JUaF0Igqmuk1q7URBtl+lDNMbGZUla3hTguwp1z/0wkvLn62UrIigjVIIRYr/M3
         aMaAMpl3Qlt1eZc+v6sgpLRs4Vvwh+4hFC33kgolMwSyBMkxtbqQA6qtgzSrpU6v5Dw7
         qtWoORlsutgcx7CCNfpewtfQ2K/2j/3XcasTDQXexmErfJoZxSDecRO1Gs3l+yuFejFg
         3aBw==
X-Forwarded-Encrypted: i=1; AJvYcCUEcIQr2jZ0kkjh89MdkAlqLQnxnSjjHonhQoyuGOJIyVLr9L333/sX42WeFw1ailXlRJykl6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxElM6+u1+ROUMcFPUOzZlYpZ2spEnIj1BcgwVn7dELh/jXXVp0
	55bkQ8eNb4qewXHQPkvz2rfU5NbP4Uq71CQ0/EdRB33xo3Geizwlcdlz
X-Gm-Gg: ATEYQzyGdRHZZ8ZPu9TKq15gzOWAm1JUn5pGbyjJ975SAoS+vMooCOWYTsveOu1bDj2
	/L8si/EheIpss2nxdkM3TdWsDwULNNa3iMskz0x1+LMlTtTQoKt7ePAV6PLPdeYwtDN1fn+3rDH
	FYmoPYoGkW3s1M4Q83ONl2Rr7wMM9F5G576aiuTR5gyWVCuYJJstQCm2EOxrtLClyKOwc/mvSkW
	F+/h6XxT7bF4bxTkomuguMAfyUWWpkW4gHj1l+sLYc/tjmEG3dzRgG54rUrs+cdrGABu0/xcD7m
	SEm2SGYA6Bnm5ZM2p0OPgnx1CT7ltpeH3OdZ82sLbXMbBSr8qwKYrgT5WpZZWziE9lkwJbmT45b
	EdNPggmBG/cFfspZPNBw1kW0EOxYDNpYUSrxaWncZC17X1suxSvVwTsy912Vg83nuOLJ7BVOKe3
	rSMDh/Gy14xLbIj0XBEiTY2p1ZXx20T18rGbWXgZM2jALffoKTkpQDLO4lcJJpQgLNNRWb7jI=
X-Received: by 2002:a05:690c:ed5:b0:798:3a5:5a76 with SMTP id 00721157ae682-798c6bd6922mr20350917b3.17.1772637712097;
        Wed, 04 Mar 2026 07:21:52 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79876c87140sm74888377b3.47.2026.03.04.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:21:51 -0800 (PST)
Date: Wed, 04 Mar 2026 10:21:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Maciek Machnikowski <maciek@machnikowski.net>, 
 netdev@vger.kernel.org
Cc: kuba@kernel.org, 
 maciek@machnikowski.net, 
 richardcochran@gmail.com, 
 milena.olech@intel.com, 
 willemdebruijn.kernel@gmail.com, 
 andrew@lunn.ch, 
 vadim.fedorenko@linux.dev, 
 horms@kernel.org
Message-ID: <willemdebruijn.kernel.d98bf752c969@gmail.com>
In-Reply-To: <20260225153858.29486-4-maciek@machnikowski.net>
References: <20260225153858.29486-1-maciek@machnikowski.net>
 <20260225153858.29486-4-maciek@machnikowski.net>
Subject: Re: [PATCH v3 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3C851202C77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	TAGGED_FROM(0.00)[bounces-263858-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[machnikowski.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ktap_helpers.sh:url]
X-Rspamd-Action: no action

Maciek Machnikowski wrote:
> Add PTP synchronization test using ptp4l and netdevsim.
> 
> The test creates two netdevsim adapters, links them together
> and runs the ptp4l leader and ptp4l follower on two ends
> of the netdevsim link and waits for the follower to report the
> synchronized state (s2) in its output log.
> 
> This implementation runs the test runs over IPv4 link.
> 
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>

> +if [ ! -x "$(command -v ptp4l)" ]; then
> +	echo "ptp4l command not found. Skipping PTP sync test"
> +	exit 4

Prefer to include ktap_helpers.sh and use named exit code KSFT_SKIP

