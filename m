Return-Path: <netdev+bounces-203353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66FAF586C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E690D7BAFF3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872FF277CBE;
	Wed,  2 Jul 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OrKKARZv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F356515624B
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462287; cv=none; b=ZxjaSQKRhktnYSRHya0nS4Zllg0LoFaO1ranHcNekynV0veyG3NVxa11MmpEIhT8HD2HlCXz+WesQLM/E+Oqd18uSVJV7XVFGcO48viCgq1xIhC5Xcpt7SctUzukNqLPOu6gfBt2rQm4EJqnaLVcB/uzTwAEGLhDzaxaEOsJoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462287; c=relaxed/simple;
	bh=5kZlihYIZFmatXI4cBGB+TFOdpXZ12A7UPeui5kT3wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev6ZN/2sHfPCSmkQwV1XAlQwEgWFdqtRn1cHicgJZmMgdcXIHi+ffkBa9GVj1uebstiCGLrQQ2hXylcXo20+HlM/klCDZDvOVPZHFQ973G3Q86OBdhCOZeEbsx9C4/O+FneJGuPg0YcJLEhxrBCCKcNkPpteeQFb7Mu/dxPhuMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OrKKARZv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74b52bf417cso423444b3a.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1751462285; x=1752067085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz23Tyg/+cYmV17yzTrHH8B+H8AlynLVnYk/5oZAsnA=;
        b=OrKKARZv8psod2z7g4d9SL5QvcXG/puN9MiuhOZ2cR0S7A+s2F+V2qP0eZaFxV2PuQ
         FMb+s28Yy8kYEsxsmG1ZMb458A+GPuDibC6YXlmnSTJJyWnh0WLUGtsCWrFBffK9/kU/
         PYgBhFfCHzvNtH5UjNVjfPibwvbqY/b3sGibgVqKGmdR9F8WxaGulbmvnAbkvTGk0qJC
         z1xkS2TrCOAxGEhdiBK8E7dIKRVN1DV86sozCOXoJ3ZF9h20WNYKL8yreSDnOjbCKQgs
         ZW1wpRLlBkSt8jwK6NxfsV/SESGY1HUo0XRgg8Arj6amgRKnDLE3wPMjeheWwsjgd2rx
         JjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751462285; x=1752067085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz23Tyg/+cYmV17yzTrHH8B+H8AlynLVnYk/5oZAsnA=;
        b=GBJ3tLtMc6X4kn7rJMIwSBzuIKRc2rjBQogJHmMH1MGMtXk6sRfR5cWd/nk2Nxg58h
         ejZsUFlN3F3/kZS5aADbk6+nTWrltePA++dzVfthhv3P51REBtgCpwPHND7oUyeNNGPK
         mLaX2OQlV4wA5A1PtN+1rUOePpC++2T3srQlgxIsEb1qeBDi8nMDCnK+O+9LR7ge+OsL
         lKrXPj4ogeNbbrxLhb05z+80ExntDsezZSoNJNQ0hB8SJ99/cjS6XL+AONmqlICNW5IY
         UM8lmwlZdUjsgZhk2NzTDuxj5MNKSG58L1+9Yz4TW5oPNYYgCjh65n+fZpigo/YVv0kH
         pTbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbyaoGn9NrIjz1WAb94rzSh9P4VLCMcLYdfh2yHKANkWSWbgWYk9bNVi32I0IZYsNIYcWe1nA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4qWb9Vieolr0CfJMAVmMdX8Z1NYlZp9nYk2LHUgzeR1DHccv
	sGaLnwvaEiSwQWzx6iP51EvKoyRuel9xy8OKYI2E4/gZto1CxDNfykTUBZcwp3ZGwkI=
X-Gm-Gg: ASbGncuqFtcLy+QOIt2oG1UIYRRryGqmBfeTe7QFPx7U1ZfUKAwts6e9qfzGIz5yqrK
	CNfstX5cjoteAX2G8tOpOU7w0oYHtg5CqDWR6mBcHGvF5vBScWI7+oMUZFw0M0AGbyqLmCudGUl
	3qyGPI87hnl/YZImbf+paG5OUMkFFt+zrjyq6tzhKZCU3Jyoo8vtpNCQXMIkmLscyMMrejCHcNc
	EIacIkPF91cKcYx4abG2n2pY5/f8TmCQwtcAfS83II0M2X5YmycNanMlVBmDyajZ7tm57W5C8Y6
	PlN+IFMg9CtZZMENTuGfKZ7havFYBmNx1PJXkdQAVvhMEYk=
X-Google-Smtp-Source: AGHT+IEGc1zq93nkJMavPRth5ri3c2hUYnAePkxmcp9zyThS7yDUwDvLudNNxEfu++eq0S0smDF4tg==
X-Received: by 2002:a05:6300:6199:b0:21f:a883:d1dd with SMTP id adf61e73a8af0-222d7defa65mr6135557637.14.1751462285065;
        Wed, 02 Jul 2025 06:18:05 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e300d02bsm12981443a12.6.2025.07.02.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 06:18:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uWxLf-00000004c0r-0w5g;
	Wed, 02 Jul 2025 10:18:03 -0300
Date: Wed, 2 Jul 2025 10:18:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, shannon.nelson@amd.com,
	brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Message-ID: <20250702131803.GB904431@ziepe.ca>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-11-abhijit.gangurde@amd.com>
 <20250701103844.GB118736@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701103844.GB118736@unreal>

On Tue, Jul 01, 2025 at 01:38:44PM +0300, Leon Romanovsky wrote:
> > +static void ionic_flush_qs(struct ionic_ibdev *dev)
> > +{
> > +	struct ionic_qp *qp, *qp_tmp;
> > +	struct ionic_cq *cq, *cq_tmp;
> > +	LIST_HEAD(flush_list);
> > +	unsigned long index;
> > +
> > +	/* Flush qp send and recv */
> > +	rcu_read_lock();
> > +	xa_for_each(&dev->qp_tbl, index, qp) {
> > +		kref_get(&qp->qp_kref);
> > +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
> > +	}
> > +	rcu_read_unlock();
> 
> Same question as for CQ. What does RCU lock protect here?

It should protect the kref_get against free of qp. The qp memory must
be RCU freed.

But this pattern requires kref_get_unless_zero()

Jason

