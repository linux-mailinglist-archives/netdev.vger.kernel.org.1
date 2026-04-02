Return-Path: <netdev+bounces-274435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLKPJOoxzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:07:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF8386791
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DAEA300E25E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F46129ACC5;
	Thu,  2 Apr 2026 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdAsV0w9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BC22E36F8
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120587; cv=none; b=QSQ0itVctGvAHIIoGdc4O7IR+QuvZBsUgM089MnMp1GhZl03r/EObIYLL3zuKxIaWBB4n49gOLIBooaaP3UWlfkB4htjachvfj3zq94fDYniWboafxv9TQwUB2ZOtig3ytiAJciPh8Gvys9/hIkTvN6yPLZTl93Dfig2mFxOaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120587; c=relaxed/simple;
	bh=2iphfIXQBrylYPU/MtPX74m7dIxtE8/vlthqJvLkxz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFMpXxEJBVNpejDmmKR9csRY/K4/ObgwCiU0dCakWh5atdgHuhMq0cu8rn8Cos65XVmZ5tj9eO16hEcM+idgWXrpg9UnlUvAv2LG7iNic7iUutdbOBaxMBPR4PUJYvO6+fyFiuXMmEya5OP4sqBVtWh97DzfefNLiCeBw4YyYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdAsV0w9; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so1582010eec.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775120585; x=1775725385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Sn2tOmBCbqkq6l93TT3B9Y0HXK0yulaqsGfrEa86WU=;
        b=XdAsV0w9NjTNniOXWU5+k2JkYjN62zUSZCgCSovt8O/ARgfLyv9nzXwg+gqCBq100Y
         RoWKhpu9OG2ZZSNPGGKH7Qyc/yI/OR5dUfZkySlT2lfRH2TKRDdHqPpFUPImSO08wKIW
         pF3TLoeXTHP+Y0dQYPRL5xBZBgthEFgvGQ++VzjjjwBqhNV3GcZ6Jftk2kKeclm7QXea
         yQjGKxbTQ1lvq+t3I5j9Mkm4CGFFXpW4KJqYrPLHrjiBdGWHo+Lm9CxWHUjtyyYvwtj+
         6uSr637soiu4Lko0qCSH8y+nCymFN2lR9WLTcqwfjxvsCmXmnTHOaaE2mw6KBXRC3Su8
         Ct2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120585; x=1775725385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Sn2tOmBCbqkq6l93TT3B9Y0HXK0yulaqsGfrEa86WU=;
        b=MydRgi4CrgllFXqJuRLJrHBwMypE8qaoK7+oqlKJCTBuJ2QAt00R7pnBvLuJ13/YoZ
         qUbecMrw1OjZ5qnlj4mKgB+fhKsqkHJZgy9RSXNvOOmY9OO6q/t0KYzYVlHOrhfV7II0
         u7Lu9xyjtEzr3xfDqCaYk0yhHOXm+vL5JwizZ0LQrJ4291veBnsifF5xl4p8PDHA1UyC
         xjcxDQPq07pV0Et69YW9bllcPvKK+GWeKhuHuQ8sBdEdx1OJwZj+Q612/IPpwBQ37HJL
         9GnMfvNMEKnRMUXBPkYwX/l4Ps9wkV+/9h0xiVu40kZwLtCfv1LuBpOiDPi40AR/Ev6W
         c0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVWHlGFrCgLG+s4HZrnHYWYh8MPGtsMmZr4+hhQwaxRQRFja86s8T0452eF5+3DpvHK/lcAyRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww9WtWqAx0wBBC++oMMt9moot98jt3RStr97xbHXI3P3NzVOa+
	/2sWIR5QrxBDDpAJpFfz/utbdlVo0LC1YdmqESbDtYGbjxWalRF7wghL
X-Gm-Gg: ATEYQzyu7hsrj/XHKQRvFuJpGq0XZ03aF00wv63KEXu9FxaSGmDCJLMhXE4TdR2e1fP
	s3DHMG9mNcxtfhwOholUVRVkZ3pf0ugYl9xUbNpLuw8PkfTsye7K8gybn0msnNjkhFGinwjaXP1
	G94AuOMc/Dl1LaELTRuWt5NdX+25LwiQMyHs6GpK7aeA38Bz6JFJ4j1CB5mqv9PZMlBdZVe6DgW
	39c+Z3Z+Js3fwSdo6/gbXra7beOgXpUhBF51cRUpS+qszc6nCdSd4o5T9jAZpqY3IALrzu5ZAaP
	2IeYczlodlTZjgym6FMl1I4QpRPM25MfX5MLwy2t53SOSnaFJO/vqvgsDf3AGVBNGcZtutj7vPZ
	HHAQhlpZcu4R7YvFmsWDOgyO5fN3j6sq+qY7VAgmyBCrO3WD31StBNiydg9NASQqU0mGFaXmPTS
	Xsfd/k4pyoEK4EezJSP812B4+4ycvRlLHQO0HXTEJdLpj+txAxu8Ykr3d1rRfg
X-Received: by 2002:a05:7301:6787:b0:2c6:1557:998f with SMTP id 5a478bee46e88-2ca9037b04amr1373965eec.25.1775120584807;
        Thu, 02 Apr 2026 02:03:04 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21cf::147f? ([2620:10d:c090:400::5:9571])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca792f3f54sm1893458eec.7.2026.04.02.02.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:03:04 -0700 (PDT)
Message-ID: <0b0eb2e1-7aec-4913-8062-b3eff786a1ae@gmail.com>
Date: Thu, 2 Apr 2026 02:03:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 net-next 04/11] net/nebula-matrix: channel msg value
 and msg struct
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, jani.nikula@intel.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260401022318.28550-1-illusion.wang@nebula-matrix.com>
 <20260401022318.28550-5-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260401022318.28550-5-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org,intel.com];
	TAGGED_FROM(0.00)[bounces-274435-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DFBF8386791
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/26 7:23 PM, illusion.wang wrote:
> For compatibility, the msg id value is fixed, and each msg struct can
> only have fields added (not removed), new fields must be appended
> 
> Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
> ---
>   .../nbl/nbl_include/nbl_def_channel.h         | 249 ++++++++++++++++++
>   1 file changed, 249 insertions(+)
> 
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> index ff03a53b9f5d..99e1d8455e0e 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> @@ -8,6 +8,255 @@
>   
>   struct nbl_channel_mgt;
>   struct nbl_adapter;
> +enum nbl_chan_msg_type {
> +	NBL_CHAN_MSG_ACK,
> +	NBL_CHAN_MSG_ADD_MACVLAN,
> +	NBL_CHAN_MSG_DEL_MACVLAN,
> +	NBL_CHAN_MSG_ADD_MULTI_RULE,
> +	NBL_CHAN_MSG_DEL_MULTI_RULE,
> +	NBL_CHAN_MSG_SETUP_MULTI_GROUP,
> +	NBL_CHAN_MSG_REMOVE_MULTI_GROUP,
> +	NBL_CHAN_MSG_REGISTER_NET,
> +	NBL_CHAN_MSG_UNREGISTER_NET,
> +	NBL_CHAN_MSG_ALLOC_TXRX_QUEUES,
> +	NBL_CHAN_MSG_FREE_TXRX_QUEUES,
> +	NBL_CHAN_MSG_SETUP_QUEUE,
> +	NBL_CHAN_MSG_REMOVE_ALL_QUEUES,
> +	NBL_CHAN_MSG_CFG_DSCH,
> +	NBL_CHAN_MSG_SETUP_CQS,
> +	NBL_CHAN_MSG_REMOVE_CQS,
> +	NBL_CHAN_MSG_CFG_QDISC_MQPRIO,
> +	NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,
> +	NBL_CHAN_MSG_DESTROY_MSIX_MAP,
> +	NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ,
> +	NBL_CHAN_MSG_GET_GLOBAL_VECTOR,
> +	NBL_CHAN_MSG_GET_VSI_ID,
> +	NBL_CHAN_MSG_SET_PROSISC_MODE,
> +	NBL_CHAN_MSG_GET_FIRMWARE_VERSION,
> +	NBL_CHAN_MSG_GET_QUEUE_ERR_STATS,
> +	NBL_CHAN_MSG_GET_COALESCE,
> +	NBL_CHAN_MSG_SET_COALESCE,
> +	NBL_CHAN_MSG_SET_SPOOF_CHECK_ADDR,
> +	NBL_CHAN_MSG_SET_VF_SPOOF_CHECK,
> +	NBL_CHAN_MSG_GET_RXFH_INDIR_SIZE,
> +	NBL_CHAN_MSG_GET_RXFH_INDIR,
> +	NBL_CHAN_MSG_GET_RXFH_RSS_KEY,
> +	NBL_CHAN_MSG_GET_RXFH_RSS_ALG_SEL,
> +	NBL_CHAN_MSG_GET_HW_CAPS,
> +	NBL_CHAN_MSG_GET_HW_STATE,
> +	NBL_CHAN_MSG_REGISTER_RDMA,
> +	NBL_CHAN_MSG_UNREGISTER_RDMA,
> +	NBL_CHAN_MSG_GET_REAL_HW_ADDR,
> +	NBL_CHAN_MSG_GET_REAL_BDF,
> +	NBL_CHAN_MSG_GRC_PROCESS,
> +	NBL_CHAN_MSG_SET_SFP_STATE,
> +	NBL_CHAN_MSG_SET_ETH_LOOPBACK,
> +	NBL_CHAN_MSG_CHECK_ACTIVE_VF,
> +	NBL_CHAN_MSG_GET_PRODUCT_FLEX_CAP,
> +	NBL_CHAN_MSG_ALLOC_KTLS_TX_INDEX,
> +	NBL_CHAN_MSG_FREE_KTLS_TX_INDEX,
> +	NBL_CHAN_MSG_CFG_KTLS_TX_KEYMAT,
> +	NBL_CHAN_MSG_ALLOC_KTLS_RX_INDEX,
> +	NBL_CHAN_MSG_FREE_KTLS_RX_INDEX,
> +	NBL_CHAN_MSG_CFG_KTLS_RX_KEYMAT,
> +	NBL_CHAN_MSG_CFG_KTLS_RX_RECORD,
> +	NBL_CHAN_MSG_ADD_KTLS_RX_FLOW,
> +	NBL_CHAN_MSG_DEL_KTLS_RX_FLOW,
> +	NBL_CHAN_MSG_ALLOC_IPSEC_TX_INDEX,
> +	NBL_CHAN_MSG_FREE_IPSEC_TX_INDEX,
> +	NBL_CHAN_MSG_ALLOC_IPSEC_RX_INDEX,
> +	NBL_CHAN_MSG_FREE_IPSEC_RX_INDEX,
> +	NBL_CHAN_MSG_CFG_IPSEC_TX_SAD,
> +	NBL_CHAN_MSG_CFG_IPSEC_RX_SAD,
> +	NBL_CHAN_MSG_ADD_IPSEC_TX_FLOW,
> +	NBL_CHAN_MSG_DEL_IPSEC_TX_FLOW,
> +	NBL_CHAN_MSG_ADD_IPSEC_RX_FLOW,
> +	NBL_CHAN_MSG_DEL_IPSEC_RX_FLOW,
> +	NBL_CHAN_MSG_NOTIFY_IPSEC_HARD_EXPIRE,
> +	NBL_CHAN_MSG_GET_MBX_IRQ_NUM,
> +	NBL_CHAN_MSG_CLEAR_FLOW,
> +	NBL_CHAN_MSG_CLEAR_QUEUE,
> +	NBL_CHAN_MSG_GET_ETH_ID,
> +	NBL_CHAN_MSG_SET_OFFLOAD_STATUS,
> +	NBL_CHAN_MSG_INIT_OFLD,
> +	NBL_CHAN_MSG_INIT_CMDQ,
> +	NBL_CHAN_MSG_DESTROY_CMDQ,
> +	NBL_CHAN_MSG_RESET_CMDQ,
> +	NBL_CHAN_MSG_INIT_FLOW,
> +	NBL_CHAN_MSG_DEINIT_FLOW,
> +	NBL_CHAN_MSG_OFFLOAD_FLOW_RULE,
> +	NBL_CHAN_MSG_GET_ACL_SWITCH,
> +	NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID,
> +	NBL_CHAN_MSG_INIT_REP,
> +	NBL_CHAN_MSG_GET_LINE_RATE_INFO,
> +	NBL_CHAN_MSG_REGISTER_NET_REP,
> +	NBL_CHAN_MSG_UNREGISTER_NET_REP,
> +	NBL_CHAN_MSG_REGISTER_ETH_REP,
> +	NBL_CHAN_MSG_UNREGISTER_ETH_REP,
> +	NBL_CHAN_MSG_REGISTER_UPCALL_PORT,
> +	NBL_CHAN_MSG_UNREGISTER_UPCALL_PORT,
> +	NBL_CHAN_MSG_GET_PORT_STATE,
> +	NBL_CHAN_MSG_SET_PORT_ADVERTISING,
> +	NBL_CHAN_MSG_GET_MODULE_INFO,
> +	NBL_CHAN_MSG_GET_MODULE_EEPROM,
> +	NBL_CHAN_MSG_GET_LINK_STATE,
> +	NBL_CHAN_MSG_NOTIFY_LINK_STATE,
> +	NBL_CHAN_MSG_GET_QUEUE_CXT,
> +	NBL_CHAN_MSG_CFG_LOG,
> +	NBL_CHAN_MSG_INIT_VDPAQ,
> +	NBL_CHAN_MSG_DESTROY_VDPAQ,
> +	NBL_CHAN_MSG_GET_UPCALL_PORT,
> +	NBL_CHAN_MSG_NOTIFY_ETH_REP_LINK_STATE,
> +	NBL_CHAN_MSG_SET_ETH_MAC_ADDR,
> +	NBL_CHAN_MSG_GET_FUNCTION_ID,
> +	NBL_CHAN_MSG_GET_CHIP_TEMPERATURE,
> +	NBL_CHAN_MSG_DISABLE_HW_FLOW,
> +	NBL_CHAN_MSG_ENABLE_HW_FLOW,
> +	NBL_CHAN_MSG_SET_UPCALL_RULE,
> +	NBL_CHAN_MSG_UNSET_UPCALL_RULE,
> +	NBL_CHAN_MSG_GET_REG_DUMP,
> +	NBL_CHAN_MSG_GET_REG_DUMP_LEN,
> +	NBL_CHAN_MSG_CFG_LAG_HASH_ALGORITHM,
> +	NBL_CHAN_MSG_CFG_LAG_MEMBER_FWD,
> +	NBL_CHAN_MSG_CFG_LAG_MEMBER_LIST,
> +	NBL_CHAN_MSG_CFG_LAG_MEMBER_UP_ATTR,
> +	NBL_CHAN_MSG_ADD_LAG_FLOW,
> +	NBL_CHAN_MSG_DEL_LAG_FLOW,
> +	NBL_CHAN_MSG_SWITCHDEV_INIT_CMDQ,
> +	NBL_CHAN_MSG_SWITCHDEV_DEINIT_CMDQ,
> +	NBL_CHAN_MSG_SET_TC_FLOW_INFO,
> +	NBL_CHAN_MSG_UNSET_TC_FLOW_INFO,
> +	NBL_CHAN_MSG_INIT_ACL,
> +	NBL_CHAN_MSG_UNINIT_ACL,
> +	NBL_CHAN_MSG_CFG_LAG_MCC,
> +	NBL_CHAN_MSG_REGISTER_VSI2Q,
> +	NBL_CHAN_MSG_SETUP_Q2VSI,
> +	NBL_CHAN_MSG_REMOVE_Q2VSI,
> +	NBL_CHAN_MSG_SETUP_RSS,
> +	NBL_CHAN_MSG_REMOVE_RSS,
> +	NBL_CHAN_MSG_GET_REP_QUEUE_INFO,
> +	NBL_CHAN_MSG_CTRL_PORT_LED,
> +	NBL_CHAN_MSG_NWAY_RESET,
> +	NBL_CHAN_MSG_SET_INTL_SUPPRESS_LEVEL,
> +	NBL_CHAN_MSG_GET_ETH_STATS,
> +	NBL_CHAN_MSG_GET_MODULE_TEMPERATURE,
> +	NBL_CHAN_MSG_GET_BOARD_INFO,
> +	NBL_CHAN_MSG_GET_P4_USED,
> +	NBL_CHAN_MSG_GET_VF_BASE_VSI_ID,
> +	NBL_CHAN_MSG_ADD_LLDP_FLOW,
> +	NBL_CHAN_MSG_DEL_LLDP_FLOW,
> +	NBL_CHAN_MSG_CFG_ETH_BOND_INFO,
> +	NBL_CHAN_MSG_CFG_DUPPKT_MCC,
> +	NBL_CHAN_MSG_ADD_ND_UPCALL_FLOW,
> +	NBL_CHAN_MSG_DEL_ND_UPCALL_FLOW,
> +	NBL_CHAN_MSG_GET_BOARD_ID,
> +	NBL_CHAN_MSG_SET_SHAPING_DPORT_VLD,
> +	NBL_CHAN_MSG_SET_DPORT_FC_TH_VLD,
> +	NBL_CHAN_MSG_REGISTER_RDMA_BOND,
> +	NBL_CHAN_MSG_UNREGISTER_RDMA_BOND,
> +	NBL_CHAN_MSG_RESTORE_NETDEV_QUEUE,
> +	NBL_CHAN_MSG_RESTART_NETDEV_QUEUE,
> +	NBL_CHAN_MSG_RESTORE_HW_QUEUE,
> +	NBL_CHAN_MSG_KEEP_ALIVE,
> +	NBL_CHAN_MSG_GET_BASE_MAC_ADDR,
> +	NBL_CHAN_MSG_CFG_BOND_SHAPING,
> +	NBL_CHAN_MSG_CFG_BGID_BACK_PRESSURE,
> +	NBL_CHAN_MSG_ALLOC_KT_BLOCK,
> +	NBL_CHAN_MSG_FREE_KT_BLOCK,
> +	NBL_CHAN_MSG_GET_USER_QUEUE_INFO,
> +	NBL_CHAN_MSG_GET_ETH_BOND_INFO,
> +	NBL_CHAN_MSG_CLEAR_ACCEL_FLOW,
> +	NBL_CHAN_MSG_SET_BRIDGE_MODE,
> +	NBL_CHAN_MSG_GET_VF_FUNCTION_ID,
> +	NBL_CHAN_MSG_NOTIFY_LINK_FORCED,
> +	NBL_CHAN_MSG_SET_PMD_DEBUG,
> +	NBL_CHAN_MSG_REGISTER_FUNC_MAC,
> +	NBL_CHAN_MSG_SET_TX_RATE,
> +	NBL_CHAN_MSG_REGISTER_FUNC_LINK_FORCED,
> +	NBL_CHAN_MSG_GET_LINK_FORCED,
> +	NBL_CHAN_MSG_REGISTER_FUNC_VLAN,
> +	NBL_CHAN_MSG_GET_FD_FLOW,
> +	NBL_CHAN_MSG_GET_FD_FLOW_CNT,
> +	NBL_CHAN_MSG_GET_FD_FLOW_ALL,
> +	NBL_CHAN_MSG_GET_FD_FLOW_MAX,
> +	NBL_CHAN_MSG_REPLACE_FD_FLOW,
> +	NBL_CHAN_MSG_REMOVE_FD_FLOW,
> +	NBL_CHAN_MSG_CFG_FD_FLOW_STATE,
> +	NBL_CHAN_MSG_REGISTER_FUNC_RATE,
> +	NBL_CHAN_MSG_NOTIFY_VLAN,
> +	NBL_CHAN_MSG_GET_XDP_QUEUE_INFO,
> +	NBL_CHAN_MSG_STOP_ABNORMAL_SW_QUEUE,
> +	NBL_CHAN_MSG_STOP_ABNORMAL_HW_QUEUE,
> +	NBL_CHAN_MSG_NOTIFY_RESET_EVENT,
> +	NBL_CHAN_MSG_ACK_RESET_EVENT,
> +	NBL_CHAN_MSG_GET_VF_VSI_ID,
> +	NBL_CHAN_MSG_CONFIGURE_QOS,
> +	NBL_CHAN_MSG_GET_PFC_BUFFER_SIZE,
> +	NBL_CHAN_MSG_SET_PFC_BUFFER_SIZE,
> +	NBL_CHAN_MSG_GET_VF_STATS,
> +	NBL_CHAN_MSG_REGISTER_FUNC_TRUST,
> +	NBL_CHAN_MSG_NOTIFY_TRUST,
> +	NBL_CHAN_MSG_CHECK_VF_IS_ACTIVE,
> +	NBL_CHAN_MSG_GET_ETH_ABNORMAL_STATS,
> +	NBL_CHAN_MSG_GET_ETH_CTRL_STATS,
> +	NBL_CHAN_MSG_GET_PAUSE_STATS,
> +	NBL_CHAN_MSG_GET_ETH_MAC_STATS,
> +	NBL_CHAN_MSG_GET_FEC_STATS,
> +	NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE,
> +	NBL_CHAN_MSG_GET_LINK_DOWN_COUNT,
> +	NBL_CHAN_MSG_GET_LINK_STATUS_OPCODE,
> +	NBL_CHAN_MSG_GET_RMON_STATS,
> +	NBL_CHAN_MSG_REGISTER_PF_NAME,
> +	NBL_CHAN_MSG_GET_PF_NAME,
> +	NBL_CHAN_MSG_CONFIGURE_RDMA_BW,
> +	NBL_CHAN_MSG_SET_RATE_LIMIT,
> +	NBL_CHAN_MSG_SET_TC_WGT,
> +	NBL_CHAN_MSG_REMOVE_QUEUE,
> +	NBL_CHAN_MSG_GET_MIRROR_TABLE_ID,
> +	NBL_CHAN_MSG_CONFIGURE_MIRROR,
> +	NBL_CHAN_MSG_CONFIGURE_MIRROR_TABLE,
> +	NBL_CHAN_MSG_CLEAR_MIRROR_CFG,
> +	NBL_CHAN_MSG_MIRROR_OUTPUTPORT_NOTIFY,
> +	NBL_CHAN_MSG_CHECK_FLOWTABLE_SPEC,
> +	NBL_CHAN_MSG_CHECK_VF_IS_VDPA,
> +	NBL_CHAN_MSG_GET_VDPA_VF_STATS,
> +	NBL_CHAN_MSG_SET_RX_RATE,
> +	NBL_CHAN_MSG_GET_UVN_PKT_DROP_STATS,
> +	NBL_CHAN_MSG_GET_USTORE_PKT_DROP_STATS,
> +	NBL_CHAN_MSG_GET_USTORE_TOTAL_PKT_DROP_STATS,
> +	NBL_CHAN_MSG_SET_WOL,
> +	NBL_CHAN_MSG_INIT_VF_MSIX_MAP,
> +	NBL_CHAN_MSG_GET_ST_NAME,
> +	NBL_CHAN_MSG_MTU_SET = 501,
> +	NBL_CHAN_MSG_SET_RXFH_INDIR = 506,
> +	NBL_CHAN_MSG_SET_RXFH_RSS_ALG_SEL = 508,
> +	/* mailbox msg end */
> +	NBL_CHAN_MSG_MAILBOX_MAX,
> +};
> +

This is a big enum. Is there a possibility to group them by functionality?

> +struct nbl_chan_param_cfg_msix_map {
> +	u16 num_net_msix;
> +	u16 num_others_msix;
> +	u16 msix_mask_en;
> +};
> +
> +struct nbl_chan_param_enable_mailbox_irq {
> +	u16 vector_id;
> +	bool enable_msix;
> +};
> +
> +struct nbl_chan_param_get_vsi_id {
> +	u16 vsi_id;
> +	u16 type;
> +};
> +
> +struct nbl_chan_param_get_eth_id {
> +	u16 vsi_id;
> +	u8 eth_mode;
> +	u8 eth_id;
> +	u8 logic_eth_id;
> +};
> +
>   enum nbl_channel_type {
>   	NBL_CHAN_TYPE_MAILBOX,
>   	NBL_CHAN_TYPE_MAX


