Return-Path: <netdev+bounces-95786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1DD8C3715
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 17:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668091F21499
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2761840879;
	Sun, 12 May 2024 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b9aNPznu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF81C683
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715527935; cv=none; b=HTNpMqaKCnXOmPKlP9qxQDM2ryH6kd0XRh0XqQLpKhVRtehyWSwTFNeAWIlbDuL+0wQl/20daVM5Lh+FRxywIYN96GepOZI2M5uPYl9puCrYm94XVJO8h/en2KdZ/8UIfYnHfU8GY6JkCi7TVTDYHz4fBLwfVkjXWl3J/vocaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715527935; c=relaxed/simple;
	bh=c/xR6XWd0ZJ2Apihi/VXSlbxsQFdOfpx1NEcoN7iM1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtLdrRhfNHjdh4QFvqsA69powNY0m5hDTXLjfpSj/jp0dNMQd+Rk8mLgoJZ/BZDNYNlurIJNVzRunm/AvZNFDy3oh+CEJzZgHM/NysFREVNlo5dlqzQ2IQpBhCQPhPoQ0HMFo6ZUdEW4uufnqQV1+FnvuPZCzxYhGWtyronmnJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b9aNPznu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-792b8bca915so359661385a.2
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715527932; x=1716132732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0efAPLV7gJorXuDH/HsiT6gIfHOKo8TmSCEI2yyuMFQ=;
        b=b9aNPznu8DLUvLVOpFdxSCp037hBpS1wchBMrc9ocgVegPi9Fz4P/QowVRwqtmuCDh
         BtEJIT4l7kX9aWVfDzEukPLA7NOooHfToaCJZUBETD+4GYRXcnPxST2pjUfRIhCaqyXa
         MS/71JyfLm90aAz0rACx9H4ElFucV/OflJJTl3mIRCm8ATbIQW4GCfO2KrPlm1+MgONj
         9CIhSBJcdoykJLBbTK2oZ9ZpRG0J1jclVxjL+WROzDYY5G2DMWNslJAmL9pBOKxnsyt2
         mq8baz4VnSv+0Z+NOG/DjRlXTK7blVuaOyJftshRhc/CKK7Dge6HjaAGH2T+3OgLazDK
         TjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715527932; x=1716132732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0efAPLV7gJorXuDH/HsiT6gIfHOKo8TmSCEI2yyuMFQ=;
        b=I4zq2AGfzQ6tgLqMBu3rb7CDPLJSeOa1CX+Qrr2dPi9DWn0KEVB2N/upaQb9ghdpe5
         0NZZG7Ly4x67IkpQqXKaIX2YpJMe3gyBjCmHacD+n2MYOtuCGUNijcE9pRuDj2QAO55k
         0KH3lESurEpbYI0uR2kPKLxNXrnGvfZJviOU2eCNlxSsd/Xe6J11VEm3JzlP4I2LuQqo
         uD6Tjr17DqcfLRi9V6IV95cy+3qVYwD2S9pEZJXd/mYaT2Eqr3Ry8YGEL7laoSy3bwJz
         aULC78I5w89uHhUXibqtX0eEzkeDdfKOtYLZv743Rik0xOQpsuDY8Q/Cr3myJ15hHHAh
         t09Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6vEeDuaalBNNNxBAguuwYuz9pONSQ0gPNj0pphXAg0kWP5MbpXgoGY2spQEjWqTP8CpogwH9croWfLBCrWSEGHyFWjhXf
X-Gm-Message-State: AOJu0YwDM49bO/+iY9SSJCIaWGolkRr7TcNXpM100v6B4Q1PwKOWFvdk
	Zj1VKSL9RYf1iL+MgYkXTP9msnpP1ZWLd0ukSd5/hKA7ij8CoMOpQ8hiaSboDNQ=
X-Google-Smtp-Source: AGHT+IF6ABeDSAxVTyR4eCJ86ITbHVICbjDvsIz9fFFVAp47oxU8ErURGU+awbml0lKGxv/RxMvDfA==
X-Received: by 2002:a05:620a:3bc4:b0:790:fc71:26ec with SMTP id af79cd13be357-792c75ffcd1mr883079885a.48.1715527932515;
        Sun, 12 May 2024 08:32:12 -0700 (PDT)
Received: from ziepe.ca ([205.220.129.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf280390sm373982785a.35.2024.05.12.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 08:32:11 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s6BBA-0003W4-S6;
	Sun, 12 May 2024 12:32:00 -0300
Date: Sun, 12 May 2024 12:32:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Shay Drory <shayd@nvidia.com>,
	netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v4 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <ZkDg8Aj/TdOqFwqf@ziepe.ca>
References: <20240509091411.627775-1-shayd@nvidia.com>
 <20240509091411.627775-2-shayd@nvidia.com>
 <2024051056-encrypt-divided-30d2@gregkh>
 <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>

On Fri, May 10, 2024 at 02:54:49PM +0200, Przemek Kitszel wrote:
> > > +	refcount_set(new_ref, 1);
> > > +	ref = __xa_cmpxchg(&irqs, irq, NULL, new_ref, GFP_KERNEL);
> > > +	if (ref) {
> > > +		kfree(new_ref);
> > > +		if (xa_is_err(ref)) {
> > > +			ret = xa_err(ref);
> > > +			goto out;
> > > +		}
> > > +
> > > +		/* Another thread beat us to creating the enrtry. */
> > > +		refcount_inc(ref);
> > 
> > How can that happen?  Why not just use a normal simple lock for all of
> > this so you don't have to mess with refcounts at all?  This is not
> > performance-relevent code at all, but yet with a refcount you cause
> > almost the same issues that a normal lock would have, plus the increased
> > complexity of all of the surrounding code (like this, and the crazy
> > __xa_cmpxchg() call)
> > 
> > Make this simple please.
> 
> I find current API of xarray not ideal for this use case, and would like
> to fix it, but let me write a proper RFC to don't derail (or slow down)
> this series.

I think xarray can do this just fine already??

xa_lock(&irqs);
used = xa_to_value(xa_load(&irqs, irq));
used++;
ret = xa_store(&irqs, irq, xa_mk_value(used));
xa_unlock(&irqs);

And you can safely read the value using the typical xa_load RCU locking.

Jason

