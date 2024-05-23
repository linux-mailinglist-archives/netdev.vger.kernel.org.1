Return-Path: <netdev+bounces-97722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F88CCE13
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8325F1F210ED
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8546213B2B2;
	Thu, 23 May 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b="aPOfNiqr"
X-Original-To: netdev@vger.kernel.org
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4926413B2A0
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452141; cv=none; b=Pbfoto0cUDZnFjFeLjsGGf/AFsLsxwK1Glrd1tltbzgOZ5Fjy1QZLVIv1GHoSUQeXvCwTK8VheS0Aw+N5Vi6L6M1A7mnqPlKcG7jKGE7jZ0SHiQ96+gwv4JSjLEePp6WpPDp5Rlw2VEKzTKN5yhoq2eRyXdEq7sUgHdCSQyobUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452141; c=relaxed/simple;
	bh=bxUddqk3a4EHLTOx7U3m6dTvxlq9Zw3qmQAtFkrdLBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgUAbSj7unjOzXaMHGiEQ/DiyA+PGg3Fb0Pb9kk39u3eID5FqcAuLYHm53iJgdt0cZQsWQzCcIDXTm/mPv/fI1Cu5uZziR2s21/O7ErcMO1CtqHI/Mlun009PKOIDaXMXd386JuihNy4/zpDaAmzOjk6yULXW3OPxsbb6eM7xxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com; spf=pass smtp.mailfrom=trudheim.com; dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b=aPOfNiqr; arc=none smtp.client-ip=79.136.2.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trudheim.com
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id BAE953F496;
	Thu, 23 May 2024 10:05:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
	dkim=pass (1024-bit key) header.d=trudheim.com
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nsqEyh0V-I3W; Thu, 23 May 2024 10:05:52 +0200 (CEST)
Received: 
	by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 9A3683F422;
	Thu, 23 May 2024 10:05:52 +0200 (CEST)
Received: from photonic.trudheim.com (photonic.trudheim.com [IPv6:2001:470:28:a8::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by trudheim.com (Postfix) with ESMTPSA id 4936713AB202;
	Thu, 23 May 2024 10:05:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trudheim.com;
	s=trudheim; t=1716451549;
	bh=bxUddqk3a4EHLTOx7U3m6dTvxlq9Zw3qmQAtFkrdLBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aPOfNiqr+8bMRp9kTjA2zmiNXQxiguc2rC8LvNC1PNmQ0mpIPbmuXS+nbT3cBZyjl
	 tXgncJ1WB9lLskbXfztI0j/eDjOvsuDUQd0wFwcBM84IrXrVxVkKCTE2zSiQt6pyNs
	 2RZvflSkzbJ2fFf5wApj3QtOyL4V7oSN5YXlZFXE=
Date: Thu, 23 May 2024 10:05:48 +0200
From: Sirius <sirius@trudheim.com>
To: Gedalya <gedalya@gedalya.net>
Cc: netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
Message-ID: <Zk743CuHshWWVJq5@photonic.trudheim.com>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk722SwDWVe35Ssu@photonic.trudheim.com>
Autocrypt: addr=sirius@trudheim.com; keydata=
	mDMEZfWzYhYJKwYBBAHaRw8BAQdA12OXNGLFcQh7/u0TP9+LmaZCQcDJ5ikNVUR6Uv++NQy0HFN
	pcml1cyA8c2lyaXVzQHRydWRoZWltLmNvbT6IkAQTFggAOBYhBP4MEykW8GvNTTxpa4Pq//Pg5C
	PuBQJl9bNiAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIPq//Pg5CPuatYA/3QLv92lC
	7xfhdf7NgmqipA+DXyobhzn9JgwLpRQQcu0AQD77L+EQ3aiyga7NR15r2IRC4DDLFK9Mnsbvi+K
	ZHmdBbg4BGX1s2ISCisGAQQBl1UBBQEBB0AZotbLXS2sTulJhpCsxrd9be2zedV47TV8CInC4nt
	9PQMBCAeIeAQYFggAIBYhBP4MEykW8GvNTTxpa4Pq//Pg5CPuBQJl9bNiAhsMAAoJEIPq//Pg5C
	PubFIA/3d2DFaXz0WJ1zq/tSacU7fckFQ7KFwddlyI7Y+IiosmAQCnBrV+e1iJXnZRSZCGBu+Xt
	BMLXZe+WKVyzQ0/AWV5Ag==
X-MailScanner-ID: 4936713AB202.A38D2
X-MailScanner: Found to be clean
X-MailScanner-From: sirius@trudheim.com

In days of yore (Thu, 23 May 2024), Sirius thus quoth: 
> In days of yore (Thu, 23 May 2024), Gedalya thus quoth: 
> > On 5/23/24 2:39 PM, Sirius wrote:
> > > read what the background is of the console
> > That's COLORFGBG. It is set by some terminal emulators as a way to
> > advertise the colors being used.
> > 
> > I'm no expert but AFAIK there is no uniform way to do this that is
> > supported by all major terminal emulators.
> 
> https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h3-Control-Bytes_-Characters_-and-Sequences
> https://stackoverflow.com/questions/2507337/how-to-determine-a-terminals-background-color
> 
> If you colour the output, then handling the prospect that the background
> might not be the assumed colour kind of comes with the territory.
> Or you deliberately set the background colour to something so that it is
> not undefined. That is what the ANSI colour sequences can do when you use
> strings like \e[32;47m where you deliberately set the background.

https://github.com/dalance/termbg

Someone already did the hard work. Just use that library and you can
detect the background colour or whether a theme is light or dark.

-- 
Kind regards,

/S

