Return-Path: <netdev+bounces-286271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEEtIW1YAGpEGgEAu9opvQ
	(envelope-from <netdev+bounces-286271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 12:05:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C84FC50381A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 12:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF93F300C006
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 10:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E3F3563C7;
	Sun, 10 May 2026 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ZvFpLqTE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1336221CFE0
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778407529; cv=none; b=aijoXwI23d9N6UG40c4NASatGn7xxYgh0BZUW61xnq9blmtfyun/FJFuyrXE/EtKQTV4MnkgSm0FRRhINRCAyjeOBj9bwbZ/RHcF6BJt/QOd9/bAmRzvefRT3TWoFcKu8fKpy/D2hqOrtQWsqSODz+EFzleocU7vfMV3ZADZ2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778407529; c=relaxed/simple;
	bh=jl9mMb2xNoQTkvMYCnG85fJgeQuVdezGK14MCgT4Wg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCSEVuOQyLXgbDbBt+HcXk8PxdlOlv6FKP2t3jluQ3cTbq3gveRxHs9j4xcXUHkReQd8l3V36dS/f4LKnaurjhmSrdE0Wt7+fvsB97Ljngcctei++Ztl8gbV9ryA3b32hEJo+bD/NlprtfdOUVg5AvMahqZOUP9udM0wOG9lqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZvFpLqTE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso29935635e9.3
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 03:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1778407526; x=1779012326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fjf6lHgwzOVnsX45ANVQd7FGC8MgEKFi4DF4O0Gwyz0=;
        b=ZvFpLqTEK9KAR9sLSusM3i9KX1C70Upuaw1yANKJyJ94AnJJ3jtco1z/hrAVuM7bD1
         Kgb5oqfZ7DG4SMYiFCTWyfL8uQyA9emEGtE7wrXjbmXs2fkU3/hXJ9Xt73rWl/MMNgES
         pezAOquxLa15Tlv58ueQwFS6M1OlWHUf95CfYrAIvk07TmZzyvdrDbqoqJIUKANICoPI
         h2ya8OqUuLAjwqX6OzHPDGzAJUx740OtP1vKtBfRx2uTNxIhRhrhtCIt8qIctlGELSOr
         QFTbR+NJRFtpwRXOX2q2OrKeAk0uGcI6atpaymjpCa4Vi1wUo+LKNcYjFh/HE4RMn3LU
         i1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778407526; x=1779012326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fjf6lHgwzOVnsX45ANVQd7FGC8MgEKFi4DF4O0Gwyz0=;
        b=cHfdu6UnBebCFO6xtzUSb1PP0KNp0/JXileYGaQeRkBUtts9tnYc8EkIgUHKxyh0ia
         plw5T7cDk0VTvKLnHwn7HiNPas/c3bEyd689RUAHnhFvatgqF4uvsXORS8wY/u5qRnQE
         OAQO3S9iADhRHfeMtRmbmGk78lAeB6ob4N1dZ/OW4zOPIFCivRkAlASkW5gOaYs0ShB8
         6KbR47UIpVcR7Dw/81ZzALJQATvzT9yE4VKCMWkwAN2+aaem8folR6MpU/iNzynCGcHQ
         cBhK9P5FxHSFApwnu9ffRNCms92MpNoUCIM51SGKHQ6LvjhKoSZDZ901oK++Q45eWFcw
         p0vw==
X-Forwarded-Encrypted: i=1; AFNElJ/G9Gt8bzypx63nIs5T/EN9pTemuPPGgIr1GrNujszHIwiAWR5lbwsJ3y+JiXo65d9zp3jBvhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdj4XvMDbk12jIp2YT4EAEkQ3bm01/Zpp0o8dXtkrZPypxSE6
	MIxoYTac4mtuB1O9HZ9eQ2S4C8JGdBGi9yrKnag4DxGBbRlkVubzO2P5wEjCHDUfAJg=
X-Gm-Gg: Acq92OFRUPwrRoT4DZ9f4qEi5gSMBBGdIkasS3sSsZavCt04HjwPZ5qWyUWMuggrjaq
	6+qdlHU3jSCGcv1Pzx92O0itPk2gSDbrgXlJbWecTK1VI3MszeKmsnDQJt1OPBFAFMVwOSmJI7x
	J5PelxQdv1fEXCkccQD4EX+aHCmucv1Sn4aRyvrIA3rdqtF6Yoc1maPwDOE5ljQKn4mGRV3q92E
	cQwBI37Ex+obIGJR9iA2mNv/CD/vY1fljrOiHm6g8c9PoFP4ujePrvyII/x5RnO35sAnjnTeVXE
	Q0KbTyg5swu/OIDXOT5osiwfOvGsmmvR4KPLeUj2hyMREBnVZotzh4b6iKVBtnHU41OYPcM/05V
	eAPVJvf/2QRZt/nHsiFsBpO8wl5zd0WwJ/EEiqdBOjBbdfn7vlXyzYjKOFT9ZliPmn6NMBItiaT
	Lct7Fkfhu7i/8oqzH9YrXpILbx+MF5rPRgV/ox76O77OGHIcGmmGT5xg==
X-Received: by 2002:a05:600c:3055:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-48e51f4e492mr198370365e9.27.1778407526198;
        Sun, 10 May 2026 03:05:26 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548bb51d40sm17103719f8f.0.2026.05.10.03.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 03:05:25 -0700 (PDT)
Message-ID: <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org>
Date: Sun, 10 May 2026 13:05:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
To: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org
Cc: idosch@nvidia.com, horatiu.vultur@microchip.com, kuba@kernel.org,
 henrik.bjoernlund@microchip.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, ronbogo@outlook.com,
 zylzyl2333@gmail.com
References: <cover.1778378864.git.zylzyl2333@gmail.com>
 <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C84FC50381A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286271-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,microchip.com,kernel.org,gmail.com,lzu.edu.cn,outlook.com];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blackwall.org:mid,blackwall.org:dkim,lzu.edu.cn:email]
X-Rspamd-Action: no action

On 10/05/2026 12:15, Ren Wei wrote:
> From: Yilin Zhu <zylzyl2333@gmail.com>
> 
> CFM registers a bridge frame handler when the first MEP is created and
> unregisters it when the last MEP is deleted. The registered object also
> contains the hlist_node used by the bridge-local frame_type_list.
> 
> The CFM frame type is currently global, so enabling CFM on multiple
> bridges links the same hlist_node into multiple bridge-local lists. A
> later unregister on one bridge can then operate on list state belonging
> to another bridge.
> 
> Move the CFM frame type into struct net_bridge and register/unregister
> the bridge-owned object. This keeps frame handler list membership local
> to the bridge while preserving the existing first-MEP/last-MEP lifetime.
> 
> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>   net/bridge/br_cfm.c     | 14 ++++++--------
>   net/bridge/br_private.h | 18 +++++++++++-------
>   2 files changed, 17 insertions(+), 15 deletions(-)
> 

I think MRP suffers from the same bug, but I also think we can contain the
fix within the packet type structure instead of making the already huge
struct net_bridge even bigger. Also, linking a struct within net_bridge
to a list within the same net_bridge looks weird.

IMO br_add_frame should take a type & a frame_handler, allocate a br_frame_type
dynamically and link it, then br_del_frame should take a type instead of a ptr
and remove that frame type and free it with kfree_rcu. That would require
br_add_frame return value to be checked in the respective cfm/mrp functions.
Warnings for already existing types on add or missing types on del should be
added.

Would you please take care of MRP as well?

Cheers,
  Nik

> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index 118c7ea48c35..547c7415c0ea 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c
> @@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
>   	return 1;
>   }
>   
> -static struct br_frame_type cfm_frame_type __read_mostly = {
> -	.type = cpu_to_be16(ETH_P_CFM),
> -	.frame_handler = br_cfm_frame_rx,
> -};
> -
>   int br_cfm_mep_create(struct net_bridge *br,
>   		      const u32 instance,
>   		      struct br_cfm_mep_create *const create,
> @@ -558,8 +553,11 @@ int br_cfm_mep_create(struct net_bridge *br,
>   	INIT_HLIST_HEAD(&mep->peer_mep_list);
>   	INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
>   
> -	if (hlist_empty(&br->mep_list))
> -		br_add_frame(br, &cfm_frame_type);
> +	if (hlist_empty(&br->mep_list)) {
> +		br->cfm_frame_type.type = cpu_to_be16(ETH_P_CFM);
> +		br->cfm_frame_type.frame_handler = br_cfm_frame_rx;
> +		br_add_frame(br, &br->cfm_frame_type);
> +	}
>   
>   	hlist_add_tail_rcu(&mep->head, &br->mep_list);
>   
> @@ -588,7 +586,7 @@ static void mep_delete_implementation(struct net_bridge *br,
>   	kfree_rcu(mep, rcu);
>   
>   	if (hlist_empty(&br->mep_list))
> -		br_del_frame(br, &cfm_frame_type);
> +		br_del_frame(br, &br->cfm_frame_type);
>   }
>   
>   int br_cfm_mep_delete(struct net_bridge *br,
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index bed1b1d9b282..a3ed9ee826f5 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -61,6 +61,9 @@ typedef struct bridge_id bridge_id;
>   typedef struct mac_addr mac_addr;
>   typedef __u16 port_id;
>   
> +struct net_bridge_port;
> +struct sk_buff;
> +
>   struct bridge_id {
>   	unsigned char	prio[2];
>   	unsigned char	addr[ETH_ALEN];
> @@ -70,6 +73,13 @@ struct mac_addr {
>   	unsigned char	addr[ETH_ALEN];
>   };
>   
> +struct br_frame_type {
> +	__be16			type;
> +	int			(*frame_handler)(struct net_bridge_port *port,
> +						 struct sk_buff *skb);
> +	struct hlist_node	list;
> +};
> +
>   #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>   /* our own querier */
>   struct bridge_mcast_own_query {
> @@ -585,6 +595,7 @@ struct net_bridge {
>   	struct hlist_head		mrp_list;
>   #endif
>   #if IS_ENABLED(CONFIG_BRIDGE_CFM)
> +	struct br_frame_type	cfm_frame_type;
>   	struct hlist_head		mep_list;
>   #endif
>   };
> @@ -926,13 +937,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct net_device *backup_dev);
>   int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
>   rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
>   
> -struct br_frame_type {
> -	__be16			type;
> -	int			(*frame_handler)(struct net_bridge_port *port,
> -						 struct sk_buff *skb);
> -	struct hlist_node	list;
> -};
> -
>   void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
>   void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
>   


