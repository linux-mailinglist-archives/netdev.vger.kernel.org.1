Return-Path: <netdev+bounces-97721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D58CCDEB
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5971F23B8A
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F348E13CF8F;
	Thu, 23 May 2024 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b="vyZICMfT"
X-Original-To: netdev@vger.kernel.org
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3313CF93
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451591; cv=none; b=gx7Ec7aHPNpLWyvZ0abx6RF1b4Cv48Vezj8kNnc/GZofayU7ujVB5hPPFNGGUhptgUOJT2N+k2+wAJKksRY4OJHWmHFLaTjTuuJkhizP6G/hMQhyw9NX9Z1/qenSQM7iNV5bC+4Ri7OM6vqCuvLj1jQJZ2EWxc3oagHVLiZtJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451591; c=relaxed/simple;
	bh=xA5TC7xYG4OxQFu8rvfLw8ItErRw1z3G8QAEJMU11lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIEKS223Iex6FggRnEGEWVp5eYyN1H+39V1+V1r3UrNXqrxliFc1b2WDwEYgEI7L2tp97H1GP/AasbLVpIf3A/fSbJypwgz34AlFs2nc/N3jj2w2/aivuZowWai2yc5RgGNnaR6oGS1U/W41hGxg0e8cMA/lVAbm4cUMS2p+e8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com; spf=pass smtp.mailfrom=trudheim.com; dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b=vyZICMfT; arc=none smtp.client-ip=79.136.2.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trudheim.com
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 429773F570;
	Thu, 23 May 2024 09:57:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level:
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (1024-bit key) header.d=trudheim.com
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4wLo60M0f-cp; Thu, 23 May 2024 09:57:20 +0200 (CEST)
Received: 
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 8777D3F385;
	Thu, 23 May 2024 09:57:19 +0200 (CEST)
Received: from photonic.trudheim.com (photonic.trudheim.com [IPv6:2001:470:28:a8::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by trudheim.com (Postfix) with ESMTPSA id 6B35513AABE0;
	Thu, 23 May 2024 09:57:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trudheim.com;
	s=trudheim; t=1716451034;
	bh=xA5TC7xYG4OxQFu8rvfLw8ItErRw1z3G8QAEJMU11lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vyZICMfT3OJId2wf9yFPbJnxoV+mSflh/iirpTNdzp/37Q2pjlqPDV0UpgoMSfw0c
	 ouMqlUeNAnEW7HbFujq8cKpj5NGJ6Z+fO2uUDHhE7ZySdbHtJzNgBFOwqIfXbTJfT4
	 mkuLLjq9neGSzKBWkKGpULq8aSX4MqramFq4AW8w=
Date: Thu, 23 May 2024 09:57:13 +0200
From: Sirius <sirius@trudheim.com>
To: Gedalya <gedalya@gedalya.net>
Cc: netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
Message-ID: <Zk722SwDWVe35Ssu@photonic.trudheim.com>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
Autocrypt: addr=sirius@trudheim.com; keydata=
	mDMEZfWzYhYJKwYBBAHaRw8BAQdA12OXNGLFcQh7/u0TP9+LmaZCQcDJ5ikNVUR6Uv++NQy0HFN
	pcml1cyA8c2lyaXVzQHRydWRoZWltLmNvbT6IkAQTFggAOBYhBP4MEykW8GvNTTxpa4Pq//Pg5C
	PuBQJl9bNiAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIPq//Pg5CPuatYA/3QLv92lC
	7xfhdf7NgmqipA+DXyobhzn9JgwLpRQQcu0AQD77L+EQ3aiyga7NR15r2IRC4DDLFK9Mnsbvi+K
	ZHmdBbg4BGX1s2ISCisGAQQBl1UBBQEBB0AZotbLXS2sTulJhpCsxrd9be2zedV47TV8CInC4nt
	9PQMBCAeIeAQYFggAIBYhBP4MEykW8GvNTTxpa4Pq//Pg5CPuBQJl9bNiAhsMAAoJEIPq//Pg5C
	PubFIA/3d2DFaXz0WJ1zq/tSacU7fckFQ7KFwddlyI7Y+IiosmAQCnBrV+e1iJXnZRSZCGBu+Xt
	BMLXZe+WKVyzQ0/AWV5Ag==
X-MailScanner-ID: 6B35513AABE0.A4B04
X-MailScanner: Found to be clean
X-MailScanner-From: sirius@trudheim.com

In days of yore (Thu, 23 May 2024), Gedalya thus quoth: 
> On 5/23/24 2:39 PM, Sirius wrote:
> > what terminal background should be used,
> It's not about prescribing what should, but about guessing what is, when that is not explicitly stated. The only "right" way to guess is to always choose what is more probable (common, in this case).

Appeal to authority.

> > read what the background is of the console
> That's COLORFGBG. It is set by some terminal emulators as a way to
> advertise the colors being used.
> 
> I'm no expert but AFAIK there is no uniform way to do this that is
> supported by all major terminal emulators.

https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h3-Control-Bytes_-Characters_-and-Sequences
https://stackoverflow.com/questions/2507337/how-to-determine-a-terminals-background-color

If you colour the output, then handling the prospect that the background
might not be the assumed colour kind of comes with the territory.
Or you deliberately set the background colour to something so that it is
not undefined. That is what the ANSI colour sequences can do when you use
strings like \e[32;47m where you deliberately set the background.

> > adapt the foreground colours to that. I would guess that means holding
> > two sets of the eight colours and if the background is "dark", use the
> > lighter set and if the background is "light", use the darker set.
> 
> That's what iproute2 currently does.
> 
> In fact this can't be adequate. You can't turn the question of best
> contrast against 16(million?) different colors into a binary. But this
> is a simple CLI command, not a full-screen productivity app.

If the background as read from terminal is > 127 it is "light", if it is <
127, it is "dark".

Xterm, the sequence \e]11;?\a will give you the background colour, zutty
does too, urxvt does not.

Maybe colouring the output by default isn't such a wise idea as utilities
reading the output now must strip control-codes before the output can be
parsed. Why not leave it as an option via the -c[olor] switch like before?

-- 
Kind regards,

/S

