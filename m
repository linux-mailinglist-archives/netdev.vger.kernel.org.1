Return-Path: <netdev+bounces-150400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D4D9EA1BA
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0531660C4
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 22:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C2199239;
	Mon,  9 Dec 2024 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byH5ix7v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5346B8
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782720; cv=none; b=tCqMOO6TfrJJ4VNYe6CceZCs8nrHDzL88Fp+wZDFygDdtKQ4A4iZf/NYT0DCLXCmplw6V0vsjV/KX6rmUSPw308rjFEbEfwtRWuiHTpYD7rouvg95ZEzDiYG8HGF7OApbIBlolVgXaTRWVvpqSMXne5MRP+ZDx549wNhNG1owCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782720; c=relaxed/simple;
	bh=Tm1WaOj8z5Pv519OzW7k9jhUwgHWvOkeot0wUwJ9Z5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBGglT67GmNQirC08aGF/Fa8yyax8rrRmkGflGVtYDMqrMKmW2Ae+v63O/YGzDTUMoJzXDR3iusZCY7zALYO58xZxLFTmXlVtfTzuN28In54oN9ZK50u6Dzf8GIjr7RAKpRsYDGEO3u9zTDTQq47pblkh+oQJCGnZcPVhvyuwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byH5ix7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB62C4CED1;
	Mon,  9 Dec 2024 22:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733782719;
	bh=Tm1WaOj8z5Pv519OzW7k9jhUwgHWvOkeot0wUwJ9Z5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=byH5ix7vQ3Zun1u8Bpzx2e6M4Zx3ysralownCaTFZFw93S6DifKHovsxaYy+Gd+9Q
	 qLk6xo0IgxjMHS1a4QIiDG5bY7FhoqRwIezHwwGYXrkvPW1VK/OENT4Ucw+Qkk7O4W
	 9+/WtZ/yIMXCfxkbwauZ74zte+oZxXwegrMyP68NGxJj0xuo5fblyBIIerMgbgErr9
	 4NxvitKG9EfGyknz21xsI5ff0M/4GVbwRRHDj7enk75tCe3nOzyrUV+IIa1dISblQY
	 pi+qTNTNw1T8veVcN/6hEMh312zeKSq7dAgfkkR6vCtZiCujHOHAQ34zPlvIUvwAd/
	 Kfp+3VJ56hWZA==
Date: Mon, 9 Dec 2024 14:18:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Masahiro Yamada
 <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v9 03/10] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241209141838.5470c4a4@kernel.org>
In-Reply-To: <20241204-packing-pack-fields-and-ice-implementation-v9-3-81c8f2bd7323@intel.com>
References: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
	<20241204-packing-pack-fields-and-ice-implementation-v9-3-81c8f2bd7323@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Dec 2024 17:22:49 -0800 Jacob Keller wrote:
> +PHONY += scripts_gen_packed_field_checks
> +scripts_gen_packed_field_checks: scripts_basic
> +	$(Q)$(MAKE) $(build)=scripts scripts/gen_packed_field_checks

You need to add this binary to .gitignore, one more round :(
The rest LGTM

> +/* Small packed field. Use with bit offsets < 256, buffers < 32B and
> + * unpacked structures < 256B.
> + */
> +struct packed_field_s {
> +	GEN_PACKED_FIELD_MEMBERS(u8);
> +};
> +
> +/* Medium packed field. Use with bit offsets < 65536, buffers < 8KB and
> + * unpacked structures < 64KB.
> + */
> +struct packed_field_m {
> +	GEN_PACKED_FIELD_MEMBERS(u16);
> +};

Random thought - would it be more intuitive to use the same size
suffixes as readX() / writeX()? b = byte, w = u16, l = u32, q = 64? 
If you're immediate reaction isn't "of course!" -- ignore me.

