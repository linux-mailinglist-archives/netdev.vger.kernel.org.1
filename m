Return-Path: <netdev+bounces-226460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB48EBA0B59
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF2F1BC4ED4
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298B3306B0A;
	Thu, 25 Sep 2025 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL0FUbIP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555E4C81
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819370; cv=none; b=uVBOJvBNIPJDVaWgNbI8gauRSVBXt1d5zgCcw31nK7fk3LpXuhDbLlzNXYO1Nm6WfJHdnJJ1bjzVooZ+ozGUke/whkK3ZEFDCo+a60Neep0WFP+fzkQ8S+3/0YqiA7aKX2e+kC2EL9PtVAmZ2rN5CVEywx+k0S44AR+51fLPlR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819370; c=relaxed/simple;
	bh=suu5B7JT+nltyxVLocDs4lzGj2tyeaQ92aGBTUkPsc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQMh5m1DXByjaJkIq59jQR+qxcMowNls2H68IeSw5tqKn0GPpW4tlsVni6H4FEATO2pli59/YQmoPKVcWNjhL82YAph+u68dklxtMWuKjtl4xd0/lCM8EoW0K5ejBIQEaQv7w03D7L6wJ60TczOPtTkOs1//wSTTCkuvnKmK8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AL0FUbIP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758819367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExJlMZbEeqHx17txFFfBUFBbqoWdfhaK/jRKu008q3E=;
	b=AL0FUbIPMRcHvgUAv7XkqQJzMCZ0LgeEgVAzD69Gfo+d0ciDy8cVyZgHQd7QRfYBZDjLsb
	MKmKuCMGkckRAsmb5SjX10PjUb9D4ShehzMD84AMsB8WUtmWsRZTu+p5pKDDbrtsN0x+og
	55Zy9ZDf62s4qtEX7IgH5JyWbDYl5JE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-n0ALBR6BM12gZA5UruXvXQ-1; Thu, 25 Sep 2025 12:56:05 -0400
X-MC-Unique: n0ALBR6BM12gZA5UruXvXQ-1
X-Mimecast-MFC-AGG-ID: n0ALBR6BM12gZA5UruXvXQ_1758819365
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e25f5ed85so7706935e9.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758819364; x=1759424164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExJlMZbEeqHx17txFFfBUFBbqoWdfhaK/jRKu008q3E=;
        b=mnLULIOog1LUZX0e7S4ah5CgudO6ZV2SRnApTD2Sitqog7t0UGJeMKVTYzzQaGuq2w
         3KYVC6B1cwQckfLxsJUMUQ6Twx0KXr/ubobr+ED1NzdLtIP4RUMnLGdGRdTggAsxcrQC
         pgPFVvx644rzDFFESfA8L5EdbMEQyvyc6pFsn/DF6WnuS631CHBVTelSyUIZ3f3aIii+
         s0RqjHgfzdlcRDWmtiBfQQlNvnMYLZyAsDtYBNHE9ZUjQL1fqwtTWYHApXxSIwS/MOk6
         da2rfBU8xtiizuOZIBXuWssj24e6eeWIypMFO3Qee0SPCgPTsMxVDz74kLwYLg5Lc/B8
         59Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWQrHHRKXVaXfsQYMxXLd0us0YIWTE1zzwSiy+JKvKj5b59DbRNhqZqEqW/T+Iz78OMa6RuLQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTBHNx6nWLnAToKrGx0Ej8K+wBr5OCF44zKYhbdoL6sU+Cis4M
	tzfD+Ynvet0EzaEyRHir0uCpHvmSXHruOOZjORCl+dl2k0UOKYaZx5WVdiXY88X8yqIFF5yAPIa
	BFE+CKu1A97UtstBCqFaZHc416LPBNduFkO1E0aPxiFuFO6gMyv1ynCnMJw==
X-Gm-Gg: ASbGncsnb7M7LScm5/+pddRUFVVtKKb7qEpgL3xLZxFyp9fT8Gh2Spahhj2MThsTCUq
	E/pOqm66duUZXUvozxJWkEyg6n917eVqAw104LNsKQwN6kNODwI86Zju1BKHnOzBoU8dAyBVdZR
	OFyI62U9Db62WbTRFR045pKSAukpOpCmSwFZfoqVujDKCIkdSYvACXnd4D4ej0IaiGyfAwSPQna
	eaE8Fko6/KgdqJneoaReEk+WPCL3XD9eW+8b3p2r2ju0cIYejNwLYESu+XBivfsjLevqTXdYc0A
	hjkKXrf80RKVR0aCCkjqVtwBTiEGdqe1pA==
X-Received: by 2002:a05:600c:4512:b0:46d:996b:828c with SMTP id 5b1f17b1804b1-46e329e3f76mr51429855e9.10.1758819364296;
        Thu, 25 Sep 2025 09:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeAb6b4av0W9CmbCIL5oQM/OPUBcpXLL9D5kvrebwEqAmOtmw5A6IkqGOvrgEx/Y5psyxduw==
X-Received: by 2002:a05:600c:4512:b0:46d:996b:828c with SMTP id 5b1f17b1804b1-46e329e3f76mr51427825e9.10.1758819363315;
        Thu, 25 Sep 2025 09:56:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb871c811sm3677653f8f.15.2025.09.25.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:56:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 12:55:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250925125528-mutt-send-email-mst@kernel.org>
References: <20250924021637-mutt-send-email-mst@kernel.org>
 <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
 <20250925021351-mutt-send-email-mst@kernel.org>
 <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>
 <20250925062741-mutt-send-email-mst@kernel.org>
 <92ca5ed1-629d-4dc3-85fc-f1c6299a42ba@nvidia.com>
 <20250925074814-mutt-send-email-mst@kernel.org>
 <b3a7715a-5826-4395-9cc3-73bac8c26a63@nvidia.com>
 <20250925085537-mutt-send-email-mst@kernel.org>
 <bc70cd99-31a5-44d4-9648-20dcd80e9f8f@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc70cd99-31a5-44d4-9648-20dcd80e9f8f@nvidia.com>

On Thu, Sep 25, 2025 at 11:53:50AM -0500, Dan Jurgens wrote:
> On 9/25/25 8:08 AM, Michael S. Tsirkin wrote:
> > On Thu, Sep 25, 2025 at 05:39:54PM +0530, Parav Pandit wrote:
> >>
> >> On 25-09-2025 05:19 pm, Michael S. Tsirkin wrote:
> >>> On Thu, Sep 25, 2025 at 04:15:19PM +0530, Parav Pandit wrote:
> >>>> On 25-09-2025 04:05 pm, Michael S. Tsirkin wrote:
> >>>>> On Thu, Sep 25, 2025 at 03:21:38PM +0530, Parav Pandit wrote:
> >>>>>> Function pointers are there for multiple transports to implement their own
> >>>>>> implementation.
> >>>>> My understanding is that you want to use flow control admin commands
> >>>>> in virtio net, without making it depend on virtio pci.
> >>>> No flow control in vnet.
> >>>>> This why the callbacks are here. Is that right?
> >>>> No. callbacks are there so that transport agnostic layer can invoke it,
> >>>> which is drivers/virtio/virtio.c.
> >>>>
> >>>> And transport specific code stays in transport layer, which is presently
> >>>> following config_ops design.
> >>>>
> >>>>> That is fair enough, but it looks like every new command then
> >>>>> needs a lot of boilerplate code with a callback a wrapper and
> >>>>> a transport implementation.
> >>>> Not really. I dont see any callbacks or wrapper in current proposed patches.
> >>>>
> >>>> All it has is transport specific implementation of admin commands.
> >>>>
> >>>>>
> >>>>> Why not just put all this code in virtio core? It looks like the
> >>>>> transport just needs to expose an API to find the admin vq.
> >>>> Can you please be specific of which line in the current code can be moved to
> >>>> virtio core?
> >>>>
> >>>> When the spec was drafted, _one_ was thinking of admin command transport
> >>>> over non admin vq also.
> >>>>
> >>>> So current implementation of letting transport decide on how to transport a
> >>>> command seems right to me.
> >>>>
> >>>> But sure, if you can pin point the lines of code that can be shifted to
> >>>> generic layer, that would be good.
> >>> I imagine a get_admin_vq operation in config_ops. The rest of the
> >>> code seems to be transport independent and could be part of
> >>> the core. WDYT?
> >>>
> >> IMHV, the code before vp_modern_admin_cmd_exec() can be part of
> >> drivers/virtio/virtio_admin_cmds.c and admin_cmd_exec() can be part of the
> >> config ops.
> >>
> >> However such refactor can be differed when it actually becomes boiler plate
> >> code where there is more than one transport and/or more than one way to send
> >> admin cmds.
> > 
> > Well administration virtqueue section is currently not a part of a
> > transport section in the spec.  But if you think it will change and so
> > find it cleaner for transports to expose, instead of a VQ, a generic
> > interfaces to send an admin command, that's fine too. That is still a
> > far cry from adding all the object management in the transport. 
> > 
> > 
> > Well we have all the new code you are writing, and hacking around
> > the fact it's in the wrong module with a level of indirection
> > seems wrong.
> > If you need help moving this code let me know, it's not hard.
> > 
> >> Even if its done, it probably will require vfio-virtio-pci to interact with
> >> generic virtio layer. Not sure added value of that complication to be part
> >> of this series.
> >>
> >>
> >> Dan,
> >>
> >> WDYT?
> > 
> > 
> > virtio pci pulls in the core already, and VFIO only uses the SRIOV
> > group, so it can keep using the existing pci device based interfaces,
> > if you prefer.
> > 
> 
> I can make changes here. I'd appreciate if you review the rest of the
> series while I do so. Patches 3+ are isolated from this, so it won't be
> a waste of your time.

OK - will review 3+, thanks!

-- 
MST


