Return-Path: <netdev+bounces-133377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB946995C3A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41B32839DA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BCA1E480;
	Wed,  9 Oct 2024 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gb+RpNKX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618661CD2B
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728432847; cv=none; b=igEayqo3RBzs320604HmHJvzJ9Ho2nvXgPTmGGKQNUKZR4CkJCW1n2XTCOEDCjtozCPjza6MBdkuhY+2dz9yw8l1OUkqDnlaIFcutKWFSERTgaovvJUXwtNc5tcccPdxS/NGLxMTzsH7kDo3utmxq+gkFUd1PNTarn0HC064Aq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728432847; c=relaxed/simple;
	bh=vCkuvxHqKBdleT2a8rkQv03dvvsEFnflHm/7wJjAlKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9XslZcAOqyhdHCLwl+I0yh9fvdixGThZbp/+aGEC5pkQddOLZoa5FUOU9KBJU+vgGyCOIvJafnsdSO/faBp6MUvR/WwZ8ERTwXO41uIWRKI+bH/209GC++tKmlm5zUlKdNRllUCDfkwFMmqGZYSKTRVfdWMj4EtUmwmS+AipI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gb+RpNKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D8DC4CED4;
	Wed,  9 Oct 2024 00:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728432846;
	bh=vCkuvxHqKBdleT2a8rkQv03dvvsEFnflHm/7wJjAlKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gb+RpNKX9gwa3wLmraNzkHZmQCjeLhk/iz4c4dssyTKlfdgr297c6M29zH/NkEz/G
	 LC4gM0wM3clnCwWHl95ESLVIulyDN2X7IXRo6iLUc+I4ix9Ginh+S9a1rdrbMJ3vEf
	 1ogDcACRkf4vjM3+VErNTO5M6AOOTqWrHbMSqz48rPftK6CkbDTCE7uR3BNKTqpPe6
	 LAdVf2t14ADIVaSm/rsC0KogBG0SSqIfuUIpgk3V4UiZQMYU41ueM6HIXPZoWbeNSS
	 hA8YRzO+KoUHgW0aIu8EVZ/p/FJAXeH+Ptow6Spw0owhIO77KpolFkQilnZNPu0QB9
	 ufgfHYy5E+wrw==
Date: Tue, 8 Oct 2024 17:14:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, Stanislav Fomichev
 <stfomichev@gmail.com>
Subject: Re: [PATCH v8 net-next 02/15] netlink: spec: add shaper YAML spec
Message-ID: <20241008171405.42e8890e@kernel.org>
In-Reply-To: <72241d8f846c67b7201f0293956ef6db6bbbf176.1727704215.git.pabeni@redhat.com>
References: <cover.1727704215.git.pabeni@redhat.com>
	<72241d8f846c67b7201f0293956ef6db6bbbf176.1727704215.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 15:53:49 +0200 Paolo Abeni wrote:
> +      name: group
> +      doc: |
> +        Create or update a scheduling group, attaching the specified
> +        @leaves shapers under the specified node identified by @handle,
> +        creating the latter, if needed.

This line is unnecessary? The first line already says "create or update"
so no need to say again that the node will be created?

> +        The @leaves shapers scope must be @queue and the node shaper
> +        scope must be either @node or @netdev.
> +        When the node shaper has @node scope, if the @handle @id is not
> +        specified, a new shaper of such scope is created, otherwise the
> +        specified node must already exist.

> +        The @parent handle for the node shaper is optional in most cases.
> +        For newly created node scope shaper, the node parent is set by
> +        default to the parent linked to the @leaves before the @group
> +        operation. If, prior to the grouping operation, the @leaves
> +        have different parents, the node shaper @parent must be explicitly
> +        set.

How about:

	The @parent handle for a new node shaper defaults to the parent
	of all the leaves, provided all the leaves share the same parent.
	Otherwise @parent handle must be specified.

> +        The user can optionally provide shaping attributes for the node
> +        shaper.
> +        The operation is atomic, on failure no change is applied to
> +        the device shaping configuration, otherwise the @node shaper
> +        full identifier, comprising @binding and @handle, is provided
> +        as the reply.

We should also mention that if the node already exists the group
operation will _add_ leaves to it, rather than recreating it with
the provided set of leaves. Right? My intuition was that the node
will get the specified set of leaves and the other leaves get deleted.
The current behavior is fine, but needs to be documented.

