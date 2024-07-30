Return-Path: <netdev+bounces-114133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F726941194
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624BE1C22DF2
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C4319DFA5;
	Tue, 30 Jul 2024 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yF8Co7Gd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D0199236
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341423; cv=none; b=IkLrGNOaMGTAdYX5vRrqgbP7dbvNzoO9i5Cw2S5+JMvaKwGKKpbs3pdN9u0ogOtXx8WWGNPADVCouRBxlNO7vOF2GsIYPBt5EMRSt9skOFFTGDFw7kk7og186B/DesF7SYkkt1DO6jeOL0/p3VCZNxGefCa83Z9bU2SBmG5nPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341423; c=relaxed/simple;
	bh=8MyQXEjIo5Z6lwcI0i8Rsr6uEVSlvFfloF8wK8T4zg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/epHS8KQKCs73lA8ku7fGbOhQbXHKd7268X+y3WZCQgcvt2uq2Ef1m6AOCX/PZh93A4patVj6FeznMixL4W/CvkVoahTS54PqffRFD7Fd8EmVeRoSn2iAZxMPTmdlED9fyxEdRYLXP/QfaQJvcJD/DK2rQhliZ7mwIQUjwUNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yF8Co7Gd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so619134766b.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 05:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722341419; x=1722946219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bl9U89NZkQLetPuLLdCv9VXdS+EHZzxCVJpeKzgkK3A=;
        b=yF8Co7Gd9H1ayhFon6llD1nMkTrWNHM1HcbYnFyCdvQTD+JJYAZkX7OQT8U8zTJsk9
         1bor+d5+xyEuRBU8FDow48UCMo33eDU4qQSk5FgwZUia3I8TNs5yJe+ZQxDkAVR+5zqu
         +LNbppJ/8T4YecI46Mklev09V9LkRKpgV2RldG76H5GOSjBE2zrTwrOSVd/dq7sGtu5V
         8hoGcat2s2ce85elod/RN88EtaVEf987AWBCiUuFD5BtSdiWvQBiWCAeB+kOrUuYe1kr
         NzHHxaTvW2wmTb62wgdRLkROI8qVOIZk598VpiH99GT8e1nNdhQI7Hf/tXmdnq5ZwZuv
         c9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722341419; x=1722946219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bl9U89NZkQLetPuLLdCv9VXdS+EHZzxCVJpeKzgkK3A=;
        b=bqtB3xXmoT3SHOxmE+rUt8gKZUhvIJvhyq2WmyPehkQdfFBJ/rXGqJvum5+o93N5jV
         O/GLzSFGXawzyoFADR3AlZwLvRQpTiKsfc9u6pEiQLoLFfyabuIZqa46cFbDkzSes5AS
         exj72gQ2ygPqoPlO0N4jERdZfJ5kNqM5ZmfkiUUlpJvsoB9jg1jC+LLSorRq/J7ek7ZG
         Jrs8boDRYYgxCx/Om/eRcdfeRUJcYzJ2/P+lIm35T0235xzeYHEtThoI5wC2uYs3nhIT
         mRK8GYDsTe5UUIicqQ3dSTdhio+jA+CGbofx6MWyVecdxRlKC9YkYByOfURrmrB2Nn+S
         cayg==
X-Forwarded-Encrypted: i=1; AJvYcCW78NFlAC3QXa2BNZLZmkNnWJyunxak7Z3Zo7OEmAZZJBfo12T0gf48Qz1e0/S/Wy0lde1qXAwbQSoeYfXx8GErtffV0+Um
X-Gm-Message-State: AOJu0Yx2PzL8Pg+DWxttpCHmadpsTACbMF489m6VacMo3smD9dbfJShC
	ohw+rkTvzl/HrI2AvtCKWDOBkKfub3aZtB5FrpujGe4PjxTVeFqfTiX6jriPVGE=
X-Google-Smtp-Source: AGHT+IHMAoKdwahn5AXTG8zCA408dz1YYA1YpbxCqwPZZN8DbFM0vt/yd43innO6i8IqsnXmP8FYgA==
X-Received: by 2002:a17:907:a41:b0:a7a:a212:be48 with SMTP id a640c23a62f3a-a7d4019b584mr660689366b.56.1722341419055;
        Tue, 30 Jul 2024 05:10:19 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acac632cesm638326166b.96.2024.07.30.05.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:10:18 -0700 (PDT)
Date: Tue, 30 Jul 2024 14:10:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"madhu.chittim@intel.com" <madhu.chittim@intel.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"sgoutham@marvell.com" <sgoutham@marvell.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <ZqjYKXLmeriWbYyC@nanopsycho.orion>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
 <abe35bb09ff1449eafaa6b78a1bce2110dee52e7.camel@nvidia.com>
 <ddfc4da97408f6c086a9485d155fa6aa302fac88.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddfc4da97408f6c086a9485d155fa6aa302fac88.camel@redhat.com>

Wed, Jun 05, 2024 at 05:52:32PM CEST, pabeni@redhat.com wrote:
>On Wed, 2024-06-05 at 15:04 +0000, Cosmin Ratiu wrote:
>> On Wed, 2024-05-08 at 22:20 +0200, Paolo Abeni wrote:
>> 
>> > +/**
>> > + * struct net_shaper_info - represents a shaping node on the NIC H/W
>> > + * @metric: Specify if the bw limits refers to PPS or BPS
>> > + * @bw_min: Minimum guaranteed rate for this shaper
>> > + * @bw_max: Maximum peak bw allowed for this shaper
>> > + * @burst: Maximum burst for the peek rate of this shaper
>> > + * @priority: Scheduling priority for this shaper
>> > + * @weight: Scheduling weight for this shaper
>> > + */
>> > +struct net_shaper_info {
>> > +	enum net_shaper_metric metric;
>> > +	u64 bw_min;	/* minimum guaranteed bandwidth, according to metric */
>> > +	u64 bw_max;	/* maximum allowed bandwidth */
>> > +	u32 burst;	/* maximum burst in bytes for bw_max */
>> 
>> 'burst' really should be u64 if it can deal with bytes. In a 400Gbps
>> link, u32 really is peanuts.
>> 
>> > +/**
>> > + * enum net_shaper_scope - the different scopes where a shaper could be attached
>> > + * @NET_SHAPER_SCOPE_PORT:   The root shaper for the whole H/W.
>> > + * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network device.
>> > + * @NET_SHAPER_SCOPE_VF:     The shaper is attached to the given virtual
>> > + * function.
>> > + * @NET_SHAPER_SCOPE_QUEUE_GROUP: The shaper groups multiple queues under the
>> > + * same device.
>> > + * @NET_SHAPER_SCOPE_QUEUE:  The shaper is attached to the given device queue.
>> > + *
>> > + * NET_SHAPER_SCOPE_PORT and NET_SHAPER_SCOPE_VF are only available on
>> > + * PF devices, usually inside the host/hypervisor.
>> > + * NET_SHAPER_SCOPE_NETDEV, NET_SHAPER_SCOPE_QUEUE_GROUP and
>> > + * NET_SHAPER_SCOPE_QUEUE are available on both PFs and VFs devices.
>> > + */
>> > +enum net_shaper_scope {
>> > +	NET_SHAPER_SCOPE_PORT,
>> > +	NET_SHAPER_SCOPE_NETDEV,
>> > +	NET_SHAPER_SCOPE_VF,
>> > +	NET_SHAPER_SCOPE_QUEUE_GROUP,
>> > +	NET_SHAPER_SCOPE_QUEUE,
>> > +};
>> 
>> How would modelling groups of VFs (as implemented in [1]) look like
>> with this proposal?
>> I could imagine a NET_SHAPER_SCOPE_VF_GROUP scope, with a shared shaper
>> across multiple VFs. 
>
>Following-up yday reviewer mtg - which was spent mainly on this topic -
>- the current direction is to replace NET_SHAPER_SCOPE_QUEUE_GROUP with
>a more generic 'scope', grouping of either queues, VF/netdev or even
>other groups (allowing nesting).
>
>> How would managing membership of VFs in a group
>> look like? Will the devlink API continue to be used for that? Or will
>> something else be introduced?
>
>The idea is to introduce a new generic netlink interface, yaml-based,
>to expose these features to user-space.
>
>> Looking a bit into the future now...
>> I am nowadays thinking about extending the mlx5 VF group rate limit
>> feature to support VFs from multiple PFs from the same NIC (the
>> hardware can be configured to use a shared shaper across multiple
>> ports), how could that feature be represented in this API, given that
>> ops relate to a netdevice? Which netdevice should be used for this
>> scenario?
>
>I must admit we[1] haven't thought yet about the scenario you describe
>above. I guess we could encode the PF number and the VF number in the
>handle major/minor and operate on any PF device belonging to the same
>silicon, WDYT?

Sometimes, there is no netdevice at all. The infra still should work I
believe.


>
>Thanks,
>
>Paolo
>
>[1] or at least myself;)
>

