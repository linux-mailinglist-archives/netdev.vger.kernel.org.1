Return-Path: <netdev+bounces-97807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1EF8CD567
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6505283FFB
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B276113C68A;
	Thu, 23 May 2024 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b="JwCUwr7g"
X-Original-To: netdev@vger.kernel.org
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583A67FBD2
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473512; cv=none; b=A2oPHnJhgRDIZrnyDBpN4G27FOvWNMfpRIraXzUgxCZ2b4LbV22JCzNFCodWvc18po4xL6fMd3D+KkvIjpbash5EfmSLZCzZsqUW05F1DfrMDp/uiEOXX1RMZrFqM1iBCA7ysHUuqQ2Ruu8DviJoFDKgJAcTpM86gDiEKNDepSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473512; c=relaxed/simple;
	bh=CoZ6hkeGPQ684Hjq4V5WM8hzBykOFWa4rgX8z02U0IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxFhiCtnvwp3rxWq/mO9eXyEM4tkfOloyh4vMQSeRiNJTUnbnbRC4aUkemf94Ti4wnbqlagVlCDiVZNH3CCAfMh7qiglaaDmiNrbhY1IKLr8uKE7XMtp0Pq3/t8z0Rvalj4ND9ULTze8kyGLm/gj7FRh2drfIfBpx7rAF+Cv/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com; spf=pass smtp.mailfrom=trudheim.com; dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b=JwCUwr7g; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trudheim.com
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 3BFCA3F5EA;
	Thu, 23 May 2024 16:11:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (1024-bit key) header.d=trudheim.com
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QXfpofC__X2h; Thu, 23 May 2024 16:11:43 +0200 (CEST)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id F36B93F4C1;
	Thu, 23 May 2024 16:11:40 +0200 (CEST)
Received: from photonic.trudheim.com (photonic.trudheim.com [IPv6:2001:470:28:a8::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by trudheim.com (Postfix) with ESMTPSA id E501A13B9166;
	Thu, 23 May 2024 16:11:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trudheim.com;
	s=trudheim; t=1716473497;
	bh=CoZ6hkeGPQ684Hjq4V5WM8hzBykOFWa4rgX8z02U0IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JwCUwr7gkZ7X7Mb6cxW2CUeNdbqH5lZZi3SdhBJFzsspSSRrCfxCPUuHB5sAxwGEv
	 eGzD5iJ+CCJLF+yUk8UqtGNWJDp9Wgv8zcgXOKRUkbp3nCALFFIImp/N7f690y2O5e
	 NBFk17K+LxCFPrtGk0qH+UA4kqRjMExQwzBEX83Q=
Date: Thu, 23 May 2024 16:11:36 +0200
From: Sirius <sirius@trudheim.com>
To: Gedalya <gedalya@gedalya.net>
Cc: Dragan Simic <dsimic@manjaro.org>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
Message-ID: <Zk9OmHeaX1UC8Cxf@photonic.trudheim.com>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
 <7cfcca05-95d0-4be0-9b50-ec77bf3e766c@gedalya.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cfcca05-95d0-4be0-9b50-ec77bf3e766c@gedalya.net>
Autocrypt: addr=sirius@trudheim.com; keydata=
	mDMEZfWzYhYJKwYBBAHaRw8BAQdA12OXNGLFcQh7/u0TP9+LmaZCQcDJ5ikNVUR6Uv++NQy0HFN
	pcml1cyA8c2lyaXVzQHRydWRoZWltLmNvbT6IkAQTFggAOBYhBP4MEykW8GvNTTxpa4Pq//Pg5C
	PuBQJl9bNiAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIPq//Pg5CPuatYA/3QLv92lC
	7xfhdf7NgmqipA+DXyobhzn9JgwLpRQQcu0AQD77L+EQ3aiyga7NR15r2IRC4DDLFK9Mnsbvi+K
	ZHmdBbg4BGX1s2ISCisGAQQBl1UBBQEBB0AZotbLXS2sTulJhpCsxrd9be2zedV47TV8CInC4nt
	9PQMBCAeIeAQYFggAIBYhBP4MEykW8GvNTTxpa4Pq//Pg5CPuBQJl9bNiAhsMAAoJEIPq//Pg5C
	PubFIA/3d2DFaXz0WJ1zq/tSacU7fckFQ7KFwddlyI7Y+IiosmAQCnBrV+e1iJXnZRSZCGBu+Xt
	BMLXZe+WKVyzQ0/AWV5Ag==
X-MailScanner-ID: E501A13B9166.A5D06
X-MailScanner: Found to be clean
X-MailScanner-From: sirius@trudheim.com

In days of yore (Thu, 23 May 2024), Gedalya thus quoth: 
> On 5/23/24 9:23 PM, Dragan Simic wrote:
> > > And what about linux virtual terminals (a.k.a non-graphical consoles)?
> > 
> > In my 25+ years of Linux experience, I've never seen one with a
> > background
> > color other than black.
> 
> You kind of missed my question: Do we make a new rule where a correctly
> set COLORFGBG is mandatory for linux vt?
> 
> That's what I meant. The fact that both vt and graphical terminal
> emulators tend to be dark is another point.
> 
> My point is you can't rely on COLORFGBG. You can only use it if/when set.
> 
> A reasonable default is needed.

For the colours like blue and magenta, using \e[34;1m and \e[35;1m would
make it more readable against dark background. And testing with a dark
background right now, that would suffice the other colours are not
problematic to read. (It uses the "bright" version of the two colours
rather than the usual.)

That would be a miniscule change to iproute2 and would resolve the
problem no matter what background is used. I need to test with schemas
like solarized light and dark as well, as they are finicky.

-- 
Kind regards,

/S

