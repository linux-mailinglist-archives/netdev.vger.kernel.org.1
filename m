Return-Path: <netdev+bounces-47901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2247EBCA9
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 05:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E406B20A61
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61510642;
	Wed, 15 Nov 2023 04:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f90tJtMv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F06A50
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122FDC433C8;
	Wed, 15 Nov 2023 04:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700023683;
	bh=EfAbGrOuV2NI0uz0v5xYGE+7CaVbAyNA3Ux45qLjFp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f90tJtMvoC7LzYgv03HvMgcFrwwMTWsndca9diaI2uoW4ah0LhNvBq6FFp3iNxliU
	 tbieooIW+SvvCWuFaK6ok3tq/JkwarRWam2i6iZfk6jQjhYWDXSyt2Fx9Kba1PKzpA
	 4ItMI7pqxkjbUmT0/iPCYUUYjL7zAyVM297RYgUv7QGH8HGd5ONl5sBYYUN2s+leUK
	 wz7dAsEJFHl16LS7vcxwxjrDJSB/2r9jHql6Fpfs8HenQRbogj2Zil/ReEcITEjp72
	 zVk8iBloBj1ZxQgMFrAF+2TZUmV386vZpqeZ7lJpo7WNRZx2beLVka9LhM4XF0sRy4
	 qzVEngi08TQBQ==
Date: Tue, 14 Nov 2023 23:48:01 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v7 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <20231114234801.0faee5db@kernel.org>
In-Reply-To: <169992177699.3867.16531901770683676993.stgit@anambiarhost.jf.intel.com>
References: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
	<169992177699.3867.16531901770683676993.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 16:29:37 -0800 Amritha Nambiar wrote:
> Add support in netlink spec(netdev.yaml) for queue information.
> Add code generated from the spec.
> 
> Note: The "queue-type" attribute takes values 0 and 1 for rx
> and tx queue type respectively.


> index 14511b13f305..e7bf6007d77f 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -55,6 +55,10 @@ definitions:
>          name: hash
>          doc:
>            Device is capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash().
> +  -
> +    name: queue-type
> +    type: enum
> +    entries: [ rx, tx ]
>  
>  attribute-sets:
>    -
> @@ -87,6 +91,31 @@ attribute-sets:
>          type: u64
>          enum: xdp-rx-metadata
>  
> +  -
> +    name: queue
> +    attributes:
> +      -
> +        name: queue-id

Hm. I guess it looks okay in the Python / JSON but the C defines
will say NETDEV_QUEUE_QUEUE_ID or some such. Should we drop the word
queue from all attrs in the queue set?

Sorry, not sure how I missed this earlier. Some extra nits below while
I'm requesting changes...

> +        doc: Queue index for most queue types are indexed like a C array, with

s/ for/;/ ?

> +             indexes starting at 0 and ending at queue count - 1. Queue indexes
> +             are scoped to an interface and queue type.
> +        type: u32
> +      -
> +        name: ifindex
> +        doc: ifindex of the netdevice to which the queue belongs.
> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: queue-type
> +        doc: queue type as rx, tx

Add: ". Each queue type defines a separate ID space."

> +        type: u32
> +        enum: queue-type
> +      -
> +        name: napi-id
> +        doc: ID of the NAPI instance which services this queue.
> +        type: u32
> +
>  operations:
>    list:
>      -
> @@ -120,6 +149,29 @@ operations:
>        doc: Notification about device configuration being changed.
>        notify: dev-get
>        mcgrp: mgmt
> +    -
> +      name: queue-get
> +      doc: Get queue information from the kernel.
> +           Only configured queues will be reported (as opposed to all available
> +           queues).

maybe add "hardware", so "all available hardware queues)" ?
That may help the reader connect the dots

