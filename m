Return-Path: <netdev+bounces-113044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5467193C79B
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 19:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BC11F22C9C
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 17:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3AF19D06C;
	Thu, 25 Jul 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CRyBwqga"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8F614A82
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927875; cv=none; b=XqcFKRVHgwviGD67VAZ/K8BVw+4sIzeXsahu+zKNa+g/j4nCbkJK48ALbqFJPVcSfvA0eorFOGkXFPO6zdf8Kud4cHE6cZsvfV37nTrOWEGufNQ3cApeNRSSbj4RbLeiVq1l05JZHDwJUEdCljguNSd92IQEBY4yU23Sx7yVsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927875; c=relaxed/simple;
	bh=gHwMmMr2pG0U1Cq5giNh6ZjpT8ogqD0NDu8mJn+QLio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvsZORA6QLtqF1M0cD82zzdv5nGrKBoV5dCR7j4tYK0yly7PwID0ZdvN9v37N+19GGoUmA63AX0H3g82kf0g6YV83uFm+gTQMEJ0dc+ZuJoVa/3ZTJaLIZGKiiad3/39DWR40KXZrgV5QdWGC5ESYlDslrjvjN/9mEl6ATtHUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CRyBwqga; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so79157a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721927873; x=1722532673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zgo53W/TfcA2xok0D0en6xpPVQcKpFXmHfnkkp2U8I=;
        b=CRyBwqgaQczZfu7wKvIeU9hnGgDryxHBCs/Ubc+TBQk/mzPonGH7erNuOei9d0G9jY
         40wvNFhPynCN3hjNpl/fmW4+x+TmUhEiUc/MAkE6mF6glhBh1Bp4nRMAtoYsWQZ7p7hk
         lIwEHExVpMeFdvm2gUYRDqwPNQ6/tAZRQckYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721927873; x=1722532673;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zgo53W/TfcA2xok0D0en6xpPVQcKpFXmHfnkkp2U8I=;
        b=gc+S94ju+NkKs+bR0YCik0D3CBcUak9cJdVXC4tOJVbtQTGCunxOF6kgySinpj6H7u
         bG4njeX42Br3ZDwqz5bJrdqaeWU6swii6WtMu4H2LMujljmjLR6RHbv9HutBYL53gkoN
         yDKsNyjPexvubHi+d6yjFDHa0dRDeqdG+JSZH7FphyQwACcifUKxlQAe5JcJmR70MO7G
         7YMe1qW/DQcgv05P9uv60vH54Orz2P3WFN4yAeJzABIjG31gCSB2I74XSST5v9lgi68e
         jZV7TVcSLjfsjSt0CF3Mdlp1zstmDlDEBl/Qj4yAA0dWN1cge8MG7jchACmcZBPp4cqG
         cSrw==
X-Gm-Message-State: AOJu0YwZYnXeLMRdENlbgewot2HfXA2U8+zmvn7SigyrWMSOOruqM82p
	iCbazYlAhflOukm4tPnExBO4Uo6flYokFDesu0x0cVwbl+Ug/z/hXOV14LT8pP4=
X-Google-Smtp-Source: AGHT+IFmaVd6AYr4PVs7dsn1rKcCIpjOTJ5hcQZupqk/JFPuS+AmYX8u5wkoanhPTblVpYmQs9Oumg==
X-Received: by 2002:a17:90a:ac06:b0:2ca:8baf:abe9 with SMTP id 98e67ed59e1d1-2cf2ec146e1mr2425028a91.40.1721927873305;
        Thu, 25 Jul 2024 10:17:53 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fcfcsm16712835ad.56.2024.07.25.10.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:17:52 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:17:50 -0700
From: Joe Damato <jdamato@fastly.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, kernel-team@meta.com
Subject: Re: [net PATCH] fbnic: Change kconfig prompt from S390=n to !S390
Message-ID: <ZqKIvuKvbsucyd2m@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	kernel-team@meta.com
References: <172192698293.1903337.4255690118685300353.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172192698293.1903337.4255690118685300353.stgit@ahduyck-xeon-server.home.arpa>

On Thu, Jul 25, 2024 at 10:03:54AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> In testing the recent kernel I found that the fbnic driver couldn't be
> enabled on x86_64 builds. A bit of digging showed that the fbnic driver was
> the only one to check for S390 to be n, all others had checked for !S390.
> Since it is a boolean and not a tristate I am not sure it will be N. So
> just update it to use the !S390 flag.
> 
> A quick check via "make menuconfig" verified that after making this change
> there was an option to select the fbnic driver.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

[...]

This seems fine to me (and matches other drivers as you mentioned),
but does it need:

Fixes 0e03c643dc93 ("eth: fbnic: fix s390 build.") 

for it be applied to net?

In either case:

Reviewed-by: Joe Damato <jdamato@fastly.com>

