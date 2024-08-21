Return-Path: <netdev+bounces-120459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06176959713
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3934A1C214C2
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C11CC8AA;
	Wed, 21 Aug 2024 08:22:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2B1CC8A7;
	Wed, 21 Aug 2024 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228525; cv=none; b=V8Vkrv4qKZ0DFxXsaQAgbLSFMGYBVQzCx5wahKyL+mS5//pg5iX2dR0lwQlLxpfe//DXtgTo2McfcioKB1hPstLjogUY9XKra+VgzEZPWuMoPDZWtP3841egaw3OL3TwtNnCI6wP3IQfg+IV5QOy78XtUmlylCLOch59/PU2p/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228525; c=relaxed/simple;
	bh=Tesmrmhfl4vNBb42r3YwxWJKeO6Dbla4NyeTG14NiZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3JcO+d6DvJWm6zSARyqqG5x/3GvLP3yoeizuwQx2juQn/gaRbrK9YAnR0Ok5yFe0afz5yRkFmxk4J41moqhGfGrWoOEGP54v58nX3SqRMpX9Q60tJF9DviU/msrMJN345f7QCCR0jJWIxithyS0rnOFxqZV/r5GWfkID+du/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7d26c2297eso732088866b.2;
        Wed, 21 Aug 2024 01:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228521; x=1724833321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcnXZvVBqBy4MzdK7leKOmalOP9dO5vly1AqcGVQkZM=;
        b=XbrB1PkK4EVchQmZ+4wZG118wSMAgAisNP3xkh9A7ZrsIvvEfFL2qi1Rn9W56S92Rt
         ndcyg7vt5+O2013W2sVy5HeI9insBYphKFmKndNp5ZsaD+KIc0bryq7Nx1qa28253f4q
         SWGcMU0v0OUPZI6ktfJKuv5yqDcwPBaE5IqGrxEJ1KbHyePSr7jTD+CYS2Qwp0UnK07X
         ihvOMavZrdBVMaQWurKJXFpH/q9nTyMPgm6/OJGJ8bRuk5dKfZU/5131X2Rc/kXUkNtv
         hPYNZbUXiqGXws9JjKG4CxHsy+CiAYBO1NuuKYZ4O4Jj4GtK5T5U0dqTWWcWRI959mBE
         wT7A==
X-Forwarded-Encrypted: i=1; AJvYcCUJhrhh6s1O5NExJN+71x1SsVHDS9I+OzGMaSwxFt0EKf57K6D4A9cfDQQ7d9R9VCpFCHIJGkXCJNs5Qdw=@vger.kernel.org, AJvYcCX71i0oXD9H3ZRYbToL2CEsqbXnNfyFCwzD6cb4v1ZwatJsyjKkPKAOWYDK6ZKXCI6gJegIvRWL@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVbZ/qNzqZ63viEbh0zbwYfbY1KK7nZPmSKCBjQfbxm1G9bbW
	UxSXR6CiM/QoSQbGWIUfQb0hhNG4AlqNTLyLF2HSSnJvhzYnVXbl
X-Google-Smtp-Source: AGHT+IHpc7wwJWzIcF7lqbNXhj1A+bKdFOnrHXIE04xv+nHsm9f2MQU38+HhqBjL793G5aF2WsvM5A==
X-Received: by 2002:a17:907:9712:b0:a77:c84b:5a60 with SMTP id a640c23a62f3a-a866f287301mr104144366b.26.1724228520949;
        Wed, 21 Aug 2024 01:22:00 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a866eeafb3esm72001166b.79.2024.08.21.01.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:22:00 -0700 (PDT)
Date: Wed, 21 Aug 2024 01:21:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aijay Adams <aijay@meta.com>
Subject: Re: [PATCH net-next v2 3/3] netconsole: Populate dynamic entry even
 if netpoll fails
Message-ID: <ZsWjpuoszvApM1I0@gmail.com>
References: <20240819103616.2260006-1-leitao@debian.org>
 <20240819103616.2260006-4-leitao@debian.org>
 <20240820162725.6b9064f8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820162725.6b9064f8@kernel.org>

Hello Jakub,

On Tue, Aug 20, 2024 at 04:27:25PM -0700, Jakub Kicinski wrote:
> On Mon, 19 Aug 2024 03:36:13 -0700 Breno Leitao wrote:
> > -	if (err)
> > -		goto fail;
> > +	if (!err) {
> > +		nt->enabled = true;
> > +	} else {
> > +		pr_err("Not enabling netconsole. Netpoll setup failed\n");
> > +		if (!IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
> > +			/* only fail if dynamic reconfiguration is set,
> > +			 * otherwise, keep the target in the list, but disabled.
> > +			 */
> > +			goto fail;
> > +	}
> 
> This will be better written as:
> 
> 	if (err) {
> 		/* handle err */
> 	}
> 
> 	nt->enabled = true;

I tried to do something like this, but, I was not able to come up with
something like this.

There are three cases we need to check here:

netpoll_setup returned 0:
	nt->enabled = true           				(1)
netpoll_setup returned !=0
	if IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)
		continue with nt->enabled disabeld  		(2)
	if IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC) is disabld:
		goto fail.					(3)


The cases are:

1) Everything is fine
2) netpoll failed, but we want to keep configfs enabled
3) netpoll failed and we don't care about configfs.

Another way to write this is:

        err = netpoll_setup(&nt->np);
        if (err) {
                pr_err("Not enabling netconsole. Netpoll setup failed\n");
                if (!IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
                        goto fail
        } else {
                nt->enabled = true;
        }

is it better? Or, Is there a even better way to write this?
	
> As for the message would it be more helpful to indicate target will be
> disabled? Move the print after the check for dynamic and say "Netpoll
> setup failed, netconsole target will be disabled" ?

In both cases the target will be disabled, right? In one case, it will
populate the cmdline0 configfs (if CONFIG_NETCONSOLE_DYNAMIC is set),
otherwise it will fail completely. Either way, netconsole will be
disabled.

Let me know if I am missing something here.

Thanks for the review,
--breno

