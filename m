Return-Path: <netdev+bounces-68908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C83848CDA
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 11:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B171C20CC9
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC59C1B7EA;
	Sun,  4 Feb 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTgMuzAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575831B5B3
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707042586; cv=none; b=AwF7AcMxR8PYu0USzvUFn6IwUDulauF/73HeHkn/l3hWS+MFOU1uUfJaScqLXxkKltstdlOodGxhpYq3yPA0qDAIGYNE8GzkRuFnxrYO5heQCluTEedK8CsCtRvZ7nQ6dgy2Psqj+ETMEG0UHEqxlWIplx6p18IzBQ7SSf+vqQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707042586; c=relaxed/simple;
	bh=5FktPgTh83VcFrtFThf7y8h/rBX6CmWSkHLp+nTa0ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3lRDKUbXKNyIZ3cZdwZeSyYvnasqL2GzjFvkhP7uSBYzoz44KZcEzq4Krs70wzhJkYzOJ5jb03ipBFgmcAMoYCYHBYhsGbcqjhUkfFoQu0PMfeSIQJA5OvLqjOIOH9iaH6ngBcR76KMRvP9jcTNqhTnN52kVJZc5ZEN7kLjCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTgMuzAy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so2828154a12.1
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 02:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707042584; x=1707647384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAoB0K0x3vAp/JNUOh+xfyz+oD4V8OIjTu3tG/9gPd8=;
        b=mTgMuzAyWwXJkT3Wtrf2wefmFhmatGcNv/80wtchKkjlAKdrDbxWgKZJaK0qPVRQ8n
         oSULw3C18w4ogwSG3aBXf9f0Ipn87cwn0v1/pJePIKsa6maBR9qCGLz2nIwxy3p+dpE1
         wkQd73c1PvW1jtgzlIwQtqWxurWjDMP5R3kkokFj502RZg4nb0HJ96zbMLVJU0lGYvXU
         onunVariW36YgAWN8q3rxVDVx8TCVsa6jPSmOReVnKLuOHpLc78k2cKxZG1vBwcO/FNA
         3W8I6noE6g5XRKz2sbnSj5acaz8toU1oQYOawu5JpzvRlDsIaNhYsE6xI2PLXdfQ+q08
         zYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707042584; x=1707647384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAoB0K0x3vAp/JNUOh+xfyz+oD4V8OIjTu3tG/9gPd8=;
        b=d6WLXrLDnXz4USG7HeV5cE906+AXdlKr9XsG6iWDJBPJSKdXmubon9gtMkYxLFYlEV
         Pp+HbvGOP0xzFJgLEeltt85Wex4mhTPLyNQ6TI1AdxRlXpuFcac/7xtfJxR8Vney2j/z
         6vzhVFnKgY5Rr+ajpvdWFRSnLEDPqA6gJioWdEu7nAUjddNw5CR2R1HtRI9vAU28yDTj
         RwaRbr+AgVa+SZlp4s6YfuZaqOygkiUo9rVr+CN+4q5+oPBJe0AOMeWRxFifl9lPVSAt
         AxPqfBsDrDUo+zcyWEYttxal15Fkr/Fdqf2DfrCHVIeOV4WsfH/lIXBNsO5Jc2CLCmbH
         dcVg==
X-Gm-Message-State: AOJu0Ywj7Z4pZWbIR+rpS4Bkiwk0hEF0luRjwECe5/NFpPmDgRh6ndWL
	Gp5p65GfvTcbNRShzCvZrQhsYZeZdnnGIktVYNZ46KkXkUJwCgsE
X-Google-Smtp-Source: AGHT+IEwZNANyTF9r9cPl400pDBB0/HjzYD3oK5S3c+QS1fkw82Ujx9mDnra0hEH2BJa4Gb2yBQj5Q==
X-Received: by 2002:a05:6a20:d90f:b0:19e:510c:ad2e with SMTP id jd15-20020a056a20d90f00b0019e510cad2emr5949063pzb.23.1707042584517;
        Sun, 04 Feb 2024 02:29:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXF0kp2WauoTS076BmFceFBH+qzanQVHllXUOXbXDwfa8rT/atqJrXJQGRNTROnqB2jvlDpsaNhjj8oA/haC5cF2EeW2xPoUzoIR4K0qQ2KM2nUI0i29zp3w8thVxLSOAuKPgfF9OfMA/Njz927Qgu0Ce+85ziQoYA4ODbrjRFLuwdQM6q4RXTnft7S9rA/4XRbZkSzIx7wshVWmDiGZ5DPu0ON9IdeBrFu0qLM40+GaL4FQCtsmOTl5zdTgkszcq7Siiz3aBZr2ZrCNriq4l1UY9g3yW0vOuml1PiFVEmOsHjh1wMm530hKWiAKWWYPZknT6A=
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id sw11-20020a17090b2c8b00b00293d173ccbasm3056858pjb.52.2024.02.04.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 02:29:43 -0800 (PST)
Date: Sun, 4 Feb 2024 18:29:38 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH net-next v3 3/5] net/ipv6: Remove expired routes with a
 separated list of routes.
Message-ID: <Zb9nEkehw-j8s7o6@Laptop-X1>
References: <20240202082200.227031-1-thinker.li@gmail.com>
 <20240202082200.227031-4-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202082200.227031-4-thinker.li@gmail.com>

On Fri, Feb 02, 2024 at 12:21:58AM -0800, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
> can be expensive if the number of routes in a table is big, even if most of
> them are permanent. Checking routes in a separated list of routes having
> expiration will avoid this potential issue.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

FYI, I will wait for David Ahern to help review this patch.

Thanks
Hangbin

