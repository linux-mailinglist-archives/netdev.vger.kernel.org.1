Return-Path: <netdev+bounces-37269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 728617B47FC
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 90290281827
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE675179A1;
	Sun,  1 Oct 2023 14:22:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273889CA43
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 14:22:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C27AB
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696170160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pS/deKlBkZMul+LFIgWetgiJ2B6GYe7768vqbID1y4s=;
	b=ApmnCe5IKGekC6uXJM31sdVgH21DubGubAOBwd/nRLlcORO175FBnDyV8RgrusIiV2rw8k
	2dnyn6+2b/94A8mRcCJr9e/6ezg7bajLYt3veV+A+zormntOV8taXCoiigVE7O17cGxW+c
	TtAha9r1XfavU1WXPBbWt9HN410WXXA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-fAvuYCZZMPSNNDXoT6f8Pw-1; Sun, 01 Oct 2023 10:22:39 -0400
X-MC-Unique: fAvuYCZZMPSNNDXoT6f8Pw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77405179afdso2591363285a.1
        for <netdev@vger.kernel.org>; Sun, 01 Oct 2023 07:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696170158; x=1696774958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pS/deKlBkZMul+LFIgWetgiJ2B6GYe7768vqbID1y4s=;
        b=iZJvZWuOpy5fWMJQKCPdhI/m1CTqLHyh/QneKmQimSfIPcX+HGw+ekHprWroUjwvrT
         U7isAFxB4l2W92410eh3yKLfC+ByljR7ucYKEoB907unfxFlTpVCYD2GKOJuQyvoDP4Q
         r0NnqUNomL3ysBwQYXI2H1HbXA/zYvx4rZWvo+z1GHgd9q2jSYGIR6f5xOvITaH0vi+V
         vkFqX2jCNJtu0C0HPA2Vq/jFXEXSk/7UyyhqQpA4Tx/5+YEiJqxTkkR3ABUSrIHVFhnr
         wP0XQWjGGbmc33/i/Twa/k9sqPy4SziBrNX5lgylciPf/CN9u4UL+TxzC6qbVQcHrgc9
         ikYA==
X-Gm-Message-State: AOJu0YwqNKMdhT3+aYswWqwIMGSo4Pe1G4KyXFxaiyfih5taIK8OdYuK
	XZpHK2jVIVBz3GTUX7e6L64wTRf4vB/siNulyrwNf6rVKJcweO1h4ueF+S9pHshWR5/J5/Y7MPV
	HQr+pTXX2H2zysdIW
X-Received: by 2002:a05:620a:2992:b0:773:d99a:49e9 with SMTP id r18-20020a05620a299200b00773d99a49e9mr12568592qkp.66.1696170158523;
        Sun, 01 Oct 2023 07:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoEB2QAvrRIoNJUdcES86FH6wLkRgYY8YbnsxzOnPpV1YyGPz5hvVFbl3TQJU9hwHYDcqubw==
X-Received: by 2002:a05:620a:2992:b0:773:d99a:49e9 with SMTP id r18-20020a05620a299200b00773d99a49e9mr12568566qkp.66.1696170158173;
        Sun, 01 Oct 2023 07:22:38 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id f19-20020a05620a15b300b0076f1d8b1c2dsm8317668qkk.12.2023.10.01.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 07:22:37 -0700 (PDT)
Date: Sun, 1 Oct 2023 07:22:36 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hannes Reinecke <hare@suse.de>, Chris Leech <cleech@redhat.com>, 
	Christoph Hellwig <hch@lst.de>, Rasesh Mody <rmody@marvell.com>, 
	Ariel Elior <aelior@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, John Meneghini <jmeneghi@redhat.com>, 
	Lee Duncan <lduncan@suse.com>, Mike Christie <michael.christie@oracle.com>, 
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
 <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
 <2023093002-unlighted-ragged-c6e1@gregkh>
 <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de>
 <2023100114-flatware-mourner-3fed@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100114-flatware-mourner-3fed@gregkh>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 01, 2023 at 01:57:25PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 01, 2023 at 12:44:05PM +0200, Hannes Reinecke wrote:
> > On 9/30/23 20:28, Greg Kroah-Hartman wrote:
> > > On Sat, Sep 30, 2023 at 11:19:20AM -0700, Chris Leech wrote:
> > > > On Sat, Sep 30, 2023 at 09:06:51AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Fri, Sep 29, 2023 at 10:00:23AM -0700, Chris Leech wrote:
> > > > > > Make use of the new UIO_MEM_DMA_COHERENT type to properly handle mmap
> > > > > > for dma_alloc_coherent buffers.
> > > > > 
> > > > > Why are ethernet drivers messing around with UIO devices?  That's not
> > > > > what UIO is for, unless you are trying to do kernel bypass for these
> > > > > devices without anyone noticing?
> > > > > 
> > > > > confused,
> > > > 
> > > > It's confusing. The bnx2 driver stack included a cnic (converged nic?)
> > > > module that sits between the ethernet drivers (bnx2, bnx2x) and protocol
> > > > offload drivers (iscsi, fcoe, rdma).
> > > > 
> > > > The iscsi module (bnx2i) uses a passthrough interface from cnic to
> > > > handle some network configuration that the device firmware doesn't do.
> > > > It uses a uio device and a userspace component called iscsiuio to do
> > > > that.
> > > 
> > > That's horrible, and not what the UIO api is for at all.  Configure the
> > > device like any other normal kernel device, don't poke at raw memory
> > > values directly, that way lies madness.
> > > 
> > > Have a pointer to the userspace tool anywhere?  All I found looks like a
> > > full IP stack in userspace under that name, and surely that's not what
> > > this api is for...
> > > 
> > But that's how the interface is used, in particular for the bnx2i driver.
> > Problem is that the bnx2i iSCSI offload is just that, an iSCSI offload. Not
> > a TCP offload. So if the iSCSI interface is configured to
> > acquire the IP address via DHCP, someone has to run the DHCP protocol.
> > But the iSCSI offload can't, and the bnx2i PCI device is not a network
> > device so that the normal network stack can't be used.
> > And so the architects of the bnx2i card decided to use UIO to pass
> > the network traffic to userspace, and used the userspace 'iscsiuio'
> > application to run DHCP in userspace.
> > 
> > But's been that way for several years now; so long, in fact, that
> > the card itself has been out of support from Marvell (since quite some
> > years, too, IIRC). And even the successor of that card (the qedi driver)
> > is nearing EOL. Mind you, the qedi driver is using the same interface (by
> > using UIO to run DHCP in userspace), so singling out the bnx2i for bad
> > design can be construed as being unfair :-)
> 
> Ok, let's say they are all horrible! :)
> 
> > I agree, though, that the design is a mess.
> 
> Ok, so why are we papering over it and continuing to allow it to exist?
>
> What "broke" to suddenly require this UIO change?  If this has been
> around for a very long time, what has caused this to now require the UIO
> layer to change?
> 
> thanks,
> 
> greg k-h

Changes last year to the dma-mapping api to no longer allow __GFP_COMP,
in particular these two (from the e529d3507a93 dma-mapping pull for
6.2):

ffcb75458460 dma-mapping: reject __GFP_COMP in dma_alloc_attrs | 2022-11-21 | (Christoph Hellwig)
bb73955c0b1d cnic: don't pass bogus GFP_ flags to dma_alloc_coherent | 2022-11-21 | (Christoph Hellwig)


Regards,
Jerry


