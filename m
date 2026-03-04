Return-Path: <netdev+bounces-263765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAxNEHAVqGnUngAAu9opvQ
	(envelope-from <netdev+bounces-263765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:20:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6F31FEDEB
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EE4D30087B8
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A653A8740;
	Wed,  4 Mar 2026 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHN9zEDN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CD3A872B;
	Wed,  4 Mar 2026 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622972; cv=none; b=k8Nc2KJCkdNtpydNZMxjyMrVG7YIadb+SP0T6B8G8AjU2EQ4b/wb8jBC0pD5Mtb/z9Sf5yDc9TETq80vX58y/ukyKjBoxnX+/pVHg/gzH0ZOYY9vYx7FjpV3k2B7C9e7l6/E6jFX4ZYHr9XTOoJrxM0037NaZSE7suUHrrYzUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622972; c=relaxed/simple;
	bh=i9TS72F0QK9frAqCtJcV/biHy156LHuWzCr0OTOqBNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lA33aXNbK7l0kC1uQlvJjBtTOR4RjMEYp7sYth4H0TBYjXKVej2wH+g1pEmJSkjeS2KR9YltbtHJnr5n3dm+Sg8oY7YQ0lqhTC43YWX1KNqJzy6ruaVhLEHwSJWyD6odYHsRoxdGhjq2MWiyU+Sy2uUvaQR6ObAqhCD+6IetPzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHN9zEDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2515FC19423;
	Wed,  4 Mar 2026 11:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772622972;
	bh=i9TS72F0QK9frAqCtJcV/biHy156LHuWzCr0OTOqBNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHN9zEDNt7+WOMHucjTPyo7b15dFRVUfJwvaG78Lo9orbHKn0kMhU7K3OMsTkF1lW
	 v5p9bryngzYHjvD8hSXTPS+klIr4RT/CzimqHNyIBdPgj0zKKQkwTTZ/vZnYkCDnSS
	 ocO2gXeMZfYCIJWyXjiWaYm6P+29uBY3PGjy6EPvp1CkvYCUSanjvuXJZN0FejFyf/
	 rPMXrATfQUF6nRInROhow06r+BhLeH3AMK/VjENx8PFmNT8uPYMriqfI+MfjNjc9ke
	 wDu5ic4CMd21PmN3FMvBIE4KO6m/9zqfg5W91ZUH4QGPU9tfT5DyYGh5g/jd2NjbXb
	 KKduMr5TfXLOg==
Date: Wed, 4 Mar 2026 11:16:07 +0000
From: Simon Horman <horms@kernel.org>
To: Jian Zhang <zhangjian.3032@bytedance.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ncsi: fix skb leak in error paths
Message-ID: <20260304111607.GH71509@kernel.org>
References: <20260302054629.1347119-1-zhangjian.3032@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302054629.1347119-1-zhangjian.3032@bytedance.com>
X-Rspamd-Queue-Id: 9A6F31FEDEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mendozajonas.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263765-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 01:46:29PM +0800, Jian Zhang wrote:
> Early return paths in NCSI RX and AEN handlers fail to release
> the received skb, resulting in a memory leak.
> 
> Specifically, ncsi_aen_handler() returns on invalid AEN packets
> without consuming the skb. Similarly, ncsi_rcv_rsp() exits early
> when failing to resolve the NCSI device, response handler, or
> request, leaving the skb unfreed.
> 
> Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>

As fixes for Networking code these should have fixes tags.
I think the following are appropriate.

Fixes: 7a82ecf4cfb8 ("net/ncsi: NCSI AEN packet handler")
Fixes: 138635cc27c9 ("net/ncsi: NCSI response packet handler")

As they seem to be commits from the same patch-set,
included in the same release - v4.8-rc1, I think
we can keep this as a single patch.

If you agree then it shouldn't be necessary to post a new version because
of this, as patchwork should pick up the tags above. But for future
reference, assuming these are backporting candidates, it's best to CC
stable on bugfixes for net.

Overall, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

