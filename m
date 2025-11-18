Return-Path: <netdev+bounces-239342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51412C66FEC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43123347B4A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744A421CC79;
	Tue, 18 Nov 2025 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cc//lk20"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689B17B50F;
	Tue, 18 Nov 2025 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432146; cv=none; b=MukL2aJ9vkl80ciZhHiipciQSq4RjW8CqkoHVUVJ27j4s5u9b7HmWoe+4rhMY83wIgNBjTi1UUXCgDjmvL7d3ZQRKKJg79f4jjn67MJBhnNaQ3lyAeD3PidvP3BBoksOM9YlT8awdBFNSk0bl/6YBccJSAA9rqYHq1kcyReV1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432146; c=relaxed/simple;
	bh=7xotXUvi9cLVnrYdR3DIu7LdHYVsC5kHqKTRFjOPSso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQDCALmh0Y6wvKF/oXZjo2b4tdblbrJeNurTvjE/hhhKbU5Qy23TjtpvqQzRMCNuygW+5lIioZl8gFlDBJWCczw8WJ5NIFSuBcDf2sbelpuFcnVm1isGAFae/Cpjyg+NlzIjO3B/2W0ehwNFHLcAneNSvOzT++fyVhD0puATXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=cc//lk20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98F6C2BCAF;
	Tue, 18 Nov 2025 02:15:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cc//lk20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763432141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfz0UjOBMmcUqWNnTqjj9EBSwyFMf+bo3hE+lHocPPE=;
	b=cc//lk20U6O3MMGi1X5Wf3VXksQA8ANosKjcfNV1B1nkdMRFeIoNKTghxiUkk++DOU+FsM
	WUeLIRuWq58C1iTs+jKVOsSbrRUCcawXj/q4M8u1hCcKNSK66Ur266bxOthWFZCBAIW1ZI
	Hw2Pg0hIfMbxI25GIKdGtHlcEEFOpjA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 31daa250 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Nov 2025 02:15:41 +0000 (UTC)
Date: Tue, 18 Nov 2025 03:15:40 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 04/11] netlink: specs: add specification for
 wireguard
Message-ID: <aRvWzC8qz3iXDAb3@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-5-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105183223.89913-5-ast@fiberby.net>

On Wed, Nov 05, 2025 at 06:32:13PM +0000, Asbjørn Sloth Tønnesen wrote:
> +name: wireguard
> +protocol: genetlink-legacy

I'll need to do my own reading, I guess, but what is going on with this
"legacy" business? Is there some newer genetlink that falls outside of
versioning?

> +c-family-name: wg-genl-name
> +c-version-name: wg-genl-version
> +max-by-define: true
> +
> +definitions:
> +  -
> +    name-prefix: wg-

There's lots of control over the C output here. Why can't there also be
a top-level c-function-prefix attribute, so that patch 10/11 is
unnecessary? Stack traces for wireguard all include wg_; why pollute
this with the new "wireguard_" ones?

> +        doc: The index is set as ``0`` in ``DUMP``, and unused in ``DO``.

I think get/set might match the operations better than the underlying
netlink verbs? This is a doc comment specific to getting and setting.

On the other hand, maybe that's an implementation detail and doesn't
need to be specified? Or if you think rigidity is important, we should
specify 0 in both directions and then validate it to ensure userspace
sends 0 (all userspaces currently do).

> +        The kernel will then return several messages (``NLM_F_MULTI``).
> +        It is possible that all of the allowed IPs of a single peer
> +        will not fit within a single netlink message. In that case, the
> +        same peer will be written in the following message, except it will
> +        only contain ``WGPEER_A_PUBLIC_KEY`` and ``WGPEER_A_ALLOWEDIPS``.
> +        This may occur several times in a row for the same peer.
> +        It is then up to the receiver to coalesce adjacent peers.
> +        Likewise, it is possible that all peers will not fit within a
> +        single message.
> +        So, subsequent peers will be sent in following messages,
> +        except those will only contain ``WGDEVICE_A_IFNAME`` and
> +        ``WGDEVICE_A_PEERS``. It is then up to the receiver to coalesce
> +        these messages to form the complete list of peers.

There's an extra line break before the "So," that wasn't there in the
original.


> +        While this command does accept the other ``WGDEVICE_A_*``
> +        attributes, for compatibility reasons, but they are ignored
> +        by this command, and should not be used in requests.

Either "While" or ", but" but not both.

However, can we actually just make this strict? No userspaces send
random attributes in a GET. Nothing should break.

> +      dump:
> +        pre: wireguard-nl-get-device-start
> +        post: wireguard-nl-get-device-done

Oh, or, the wg_ prefix can be defined here (instead of wireguard_, per
my 10/11 comment above).

> +        # request only uses ifindex | ifname, but keep .maxattr as is
> +        request: &all-attrs
> +          attributes:
> +            - ifindex
> +            - ifname
> +            - private-key
> +            - public-key
> +            - flags
> +            - listen-port
> +            - fwmark
> +            - peers

As mentioned earlier, maybe this can be reduced to ifindex+ifname.

> +        It is possible that the amount of configuration data exceeds that
> +        of the maximum message length accepted by the kernel.
> +        In that case, several messages should be sent one after another,
> +        with each successive one filling in information not contained in
> +        the prior.
> +        Note that if ``WGDEVICE_F_REPLACE_PEERS`` is specified in the first
> +        message, it probably should not be specified in fragments that come
> +        after, so that the list of peers is only cleared the first time but
> +        appended after.
> +        Likewise for peers, if ``WGPEER_F_REPLACE_ALLOWEDIPS`` is specified
> +        in the first message of a peer, it likely should not be specified
> +        in subsequent fragments.

More odd linebreaks added. Either it's a new paragraph or it isn't. Keep
this how it was before?

Jason

