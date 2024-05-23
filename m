Return-Path: <netdev+bounces-97794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F228CD3FB
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5A8285621
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997A214B95B;
	Thu, 23 May 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b="gVRNPmJr"
X-Original-To: netdev@vger.kernel.org
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E814A4FF
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470409; cv=none; b=PrDfEMyX5OJuN8qw5AmvZExZLUFTiOioYbZcTUOwkiJmB6dkQYKRxGkWSfluKIpmbu2uOyu+OXK7ysCQ8ngqmGoM+J8AhGGX1UNHBj2L7MErniOfeHdrgNXgMJp9gAlnkhBqKucyjkmk7sGQNMwrnTz33D+YeuZ3KxO/x4zK1fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470409; c=relaxed/simple;
	bh=9AElXtsEgsyUytkFmE/oFMbshBvRTekdYNMmzobCvbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1g1JtBIX1ERwuNVJau1FGnZq9UG3J//6w5g2POEaBag0P5qrCXLtaoUKudk5IwElv84ibrIvL647xuzq+TTw4Ow86fIOTKLTj7SE0amg5Y9sX0NkUK9FYZ65nCKA/LoPYRyT2J2LnWM5m/ej616oklCbjdoe3rX4UhMjWl1wWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com; spf=pass smtp.mailfrom=trudheim.com; dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b=gVRNPmJr; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trudheim.com
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 03F943F932;
	Thu, 23 May 2024 15:20:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (1024-bit key) header.d=trudheim.com
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g8kqtkSDln1F; Thu, 23 May 2024 15:20:01 +0200 (CEST)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 5E5783F7D7;
	Thu, 23 May 2024 15:19:58 +0200 (CEST)
Received: from photonic.trudheim.com (photonic.trudheim.com [IPv6:2001:470:28:a8::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by trudheim.com (Postfix) with ESMTPSA id 2AD2013B71B5;
	Thu, 23 May 2024 15:19:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trudheim.com;
	s=trudheim; t=1716470395;
	bh=9AElXtsEgsyUytkFmE/oFMbshBvRTekdYNMmzobCvbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gVRNPmJrd9xtMxb4wZZbneKLd87cVnw7+3h3X2hC/OdcnJYjCsjJqQ90JghEXCIfY
	 FfgdUs1AS7RHJ2nUfcHrW5dHe/fOqg/9EiHv3Jc1c+x/bXooj+W2DByD3Fk/fOT522
	 lQboLn7dsaMAlAFoqWM61WzVTIY1ufPlEoh/WWLk=
Date: Thu, 23 May 2024 15:19:54 +0200
From: Sirius <sirius@trudheim.com>
To: Gedalya <gedalya@gedalya.net>
Cc: Dragan Simic <dsimic@manjaro.org>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
Message-ID: <Zk9CehhJvVINJmAz@photonic.trudheim.com>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
Autocrypt: addr=sirius@trudheim.com; keydata=
	mDMEZfWzYhYJKwYBBAHaRw8BAQdA12OXNGLFcQh7/u0TP9+LmaZCQcDJ5ikNVUR6Uv++NQy0HFN
	pcml1cyA8c2lyaXVzQHRydWRoZWltLmNvbT6IkAQTFggAOBYhBP4MEykW8GvNTTxpa4Pq//Pg5C
	PuBQJl9bNiAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIPq//Pg5CPuatYA/3QLv92lC
	7xfhdf7NgmqipA+DXyobhzn9JgwLpRQQcu0AQD77L+EQ3aiyga7NR15r2IRC4DDLFK9Mnsbvi+K
	ZHmdBbg4BGX1s2ISCisGAQQBl1UBBQEBB0AZotbLXS2sTulJhpCsxrd9be2zedV47TV8CInC4nt
	9PQMBCAeIeAQYFggAIBYhBP4MEykW8GvNTTxpa4Pq//Pg5CPuBQJl9bNiAhsMAAoJEIPq//Pg5C
	PubFIA/3d2DFaXz0WJ1zq/tSacU7fckFQ7KFwddlyI7Y+IiosmAQCnBrV+e1iJXnZRSZCGBu+Xt
	BMLXZe+WKVyzQ0/AWV5Ag==
X-MailScanner-ID: 2AD2013B71B5.A3FD9
X-MailScanner: Found to be clean
X-MailScanner-From: sirius@trudheim.com

In days of yore (Thu, 23 May 2024), Gedalya thus quoth: 
> Yes, echo -ne '\e]11;?\a' works on _some_ (libvte-based) terminals but not
> all. And a core networking utility should be allowed to focus on, ehhm,
> networking rather than oddities of a myriad terminals.

Then it perhaps should not add colour to the output in the first place and
focus solely on the networking.

A suggestion would be the iproute2 package revert the option to compile
colourised output as default, sticking to plain text output as that
require zero assumptions about the user terminal. Carry on offering the
'-c' switch to enable it at runtime.

-- 
Kind regards,

/S

