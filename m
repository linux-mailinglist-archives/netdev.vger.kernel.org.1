Return-Path: <netdev+bounces-77652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CC78727E0
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 20:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F1E1C25F47
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD55915D;
	Tue,  5 Mar 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDx1b/oG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696318639
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668028; cv=none; b=H7woyQmJBEwCTJnlWTHhi50rN4ej/4CRRQE7Ijlmey6BVynbSFJrm5iluPvUZXk2MIk1h3raEApu9WmHe62zxxhrrECAVfIZnxopUqSK9uK45KDL00xzXbg/wp/P6x09ED7mIlgztImcZ78qL9mOlWfI18AKhjasxVhS3Q/a8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668028; c=relaxed/simple;
	bh=+yr0MhDh405JuzPs9EAwBBjdHvrKHQDTa6kD0oUNsxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3nGwGrRD9/ywxSRbdTrPPBHXlk9ysLgzuYO4nMXILuH9rUHgJPhSmtJt86hKhc5anZxUQHzyOzN9DmBCkVPosJ8tvuYF6AzmazP+FeN5ZJxAjvtgOmnAahuEFrmpXCRjUfY7NbNcQk8d/ogdlorolpHdyauyoXYG58riStorRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDx1b/oG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130CAC433C7;
	Tue,  5 Mar 2024 19:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709668028;
	bh=+yr0MhDh405JuzPs9EAwBBjdHvrKHQDTa6kD0oUNsxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDx1b/oGYXqmC8knzWDTEl2mHWNIE5HKg8kCA0xkrZH8qt3DSSX88gVnS68Tfnf2M
	 oSjK3aMdqEH7JeM3VXp0xS1fS5m3Ev68xGHRN5dkzOeW/BJAslC+H323Dug6TAuysN
	 re8ZJp+ruVNDehMKXmfpx9chpItIuejwYB9anEakeZr8LpHLUQRRDM3gbIzDPNucvw
	 iSBO2TEeij24ELBXz3mLKKFdNrFBdXHREAMAPJasIt5bUD/0WAlV1g4pqDSZwxu1Pu
	 csKlvSSnPiJPLkl6h4hYCpZU/Cgogox4tzVZXSUvlrjJkNkgpq5Grd38W8Ij2hsiwg
	 aiJ+oWVSPFERg==
Date: Tue, 5 Mar 2024 11:47:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 08/22] ovpn: implement basic TX path (UDP)
Message-ID: <20240305114707.0276a2bc@kernel.org>
In-Reply-To: <20240304150914.11444-9-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
	<20240304150914.11444-9-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 16:08:59 +0100 Antonio Quartulli wrote:
> +	if (skb_is_gso(skb)) {
> +		segments = skb_gso_segment(skb, 0);
> +		if (IS_ERR(segments)) {
> +			ret = PTR_ERR(segments);
> +			net_err_ratelimited("%s: cannot segment packet: %d\n", dev->name, ret);
> +			goto drop;
> +		}
> +
> +		consume_skb(skb);
> +		skb = segments;
> +	}
> +
> +	/* from this moment on, "skb" might be a list */
> +
> +	__skb_queue_head_init(&skb_list);
> +	skb_list_walk_safe(skb, curr, next) {
> +		skb_mark_not_on_list(curr);
> +
> +		tmp = skb_share_check(curr, GFP_ATOMIC);

The share check needs to be before the segmentation, I think.

