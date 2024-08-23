Return-Path: <netdev+bounces-121275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF06F95C82C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632AC28165E
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C113B2A9;
	Fri, 23 Aug 2024 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLzPLop1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4AA36AEC
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402114; cv=none; b=kv/Ex+mLQ2XBAS3/I5JInepbZkdSJFx47Ct5G3CmFCRKrA6PPQT6wWHu+SSyavD086wUFuKH6gyDufGh+z7aA29OpNgAUjH1zE3g7Saf330avlBEAM4e5wkD7nXNMM1QGxem6Php8EBw6shYQOtEckc0S8IGV89coYIIXJJZfUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402114; c=relaxed/simple;
	bh=dBbXCgUWhkHiZjvfeofmZj5z9NaOBdX1NPMlzdYVpws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuAC00GQrybuNMEu6ENpbZNGzM2Qmn629DQJUpbnIsMnC8oOS45F4GVkk4ZTEiXM9I2jGg0mk50lLd+k25C3/TfuPRSwHNqYXWltLwQcMXRxlnl5lXhkYQ0FyVJ2JCrGhcmJyi4/D3KRnc8EjJFXnvGrkVPm9qg0QS5eMRv3vik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLzPLop1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724402111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhcLkjL1QGJrgxJhOke5hrY6lNv+l99BMwT4C9JY3Ic=;
	b=TLzPLop1TBeS/x8PVtj834ogBqrkl02nibGVXANr/Hi2Iq2XtTrz5N5rDb3BJSCJEkMGeZ
	7ONP+1vmn/zFuj398hq7ATniLQd4ob6ueOZY4Dqtbyb/bKWNNwuswXRGIXu2Cw/jRGWnxs
	q/hDhYTh2YA7J44+qHLO4uoY9C+pW5c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-neLMCipXN166g9Vjmremaw-1; Fri, 23 Aug 2024 04:35:09 -0400
X-MC-Unique: neLMCipXN166g9Vjmremaw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280a434147so14504115e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 01:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402108; x=1725006908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhcLkjL1QGJrgxJhOke5hrY6lNv+l99BMwT4C9JY3Ic=;
        b=ZNwKavRZxKpGaDKPPxu9ZZ7wGuSkuinT9dQwkOArfEX7NCxCM9oBAzIKhxvkA9ZaUk
         Yls86IZ+feaMR5auEvu60+dNFgBVqmy4cPVhDWQtBKtbGPd3++Z+XGncawS90t++Jzve
         M6cfCXKnXmdPzJ+Y8KZX7NEQq1D9K4rd1iaVtTUBQevrV5Stu3GBH9GYmpnx2Mepnbkf
         PagVJjFJLTxjVBs5Jyi+HVwUuy1jdyvs7753aA3cRw6ZPla+huyg/PMFsLlmNUwHPH9A
         MHFzagVAFMFMU8GJOniCeLrdG4Xcdkj37jykDam3u3wPuUJdZonbMtK8/Z/xYebTkfI4
         fx0A==
X-Gm-Message-State: AOJu0Yzvgj9JC3+beBaX5u9dAU7vz+q5/dVT/mvjn49/SSyhXvNWyN2t
	nIeg3Q4la+UQFqS+yHTt43l8XMPsb11fUMhfMpQQOfE3nEy2HSf4jUTmi8OKcM/DnANLONre8Fs
	jI/HiXX3gQxx/+8SU46mcxvqq3Ndy6WGTzNOOe/hcuJggskcWILLOaA==
X-Received: by 2002:a05:600c:4fc8:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-42acc8dd28dmr11336445e9.10.1724402107984;
        Fri, 23 Aug 2024 01:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ6OEPqJU3ya1lye05mUF1sQf2u+I5bF7YTkq2aQRzEvEn0h1EUwjzMPdOMF0wb2eXe9Mlrg==
X-Received: by 2002:a05:600c:4fc8:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-42acc8dd28dmr11336125e9.10.1724402107390;
        Fri, 23 Aug 2024 01:35:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10::f71? ([2a0d:3344:1b51:3b10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abed8b994sm90196865e9.8.2024.08.23.01.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 01:35:06 -0700 (PDT)
Message-ID: <ad5be943-2aa6-4f60-be90-929f889e6057@redhat.com>
Date: Fri, 23 Aug 2024 10:35:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 02/12] netlink: spec: add shaper YAML spec
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
References: <cover.1724165948.git.pabeni@redhat.com>
 <dac4964232855be1444971d260dab0c106c86c26.1724165948.git.pabeni@redhat.com>
 <20240822184824.3f0c5a28@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822184824.3f0c5a28@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/24 03:48, Jakub Kicinski wrote:
> On Tue, 20 Aug 2024 17:12:23 +0200 Paolo Abeni wrote:
>> diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
>> new file mode 100644
>> index 000000000000..a2b7900646ae
>> --- /dev/null
>> +++ b/Documentation/netlink/specs/net_shaper.yaml
>> @@ -0,0 +1,289 @@
>> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>> +
>> +name: net-shaper
>> +
>> +doc: |
>> +  Network device HW rate limiting configuration.
>> +
>> +  This API allows configuring HR shapers available on the network
> 
> What's HR?

Type: HW

>> +  device at different levels (queues, network device) and allows
>> +  arbitrary manipulation of the scheduling tree of the involved
>> +  shapers.
>> +
>> +  Each @shaper is identified within the given device, by an @handle,
>> +  comprising both a @scope and an @id, and can be created via two
>> +  different modifiers: the @set operation, to create and update single
> 
> s/different modifiers/operations/
> 
>> +  shaper, and the @group operation, to create and update a scheduling
>> +  group.
>> +
>> +  Existing shapers can be deleted via the @delete operation.
> 
> deleted -> deleted / reset
> 
>> +  The user can query the running configuration via the @get operation.
> 
> The distinction between "scoped" nodes which can be "set"
> and "detached" "node"s which can only be created via "group" (AFAIU)
> needs clearer explanation.

How about re-phrasing the previous paragraph as:

   Each @shaper is identified within the given device, by an @handle,
   comprising both a @scope and an @id.

   Depending on the @scope value, the shapers are attached to specific
   HW objects (queues, devices) or, for @node scope, represent a
   scheduling group that can be placed in an arbitrary location of
   the scheduling tree.

   Shapers can be created with two different operations: the @set
   operation, to create and update single "attached" shaper, and
   the @group operation, to create and update a scheduling
   group. Only the @group operation can create @node scope shapers.


>> +definitions:
>> +  -
>> +    type: enum
>> +    name: scope
>> +    doc: The different scopes where a shaper can be attached.
> 
> Are they attached or are they the nodes themselves?
> Maybe just say that scope defines the ID interpretation and that's it.

Will do.

> 
>> +    render-max: true
>> +    entries:
>> +      - name: unspec
>> +        doc: The scope is not specified.
>> +      -
>> +        name: netdev
>> +        doc: The main shaper for the given network device.
>> +      -
>> +        name: queue
>> +        doc: The shaper is attached to the given device queue.
>> +      -
>> +        name: node
>> +        doc: |
>> +             The shaper allows grouping of queues or others
>> +             node shapers, is not attached to any user-visible
> 
> Saying it's not attached is confusing. Makes it sound like it exists
> outside of the scope of a struct net_device.

What about:

   Can be placed in any arbitrary location of
   the scheduling tree, except leaves and root.

> 
>> +             network device component, and can be nested to
>> +             either @netdev shapers or other @node shapers.
> 
>> +attribute-sets:
>> +  -
>> +    name: net-shaper
>> +    attributes:
>> +      -
>> +        name: handle
>> +        type: nest
>> +        nested-attributes: handle
>> +        doc: Unique identifier for the given shaper inside the owning device.
>> +      -
>> +        name: info
>> +        type: nest
>> +        nested-attributes: info
>> +        doc: Fully describes the shaper.
>> +      -
>> +        name: metric
>> +        type: u32
>> +        enum: metric
>> +        doc: Metric used by the given shaper for bw-min, bw-max and burst.
>> +      -
>> +        name: bw-min
>> +        type: uint
>> +        doc: Minimum guaranteed B/W for the given shaper.
> 
> s/Minimum g/G/
> Please spell out "bandwidth" in user-facing docs.
> 
>> +      -
>> +        name: bw-max
>> +        type: uint
>> +        doc: Shaping B/W for the given shaper or 0 when unlimited.
> 
> s/Shaping/Maximum/
> 
>> +      -
>> +        name: burst
>> +        type: uint
>> +        doc: Maximum burst-size for bw-min and bw-max.
> 
> How about:
> 
> s/bw-min and bw-max/shaping. Should not be interpreted as a quantum./
> 
> ? >
>> +      -
>> +        name: priority
>> +        type: u32
>> +        doc: Scheduling priority for the given shaper.
> 
> Please clarify that that priority is only valid on children of
> a scheduling node, and the priority values are only compared
> between siblings.
> 
>> +      -
>> +        name: weight
>> +        type: u32
>> +        doc: |
>> +          Weighted round robin weight for given shaper.
> 
> Relative weight of the input into a round robin node.

I would avoid mentioning 'input' unless we rolls back to the previous 
naming scheme.

> ?
> 
>> +          The scheduling is applied to all the sibling
>> +          shapers with the same priority.
>> +      -
>> +        name: scope
>> +        type: u32
>> +        enum: scope
>> +        doc: The given shaper scope.
> 
> :)
> 
>> +      -
>> +        name: id
>> +        type: u32
>> +        doc: |
>> +          The given shaper id.
> 
> "Numeric identifier of a shaper."
> 
> Do we ever use ID and scope directly in a nest with other attrs?
> Or are they always wrapped in handle/parent ?
> If they are always wrapped they can be a standalone attr set / space.

Will do in the next revision.

>> +      -
>> +        name: leaves
>> +        type: nest
>> +        multi-attr: true
>> +        nested-attributes: info
>> +        doc: |
>> +           Describes a set of leaves shapers for a @group operation.
>> +      -
>> +        name: root
>> +        type: nest
>> +        nested-attributes: root-info
>> +        doc: |
>> +           Describes the root shaper for a @group operation
> 
> missing full stop
> 
>> +           Differently from @leaves and @shaper allow specifying
>> +           the shaper parent handle, too.
> 
> Maybe this attr is better called "node", after all.

Fine by me, but would that cause some confusion with the alias scope 
value?

>> +      -
>> +        name: shaper
>> +        type: nest
>> +        nested-attributes: info
>> +        doc: |
>> +           Describes a single shaper for a @set operation.
> 
> Hm. How is this different than "info"?
> 
> $ git grep SHAPER_A_INFO
> include/uapi/linux/net_shaper.h:        NET_SHAPER_A_INFO,
> $
> 
> is "info" supposed to be used?

left over from the previous revision, I will drop it.

>> +++ b/net/shaper/Makefile
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Makefile for the Generic HANDSHAKE service
>> +#
>> +# Copyright (c) 2024, Red Hat, Inc.
> 
> Ironic that you added the copyright given the copy/paste
> fail in the contents... ;)

Strictly speaking, since it was not intentional, it is more careless or 
stupid on my side.

Thanks,

Paolo


