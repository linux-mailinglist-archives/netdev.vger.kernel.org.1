Return-Path: <netdev+bounces-240350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55BC73A91
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C146D347E7D
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6242D192B;
	Thu, 20 Nov 2025 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cstr9LDO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95B1EA7EC
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637388; cv=none; b=P/FpoCkdtEoIpsmqRyxegfLNTOjsCVjP2JA3I4p4MJyx+X8qLKXo+LpuTCDX8KkNIeHemZfiAPO8BYIlE06K/ASGHT9p4LnuOBJlmM1nB93ZUbhc9xKqWxS2AGrbjpoRv/ES3s3CHLERKdVH9GYyeJFr5slgkJgnX8Dxe4eHVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637388; c=relaxed/simple;
	bh=aaujChFq0aBNtPDtJwu9E+yl31n3maw8a+IjMcDvdgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPr/i4ewcubec9HwEwcd2CKSsoEFiyOg4i/HDFbS22QrBrPmMPozXlqpEJe9K+fYqJeZZ28UFQhku1NxV0LbKH12teKp4ruXxDLNZ6ctHSacjbLRrsDkgM0J0khvHl0czQ90pAHkGW9oBSQBtf4m2x1NWHFuVuW3I6uGQAGzH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cstr9LDO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477a1c28778so8965165e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 03:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763637386; x=1764242186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OPXfZoq32hCbqwxNyncsVbKNdLZ3Sub0ZLhzzXMtjo=;
        b=Cstr9LDOZEyibDNHmrlgwZv/kUodflHgjupKdZT7AaNpOXRIyksbd2jGikvCUWiQlq
         h92nMuj1rxfWVQQgqVo1bqRRjhC3MQrRDH2y7sCjd4TfcHMj8JFZw/uBwDleJp9wsFz4
         Uz3k4tuff8DBGsNa3g1mC/RUXZbzUCkCw5VmOz4/qJJQPO8N9X4FKkqnB+HNGNtdVb9F
         Z9CXDD8W5II8xaTmbK5YlHeE2zoussuM2+FfHBpHcruCKM4hhgjNVQm1zcFEYJTTj/QL
         nIQN43rtdum/Qv9HAxvaL79rvlBTpJAVoyFcBh36gM8jKEJRiV74Y373mzYamsWYGOQh
         L/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763637386; x=1764242186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0OPXfZoq32hCbqwxNyncsVbKNdLZ3Sub0ZLhzzXMtjo=;
        b=PqfdED7Np7k3zSK8tHdGPLl8a68RxurNuOdxAc23I9IPwCDCmM9CviajzOcbT2k3N6
         Z4kO52Cnn0G27C+ys6Jq5jkI4tmUI+FQ6Dx8ABl4gVNKYZhn+sEF8xzT03NsJ5J9Arv+
         VuY+Yor1mWAGd1/AxyaD8eeDeCHBZPz2c6ccoc4BwNWzYUKk1YJDOd6qKEZOI1BYHFjc
         ZHd+yR86HEeWybtD2I7RxYHS3S7vbHpdfHb4rNFZ/zvU+v5063d3mjY2z/tcBwveEhI+
         Mrxy7oqxv50z7hJHkjiAwM2RetLC4t+4pAK5sO64MEojE0mn45IPcXWHos3mb0daRsrX
         zwPg==
X-Forwarded-Encrypted: i=1; AJvYcCW5oNuZ6hQVQ2LXQdcPTCR9UGA2Jav9J3+IoEaez6JZNBFRqIePSF6ti1yWswHf22lEetcecIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQopXZX5jP0xCoDR+WUTOKU6Fdx0kj9DGyTdoWCFPZVGStXR1
	x+x6zRofconfvO1TJ+MXcTttil0rtes2bnelEgg318fFMqXl/aupKq00
X-Gm-Gg: ASbGncuP+ZsqIqrAAJgEmu7HaaJG0Bzq+RJRkGvJermS5gGB1iV3VPzxCgmjc0leYkM
	luLhzDjbK3QRvwYSiSQhcvpMcZ7TyCmSTlEnX71hXjLsphwhAI/03fngMjRp4Bbl9R12Wk9vXXk
	e7PbDhgjKWfKlPHt5SXFza/r6BZ7OvwFZRW8WRFZXJacpQDHU+p41HVF7YvY39E9kRibJFgwSAH
	E+lMGBmeROYwv8rXZxUE78giUXVf812qEiBnuonongf60QM9IIxtCBQVIeuvLBXhH6J/jn/41br
	aqQ2r8aToGNQOnYJ+X+zRHSiRntplubuyaVz6tJwi9huuxs+NWSa0n2eVrhzS69/2nds6+nLMPR
	lGN6nrifVoEO8iuCi7ML125BQSeqTFevfLRKSYHeAAw1nCmSmSQKPU7g1di2iLSxrZUQyY4z+3G
	cdY0/mI7rLU/e4JRhewneUiGynVmqJTd7ReujYIO+amHpPW06x+kFT
X-Google-Smtp-Source: AGHT+IFZB29IrybraSPGQhV7roEItbkZW/1Rvxj8aVil7QNoLoeVbtGz5PzkfltFhZGqHiCqn2Q5ow==
X-Received: by 2002:a05:600c:3115:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-477b8a9f9camr28349905e9.31.1763637385245;
        Thu, 20 Nov 2025 03:16:25 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a973dbabsm64908285e9.3.2025.11.20.03.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 03:16:24 -0800 (PST)
Date: Thu, 20 Nov 2025 11:16:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 09/44] ipv6: __ip6_append_data() don't abuse max_t()
 casts
Message-ID: <20251120111623.44ebfae7@pumpkin>
In-Reply-To: <ddcd920ff99e0f97ed2c92cf650872d76a4b7404ea87a104e6ab061ee3005cf9@mail.kernel.org>
References: <20251119224140.8616-10-david.laight.linux@gmail.com>
	<ddcd920ff99e0f97ed2c92cf650872d76a4b7404ea87a104e6ab061ee3005cf9@mail.kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 00:32:34 +0000 (UTC)
bot+bpf-ci@kernel.org wrote:

> > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > index f904739e9..6fecf2f2c 100644
> > --- a/net/ipv6/ip6_output.c
> > +++ b/net/ipv6/ip6_output.c
> > @@ -1440,7 +1440,7 @@ static int __ip6_append_data(struct sock *sk,
> >  	struct sk_buff *skb, *skb_prev = NULL;
> >  	struct inet_cork *cork = &cork_full->base;
> >  	struct flowi6 *fl6 = &cork_full->fl.u.ip6;
> > -	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu, pmtu;
> > +	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu;  
> 
> [ ... ]
> 
> > @@ -1504,9 +1504,10 @@ static int __ip6_append_data(struct sock *sk,
> >  		maxnonfragsize = mtu;
> >
> >  	if (cork->length + length > maxnonfragsize - headersize) {
> > +		int pmtu;
> >  emsgsize:
> > -		pmtu = max_t(int, mtu - headersize + sizeof(struct ipv6hdr), 0);
> > -		ipv6_local_error(sk, EMSGSIZE, fl6, pmtu);
> > +		pmtu = mtu - headersize + (int)sizeof(struct ipv6hdr);
> > +		ipv6_local_error(sk, EMSGSIZE, fl6, max(pmtu, 0));
> >  		return -EMSGSIZE;
> >  	}  
> 
> Can the variable pmtu be used uninitialized here?

If your AI bot doesn't understand code don't run it.

	David

> 
> When reaching the emsgsize label via goto statements from earlier in
> __ip6_append_data() (the checks at lines around mtu <= fragheaderlen,
> headersize + transhdrlen > mtu, and the dontfrag check), the int pmtu
> declaration is skipped. This leaves pmtu uninitialized when it's used
> in the calculation that's passed to ipv6_local_error().
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19519124312


