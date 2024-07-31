Return-Path: <netdev+bounces-114688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7A294379C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 23:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED99B23CDC
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D261494A9;
	Wed, 31 Jul 2024 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOslInfa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E429CE1
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460458; cv=none; b=FzKVUqQUXkdkpvVS+Xv9xtf2YpbFtl+Eosz3aOAhceU8GePXcB68lU+CgMV0mtkBRASPFA6qX06PyBB7l4K67v9OwYi/fbJjZGnrSIWnWvaZEGk6ORA/FW50EQVyeMAhDR5E/9BjAIU7gXnB7C6wodIary068yqsM3aXu//P3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460458; c=relaxed/simple;
	bh=DEL3KsgkiuwE45K2aXLK8gQ/3PUHiRbJm7PQWukK+Jk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ukJF5pLutGtU2A4WEc1utNia7+kuuqcBEW4nT6q/RkMYcOTKMFzJPIzbaf/R18zk+qq5+f0RApuSDUia1+jhCu6dVOGVJUnSWXhZ6J6KqgWVjmTHJoz9GjK/H7pwFb169P8V9Dk1aVo71e61YQt3QtZa4W8jneOOJU2d5dX0pkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOslInfa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so38841445e9.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722460455; x=1723065255; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nu/8KazI9qiAlJn5lg+bWcqE+MRa4SboTAO1sP/pXfY=;
        b=nOslInfa8T5uuXlvTdrIQQfZCMkodZ7cGk9JSLOrEdmlyolMlu1hvq6FbJbXPTsAFL
         l86ROgLSqLCpYm+SGtzziok948Q2e7eqbNmhzi1tDKA36hPUpUYahwIBS6tK1ueyqezJ
         /SCW6ERQsp8L1ahzTs1s8kJ4Wf+tMEwRmzWOpmoWMZ4eFJRXXgfN/AfSYF1kieYfHZAI
         eGOoO9XCELz5ilNVsAqlIIwchagR6/4JJbddB+bsm8cXdAWN0/VJtgvnivaCT9dZW+lr
         hleLw6EOFwwGiSxgkijnCSg/G9dPKRsdHhDI3YwsIl4wxdpbzFTO6LrnMwolvSGqlCjr
         LZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722460455; x=1723065255;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nu/8KazI9qiAlJn5lg+bWcqE+MRa4SboTAO1sP/pXfY=;
        b=XLB6WrTrcyAJtatDwTnjXUNcqXlAQKQPJVO8MjhJdrpvzItF/fXE5lG6+8fuQ7V78f
         Bm+BJFDEqNBHE934P7NLbYHQi0zqBlbERL8FHdoy4mmbHzW30SQ6wDLuG7JZfy38L45Z
         +yZEp2TiIvXHPuQEHmw+ZrRbZSXdjJwMd/i9DMwp1/anGQcJnMk9y1RcYzG59eynurle
         VRraLQ4HDC7IaF49YFRjUJ7I/M20Z7eY5qIu70ZgHaNqn+tEfLpQjDJrBFdoAfwZCUdd
         KEKRTViFbKLCo7ifKmzZDAaMhoL9mfgwuMxl23fNOFvf2Yf6yJw3B4PCZ8cOGS9HJYPx
         tsXw==
X-Gm-Message-State: AOJu0YzwjmjiYAFgGjvKocqT48xAgjiYW+PZB3TwvC4srWytaHIkmNoI
	gat6KgI57GAPxkWRJ7o53yvqCjXuySzOs3S1ESdZONkDI5mo/GPU
X-Google-Smtp-Source: AGHT+IHnwiCvb2buCrm0E3uipuBN70XFGNCHUiHQ+HAiDIdWD8nGE6HIAveTJQ3+2RO+5/32ug63RA==
X-Received: by 2002:a05:600c:1f95:b0:428:f79:1836 with SMTP id 5b1f17b1804b1-428b030c455mr3963235e9.26.1722460454206;
        Wed, 31 Jul 2024 14:14:14 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:605a:f0fa:53fc:dd3c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8a2593sm34552355e9.4.2024.07.31.14.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:14:13 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  Jiri Pirko
 <jiri@resnulli.us>,  Madhu Chittim <madhu.chittim@intel.com>,  Sridhar
 Samudrala <sridhar.samudrala@intel.com>,  Simon Horman <horms@kernel.org>,
  John Fastabend <john.fastabend@gmail.com>,  Sunil Kovvuri Goutham
 <sgoutham@marvell.com>,  Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
In-Reply-To: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
	(Paolo Abeni's message of "Tue, 30 Jul 2024 22:39:45 +0200")
Date: Wed, 31 Jul 2024 22:13:22 +0100
Message-ID: <m25xslp8nh.fsf@gmail.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paolo Abeni <pabeni@redhat.com> writes:

> diff --git a/Documentation/netlink/specs/shaper.yaml b/Documentation/netlink/specs/shaper.yaml
> new file mode 100644
> index 000000000000..7327f5596fdb
> --- /dev/null
> +++ b/Documentation/netlink/specs/shaper.yaml

It's probably more user-friendly to use the same filename as the spec
name, so net-shaper.yaml

> @@ -0,0 +1,262 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +
> +name: net-shaper
> +
> +doc: Network device HW Rate Limiting offload
> +
> +definitions:
> +  -
> +    type: enum
> +    name: scope
> +    doc: the different scopes where a shaper can be attached

Nit: upper case 'The' to be consistent with rest of docs.

> +    render-max: true
> +    entries:
> +      - name: unspec
> +        doc: The scope is not specified

What are the semantics of 'unspec' ? When can it be used?

> +      -
> +        name: port
> +        doc: The root for the whole H/W
> +      -
> +        name: netdev
> +        doc: The main shaper for the given network device.

What are the semantic differences between netdev and port?

> +      -
> +        name: queue
> +        doc: The shaper is attached to the given device queue.
> +      -
> +        name: detached
> +        doc: |
> +             The shaper is not attached to any user-visible network
> +             device component and allows nesting and grouping of
> +             queues or others detached shapers.

I assume that shapers are always owned by the netdev regardless of
attach status?

> +  -
> +    type: enum
> +    name: metric
> +    doc: different metric each shaper can support

Nit: upper case here as well.

> +    entries:
> +      -
> +        name: bps
> +        doc: Shaper operates on a bits per second basis
> +      -
> +        name: pps
> +        doc: Shaper operates on a packets per second basis
> +
> +attribute-sets:
> +  -
> +    name: net-shaper
> +    attributes:
> +      -
> +        name: ifindex
> +        type: u32
> +        doc: Interface index owing the specified shaper[s]

Typo: this should be 'owning' ?

> +      -
> +        name: handle
> +        type: nest
> +        nested-attributes: handle
> +        doc: Unique identifier for the given shaper
> +      -
> +        name: metric
> +        type: u32
> +        enum: metric
> +        doc: Metric used by the given shaper for bw-min, bw-max and burst
> +      -
> +        name: bw-min
> +        type: uint
> +        doc: Minimum guaranteed B/W for the given shaper
> +      -
> +        name: bw-max
> +        type: uint
> +        doc: Shaping B/W for the given shaper or 0 when unlimited
> +      -
> +        name: burst
> +        type: uint
> +        doc: Maximum burst-size for bw-min and bw-max
> +      -
> +        name: priority
> +        type: u32
> +        doc: Scheduling priority for the given shaper
> +      -
> +        name: weight
> +        type: u32
> +        doc: |
> +          Weighted round robin weight for given shaper.
> +          The scheduling is applied to all the sibling
> +          shapers with the same priority
> +      -
> +        name: scope
> +        type: u32
> +        enum: scope
> +        doc: The given handle scope
> +      -
> +        name: id
> +        type: u32
> +        doc: |
> +          The given handle id. The id semantic depends on the actual
> +          scope, e.g. for 'queue' scope it's the queue id, for
> +          'detached' scope it's the shaper group identifier.

If scope and id are only ever used as attributes of a handle then they
would be better specified as a separate attribute-set, instead of
mixing them in here and using a subset.

You use 'quoted' references here and @refs elsewhere. It would be good
to be consistent. See note below about @ in htmldocs.

> +      -
> +        name: parent
> +        type: nest
> +        nested-attributes: handle
> +        doc: |
> +          Identifier for the parent of the affected shaper,
> +          The parent handle value is implied by the shaper handle itself,
> +          except for the output shaper in the 'group' operation.

Nit: quoted ref again here

> +      -
> +        name: inputs
> +        type: nest
> +        multi-attr: true
> +        nested-attributes: ns-info
> +        doc: |
> +           Describes a set of inputs shapers for a @group operation

The @group renders exactly as-is in the generated htmldocs. There may be
a more .rst friendly markup you can use that will render better.

> +      -
> +        name: output
> +        type: nest
> +        nested-attributes: ns-output-info
> +        doc: |
> +           Describes the output shaper for a @group operation
> +           Differently from @inputs and @shaper allow specifying
> +           the shaper parent handle, too.
> +

Nit: remove the extra blank line here

> +      -
> +        name: shaper
> +        type: nest
> +        nested-attributes: ns-info
> +        doc: |
> +           Describes a single shaper for a @set operation
> +  -
> +    name: handle
> +    subset-of: net-shaper
> +    attributes:
> +      -
> +        name: scope
> +      -
> +        name: id
> +  -
> +    name: ns-info
> +    subset-of: net-shaper
> +    attributes:
> +      -
> +        name: handle
> +      -
> +        name: metric
> +      -
> +        name: bw-min
> +      -
> +        name: bw-max
> +      -
> +        name: burst
> +      -
> +        name: priority
> +      -
> +        name: weight
> +  -
> +    name: ns-output-info
> +    subset-of: net-shaper
> +    attributes:
> +      -
> +        name: parent
> +      -
> +        name: handle
> +      -
> +        name: metric
> +      -
> +        name: bw-min
> +      -
> +        name: bw-max
> +      -
> +        name: burst
> +      -
> +        name: priority
> +      -
> +        name: weight
> +
> +operations:
> +  list:
> +    -
> +      name: get
> +      doc: |
> +        Get / Dump information about a/all the shaper for a given device
> +      attribute-set: net-shaper
> +
> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - handle
> +        reply:
> +          attributes: &ns-attrs
> +            - parent
> +            - handle
> +            - metric
> +            - bw-min
> +            - bw-max
> +            - burst
> +            - priority
> +            - weight
> +
> +      dump:
> +        request:
> +          attributes:
> +            - ifindex
> +        reply:
> +          attributes: *ns-attrs
> +    -
> +      name: set
> +      doc: |
> +        Create or configures the specified shaper.
> +        On failures the extack is set accordingly.
> +        Can't create @detached scope shaper, use
> +        the @group operation instead.
> +      attribute-set: net-shaper
> +      flags: [ admin-perm ]
> +
> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - shaper
> +
> +    -
> +      name: delete
> +      doc: |
> +        Clear (remove) the specified shaper. If after the removal
> +        the parent shaper has no more children and the parent
> +        shaper scope is @detached, even the parent is deleted,
> +        recursively.
> +        On failures the extack is set accordingly.
> +      attribute-set: net-shaper
> +      flags: [ admin-perm ]
> +
> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - handle
> +
> +    -
> +      name: group
> +      doc: |
> +        Group the specified input shapers under the specified
> +        output shaper, eventually creating the latter, if needed.
> +        Input shapers scope must be either @queue or @detached.

It says above that you cannot create a detached shaper, so how do you
create one to use as an input shaper here? Is this group op more like a
multi-create op?

> +        Output shaper scope must be either @detached or @netdev.
> +        When using an output @detached scope shaper, if the
> +        @handle @id is not specified, a new shaper of such scope
> +        is created and, otherwise the specified output shaper
> +        must be already existing.
> +        The operation is atomic, on failures the extack is set
> +        accordingly and no change is applied to the device
> +        shaping configuration, otherwise the output shaper
> +        handle is provided as reply.
> +      attribute-set: net-shaper
> +      flags: [ admin-perm ]

Does there need to be a reciprocal 'ungroup' operation? Without it,
create / group / delete seems like they will have ambiguous semantics.

> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - inputs
> +            - output
> +        reply:
> +          attributes:
> +            - handle

