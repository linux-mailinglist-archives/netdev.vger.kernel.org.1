Return-Path: <netdev+bounces-128992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03A97CC99
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 18:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80AAE285E83
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335621A01B8;
	Thu, 19 Sep 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="F81wG8uL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616019CC13
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764197; cv=none; b=TaPOUdD+6KehIur5wBAq5zWg3GrZBGJw5/KfaYKGX1XeRPCY6antXzVrK1MItc812H+0LvfZxuEKm49XdHMnFNt9MSKC6dYSppx22xba5FmvL94QJQ6F7HtHwAS90pjMfs+rANEISIwlX8e0aM51nhVAVhUI+iSDiWwfqnBbnvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764197; c=relaxed/simple;
	bh=suEUXjtwH5yj3P21zQ/E2dBOux0/GXJ+gwUGxl/d6Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bb1spGVwb47picLWSin/A6XMMc0kcmIs05F731LXTfDyhAai/XBnq3sbw3xNUtneTCn9fHD+TwQVxdwojZEMA7tBAGuMx74IownN4Yq0JGBXvIIxILzvymytOwP7WN3coqP1Io1VY0N6KxUxLfr5WxUJmexY/5jP1kNxDgjlQow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=F81wG8uL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e56d7469so758278b3a.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726764194; x=1727368994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3OeaOm3R1sGzp7uW3d49gJuf1EAjol71BtaCns8yVg=;
        b=F81wG8uLDjADXhEh2hVU7Y5Xmh4guiS0cFFsBR4Bw/QoGTjhyFUTzFRMJxJ9f0QneN
         HwkqaZXjJJ47asEXR0PdyEdr2DxGyWEIHBl3AyKViEODeDkYATShmTTxiIg3TsIX25F7
         qCKGR3wXF0zMd4sIGOQugS+2SM0HVmJeZxlYbpv33r/ovlgHInCMz1qekWr1OL0Hi0cH
         ZhBH3HJqBwhSGS/h4fbjvaxL9rh3/eeM7TsReWtTCHxsMVB7gDdrZJUo9ObAJf2GP7qr
         mFpgfrP+U4apAq5umSoCK3ZYeoDOjGuQ47PY9t+HvzEgNOQC+UVjHbnoMexy43jEq8Ow
         lbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726764194; x=1727368994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3OeaOm3R1sGzp7uW3d49gJuf1EAjol71BtaCns8yVg=;
        b=QUVabVAjKSNpNHXdKLkY896fVY6SiV3PUh39btA73UMMlzyZev2nwJNrYs/Y5Lneob
         Mo6ZVmVm4o9paeWHTiblpFksGWPK5J6fti9gywaIE43rOPboNwRFJUJK5J6Qm93cGTYM
         p27UvhSFVp022VkcR3iDkLkAMFlCI/jNVoPlV7aX/veGnhAk6OLfsN2RMr9/hMahyG89
         mE4nV8+m0UOiBNkfnWtDfNG3C9FnWyT80Sau1cv/L955VfIIOv5FCKwwz/ICd7FjTajL
         axF/65NdHp/zZhXZJyk3utzy5+c+6B/zv7rwaAWIg22JOzxKL5H1TsH2zlrQ6p5U7ari
         qZpQ==
X-Gm-Message-State: AOJu0YwtA2+6obHZdKfPGIIxvpxf2+WA1rsv+P8+jEF66t4TzQacVXmn
	xYN34vD4diJxJWocBtnMVGJi4xxc4IAZGN901ZBQhyRgjLcLxpEp6I0rzo3ICbLm2raNSrvh1kh
	4
X-Google-Smtp-Source: AGHT+IGVQz4XGXnrXeoPYySrrEQ2ci8vRtDX2dmMd7UO5rmxun/US+JWqNOwwDWaCqF7rHfgVZg3sw==
X-Received: by 2002:a05:6a00:997:b0:719:20b0:d041 with SMTP id d2e1a72fcca58-71936a49390mr36164238b3a.10.1726764193857;
        Thu, 19 Sep 2024 09:43:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944baf04dsm8753692b3a.174.2024.09.19.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 09:43:13 -0700 (PDT)
Date: Thu, 19 Sep 2024 09:43:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org
Subject: Re: Dealing with bugzilla
Message-ID: <20240919094312.1d0d4b87@hermes.local>
In-Reply-To: <20240919161709.GA18875@breakpoint.cc>
References: <20240919091046.64cb49b6@hermes.local>
	<20240919161709.GA18875@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 18:17:09 +0200
Florian Westphal <fw@strlen.de> wrote:

> Stephen Hemminger <stephen@networkplumber.org> wrote:
> > Up until now, I have been the volunteer screener of networking related bugzilla bugs.
> > I would like to get out of doing that.  
> 
> Understandable, thanks for doing all the prefiltering work all these
> years!
> 
> > The alternatives are:
> >    1. Change the bugzilla forwarding to netdev@vger.kernel.org (ie no screening)  
> 
> "OH NEIN !!!11"
> 
> >    2. Get a new volunteer to screen  
> 
> Even if someone would volunteer I don't think it would be good to have
> this burden on one person alone.
> 
> >    3. Make a new mailing list target on vger (ie netdev-bugs@vger.kernel.org)  
> 
> I'd go for 3) and see how that works out.
> 
> >    4. Find someone to make a bot to use get_maintainer somehow to forward  
> 
> I'd say 3, then see if it can be refined somehow.
> 3) would also allow to get an impression on the volume, the signal/noise ratio etc.
> 
> >    5. Blackhole the bugzilla reports.
> >    6. Bounce all the bugzilla reports somehow.  
> 
> 5 & 6 are worse than 7), which would be to close bugzilla
> and keep it readonly archive.

Volume is about 1 report every 2 weeks with about 10% dropped.
Most of the drops are because the report is for an vendor kernel which is tainted
or end of life.

