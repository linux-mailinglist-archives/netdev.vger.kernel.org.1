Return-Path: <netdev+bounces-97787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE08CD31B
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35C52852AE
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDEA145B10;
	Thu, 23 May 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b="fIy3KR07"
X-Original-To: netdev@vger.kernel.org
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C24813B7BC
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469344; cv=none; b=p7D4y2e4pGfhruL7M+MwWxbHqlrul4HC7ooHyDJUXlhVALJvY/GJv25gzrurGZ5bWIHsieWxnhxum+ojvSi+debTx6jFaODr5ZxXJNgfyT8VvyLZ+oV7Sis7+XJGiagkXOM6YNFVwGA16bZKYpTTzbLw2GcZXyDaGCCWRVhwf0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469344; c=relaxed/simple;
	bh=3vlQF44J1b4CyBF2yMWkr19UWK9V17ZpghGNzWcchHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyJnSKSfeKbxipCaAL4hr1IRsRXZhGLyEcW5FLfFcG6Qt0LEFI4fVCY6HZoZmqurkvr/JuL+2OCJkboHNKbeiRvvY22qDitlk4sBkPgPXkXgu4yWl6lrh7lmLKazpzFwKZdN3YTlx56ntpmqZLwyhXJ5HyXOAmnt/nKBwoxPXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com; spf=pass smtp.mailfrom=trudheim.com; dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b=fIy3KR07; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trudheim.com
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 73C463F40E;
	Thu, 23 May 2024 15:02:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (1024-bit key) header.d=trudheim.com
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id auOyB8l8Hm1n; Thu, 23 May 2024 15:02:14 +0200 (CEST)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 77F0B3F265;
	Thu, 23 May 2024 15:02:09 +0200 (CEST)
Received: from photonic.trudheim.com (photonic.trudheim.com [IPv6:2001:470:28:a8::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by trudheim.com (Postfix) with ESMTPSA id 8893113B6650;
	Thu, 23 May 2024 15:02:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trudheim.com;
	s=trudheim; t=1716469327;
	bh=3vlQF44J1b4CyBF2yMWkr19UWK9V17ZpghGNzWcchHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fIy3KR07hZoaLr6nWyQVBOeRrvhPDd1jNxHNInuCN4l9fm6f5VViFf4Kr15ZuFj4R
	 79+PTRLF1BsqqXOg5t3xOG0OKUFpapCNjATQtBmMKdC1xU7/nulp+VRhXP3UT8yOP7
	 VW9USk9vwJogX21/H0tka8cn+sjT6hIGbNLgG0Cg=
Date: Thu, 23 May 2024 15:02:06 +0200
From: Sirius <sirius@trudheim.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Gedalya <gedalya@gedalya.net>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
Message-ID: <Zk8-Tq733F8pgMB4@photonic.trudheim.com>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
Autocrypt: addr=sirius@trudheim.com; keydata=
	mDMEZfWzYhYJKwYBBAHaRw8BAQdA12OXNGLFcQh7/u0TP9+LmaZCQcDJ5ikNVUR6Uv++NQy0HFN
	pcml1cyA8c2lyaXVzQHRydWRoZWltLmNvbT6IkAQTFggAOBYhBP4MEykW8GvNTTxpa4Pq//Pg5C
	PuBQJl9bNiAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIPq//Pg5CPuatYA/3QLv92lC
	7xfhdf7NgmqipA+DXyobhzn9JgwLpRQQcu0AQD77L+EQ3aiyga7NR15r2IRC4DDLFK9Mnsbvi+K
	ZHmdBbg4BGX1s2ISCisGAQQBl1UBBQEBB0AZotbLXS2sTulJhpCsxrd9be2zedV47TV8CInC4nt
	9PQMBCAeIeAQYFggAIBYhBP4MEykW8GvNTTxpa4Pq//Pg5CPuBQJl9bNiAhsMAAoJEIPq//Pg5C
	PubFIA/3d2DFaXz0WJ1zq/tSacU7fckFQ7KFwddlyI7Y+IiosmAQCnBrV+e1iJXnZRSZCGBu+Xt
	BMLXZe+WKVyzQ0/AWV5Ag==
X-MailScanner-ID: 8893113B6650.A4609
X-MailScanner: Found to be clean
X-MailScanner-From: sirius@trudheim.com

In days of yore (Thu, 23 May 2024), Dragan Simic thus quoth: 
> On 2024-05-23 09:57, Sirius wrote:
> > Maybe colouring the output by default isn't such a wise idea as
> > utilities reading the output now must strip control-codes before the
> > output can be parsed. Why not leave it as an option via the -c[olor]
> > switch like before?
> 
> How about this as a possible solution...  If Debian configures the
> terminal emulators it ships to use dark background, why not configure
> the ip(8) utility the same way, i.e. by setting COLORFGBG in files
> placed in the /etc/profile.d directory, which would also be shipped by
> Debian?

That makes more sense.

> That wouldn't be a perfect solution, of course, but would be more
> consistent.  Debian ships terminal emulators configured one way, so the
> ip(8) should also be shipped configured (mind you, not patched) the same
> way.

This is a much better argument - Thank you. Something for the
distributions to consider should they turn on the colour by default.

-- 
Kind regards,

/S

