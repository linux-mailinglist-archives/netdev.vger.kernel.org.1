Return-Path: <netdev+bounces-37324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE3F7B4CCF
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 09:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 15562281B28
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 07:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF47184E;
	Mon,  2 Oct 2023 07:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DC517F4
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 07:50:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3103BC
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 00:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696233025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L5fJ5s4tSJ75JUyYMT3IWTY1CcZbtcp06il4dgPzNKo=;
	b=ik9bHj61w33maNjNIy9zxVGHCClq0DaxOMnKTC83lPATw0xLNdVq/7zboTuomUGy7XGJeh
	mqchwl+LKxifE49X6QZx8d/7SDsXmfCZaQOkao7/A5X2NmdcABCR/GWT5xctZAWi83XJ5E
	5If4u7gOUEroupn9y4Wor4cyQ5mWmUU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-IVgZ--znN0yG3Cfvxged2g-1; Mon, 02 Oct 2023 03:50:23 -0400
X-MC-Unique: IVgZ--znN0yG3Cfvxged2g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-65cfb5ff28aso99412356d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 00:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696233023; x=1696837823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5fJ5s4tSJ75JUyYMT3IWTY1CcZbtcp06il4dgPzNKo=;
        b=ChkXrujOAfH/BzEzIA2r0cZ4ZKtwV05Au4KnJZZL3y7dMnf/+j7irUaXf7jRaVRHdF
         lBEfZnNztqYm1MIu3MLlItRKDdQ73ctHdnzFhWonjGky3UfXfz99hEPPBAF03KqflbF9
         PZ6tP6+pn/1ZdGM0US+g0PMJh/v3+XK8cVYnYQyrAisp/gevelTb1nNDxA8Y6mFgtdoe
         m51hIYzpQ8QKOO5Kxw0UgHCmE2J4bf3R3S5teuCAkVjto7yvl0eExoBnGDso5Aou+uQk
         Eg2F/ePO3VvHy4626LfTZTLhAGu4MsutDKg5qBIhMubG7pcv6hiBJe2beT7vefbKkDW/
         BnSw==
X-Gm-Message-State: AOJu0Yy3/Bkm/EqiS9QiArHXYWWF8UFNafj/U9JoFWfCjYsjV0a73t1P
	paYnSYFiqCwSChbv7/Y3t/tgXEdupbB3jRqhEzUyc+0OZr/YeC7QyNW2/IhCKbkGRXZrbdfoq5q
	/qQ/hpfd2b164zITQ
X-Received: by 2002:a0c:8d07:0:b0:655:8a4b:a3fd with SMTP id r7-20020a0c8d07000000b006558a4ba3fdmr7491379qvb.63.1696233023425;
        Mon, 02 Oct 2023 00:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIatO2dq8szhlU914qNxjhFLjpRo1iSQwCyioR13FeEegFPwRpmsPfQlILV+sD5kYQXi2J3g==
X-Received: by 2002:a0c:8d07:0:b0:655:8a4b:a3fd with SMTP id r7-20020a0c8d07000000b006558a4ba3fdmr7491357qvb.63.1696233023100;
        Mon, 02 Oct 2023 00:50:23 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id r13-20020a0cb28d000000b0064f4e0b2089sm5527376qve.33.2023.10.02.00.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:50:22 -0700 (PDT)
Date: Mon, 2 Oct 2023 00:50:21 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hannes Reinecke <hare@suse.de>, Chris Leech <cleech@redhat.com>, Rasesh Mody <rmody@marvell.com>, 
	Ariel Elior <aelior@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, John Meneghini <jmeneghi@redhat.com>, 
	Lee Duncan <lduncan@suse.com>, Mike Christie <michael.christie@oracle.com>, 
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <tf2zu6gqaii2bjipbo2mn2hz64px2624rfcmyg36rkq4bskxiw@zgjzznig6e22>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
 <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
 <2023093002-unlighted-ragged-c6e1@gregkh>
 <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de>
 <2023100114-flatware-mourner-3fed@gregkh>
 <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
 <20231002060424.GA781@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002060424.GA781@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 08:04:24AM +0200, Christoph Hellwig wrote:
> On Sun, Oct 01, 2023 at 07:22:36AM -0700, Jerry Snitselaar wrote:
> > Changes last year to the dma-mapping api to no longer allow __GFP_COMP,
> > in particular these two (from the e529d3507a93 dma-mapping pull for
> > 6.2):
> 
> That's complete BS.  The driver was broken since day 1 and always
> ignored the DMA API requirement to never try to grab the page from the
> dma coherent allocation because you generally speaking can't.  It just
> happened to accidentally work the trivial dma coherent allocator that
> is used on x86.
> 

re-sending since gmail decided to not send plain text:

Yes, I agree that it has been broken and misusing the API. Greg's
question was what changed though, and it was the clean up of
__GFP_COMP in dma-mapping that brought the problem in the driver to
light.

I already said the other day that cnic has been doing this for 14
years. I'm not blaming you or your __GFP_COMP cleanup commits, they
just uncovered that cnic was doing something wrong. My apologies if
you took it that way.

Regards,
Jerry


