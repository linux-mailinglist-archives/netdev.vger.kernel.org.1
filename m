Return-Path: <netdev+bounces-267641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LQ8BzKltGlvrgAAu9opvQ
	(envelope-from <netdev+bounces-267641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:00:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 743B328AC84
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E25530312F8
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634D10785;
	Sat, 14 Mar 2026 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="BPm0St31"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434DD1C68F
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446447; cv=none; b=JWxpL1ngOwAraM+THrUj+C/eAim3wbAVcTw4urSNJ5UOgwyl63xRRssygiFENoLJ19Jtp+ney69i0d8w4ODqtLxGwrTlYj7okljOtHM9/furdPPY25qhbCwtIyE+kXZm2TzlKGqZwAtsrYuQPBE+Kc/unWIgydP7KBdUPwsAVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446447; c=relaxed/simple;
	bh=Jdy8vtd4v2L5ybNRpXFG2S36VaTj65TmQCtQyBKvDY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPhLr61wvycEgvT1JLh1yhRiWq+STgKwXCP+acycWAN18jVW1RSXiuXbAFQxm2l8H2CBwTxf/xy6x2rmthiwRrvuXZfedRKZMtBoRNDoHX6QVmT4V9745w100ttoQ8ZFtK+QiZ1HwH1M7G3sDKpBz5PUOfZ99IYVomQLG4FIKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=BPm0St31; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aecefc7503so8631555ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773446445; x=1774051245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUNX9+er7eAIPoSIjhlN4xy336/lFgZH6wO1ycKkjxc=;
        b=BPm0St317WSF+FDVXPZku8XqNcuapzNMxoqTPqE3OqKcIqMSS6UuC1igk6ubEatQdT
         4Lzl8p63Q5q76TK26DZhZmZxN9KfN9elwCVF1MokzAa24HZA1WsvAX5pqTmq/svWXRXp
         /2lf7e/9qQ+UiXvoEUWWmjJiXTFYoQeYyN1kqH8X7wAj2cAY/2pzbm9NDAiqjAVjvDPO
         Z3v6BXj3oijos0ixwqzvU/jaDrqEVtiKneeSYWUoaEUblebmkWtIbWCqkbMnPuCduZYK
         ljHkfHGzbwCOuk6gt9E/Hrry1v3zAirZ8vEkf9edtvjCzdJyaj3AIe3EKpTrwWlo1R+2
         U2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446445; x=1774051245;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUNX9+er7eAIPoSIjhlN4xy336/lFgZH6wO1ycKkjxc=;
        b=FBsUaLoMgxzRb2fiv4PXAOHncxILe/LdwphOzs4wNQWYDJGLAKhr59aTJUJz4KRdHM
         xcTdeO+qzbho+xl+JdF+so7wFxOciU2ccbn3gMAHUlZiZLPJ2/1VvnOE0yS0uvc1bRDH
         J/N2+DNOpbRlLqk1RGNthg9WTyeRDug9az8+zXzBBJmK8Bx7xZm9eqFZ7oqpHj2s9xlN
         9zov3we0jUsoBM18Na3THvM7ZW3TQYFItJ1pkhwKBKOgbuhoI18MYB/0sE3A3FqgDjdn
         g93LTSyuylRQQ23hr1zeyyROPhrvzLaKbFaNqibRpS2bNIul2NorvzkvkAGP3EUCzxSz
         DfOA==
X-Forwarded-Encrypted: i=1; AJvYcCXpNaa7pJNpqznlV4bfEECrDFLU0QCqdpWVaBWY7Uz/rLCu6P8hcwfQtpg4Mw9xKP9YP62SFj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4XsDx7dBv3a0NVb1qTkTJ5RW6+O3cc6zt+eXVpdZXOTaqpZL
	+sIIXcVADeDQN1zXlsFGxX19GqEUmEUWbtKGr0QKYOZqsJJn4rWpgf4QaC0pTUXE1AcDnQ1xQmH
	l4ycIN8o=
X-Gm-Gg: ATEYQzyktymWLa/cx5oZZNwm519Cneur6WMz731FWvqtoL0gculeskfjcyvHBINGba0
	Jve/6QZ5P+6EUHAHLsPMzdWrD8Qavic57n63j8VlCOIpAQb9ZYdyut0Okp4tGAdRggjwjCETXkY
	HdU7uPKWGbm11iE94nDkb6IM92OqRlRpipYIxr2+2EDNk78zmbJkFTb2BIAlpJQ0Vy94cXYX+6G
	mLQ+bX51aUM93fDHKr0wCaHp0dLuHcO5YTjZ83MBeyp7NZg6d8Kio3hj5hk7Rp4Gnzfy/sv8LnH
	8hH8mFclYcUWDdTEaItIywE6Xw3Sd5XHISnSK6eZ5D+ss0ydDzFwk6lv3I2jW8P8twHuIAwog4S
	+3gb2LG/87njmrp+Ll8sg2+0a4A9EJvBdlP+9xiuG0P+2YXQOQkEiw1QzKa3Va0MGHF+wamqzG0
	Gd69g=
X-Received: by 2002:a17:902:f70a:b0:2ae:5044:8dd4 with SMTP id d9443c01a7336-2aeca960929mr48646955ad.19.1773446445348;
        Fri, 13 Mar 2026 17:00:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece630b8asm33391945ad.40.2026.03.13.17.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:00:44 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:00:44 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/6] bnxt_en: use bnxt_xdp_buff for xdp
 context
Message-ID: <abSlLEsmGAlmGkQk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260313223029.454755-1-carges@cloudflare.com>
 <20260313223029.454755-2-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313223029.454755-2-carges@cloudflare.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267641-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 743B328AC84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 05:27:31PM -0500, Chris J Arges wrote:
> This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
> pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
> along with the completion type.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
> v4: moved bnxt_xdp declaration to follow RCT style
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++--------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
>  2 files changed, 22 insertions(+), 10 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

