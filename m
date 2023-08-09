Return-Path: <netdev+bounces-25663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A3775102
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 04:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04E0281A2F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 02:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7252F388;
	Wed,  9 Aug 2023 02:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53734181
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 02:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49193C433C8;
	Wed,  9 Aug 2023 02:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691549112;
	bh=pyxUNDci4sxB1wNfmcV69RY2TDxRDhfEARSmUExkJrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G7Vydx4fkgsHZsKkGw098Beu9kEAY+jmirB0yHPMYCq4wy99U7H+dLrpiyc9PSCbk
	 BTucSG6I6qd6TWuHsRKgLSmXckz4qxbwj2Rxu72tMHG4mmiqQ1eTI6+rnCTwvQ1f9B
	 sVIEnnHzO0Nz2Y0SDlnt4BSq7Ybaq1I5Kpc8F1QzyEGog4JVqSV7ulIyGNBVab1DN4
	 jXfu3gg1KFlNsV1QMQdJ5DO6+eb3l9CB9bYI0hhcZAXvfVop98d7jYR+b7qKd9bURg
	 kHTOshe1EK51WWRX4W7F0sFhJB0zmefrUx7LDuttAeE7QWbeTDR6ZQLRrQP33o1q2x
	 k7Ei4VxEF9IBA==
Date: Tue, 8 Aug 2023 19:45:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next PATCH v1 3/9] netdev-genl: spec: Extend netdev
 netlink spec in YAML for NAPI
Message-ID: <20230808194511.538a0784@kernel.org>
In-Reply-To: <ac4374d5-0d39-c15b-15d1-f79c4c0ab3fe@intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
	<169059162756.3736.16797255590375805440.stgit@anambiarhost.jf.intel.com>
	<20230731123651.45b33c89@kernel.org>
	<6cb18abe-89aa-a8a8-a7e1-8856acaaef64@intel.com>
	<20230731171308.230bf737@kernel.org>
	<c21aa836-a197-6c63-2843-ec6db4faa3be@intel.com>
	<20230731173512.55ca051d@kernel.org>
	<ac4374d5-0d39-c15b-15d1-f79c4c0ab3fe@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Aug 2023 17:17:34 -0700 Nambiar, Amritha wrote:
> > The main thing to focus on for next version is to make the NAPI objects
> > "flat" and individual, rather than entries in multi-attr nest within
> > per-netdev object.
> 
> Would this be acceptable:
> $ netdev.yaml  --do napi-get --json='{"ifindex": 12}'
> 
> {'napi-info': [{'ifindex': 12, 'irq': 293, 'napi-id': 595, ...},
>                 {'ifindex': 12, 'irq': 292, 'napi-id': 594, ...},
>                 {'ifindex': 12, 'irq': 291, 'napi-id': 593, ...}]}
> 
> Here, "napi-info" represents a list of NAPI objects. A NAPI object is an 
> individual element in the list, and are not within per-netdev object. 
> The ifindex is just another attribute that is part of the NAPI object. 
> The result for non-NAPI devices will just be empty.
> 
> I am not sure how to totally avoid multi-attr nest in this case. For the 
> 'do napi-get' command, the response is a list of elements with multiple 
> attributes and not an individual entry. This transforms to a struct 
> array of NAPI objects in the 'do' response, and is achieved with the 
> multi-attr nest in the YAML. Subsequently, the 'dump napi-get' response 
> is a list of the 'NAPI objects struct list' for all netdevs. Am I 
> missing any special type in the YAML that can also give out a 
> struct-array in the 'do' response besides using multi-attr nest ?

napi-get needs to take napi-id as an argument, if you want to filter 
by ifindex - that means a dump. Dumps work kind-of similar to do, you
still get the attributes for the request (although in a somewhat
convoluted way:

static int your_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
{
       const struct genl_dumpit_info *info = genl_dumpit_info(cb);

	info->attr[attrs-as-normal]

So if info->attrs[IFINDEX] is provided by the user - limit the dump to
only napis from that netdev.

