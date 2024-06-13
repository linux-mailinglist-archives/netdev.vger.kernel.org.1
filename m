Return-Path: <netdev+bounces-103093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FE8906462
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 08:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06F2B23C38
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 06:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80A813791E;
	Thu, 13 Jun 2024 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dy6qm/lq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB958137758
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261380; cv=none; b=tWOZEulOAeae4DCqeeeQeWjPqoGtWva4ekIXldq57BpkIyHR7FA855Phfc3Q/CLFIUiw91UHIoqklHB2GlJhVKUm4XG/VxToWbreqL5HsVjLoL+dfH15clqNAMyb4L+bz/j8yJ08gJ/bIDq2dfMbcmPlSDFN/VN2wYcK042Poas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261380; c=relaxed/simple;
	bh=nOI9j21ZgI3I0MQ5EhathzuyzKyOMxQisKyvdWlhhdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT6BQT5AaGOD4+I8t8wo+aJszTG6dLJ1wIITD4AemqY8t29Us5NqRe7evl/G2+uH0mCLUHRTIDGJldIOhug6J0UbIpNP0iNbl7B7IJwRXzbMVM1WN97Fwjg/iR7p3/ZeC0lWmZP235VsXW+OxtSHhywDuCdmZBXtnjdMB90RIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dy6qm/lq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718261377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/CbSxasg15SB+kyQXKy/dPIg+1PKI2NcVPeH5mNpLbA=;
	b=dy6qm/lq5RbXzdhark2BjenYNwef36lvewkVD60vFXBffPW1MytFR95jhnrARng43AF16R
	VYAck9J77vP5mY+TnEfQOFYCaYxmEcPoc+NAmOFjxGr/kDRf2svy3NKsSuL1afM0cv2jB+
	w2oPQcigsmwK8J0W/Wtfq4lgAwhkv2Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-LoFLfLyOOYuwOXO5laiH1w-1; Thu, 13 Jun 2024 02:49:32 -0400
X-MC-Unique: LoFLfLyOOYuwOXO5laiH1w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421292df2adso4668095e9.3
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 23:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718261371; x=1718866171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CbSxasg15SB+kyQXKy/dPIg+1PKI2NcVPeH5mNpLbA=;
        b=wAmr81rwIqLPBOXVEwJuxO8KDs7/oSFBOSubdM2lZznJlrJ6LDMbEMlY548n7gWk2T
         FkgZa+Jn9HgfQ5vSLPeGTiZYr8J4i23SE+lD6T4hmRGrgoGpEKwuJFpr/rJobtfGPz1d
         CrKcd+dBQmj2sZ58+/7hXpCNVowu0FkA8RkB+2A6Sruxsd/STACidjHyRIX5thsM/E+6
         1GHrwsfG5HwDycV3/rU97lQmj4bWEL+vl9SbzC48rdQ0K8Ta+08lL6aeYOpWkkmRUemY
         6HewRBWowIqIwfGUonWcC08MRLzKgOBXntEFzEqNM/RFU2p1MMXblWGr+wyy3IT7XsaY
         xovQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg1v8l5EKL3kMBEwJbrEniJnF3hfmhK4FpPde88yDP5qW4B+0SXJyhkySl0XX0WusCseqW0pG94OatI9XbuCqtUc0z9BtD
X-Gm-Message-State: AOJu0YyknyJeo3/oqpSntfcdc6BmRt1M8tPleW1b7C64w/8Nhbr/ccOu
	ebL+OFpov6pgf1jbmDR527Jmg73+SVcJ5U1+BDL83a3HW2dNopIsBxlcxvggAlcZ8ThSMW5yl24
	nj9b8n8NMNP5B/5E1jyQHj89wATW9UWWLZkMZC1QvFufX0Jhv8HR86g==
X-Received: by 2002:a5d:4ac3:0:b0:355:161:b7e6 with SMTP id ffacd0b85a97d-35fdf7ae574mr2690497f8f.41.1718261371371;
        Wed, 12 Jun 2024 23:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2zc9YTuq67HAYl0S1ZCAGfDX9FHmtCsB3op2ROZqV+XTOIEDmRzmfD9lHK2sqlkU4bC7xmQ==
X-Received: by 2002:a5d:4ac3:0:b0:355:161:b7e6 with SMTP id ffacd0b85a97d-35fdf7ae574mr2690467f8f.41.1718261370362;
        Wed, 12 Jun 2024 23:49:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:5539:9b1a:2e49:4aac:204e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c89dsm764954f8f.25.2024.06.12.23.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 23:49:29 -0700 (PDT)
Date: Thu, 13 Jun 2024 02:49:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240613024756-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <20240612031356-mutt-send-email-mst@kernel.org>
 <ZmlMuGGY2po6LLCY@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmlMuGGY2po6LLCY@nanopsycho.orion>

On Wed, Jun 12, 2024 at 09:22:32AM +0200, Jiri Pirko wrote:
> Wed, Jun 12, 2024 at 09:15:44AM CEST, mst@redhat.com wrote:
> >On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
> >> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> >> Add new UAPI to support the mac address from vdpa tool
> >> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> >> MAC address from the vdpa tool and then set it to the device.
> >> >> 
> >> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >> >
> >> >Why don't you use devlink?
> >> 
> >> Fair question. Why does vdpa-specific uapi even exist? To have
> >> driver-specific uapi Does not make any sense to me :/
> >
> >I am not sure which uapi do you refer to? The one this patch proposes or
> >the existing one?
> 
> Sure, I'm sure pointing out, that devlink should have been the answer
> instead of vdpa netlink introduction. That ship is sailed,

> now we have
> unfortunate api duplication which leads to questions like Jakub's one.
> That's all :/



Yea there's no point to argue now, there were arguments this and that
way.  I don't think we currently have a lot
of duplication, do we?

-- 
MST


