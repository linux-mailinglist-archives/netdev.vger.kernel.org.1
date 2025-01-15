Return-Path: <netdev+bounces-158673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447E6A12EE4
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 00:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E7E97A28D2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771D91DD879;
	Wed, 15 Jan 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pgb9H2tA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD9C1D88B4;
	Wed, 15 Jan 2025 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736982073; cv=none; b=mVGpRbYlUQBNvFDoTjkhhhFb5se8yA+718iPw5nDmKC4Kos3Bxvf7iOfq9y6lKULg4G1yKj82e3p6Tc9S7gaHUPiSTON+P7m1zACbdR4dKz6ZE9PutGkfotFU6qmLdiisUjn1JfW3XM+2sodzHMlH1wBwr7cNoxZcYmzDzsawvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736982073; c=relaxed/simple;
	bh=I3IfvvqdcoU7nHHADCItZRbYFOMowB8r/DknPpQ9+zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0jm7iUb4VdRnJJf7/r87nVKXOHaT3UtByL3u4rYslawcYUmo4CF8YTuWrZGdgMRHzhWvECxBst6IbFJfyUyU2xymgUduZg+UXUmE69K4fgjBp6ceORhjBDmByQ3fnJn14FxEmi4DlSyJ9PGVS6sg1rWhi5s2d47sY0gu7csD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pgb9H2tA; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3003e203acaso3207461fa.1;
        Wed, 15 Jan 2025 15:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736982069; x=1737586869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7a0VH4/3/vYeVavIG5A8uZ6qvorPXei2ZSvBCCuae0=;
        b=Pgb9H2tAEsvYwy/6UNF0SdqGHoL+rtZmjHmKEPj5qvfZOcoru4SSRGRO8A61nrK4qb
         BrYKtdnB5wZnkmDKEUfvWieW300dC8wu0IrGhJ/BxF6CASU7otTb5ylVHdp4+YiM3cd1
         0xSG1cOpG5kFKpj/nGa3DpsBg0KHcXZMg4bHFs7rmAOkmgZBml35GGybYoYy+OcOX+Nt
         bdk5RkVJAkVEafSuZxeLxVFxu29dCwUYCyr/q1Ded6UJBH25DIVU2DIbqCKCO1fQ+rrT
         Y6ADxib0itveH4GvUHhDVSIW9jz/uWyIQXiNRLMc3D/zMrXf3n7d23IxJWXzc6KnD0U4
         mFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736982070; x=1737586870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7a0VH4/3/vYeVavIG5A8uZ6qvorPXei2ZSvBCCuae0=;
        b=AghYV/UNfFgOkVbL08AWyu0q+ugvS4Iak83t5T4j/o/MSO/F2epa1sRn1x6xfRnssi
         DH5vpBhgXfqX6q+L0ddUWXaUd6JfU1zQfYFvsnUmQGxdUFWuI2On6NlZSydEZ8n3kSGn
         TkEtPxF79D8uEnkPw+Bbayr1VffPhSur714tkTSg3e7eNeDwEHQmWFxl4TTysdaXcpti
         n67/XxOUPpXBFoZxLxUTqigHaDhRDK/pNnrV0x+8qC1jBLmJPTetbrGv9oiC3TzMuVQG
         1Ifm2LC0oM5XTeOxFRWVKg4/IZFyZcExzU53T72kf56J82SMMO9YgwCLgaIvzA2RFXtK
         Q3vw==
X-Forwarded-Encrypted: i=1; AJvYcCWRJnl/iv0i6vHWpSxATyiVh3YLRLjWd0w48azYx7IvyMmSJQYStkXT5oLlV3UhEd2HZPTsguGZkOLALR4=@vger.kernel.org, AJvYcCXLmf3/LZw50TPh2gECixDgU++dHo9p5EoIqTF7kpnj1Pk6s135/bqHeE8U9CJhBTI4A8E0DUBu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZXk9T56W65Obwo0EfVCvipTdTg4NxKawsQ+rEdpQpWsNzCzn
	vE6wEWXJ1KWQfWI1a/0ZOg2P5A39vSZ/zXPQUEyATGyzCZs7WdtF
X-Gm-Gg: ASbGncvj1BQ4yAu3xxWVOCB5TTsztECpi0yq3vh9UmIlzM5TKJBZF/npfTHPzUQjcO8
	ZIF5gqgxYsqBRomqUl1ZxwX2XxGzhy9ca4dben5i59HIuufF/KeEcMrJn3PDrzeSS4w8mZk9JW1
	7MlYyU3NBuvBW5PmvH8Zh5G5PjzH6KZa6lZ3j8eiK+mtpe0DtFmWUOfE5WDR8xoCbO+9SLswKR1
	Xan42I5I/U2umNoCHEMUbIpDW1yGp1MhT3njMi3DXsFEcyUFq/pkr5O0loGpPSnHQ1sF4Q=
X-Google-Smtp-Source: AGHT+IFHsOyouwx8pfW1D+fKycH5aKyFvM25PDovCl4dtLRPrCDHrmZHCEAJfogENtebfxY2grN8GQ==
X-Received: by 2002:a05:651c:2109:b0:300:3e1c:b8b1 with SMTP id 38308e7fff4ca-305f45da72dmr137615921fa.18.1736982069112;
        Wed, 15 Jan 2025 15:01:09 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-305ff0f88e3sm23192531fa.61.2025.01.15.15.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 15:01:08 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 50FN14RA004157;
	Thu, 16 Jan 2025 02:01:06 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 50FN13Hh004156;
	Thu, 16 Jan 2025 02:01:03 +0300
Date: Thu, 16 Jan 2025 02:01:02 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eddie James <eajames@linux.ibm.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
        edumazet@google.com, davem@davemloft.net, sam@mendozajonas.com,
        Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: Re: [PATCH] net/ncsi: Fix NULL pointer derefence if CIS arrives
 before SP
Message-ID: <Z4g+LmRZC/BXqVbI@home.paul.comp>
References: <20250110194133.948294-1-eajames@linux.ibm.com>
 <20250114144932.7d2ba3c9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114144932.7d2ba3c9@kernel.org>

Hi Jakub,

On Tue, Jan 14, 2025 at 02:49:32PM -0800, Jakub Kicinski wrote:
> Any thoughts on this fix?

This indeed looks related to what we discussed!

> On Fri, 10 Jan 2025 13:41:33 -0600 Eddie James wrote:
> > If a Clear Initial State response packet is received before the
> > Select Package response, then the channel set up will dereference
> > the NULL package pointer. Fix this by setting up the package
> > in the CIS handler if it's not found.

My current notion is that the responses can't normally be re-ordered
(as we are supposed to send the next command only after receiving
response for the previous one) and so any surprising event like that
signifies that the FSM got out of sync (unfortunately it's written in
such a way that it switches to the "next state" based on the quantity
of responses the current state expected, not on the actual content of
them; that's rather fragile).

Sending the "Select Package" command is the first thing that is
performed after package discovery is complete so problems in that area
suggest that the reason might be lack of processing for the response
to the last "Package Deselect" command: receiving it would advance the
state machine prematurely. It's not quite clear to me how the SP
response can be lost altogether or what else happens there in the
failure case, unfortunately it's not reproducible on my system so I
can't just add more debugging to see all responses and state
transitions as they happen.

Eddie, how easy is it to reproduce the issue in your setup? Can you
please try if the change in [0] makes a difference?

[0] https://lore.kernel.org/all/Z4ZewoBHkHyNuXT5@home.paul.comp/

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

