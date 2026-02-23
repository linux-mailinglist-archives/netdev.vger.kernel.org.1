Return-Path: <netdev+bounces-260134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLSdMfqOnGmdJQQAu9opvQ
	(envelope-from <netdev+bounces-260134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:31:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBB717ADC0
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61ECF301F991
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDFD32FA2F;
	Mon, 23 Feb 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XL8US97q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A9757EA
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867503; cv=none; b=Y8FbyMXH0bZU1xG4TuSHWtKdHjJ1Nmn928K7DfZfktHYNE8+Rt7/gym0wbP1CGVJBoHG7wSV7Cnss9DqTZcJpbMZq9N9SECg3h9CU6FX8JfwchG0+EyQ2fAjgNzM8wTF+/E2Quh8haGuUZL0qhRNdqxhNdBRMfqlugEL0Wec05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867503; c=relaxed/simple;
	bh=RvEVcLKU9+t4Iv3LizhStoaFDw2V7PldvNK+Ai89BI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzUTUU5lpRCdv5bGSbkgKyuuOvmbFdLWumSm6a0L+8WRa6ak6ClGkwqg3gOIyRGpGDvydFO/X6V+YGsKRlzbDJYPS8hCJMIrPzAjwGGPXqKl12lbLC2TMKImCBD+OZ3gKpd9pcFZOqHWovx7poikaxWZNMHQ803misDPLamNP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XL8US97q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D92C116C6;
	Mon, 23 Feb 2026 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771867503;
	bh=RvEVcLKU9+t4Iv3LizhStoaFDw2V7PldvNK+Ai89BI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XL8US97q/yKwhCpA2lgmyjUj6zu4M9YSIXKQ4o2E0ombOTUHBakDRuGtBa3xyFFzt
	 uOBYQg+j/kBFfBe5H5TMAr4XPQ7M5Zf+BazFx7jZwp+j/MrtxOPzJjQTSnIFScip4t
	 FCo7iHP2Z+NqK5NVOb8p5/EE2vBUv1MSmAxF91a0FamlQ1Q6++58nsGYZTf/E8/m18
	 KT33UCSat58CvrPfRYx7XZ+jZ2FnOGry3slN9hNKc0UkS1hXBcA8XQ4eM2OaoujgBU
	 zr6UHwNVkDCDo9Kx6Y7LiljgN7BgldpAFhqC19htKe7MO2PwQfRAVLYiJrcXdaJGb3
	 cm9emxgEM3CuQ==
Date: Mon, 23 Feb 2026 17:24:59 +0000
From: Simon Horman <horms@kernel.org>
To: Tung Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, jmaloy@redhat.com
Subject: Re: [PATCH net] tipc: fix duplicate publication key in
 tipc_service_insert_publ()
Message-ID: <aZyNa__aB_RUozjJ@horms.kernel.org>
References: <20260220050541.237962-1-tung.quang.nguyen@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220050541.237962-1-tung.quang.nguyen@est.tech>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-260134-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 2FBB717ADC0
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 05:05:41AM +0000, Tung Nguyen wrote:
> TIPC uses named table to store TIPC services represented by type and
> instance. Each time an application calls TIPC API bind() to bind a
> type/instance to a socket, an entry is created and inserted into the
> named table. It looks like this:
> 
> named table:
> key1, entry1 (type, instance ...)
> key2, entry2 (type, instance ...)
> 
> In the above table, each entry represents a route for sending data
> from one socket to the other. For all publications originated from
> the same node, the key is UNIQUE to identify each entry.
> It is calculated by this formula:
> key = socket portid + number of bindings + 1 (1)
> 
> where:
>  - socket portid: unique and calculated by using linux kernel function
>                   get_random_u32_below(). So, the value is randomized.
>  - number of bindings: the number of times a type/instance pair is bound
>                        to a socket. This number is linearly increased,
>                        starting from 0.
> 
> While the socket portid is unique and randomized by linux kernel, the
> linear increment of "number of bindings" in formula (1) makes "key" not
> unique anymore. For example:
> - Socket 1 is created with its associated port number 20062001. Type 1000,
> instance 1 is bound to socket 1:
> key1: 20062001 + 0 + 1 = 20062002
> 
> Then, bind() is called a second time on Socket 1 to by the same type 1000,
> instance 1:
> key2: 20062001 + 1 + 1 = 20062003
> 
> Named table:
> key1 (20062002), entry1 (1000, 1 ...)
> key2 (20062003), entry2 (1000, 1 ...)
> 
> - Socket 2 is created with its associated port number 20062002. Type 1000,
> instance 1 is bound to socket 2:
> key3: 20062002 + 0 + 1 = 20062003
> 
> TIPC looks up the named table and finds out that key2 with the same value
> already exists and rejects the insertion into the named table.
> This leads to failure of bind() call from application on Socket 2 with error
> message EINVAL "Invalid argument".
> 
> This commit fixes this issue by adding more port id checking to make sure
> that the key is unique to publications originated from the same port id
> and node.
> 
> Fixes: 218527fe27ad ("tipc: replace name table service range array with rb tree")
> Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>


Thanks.

My understanding is that ->ref functions as the portid.
And if so, this makes sense to me.

Reviewed-by: Simon Horman <horms@kernel.org>

