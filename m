Return-Path: <netdev+bounces-74722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD2D862891
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 01:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DD4281D5E
	for <lists+netdev@lfdr.de>; Sun, 25 Feb 2024 00:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B1C7FD;
	Sun, 25 Feb 2024 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4ukc6IK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD4563D
	for <netdev@vger.kernel.org>; Sun, 25 Feb 2024 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708821272; cv=none; b=Z4jA6JajHY/1fjHEkcb6VTQKUMAhAsF4T1uOym6ftMsujFuOf8vH+O8En3I+XNqi9xOiIsqIbSkZTdJJ4c57/rPLKefC9UbOgZly3Lrhyq4el99xMX/LgAmMJ/u50X9mx8q3SZUdWqTVHc6uKiLAxliZa98/V87Y0wGviAcw9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708821272; c=relaxed/simple;
	bh=pW35lHmRZbmLNwBmL2fWBG9v27WSVr02Mm18cN6snmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ3XY2f99+cB8LFjXft8rnbKLzZ7+m3Y4mVwsBaTu5sbPrfTtbPcY766ckjsfl1S7roOJi/+Mu8msFlNxb9eM7WCDIJDqCrrVIgWi1oSq+VAy3iY8HJAN5ygIhjO3JZ0NtMxUlSblslPX9QyoTNhpVrnYqJwpCgWf2eLd3lF0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4ukc6IK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C65C433F1;
	Sun, 25 Feb 2024 00:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708821272;
	bh=pW35lHmRZbmLNwBmL2fWBG9v27WSVr02Mm18cN6snmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K4ukc6IKBtizGP99kMFAId3915KrC/6M4R9EIQ9xsyLGdcoO8NK+ZySKOiqtulkNm
	 4Z5hwN6nyb5zynpjhps24Ke+Ped5SrHmimKeoAM4mxLci10CY68EMXVTtCceXnnG4X
	 1fxmXEpcWep0PN4VsEQJ+v2osuVys/gES1GXir/cFIcHxEWh6/MTmaup8IvQHm2mbx
	 7lDCAS8VYhcBDUhwIBEPdWjMQwbkFoC3VdjLmOIYhAejBnjalGaCyfX3Y8y34zMHDn
	 /8+WnzA50RItSC1fRUivkknD9k2kD97IJiLOQLpCBuZG/VcrYeEdOuEHiKTqwiTNSq
	 qzqhwcKIv5Gww==
Date: Sat, 24 Feb 2024 16:34:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 05/14] af_unix: Detect Strongly Connected
 Components.
Message-ID: <20240224163430.05595eb0@kernel.org>
In-Reply-To: <20240223214003.17369-6-kuniyu@amazon.com>
References: <20240223214003.17369-1-kuniyu@amazon.com>
	<20240223214003.17369-6-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 13:39:54 -0800 Kuniyuki Iwashima wrote:
> +	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
> +		struct unix_vertex *next_vertex = edge->successor->vertex;
> +
> +		if (!next_vertex)
> +			continue;
> +
> +		if (next_vertex->index == UNIX_VERTEX_INDEX_UNVISITED) {
> +			list_add(&edge->stack_entry, &edge_stack);
> +
> +			vertex = next_vertex;
> +			goto next_vertex;
> +prev_vertex:
> +			next_vertex = vertex;
> +
> +			edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
> +			list_del_init(&edge->stack_entry);
> +
> +			vertex = edge->predecessor->vertex;
> +
> +			vertex->lowlink = min(vertex->lowlink, next_vertex->lowlink);
> +		} else if (edge->successor->vertex->on_stack) {
> +			vertex->lowlink = min(vertex->lowlink, next_vertex->index);
> +		}
> +	}
> +
> +	if (vertex->index == vertex->lowlink) {
> +		struct list_head scc;
> +
> +		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
> +
> +		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
> +			list_move_tail(&vertex->entry, &unix_visited_vertices);
> +
> +			vertex->on_stack = false;
> +		}
> +
> +		list_del(&scc);
> +	}
> +
> +	if (!list_empty(&edge_stack))
> +		goto prev_vertex;

coccicheck says:

net/unix/garbage.c:406:17-23: ERROR: invalid reference to the index variable of the iterator on line 425

this code looks way to complicated to untangle on a quick weekend scan,
so please LMK if this is a false positive, I'll hide the patches from
patchwork for now ;)

