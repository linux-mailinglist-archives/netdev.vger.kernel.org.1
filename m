Return-Path: <netdev+bounces-27972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72D77DC92
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAFE1C20F2B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395E4D2F6;
	Wed, 16 Aug 2023 08:41:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2BC2DF
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CD3C433CA;
	Wed, 16 Aug 2023 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692175280;
	bh=WtavSszM3J/Pf8Dcmdp1KmdiVZodBZ0p8PCwwJgoBvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGb74r/xEV0UyznLMjDIcJwCqBaPz7g2fjlDbDmc8SIMDwyMdAnyAKUAi3mnzlIwh
	 fFIXa7G6teDVsmWRjwQf25Ci0a5rXAMGNlD2fMWgFq8ygXH9rvZRVgOKHnxpKCQK81
	 IHngGspIYeuUl5uy9FKo+i5FwnLN+ZRdaa4Xy9szBzbW8lZrPjIE1QcsBibgcJw9K+
	 2ziBnF+Tn+OT1w5ZfXqUutOfedw1G1vqFlWw9g7y/YHB7FUAEqRIPQFzMRHczpqldI
	 YbWX8F0eMQ3tOsnhzuKOsajwh2VC6iicyR1D2L/IGQu51OXTa0E9HtOgtvNPSiZIfS
	 uH9kzohwzRJUw==
Date: Wed, 16 Aug 2023 10:41:15 +0200
From: Simon Horman <horms@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 01/10] doc/netlink: Add a schema for
 netlink-raw families
Message-ID: <ZNyLqxEVDh0JG7h7@vergenet.net>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
 <20230815194254.89570-2-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815194254.89570-2-donald.hunter@gmail.com>

On Tue, Aug 15, 2023 at 08:42:45PM +0100, Donald Hunter wrote:
> This schema is largely a copy of the genetlink-legacy schema with the
> following additions:
> 
>  - a top-level protonum property, e.g. 0 (for NETLINK_ROUTE)
>  - add netlink-raw to the list of protocols supported by the schema
>  - add a value property to mcast-group definitions
> 
> This schema is very similar to genetlink-legacy and I considered
> making the changes there and symlinking to it. On balance I felt that
> might be problematic for accurate schema validation.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/netlink/netlink-raw.yaml | 414 +++++++++++++++++++++++++
>  1 file changed, 414 insertions(+)
>  create mode 100644 Documentation/netlink/netlink-raw.yaml
> 
> diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
> new file mode 100644
> index 000000000000..a5ec6f3e41cc
> --- /dev/null
> +++ b/Documentation/netlink/netlink-raw.yaml
> @@ -0,0 +1,414 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +%YAML 1.2
> +---
> +$id: http://kernel.org/schemas/netlink/genetlink-legacy.yaml#
> +$schema: https://json-schema.org/draft-07/schema
> +
> +# Common defines
> +$defs:
> +  uint:
> +    type: integer
> +    minimum: 0
> +  len-or-define:
> +    type: [ string, integer ]
> +    pattern: ^[0-9A-Za-z_]+( - 1)?$
> +    minimum: 0
> +
> +# Schema for specs
> +title: Protocol
> +description: Specification of a genetlink protocol
> +type: object
> +required: [ name, doc, attribute-sets, operations ]
> +additionalProperties: False
> +properties:
> +  name:
> +    description: Name of the genetlink family.
> +    type: string
> +  doc:
> +    type: string
> +  version:
> +    description: Generic Netlink family version. Default is 1.
> +    type: integer
> +    minimum: 1
> +  protocol:
> +    description: Schema compatibility level. Default is "genetlink".
> +    enum: [ genetlink, genetlink-c, genetlink-legacy, netlink-raw ] # Trim
> +  # Start netlink-raw
> +  protonum:
> +    description: Protocol number to use for netlink-raw
> +    type: integer
> +  # End netlink-raw
> +  uapi-header:
> +    description: Path to the uAPI header, default is linux/${family-name}.h
> +    type: string
> +  # Start genetlink-c
> +  c-family-name:
> +    description: Name of the define for the family name.
> +    type: string
> +  c-version-name:
> +    description: Name of the define for the verion of the family.

Hi Donald,

a minor nit from my side: verion -> version

> +    type: string

...

