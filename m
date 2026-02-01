Return-Path: <netdev+bounces-255556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOwqEvybfmnGbQIAu9opvQ
	(envelope-from <netdev+bounces-255556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:19:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDAC47B7
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D53B3018753
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 00:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC1C19B5A7;
	Sun,  1 Feb 2026 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPuk8jyP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0657A59;
	Sun,  1 Feb 2026 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769905146; cv=none; b=eEMOOYZf38FFw8MuNJ2e1IYbrtJZxaKzdF17t87oI0IbyULmqBO701R3OZk4XPDEmaeJUVt99Qu9CjHSl366OsUOsHbQ/R1c8E6elj7/IeecgfdHNH37jOYYU6ZQEIuSWAoPqIykYA/fB/NI5xhM335pgNYW8T/WvETK8RApmd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769905146; c=relaxed/simple;
	bh=euGTdnZHCV2R7LBMHiViBQoJGTwnWpST7MI06YTCPFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2aX6pS/cT/EB4/U5pABoKIQTmGAz/kkuInL7GI1M/O/kUKBpGZRQkaL9GxYYoXogqTXaL1qK897L5aSQSNIRn4+kugZQyW3GScDMV93dzKIeQ2PWUsBGdpZwPBjYEfD5CkildOZo9EY8eY4Al4qKO97Y2tfUruQiZ5auwB8B2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPuk8jyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9B2C4CEF1;
	Sun,  1 Feb 2026 00:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769905145;
	bh=euGTdnZHCV2R7LBMHiViBQoJGTwnWpST7MI06YTCPFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QPuk8jyPZe6BfPXpA6e7gaX9KqVwArTPwmyTfnbenYXeA16K+Iq+W5FR1qUnFKxEl
	 kKjyyimtyA7zDpxfUuZxQ8FJtZ0wS4SlHh0EODPd6EK9BG0BuAGluAKzfVq6A2JjvB
	 2V4zrMsCvZRTkbZfrcIIu0h4W/UmDcYXMYw4u9Hki2om0SlipgJSdBtTecFYRyYiy5
	 Yhch5HB7hLXeTX7oU/TuTOQFq4GgNPtzCQyoOxQHwMpHhCGgTsdQmpFjIA1vt5NYyy
	 8xAmkaCEQRy66IMzhfFx8fTIiL8B9Fmd0MnKWS7H8/y7FC0OtGAjFnEGYflz8Bwxrf
	 H5kpcG0usKSjg==
Date: Sat, 31 Jan 2026 16:19:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 11/16] netkit: Implement
 rtnl_link_ops->alloc and ndo_queue_create
Message-ID: <20260131161903.064b5cb2@kernel.org>
In-Reply-To: <20260129222830.439687-12-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-12-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255556-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0EDAC47B7
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 23:28:25 +0100 Daniel Borkmann wrote:
> +	if (netif_running(dev))
> +		netif_carrier_off(dev);
> +	err = netif_set_real_num_rx_queues(dev, rxq_count_new);
> +	if (netif_running(dev))
> +		netif_carrier_on(dev);

Why do we need to flap the carrier?
(If there's a reason perhaps add a comment?)

