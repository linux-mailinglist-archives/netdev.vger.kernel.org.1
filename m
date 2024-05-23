Return-Path: <netdev+bounces-97699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6808CCC72
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 08:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC731C20A78
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 06:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26E13C685;
	Thu, 23 May 2024 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b="VoBkcQVK"
X-Original-To: netdev@vger.kernel.org
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272DEC5
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446918; cv=none; b=HDAY/nbCh28LGu/BmCAv5wjmywmoKa85PbudK9dVKbTfR1CMMrKR3c6L/gHl/nUjtmVgjkuNHU6h5d9D5te+7H2g+m8PN4o9nuwOYW2dYqSBIrxCh0CE1jN38sOBVtqXBt7oRu6hVDvRsp7rFDGVPG/glErDShkUgyS+f3GH/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446918; c=relaxed/simple;
	bh=zsj4Zo+gcnm2Fbjx8fu4XlnNgVixHHqGce4SSfLKHfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks2dOMNyPv/U5B4I5qlfWjJ6RXKnFBVJukN9lBBWBzwKkk4umxe7lZHgkdLA8EzUtF3XQ4UL9qbAajlWPb9X9Dc6dhxQ8/QomqLVN0Th0grVqJ1wulPDsIc7vU3SpwOCoN5DIAkkNBYy2JmaLMpOMWdY/GVdwHsO/jfNcKbdZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com; spf=pass smtp.mailfrom=trudheim.com; dkim=pass (1024-bit key) header.d=trudheim.com header.i=@trudheim.com header.b=VoBkcQVK; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trudheim.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trudheim.com
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id A94283F42D;
	Thu, 23 May 2024 08:39:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (1024-bit key) header.d=trudheim.com
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id etGxyT--jXR2; Thu, 23 May 2024 08:39:11 +0200 (CEST)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id EB53E3F42C;
	Thu, 23 May 2024 08:39:10 +0200 (CEST)
Received: from photonic.trudheim.com (photonic.trudheim.com [IPv6:2001:470:28:a8::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by trudheim.com (Postfix) with ESMTPSA id 431ED13A7E79;
	Thu, 23 May 2024 08:39:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trudheim.com;
	s=trudheim; t=1716446345;
	bh=zsj4Zo+gcnm2Fbjx8fu4XlnNgVixHHqGce4SSfLKHfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VoBkcQVKt7DUgvpmW95IWSo9u8Wfu12ePgKvT8eS+OsOe4X2XHIp+LmhO5RqqCazr
	 Z8kQLpt4pgmVRmWV0nhMIgAVDsx601iWtAp/iySKfmJXg5ce963CwjlXr28VO+uiGb
	 BQ9FHfSxzyFW6knIy4Afgfv6MfEyhwYn+zqY/53M=
Date: Thu, 23 May 2024 08:39:04 +0200
From: Sirius <sirius@trudheim.com>
To: Gedalya <gedalya@gedalya.net>
Cc: netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
Message-ID: <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
Autocrypt: addr=sirius@trudheim.com; keydata=
	mDMEZfWzYhYJKwYBBAHaRw8BAQdA12OXNGLFcQh7/u0TP9+LmaZCQcDJ5ikNVUR6Uv++NQy0HFN
	pcml1cyA8c2lyaXVzQHRydWRoZWltLmNvbT6IkAQTFggAOBYhBP4MEykW8GvNTTxpa4Pq//Pg5C
	PuBQJl9bNiAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIPq//Pg5CPuatYA/3QLv92lC
	7xfhdf7NgmqipA+DXyobhzn9JgwLpRQQcu0AQD77L+EQ3aiyga7NR15r2IRC4DDLFK9Mnsbvi+K
	ZHmdBbg4BGX1s2ISCisGAQQBl1UBBQEBB0AZotbLXS2sTulJhpCsxrd9be2zedV47TV8CInC4nt
	9PQMBCAeIeAQYFggAIBYhBP4MEykW8GvNTTxpa4Pq//Pg5CPuBQJl9bNiAhsMAAoJEIPq//Pg5C
	PubFIA/3d2DFaXz0WJ1zq/tSacU7fckFQ7KFwddlyI7Y+IiosmAQCnBrV+e1iJXnZRSZCGBu+Xt
	BMLXZe+WKVyzQ0/AWV5Ag==
X-MailScanner-ID: 431ED13A7E79.A524F
X-MailScanner: Found to be clean
X-MailScanner-From: sirius@trudheim.com

In days of yore (Thu, 23 May 2024), Gedalya thus quoth: 
> Hello,

Good morning,

> Debian is now building iproute2 with color output on by default. This
> brings attention to the fact that iproute2 defaults to a color palette
> suitable for light backgrounds.
> 
> The COLORFGBG environment variable, if present and correctly set would
> select a dark background. However COLORFGBG is neither ubiquitous nor
> standard. It wouldn't typically be present in a non-graphical vt, nor is
> it presnet in XFCE and many other desktop environments.
> 
> Dark backgrounds seem to be the more common default, and it seems many
> people stick to that in actual use.

FWIW, I use a light background as that is easier for me to read.

Might I suggest that instead of fueling a bikeshed war about what terminal
background should be used, read what the background is of the console and
adapt the foreground colours to that. I would guess that means holding two
sets of the eight colours and if the background is "dark", use the lighter
set and if the background is "light", use the darker set. Then the
variable is superfluous.

Make it usable for everyone rather than just a subset of users based on
personal preference.

> The dark blue used by the ip command for IPv6 addresses is particularly
> hard to read on a dark background. It's really important for the ip
> command to provide basic usability e.g. when manually bringing up
> networking at the console in an emergency. I find that fiddling with
> extra details just to disable or improve the colors would be an
> unwelcome nuisance in such situations, but the Debian maintainer
> outright refuses to revert this change, without explanation or
> discussion.
> 
> Instead the maintainer suggested I submit a patch upstream, which I will
> do. I've never contributed here before, so your patience and guidance
> would be very highly appreciated.
> 
> Ref: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071582

Kudos for that.

-- 
Kind regards,

/S

