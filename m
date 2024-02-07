Return-Path: <netdev+bounces-69864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DC684CD93
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A775D28319D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5B55A118;
	Wed,  7 Feb 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QeD8NyS8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339687E77F
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318186; cv=none; b=rC+MJsrle4x6ZHqF8U9M00AcN1iXJOfewClbbjJjdidiyw6qtEBHgEFiqmKjZVyk8AvmJifAeNHaqE2DkcFX3FUhlHv4HFvqIJrpkQqqCSOIXz3N9aDaNvazpuvLKGybpPXkSxVetwZ3MHwOQ+0u0JgYX5sYcqT/sWROMTlseg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318186; c=relaxed/simple;
	bh=qj4sBKquNJsa6JjdBukWFgRky9J6PjC1lcEC2PLxRJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNTL8ntv+VhAsoU9Tkx+Zb5cMJdUtBu0J0g+fjO2VUXduPLy+H96mYzAyCeJxhVyvN57I7Lg0mj1LPHRD9M9jn8PDTDOVzMp486fI0W3lkh4BrdhUbIf7iWMQAkiFO3bghrDBorVITCpQ6YmPRBJorOOu8qYrcq5A4EIg0NsIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=QeD8NyS8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e065098635so516207b3a.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 07:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707318183; x=1707922983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj4sBKquNJsa6JjdBukWFgRky9J6PjC1lcEC2PLxRJo=;
        b=QeD8NyS8AH2Y7jqs74s/hoD8/WreEMEWxgWwg3nXUZhnHjyUkYwUPWaUo3qoeKLJ5t
         KDqdQRiJBdYVO2aLExvoF2u3aP5vHreYBOfR82BnBah2VkhHb1GwIytB8i4qcD5YUUbn
         36oZFrP/i4+TJocoELZsK1Bd8Jm8I+7crgoPJ3UtAVqbc7P171PMYiv7JutnypS43DTX
         0Rkf2+H9Pl2Y4CQvd+anaMTBM9Nd4297isL6+nr6D9+YrPE8rXzL1xS3EIR0izaSGy9L
         Dcmth7gWuBCEeF1r3dY/UeNooVy3bRU4ZqJiCZdYu63dGkFJxkqhouQFzcUQCqqtkKZ5
         pGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318183; x=1707922983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qj4sBKquNJsa6JjdBukWFgRky9J6PjC1lcEC2PLxRJo=;
        b=AW2+cNwhVEfnD5duKTpIzqbkfMskj3kRSKXI0C9Ky94bwZfLHvhU0mm/02JRLKmJsa
         LJbXrYFxTSvgKFtp/cDZrZxKcDjFaI8v97jJtQGWBxwcGnWgLeMUxtTUxk0A2UXKMqmq
         tLmLUWjaQxpmH+UATmVRVT1xwm9Dc8f8mjUkBUUnGfdOMZepGdgYXcpgRP6VDZkNWPBU
         mMld/6KmmmGVt/NIfaiqGwNnJr7NchDhUil1KSCNXtynnI3p0H35jN6ZtF1JWYOZtD0d
         QgOcCRcmIJ/SN31tKOC98vuo0c6CP6IRHgFPv5tQImqXjep46d/Aw4pWmn8PTOREOXbq
         bZfA==
X-Forwarded-Encrypted: i=1; AJvYcCWQfuy+VKUCBN5U2imKcy+vkV1sLNVFGcmu/bLeV9W875SwZdzbKIdojjNtnnaAnmp8foKjtuw+MZdF6Hyt9b3EUCcG1tNc
X-Gm-Message-State: AOJu0YxUSdnOo++kK1J1tewTjSSz99PZgt/p3ee5i2F0fmvLuIPH7DRB
	0ka2AevIj03wO4lLuPlo+O9M7wkC4mKA2ErSWWkKZBoIDabqrXSEaXMxEl7x/jw=
X-Google-Smtp-Source: AGHT+IHbN4vbIcsgi4bVcxp+6A8g0KI7mqKgCobm5KY5ELFhbrXQy36Lctlwxb4A8K+1bnpxDt1K7g==
X-Received: by 2002:a05:6a20:d90e:b0:19e:9bcb:9344 with SMTP id jd14-20020a056a20d90e00b0019e9bcb9344mr5793288pzb.53.1707318183322;
        Wed, 07 Feb 2024 07:03:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEs3KDwCb+/+DbWUspqQlq1t3VVCTCgBXdrb3GVQpou2fgeIQy1Ni9oojRcdijV51y0+Pt2WGQB7dm+6oL1NR5nmL13nkJMJF/C4w1rN/asNLO9U9iMZ3p8bI=
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id l185-20020a6325c2000000b005dc19ac7162sm1652953pgl.3.2024.02.07.07.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:03:03 -0800 (PST)
Date: Wed, 7 Feb 2024 07:03:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dave Taht via Bloat <bloat@lists.bufferbloat.net>
Cc: Dave Taht <dave.taht@gmail.com>, Michael Welzl <michawe@ifi.uio.no>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: [Bloat] Trying to *really* understand Linux pacing
Message-ID: <20240207070301.30c92e23@hermes.local>
In-Reply-To: <CAA93jw6di-ypNHH0kz70mhYitT_wsbpZR4gMbSx7FEpSvHx3qg@mail.gmail.com>
References: <1BAA689A-D44E-4122-9AD8-25F6D024377E@ifi.uio.no>
	<CAA93jw6di-ypNHH0kz70mhYitT_wsbpZR4gMbSx7FEpSvHx3qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 07:05:27 -0500
Dave Taht via Bloat <bloat@lists.bufferbloat.net> wrote:

> I also tend to think that attempting it in various cloudy
> environments and virtualization schemes, and with certain drivers, the
> side effects are not as well understood as I would like. For example,
> AWS's nitro lacks BQL as does virtio-net.

FYI - Microsoft Azure drivers don't do BQL either.
Both netvsc and mana.

The problem is that implementing BQL is not as easy as it looks
and has possibility of introducing bugs. One big customer with a stuck
connection totally negates any benefit!

For virtio, there have been several attempts at BQL and they never worked
perfectly.

