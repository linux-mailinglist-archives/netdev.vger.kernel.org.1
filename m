Return-Path: <netdev+bounces-133326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E0D995A12
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95F9B21815
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 22:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE6215F54;
	Tue,  8 Oct 2024 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="G4vtp/9X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F69B14A82
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728426487; cv=none; b=E2xxff1LenH5qd9Ysphgs5o+a6jADfXk/K8/BOn9zWh0/MNi8UNbCBcyDG3/1rh3Tvj0LG55YI53lQ7HRonMs/wXx66UBcVc2z2s/2bq97czlFq3X41v/QX/MKcGYgbNWDfxQ4Eu6IVzbKFQrgGRoLwrOyuuQJgL6E53idw68Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728426487; c=relaxed/simple;
	bh=PeQ+3ZqZao8FTskqbH9VfwLkZaZ1/LLm/N0vThJthsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xawjsgm+KREBLU8nGMjCE/OKyglTtxmLauqZcqcCjweaJ7y0pjC12AMRoy9hXtdOI49LyUR8n5+et3rpHRja2FIK6m5126n5I9pRxtxhJt23Yk/qX3w207jft92ofWXT2TnSgi/OUgwvx1qAQANdkblntEo+xmMVo8lCyV7o4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=G4vtp/9X; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea1b850d5cso926553a12.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 15:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728426485; x=1729031285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GpPyK5gRQWrst+Fyr+Lsx8V+lp2jzKPbwoFf+V+Wos=;
        b=G4vtp/9XxuXOyk84EUhUcPlEV5RmXOskkza4Mx0E/x+ObEIANVfRH2EzsGCbQZpIt9
         Bub+bhikT1AvbLSWiGU8v3nE3iL8a7/DiDb1fyoBmSs6nPBVaIYKB4A/+NGaF8foZW6W
         MuSkcJTkpD5lYufFmFK8vMMSZkH8ZjDC+9GXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728426485; x=1729031285;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GpPyK5gRQWrst+Fyr+Lsx8V+lp2jzKPbwoFf+V+Wos=;
        b=pWiAGq1Ou3HWpMhar0hLWeU8XSnNcgaJ/IkZ2zBXTxUpwlrumJ2x8XsL60grqZo/Lz
         3libndMr6GpMfXha5k2dC/tOV/t9ZBAtXhNB550w3hDDbDGwuToAsn3OVFfyi+EdGzuW
         CZOWCdLm0YbcNJzDpMdKzxJwiScX3fXLJqeaZSXwpEbpgh4zc7J3oqtoAYWkZc58VCAe
         9E72N5t1twOe41CeNfhBPiiSukMFdP5y+vg3y/e9rZ+1JxaFb2zwnB8PhbLl4ApxYO5g
         3F3xjI/JhLonejqz7gfL5TkjonF9WVdvKfpebD6vctkwnlXLig0jqUONaAQR8Y6xCA5V
         0ukw==
X-Gm-Message-State: AOJu0Ywkk291brayPfrqtZtevgtjXTEsfOKX3ug+mpuEnCOEVNGuCrZj
	vo8OS1TOIjea80GJpNRzZKAVngsJ8nxOibKMCPfw3JPoQHt2z1/BEJsQNHiw0pg=
X-Google-Smtp-Source: AGHT+IE1tXuqOdJ2//PwSHKA9ssLoCKqnAz9+E7C6N37yGYWDeMO+zE60t4b/4luCg6NBXDD2oLj/g==
X-Received: by 2002:a17:90a:db07:b0:2d8:3fe8:a195 with SMTP id 98e67ed59e1d1-2e2a22e6e31mr558509a91.4.1728426485495;
        Tue, 08 Oct 2024 15:28:05 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139a32e1sm59872155ad.296.2024.10.08.15.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:28:05 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:28:01 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v4 5/9] net: napi: Add napi_config
Message-ID: <ZwWx8V1kQBDLFT6i@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241001235302.57609-1-jdamato@fastly.com>
 <20241001235302.57609-6-jdamato@fastly.com>
 <20241008151701.6f8bb389@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008151701.6f8bb389@kernel.org>

On Tue, Oct 08, 2024 at 03:17:01PM -0700, Jakub Kicinski wrote:
> On Tue,  1 Oct 2024 23:52:36 +0000 Joe Damato wrote:
> >  static inline void netdev_set_defer_hard_irqs(struct net_device *netdev,
> >  					      u32 defer)
> >  {
> > +	unsigned int count = max(netdev->num_rx_queues,
> > +				 netdev->num_tx_queues);
> >  	struct napi_struct *napi;
> > +	int i;
> >  
> >  	WRITE_ONCE(netdev->napi_defer_hard_irqs, defer);
> >  	list_for_each_entry(napi, &netdev->napi_list, dev_list)
> >  		napi_set_defer_hard_irqs(napi, defer);
> > +
> > +	if (netdev->napi_config)
> 
> Could this ever be NULL ?

Ah, good catch. I think this was an artifact from a previous
revision where it could have been. But, I'll double check.

In the current proposed implementation, however, I don't think it
can be NULL as it is always allocated.

