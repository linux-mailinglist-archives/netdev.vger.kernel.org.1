Return-Path: <netdev+bounces-252400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHzVM3E8cmnTfAAAu9opvQ
	(envelope-from <netdev+bounces-252400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:04:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9652E68507
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 278533012255
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9575E34DCC7;
	Thu, 22 Jan 2026 15:00:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70FA34B425
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094058; cv=none; b=PjA89NOGNGbkDR3c43cZJnKh1Cfx/BSmNI5P4TzTjU1QQ1AbTWjTu5J5mLlgaV2IwR+tua48ivhEB6HpETykqCSdiUL5qIzitsiaFgnmVDB2t6cLg/btvwK6lPmqMqTzcZD9ARxGeBSb9dxaIjH9roHzSJ1aMLiCwf9jDs8lXmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094058; c=relaxed/simple;
	bh=xq17aT3PVlvjNaDC+9oBVk8kHTUqk3C34kOwBDxMqTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owEMvnVB3607S4+jgFN9CsaxvpERXqJ7Lsj551XiNC24RL7YcPzfw4IJaO0TpaxTlJ05UMzgvrdVkk4a13BEaD+PcgUjINhEyTmDHx3zJQFZoF9bKinUZ6sKDiQxZnIioNVD6yurvWPsxhOIm7nujYyW4ealOU8emDpJ08cg2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8B5144C44303AE;
	Thu, 22 Jan 2026 16:00:02 +0100 (CET)
Message-ID: <ab7b6df0-53d6-4304-8e65-5f1e243d9615@molgen.mpg.de>
Date: Thu, 22 Jan 2026 16:00:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next] igb: set skb hash type from
 RSS_TYPE
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kohei.enju@gmail.com, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260122134809.7765-1-kohei@enjuk.jp>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260122134809.7765-1-kohei@enjuk.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252400-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpg.de:email,molgen.mpg.de:mid,intel.com:email,toeplitz.py:url]
X-Rspamd-Queue-Id: 9652E68507
X-Rspamd-Action: no action

Dear Kohei,


Thank you for your patch.

Am 22.01.26 um 14:47 schrieb Kohei Enju:
> igb always marks the RX hash as L3 regardless of RSS_TYPE in the
> advanced descriptor, which may indicate L4 (TCP/UDP) hash. This can
> trigger unnecessary SW hash recalculation and breaks toeplitz selftests.
> 
> Use RSS_TYPE from pkt_info to set the correct PKT_HASH_TYPE_*
> 
> Tested by toeplitz.py with the igb RSS key get/set patches applied as
> they are required for toeplitz.py (see Link below).
>   # ethtool -N $DEV rx-flow-hash udp4 sdfn
>   # ethtool -N $DEV rx-flow-hash udp6 sdfn
>   # python toeplitz.py | grep -E "^# Totals"
> 
> Without patch:
>   # Totals: pass:0 fail:12 xfail:0 xpass:0 skip:0 error:0
> 
> With patch:
>   # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Link: https://lore.kernel.org/intel-wired-lan/20260119084511.95287-5-takkozu@amazon.com/
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> Changelog:
>    v2:
>      - Fix max-line-length by removing unnecessary comment
>    v1: https://lore.kernel.org/intel-wired-lan/20260119175922.199950-1-kohei@enjuk.jp/
> ---
>   drivers/net/ethernet/intel/igb/e1000_82575.h | 21 ++++++++++++++++++++
>   drivers/net/ethernet/intel/igb/igb_main.c    | 18 +++++++++++++----
>   2 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h b/drivers/net/ethernet/intel/igb/e1000_82575.h
> index 63ec253ac788..9e696d55e512 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_82575.h
> +++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
> @@ -87,6 +87,27 @@ union e1000_adv_rx_desc {
>   	} wb;  /* writeback */
>   };
>   
> +#define E1000_RSS_TYPE_NO_HASH		 0
> +#define E1000_RSS_TYPE_HASH_TCP_IPV4	 1
> +#define E1000_RSS_TYPE_HASH_IPV4	 2
> +#define E1000_RSS_TYPE_HASH_TCP_IPV6	 3
> +#define E1000_RSS_TYPE_HASH_IPV6_EX	 4
> +#define E1000_RSS_TYPE_HASH_IPV6	 5
> +#define E1000_RSS_TYPE_HASH_TCP_IPV6_EX	 6
> +#define E1000_RSS_TYPE_HASH_UDP_IPV4	 7
> +#define E1000_RSS_TYPE_HASH_UDP_IPV6	 8
> +#define E1000_RSS_TYPE_HASH_UDP_IPV6_EX	 9
> +
> +#define E1000_RSS_TYPE_MASK		GENMASK(3, 0)
> +
> +#define E1000_RSS_L4_TYPES_MASK	\
> +	(BIT(E1000_RSS_TYPE_HASH_TCP_IPV4)	| \
> +	 BIT(E1000_RSS_TYPE_HASH_TCP_IPV6)	| \
> +	 BIT(E1000_RSS_TYPE_HASH_TCP_IPV6_EX)	| \
> +	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV4)	| \
> +	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV6)	| \
> +	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV6_EX))
> +
>   #define E1000_RXDADV_HDRBUFLEN_MASK      0x7FE0
>   #define E1000_RXDADV_HDRBUFLEN_SHIFT     5
>   #define E1000_RXDADV_STAT_TS             0x10000 /* Pkt was time stamped */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 8dab133296ca..ef0cbf532716 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -8824,10 +8824,20 @@ static inline void igb_rx_hash(struct igb_ring *ring,
>   			       union e1000_adv_rx_desc *rx_desc,
>   			       struct sk_buff *skb)
>   {
> -	if (ring->netdev->features & NETIF_F_RXHASH)
> -		skb_set_hash(skb,
> -			     le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
> -			     PKT_HASH_TYPE_L3);
> +	u16 rss_type;
> +
> +	if (!(ring->netdev->features & NETIF_F_RXHASH))
> +		return;
> +
> +	rss_type = le16_to_cpu(rx_desc->wb.lower.lo_dword.pkt_info) &
> +		   E1000_RSS_TYPE_MASK;
> +
> +	if (!rss_type)
> +		return;
> +
> +	skb_set_hash(skb, le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
> +		     (E1000_RSS_L4_TYPES_MASK & BIT(rss_type)) ?
> +		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
>   }
>   
>   /**

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

