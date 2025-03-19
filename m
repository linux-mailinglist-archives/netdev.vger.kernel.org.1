Return-Path: <netdev+bounces-176207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D556A6959E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60143BAAC3
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9132B1E22E6;
	Wed, 19 Mar 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Tq66VM76"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E5114D70E;
	Wed, 19 Mar 2025 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403563; cv=none; b=KLgKKWdgJWxoea6VhfPBkgbZtq9maat6H5VXK/Llk1CeRYjCkmSw+kGLgcUJemGreYWs3/XlYw0SD7M7ujLbCv9yuijU7i9GzXtBnZx3KWwDHzrP4LiKx0b6eeosT1Giqakm3IVki61x7gX43xk2007zP2umDoJ/tOJWL9Q+rzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403563; c=relaxed/simple;
	bh=C/oLQqGLGQ9DX0nwXmSdMgfjgHP3EaILZb0W8jEkeYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBojvTw3Y69xNiB22AqWQKFyxqcA9KJIYwdqHO1JUYoU1QhU00PYj2vDJ1v40DQx1FQWFLVLkRlDMphcJQXfNasf69tXblYr2XnbiusMbBa5Mdr8GPa2HQjRc31Th4C87R0lvmsKDksH50FozoMcdurpvjryJQgToA0BqUS900o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Tq66VM76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4FAC4CEE4;
	Wed, 19 Mar 2025 16:59:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Tq66VM76"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1742403561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uf/p7VlVNzQ814HdQ3t8Ub9K7Z0QRnEkUpNVCIzegLU=;
	b=Tq66VM76yopfaCOE3UPF1qlAPt1DsX2zUYDHrSNummG1xYmOUI7d8Ewg8pRwES15HaorQh
	bAv7+5B4aGoERuQIVOXGVzyCehOPPd1G3/XdxZzpA0ux+Kqg6s8VIUj2UF3RS5Dwklc4og
	pWkNWnxxVysrGgrmfc8P7GhTYzMigRg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7a205e8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 16:59:20 +0000 (UTC)
Date: Wed, 19 Mar 2025 17:59:16 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Dmitrii Ermakov <demonihin@gmail.com>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] wireguard: use rhashtables instead of hashtables
Message-ID: <Z9r35H2rfLV8m5iW@zx2c4.com>
References: <20250105110036.70720-2-demonihin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250105110036.70720-2-demonihin@gmail.com>

On Sun, Jan 05, 2025 at 12:00:17PM +0100, Dmitrii Ermakov wrote:
> @@ -74,7 +75,6 @@ struct noise_handshake {
>  	u8 remote_static[NOISE_PUBLIC_KEY_LEN];
>  	u8 remote_ephemeral[NOISE_PUBLIC_KEY_LEN];
>  	u8 precomputed_static_static[NOISE_PUBLIC_KEY_LEN];
> -
>  	u8 preshared_key[NOISE_SYMMETRIC_KEY_LEN];
>  
>  	u8 hash[NOISE_HASH_LEN];
> @@ -83,6 +83,8 @@ struct noise_handshake {
>  	u8 latest_timestamp[NOISE_TIMESTAMP_LEN];
>  	__le32 remote_index;
>  
> +	siphash_key_t hash_seed;

Why?

> +#include "linux/printk.h"
> +#include "linux/rcupdate.h"
> +#include "linux/rhashtable-types.h"
> +#include "linux/rhashtable.h"
> +#include "linux/siphash.h"

Seems wrong.

> +#include "messages.h"
>  #include "peer.h"
>  #include "noise.h"
> +#include "linux/memory.h"

Ditto.

>  
> -static struct hlist_head *pubkey_bucket(struct pubkey_hashtable *table,
> -					const u8 pubkey[NOISE_PUBLIC_KEY_LEN])
> +static inline u32 index_hashfn(const void *data, u32 len, u32 seed)
>  {
> -	/* siphash gives us a secure 64bit number based on a random key. Since
> -	 * the bits are uniformly distributed, we can then mask off to get the
> -	 * bits we need.
> -	 */
> -	const u64 hash = siphash(pubkey, NOISE_PUBLIC_KEY_LEN, &table->key);
> +	const u32 *index = data;
> +	return *index;
> +}

But shouldn't this actually use siphash? What's happening here?

> +struct peer_hash_pubkey {
> +	siphash_key_t key;
> +	u8 pubkey[NOISE_PUBLIC_KEY_LEN];
> +};
> +
> +static inline u32 wg_peer_obj_hashfn(const void *data, u32 len, u32 seed)
> +{
> +	const struct wg_peer *peer = data;
> +	struct peer_hash_pubkey key;
> +	u64 hash;
> +
> +	memcpy(&key.key, &peer->handshake.hash_seed, sizeof(key.key));
> +	memcpy(&key.pubkey, &peer->handshake.remote_static, NOISE_PUBLIC_KEY_LEN);
> +
> +	hash = siphash(&key.pubkey, NOISE_PUBLIC_KEY_LEN, &key.key);

Why this weird construction with this other struct?

I'll stop reading here. There's a lot of strangeness with this patch.
Maybe it's workable with enough care, but I think to review this into
shape, in its current state, would be about the same as just rewriting
it.

