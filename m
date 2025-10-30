Return-Path: <netdev+bounces-234264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E318BC1E53F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 05:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3105B1893695
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EDF2EA143;
	Thu, 30 Oct 2025 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="tZNuh1hb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EFB23B607
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 04:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761797484; cv=none; b=K+LjnNSQ/350XBPEyGmIyBzDLhueiMdbuhnbHeevPkcVpzYQ4gBAUAuPpYI5W0V7z8pVMehAzYzOe/VJUedHq31NqkGuOJ5m47bbLIwlFbSMb30T3s098dIIxQtXRdjIW2Wgne+29RyVylEwkpAKRaJQ70+eiMuiIBsKF1uANoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761797484; c=relaxed/simple;
	bh=wOQEOC2HPRhz/xfy7DQRDA+xMnWo/M0q/ZztPLo/IbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m53EAYnIsD5i3WSWDZMVpN1Zum8QoS7DsD82Gp269eNZhiOqQBWq5vPzoqTw0Sco826q3n4lXyomntDDfezKpXtdlQIO7VmlYRM6lmoJYyfkdWBNtKL9uaDmEBVO6i0S4YX0Y9XDv42YQcxVVq+Fn8Qx+/ph5opG8AE8WHmICxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=tZNuh1hb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so568924a91.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 21:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761797480; x=1762402280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOHF4yRzSI+pLeEyJamn8iNJEDjHjhmR5/cKOdpaYa0=;
        b=tZNuh1hb5VCnPNxSC3QG4xYcew5TnIk7LFjiCof9CMrqv+vPMLka7CpawXX16KzvTW
         VkdF+qiMoVJcq/U5N9ruxFSjq722Ov6PHEv5v0w8Jwu9wDuxe89BrrJddNwAutGjFZQr
         j0adHus8AmittBgluIGKyFP+PCcDcT5SEJaNSHYOfuf2tttajmV7x6cZYw1RJFEgAc0D
         /MfeyszOMTR4q3H0zvKtydEcamTlCrftfZKzinYwgC77rdWIq/ybtpDeo1Qc/8tqZk5M
         cIeGhpo5Gch+Y5LHZdgTwGvgxG+BcKm3PQX/31kMwfePMUJbpK9PNswz0ZgSzjp/YYEX
         P2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761797480; x=1762402280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOHF4yRzSI+pLeEyJamn8iNJEDjHjhmR5/cKOdpaYa0=;
        b=WJzWaYKDj20CK9wCaGu9NELiiInNaSOAkPK285hNQfwxgvTa7yoOHJFE6YrOY1XF0J
         8ARL+STyzLeLqurDtZFrfl/YroRc4iGaqttBHPdBTWrdgpJXm7sp4mVz7I5d+o2gaITg
         ykMe9fGj0heh8m3e6cX4o4kRKr6SDQkCyQ18TwI8fba6eJeQIWeA6mcFjdhlqvwlqIzx
         keUuNRLWp8VXuJL4rY+RQt5RgCoBJpvNjSWe9YKZ/XbOmiDUlype8FKaqZtFv1aC4Tb5
         VJS1kPij1yD83DYtORJb/jseZ925mCYxXXpXKax9SzUIMn9uc8j5y6aFXUSchMBUQJMV
         kKnA==
X-Forwarded-Encrypted: i=1; AJvYcCV/lDxQFbK9sF66lFuwKr4gBnJFKge65WRR5Ijc4G6IJi/iY5zQlPcW87Q/I+fG9nPlWa+fB3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0GxfqFmr/deQ1HvYLaX9/9TNPrhgfgPveebhpQT4/5V3TJ4o
	3GgCnKIfnU9DRXKhgKSM7aABM6WSeDmC5xxmWKuU2Lh/DTeGtctaTvdlSDggtfui4w4=
X-Gm-Gg: ASbGnctY8ktNF3Dd5NmWe4S7KBYefm0GmucuNxfvgOdG09LvcsATNfiBoS0m6bl1Grg
	WKXaYdJCb+8iPbgb6fWNooAyM2SchsLshSqLjGxiTZZeM1QAVuPNMCp/h4ZPyrolvhNgIMYFmjx
	Djw/leWCRH0FM/FmGhyf52PAqCv9llxakZCa7zUv5zQf0dX6ZsJFArntsA5WTqHi1vV01sn9Y1+
	1JCT8f49cYb6l3dm70Fj8td26sUIztFeEjWUbiIFL6e6X5ig6htPJsiUXtuV5bhA8DFZb11S72z
	hSPf3SaOt47xD8FJ7Fy1K1Ec9OjP62r7cSEIkS5tjZDyZFcIkKqXa4c8pWqZqDPbiOIUhtPkr/A
	0fE+lQfkGBRTPN22GPPXr+aNVcA6BI1ywQ2bGHsz2F7rfsgWMisVI3vy/9RoWjdW1TlKMdNDNri
	BuuQ==
X-Google-Smtp-Source: AGHT+IHDYUaQ5wuoTh+R9kqhNVBSoFU5/rnF4NGTpW+M2cfiF1Fjd2rEX75+a3Vq2Fq7YGx3Gi2ewQ==
X-Received: by 2002:a17:90b:1f8e:b0:33b:ba64:8a2c with SMTP id 98e67ed59e1d1-3403a295ad4mr5980624a91.25.1761797480492;
        Wed, 29 Oct 2025 21:11:20 -0700 (PDT)
Received: from essd ([103.158.43.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050b57a0csm835253a91.10.2025.10.29.21.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:11:19 -0700 (PDT)
Date: Thu, 30 Oct 2025 09:41:14 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Simon Horman <horms@kernel.org>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] isdn: mISDN: hfcsusb: fix memory leak in
 hfcsusb_probe()
Message-ID: <2vx2us6bw6vo2oyhu7dzcg2fesaflxz7ndgif7dvyceu6322wz@2g6pmg4jqyjd>
References: <20251024173458.283837-1-nihaal@cse.iitm.ac.in>
 <aQC333bzOkMNOFAG@horms.kernel.org>
 <f2xnihnjrvh6qqqqtqev6zx47pjhxd5kpgdahibdsgtg7ran2d@z6yerx5rddsr>
 <aQJEkvtfmG-sEA3v@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJEkvtfmG-sEA3v@horms.kernel.org>

On Wed, Oct 29, 2025 at 04:45:06PM +0000, Simon Horman wrote:
> 
> Insist is a strong word. But that is my preference.
> Because even for two allocations this is the preferred style
> for Networking code.

Sure I'll update and send a v2.

