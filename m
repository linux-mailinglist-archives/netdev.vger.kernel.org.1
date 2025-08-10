Return-Path: <netdev+bounces-212344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E866EB1F8BD
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 09:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190DE189B081
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 07:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECDE230272;
	Sun, 10 Aug 2025 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJhS+tmm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A11C1AB4
	for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754810072; cv=none; b=ldQCdYi/pIaVCZhGbWH9oR6jN+FAw2sVJh8xKyLJjcszck4ePUAHuUE64WBKKtmlkMFwtF0IpTleoA/Bq3PyeJPALrFrWiBFR76U3BGcd0SblycJSnx4xTT9sZBatOQSIM+OCRfF8ywO6I25tW8p7LdZP5vZpnsivK9sFSirRL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754810072; c=relaxed/simple;
	bh=7I9JAt8dCie/o6zbZbjy2Sd+cX6XM1d2Xq+x0xd8WGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHtiTf1G9qsnLVyBxvdctkHMvg5VoxBhcHZkg5HxS0AUAqtCYLiTvSQjPowV+p3NvSzeatKHwnu1aTeDTKe5EnMi6LHElHQLIMRmBeOBzszHz+D/WqbRm1SraZ/j1WRL24nT9WuoZEiS6ZT4lxt+uBPiGZoRJfY3DQ7O8Sf+LRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJhS+tmm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so1977998f8f.2
        for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754810069; x=1755414869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yu6N7+lRufo2vDpOkxbMFrhs20tQ4MrIqlchegOHkJM=;
        b=XJhS+tmmdNAswDX6jFRwEttaQncHAQTxD1Cc9LaIoKrc2F0Cu+q2jIdCiIANLsVBKS
         gxXcFfcvS4lbOXrU7/gqOrylZIoQ0uj98xgDztttUAKIjoH7spT0PBheY0e27FV58ZQ9
         1Dve4JnsiHg3fJRBm1XI+UcXPSADDdgeKqQK9QEE+wSBZ7MRtp6JPIUNqMZyI+5jG6a4
         CUhXZ51FuEXdpgrkstLIPgT87NC37tsXR6TAs8P54xjnRsj21eLNbouTokI/2y8choe/
         6IoYhizQdr83f2eZrxDfe+wf/CaCHBkUxHOdJ2xDlCUJzktyuYcAAcnGrYYv/LfZjMRH
         7A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754810069; x=1755414869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yu6N7+lRufo2vDpOkxbMFrhs20tQ4MrIqlchegOHkJM=;
        b=o+xXF3h99715bEWYfj1zv3GyanBCAlY4ciCMk9KjtbQBg1aOPR0iQGQB1cbL2NfFc2
         2kInC8RIQ2Awp1UlNSLFyiQK2OUP0Ksr6dODeO6jQmj0RyI+X5vCqpp/EoNXtt/lrblY
         JehZGC9rygP5FjTE61e+0YEr4DDHb7KqhpAVTp9YRhELfLDOkljsU7OwJHnsserA0RMQ
         RHK4U8068PoCzfaPVo4PFkdopW6Z+XwGfg311ZDkth7l2gmyDkoo17OPtHSEUqA6eZpF
         PEuaf2xcKSwnSVZxuIL9tdhiFJSdt1J6WLx1W/ZE0wpLh+bt4t57fzg3xAuOIapLTFKC
         3T5g==
X-Forwarded-Encrypted: i=1; AJvYcCUSC0XkQCzW34ruslSzrWI+uzbUEwqX9ZIPL0ERAmTkG89kG6IQFkFv1uQmjjsmlj1TFvJkxuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZRVwijUjGo3FGpfTGK5FQmLa3TQqxOyso9X/jtBpP7a69THLi
	xqKlrg2udlaArbqOk1f4lgu4oCl1oqPufT3BA1grRY6aIY6E9neAUovy
X-Gm-Gg: ASbGncumG1B5g1f3JycjB/t+aVsRu4RwACYTkB2YkQDR3/sBw7iqMl44Jy8osYK8V18
	Zh/kZg/FsJkIXyPoyvEESRST/O6NyB3JV4GW33bfspPRLGEIhIDATI3KB4z0vZwgfmCFfdJcWnj
	V/0ByqMcz+63v51rjXw/rP0bJRLbe66KVq9K+cjBQcQ/Yu1FwukcT7Ka7q22ULOv/OXeD92DB27
	T6Rtl4kXDWMqpB7zo7PYFQRMi5mkx+9KlZBGEa4aAU+QZvFvIvW4xRtVTvuGmFK6PNvSH1N0FG2
	1zU+B688/b/BJlKpNu9j0ic47hX3ZZE+6PyJ6lCmoDiGezoSahbZY+1XqV5x8zlTQCdSg+vetBu
	dKBK1A3kAOxPuUUGe40uU16Z23M5yv5bgNibAhLUFsR8KpyNbvzGmUqA=
X-Google-Smtp-Source: AGHT+IGgFmfJDYNOxwV1Bjk68HYZVVwm2S2L4biswWLUv6WWyGw8TtiGIMaJJE11fDsA6NOanys3cw==
X-Received: by 2002:a05:6000:2c0b:b0:3b7:8473:31bd with SMTP id ffacd0b85a97d-3b9008c2781mr7113667f8f.0.1754810069152;
        Sun, 10 Aug 2025 00:14:29 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453328sm38120036f8f.46.2025.08.10.00.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 00:14:27 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 7F634BE2DE0; Sun, 10 Aug 2025 09:14:26 +0200 (CEST)
Date: Sun, 10 Aug 2025 09:14:26 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Michel Lind <michel@michel-slm.name>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH ethtool] netlink: fix print_string when the value is NULL
Message-ID: <aJhG0geDvJ4a8CpS@eldamar.lan>
References: <aILUS-BlVm5tubAF@maurice.local>
 <lwicuyi63qrip45nfwhifujhgtravqojbv4sud5acdqpmn7tpi@7ghj23b3hhdx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lwicuyi63qrip45nfwhifujhgtravqojbv4sud5acdqpmn7tpi@7ghj23b3hhdx>

Hi Michal,

On Fri, Aug 08, 2025 at 01:05:52AM +0200, Michal Kubecek wrote:
> On Thu, Jul 24, 2025 at 07:48:11PM GMT, Michel Lind wrote:
> > The previous fix in commit b70c92866102 ("netlink: fix missing headers
> > in text output") handles the case when value is NULL by still using
> > `fprintf` but passing no value.
> > 
> > This fails if `-Werror=format-security` is passed to gcc, as is the
> > default in distros like Fedora.
> > 
> > ```
> > json_print.c: In function 'print_string':
> > json_print.c:147:25: error: format not a string literal and no format arguments [-Werror=format-security]
> >   147 |                         fprintf(stdout, fmt);
> >       |
> > ```
> > 
> > Use `fprintf(stdout, "%s", fmt)` instead, using the format string as the
> > value, since in this case we know it is just a string without format
> > chracters.
> > 
> > Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Michel Lind <michel@michel-slm.name>
> 
> Applied, thank you.
> 
> It's a bit surprising that I didn't hit this problem as I always test
> building with "-Wall -Wextra -Werror". I suppose this option is not
> contained in -Wall or -Wextra.
> 
> Michal
> 
> > ---
> >  json_print.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/json_print.c b/json_print.c
> > index e07c651..75e6cd9 100644
> > --- a/json_print.c
> > +++ b/json_print.c
> > @@ -144,7 +144,7 @@ void print_string(enum output_type type,
> >  		if (value)
> >  			fprintf(stdout, fmt, value);
> >  		else
> > -			fprintf(stdout, fmt);
> > +			fprintf(stdout, "%s", fmt);
> >  	}
> >  }
> >  
> > -- 
> > 2.50.1

As b70c92866102 ("netlink: fix missing headers in text output") was
backported as well for the 6.14.2 version, should that get as well a
new release 6.14.3 with the fix?

Regards,
Salvatore

