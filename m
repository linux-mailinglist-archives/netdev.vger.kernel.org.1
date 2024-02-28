Return-Path: <netdev+bounces-75582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89E686A9A4
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC9A28D22F
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD1B25639;
	Wed, 28 Feb 2024 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oiPfqLfA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3365D28DA4
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108045; cv=none; b=MK8lqoPIuKWzX2lqwXdY+MB/sryaVJnB7FTAsZRDUSH4RdhFHpBdv/v/pkOYK+l/NElhZBsPcl+VsOHCx67TmfjIOqQdIZXz8EeLfQlXGJda5B8NnYvyyb7u1uhH/hXKFMeJIwJ4/Lvzu+Qhf4yswVGPB0nDyJRlaOD7PZ6n9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108045; c=relaxed/simple;
	bh=JIfcaI6Hx1poXMve2Q/K6p/5q/GmORBI+NvSADgabOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqZAEduYBzohxu0BJTkwgzIc76SI+AZN1BTmX6Kl1CNzZlZyDJblZkJ+OnvEhTckhXFQiXlOEI4QSJ97lM/mw5VU0j7d6Gb+fS2k74fpbMVOHvLkgiA9vFfCkrHdsX8yZ+lf+KBmHvQAAy4VtPIBE9pgJ9yS3vdQhgTc9+/a84A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oiPfqLfA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so40755215e9.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 00:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709108041; x=1709712841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNHgJtZtQdVU2IQ7Onv8tEEooWyqlFcC0t9o7q8FkE4=;
        b=oiPfqLfAJo8QFSzKbLufzUIWofIOvtUH4wnN01001g/nW8aZho0hLL88iRBB8dbPyk
         h+QmZ9t5vLto59kPjZr6odDSi3wFLy9QGlKaV/20KytY3VC88YIZ+93/r0tutjV5BQmE
         VBM5yoOUZgJZeRV7Dv129oEiL0Bnr/4te728q9lxrK1dj2x6ey0TdHL7vJo3MNZ/ruww
         ITuVgq+MH/SU4QJyjReNtTpyg5zfUqwjoNmzSJLpFOTzJ2PjW6Y9mfMxRncRBBOrMpE0
         PTSCvWYmnCyzCUc6lbHL6YM6Np1E5FQF5tRww2mhobG8H+HKPqRm97+MHzRogqhCvBQ/
         nN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709108041; x=1709712841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNHgJtZtQdVU2IQ7Onv8tEEooWyqlFcC0t9o7q8FkE4=;
        b=TvAvt0Fo79BEVXX+zC4GhXbskFsGOFvl4so4ilp46l3ZrP8GIhADDw4yYghn4ejgUj
         aX6ep0DhUwR+fry05ovwSAtTOT7H2wG74y+mBIqjXfHCVDUPF6bw/ybUYuyAI0fQ4wIB
         eBRrL1NvXEK/xH51vU+HaDdsye1fGVe6+EXjmUuxU9bldlq76abmpowiDSLLi18Bp2Gi
         ZBJAQ81vBT9X8qagspiVDd6JcwO1B0FOrCp30zH8ABQfAe0cwmJI+hQ/lYnYGuW6rElz
         EWS0LgTl6JaV8aP8MhRPVqBnBn4JdO6SmAEssNHm0/Z8kIeJy9JXzzocqTNYGwHz8AnG
         Jy1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDEmh8qHFVPYqSY3l0KHMAcpSSLfdzA37jE60gbftGl/yn6GZXAqh7+4V6fErctdFByc13xUroANaKe7V/pNbad74TDDu4
X-Gm-Message-State: AOJu0YxRMHgEe3E5whXF5MIKUSduXZhDSBusYEcKXmCYZ2G0GycCn4dh
	cbV59ajxXNtW9Ya4yDj88rLEtAebhwOxsV1jYMCEvpl2eyqbbpuM+5n9DZm70sQ=
X-Google-Smtp-Source: AGHT+IG9fJc49Ksu5yxEo0ijFmJSO75nNwbgZaIFSXhrPH4ZDeSXA08vEttcy33/Qfpkh3WghzJG7w==
X-Received: by 2002:a05:600c:3514:b0:412:97d7:581c with SMTP id h20-20020a05600c351400b0041297d7581cmr8114661wmq.6.1709108041275;
        Wed, 28 Feb 2024 00:14:01 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c260e00b00412a813e4cfsm1276764wma.34.2024.02.28.00.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:14:00 -0800 (PST)
Date: Wed, 28 Feb 2024 09:13:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tariq Toukan <ttoukan.linux@gmail.com>,
	Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, jay.vosburgh@canonical.com
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <Zd7rRTSSLO9-DM2t@nanopsycho>
References: <20240215030814.451812-1-saeed@kernel.org>
 <20240215030814.451812-16-saeed@kernel.org>
 <20240215212353.3d6d17c4@kernel.org>
 <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
 <20240220173309.4abef5af@kernel.org>
 <2024022214-alkalize-magnetize-dbbc@gregkh>
 <20240222150030.68879f04@kernel.org>
 <de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
 <ZdhnGeYVB00pLIhO@nanopsycho>
 <20240227180619.7e908ac4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227180619.7e908ac4@kernel.org>

Wed, Feb 28, 2024 at 03:06:19AM CET, kuba@kernel.org wrote:
>On Fri, 23 Feb 2024 10:36:25 +0100 Jiri Pirko wrote:
>> >> It's really a special type of bonding of two netdevs. Like you'd bond
>> >> two ports to get twice the bandwidth. With the twist that the balancing
>> >> is done on NUMA proximity, rather than traffic hash.
>> >> 
>> >> Well, plus, the major twist that it's all done magically "for you"
>> >> in the vendor driver, and the two "lower" devices are not visible.
>> >> You only see the resulting bond.
>> >> 
>> >> I personally think that the magic hides as many problems as it
>> >> introduces and we'd be better off creating two separate netdevs.
>> >> And then a new type of "device bond" on top. Small win that
>> >> the "new device bond on top" can be shared code across vendors.  
>> >
>> >Yes. We have been exploring a small extension to bonding driver to enable a
>> >single numa-aware multi-threaded application to efficiently utilize multiple
>> >NICs across numa nodes.  
>> 
>> Bonding was my immediate response when we discussed this internally for
>> the first time. But I had to eventually admit it is probably not that
>> suitable in this case, here's why:
>> 1) there are no 2 physical ports, only one.
>
>Right, sorry, number of PFs matches number of ports for each bus.
>But it's not necessarily a deal breaker - it's similar to a multi-host
>device. We also have multiple netdevs and PCIe links, they just go to
>different host rather than different NUMA nodes on one host.

That is a different scenario. You have multiple hosts and a switch
between them and the physical port. Yeah, it might be invisible switch,
but there still is one. On DPU/smartnic, it is visible and configurable.


>
>> 2) it is basically a matter of device layout/provisioning that this
>>    feature should be enabled, not user configuration.
>
>We can still auto-instantiate it, not a deal breaker.

"Auto-instantiate" in meating of userspace orchestration deamon,
not kernel, that's what you mean?


>
>I'm not sure you're right in that assumption, tho. At Meta, we support
>container sizes ranging from few CPUs to multiple NUMA nodes. Each NUMA
>node may have it's own NIC, and the orchestration needs to stitch and
>un-stitch NICs depending on whether the cores were allocated to small
>containers or a huge one.

Yeah, but still, there is one physical port for NIC-numanode pair.
Correct? Does the orchestration setup a bond on top of them or some other
master device or let the container use them independently?


>
>So it would be _easier_ to deal with multiple netdevs. Orchestration
>layer already understands netdev <> NUMA mapping, it does not understand
>multi-NUMA netdevs, and how to match up queues to nodes.
>
>> 3) other subsystems like RDMA would benefit the same feature, so this
>>    int not netdev specific in general.
>
>Yes, looks RDMA-centric. RDMA being infamously bonding-challenged.

Not really. It's just needed to consider all usecases, not only netdev.


>
>Anyway, back to the initial question - from Greg's reply I'm guessing
>there's no precedent for doing such things in the device model either.
>So we're on our own.

