Return-Path: <netdev+bounces-126913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C022A972EB9
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0D1286868
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC0B18EFD8;
	Tue, 10 Sep 2024 09:44:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6F18EFCB;
	Tue, 10 Sep 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961488; cv=none; b=bzKumNJI1N421vAu9bupX24R/4pe9FX/d9LN+evPgzHoGNHD66yw8s9R1hM/jdMMKFZfOjQxReu8F+S6kIse/h1YIjnVFMImykPZthcwn7gy/RlMmkZTgWkjFrSvvcO8Kun1Zx7QXuJISShnPL910umeDfQKBZqMXstVeWyKZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961488; c=relaxed/simple;
	bh=B/Hnf7fYM7HOeWShPDrC5NP0EgrLS05vitkWoMbwaiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFBWqrX5EG5PR0D9wqFZLqic1cBygqBQaZTalo6HkUGsxMCVlPWw5cC1vaXbXpITUbCRzqVeXA3T9pT8OtCBmP8KBFsKWR4tDBcF6K3HMmQozKOqaY4Yg5YPpFUADp7hChSnbPWyzF/x//gWS2aH8Cc86Lz4CV+BjkzfeLyvrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d43657255so320229066b.0;
        Tue, 10 Sep 2024 02:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725961485; x=1726566285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEiLqRfxf7lBPb/a2NUaZRXiI2UrOttr4l6z8YhNi4Q=;
        b=XxTxUrSjZ+x6DjEsFPtt+FDbh++QVilUXoX2hXpDo0B2RDJI7NLr5Al8JmCXxvnOum
         LD0viONA0LuosXfLYWKudED5PukvQhQLJnqK0u4ljg/GYyFFfHQFEydEq6fPlLUcbuxa
         gidwz5wSz4kr4pOTuazDXBHJMMnltGmepkogZmL886d073OOfYps289yAXQ2hUlN81Fu
         Jgbe0vrE4X/OOFvZRELq1ZSi86RzONPSTJ5EPQWt/O4Ooi7txoegSa/xmiZW/IISjnr4
         cTgZGwUDt6SzMb9PAJe29pOJj1ih/BI9clYiB32KMCpojM3q6nG4D1kJiXn4xT7Brg+8
         MZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCVMf53QenMFbK6HHsVb/1/5CYl5ZiNA4sRLQMRNIrngpcbHbcrCjuS6EdbDgwcXHzRgUfAwgZc9BMKUawI=@vger.kernel.org, AJvYcCVZIb/5obvRddZD4hqeApuXXIQJ9CZ4RBQKEJaj2L/k0PvCBrEWqGbbmsLboC1PM3v6NAJJtJr5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc3rM4U5sS7eHhZ5l70DAKItHgedLaSmyezkdKGiqPuMlzhCk1
	YV8ilfnXCu1RzrkndeyumYnzApFTVRA/mlrjGr3ZyuBfJn7ArXxv
X-Google-Smtp-Source: AGHT+IFj3shL6QuYetQtig1F0qQ+MlhLBZvhKZZ4LCvSersDof8GynDsZxIfAXp8ReLBROX8xYBaPw==
X-Received: by 2002:a17:906:f5a9:b0:a7d:a00a:a9fe with SMTP id a640c23a62f3a-a8ffaac09dfmr15128966b.17.1725961484500;
        Tue, 10 Sep 2024 02:44:44 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2583fc73sm455114466b.34.2024.09.10.02.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 02:44:44 -0700 (PDT)
Date: Tue, 10 Sep 2024 02:44:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com
Subject: Re: [PATCH net-next v2 08/10] net: netconsole: do not pass userdata
 up to the tail
Message-ID: <20240910-certain-weasel-of-bliss-1cf769@devvm32600>
References: <20240909130756.2722126-1-leitao@debian.org>
 <20240909130756.2722126-9-leitao@debian.org>
 <20240909160528.GD2097826@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909160528.GD2097826@kernel.org>

On Mon, Sep 09, 2024 at 05:05:28PM +0100, Simon Horman wrote:
> On Mon, Sep 09, 2024 at 06:07:49AM -0700, Breno Leitao wrote:
> > Do not pass userdata to send_msg_fragmented, since we can get it later.
> > 
> > This will be more useful in the next patch, where send_msg_fragmented()
> > will be split even more, and userdata is only necessary in the last
> > function.
> > 
> > Suggested-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> ...
> 
> > @@ -1094,7 +1098,6 @@ static void append_release(char *buf)
> >  
> >  static void send_msg_fragmented(struct netconsole_target *nt,
> >  				const char *msg,
> > -				const char *userdata,
> >  				int msg_len,
> >  				int release_len)
> >  {
> > @@ -1103,8 +1106,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
> >  	int offset = 0, userdata_len = 0;
> >  	const char *header, *msgbody;
> >  
> > -	if (userdata)
> > -		userdata_len = nt->userdata_length;
> > +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> > +	userdata = nt->userdata_complete;
> > +	userdata_len = nt->userdata_length;
> > +#endif
> 
> userdata does not appear to be declared in this scope :(
> 
> .../netconsole.c:1110:9: error: 'userdata' undeclared (first use in this function)
>  1110 |         userdata = nt->userdata_complete;

Oh, during my rebase, I moved the declaration to a patch forward, and I
didn't catch this because I was just compiling and testing with the
whole patchset applied.

Thanks for catching it. I will send an updated version.
--breno

