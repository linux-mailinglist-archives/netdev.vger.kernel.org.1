Return-Path: <netdev+bounces-186375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AF0A9EB61
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA743A85A6
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9225EFB8;
	Mon, 28 Apr 2025 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksu3Ubrz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6545C2236E5;
	Mon, 28 Apr 2025 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830971; cv=none; b=oIOXcWdUhXfh3/uSlawJgvOgkFnX7q2iGG35rwyklt4/gilKRqCbEz8mrMPBziYZSo0w3pFUX631W4vIiT8da+xuQXKUZAZeQCUp9GvyU6Bmi4JNUCt7JDpkAwVoyKv4H4h8K8ho/12/JdWeNTL45QMBk4qrIEhMHI8Sr7eP4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830971; c=relaxed/simple;
	bh=mUezaAAjCJvcIBBQl20BiC4MU7jwp5YtdVwMumDpQuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkBsG2poPfD/GCVXVu5bpsxZ1oi32dG0FybQ26r88ck7t6iV/ZSktwZkn3kBFJPXthyyVmpcVCtjKDWx0KpzNHmvoep91lOafjxKsvxiYfhuG/NAmR35vWxzwXBTyj8gOk/AhfkuY4/2sL3rZJ0ctRfnvgqY6DIzViMtIrH/lqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksu3Ubrz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3912387cf48so130732f8f.3;
        Mon, 28 Apr 2025 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745830968; x=1746435768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rBGksg2IxAu1Tmq5JGjOVoyWm+EmXRQlpuLMjgaUXIo=;
        b=ksu3UbrzqLr88L8X+3QdkI5+BOftcJNvg8Zphu8lgMxNt1eyzXXipmibL2Rto4kwVb
         d8+zzRVDY0xdYUVDVPbLtYiZaU0kMIiHQ9I/WaRMU7uHCeJDUYWYarBFKHJHcnj1zkvo
         HCeXh6mltVXouoOr70XDVDTjBe/CDFLLaOD8VbuTq+U3nacGZw1Y3+/4fxHrr9+YwAy9
         zib5SfVgbEkyFNp/R0igZxtSqa6KnufcmBIVzJ0mMUlO36IPUjx4M9nBIryEizd3fifQ
         O+sajJALKYyTa+TPiafxVvndhJyIPeDEzq1vt5qYZrpoOU3/auisADNs9oDYGRMMyYNn
         CYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745830968; x=1746435768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBGksg2IxAu1Tmq5JGjOVoyWm+EmXRQlpuLMjgaUXIo=;
        b=v1z8iYRVrCD7bFBzVyNxLfeUGfg48VRht0iCQywUacEB7VCZIUhqqhERSKw8V7Ca+S
         1b0enFQqRbllGxvQ4QHJEFBkM+g63Q+IL2t0NhUCb1u2/n3zWu4hARaQEyajxtZ3ca7Q
         brc8BW6EqLqt+bOjCAnv7MAtE/YaZBioW9n8pascXziC3NNF+nmv5+uUn0PJegYZjTqU
         57fyHxY31h2dA92fXV4qS4nWLMpmkkXSxcaFxJsUtgCiRbwbtUr4aTawvNzCbS/YRf3g
         Wbv8S8lOGj2oqxYMmlMr2nnRUfoJTFiG+hT1jnEEb4D6er3SWf8KG5ZWTjZHh2L/S0Bl
         vEkA==
X-Forwarded-Encrypted: i=1; AJvYcCVptS7T5efyzyv0P+1NGiWuhgqJETFkP3gLFX9+2mnjZ5pudqiufdOfHA4E/bQRbwDAlfxQg75Fgdsxux0=@vger.kernel.org, AJvYcCWMDyDdouj+UyaJPcSVIbu4ut0JEtazo4RO4WbVd0fcvJ5raAhhLRNr4uQwfLuFoieAd9f+Jy7M@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIrh54vxWoYN6F28lZI37z+FRy2v9PvQluejQ+X22zCwYla8x
	jlYegqBILRakfO53gAf3bReLVfK4EjqNwI9HOnO+Ho1++V7jbEQh
X-Gm-Gg: ASbGnctE8fyJVpSQFjZ/szAWRz42aC0jQGxVWHAmX67GydhVvQ++vU/e9VHV3+YUNjl
	R1G07AvjlVEtcxHeJB6kJgGNHCvL3azPxsDKPvu2laA8dMKAVrLhn2HUBK1KOeqlTfdHMrdswGl
	hXVJlKoywpSlkj3bdtD0/9Qx31dmtGoepYucbwGcARuE1P19K7XMWRmJyPhCXScCrTbQ5HVDj32
	RGJlkl8fCNYmXCnntbnaOrnRak+GReGm7ESL9LPz16aGUeKoZ4cgWBZij2tEB77yg8l1izwA5v7
	zzvi1B4VumgmsxXmisxUUEC3HH35
X-Google-Smtp-Source: AGHT+IH95kWZIl9MkZDgw7fmG1bBonr030oaRnnaazBkxqkiOcALWz2eFk9yqTnyD0OELAIfXOAALg==
X-Received: by 2002:adf:ef8d:0:b0:3a0:782e:9185 with SMTP id ffacd0b85a97d-3a0782e93f6mr2122002f8f.2.1745830967400;
        Mon, 28 Apr 2025 02:02:47 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca511asm10277169f8f.26.2025.04.28.02.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 02:02:46 -0700 (PDT)
Date: Mon, 28 Apr 2025 12:02:44 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling
 filtering
Message-ID: <20250428090244.phg3xijxhhtczkvk@skbuf>
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
 <cf0d5622-9b35-4a33-8680-2501d61f3cdf@redhat.com>
 <CAOiHx=mkuvuJOBFjmDRMAeSFByW=AZ=RTTOG6poEu53XGkWHbw@mail.gmail.com>
 <CAOiHx=m6Dqo4r9eaSSHDy5Zo8RxBY4DpE-qNeZXTjQRDAZMmaA@mail.gmail.com>
 <20250425075149.esoyz3upzxlnbygw@skbuf>
 <CAOiHx=keOAWqF4Atzqx4VZW+xAccO=WtWCOoVoEPR9iFrDf_zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx=keOAWqF4Atzqx4VZW+xAccO=WtWCOoVoEPR9iFrDf_zw@mail.gmail.com>

On Sat, Apr 26, 2025 at 05:48:26PM +0200, Jonas Gorski wrote:
> It does need a lot more fixes on top of that. With this patch applied:
> 
> TEST: Reception of 802.1p-tagged traffic                            [ OK ]
> TEST: Dropping of untagged and 802.1p-tagged traffic with no PVID   [FAIL]
>         802.1p-tagged reception succeeded, but should have failed
> 
> The latter is no surprise, since b53 does not handle non filtering
> bridges correctly, or toggling filtering at runtime.
> 
> I fixed most issues I found in b53 and it now succeeds in WIP code I
> have (and most other tests from there).
> 
> One thing I struggled a bit is that the second test tests four
> different scenarios, but only has one generic failure message, so a
> failure does not tell which of the four setups failed.
> 
> The issues I fixed so far locally:
> 
> 1. b53 programs the vlan table based on bridge vlans regardless if
> filtering is on or not
> 2. b53 allows vlan 0 to be modified from
> dsa_switch_ops::port_vlan_{add,remove} for bridged ports
> 3. b53 adds vlan 0 to a port when it leaves a bridge, but does not
> remove it on join
> 4. b53 does not handle switching a vlan from pvid to non-pvid
> 5. stp (and other reserved multicast) requires a PVID vlan.
> 
> This makes especially non-filtering bridges not work as expected, or
> the switch in any way after adding and then removing a filtering
> bridge.

I'll admit that I'm not very familiar with the b53 driver and that my
attention span has been quite short (and the passage of the weekend has
not helped). Please post patches explaining clearly where we are and
I'll try to follow along.

