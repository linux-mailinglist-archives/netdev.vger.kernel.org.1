Return-Path: <netdev+bounces-104089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2381A90B20E
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A911C23267
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59861B3F2B;
	Mon, 17 Jun 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7q5Dw8/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1619B581
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632050; cv=none; b=nKO/BYJ6ZucK4I6BFcfRQIVeByDaHR/ZWjm+gm0Ve0+kzuk+ZogieCj48wpCgBPxIxrmms0qRI6P7YYcDTrxHBPgmvK0LucXuR11nLamkDGIsGoXJLboYb5rIz/b23eRIAcGEQ/+ztNxJRWPYad/1NPeMwUH9V0yc4M/Bnn7OnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632050; c=relaxed/simple;
	bh=9vMowxz1Q+3I2YwsUDY+sWrqcLKaTWtnkDjXYlErIX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7yeJEed8B2NU8lhj1dvS7rO32G61xobQcgHGi5hBVsRkMq9WM3hZfFZWE0Suvd97InS7IM5zGO57L0tTip/1coqJFzioRAfUvph+2ofAdyX+HtDobic74Ydzlt/5UpJCFU8vpKLPgCdq5HVdtk5kgSjk6gurbf2PZ0mAgM8dzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7q5Dw8/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718632047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxMIasYgmKOwN2Uh/eYVqv+BqAex9HFyWItgJcmfmCI=;
	b=O7q5Dw8/Tu4LsTSVuw+lxQoLyCG5Syfrntmy4uCiVHwiZiqZUHPaDG2DRnlrVHzsSCZHxo
	rzVuoAO+Yfv3h737pZjETFghjdp2tpAVaplVIbFurD6nPMHSOUL/WXZFM2OmUV6jVFOZy7
	O/vyCPjTrj5jHmAsT9YXsBK3VWIiuSY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-vLLqioagMbWdzM9etQ9sgQ-1; Mon, 17 Jun 2024 09:47:26 -0400
X-MC-Unique: vLLqioagMbWdzM9etQ9sgQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421739476b3so38309695e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 06:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632045; x=1719236845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxMIasYgmKOwN2Uh/eYVqv+BqAex9HFyWItgJcmfmCI=;
        b=BcjCbEkwsJDZ6ZyFXzOOwzlmZDvpY4jfWu9afltxmrU+F/Q+8Hp2EmxpnAcLMEl2zj
         xTkkjgJOB8K9etBtBy03pxTKUlQbvREHM9TBPzMhKnmvET8t8lMSUVMpNlc63660QHxJ
         QKO+GlBtariYcKQbb5sYTziiAz0cgzBkfTIUSHovxmLTrKv3SxaTecUGINeKlD9fbexX
         H0rdjNVNho1zL+YFUA+ut34La9E6Cm81k9+fsZgZWTWUIQun5q5KHyA0ZOPSv3j/oZ03
         3BnaV+bxS3CUjvS8URmsEO9dKbxhNxOnKXtpG6e2ozPqRaScKvJpvgfbmSg2HaioJMcs
         FsoA==
X-Forwarded-Encrypted: i=1; AJvYcCX1JW9NDmqCmQkmXGh4JZW21TLy5Hawq0NRnEab75bYVZBopnqAIwbrerVSOtkskTz4kB12SGPNwPYpw8wTt+q0rOneHL7Y
X-Gm-Message-State: AOJu0Ywa2wz927usFHUtnUP1izCyRHlVJehdIw0Aw0X8Rc/P1dLjvhI1
	ZmVmdcLApc2HYTze2Mp7Us2hrHqlg8agzpubxpS+JSRwaFwBWbyefZDFRKtudlCYVtdGOuAnXoF
	hDe0Nrdiqz4G106UW9nI9A/BqDVwUmzGZYLmvYw/b653ICdIz42xl5w==
X-Received: by 2002:a05:600c:3b06:b0:422:1705:7549 with SMTP id 5b1f17b1804b1-42304844acamr91904775e9.25.1718632045327;
        Mon, 17 Jun 2024 06:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDkRJ1ZBxBFsxD0RRnuf9bQWNjc837sVUfnG+M/dHrjMGzbYj/nvXPGpSefPzRBftuhU0mNA==
X-Received: by 2002:a05:600c:3b06:b0:422:1705:7549 with SMTP id 5b1f17b1804b1-42304844acamr91904525e9.25.1718632044859;
        Mon, 17 Jun 2024 06:47:24 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7439:b500:58cc:2220:93ce:7c4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750acd7csm11936995f8f.52.2024.06.17.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:47:24 -0700 (PDT)
Date: Mon, 17 Jun 2024 09:47:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240617094314-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
 <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion>
 <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAgefA1ge11bbFp@nanopsycho.orion>
 <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAz8xchRroVOyCY@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnAz8xchRroVOyCY@nanopsycho.orion>

On Mon, Jun 17, 2024 at 03:02:43PM +0200, Jiri Pirko wrote:
> Mon, Jun 17, 2024 at 01:48:02PM CEST, parav@nvidia.com wrote:
> >
> >> From: Jiri Pirko <jiri@resnulli.us>
> >> Sent: Monday, June 17, 2024 5:10 PM
> >> 
> >> Mon, Jun 17, 2024 at 11:44:53AM CEST, parav@nvidia.com wrote:
> >> >
> >> >> From: Jiri Pirko <jiri@resnulli.us>
> >> >> Sent: Monday, June 17, 2024 3:09 PM
> >> >>
> >> >> Mon, Jun 17, 2024 at 04:57:23AM CEST, parav@nvidia.com wrote:
> >> >> >
> >> >> >
> >> >> >> From: Jason Wang <jasowang@redhat.com>
> >> >> >> Sent: Monday, June 17, 2024 7:18 AM
> >> >> >>
> >> >> >> On Wed, Jun 12, 2024 at 2:30 PM Jiri Pirko <jiri@resnulli.us> wrote:
> >> >> >> >
> >> >> >> > Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >> >> >> > >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> >> >> > >> Add new UAPI to support the mac address from vdpa tool
> >> >> >> > >> Function
> >> >> >> > >> vdpa_nl_cmd_dev_config_set_doit() will get the MAC address
> >> >> >> > >> from the vdpa tool and then set it to the device.
> >> >> >> > >>
> >> >> >> > >> The usage is: vdpa dev set name vdpa_name mac
> >> >> >> > >> **:**:**:**:**:**
> >> >> >> > >
> >> >> >> > >Why don't you use devlink?
> >> >> >> >
> >> >> >> > Fair question. Why does vdpa-specific uapi even exist? To have
> >> >> >> > driver-specific uapi Does not make any sense to me :/
> >> >> >>
> >> >> >> It came with devlink first actually, but switched to a dedicated uAPI.
> >> >> >>
> >> >> >> Parav(cced) may explain more here.
> >> >> >>
> >> >> >Devlink configures function level mac that applies to all protocol
> >> >> >devices
> >> >> (vdpa, rdma, netdev) etc.
> >> >> >Additionally, vdpa device level mac can be different (an additional
> >> >> >one) to
> >> >> apply to only vdpa traffic.
> >> >> >Hence dedicated uAPI was added.
> >> >>
> >> >> There is 1:1 relation between vdpa instance and devlink port, isn't it?
> >> >> Then we have:
> >> >>        devlink port function set DEV/PORT_INDEX hw_addr ADDR
> >> >>
> >> >Above command is privilege command done by the hypervisor on the port
> >> function.
> >> >Vpda level setting the mac is similar to a function owner driver setting the
> >> mac on the self netdev (even though devlink side has configured some mac for
> >> it).
> >> >For example,
> >> >$ ip link set dev wlan1 address 00:11:22:33:44:55
> >> 
> >> Hmm, under what sceratio exacly this is needed?
> >The administrator on the host creating a vdpa device for the VM wants to configure the mac address for the VM.
> >This administrator may not have the access to the devlink port function.
> >Or he may just prefer a different MAC (theoretical case).
> 
> Right, but that is not reason for new uapi but rather reason to alter
> existing devlink model to have the "host side". We discussed this many
> times.
> 
> 
> >
> >> I mean, the VM that has VDPA device can actually do that too. 
> >VM cannot do. Virtio spec do not allow modifying the mac address.
> 
> I see. Any good reason to not allow that?
> 
> 
> >
> >> That is the actual function owner.
> >vdpa is not mapping a whole VF to the VM.
> >It is getting some synthetic PCI device composed using several software (kernel) and user space layers.
> >so VM is not the function owner.
> 
> Sure, but owner of the netdev side, to what the mac is related. That is
> my point.


I don't know what this discussion is about, at this point.
For better or worse, vdpa gained interfaces for provisioning
new devices. Yes the solution space was wide but it's been there
for years so kind of too late to try and make people
move to another interface for that.

Having said that, vdpa interfaces are all built around
virtio spec. Let's try to stick to that.


-- 
MST


