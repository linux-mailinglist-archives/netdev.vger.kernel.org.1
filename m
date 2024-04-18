Return-Path: <netdev+bounces-89346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A6D8AA169
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9FD9B230C7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC117AD75;
	Thu, 18 Apr 2024 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lJ08rxMW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CE17AD6D
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462664; cv=none; b=CgYmwXcn+Kh9yx9jPFdX4LjH9deAizKvwgd3MOMjQnRTzoIq2CaQgYoEk0aLfu9x0Huw8Gc7f/tl8hKwVsM2ap6wjX2aRSrpRzifJ6AjqCZYgLP1Ms1nQJHafxO655U3qUF6ew04n4mdOnf3So3jhyvav20cIZu/GrRN1Iy075A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462664; c=relaxed/simple;
	bh=ICVQMXd+yWltnMkkLmPSWiJSyQlug6UXgcOqsu6RALs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUGXYMSCn3RnzNOdgulrb4PYe0Ns1GnUUvf0dHA+gXmi5cVz6FkBi+qe9zCOiBywRjZ11MEplUZhG4d0+gjh8daBzFlbZn8A3DodzXmwKcuHaGEaGWsMdO5XN4A+0XrvaK4HJpO2psQhI68YhO+4R5ElolAwkTw0oYfBlTMAkhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lJ08rxMW; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ea2ac0c217so460862a34.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713462662; x=1714067462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jYBNpNIicI/8ED5gIHnDvzk5k+KDpAJzCV70dwuFNEY=;
        b=lJ08rxMWDcbrI1Hl6SBNOrCvACyB1LRJK8rTLBm0rfyOeX/veSr2JkDbmiQU15CJoc
         nTUZHur42DqiwOKpoUchU07tCggKELuo4Pv2/OYAQE5f3Zsh8SisYBHXUzz2xb19e32t
         j7M1PflzoYzH4J8ZCR4eRntOhIlQAtEk4aWLJaK1+sG8VO9v2x/7C5tMLdjvAL5qIdND
         E8AVFxAsDGv5VXq5BmwcTleh8io2bEf7+7rOMJkQRiz4sDE7FQheFuKVQ6+jlQKqg9GJ
         g0xSY8Z/YtG9M9QCwHhUaNAp++Wu0/S+2N9Nwd74k2rh8Nly/+Pk+a2gD6Ies3McmUHH
         ZIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713462662; x=1714067462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYBNpNIicI/8ED5gIHnDvzk5k+KDpAJzCV70dwuFNEY=;
        b=nranriHaBQO5ysdAWHUkHDSGeUBmQBznxVvnZg9/fccbOhOoa4TASHD4f7mVUjjTI8
         qJUrxYtzZtqK6V5etHCHAcLWhvrVbfn7nTWHrsgZvDcQlXItlq3FhrXTB8plSwHclqh5
         1OTczSL06ojbdKhNz3OSo54xc/YYz0WbYYa/jA25Noh1lytg3XQloIFMZefVWLUgm4Dm
         eGInNbh4q3CS12222gWrz6jfwXnLYcFi+FMdnAQQekJOPwssxqkRCXMXr0o4qX4eYEbz
         NT78UhOsNvTkAtpvpMGnrC6EW+iwv7TiUYxTmA4MNBOIubefZqB0F6u7Ttdw/svUve28
         qXjA==
X-Forwarded-Encrypted: i=1; AJvYcCVs5Wg9xvcnBojRCIVU/EZJYscEkrFinNvifbEVe2vTIrK+rpTPuh5Qoad3BnsELhZE3breg+JUNlq5qKl2rBAJmrkN6qZh
X-Gm-Message-State: AOJu0YznPhlfyUMNI43VnC2PufduszAoKAw7Cy3xhXS9qatIlbDyGyzC
	+Ke3UFnginJWXIT6nqNu1FeAmMeGfhvi80eIlvO2bzI5FamDftoCCgqtly9p7JI=
X-Google-Smtp-Source: AGHT+IHAgStOV9TdoloDBt9xFRmSANx1NimuspwckNExMic3r/5mxvsR/GI8ziwcEFHL6TxWaU/P2A==
X-Received: by 2002:a05:6830:1152:b0:6eb:85bb:144d with SMTP id x18-20020a056830115200b006eb85bb144dmr1341629otq.7.1713462661747;
        Thu, 18 Apr 2024 10:51:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id s8-20020a056830148800b006eb85b34e48sm399299otq.54.2024.04.18.10.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:51:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rxVuV-00EHQx-H7;
	Thu, 18 Apr 2024 14:50:59 -0300
Date: Thu, 18 Apr 2024 14:50:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Zhu Yanjun <yanjun.zhu@linux.dev>,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Add new device attributes for mana
Message-ID: <20240418175059.GZ223006@ziepe.ca>
References: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240415161305.GO223006@ziepe.ca>
 <56b0a8c1-50f6-41a9-9ea5-ed45ada58892@linux.dev>
 <b34bfb11-98a3-4418-b482-14f2e50745d3@lunn.ch>
 <20240418060108.GB13182@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418060108.GB13182@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Wed, Apr 17, 2024 at 11:01:08PM -0700, Shradha Gupta wrote:

> > > > > +static ssize_t mana_attr_show(struct device *dev,
> > > > > +			      struct device_attribute *attr, char *buf)
> > > > > +{
> > > > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > > > +	struct gdma_context *gc = pci_get_drvdata(pdev);
> > > > > +	struct mana_context *ac = gc->mana.driver_data;
> > > > > +
> > > > > +	if (strcmp(attr->attr.name, "mport") == 0)
> > > > > +		return snprintf(buf, PAGE_SIZE, "%d\n", ac->num_ports);
> > > > > +	else if (strcmp(attr->attr.name, "adapter_mtu") == 0)
> > > > > +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->adapter_mtu);
> > > > > +	else if (strcmp(attr->attr.name, "msix") == 0)
> > > > > +		return snprintf(buf, PAGE_SIZE, "%d\n", gc->max_num_msix);
> > > > > +	else
> > > > > +		return -EINVAL;
> > > > > +
> > > > 
> > > > That is not how sysfs should be implemented at all, please find a
> > > > good example to copy from. Every attribute should use its own function
> > > > with the macros to link it into an attributes group and sysfs_emit
> > > > should be used for printing
> > > 
> > > Not sure if this file drivers/infiniband/hw/usnic/usnic_ib_sysfs.c is a good
> > > example or not.
> > 
> > The first question should be, what are these values used for? You can
> > then decide on debugfs or sysfs. debugfs is easier to use, and you
> > avoid any ABI, which will make long term support easier.
> 
> Hi Andrew,
> We want to eventually use these attributes to make the device settings configurable
> and also improve debuggability for MANA devices. I feel having these attributes 
> in sysfs would make more sense as we plan to extend the attribute list and also make
> them settable.

From an RDMA perspective this is all available from other APIs already
at least and I wouldn't want to see new sysfs unless there is a netdev
justification.

Jason

