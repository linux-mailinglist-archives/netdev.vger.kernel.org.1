Return-Path: <netdev+bounces-260496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL9pFhCWnWnKQgQAu9opvQ
	(envelope-from <netdev+bounces-260496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:14:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A5186C96
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9772B3025900
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFAF38BF9D;
	Tue, 24 Feb 2026 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmLN5e/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030127EFEE
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935175; cv=none; b=UuG1M54AoOXjnMRfHGlMXWO5iiWJOjRwxBYh5EQW+uXr6hwTlzRz6A3d3EmgpjU3d2VIA+TniWh8q/LrxAlzVzge+l1HI2wVOuJoR7C075sMqpAaIrXMTxbNA+bgRLQaIo7Qn6fSSWFv6C/lXx1+jC3BQwkZt3I8ctbMIA2B08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935175; c=relaxed/simple;
	bh=qVcOp5MnvlONbLG06msjRU6TJXzRsaX/t8tfbP70eys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WltJpZ9IdmVaORNSFkTts4kyy888fXoweZaWCOEgCrKtYt69kCepAIjpargDjr+MPVU05k2Kv4OYeLNGVqZFUGGmQoLygViRS6MeVRzv+vImyC8MWKpiS8VZZGFvUJN6oNHf+wgvVhoFjUmdNIrs6ErJdFcOTBwXjOnZN5ef7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmLN5e/l; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b885e8c6727so952966766b.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771935173; x=1772539973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZ4fv5w72iR4alZnfS3RK7xFl8sWnyZEZWYM2yXruBI=;
        b=XmLN5e/lEcQ09/Kk0A987tVGFLAIQVbpWBmyZjc2eyA4CgSEjZCU6bBP6Z2PeJ8sJm
         HWZtWwlLH+u38ruHlM9fkBZrlYyV2IWOBdgqhvr/nK9QrByKwo/zR0DkrwtwS756WiWl
         bY0CKTiJMuR18WOMAuOuea99GFW8+Bd7VBitrpZdNMFXychP4v/4zoZVDX6JH86da4aE
         tjsAGrc07nb4rsNt8SGaE3c+ZYiA94q18omEjiMO7MH7187wLRKRItbyPYbqFsFXW2T0
         AHoWiuMgG/23O/ltzGAh/BhCc2c0mDG2r5PnVRi41E2Am1YNUT+iv/hoLzAFgPZyRG7W
         99GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935173; x=1772539973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZ4fv5w72iR4alZnfS3RK7xFl8sWnyZEZWYM2yXruBI=;
        b=Gc9+cnsUN6NmBoFLR1C/0Zmuw4DHWDWgE21ktXWQYb4yq2rHbIIkB+WNIqQRa3iJd4
         JM1Jsj5f4Vxotgi7to58knzOY7gUJyCNLuCn894IIwrHFHaLdmiE4LIfajkHISp4OY72
         YnbzVRVwRK+QrwZ4NaGhEyCXTv6+Ccfgn/Qo3Hg9oBZHi3L1TbqbN7WlePjMXEV9l3Lo
         mZLRilVjW8pPCKSZOTtbRLgH5QUxqDaUG+tURr4sV2JTTKfQXwzNdfZeiYPIlb3LFN0g
         iXcOY1iVXkNm9WK2Sw1iaqa1XvBUHxz+L/kB4Ey+P8Dh4N2e8vUhEav0RXl571K+reGr
         E/qg==
X-Forwarded-Encrypted: i=1; AJvYcCV+P6n6bqPLIWrwRXznhBqNv0iEjmhToUujcZ/4ydbUgqAzNcC6OHDnY5kprQhAFI0pvRKYfoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUr+OCxMtTj8ZDGCJizglJ7VNFsZxRJ11YPnRtSQIKYtxQWj68
	74Hs0Ms+sWazANoq2rz8bsmXaVGy88sZAQdnqwORtkn40aL8+mSZ4JES
X-Gm-Gg: ATEYQzwCYbx+RPZs+ejbVRnVQazAyk1pPN5d26pwSe3A5kiVfl76jCK4Q8MLaV4439N
	9bMZ+fjJ0eQGI8D01PqDua2J6lT8jXAucTl/vQpDn5x9r42bQDZ+Lq7NBIh3JEQ95DjXOSPMJGJ
	4xODfgzGiRW87hCb6FK09dyZKMyKyVdDh/7CED41UFgIDGmRyJdGVYepdrZrvq+7VmmIX4AnBmR
	ZNh6ZBJRykqkQ6K/jf7k0UuiCCfshcNCPIytQN2iULXiIwSJR7HwPlwmj7caGz0vrzlJ78mEl8x
	Vucsiaiu2kiGk93wKNZQskUewVWhsux0p4RCf1HzVM4juN+SSDSIWVto8jrRxv1vefAvNI68gO9
	fElOIgg4ed2K+TKFE5KGwxwppQpxpCk2fKfkg9VkYnITNoRG65E41fblmnmzDb2cGqbCH7Bh4Yw
	vgYEnK8WCNaa0N7crv2zyOxxf3TDmx95GkKOHrGnruVEjbq0OxLwTcKk09wg==
X-Received: by 2002:adf:e3c3:0:b0:439:8bb9:db03 with SMTP id ffacd0b85a97d-4398bb9dedemr632589f8f.3.1771928510821;
        Tue, 24 Feb 2026 02:21:50 -0800 (PST)
Received: from [10.221.199.249] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c09897sm26186806f8f.17.2026.02.24.02.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 02:21:49 -0800 (PST)
Message-ID: <9ed3ade5-717d-4f03-ac13-40614a0f093c@gmail.com>
Date: Tue, 24 Feb 2026 12:21:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethtool: add COALESCE_RX_CQE_FRAMES/NSECS
 parameters
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
 Gal Pressman <gal@nvidia.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: haiyangz@microsoft.com, paulros@microsoft.com
References: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260496-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.microsoft.com,vger.kernel.org,lunn.ch,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,bootlin.com,nvidia.com,pengutronix.de,linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB2A5186C96
X-Rspamd-Action: no action



On 22/02/2026 23:23, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Add two parameters for drivers supporting Rx CQE Coalescing.
> 
> ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
> Maximum number of frames that can be coalesced into a CQE.
> 
> ETHTOOL_A_COALESCE_RX_CQE_NSECS:
> Time out value in nanoseconds after the first packet arrival in a
> coalesced CQE to be sent.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>   Documentation/netlink/specs/ethtool.yaml       |  8 ++++++++
>   Documentation/networking/ethtool-netlink.rst   | 10 ++++++++++
>   include/linux/ethtool.h                        |  6 +++++-
>   include/uapi/linux/ethtool_netlink_generated.h |  2 ++
>   net/ethtool/coalesce.c                         | 14 +++++++++++++-
>   5 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 0a2d2343f79a..951d98f6bb12 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -861,6 +861,12 @@ attribute-sets:
>           name: tx-profile
>           type: nest
>           nested-attributes: profile
> +      -
> +        name: rx-cqe-frames
> +        type: u32
> +      -
> +        name: rx-cqe-nsecs
> +        type: u32
>   
>     -
>       name: pause-stat
> @@ -2244,6 +2250,8 @@ operations:
>               - tx-aggr-time-usecs
>               - rx-profile
>               - tx-profile
> +            - rx-cqe-frames
> +            - rx-cqe-nsecs
>         dump: *coalesce-get-op
>       -
>         name: coalesce-set
> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index af56c304cef4..a3e78b69fd07 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -1072,6 +1072,8 @@ Kernel response contents:
>     ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
>     ``ETHTOOL_A_COALESCE_RX_PROFILE``            nested  profile of DIM, Rx
>     ``ETHTOOL_A_COALESCE_TX_PROFILE``            nested  profile of DIM, Tx
> +  ``ETHTOOL_A_COALESCE_RX_CQE_FRAMES``         u32     max packets, Rx CQE
> +  ``ETHTOOL_A_COALESCE_RX_CQE_NSECS``          u32     delay (ns), Rx CQE
>     ===========================================  ======  =======================
>   
>   Attributes are only included in reply if their value is not zero or the
> @@ -1105,6 +1107,12 @@ well with frequent small-sized URBs transmissions.
>   to DIM parameters, see `Generic Network Dynamic Interrupt Moderation (Net DIM)
>   <https://www.kernel.org/doc/Documentation/networking/net_dim.rst>`_.
>   
> +Rx CQE coalescing allows multiple received packets to be coalesced into a single
> +Completion Queue Entry (CQE). ``ETHTOOL_A_COALESCE_RX_CQE_FRAMES`` describes the
> +maximum number of frames that can be coalesced into a CQE.
> +``ETHTOOL_A_COALESCE_RX_CQE_NSECS`` describes max time in nanoseconds after the
> +first packet arrival in a coalesced CQE to be sent.
> +

I am trying to understand how generic this feature/API is.
Can you please elaborate on the feature you want to configure here?

A single CQE to describe several packets?
What is the price? What per-packet information/hw offloads do you lose 
in the process?

For comparison, in mlx5 we have RX CQE compression, which can be applied 
on multiple near-identical completions that share/match several fields. 
Still, there is a per-packet mini-cqe with distinctive per-packet fields 
like csum.

>   COALESCE_SET
>   ============
>   
> @@ -1143,6 +1151,8 @@ Request contents:
>     ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
>     ``ETHTOOL_A_COALESCE_RX_PROFILE``            nested  profile of DIM, Rx
>     ``ETHTOOL_A_COALESCE_TX_PROFILE``            nested  profile of DIM, Tx
> +  ``ETHTOOL_A_COALESCE_RX_CQE_FRAMES``         u32     max packets, Rx CQE
> +  ``ETHTOOL_A_COALESCE_RX_CQE_NSECS``          u32     delay (ns), Rx CQE
>     ===========================================  ======  =======================
>   
>   Request is rejected if it attributes declared as unsupported by driver (i.e.
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 798abec67a1b..25ccd2d5d4dc 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -332,6 +332,8 @@ struct kernel_ethtool_coalesce {
>   	u32 tx_aggr_max_bytes;
>   	u32 tx_aggr_max_frames;
>   	u32 tx_aggr_time_usecs;
> +	u32 rx_cqe_frames;
> +	u32 rx_cqe_nsecs;
>   };
>   
>   /**
> @@ -380,7 +382,9 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
>   #define ETHTOOL_COALESCE_TX_AGGR_TIME_USECS	BIT(26)
>   #define ETHTOOL_COALESCE_RX_PROFILE		BIT(27)
>   #define ETHTOOL_COALESCE_TX_PROFILE		BIT(28)
> -#define ETHTOOL_COALESCE_ALL_PARAMS		GENMASK(28, 0)
> +#define ETHTOOL_COALESCE_RX_CQE_FRAMES		BIT(29)
> +#define ETHTOOL_COALESCE_RX_CQE_NSECS		BIT(30)
> +#define ETHTOOL_COALESCE_ALL_PARAMS		GENMASK(30, 0)
>   
>   #define ETHTOOL_COALESCE_USECS						\
>   	(ETHTOOL_COALESCE_RX_USECS | ETHTOOL_COALESCE_TX_USECS)
> diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
> index 556a0c834df5..efc6e4ade77b 100644
> --- a/include/uapi/linux/ethtool_netlink_generated.h
> +++ b/include/uapi/linux/ethtool_netlink_generated.h
> @@ -371,6 +371,8 @@ enum {
>   	ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,
>   	ETHTOOL_A_COALESCE_RX_PROFILE,
>   	ETHTOOL_A_COALESCE_TX_PROFILE,
> +	ETHTOOL_A_COALESCE_RX_CQE_FRAMES,
> +	ETHTOOL_A_COALESCE_RX_CQE_NSECS,
>   
>   	__ETHTOOL_A_COALESCE_CNT,
>   	ETHTOOL_A_COALESCE_MAX = (__ETHTOOL_A_COALESCE_CNT - 1)
> diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
> index 3e18ca1ccc5e..349bb02c517a 100644
> --- a/net/ethtool/coalesce.c
> +++ b/net/ethtool/coalesce.c
> @@ -118,6 +118,8 @@ static int coalesce_reply_size(const struct ethnl_req_info *req_base,
>   	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_BYTES */
>   	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_FRAMES */
>   	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_TIME_USECS */
> +	       nla_total_size(sizeof(u32)) +	/* _RX_CQE_FRAMES */
> +	       nla_total_size(sizeof(u32)) +	/* _RX_CQE_NSECS */
>   	       total_modersz * 2;		/* _{R,T}X_PROFILE */
>   }
>   
> @@ -269,7 +271,11 @@ static int coalesce_fill_reply(struct sk_buff *skb,
>   	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,
>   			     kcoal->tx_aggr_max_frames, supported) ||
>   	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,
> -			     kcoal->tx_aggr_time_usecs, supported))
> +			     kcoal->tx_aggr_time_usecs, supported) ||
> +	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_CQE_FRAMES,
> +			     kcoal->rx_cqe_frames, supported) ||
> +	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_CQE_NSECS,
> +			     kcoal->rx_cqe_nsecs, supported))
>   		return -EMSGSIZE;
>   
>   	if (!req_base->dev || !req_base->dev->irq_moder)
> @@ -338,6 +344,8 @@ const struct nla_policy ethnl_coalesce_set_policy[] = {
>   	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES] = { .type = NLA_U32 },
>   	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES] = { .type = NLA_U32 },
>   	[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS] = { .type = NLA_U32 },
> +	[ETHTOOL_A_COALESCE_RX_CQE_FRAMES] = { .type = NLA_U32 },
> +	[ETHTOOL_A_COALESCE_RX_CQE_NSECS] = { .type = NLA_U32 },
>   	[ETHTOOL_A_COALESCE_RX_PROFILE] =
>   		NLA_POLICY_NESTED(coalesce_profile_policy),
>   	[ETHTOOL_A_COALESCE_TX_PROFILE] =
> @@ -570,6 +578,10 @@ __ethnl_set_coalesce(struct ethnl_req_info *req_info, struct genl_info *info,
>   			 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES], &mod);
>   	ethnl_update_u32(&kernel_coalesce.tx_aggr_time_usecs,
>   			 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS], &mod);
> +	ethnl_update_u32(&kernel_coalesce.rx_cqe_frames,
> +			 tb[ETHTOOL_A_COALESCE_RX_CQE_FRAMES], &mod);
> +	ethnl_update_u32(&kernel_coalesce.rx_cqe_nsecs,
> +			 tb[ETHTOOL_A_COALESCE_RX_CQE_NSECS], &mod);
>   
>   	if (dev->irq_moder && dev->irq_moder->profile_flags & DIM_PROFILE_RX) {
>   		ret = ethnl_update_profile(dev, &dev->irq_moder->rx_profile,


