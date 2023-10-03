Return-Path: <netdev+bounces-37759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC497B7061
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 19:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DE6BE28139C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8E33B7AB;
	Tue,  3 Oct 2023 17:55:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39B25102
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 17:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23721C433C9;
	Tue,  3 Oct 2023 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696355742;
	bh=gcYhbiv6s3HPdYSDDfxpvxQsIE4cXTHj+uXhxeromT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jq7COVgR1vR7n6LENmxU9AXl21eFb6N6O1Qu/ai9E6q80T8mDYPT6W1xqjYWeOIXr
	 +Ka2yBoLTpYGSjWmTC139YVuXHFkE32ULOBYaQQnSktm1vHHTJNkmV6/aeZL+fwvGj
	 IqJ/x4TXwCh0bfP10r7RD2mC9yZ8ysLm5M4Z9lxcg9mgXWMlxiz7oV70TJGvtiQu9l
	 Iu5w68s8HxuCbaA0TrgfFlbJT+wghD8N8YzkhZnjmTgRyctqJCRS83Lvz1r2bgmsd3
	 uibAWpQ8lydTM9OZuvFxQwZIkx21R81WElXmWUbYlXPAVUYeBTwhUDQ5ExOQZTTOqu
	 zN5BDUfDQzjEg==
Date: Tue, 3 Oct 2023 10:55:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
 chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 netdev@vger.kernel.org
Subject: Re: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
Message-ID: <20231003105540.75a3e652@kernel.org>
In-Reply-To: <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
	<47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Sep 2023 14:49:44 +0200 Lorenzo Bianconi wrote:
> Introduce nfsd_server.yaml specs to generate uAPI and netlink
> code for nfsd server.
> Add rpc-status specs to define message reported by the nfsd server
> dumping the pending RPC requests.

Sorry for the delay, some minor "take it or leave it" nits below.

> +doc:
> +  nfsd server configuration over generic netlink.
> +
> +attribute-sets:
> +  -
> +    name: rpc-status-comp-op-attr
> +    enum-name: nfsd-rpc-status-comp-attr
> +    name-prefix: nfsd-attr-rpc-status-comp-
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0

the unused attrs can usually be skipped, the specs now start with value
of 1 by default. Same for the unused command.

> +      -
> +        name: dport
> +        type: u16
> +        byte-order: big-endian
> +      -
> +        name: compond-op
> +        type: array-nest

Avoid array-nests if you can, they are legacy (does this spec pass JSON
schema validation?).

There's only one attribute in the nest, can you use

	- 
	 name: op
	 type: u32
	 multi-attr: true

?

> +        nested-attributes: rpc-status-comp-op-attr

> +    -
> +      name: rpc-status-get
> +      doc: dump pending nfsd rpc
> +      attribute-set: rpc-status-attr
> +      dump:
> +        pre: nfsd-server-nl-rpc-status-get-start
> +        post: nfsd-server-nl-rpc-status-get-done

No attributes listed? User space C codegen will need those to make
sense of the commands.

