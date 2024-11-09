Return-Path: <netdev+bounces-143522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA6F9C2D93
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 14:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E71F280FBC
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C1B194125;
	Sat,  9 Nov 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="zeQkhBax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0342192B95
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731159650; cv=none; b=N0P/FHgeTRkJw/DWSRJmi0IYvaymep8XImjKGTIUvunJqnJDG3LtOrjmqyaQDkesQL21zIYO1MmisAEqBY58D4GwQoPHKLwQRt8k5X8ErP6cxZsG5eUT1HylFFTk99ZMuV7P7YDaFbD/JMh1N3HZeYqWUyEXryLHrkAKvZFrzrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731159650; c=relaxed/simple;
	bh=DpuvVt7caLTKXKo/ZpTpfxwmYD5a5qfV0OjlFjgHRkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6UuSXO2Y1psuTQYogkULbNVZTRbMNt1CxKymmcoEr6ExEgLjRjXkPermA6nsGw+4r7VB4CNGLends5ypEdsBm6pKhQaoohpyEYFhJdtzsUbZRuijCWGJ5GkDo2Xdx+NLzTknV0AJU5O/y2pvJk75ozoLL2k9aXHg+Xv/YZ3wx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=zeQkhBax; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53b34ed38easo3099221e87.0
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 05:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731159647; x=1731764447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxB5gPoc3zzAhuEQiHf7da4pTtcAC3DNJzHv50OU/m4=;
        b=zeQkhBaxgRaNjfPlN36AymfuUjNsxsPD6ibGlIMH2vK93+wglIykN/oWy7u9dUAddH
         jUUJh88oo8Oha1DrOs4bi1AIVB48oagj2GgD0z8R4vul0BwG/ItXcMPNmjBQYMLvvbyT
         6ojXCA+dAbf5ORKdP2rGkJPZ2MY95dGEOrHhktHJ+UxDx92z9r7RuMe+b+OL3JM8iP04
         +JHO2tYS8kz2/4TOYLMecJJ5BD3sF7Clr747ROQtwLTP95ZD0+J8jYdg2S/8MCq3ADpP
         92YdW7lIIn6Y0L2MzJdSwN+sVJySc7ddBdAJ4jEQD4jxTm6uX+OJEglIXuYduR35BTZV
         Mb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731159647; x=1731764447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxB5gPoc3zzAhuEQiHf7da4pTtcAC3DNJzHv50OU/m4=;
        b=E6LHUijIn+ZT2GOpo9dwAmCNk5qytkFfwdaR3ahkbDSyeFwqIZ21/w0oA+k1xCI/fd
         YL7B6LpH8S7rSZj5UpjniDNmsAgWOXMmTJVyD95sxmnXl2n8hX8EjFISXDM7U+MYhg+s
         C+1sA+TqVv0o8SWmWJw11xRt6CTDG1GvAC0DviHp6dIjrXAy8btl4ux19a58/x7NuVKM
         0PHlP1Yibjuf7U2Bu5YIIfMfiO3mtbVwEK7AE7dNszh5pW42Iu4XQyyIEIACpXeP/NFV
         xLztL+SI01TlckW/xATkYgPuMR0r4hHjQcwj7ZfTs5C2cMC5Af9vep7gzylLndJeDQNR
         3z2g==
X-Forwarded-Encrypted: i=1; AJvYcCVFtveNWAAH9fQkLOj2kqBRW8NnSTnIuwfUDopATOjvCNeBI3M5urgFCOWjF3s9WIGeOmFn0i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNiVycJ3n7t0sv6fqMudk9oBx9+OThs6zrLZ+552L8rmVQckhJ
	gYL7/0J65CYDGQO4Q+SZ3+QtO2AaOERAAxMva3vkDgntiv5eIpr0TCQLl+XysF8=
X-Google-Smtp-Source: AGHT+IE0JAECEIE2ksLs8Y2aggg+blpxzPCgZBIS2K0qt/fU9tDMt9/9JtHZZK89+t7cjZNI3BmPvA==
X-Received: by 2002:a05:6512:b83:b0:53c:7652:6c7a with SMTP id 2adb3069b0e04-53d862b45c8mr2870834e87.8.1731159646629;
        Sat, 09 Nov 2024 05:40:46 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7248sm919292e87.127.2024.11.09.05.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 05:40:46 -0800 (PST)
Date: Sat, 9 Nov 2024 15:40:45 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Cc: davem@davemloft.net, Roopa Prabhu <roopa@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [RFC net-next 2/4] net: bridge: send notification for roaming
 hosts
Message-ID: <Zy9mXda9diHR_Eh5@penguin>
References: <20241108032422.2011802-1-elliot.ayrey@alliedtelesis.co.nz>
 <20241108032422.2011802-3-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108032422.2011802-3-elliot.ayrey@alliedtelesis.co.nz>

On Fri, Nov 08, 2024 at 04:24:19PM +1300, Elliot Ayrey wrote:
> When an fdb entry is configured as static and sticky it should never
> roam. However there are times where it would be useful to know when
> this happens so a user application can act on it. For this reason,
> extend the fdb notification mechanism to send a notification when the
> bridge detects a host that is attempting to roam when it has been
> configured not to.
> 
> This is achieved by temporarily updating the fdb entry with the new
> port, setting a new notify roaming bit, firing off a notification, and
> restoring the original port immediately afterwards. The port remains
> unchanged, respecting the sticky flag, but userspace is now notified
> of the new port the host was seen on.
> 
> The roaming bit is cleared if the entry becomes inactive or if it is
> replaced by a user entry.
> 
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
>  include/uapi/linux/neighbour.h |  4 ++-
>  net/bridge/br_fdb.c            | 64 +++++++++++++++++++++++-----------
>  net/bridge/br_input.c          | 10 ++++--
>  net/bridge/br_private.h        |  3 ++
>  4 files changed, 58 insertions(+), 23 deletions(-)
> 

No way, this is ridiculous. Changing the port like that for a notification is not
ok at all. It is also not the bridge's job to notify user-space for sticky fdbs
that are trying to roam, you already have some user-space app and you can catch
such fdbs by other means (sniffing, ebpf hooks, netfilter matching etc). Such
change can also lead to DDoS attacks with many notifications.

Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>

> diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
> index 5e67a7eaf4a7..e1c686268808 100644
> --- a/include/uapi/linux/neighbour.h
> +++ b/include/uapi/linux/neighbour.h
> @@ -201,10 +201,12 @@ enum {
>   /* FDB activity notification bits used in NFEA_ACTIVITY_NOTIFY:
>    * - FDB_NOTIFY_BIT - notify on activity/expire for any entry
>    * - FDB_NOTIFY_INACTIVE_BIT - mark as inactive to avoid multiple notifications
> +  * - FDB_NOTIFY_ROAMING_BIT - mark as attempting to roam
>    */
>  enum {
>  	FDB_NOTIFY_BIT		= (1 << 0),
> -	FDB_NOTIFY_INACTIVE_BIT	= (1 << 1)
> +	FDB_NOTIFY_INACTIVE_BIT	= (1 << 1),
> +	FDB_NOTIFY_ROAMING_BIT	= (1 << 2)
>  };
>  
>  /* embedded into NDA_FDB_EXT_ATTRS:
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index d0eeedc03390..a8b841e74e15 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -145,6 +145,8 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
>  			goto nla_put_failure;
>  		if (test_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags))
>  			notify_bits |= FDB_NOTIFY_INACTIVE_BIT;
> +		if (test_bit(BR_FDB_NOTIFY_ROAMING, &fdb->flags))
> +			notify_bits |= FDB_NOTIFY_ROAMING_BIT;
>  
>  		if (nla_put_u8(skb, NFEA_ACTIVITY_NOTIFY, notify_bits)) {
>  			nla_nest_cancel(skb, nest);
> @@ -554,8 +556,10 @@ void br_fdb_cleanup(struct work_struct *work)
>  					work_delay = min(work_delay,
>  							 this_timer - now);
>  				else if (!test_and_set_bit(BR_FDB_NOTIFY_INACTIVE,
> -							   &f->flags))
> +							   &f->flags)) {
> +					clear_bit(BR_FDB_NOTIFY_ROAMING, &f->flags);
>  					fdb_notify(br, f, RTM_NEWNEIGH, false);
> +				}
>  			}
>  			continue;
>  		}
> @@ -880,6 +884,19 @@ static bool __fdb_mark_active(struct net_bridge_fdb_entry *fdb)
>  		  test_and_clear_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags));
>  }
>  
> +void br_fdb_notify_roaming(struct net_bridge *br, struct net_bridge_port *p,
> +			   struct net_bridge_fdb_entry *fdb)
> +{
> +	struct net_bridge_port *old_p = READ_ONCE(fdb->dst);
> +
> +	if (test_bit(BR_FDB_NOTIFY, &fdb->flags) &&
> +	    !test_and_set_bit(BR_FDB_NOTIFY_ROAMING, &fdb->flags)) {
> +		WRITE_ONCE(fdb->dst, p);
> +		fdb_notify(br, fdb, RTM_NEWNEIGH, false);
> +		WRITE_ONCE(fdb->dst, old_p);
> +	}
> +}
> +
>  void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>  		   const unsigned char *addr, u16 vid, unsigned long flags)
>  {
> @@ -906,21 +923,24 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>  			}
>  
>  			/* fastpath: update of existing entry */
> -			if (unlikely(source != READ_ONCE(fdb->dst) &&
> -				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
> -				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
> -				WRITE_ONCE(fdb->dst, source);
> -				fdb_modified = true;
> -				/* Take over HW learned entry */
> -				if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
> -						      &fdb->flags)))
> -					clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
> -						  &fdb->flags);
> -				/* Clear locked flag when roaming to an
> -				 * unlocked port.
> -				 */
> -				if (unlikely(test_bit(BR_FDB_LOCKED, &fdb->flags)))
> -					clear_bit(BR_FDB_LOCKED, &fdb->flags);
> +			if (unlikely(source != READ_ONCE(fdb->dst))) {
> +				if (unlikely(test_bit(BR_FDB_STICKY, &fdb->flags))) {
> +					br_fdb_notify_roaming(br, source, fdb);
> +				} else {
> +					br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
> +					WRITE_ONCE(fdb->dst, source);
> +					fdb_modified = true;
> +					/* Take over HW learned entry */
> +					if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
> +							      &fdb->flags)))
> +						clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
> +							  &fdb->flags);
> +					/* Clear locked flag when roaming to an
> +					 * unlocked port.
> +					 */
> +					if (unlikely(test_bit(BR_FDB_LOCKED, &fdb->flags)))
> +						clear_bit(BR_FDB_LOCKED, &fdb->flags);
> +				}
>  			}
>  
>  			if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
> @@ -1045,6 +1065,7 @@ static bool fdb_handle_notify(struct net_bridge_fdb_entry *fdb, u8 notify)
>  		   test_and_clear_bit(BR_FDB_NOTIFY, &fdb->flags)) {
>  		/* disabled activity tracking, clear notify state */
>  		clear_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags);
> +		clear_bit(BR_FDB_NOTIFY_ROAMING, &fdb->flags);
>  		modified = true;
>  	}
>  
> @@ -1457,10 +1478,13 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
>  
>  		fdb->updated = jiffies;
>  
> -		if (READ_ONCE(fdb->dst) != p &&
> -		    !test_bit(BR_FDB_STICK, &fdb->flags)) {
> -			WRITE_ONCE(fdb->dst, p);
> -			modified = true;
> +		if (READ_ONCE(fdb->dst) != p) {
> +			if (test_bit(BR_FDB_STICKY, &fdb->flags)) {
> +				br_fdb_notify_roaming(br, p, fdb);
> +			} else {
> +				WRITE_ONCE(fdb->dst, p);
> +				modified = true;
> +			}
>  		}
>  
>  		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index ceaa5a89b947..512ffab16f5d 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -120,8 +120,14 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  				br_fdb_update(br, p, eth_hdr(skb)->h_source,
>  					      vid, BIT(BR_FDB_LOCKED));
>  			goto drop;
> -		} else if (READ_ONCE(fdb_src->dst) != p ||
> -			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
> +		} else if (READ_ONCE(fdb_src->dst) != p) {
> +			/* FDB is trying to roam. Notify userspace and drop
> +			 * the packet
> +			 */
> +			if (test_bit(BR_FDB_STICKY, &fdb_src->flags))
> +				br_fdb_notify_roaming(br, p, fdb_src);
> +			goto drop;
> +		} else if (test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
>  			/* FDB mismatch. Drop the packet without roaming. */
>  			goto drop;
>  		} else if (test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 041f6e571a20..18d3cb5fec0e 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -277,6 +277,7 @@ enum {
>  	BR_FDB_NOTIFY_INACTIVE,
>  	BR_FDB_LOCKED,
>  	BR_FDB_DYNAMIC_LEARNED,
> +	BR_FDB_NOTIFY_ROAMING,
>  };
>  
>  struct net_bridge_fdb_key {
> @@ -874,6 +875,8 @@ int br_fdb_external_learn_del(struct net_bridge *br, struct net_bridge_port *p,
>  			      bool swdev_notify);
>  void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p,
>  			  const unsigned char *addr, u16 vid, bool offloaded);
> +void br_fdb_notify_roaming(struct net_bridge *br, struct net_bridge_port *p,
> +			   struct net_bridge_fdb_entry *fdb);
>  
>  /* br_forward.c */
>  enum br_pkt_type {

