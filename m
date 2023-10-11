Return-Path: <netdev+bounces-39773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBDE7C4705
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD51B1C20D02
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A8E80D;
	Wed, 11 Oct 2023 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1oKeHYL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552EE39A;
	Wed, 11 Oct 2023 01:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EA7C433C8;
	Wed, 11 Oct 2023 01:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696986520;
	bh=q6kCuKw1p9zMOPVBO4PESzKHHtd8rxfLWiEaydvuP8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T1oKeHYLIwOvj57maEkeiU/sXMyjNjKzGbBivTqn4jMWhhrkRgl1WQseQhT+j7T1J
	 p1bQTwIR7EObse0T5HRmZCu7IRKc/8TRGWMZgFYVeOxyFsfLv0nNpNgl0kjL3h2Q4B
	 CF2/Z8D8SFqAkRWT1dPQ5z3yptR2sjXGrqMLr5XasZQvfgGCKdgKa1/cmXKpvMenO9
	 y3tqU+lDsjTfxLgmxnplB3hrrNnZ5dkVKrcQTE/95DYEsE5yG4502IMg6gf7s0Z1YA
	 PpX04tiF6vebL7346+zM9Zut/sqGj3Zy0M5kksvXP+WYxtTzmORvMsJ4ElYY/VmbmF
	 UFPC5+0MCdDwg==
Date: Tue, 10 Oct 2023 18:08:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Mat
 Martineau <martineau@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next 3/6] Documentation: netlink: add a YAML spec
 for mptcp
Message-ID: <20231010180839.0617d61d@kernel.org>
In-Reply-To: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-3-18dd117e8f50@kernel.org>
References: <20231010-upstream-net-next-20231006-mptcp-ynl-v1-0-18dd117e8f50@kernel.org>
	<20231010-upstream-net-next-20231006-mptcp-ynl-v1-3-18dd117e8f50@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 21:21:44 +0200 Matthieu Baerts wrote:
> +definitions:
> +  -
> +    type: enum
> +    name: event-type
> +    enum-name: mptcp_event_type
> +    name-prefix: mptcp_event_

I think you can use - instead of _ here.
For consistency with other families?

> +    entries:
> +     -
> +      name: unspec
> +      value: 0

90% sure enums still start at 0, only attrs and msgs now default to 1.

> +     -
> +      name: announced
> +      value: 6
> +      doc:
> +        token, rem_id, family, daddr4 | daddr6 [, dport]
> +        A new address has been announced by the peer.
> +     -
> +      name: removed
> +      value: 7

Follows 6 so no need for value?

> +      doc:
> +        token, rem_id
> +        An address has been lost by the peer.
> +     -
> +      name: sub_established

Similarly for names we generally recommend - as a separator.
Looks more natural in places where it's used as a string, eg Python.
Well, I guess at least to me it does :)

> +      value: 10
> +      doc:
> +        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
> +        dport, backup, if_idx [, error]
> +        A new subflow has been established. 'error' should not be set.
> +     -
> +      name: sub_closed
> +      value: 11

and here, /value/d, s/_/-/

> +      doc:
> +        token, family, loc_id, rem_id, saddr4 | saddr6, daddr4 | daddr6, sport,
> +        dport, backup, if_idx [, error]
> +        A subflow has been closed. An error (copy of sk_err) could be set if an
> +        error has been detected for this subflow.

> +attribute-sets:
> +  -
> +    name: address
> +    name-prefix: mptcp_pm_addr_attr_
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: family
> +        type: u16
> +      -
> +        name: id
> +        type: u8
> +      -
> +        name: addr4
> +        type: u32
> +        byte-order: big-endian
> +      -
> +        name: addr6
> +        type: binary
> +        checks:
> +          min-len: 16

Do you not want the exact length for this?
If YNL doesn't support something just LMK, we add stuff as needed..

