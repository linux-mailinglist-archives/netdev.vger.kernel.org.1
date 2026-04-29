Return-Path: <netdev+bounces-282497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DZ1D3Vy8mmJrQEAu9opvQ
	(envelope-from <netdev+bounces-282497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:04:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A710C49A5C5
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45A81301BEFD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6119F3A4F59;
	Wed, 29 Apr 2026 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZktUrtBB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D839658A
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496682; cv=none; b=b0QyTDj8oYUR27tm9g2ljIkoTmKzS0qDAJc/4uU/aggl07wRLemfj3cisaERkhJTMseTbY5yADSLYWkD1Zw/TTJl0ZM6qnHcDw2UbIrJrNw04nLkx9lRiu/rAXjNxD1Qn/GUoZkLyG7NVrPOrKMxRz0Oj/VJ4RGTFFX/wkg+rJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496682; c=relaxed/simple;
	bh=v/klsiu7TJPttt22aJUT+v/pyfHGYXeDwOs1tw27diI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=n8GhP8/VNlayEuRy6QkBOTHQiP98FNzNX8S5RKXLuEHadliOsOqA4RigQ4e0oQqdXoHG6wIMMXiByCZMFJ+e+S9a6a6dk0zqfZVbMuPBBWer4CIFJmE0o74UZXcRpIs4WZ7JlQlAK+6HDErf1lOtKxnebAtiFfEqGCeai9Zj/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZktUrtBB; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7baee75f874so2881597b3.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777496680; x=1778101480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmrzn3X/9uiZSme2Vvclamu0yQ/WhXJrbCkODCE5Ny4=;
        b=ZktUrtBBVrYYoentT2nUPeB+nW0se3f7+ZWUQAXiZPFsZ6G+584JYN6bAb8PQXMPUy
         xjjl7nEs6VM+fOLYPVZul5ZcosXCwB/qGiq1i1NXVKh0zCbzKOMs4J9Yo9ZnBf6QNJ5Z
         5UARXfP9YCSN7YRXIfXUoeut48S/ddRCdSTBcNMImdHJTowOzPT3UKsbisqCd/XUU8Ux
         pmQM6zPqrB410p2N6n/mh5bnsIIijsVgRZxD3aUWNUFDExH35JT7n0K200ahmQJQwxpS
         INWJ2AXYjpn+kSssOMLbfkVlv9i1ARuCSuIzSMG8TiUzmdbHhdBwbWmDOHqsalPngPvX
         YcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777496680; x=1778101480;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmrzn3X/9uiZSme2Vvclamu0yQ/WhXJrbCkODCE5Ny4=;
        b=Ba7rvH2zia22FWBZF+Y8YDlRfco1nH0oIsr99E6m8zC18vIPBjPJ02ICg2sX5jS5LM
         cpQlIc6MOogAVD/rkf++RlYnQ8ApVebU9oBi7FuOSjBx7rLUVAAqv7C+0gMUtzHexriu
         qXZUh78W0Zc72E5+LnP/nNteBTWvLKSHorUbCnfTHhmYBrUSyJ0wZriuC5ZGZ01AV/bw
         n36MCQZkGOPlUFLK5u+GtbsNc6aFR2cQiLNAIuDh5SXjmg7t4n1V+glAlJDMnHVLZAE9
         TYHYgLDqTtZ0+vw4T15cWXtQm9g+CnEnFKC9NMdEXo6Bk/1aPtn+rknMt2xIfYqXgdDW
         Bt3A==
X-Forwarded-Encrypted: i=1; AFNElJ8a6EoxI5yhC7vOyAOJV5CegnVoAdhzZzOCBIdBGJhUaTAYh0QxSoUVHCGyJyYkLy/ww/Ua+T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyytIlGV5JASf98beWgpm6YzivA8xOw/Tyc/nyDmodarIqFvk0t
	ev1lJTgcfudCpNy1U5xspzCPhX+4klR9NHFCi4JXhvrnZMsGi5LDh/ap
X-Gm-Gg: AeBDievcEm2ylNxBJ3zWtRcLrgA0EZnRUL7cp2hk6/vd9g54jbwEv0yJssa6up6OLDl
	iAiC3Dg9A4bQw94qakZzRPmBx80BTA8FslacjU9XHW3SqZqI113goHb2dFSoVqQq/W1h6QSYZ65
	O1xcRoCSUrxeCfkFuRnBZCsMHkaFWqMLZdLokyMHtU89utF2BfHUrPZLVEYEmXn2s4UIJLKJvWt
	0cIyYwS7wvrveJtYZhhis4FIpf8UzlZMpZzxHPwZWT8Gz6RJWz8O7rjPvBZYF5JPG9QP8tVtifl
	msEA1czvV1LsUruEaE9kqfA9Y5KZnLU6Skf+URNCKw9fPBCweKC56/vzH+Z1D8q0b0ZTmdfmQxZ
	C3ufpV+FZZ4Ljq9KpcSc58whGJveqRUTgSAk/liDEX0mrrkdvTpfcO7ALeaHn9fsC2HUuliZW7A
	LGgYXlorc1S5VlJPleMUk/bsclc8UblfW73uGqIuFBI5ELG3JKngfGT1yVnbZhHAdSDjcmjIGZh
	qsvhVydQEpRriM=
X-Received: by 2002:a05:690c:64c3:b0:7b4:53df:b02 with SMTP id 00721157ae682-7bd5292e5c3mr4674197b3.28.1777496679795;
        Wed, 29 Apr 2026 14:04:39 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd5446d0ebsm295307b3.43.2026.04.29.14.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:04:39 -0700 (PDT)
Date: Wed, 29 Apr 2026 17:04:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kohei Enju <kohei@enjuk.jp>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Gerhard Engleder <gerhard@engleder-embedded.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Kohei Enju <kohei@enjuk.jp>
Message-ID: <willemdebruijn.kernel.2d041a6261a02@gmail.com>
In-Reply-To: <20260429091632.26509-2-kohei@enjuk.jp>
References: <20260429091632.26509-1-kohei@enjuk.jp>
 <20260429091632.26509-2-kohei@enjuk.jp>
Subject: Re: [PATCH net v1 1/3] net: introduce helper to resolve hardware
 timestamps from skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A710C49A5C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282497-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,engleder-embedded.com,gmail.com,enjuk.jp];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Kohei Enju wrote:
> Move the logic that resolves a hardware timestamp from an skb, including
> late timestamp resolution via netdev_get_tstamp(), from net/socket.c to
> a common helper.
> 
> Let's allow other networking code to reuse the same resolution path.
> 
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Thanks for the fix series.

Fixes require a Fixes tag. See also https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html.

I suggest merging this and the second patch, as this is not a
standalone fix, and the other is a one-line change.

> ---
>  include/linux/skbuff.h | 11 +++++++++++
>  net/core/skbuff.c      | 27 +++++++++++++++++++++++++++
>  net/socket.c           | 27 +++------------------------
>  3 files changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2bcf78a4de7b..651a5ae8b11c 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4731,6 +4731,17 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb, const struct sk_buff *ack_skb,
>  void skb_tstamp_tx(struct sk_buff *orig_skb,
>  		   struct skb_shared_hwtstamps *hwtstamps);
>  
> +/**
> + * skb_get_hwtstamp - resolve a hardware timestamp from an skb
> + * @skb:	skb carrying the timestamp
> + * @cycles:	true to request the free-running cycle-based timestamp
> + * @if_index:	optional return pointer for the originating netdev ifindex
> + *
> + * Return: resolved hardware timestamp, or the stored skb hwtstamp when no
> + * device-specific late timestamp resolution is needed.
> + */
> +ktime_t skb_get_hwtstamp(struct sk_buff *skb, bool cycles, int *if_index);
> +
>  /**
>   * skb_tx_timestamp() - Driver hook for transmit timestamping
>   *
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 7dad68e3b518..d11f4e2e9391 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5729,6 +5729,33 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
>  }
>  EXPORT_SYMBOL_GPL(skb_tstamp_tx);
>  
> +ktime_t skb_get_hwtstamp(struct sk_buff *skb, bool cycles, int *if_index)
> +{
> +	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
> +	struct net_device *orig_dev;
> +	ktime_t hwtstamp;
> +
> +	if (if_index)
> +		*if_index = 0;
> +
> +	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV))
> +		return shhwtstamps->hwtstamp;
> +
> +	rcu_read_lock();
> +	orig_dev = dev_get_by_napi_id(skb_napi_id(skb));
> +	if (orig_dev) {
> +		if (if_index)
> +			*if_index = orig_dev->ifindex;
> +		hwtstamp = netdev_get_tstamp(orig_dev, shhwtstamps, cycles);
> +	} else {
> +		hwtstamp = shhwtstamps->hwtstamp;
> +	}
> +	rcu_read_unlock();
> +
> +	return hwtstamp;
> +}
> +EXPORT_SYMBOL_GPL(skb_get_hwtstamp);
> +
>  #ifdef CONFIG_WIRELESS
>  void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
>  {
> diff --git a/net/socket.c b/net/socket.c
> index 22a412fdec07..95b21b16a0fc 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -876,21 +876,7 @@ static bool skb_is_swtx_tstamp(const struct sk_buff *skb, int false_tstamp)
>  static ktime_t get_timestamp(struct sock *sk, struct sk_buff *skb, int *if_index)
>  {
>  	bool cycles = READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC;
> -	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
> -	struct net_device *orig_dev;
> -	ktime_t hwtstamp;
> -
> -	rcu_read_lock();
> -	orig_dev = dev_get_by_napi_id(skb_napi_id(skb));
> -	if (orig_dev) {
> -		*if_index = orig_dev->ifindex;
> -		hwtstamp = netdev_get_tstamp(orig_dev, shhwtstamps, cycles);
> -	} else {
> -		hwtstamp = shhwtstamps->hwtstamp;
> -	}
> -	rcu_read_unlock();
> -
> -	return hwtstamp;
> +	return skb_get_hwtstamp(skb, cycles, if_index);
>  }

At this point simpler to remove get_timestamp entirely. It's an
unnecessary layer of indirection.

Perhaps pass sk_tsflags rather than bool to skb_get_hwtstamp.
  
>  static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb,
> @@ -940,7 +926,6 @@ int skb_get_tx_timestamp(struct sk_buff *skb, struct sock *sk,
>  {
>  	u32 tsflags = READ_ONCE(sk->sk_tsflags);
>  	ktime_t hwtstamp;
> -	int if_index = 0;
>  
>  	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
>  	    ktime_to_timespec64_cond(skb->tstamp, ts))
> @@ -950,10 +935,7 @@ int skb_get_tx_timestamp(struct sk_buff *skb, struct sock *sk,
>  	    skb_is_swtx_tstamp(skb, false))
>  		return -ENOENT;
>  
> -	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
> -		hwtstamp = get_timestamp(sk, skb, &if_index);
> -	else
> -		hwtstamp = skb_hwtstamps(skb)->hwtstamp;
> +	hwtstamp = get_timestamp(sk, skb, NULL);
>  
>  	if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
>  		hwtstamp = ptp_convert_timestamp(&hwtstamp,
> @@ -1033,10 +1015,7 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
>  	      !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
>  	    !skb_is_swtx_tstamp(skb, false_tstamp)) {
>  		if_index = 0;
> -		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
> -			hwtstamp = get_timestamp(sk, skb, &if_index);
> -		else
> -			hwtstamp = shhwtstamps->hwtstamp;
> +		hwtstamp = get_timestamp(sk, skb, &if_index);
>  
>  		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
>  			hwtstamp = ptp_convert_timestamp(&hwtstamp,
> -- 
> 2.53.0
> 



