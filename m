Return-Path: <netdev+bounces-44033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD877D5E6E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8831C20860
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A551E1D6B6;
	Tue, 24 Oct 2023 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCwt4qtS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883842D61B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2E4C433C7;
	Tue, 24 Oct 2023 22:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698187549;
	bh=+tRN4p4qjO9Umy5uQf6DXVEWu4gjiL3MSMVmPjaoCU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RCwt4qtSBJzqy1Kq4HNJQDf4rcbqf9MoCEbRO75qRCZQUR8z1ItJb6OxjHqnEAWsz
	 3kWm5w0VP98kH7WGq8vnggEZr1DJafiC8dt6ftLcbppJiIy5zhwfJ1wnlHQwcWAaDW
	 Gg9jh7qPfK1jq8D4zvACjGaL4ZkXvVlmzYhNDvwWRNoAnTU8gaAcHXvNeg6ECU9aZi
	 Ful3FXwQDqIH2dLFYSOzKCxQovrDcnnslqIPlDHKqytxGpf+MoIBMq0KjOBcNILS5Y
	 NvhJAlSvYqBwGTyGrhX/bzusNz2K1JjU5EHImIQcMVPjZE9vm6Xddu4AJFv8dWm1ml
	 0sjKw5/KnQYJg==
Date: Tue, 24 Oct 2023 15:45:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v6 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <20231024154548.5baa1dfc@kernel.org>
In-Reply-To: <169811120427.59034.37426094846142386.stgit@anambiarhost.jf.intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
	<169811120427.59034.37426094846142386.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Let's beef up the docs here.

On Mon, 23 Oct 2023 18:33:24 -0700 Amritha Nambiar wrote:
> +  -
> +    name: queue
> +    attributes:
> +      -
> +        name: queue-id
> +        doc: queue index

Queue index, most queue types are indexed like a C array,
with indexes starting at 0 and ending at queue count - 1.
Queue indexes are scoped to an interface and queue type.

> +        type: u32
> +      -
> +        name: ifindex
> +        doc: netdev ifindex

ifindex of the netdevice to which the queue belongs.

> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: queue-type
> +        doc: queue type as rx, tx
> +        type: u32
> +        enum: queue-type
> +      -
> +        name: napi-id
> +        doc: napi id

ID of the NAPI instance which services this queue.

> +        type: u32
> +
>  operations:
>    list:
>      -
> @@ -120,6 +147,27 @@ operations:
>        doc: Notification about device configuration being changed.
>        notify: dev-get
>        mcgrp: mgmt
> +    -
> +      name: queue-get
> +      doc: queue information

Get queue information from the kernel. Only configured queues will 
be reported (as opposed to all available queues).

> +      attribute-set: queue

