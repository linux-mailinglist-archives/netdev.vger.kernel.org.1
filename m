Return-Path: <netdev+bounces-56175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894B880E121
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAA91F2191E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 01:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB5FEDC;
	Tue, 12 Dec 2023 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/BvSge/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D6010EB;
	Tue, 12 Dec 2023 01:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67684C433C8;
	Tue, 12 Dec 2023 01:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702346195;
	bh=eN38VqGBqZv9PWgSbUQTy4Dgwvg4OKPBdtvSUOY24RI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I/BvSge/uVn1OgZbD+pRU/drngvKi+wZujwNMKtiyJm9jwrN4JdZ67L20Wl+MKumE
	 JJqJSlK8O1+n/Rv2WFoFGIT43S5iffqWbS19f8D5/B/fsoYe0DPAlPYVbya/4fSIiI
	 XuJf0WJq01S8JsJ3+yJWbxxcPyR8RjKbd7nVFdJP6jCaPy6+B16qDjaQyLJwAXynre
	 xzo/0vGwJPg6U8bx6ZuFCFdpMlPRmUsHC4AVUALcz1QFxq36s+jZv6T4YIH6B+o52i
	 pzSC+umi/ubjz2FQIbWNuJ8AIqk7WtAbeNIp2zNXB6SLIsxzeyVFIa+a5vLWYP6CbQ
	 jh+noLMhrTXRA==
Date: Mon, 11 Dec 2023 17:56:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 06/11] doc/netlink: Document the sub-message
 format for netlink-raw
Message-ID: <20231211175634.3ac1ea07@kernel.org>
In-Reply-To: <20231211164039.83034-7-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211164039.83034-7-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 16:40:34 +0000 Donald Hunter wrote:
> +Sub-messages
> +------------
> +
> +Several raw netlink families such as rt_link and tc have type-specific
> +sub-messages. These sub-messages can appear as an attribute in a top-level or a
> +nested attribute space.
> +
> +A sub-message attribute uses the value of another attribute as a selector key to
> +choose the right sub-message format. For example if the following attribute has
> +already been decoded:

We may want to explain why we call this thing "sub-message". How about:

  Several raw netlink families such as rt_link and tc use attribute
  nesting as an abstraction to carry module specific information.
  Conceptually it looks as follows::

    [OUTER NEST OR MESSAGE LEVEL]
      [GENERIC ATTR 1]
      [GENERIC ATTR 2]
      [GENERIC ATTR 3]
      [GENERIC ATTR - wrapper]
        [MODULE SPECIFIC ATTR 1]
        [MODULE SPECIFIC ATTR 2]

  The GENERIC ATTRs at the outer level are defined in the core (or rt_link
  or core TC), while specific drivers / TC classifiers, qdiscs etc. can
  carry their own information wrapped in the "GENERIC ATTR - wrapper".
  Even though the example above shows attributes nesting inside the wrapper,
  the modules generally have full freedom of defining the format of the nest.
  In practice payload of the wrapper attr has very similar characteristics
  to a netlink message. It may contain a fixed header / structure, netlink
  attributes, or both. Because of those shared characteristics we refer
  to the payload of the wrapper attribute as a sub-message.

> +A sub-message attribute uses the value of another attribute as a selector key to
> +choose the right sub-message format. For example if the following attribute has
> +already been decoded:

