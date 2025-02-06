Return-Path: <netdev+bounces-163667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E79A2B40A
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23033A6BA4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 21:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391311DF965;
	Thu,  6 Feb 2025 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="h4jynQry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745271DF964
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876752; cv=none; b=mCFFgs2NeGn2MbICIe+BY6XIpkaP5DvJ9hz9g/yS/WGNlj8KysDZ+hyjfJpTtGGlHuXbTNVr3+iLFpkwrCkoWlXcpYB+z5WODgMHGFau95N1fc+V7vHGhT6rWyE3qjlQkJOPRvxCOwUWWp63VAVJuwx2dDtL17QtImwTlCZhJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876752; c=relaxed/simple;
	bh=BKXQ3UO6wluxh4NpMXIjxMheqgo2EwxAFcHsPwZNSNI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAznPlCf9O8y9o47L3nl/DhtlYM7iJJydXkbZFhXcv1I20jPa+Elayh3i+Q+8NxrFVzpdZc96pVFcyWG+kWchoML4wbG/el5JmpPKA6/978GmWKeR6IYVeuKIs3MN8t7xU7mZCIrrPNpzn93TrRV5T5O2yKsOnnkjufAN/9xeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=h4jynQry; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-219f8263ae0so28958405ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 13:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738876748; x=1739481548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7htl7Tg0M4/5PeYsotO0GAOj7s9NzufpKJezS5le81Q=;
        b=h4jynQry3XkD2Od2toHM/mX4W4Hjwhv3wDcg7OCs8Z52PLyRHV2mT53wJ5z2JfGG2C
         59FDF8LcMF976dKMuU2IMMD2af+TRx4aIrUF73lKZ14mtezkI9FaeODwkIJjwdg1K9jG
         JBLkHg9zOG2c7EEV5wpsFDH6ruc8wZiS8v4Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738876748; x=1739481548;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7htl7Tg0M4/5PeYsotO0GAOj7s9NzufpKJezS5le81Q=;
        b=a6DDpgyZLty4p6i5KLtyRIbx4ZbZntrbw+uEmkt6sBtrlbwElOMoUQ+TeBREQTrPzp
         cdRE8EmmkoMyu5gkDq6ZgK0dL8MeryEjdIihh+JxxIHeoMVCV0Gvp4SIGQXgkpz7xw2u
         Yhid1oHFGXJHXEbI/uHxwCatNon6QcOt5atxtXnSDcDkDr1912qBY2EY7ka4wMC9y3Wu
         FosJCJmcm6gSNqN76/EPIVochVDwhcBCNvOBEP8lD02hPMLn2sd94UXnONQwEupRJUDH
         9LzMVKWuOJPS1LFVEWqnn31Osll5TV0ZjD/pTgBs3E/LxfvlrwXDF3Mtcloilf/IjuJ7
         Si8w==
X-Forwarded-Encrypted: i=1; AJvYcCVqIdAdEykDoNIUivA6SO4Qws1mlHBY2+fJhYP0WIj0JpAF2NjYl5zGnqXsMozZBVYHPhfnMIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQHdfCsC0q6KnMlWQegdAaSD5eI6XHHd0d5dnsUbYuErEs4Lx
	+4uNzaMatsoofq28kPXvy7EuX5FSYPgDVVFhkm/0EKmnRUCUIUTEW3rsJ5c1y1w=
X-Gm-Gg: ASbGncvseDC1ccD/VnLwRf4hzy1IosPI9PAC537Lds5TpOTwjbGZ3Kod90taeiNXXfi
	pD4eNoAsQ4mkhD9+Kjx3lGIyr1r98gWOKeXXlwDSXbOMxH2PUZQo2dvHt7IRWlvkNHr7xrxCcU1
	DMInPeE0du83RnQkXK1FZjtleojhYIdPLKGy+v1I6HIQ318pIa/wSrowClgCoNMp70QNv6vHaTx
	wBME6d97t6FI1rnCzE4QJoryOSgKtcJo8KDHyCxN80D6ukReSpSxrGVdRH33V43FG7QoALG73QA
	zbT6EclSPFrBbeTftpRpHt8s71L40jUfJAOwcD3gKpznpiEKewkhT+LJog==
X-Google-Smtp-Source: AGHT+IGvfIKVNNo9AkzCalC/O6yQT4K8RzYuUU35QUfGafBQJjNDRyerv7Y/Pmyt+GDEA70kSW/q4g==
X-Received: by 2002:a17:902:ce03:b0:21a:8ce5:10dc with SMTP id d9443c01a7336-21f4e6ced1emr14135485ad.28.1738876748641;
        Thu, 06 Feb 2025 13:19:08 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650eeffsm17517435ad.50.2025.02.06.13.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:19:08 -0800 (PST)
Date: Thu, 6 Feb 2025 13:19:05 -0800
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
Message-ID: <Z6UnSe1CGdeNSv2q@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <Z6LYjHJxx0pI45WU@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6LYjHJxx0pI45WU@LQ3V64L9R2>

On Tue, Feb 04, 2025 at 07:18:36PM -0800, Joe Damato wrote:
> On Wed, Feb 05, 2025 at 12:10:48AM +0000, Samiullah Khawaja wrote:
> > Extend the already existing support of threaded napi poll to do continuous
> > busy polling.
> 
> [...]
> 
> Overall, +1 to everything Martin said in his response. I think I'd
> like to try to reproduce this myself to better understand the stated
> numbers below.
> 
> IMHO: the cover letter needs more details.
> 
> > 
> > Setup:
> > 
> > - Running on Google C3 VMs with idpf driver with following configurations.
> > - IRQ affinity and coalascing is common for both experiments.
> 
> As Martin suggested, a lot more detail here would be helpful.

Just to give you a sense of the questions I ran into while trying to
reproduce this just now:

- What is the base SHA? You should use --base when using git
  format-patch. I assumed the latest net-next SHA and applied the
  patches to that.

- Which C3 instance type? I chose c3-highcpu-192-metal, but I could
  have chosen c3-standard-192-metal, apparently. No idea what
  difference this makes on the results, if any.

- Was "tier 1 networking" enabled? I enabled it. No idea if it
  matters or not. I assume not, since it would be internal
  networking within the GCP VPC of my instances and not real egress?

- What version of onload was used? Which SHA or release tag?

- I have no idea where to put CPU affinity for the 1 TX/RX queue, I
  assume CPU 2 based on your other message.

- The neper commands provided seem to be the server side since there
  is no -c mentioned. What is the neper client side command?

- What do the environment variables set for onload+neper mean?

...

Do you follow what I'm getting at here? The cover lacks a tremendous
amount of detail that makes reproducing the setup you are using
unnecessarily difficult.

Do you agree that I should be able to read the cover letter and, if
so desired, go off and reproduce the setup and get similar results?

