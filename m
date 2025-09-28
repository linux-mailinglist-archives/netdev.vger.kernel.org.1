Return-Path: <netdev+bounces-227033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 155E1BA7548
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 19:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B813A178303
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11771FFC6D;
	Sun, 28 Sep 2025 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUdIQ+bT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F91E51FA
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759079903; cv=none; b=CJs/hk6amzMX+pjAFCaur7OJN+mTFQ7DCW2cOfTD1Hp/s2eZIZn/xgCEGkxmFlADwerkShvxyYZSTu26PoeUUgI0VnsJDOTfmFLp/I72unf7MAZLDIZnJvoQ+okMHxN5e4ScmjRj0e/bCWxB4l6KfWdsgqS4LaQ9xGR4YzUBi2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759079903; c=relaxed/simple;
	bh=x2yexiXIy45u2otga7DM9/2C/G9c+BzLFnUMgiFDWgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f00usU7luo3lfpu2Gky6mXuXnCdryg83DrkPmcYCd3sEddyzXHm9UKWywTz14r7xT9rc3RnZLPpLnu0FN/ZB4yiZuD9SDyDoB/BUwW7w1UwxSz9aXoTq+nU//8TdLoRHxjacGIroBrISHQfjLRtgDLYXObIR1ryEnVJvBNoU0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUdIQ+bT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0912C4CEF0;
	Sun, 28 Sep 2025 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759079902;
	bh=x2yexiXIy45u2otga7DM9/2C/G9c+BzLFnUMgiFDWgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUdIQ+bTKFjbZ0ndk8QdFvHlmV0dDZkpCWLPHS+5L11iAohcBvkHfhTbai+eicon3
	 OaMI57rilM0czp+x3dM9Vn/TACAUvrHjmyiDtEcDhBQy10iQV/sDbZuFI6bG56XLCm
	 4L2YOgOVSl07P+U74FUx1RZNVH1NE0Tfp3BZhGrl34nax4Qls15rULw8pT9yj0SGEJ
	 WmnGohB/zEidAYYaCmRtlBP4cTsBorfa0p1WOcaKTGoDEK4ZUddM1aHInpM1PV6gAV
	 qRgUxlDkAJe0W1aFJNEX/kRAGoG5AsHeNK/NDDrGeX6yFJOeoH46bfUeVuLiKoc2yf
	 AOJYlTl/9hgqw==
Date: Sun, 28 Sep 2025 10:17:03 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 3/4] batman-adv: keep skb crc32 helper local in
 BLA
Message-ID: <20250928171703.GA6416@sol>
References: <20250916122441.89246-1-sw@simonwunderlich.de>
 <20250916122441.89246-4-sw@simonwunderlich.de>
 <20250927205552.GD9798@quark>
 <2878689.BEx9A2HvPv@sven-desktop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2878689.BEx9A2HvPv@sven-desktop>

On Sun, Sep 28, 2025 at 10:45:12AM +0200, Sven Eckelmann wrote:
> On Saturday, 27 September 2025 22:55:52 CEST Eric Biggers wrote:
> > Hi,
> > 
> > On Tue, Sep 16, 2025 at 02:24:40PM +0200, Simon Wunderlich wrote:
> > > +static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
> > > +{
> > > +	unsigned int to = skb->len;
> > > +	unsigned int consumed = 0;
> > > +	struct skb_seq_state st;
> > > +	unsigned int from;
> > > +	unsigned int len;
> > > +	const u8 *data;
> > > +	u32 crc = 0;
> > > +
> > > +	from = (unsigned int)(payload_ptr - skb->data);
> > > +
> > > +	skb_prepare_seq_read(skb, from, to, &st);
> > > +	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
> > > +		crc = crc32c(crc, data, len);
> > > +		consumed += len;
> > > +	}
> > > +
> > > +	return htonl(crc);
> > > +}
> > 
> > Has using skb_crc32c() been considered here?
> 
> No. At the time this was written (v3.8), skb_crc32c (v6.16) didnt exist. Also 
> its predecessor __skb_checksum only started its existence in v3.13. And no one 
> noticed it as candidate to replace batadv_skb_crc32 with
> 
> And this patch here was just moving the function between two places - so not 
> introducing new code.
> 
> Do you want to submit a patch to integrate your new function in batman-adv? I 
> only performed a quick-and-dirty test to see if it returns the same results 
> and it seemed to do its job fine.
> 
> diff --git c/net/batman-adv/Kconfig w/net/batman-adv/Kconfig
> index c299e2bc..58c408b7 100644
> --- c/net/batman-adv/Kconfig
> +++ w/net/batman-adv/Kconfig
> @@ -35,6 +35,7 @@ config BATMAN_ADV_BLA
>  	bool "Bridge Loop Avoidance"
>  	depends on BATMAN_ADV && INET
>  	select CRC16
> +	select NET_CRC32C
>  	default y
>  	help
>  	  This option enables BLA (Bridge Loop Avoidance), a mechanism
> diff --git c/net/batman-adv/bridge_loop_avoidance.c w/net/batman-adv/bridge_loop_avoidance.c
> index b992ba12..eef40b6f 100644
> --- c/net/batman-adv/bridge_loop_avoidance.c
> +++ w/net/batman-adv/bridge_loop_avoidance.c
> @@ -12,7 +12,6 @@
>  #include <linux/compiler.h>
>  #include <linux/container_of.h>
>  #include <linux/crc16.h>
> -#include <linux/crc32.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/etherdevice.h>
> @@ -1585,45 +1584,11 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
>  	return 0;
>  }
>  
> -/**
> - * batadv_skb_crc32() - calculate CRC32 of the whole packet and skip bytes in
> - *  the header
> - * @skb: skb pointing to fragmented socket buffers
> - * @payload_ptr: Pointer to position inside the head buffer of the skb
> - *  marking the start of the data to be CRC'ed
> - *
> - * payload_ptr must always point to an address in the skb head buffer and not to
> - * a fragment.
> - *
> - * Return: big endian crc32c of the checksummed data
> - */
> -static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
> -{
> -	unsigned int to = skb->len;
> -	unsigned int consumed = 0;
> -	struct skb_seq_state st;
> -	unsigned int from;
> -	unsigned int len;
> -	const u8 *data;
> -	u32 crc = 0;
> -
> -	from = (unsigned int)(payload_ptr - skb->data);
> -
> -	skb_prepare_seq_read(skb, from, to, &st);
> -	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
> -		crc = crc32c(crc, data, len);
> -		consumed += len;
> -	}
> -
> -	return htonl(crc);
> -}
> -
>  /**
>   * batadv_bla_check_duplist() - Check if a frame is in the broadcast dup.
>   * @bat_priv: the bat priv with all the mesh interface information
>   * @skb: contains the multicast packet to be checked
> - * @payload_ptr: pointer to position inside the head buffer of the skb
> - *  marking the start of the data to be CRC'ed
> + * @payload_offset: offset in the skb, marking the start of the data to be CRC'ed
>   * @orig: originator mac address, NULL if unknown
>   *
>   * Check if it is on our broadcast list. Another gateway might have sent the
> @@ -1638,16 +1603,18 @@ static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
>   * Return: true if a packet is in the duplicate list, false otherwise.
>   */
>  static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
> -				     struct sk_buff *skb, u8 *payload_ptr,
> +				     struct sk_buff *skb, int payload_offset,
>  				     const u8 *orig)
>  {
>  	struct batadv_bcast_duplist_entry *entry;
>  	bool ret = false;
> +	int payload_len;
>  	int i, curr;
>  	__be32 crc;
>  
>  	/* calculate the crc ... */
> -	crc = batadv_skb_crc32(skb, payload_ptr);
> +	payload_len = skb->len - payload_offset;
> +	crc = htonl(skb_crc32c(skb, payload_offset, payload_len, 0));
>  
>  	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
>  
> @@ -1727,7 +1694,7 @@ static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
>  static bool batadv_bla_check_ucast_duplist(struct batadv_priv *bat_priv,
>  					   struct sk_buff *skb)
>  {
> -	return batadv_bla_check_duplist(bat_priv, skb, (u8 *)skb->data, NULL);
> +	return batadv_bla_check_duplist(bat_priv, skb, 0, NULL);
>  }
>  
>  /**
> @@ -1745,12 +1712,10 @@ bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
>  				    struct sk_buff *skb)
>  {
>  	struct batadv_bcast_packet *bcast_packet;
> -	u8 *payload_ptr;
>  
>  	bcast_packet = (struct batadv_bcast_packet *)skb->data;
> -	payload_ptr = (u8 *)(bcast_packet + 1);
>  
> -	return batadv_bla_check_duplist(bat_priv, skb, payload_ptr,
> +	return batadv_bla_check_duplist(bat_priv, skb, sizeof(*bcast_packet),
>  					bcast_packet->orig);
>  }

It looks like you're already most of the way there, so I suggest you
send the patch.  Thanks!

- Eric

