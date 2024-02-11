Return-Path: <netdev+bounces-70825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07250850A7E
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 18:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D0E1F224DA
	for <lists+netdev@lfdr.de>; Sun, 11 Feb 2024 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD85C8E8;
	Sun, 11 Feb 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="aMZjQALY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5855C60B
	for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671887; cv=none; b=refzHVFntbOQONH8fBxo4tuee47pkb29LtXB1wBOAr8WVv9PhoFywm4bY4V9hQ2ki2lRyBBPWMjkSRxCdmGmgGkOFuE0rHPbixh7FZBaQaXSNZmn8p5OkjYhSGm5ILUV2P5a0Iwua4Y+KoQG6NbTwo8n1pVB84ueM4KcNwSYD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671887; c=relaxed/simple;
	bh=z2ZVZm9N/VktiEEOeQqAHI36ydHlZm8Op7ssrWwrLkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCbysMcSLcVQDYQxFqhivAr6adh0S39qzr6I/9qgdqQxKGUdSJ1wullgkRXR37l3UnyEmo5223W4nE+WSO1mQwad4lVHjg2FW8WCKJ89WpiJs50HUjgE3uYivjjNx9HETVmVkI54TCVJXOivwFl+FGA4jmTQShuIC1apO60FJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=aMZjQALY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d74045c463so19695425ad.3
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707671885; x=1708276685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+w0y7Rh7GWfaD2Lfys/cjVGvaWXiWncI0fzzhwgiYY=;
        b=aMZjQALY5OBfC5KbeZ/NMmG4ukXjvzwSQ0EisJKBzwumlBfZtI+yijX3Ut+30OKlzM
         7dmalnMqbNXTPQqJvQkPrLGqea2FZ4qrmtUxx7xeuQ2OHVO44FZkWyTASGEx5YO+Gktu
         noF6yzqgWxZqRIWSH+9wiZdOTMZ47Cal3lgClz7S5sU4iUk6FQn8nbIMc8c40G7BtGik
         BpmF01AEmzOx/928Bt3L5TP5C/mZbn+DiTEEpAfGLqphVkDFCBuSCvlKye4jYR0Ys35M
         bkOCRZ4gaR0OSNxTZUFrBoJUjx+rE1MHiEzvGPjLxCqXuNJSv/0R0Zyr0jxO81hDNgOl
         j8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707671885; x=1708276685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+w0y7Rh7GWfaD2Lfys/cjVGvaWXiWncI0fzzhwgiYY=;
        b=hoRyKc+8JC1nP5U0puROCg4qYj2QSO2JTB6qBI5Z8fxsi2dg8rf68w93HcBL6L5c4Q
         N+XDNFp/yHGbv0uyOgmHYBjHn5ZRTuzn44boOpH50c3xyqVDb23U7TOp0S/4JHbFmC9q
         PmSjkS3XRMu1oRkQxB5OIxEZ0FZFcgADXkZVGCENkCMA5GYGoNKEKdOa0i5K/BtZy/P6
         P3KYyTXBDvGAA+ozVQf7FTEXkd8CHT9jvzcFr9wqgbt5AV6qfccbNEPnXR0gaWHRuKg+
         d2i3V52JlTbZESHYN85qo4KQc/WqK2HtCTXrTg6omXut0ozQUWej4uC+KFSdDlngIu2M
         87Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWEnSc3l2S6yUohXzGK6nIQ5Cu7MJ7/sDAZhwBXCViQxDd5RdZB4UYl7chZxeSvHccHVqaNFAL//e6pX3kWAHYIy4AvkRq0
X-Gm-Message-State: AOJu0YwtEXwXyoZ1usZDXZWd/Dre3lfiLygLirE5T3p5STyfXPOqv/h2
	dMBOGjj8zAS9jLOUn0uzVdABtW3cN6oIKlZW5NtV+6ZgV7rXmM0bkPb5YX3zVNs=
X-Google-Smtp-Source: AGHT+IG77dQJzrY12k7FmeduPyz8QoHe9djKp/1G97KtkASI8PxpZw8jUD4oWKjbOzl+wWW+gVQx1Q==
X-Received: by 2002:a17:902:e751:b0:1d9:db3e:e3ec with SMTP id p17-20020a170902e75100b001d9db3ee3ecmr4850033plf.14.1707671884849;
        Sun, 11 Feb 2024 09:18:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZ6s0e83aW+pZ7fIVyOBpsojY6vh09+TcaMyb3ysiuNPOoSiAeYXYNacYuJvUYKKKwMWPFaBa1jHLvi5Uw3oPWD+NVluAw
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e16-20020a170902cf5000b001d8ecf5ff6csm4564538plg.147.2024.02.11.09.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 09:18:04 -0800 (PST)
Date: Sun, 11 Feb 2024 09:18:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Kirjanov <dkirjanov@suse.de>
Cc: Denis Kirjanov <kirjanov@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 iproute2] ifstat: convert sprintf to snprintf
Message-ID: <20240211091802.21885973@hermes.local>
In-Reply-To: <331c1b3b-4dbe-48e7-9e75-0536528a8868@suse.de>
References: <20240202093527.38376-1-dkirjanov@suse.de>
	<20240210123303.4737392e@hermes.local>
	<331c1b3b-4dbe-48e7-9e75-0536528a8868@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 11:39:13 +0300
Denis Kirjanov <dkirjanov@suse.de> wrote:

> On 2/10/24 23:33, Stephen Hemminger wrote:
> > On Fri,  2 Feb 2024 04:35:27 -0500
> > Denis Kirjanov <kirjanov@gmail.com> wrote:
> >   
> >> Use snprintf to print only valid data
> >>
> >> v2: adjust formatting
> >>
> >> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> >> ---  
> > 
> > Tried this but compile failed
> > 
> > ifstat.c:896:2: warning: 'snprintf' size argument is too large; destination buffer has size 107, but size argument is 108 [-Wfortify-source]
> >         snprintf(sun.sun_path + 1, sizeof(sun.sun_path), "ifstat%d", getuid());  
> 
> Right, this is addressed in the patch with scnprintf
>  

But I see no need to convert to scnprintf(). Scnprintf is about the return value
and almost nowhere in iproute2 uses the return value and those that to look at the
return value are checking for beyond buffer. Plus if you convert to scnprintf you
lose lots of the fortify and other analyzer checking.

Bottom line scnprintf() makes sense in kernel but not iproute2.

