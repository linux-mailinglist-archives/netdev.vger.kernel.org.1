Return-Path: <netdev+bounces-104021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EBC90AE8A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DA91C20C54
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C62F194C9C;
	Mon, 17 Jun 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="temkr+ko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A3186294
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629371; cv=none; b=IdzF06kU37VTLrdlVlczYfS4ehRbJPSkDgkwIrWkEUryb3KIxLlZRfTyJIAkP7hf9j1t6TvVb40GV8E00TvjQzxFuiPNlzt04U3NNSyIA52RqyAl75ms8GJRGIlzw771iDH6r70ox3V9VjD0O5MMprhnrxyqleiigC/zfcespno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629371; c=relaxed/simple;
	bh=TRpITMfhSedBWCyK8bo5vy9+rNDpUJBCcfGkU+oVsl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GryOnANOy+goFyeCNka29jUXyR2VRRpllvh27jNOSxKkuDfithv88cred8h2i91IsgxymMMpAtzh9Zb+hqzWfiAji94D4fELCZvAWmySXTNDL2g81Usb919elu32QYnF1ERWbeEh9p1nuOSgjQas07upy11VZiHgGt0f6942I1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=temkr+ko; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f13dddf7eso524229066b.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 06:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718629368; x=1719234168; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IPWu6UjDZMnQVTRsZX0tk4x7xzpqv9lDVHERGvbzAHw=;
        b=temkr+koJoVWlHdG/HBKUxDCmvwXgmgR+Q24OF4DQwwS2ZntPNQs2VBl4HL7X8MrZn
         r2Z2F1vSe+3TsqS9lPf9X+ZR9nCzLS9mRGCP7pyjwPXpB6szM8lykMP7YBwxK02bu40P
         fjMDHwymsZMMvEyp/h+kZ26FF9ik4zHq7oDmasPb1YR08RyDG8m5PdAlona0gSuPVF2/
         g3q0agwQcIrkF4mqr0v/YPdM/ICE7cxDgpZKDiXIKFBROV6PMYr4xsSqXEHT6JwB6ERW
         hLI4HIWawOQ7a0U9uqelJoGlAzAayACKbFA19WesD3sdu4lJGp0oP+KDkZELWARPzn25
         WMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718629368; x=1719234168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPWu6UjDZMnQVTRsZX0tk4x7xzpqv9lDVHERGvbzAHw=;
        b=mJJ7rFNcJxl31yWIaMVAA2LZxUIBDmBcmC3L7NWCANyK3bg1Cwmn32Jk6rzXuUrwLr
         qpLVtyC5qmnLEGP/Jtw/envAyR8aZo+NPVjsu/OrJXoXle6LMTt5BFN4AK3m55sGi/+t
         Z+0nMwPDqJmfNTS5BVilPeGTFa7tEnYl4/f+uJ6E8TSCCqYWdcftTCQNC9MblVD7Bw7l
         ogHDVMHcOJL5pJf8xnvp+IJZCbknZePqtCj1awM4nJgH7znzvtr9mHVN6RiSS3so+CJy
         wjJanghiTkJO4Yob47bjRHgjTHru1jLKiiKvpMrUrgbXxPsko8E/8aiV7R2PKOUybEgh
         XyPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7wvxRsuOjtJNRpq+Y8kbJGzXNjbGr9W3H5tlSncN+7JTkN+5X5u0Co3ysBcAEjcv1xNZ4EGomhnaGvX64tigaKeE64c7T
X-Gm-Message-State: AOJu0YyUJpU7yIixQKYuGH87UVDBfIhl5D1IMtAWHwVn0BpFjsohs0N8
	HVnervnRZIZbiB+MWr0Eyp1SuWkC85sZms8ZH7Ps/9778oMd29atNoXupQlUrzc=
X-Google-Smtp-Source: AGHT+IGcudZokFT78RyZ7cYSlZbHBwzJ8nGrQcqcTLF+Nm30y+RQMLNd7Az1DxCGUnWXSUhfn6Te8w==
X-Received: by 2002:a17:906:c0cc:b0:a6f:16c7:9130 with SMTP id a640c23a62f3a-a6f60d2976bmr640523766b.28.1718629367294;
        Mon, 17 Jun 2024 06:02:47 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cddba1b0esm2137421a12.84.2024.06.17.06.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:02:46 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:02:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Cindy Lu <lulu@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <ZnAz8xchRroVOyCY@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <CACGkMEtKFZwPpzjNBv2j6Y5L=jYTrW4B8FnSLRMWb_AtqqSSDQ@mail.gmail.com>
 <PH0PR12MB5481BAABF5C43F9500D2852CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAETXPWG2BvyqSc@nanopsycho.orion>
 <PH0PR12MB5481F6F62D8E47FB6DFAD206DCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ZnAgefA1ge11bbFp@nanopsycho.orion>
 <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR12MB548116966222E720D831AA4CDCCD2@PH0PR12MB5481.namprd12.prod.outlook.com>

Mon, Jun 17, 2024 at 01:48:02PM CEST, parav@nvidia.com wrote:
>
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Monday, June 17, 2024 5:10 PM
>> 
>> Mon, Jun 17, 2024 at 11:44:53AM CEST, parav@nvidia.com wrote:
>> >
>> >> From: Jiri Pirko <jiri@resnulli.us>
>> >> Sent: Monday, June 17, 2024 3:09 PM
>> >>
>> >> Mon, Jun 17, 2024 at 04:57:23AM CEST, parav@nvidia.com wrote:
>> >> >
>> >> >
>> >> >> From: Jason Wang <jasowang@redhat.com>
>> >> >> Sent: Monday, June 17, 2024 7:18 AM
>> >> >>
>> >> >> On Wed, Jun 12, 2024 at 2:30 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >> >
>> >> >> > Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>> >> >> > >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> >> >> > >> Add new UAPI to support the mac address from vdpa tool
>> >> >> > >> Function
>> >> >> > >> vdpa_nl_cmd_dev_config_set_doit() will get the MAC address
>> >> >> > >> from the vdpa tool and then set it to the device.
>> >> >> > >>
>> >> >> > >> The usage is: vdpa dev set name vdpa_name mac
>> >> >> > >> **:**:**:**:**:**
>> >> >> > >
>> >> >> > >Why don't you use devlink?
>> >> >> >
>> >> >> > Fair question. Why does vdpa-specific uapi even exist? To have
>> >> >> > driver-specific uapi Does not make any sense to me :/
>> >> >>
>> >> >> It came with devlink first actually, but switched to a dedicated uAPI.
>> >> >>
>> >> >> Parav(cced) may explain more here.
>> >> >>
>> >> >Devlink configures function level mac that applies to all protocol
>> >> >devices
>> >> (vdpa, rdma, netdev) etc.
>> >> >Additionally, vdpa device level mac can be different (an additional
>> >> >one) to
>> >> apply to only vdpa traffic.
>> >> >Hence dedicated uAPI was added.
>> >>
>> >> There is 1:1 relation between vdpa instance and devlink port, isn't it?
>> >> Then we have:
>> >>        devlink port function set DEV/PORT_INDEX hw_addr ADDR
>> >>
>> >Above command is privilege command done by the hypervisor on the port
>> function.
>> >Vpda level setting the mac is similar to a function owner driver setting the
>> mac on the self netdev (even though devlink side has configured some mac for
>> it).
>> >For example,
>> >$ ip link set dev wlan1 address 00:11:22:33:44:55
>> 
>> Hmm, under what sceratio exacly this is needed?
>The administrator on the host creating a vdpa device for the VM wants to configure the mac address for the VM.
>This administrator may not have the access to the devlink port function.
>Or he may just prefer a different MAC (theoretical case).

Right, but that is not reason for new uapi but rather reason to alter
existing devlink model to have the "host side". We discussed this many
times.


>
>> I mean, the VM that has VDPA device can actually do that too. 
>VM cannot do. Virtio spec do not allow modifying the mac address.

I see. Any good reason to not allow that?


>
>> That is the actual function owner.
>vdpa is not mapping a whole VF to the VM.
>It is getting some synthetic PCI device composed using several software (kernel) and user space layers.
>so VM is not the function owner.

Sure, but owner of the netdev side, to what the mac is related. That is
my point.

