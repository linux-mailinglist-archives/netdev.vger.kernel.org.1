Return-Path: <netdev+bounces-22096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE58B7660CA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB906282566
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29F17EA;
	Fri, 28 Jul 2023 00:37:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D947C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E501EC433C7;
	Fri, 28 Jul 2023 00:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690504674;
	bh=XfgaUva1Wbg+rSQo9n5K1iEo4s1KkgR6BlYCSkc5Rq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jzmqp/yCO5ca/d4g0u+j2tQfKXnFQNTQdKWroGxfS8FWYriofAamIDVN7u5Yhsj1A
	 rROOB3c5XkTVHElI9OMSg5Auiqj4VedXbQThKuPEPBjTeymbS6e49n/MfoqaHQax0v
	 H/E8vbmI0oItLJ0h8ptlERBt3H+BwgfCDBWLKf1lTroKetUSjBim0wZtv1cL/ejFAq
	 2TI5KN0P6iUm31pKJiRJqLfmovIDOuag/4WKLa74Q2vcjRdol7ZdaXPKI3G1Mo+jUa
	 N7pwusDkJyHkU1KDSjSPutcTB422IuOqpNeEXS1CKjQB9UpVk+TrzZXcD0zUlbJfkB
	 sTaOy9rpvJG9A==
Date: Thu, 27 Jul 2023 17:37:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maryam Tahhan <mtahhan@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v2 0/2] tools/net/ynl: enable json
 configuration
Message-ID: <20230727173753.6e044c13@kernel.org>
In-Reply-To: <20230727120353.3020678-1-mtahhan@redhat.com>
References: <20230727120353.3020678-1-mtahhan@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 08:03:29 -0400 Maryam Tahhan wrote:
> Use a json configuration file to pass parameters to ynl to allow
> for operations on multiple specs in one go. Additionally, check
> this new configuration against a schema to validate it in the cli
> module before parsing it and passing info to the ynl module.

Interesting. Is this related to Donald's comments about subscribing
to notifications from multiple families?

Can you share some info about your use case?

> Example configs would be:
> 
> {
>     "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
>     "spec-args": {
>         "ethtool.yaml": {
>             "do": "rings-get",
>             "json-params": {
>                 "header": {
>                     "dev-name": "eno1"
>                 }
>             }
>         },
>        "netdev.yaml": {
>             "do": "dev-get",
>             "json-params": {
>             "ifindex": 3
>             }
>         }
>     }
> }

Why is the JSON preferable to writing a script to the same effect?
It'd actually be shorter and more flexible.
Maybe we should focus on packaging YNL as a python lib?

> OR
> 
> {
>     "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
>     "spec-args": {
>         "ethtool.yaml": {
>             "subscribe": "monitor",
>             "sleep": 10
>         },
>         "netdev.yaml": {
>             "subscribe": "mgmt",
>             "sleep": 5
>         }
>     }
> }

Could you also share the outputs the examples would produce?

