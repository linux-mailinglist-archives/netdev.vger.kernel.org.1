Return-Path: <netdev+bounces-216967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A84B36C49
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441FC1C46005
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3FF35FC19;
	Tue, 26 Aug 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXlW3t9S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E735AAB4;
	Tue, 26 Aug 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219136; cv=none; b=QBWM95UW6iARig6KfFTcucpFnmU4MJD70OTymGq/6yUO2l3gg5Pw3I7ryfojOaSJwx1/8ZU0TS/JA93qT9bBLujxnGa58qHJF30gHqVQ8G8lCGhB76dEAb/412D/my2QlnpxJT/xnSknZIfay2/sKUivZvWAdEyQgQ0aok6/v3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219136; c=relaxed/simple;
	bh=Y6APwQxwvGhqQiU0qnlk9kFVimX4KbrPK3kJnYGAEwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe1umEH650eb+9BTA92r+xJJRxEkL+uIMBy4n2/v/hKhG163z3OqaVNrh+ppSQ8ZGYNSo6uee0muHgOniAv8hOjlt6vHHo/wi3i8cXMYengFcfA5NtNzGa6mAGo6MgS41Vqr7/y7WM5XaqHgTlVNMGAGw+R+SyIALsZhr7GsyZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXlW3t9S; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b72d690so898701a12.2;
        Tue, 26 Aug 2025 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756219132; x=1756823932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6d4F5lWcv+eLekx7HNLggfgjBWTBT95yOAIkuEoxMk=;
        b=IXlW3t9SzXp3SmY1cZce//wKOIC4yBgyfIdXatIrR+bGGMnDGcrp+F040dZqsQqx0w
         UF79BI+DQYWH1Fftxe4j3SznOjof9cra6sg29lMRaGJXBxOwg/Z4kkf07cz0u7qd2VNZ
         Q+kXSAOHZJ0HXDJQgKYffo894QwINQtmUD8AgdCwguafBIm3xXVrtPqkdsjreJbzGAvP
         MjPZ9QEdP/l/dlgpjyYoVOGySdbQZTXYDtF7UjEMR0Wr57jk/x59ywYJJMJBYX2jP2dO
         4zfFvssn67DFqouze09eL9ba33v8u8cspRbe9dmqqTIW2/jRQqfjO/4w1XCTRQKNq4y2
         97pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756219132; x=1756823932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6d4F5lWcv+eLekx7HNLggfgjBWTBT95yOAIkuEoxMk=;
        b=E85WC9GlHgHaIv6Af1wZGYwKdcQ31F23Bp5Nq4FnLRxLXAQplrBz2pr4XQUIrXzAFU
         pw1ZCJ5XIBNh9M02kAqhHXuWxV55BHe2Wr+Bs+CG6rENhN7sEzJ6SrKlAM8hRTuwG4tm
         EgYkOO4VJ+Pl9SiFlBnEQ4NsVUFgY2q/6IntfdXt9jUptSCQcZwt2NGA49ZEK19Tegdj
         srAXmUydekmVuOhHBd7ojgI7CWAJeDoJLkImDDWoxFI3QiBU0Uh3gUE677YygMVCQ0ft
         PMoIJH54L51wKEfebF1O08kgz9kJVhFNqbeFxGDWF19nRvR4wyKxyit8Q+ncHN1PD9hm
         06qA==
X-Forwarded-Encrypted: i=1; AJvYcCWTTfsNIIX1lMye/wmRSTmCX4N3EtfJDNvkId6DKisRQP70zjM22cx3Og7QI8pXU60vWbIy3WjFtZZe6wqQ@vger.kernel.org, AJvYcCXL/dzVIN8AmDrKzGkITbn+75WiXwbWXFgQzTqdnsOvvjSkbz4ell6CgQGjYGTcHmDC67nP4yTGH+1A@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZW1qUiQmd6/nNF/F1iRyfLk5PKVzhNz/r6xz44PIQ7vmc8nu
	pLo74bD28it/4CrA5zGb1Ub2+Ep3nsIkUFFyjRb9soVzzoRC0RAo+1DQ
X-Gm-Gg: ASbGncuZ88LapkbflyAeOdaxRieAwN5FaBy1q8TmApFXueemWlnvsfYDZIbU8wT0qzB
	DAyuZKgy/IUZTSIOGgfvz9x019qMImWiRhy6f/kGybh7Bez9VvE2lHZCQrP8i1/xbGBngCKUJOU
	b8Uszw9kvzOMz24jjcvJ19uB9SqW+gAaqmQ6wfxHeXU1VdLqKANUeY/sElDozQn4raHyjXqlOlE
	p7vx4yHy8PO9PcDNZJkDaKuQ3xfvNbRLD8ea/fI2Sdnp63rvIynaY+DOWx4zf1pvT4kV/jDs5Eh
	j5cljxy5VZ6KJnA5HwSwoqjQyZIODz/jp5SJDsHk037ljYFBMh56XzA02rwWaIaeWd6jXoHrb30
	UCw3Fi24eA+ZHWw==
X-Google-Smtp-Source: AGHT+IETPXxxMpJyeesJWYBnsu+A3CD+BFs8jRFWez5lq7PWwxLL73ZZJjY/I5QKHSkfBf3w4iFvWw==
X-Received: by 2002:a05:6402:510a:b0:61c:8205:f3d8 with SMTP id 4fb4d7f45d1cf-61c8205f61cmr2116423a12.4.1756219131642;
        Tue, 26 Aug 2025 07:38:51 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:63b:fbf0:5e17:81ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c31703d8esm6917552a12.26.2025.08.26.07.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:38:50 -0700 (PDT)
Date: Tue, 26 Aug 2025 17:38:47 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/3] net: dsa: tag_yt921x: add support for
 Motorcomm YT921x tags
Message-ID: <20250826143847.wwczaqgafl6y7ped@skbuf>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-3-mmyangfl@gmail.com>
 <20250825221507.vfvnuaxs7hh2jy7d@skbuf>
 <CAAXyoMNh-6_NtYGBYYBhbiH0UPWCOoiZNhMkgeGqPzKP3HA-_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMNh-6_NtYGBYYBhbiH0UPWCOoiZNhMkgeGqPzKP3HA-_g@mail.gmail.com>

On Tue, Aug 26, 2025 at 09:47:34AM +0800, Yangfl wrote:
> > The tag format sort of becomes fixed ABI as soon as user space is able
> > to run "cat /sys/class/net/eth0/dsa/tagging", see "yt921x", and record
> > it to a pcap file. Unless the EtherType bears some other meaning rather
> > than being a fixed value, then if you change it later to some other
> > value than 0x9988, you'd better also change the protocol name to
> > distinguish it from "yt921x".
> 
> "EtherType" here does not necessarily become EtherType; better to
> think it is a key to enable port control over the switch. It could be
> a dynamic random value as long as everyone gets the same value all
> over the kernel, see the setup process of the switch driver. Ideally
> only the remaining content of the tag should become the ABI (and is
> actually enforced by the switch), but making a dynamic "EtherType" is
> clearly a worse idea so I don't know how to clarify the fact...
> 
> > Also, you can _not_ use yt921x_priv :: tag_eth_p, because doing so would
> > assume that typeof(ds->priv) == struct yt921x_priv. In principle we
> > would like to be able to run the tagging protocols on the dsa_loop
> > driver as well, which can be attached to any network interface. Very
> > few, if any, tagging protocol drivers don't work on dsa_loop.
> > > +
> > > +static struct sk_buff *
> > > +yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> > > +{
> > > +     unsigned int port;
> > > +     __be16 *tag;
> > > +     u16 rx;
> > > +
> > > +     if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
> > > +             return NULL;
> > > +
> > > +     tag = (__be16 *)skb->data;
> >
> > Use dsa_etype_header_pos_rx() and validate the CPU_TAG_TPID_TPID as well.
> 
> See the above explanation why rx "EtherType" is not considered part of ABI.

So what I don't understand is: it's impossible to separate RX from TX in
current DSA taggers. If TX hardcodes the assumption that the switch was
configured to use EtherType 0x9988, why would we expect RX to use anything else?
What valid configuration would we prevent, if we ensured that RX packets
have the same EtherType?

It should be ok if you documented that the EtherType is self-assigned
and must be hardcoded to 0x9988 by local convention for the moment, but
is otherwise configurable, and the meaning of a different value is
undefined. Even if self-assigned, I suppose you could still add the
value to include/uapi/linux/if_ether.h to avoid conflicts with other
uses.

Even better if you clarify the expectations by writing a libpcap
dissector for the new tagging protocol, which you need to do anyway for
recent tcpdump versions to work on the conduit interface (otherwise it
fails with "unsupported protocol"). See
https://github.com/the-tcpdump-group/libpcap/pull/1463
The libpcap dissector uses the /sys/class/net/eth0/dsa/tagging text to
identify the protocol in use, not the EtherType.

