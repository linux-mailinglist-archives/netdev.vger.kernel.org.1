Return-Path: <netdev+bounces-244633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D348ACBBD4D
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 17:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C71E300F596
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D6E2DAFB0;
	Sun, 14 Dec 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4GDV2vM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DF82DBF78
	for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765728633; cv=none; b=c9csyKhwSkafUesvrxe0BQ5DABTq85ZV+265UI7thIggny4aFP698gG+GrXJXiGfHe21Q+NHPASt2h+ZMuCMk76VqmqYGqNyavTGSwzT0+UpYg+fscvR1M05Fs01TYg1lo8sRN54pkjqvFW7NOV5DO2snnZ/OadfW6uKffAKF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765728633; c=relaxed/simple;
	bh=2P76yn+Z8LI/ZVioihqPrigDTmpFaYI31nbzKmzdNA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+AQ8Be2rcHEE+tiJheGf1oPo1OHkKg/4s9fVjwXE1aTlLoPASu3aZ4WHNS5apl8+cGeJWcRNVMN6i4luAWhp486XcvItrbJXyHsF2RJE8u7aqDLWeGQNCiiGBNItuqAw+EboaAJuRqIZXcpWQCb6DhxXstEbQxGdJ+8H+AHqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4GDV2vM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7ccc521397so45997666b.0
        for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 08:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765728630; x=1766333430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fgCqWv5yTAwZgeJA7+vqwON4IRjNzRVmnKX5YmdyP0I=;
        b=D4GDV2vMosfm+CrnHHWuTMeyGfPitBLrv7E2CdIe5il6YcVdZYZXcv5o4D6XZeRhOu
         Ke2PYiTZK8gsd9sASWynrx/bMiGGoAdvQHOyx2H5JxkTS2hnx2cknVaIwp7nOR0OTb45
         pU66FyL00xVS1aoLxNIvWCJWTY8M6WTMNw2ZnE2KZRc+y277agGW2yraLRvgwk1Thhyk
         /2cYJ2Ae2UKVEUvL+UrSFAYDpRgcGwYR49KmoQAz2xDijBP6QFeyy7SbNpHSjpG2JnYi
         xFhIkXKpXH+zonD+WUsV6dHdHHNLSyaWHgLwVJjpZmAbEzwYqtDDxuZFhYn5p4S2L/b3
         uMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765728630; x=1766333430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgCqWv5yTAwZgeJA7+vqwON4IRjNzRVmnKX5YmdyP0I=;
        b=rz61peBtWN054VFYfnc69m3J8xB6o6DyRAXq3W7UwBbQsvuHtAhHO6OHYyvKNudniq
         70Acepjdczv8VKTUsjTeOODb82EP8bBnlpaJ0R6nTMBy9Pp9l4C2+zMbeiMRzDOGP/OW
         K360lBbgc61xxISr862dso3qQDPO1bdFmE0IDwfAQFM6xZ1BcWBNZsee+ATu17sVKZ5m
         sWU64zuPAiAkwO8P5F3utcH6ayq3Ja7U4MKeeWmdUBwTXRtFOtliNNNWQgQTXRD3DQOH
         CKrhVrZG4xsGNU5xgX+mD7nj1tknqH2VUAnX4n7VNlmGBcQHSist6EbMsJbn5rINlaKy
         UmUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtMD9RSdOKd5Vdt92FQX5WAlnGxcsOBjR5cw1xskudVG71ELrAn1zHqdyXfkvwe+rz4cDl/74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXVCWjPavUbWuPp9Ck334fda2wbtxDrRWpp92s3Heg/LI54RU
	LVqPIgr/OeEr6YTNGgz0JkEaWwsqjxIszrmpcyJI9M1Y+t1JPNXxrE3V
X-Gm-Gg: AY/fxX6qIEI1SOaLTkmQLxm6maFqjKVZNYI9JPKmDSKLo+4IrkfnPPKNhssHq5CFhU6
	R7zPFLJ94GWA5m4AeT/lVIUcIhjC54ixa9StElELb9F2UeTskNOB7mPuumLuWkqwKfuh5CvqSLs
	0C1+Qfb4S4qDkjiBSWYwTgeQoRBOZQVmUjuzJ9UgwUVENshyJc5BFUh7jzZ4yDtib2PGVCdVOOA
	+BmnEuJy8DchnsMVWI7r/y3FPxssLOYGddOk45XEr8WnpdL+2buH2IR+sV12aQ0Z53IjK8A1ivK
	GZ0DSqB/GgdnGuFSMKEvYEOxjIdEHNXf/T/dT2NyyHVkYh8kcezXhsRsWpEOj5CJfyK7qEznjHp
	HwDaksu8sDnA6zi1NThmd1QiF+0ItwmXxgtKJ5N89ATCNBeM1BsnIxVCiXxBs9fxMZXwWOX6cnJ
	0ejw==
X-Google-Smtp-Source: AGHT+IEEp5YA/CXlF0fGVYT4q2YzKcum9dlHWaMuW0DOnrROURB8FU3NlBiJivnRbJ8xs/4/n0apSw==
X-Received: by 2002:a17:907:7295:b0:b76:2f66:4ddf with SMTP id a640c23a62f3a-b7d238ece38mr491721866b.3.1765728626411;
        Sun, 14 Dec 2025 08:10:26 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:10b6:92bb:682a:9a0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e70c2sm1135704566b.15.2025.12.14.08.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:10:25 -0800 (PST)
Date: Sun, 14 Dec 2025 18:10:23 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Ma Ke <make24@iscas.ac.cn>, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, tobias@waldekranz.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: Fix error handling in dsa_port_parse_of
Message-ID: <20251214161023.5qcyyifscu73b47u@skbuf>
References: <20251214131204.4684-1-make24@iscas.ac.cn>
 <39ba16a9-9b7d-4c26-91b5-cf775a7f8169@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ba16a9-9b7d-4c26-91b5-cf775a7f8169@gmail.com>

Hi Jonas, Ma Ke,

On Sun, Dec 14, 2025 at 05:02:33PM +0100, Jonas Gorski wrote:
> Hi,
> 
> On 12/14/25 14:12, Ma Ke wrote:
> > When of_find_net_device_by_node() successfully acquires a reference to
> 
> Your subject is missing the () of dsa_port_parse_of()
> 
> > a network device but the subsequent call to dsa_port_parse_cpu()
> > fails, dsa_port_parse_of() returns without releasing the reference
> > count on the network device.
> > 
> > of_find_net_device_by_node() increments the reference count of the
> > returned structure, which should be balanced with a corresponding
> > put_device() when the reference is no longer needed.
> > 
> > Found by code review.
> 
> I agree with the reference not being properly released on failure,
> but I don't think this fix is complete.
> 
> I was trying to figure out where the put_device() would happen in
> the success case (or on removal), and I failed to find it.
> 
> Also if the (indirect) top caller of dsa_port_parse_of(),
> dsa_switch_probe(), fails at a later place the reference won't be
> released either.
> 
> The only explicit put_device() that happens is in
> dsa_dev_to_net_device(), which seems to convert a device
> reference to a netdev reference via dev_hold().
> 
> But the only caller of that, dsa_port_parse() immediately
> calls dev_put() on it, essentially dropping all references, and
> then continuing using it.
> 
> dsa_switch_shutdown() talks about dropping references taken via
> netdev_upper_dev_link(), but AFAICT this happens only after
> dsa_port_parse{,_of}() setup the conduit, so it looks like there
> could be a window without any reference held onto the conduit.
> 
> So AFAICT the current state is:
> 
> dsa_port_parse_of() keeps the device reference.
> dsa_port_parse() drops the device reference, and shortly has a
> dev_hold(), but it does not extend beyond the function.
> 
> Therefore if my analysis is correct (which it may very well not
> be), the correct fix(es) here could be:
> 
> dsa_port_parse{,_of}() should keep a reference via e.g. dev_hold()
> on success to the conduit.
> 
> Or maybe they should unconditionally drop if *after* calling
> dsa_port_parse_cpu(), and dsa_port_parse_cpu() should take one
> when assigning dsa_port::conduit.
> 
> Regardless, the end result should be that there is a reference on
> the conduit stored in dsa_port::conduit.
> 
> dsa_switch_release_ports() should drop the references, as this
> seems to be called in all error paths of dsa_port_parse{,of} as
> well by dsa_switch_remove().
> 
> And maybe dsa_switch_shutdown() then also needs to drop the
> reference? Though it may need to then retake the reference on
> resume, and I don't know where that exactly should happen. Maybe
> it should also lookup the conduit(s) again to be correct.
> 
> But here I'm more doing educated guesses then actually knowing
> what's correct.
> 
> The alternative/quick "fix" would be to just drop the
> reference unconditionally, which would align the behaviour
> to that of dsa_port_parse(). Not sure if it should mirror the
> dev_hold() / dev_put() spiel as well.
> 
> Not that I think this would be the correct behaviour though.
> 
> Sorry for the lengthy review/train of thought.
> 
> Best regards,
> Jonas

Thank you for your thoughts on this topic. Indeed there is a problem,
for which I managed to find a few hours today to investigate. I was
going to just submit a patch directly and refer Ma Ke to it directly,
but since you started looking into the situation as well, I just thought
I'd reply "please standby". It's currently undergoing testing.

