Return-Path: <netdev+bounces-80713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0D388099E
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 03:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09961C21EA6
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 02:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865EF9E8;
	Wed, 20 Mar 2024 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igFhWWrx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B628F4
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 02:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902485; cv=none; b=hUp7lFRQ7+thWxLzqcqIt7Npj83plSJam70dBs93Bs4AImDJzbpJX62cRiuGh2g6URT7mqddL5Zb5GdGZ6dN3FXjzjmriw+98SYqrx2q2ZrWO/mMRH2V4tOsmzWZDRDDCYrVEjW7NH4mxMzHkWCCeo2NZEHZqjbHRgrm4DljmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902485; c=relaxed/simple;
	bh=leQwJ4BEkGqcz2CwSeZ1U45LFjnBG9t8KtjjHqx7fm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0Fp82ED01B/OdxEKdtvs7Ti4Vde2rueCOHibfhYIf7Kyv00VO2CzsoFcWOClYj5rxgeYPtiWmP16gddHJHjB4YuPKMet5YUKxHdpZX8TOJos81BrZ3fGQrYrc66kxfI4kL6+HCfTNIdSan7HoLaL06nu3lpk1y01SCvbelyfJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igFhWWrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFC7C433F1;
	Wed, 20 Mar 2024 02:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710902485;
	bh=leQwJ4BEkGqcz2CwSeZ1U45LFjnBG9t8KtjjHqx7fm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=igFhWWrxihJ2tUfEvG2SJnxlNa5fB/T/xFCJ6M4n3VMsEJeCFI4aljl20KydIHApF
	 YQSKbgHDUI6Bsd6y1Ay0z9ky4hB+e+1ok1uEC9jp9bD23fftxbnVCJvnLz6tbNRwlb
	 0PNX3M4pgSWBcV8O3vnt7gsw+5BXrBd3zd4jfXrqdd2KrAKrGmnr/fy/FXdvpFUtFg
	 7yoKmagOQLsMKo4XlJQ+Qdn0kcDqQEusHYeWDPRWIFzhoLNsutGKCKpnHOl20W01dV
	 ludRBhFfx3MJ1u03kscDZgwSsCFSM9ms91sZvFuUyOLXZRZo7UX+KVVakCdcKdhEBF
	 jFVogn+GoHQ+g==
Date: Tue, 19 Mar 2024 19:41:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com,
 netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v2 1/4] udp: do not accept non-tunnel GSO skbs
 landing in a tunnel
Message-ID: <20240319194124.25097f5a@kernel.org>
In-Reply-To: <20240319093140.499123-2-atenart@kernel.org>
References: <20240319093140.499123-1-atenart@kernel.org>
	<20240319093140.499123-2-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 10:31:36 +0100 Antoine Tenart wrote:
> +DECLARE_STATIC_KEY_FALSE(udp_encap_needed_key);

nit: our build bot says you need to export this as well for v6=m.
-- 
pw-bot: cr

