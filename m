Return-Path: <netdev+bounces-237195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A855C471E3
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69FFC4E5CA1
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4D031282C;
	Mon, 10 Nov 2025 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QshNdn8y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCD3126C4
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784042; cv=none; b=EdCyOaOEb+Lk7qkN8KhdmfSSfTS0RlBLp69Et1RSLdALLRvbPlXikf5KbAfx9TeZTgHySaIMqgacfetZmZ59p5GZAaHzTG/K42qMwc8MQJZkKkcE7HHUyZNbWbVLM1ndaNas4sx1K+VSDSCOwSdwZTmyvmJTNiPMTn606AWxSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784042; c=relaxed/simple;
	bh=nhj3Igbx12WySTAs3L6CZE8fbVP3gkRxrlKpU0V1S2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVSQK9owGhDX42PpMr9b54qFYH6fUliH/0VQB9LWUpdSGB2togbabMyQvtz9j7/1geqVQpUzzghoxurhO4eui2Qx4dyCQYohejQkjbPBZMz3FK1D2aNiMwDVtwTWL4sCOiilzcJyfrajHUaUKTthRW2LqPMtvfg0/c8x3isbGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QshNdn8y; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b7277324204so530139866b.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 06:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762784039; x=1763388839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYf9FpLZWUf42lAhUlxsk+V48xYQlFSQ2G8JV6jPPvE=;
        b=QshNdn8yQ7FchSFTx7qcHFGVopt7Fd31yJBamIE8scdUsKrK/Dl1wesxzuiw1aqwxw
         fA/KZZckMgyCowdFY8JB/HTMTraHBXYKDxp3G0h4p8MwKLJKR5gD8iuVHN0pF642sdZe
         35kwMDAl2kDoP9y0NDtIAln4A7XoOOIzGpAGgABYPj58EL6qhnVIyeyRjKWvq3jb/i/0
         v1SPcux9ZbAl7ofXlfFewNgib5lDR7/+CHOxRVJMToN5jiokP/6QbncOOyYPgBILY3s7
         8yMZZnIFGt0Fyiz4VYERDzIaYTR6O1a0NTGIn7nus2e95TP3UtcrIGYg0nAjFpqxtAxQ
         eBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762784039; x=1763388839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYf9FpLZWUf42lAhUlxsk+V48xYQlFSQ2G8JV6jPPvE=;
        b=jEhVIKwCb9vtJklRVYejJj94xn/mU/O16cJpPVZxOFIhwZsCDtPuDUWPD55C+dEXGT
         mIqUiRZ5T+Lk1+V83kNgD7Dx8CbTJ7Yq2yO3BIRWCiIg6r78Dn7jYjyyKnyBSIEwRQ7y
         WKx0jcw4US7u9Rdpm6PB+6Iix0aUFrmjJIR1JjpnXpFAsx23lzNnEiSrmPvArteIJSl3
         ehOlo+33VKVNkqprRiy2IZGCJKHqFM322Xns/nZy3ydfuag9qupXQYJKHQLG12uTEc69
         PBgADgAjcHGgVlImr28syQcjNP7hxa7UhvqBQAg9gviQE6xaJQ+Hk7GASxdzKRUcg46f
         qGBw==
X-Forwarded-Encrypted: i=1; AJvYcCXlsw5udHYI9fpstF62E0YI/N7l06Zo4nw9PqXpK9FDgsHzxm52/4prqJ8ESuiodGQvMGqWYsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGlZcHokSuYxVNrQ54lP1pu5oeOXkaNMODKBM1Vm9u8n+BsBW
	KIAyrleSiDi9adYb+sGT4wPUkQbosMs18oGpvPG8BZ9Xto7+sYs8cCms5yC+7k0QUgc=
X-Gm-Gg: ASbGncs7o5ddS0wGbh2jY6rbiIJK6mImBrvR5/FMkLJD9sxild4G8xfc8CSY7uJntP8
	6t6N528Dlr3hkUylM9LxUWufbkO0sQAiTZDmBhOBcVYdxTgZtkdpw0XP2cz6NH68MV6jQNmFTjy
	NYzEQVOVDNYv4WGaqmRbabWsWGXpXQinoKjbdm3S8MrfMhOG3MpEwVdzDfuMxHsyP07epIIQDTu
	vIoQaTjpRwh8mtKGDrixhhql3uwQt6mEXf2lyNl7gjRj/iBxu4KLvH8W62hRvxyYZFQ+kegauUo
	ns16PZ75frrXcEdxRdEb1ud7HCh6LKce6ju1kfg5AffX+16c4dddmdEuMSJnraAgNMAP0KXzcSa
	E0y0qjNkj+Ls/QFpQM89jRZcotANOfwjDPBc2nN/7DwNgKwne4A7v9KXC2HuXIe1EHJerw5IEUG
	sDuvc=
X-Google-Smtp-Source: AGHT+IFWGbbWVSdwsSwRLLUACXXxYZpMnpmrI0HtAU0yQT12wD1kfbTgpMWg/xPH1FaG58xVuN8lew==
X-Received: by 2002:a17:907:a0c8:b0:b3f:9b9c:d49e with SMTP id a640c23a62f3a-b72e053f2b5mr824285466b.57.1762784039128;
        Mon, 10 Nov 2025 06:13:59 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf407a01sm1105466366b.22.2025.11.10.06.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:13:58 -0800 (PST)
Date: Mon, 10 Nov 2025 15:13:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Junrui Luo <moonafterrain@outlook.com>,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, tiwai@suse.com,
	perex@perex.cz, linux-sound@vger.kernel.org, mchehab@kernel.org,
	awalls@md.metrocast.net, linux-media@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <aRHzJIFkgfHIilTl@pathway.suse.cz>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
 <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
 <20251107091246.4e5900f4@pumpkin>
 <aQ29Zzajef81E2DZ@smile.fi.intel.com>
 <aQ3riwUO_3v3UOvj@pathway.suse.cz>
 <20251107175123.70ded89e@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107175123.70ded89e@pumpkin>

On Fri 2025-11-07 17:51:23, David Laight wrote:
> On Fri, 7 Nov 2025 13:52:27 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Fri 2025-11-07 11:35:35, Andy Shevchenko wrote:
> > > On Fri, Nov 07, 2025 at 09:12:46AM +0000, David Laight wrote:  
> > > > On Thu, 6 Nov 2025 21:38:33 -0800
> > > > Andrew Morton <akpm@linux-foundation.org> wrote:  
> > > > > On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:  
> > > 
> > > ...
> > >   
> > > > That is true for all the snprintf() functions.
> > > >   
> > > > > I wonder if we should instead implement a kasprintf() version of this
> > > > > which reallocs each time and then switch all the callers over to that.  
> > > > 
> > > > That adds the cost of a malloc, and I, like kasprintf() probably ends up
> > > > doing all the work of snprintf twice.
> > > > 
> > > > I'd be tempted to avoid the strlen() by passing in the offset.
> > > > So (say):
> > > > #define scnprintf_at(buf, len, off, ...) \
> > > > 	scnprintf((buf) + off, (len) - off, __VA_ARGS__)  
> > 
> > It does not handle correctly the situation when len < off.
> > Othersise, it looks good.
> 
> That shouldn't happen unless the calling code is really buggy.
> There is also a WARN_ON_ONCE() at the top of snprintf().

Fair enough.

BTW: I have found there exists a userspace library which implements
this idea, the funtion is called vsnoprintf(), see
https://arpa2.gitlab.io/arpa2common/group__snoprintf.html

I know that it is cryptic. But I like the name. The letters "no"
match the ordering of the parameters "size, offset".

In our case, it would be scnoprintf() ...

Best Regards,
Petr

