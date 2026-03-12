Return-Path: <netdev+bounces-267030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOL/MKeqsmnwOQAAu9opvQ
	(envelope-from <netdev+bounces-267030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:59:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE5E27161A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79DAA31115B3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5398C39C017;
	Thu, 12 Mar 2026 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEJ8ZogP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpHkIklo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB439DBE0
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316716; cv=none; b=qI7g4hHv4Xzbh6O8zDBugYsJMQS2Q2FMl7gbmODeYZocO57kkzGVLSycqm4vb91/K7ldlQV8H2AsRiak2oZGEaqprnMpgnSLISirphkvY7c6L1LBvtLLmOEJBIhS+38vWA1e3ZJO1tauDjEIEPxex07GsJerqRhaUXs1nD4FfN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316716; c=relaxed/simple;
	bh=lGoY4TCSDBsyWNxOzKDjFgOnFRKJhGmeKyY5SnA1jEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVtYlAzOk61xp8bdQ4YwJw+fRbHBEAItO2d0/RiXpC2ywfq7MlbglJ3wo6HBx4miCLLwF0xB5EETacjcOrNrJqQN97tGS8mzelBGTdcOBMfDpAahGymf6M+pOqMZXKwFk6v7nhuCUz0W0iN5w/IF0pwCSoDyFoGxIXbrIL9BJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEJ8ZogP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpHkIklo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773316713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXxi3+qmXgl3v9TnFE4bq2itdoaey5h02vNp6UUv4gk=;
	b=YEJ8ZogPOL0BtMbr8dCbsSlkbwm567cLlddkZSH0Q8e4Nlzoqok47UEwGcjaAQY/xa81pt
	k5nsWudbRggIH2nfsOG4KIKaQLipnIW0L5i2FqLMAny/xCWQsIrReIawYAcqhzLoikAcmE
	AuWYbk6WdBfUWA6PnT9JS4o/IPs+F7s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-3Q5pYmWzMhebjW3O9c1DbQ-1; Thu, 12 Mar 2026 07:58:26 -0400
X-MC-Unique: 3Q5pYmWzMhebjW3O9c1DbQ-1
X-Mimecast-MFC-AGG-ID: 3Q5pYmWzMhebjW3O9c1DbQ_1773316705
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48378df3469so10011455e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 04:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773316705; x=1773921505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXxi3+qmXgl3v9TnFE4bq2itdoaey5h02vNp6UUv4gk=;
        b=bpHkIklo6WTRZCSl9qUyUg47YYHfz57kcsKDstwJ4mf8w2iba5az4eig13MjX/0w75
         IIrqNqZNlm8my+uOvlklh8Adoe7yKK80jgBd+3srPUtbYzQxAP0MoJJkUxML8EN+d3Cr
         NoHy56okCxcxYzBcGBwjI70Nk37+Yfl1Jzvcs5AB+DVDXWySdKTeEXBbbTXMKL59dkaA
         UwBkExEEFQ0jFveKSb3M5NQfXdwvDL4qSHnqqz2NGJfT28jD5dx/Xd+Zrc3GIxJ3/DgA
         aHhvTSbveZdNuu1yvx3EbAd1bMNeD+Rzv3YDtRJ8kut4/IXVK+KtguOQN9OCmNYXVvIG
         miBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773316705; x=1773921505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXxi3+qmXgl3v9TnFE4bq2itdoaey5h02vNp6UUv4gk=;
        b=I2xdM03MQLi/kw/ekCyc2w6nD7LVRs4EWxGYmgNVc83EoxJpc9A0NxrWsJG3UQ9Jxj
         ASTheyFD0jY67AvbTaPq86TcfYlhB2J9dyqKUkHeCGHdyXeikDNVH/hENNUrD2ruH81z
         SMzwjzhSsoSjXF1lAENXVFClu9sIR2AziLeL3LOcfUxCEcr2YDb7HbHrSjf0lwNy7zTB
         GHMuHeulgN2nmZy/9lyll6EgtbzqY8VL12NO/Q21DzIEEGJN8GMbtsxkqOkMR0rCK8db
         UUoL2QFUqt/EhsFCO2h/CUZ1mrS0K/+WqNKuNgeEZ34YVna8tEGu8S3FeJVSm7CZb9Qc
         Tl8g==
X-Forwarded-Encrypted: i=1; AJvYcCVBVvbQpcaNoA7E0o/L6oIuoQlqV9EVQZbZTcbqtJmh0ga9NJUfvz90/MGa3nr8U/4cXCagt9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxtmOikQie3DSNWYMoOlMgvhKuWY1xy1GEC7ZBhPUTNaUFxrb
	u+w1G2m16vi3AjA+Vfr7ztYpD2NoSveK4+380gLwMvRUF/B7V56LUA0tlThJuxdHE0DKkvVrkmN
	BGRzvHCYFftWBRrsOmMXbSuhzaF6dBZbQ4JfSOFGBykF1TYKb+ran5ehzcg==
X-Gm-Gg: ATEYQzymT8VYO1sXXhfdWl6qml/0hb50JjlywVYnNOdxW2XTugj2up7/6nWbL5GAEUT
	99/DvCqg4qX0AcLZKkUj2FkM9Jm31KXSAdMYtpEculIB20Yzab4nOZs+hSr3i6asnOKSAix4Om0
	fUvP3MRW6ZuV5rF1X2kgg1wzpxotvlwFwhgtQTOYTzJ4XuUR8alGaU3Lmi4zKaMr3+7TnGC2u+i
	4KnADC8ewUBfkuORlQOy2qWMwJLOmZwWDVh5JXYP6t8T/HMj/KXZ76TyJqX5IAOxkz+j+ZVISQZ
	WZelHth4aDtZ2C+XveZnp62iXE7xQybv1wmjs4ZIvrxUzS09ofx5MwTMt4oRTviM7lZ4ztxeAWH
	+M4xkggNBqzQ4/PfS9XVHowQtVlkiFLVtjCM23ecaDlwbWWi8LMc4Z1s=
X-Received: by 2002:a05:600c:4e8e:b0:485:3f58:da2 with SMTP id 5b1f17b1804b1-4854f59f546mr47264885e9.16.1773316705098;
        Thu, 12 Mar 2026 04:58:25 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8e:b0:485:3f58:da2 with SMTP id 5b1f17b1804b1-4854f59f546mr47264245e9.16.1773316704481;
        Thu, 12 Mar 2026 04:58:24 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66dedfsm127213045e9.12.2026.03.12.04.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 04:58:24 -0700 (PDT)
Message-ID: <f669062e-16f4-471a-9884-6441c478dd09@redhat.com>
Date: Thu, 12 Mar 2026 12:58:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 03/11] net/nebula-matrix: add chip related
 definitions
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, edumazet@google.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260310120959.22015-1-illusion.wang@nebula-matrix.com>
 <20260310120959.22015-4-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260310120959.22015-4-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267030-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,illusion.wang:url]
X-Rspamd-Queue-Id: 3FE5E27161A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 1:09 PM, illusion.wang wrote:
> +/*  --------  USTORE  --------  */
> +#define NBL_USTORE_PKT_LEN_ADDR (NBL_DP_USTORE_BASE + 0x00000108)
> +#define NBL_USTORE_PORT_DROP_TH_REG_ARR(port_id) \
> +	(NBL_DP_USTORE_BASE + 0x00000150 +       \
> +	 (port_id) * sizeof(struct nbl_ustore_port_drop_th))
> +#define NBL_USTORE_BUF_PORT_DROP_PKT(eth_id) \
> +	(NBL_DP_USTORE_BASE + 0x00002500 + (eth_id) * sizeof(u32))
> +#define NBL_USTORE_BUF_PORT_TRUN_PKT(eth_id) \
> +	(NBL_DP_USTORE_BASE + 0x00002540 + (eth_id) * sizeof(u32))
> +
> +#define NBL_USTORE_SIGNLE_ETH_DROP_TH		0xC80

AI review says:

There's a typo in the macro name: NBL_USTORE_SIGNLE_ETH_DROP_TH should
be NBL_USTORE_SINGLE_ETH_DROP_TH.


> +#define NBL_USTORE_DUAL_ETH_DROP_TH		0x640
> +#define NBL_USTORE_QUAD_ETH_DROP_TH		0x320
> +
> +/* USTORE pkt_len */
> +struct ustore_pkt_len {
> +	u32 min:7;
> +	u32 rsv:8;
> +	u32 min_chk_en:1;
> +	u32 max:14;
> +	u32 rsv2:1;
> +	u32 max_chk_len:1;
> +};
> +
> +/* USTORE port_drop_th */
> +struct nbl_ustore_port_drop_th {
> +	u32 disc_th:12;
> +	u32 rsv:19;
> +	u32 en:1;
> +};
> +
> +#define NBL_UQM_QUE_TYPE			(NBL_DP_UQM_BASE + 0x0000013c)
> +#define NBL_UQM_DROP_PKT_CNT			(NBL_DP_UQM_BASE + 0x000009C0)
> +#define NBL_UQM_DROP_PKT_SLICE_CNT		(NBL_DP_UQM_BASE + 0x000009C4)
> +#define NBL_UQM_DROP_PKT_LEN_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009C8)
> +#define NBL_UQM_DROP_HEAD_PNTR_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009CC)
> +#define NBL_UQM_DROP_WEIGHT_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009D0)
> +#define NBL_UQM_PORT_DROP_PKT_CNT		(NBL_DP_UQM_BASE + 0x000009D4)
> +#define NBL_UQM_PORT_DROP_PKT_SLICE_CNT		(NBL_DP_UQM_BASE + 0x000009F4)
> +#define NBL_UQM_PORT_DROP_PKT_LEN_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A14)
> +#define NBL_UQM_PORT_DROP_HEAD_PNTR_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A34)
> +#define NBL_UQM_PORT_DROP_WEIGHT_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A54)
> +#define NBL_UQM_FWD_DROP_CNT			(NBL_DP_UQM_BASE + 0x00000A80)
> +#define NBL_UQM_DPORT_DROP_CNT			(NBL_DP_UQM_BASE + 0x00000B74)
> +
> +#define NBL_UQM_PORT_DROP_DEPTH			6
> +#define NBL_UQM_DPORT_DROP_DEPTH		16
> +
> +struct nbl_uqm_que_type {
> +	u32 bp_drop:1;
> +	u32 rsv:31;
> +};
> +
> +#pragma pack()
> +
> +#define NBL_BYTES_IN_REG			(4)
> +#define NBL_SHAPING_DPORT_ADDR (0x504700)
> +#define NBL_SHAPING_DPORT_DWLEN (4)
> +#define NBL_SHAPING_DPORT_REG(r) \
> +	(NBL_SHAPING_DPORT_ADDR + (NBL_SHAPING_DPORT_DWLEN * 4) * (r))
> +#define NBL_SHAPING_DVN_DPORT_ADDR (0x504750)
> +#define NBL_SHAPING_DVN_DPORT_DWLEN (4)
> +#define NBL_SHAPING_DVN_DPORT_REG(r) \
> +	(NBL_SHAPING_DVN_DPORT_ADDR + (NBL_SHAPING_DVN_DPORT_DWLEN * 4) * (r))
> +#define NBL_DSCH_PSHA_EN_ADDR (0x404314)
> +#define NBL_SHAPING_NET_ADDR (0x505800)
> +#define NBL_SHAPING_NET_DWLEN (4)
> +#define NBL_SHAPING_NET_REG(r) \
> +	(NBL_SHAPING_NET_ADDR + (NBL_SHAPING_NET_DWLEN * 4) * (r))
> +
> +#define NBL_DPED_L4_CK_CMD_40_ADDR  (0x75c338)
> +#define NBL_DPED_L4_CK_CMD_40_DEPTH (1)
> +#define NBL_DPED_L4_CK_CMD_40_WIDTH (32)
> +#define NBL_DPED_L4_CK_CMD_40_DWLEN (1)
> +union dped_l4_ck_cmd_40_u {
> +	struct dped_l4_ck_cmd_40 {
> +		u32 value:8;             /* [7:0] Default:0x0 RW */
> +		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
> +		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
> +		u32 len_vld:1;           /* [17] Default:0x0 RW */
> +		u32 data_vld:1;          /* [18] Default:0x0 RW */
> +		u32 in_oft:7;            /* [25:19] Default:0x8 RW */
> +		u32 phid:2;              /* [27:26] Default:0x3 RW */
> +		u32 flag:1;              /* [28] Default:0x0 RW */
> +		u32 mode:1;              /* [29] Default:0x1 RW */
> +		u32 rsv:1;               /* [30] Default:0x0 RO */
> +		u32 en:1;                /* [31] Default:0x0 RW */
> +	} __packed info;
> +	u32 data[NBL_DPED_L4_CK_CMD_40_DWLEN];
> +} __packed;
> +
> +#define NBL_DSTORE_D_DPORT_FC_TH_ADDR  (0x704600)
> +#define NBL_DSTORE_D_DPORT_FC_TH_DEPTH (5)
> +#define NBL_DSTORE_D_DPORT_FC_TH_WIDTH (32)
> +#define NBL_DSTORE_D_DPORT_FC_TH_DWLEN (1)
> +union dstore_d_dport_fc_th_u {
> +	struct dstore_d_dport_fc_th {
> +		u32 xoff_th:11;          /* [10:0] Default:200 RW */
> +		u32 rsv1:5;              /* [15:11] Default:0x0 RO */
> +		u32 xon_th:11;           /* [26:16] Default:100 RW */
> +		u32 rsv:3;               /* [29:27] Default:0x0 RO */
> +		u32 fc_set:1;            /* [30:30] Default:0x0 RW */
> +		u32 fc_en:1;             /* [31:31] Default:0x0 RW */
> +	} __packed info;
> +	u32 data[NBL_DSTORE_D_DPORT_FC_TH_DWLEN];
> +} __packed;
> +#define NBL_DSTORE_D_DPORT_FC_TH_REG(r) (NBL_DSTORE_D_DPORT_FC_TH_ADDR + \
> +		(NBL_DSTORE_D_DPORT_FC_TH_DWLEN * 4) * (r))
> +#define NBL_DSTORE_PORT_DROP_TH_ADDR  (0x704150)
> +#define NBL_DSTORE_PORT_DROP_TH_DEPTH (6)
> +#define NBL_DSTORE_PORT_DROP_TH_WIDTH (32)
> +#define NBL_DSTORE_PORT_DROP_TH_DWLEN (1)
> +union dstore_port_drop_th_u {
> +	struct dstore_port_drop_th {
> +		u32 disc_th:10;          /* [9:0] Default:800 RW */
> +		u32 rsv:21;              /* [30:10] Default:0x0 RO */
> +		u32 en:1;                /* [31] Default:0x1 RW */
> +	} __packed info;
> +	u32 data[NBL_DSTORE_PORT_DROP_TH_DWLEN];
> +} __packed;
> +#define NBL_DSTORE_PORT_DROP_TH_REG(r) (NBL_DSTORE_PORT_DROP_TH_ADDR + \
> +		(NBL_DSTORE_PORT_DROP_TH_DWLEN * 4) * (r))
> +
> +#define NBL_FW_BOARD_CONFIG			0x200
> +#define NBL_FW_BOARD_DW3_OFFSET			(NBL_FW_BOARD_CONFIG + 12)
> +#define NBL_FW_BOARD_DW6_OFFSET			(NBL_FW_BOARD_CONFIG + 24)
> +union nbl_fw_board_cfg_dw3 {
> +	struct board_cfg_dw3 {
> +		u32 port_type:1;
> +		u32 port_num:7;
> +		u32 port_speed:2;
> +		u32 gpio_type:3;
> +		u32 p4_version:1; /* 0: low version; 1: high version */
> +		u32 rsv:18;
> +	} __packed info;
> +	u32 data;
> +};
> +
> +union nbl_fw_board_cfg_dw6 {
> +	struct board_cfg_dw6 {
> +		u8 lane_bitmap;
> +		u8 eth_bitmap;
> +		u16 rsv;
> +	} __packed info;
> +	u32 data;
> +};
> +
> +#define NBL_LEONIS_QUIRKS_OFFSET	(0x00000140)
> +#define NBL_LEONIS_ILLEGAL_REG_VALUE	(0xDEADBEEF)
> +
>  #endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
> new file mode 100644
> index 000000000000..8850ff7f7e52
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
> @@ -0,0 +1,2901 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include "nbl_hw_leonis.h"
> +#include "nbl_hw_leonis_regs.h"
> +
> +#define NBL_SEC_BLOCK_SIZE		(0x100)
> +#define NBL_SEC000_SIZE			(1)
> +#define NBL_SEC000_ADDR			(0x114150)
> +#define NBL_SEC001_SIZE			(1)
> +#define NBL_SEC001_ADDR			(0x15c190)
> +#define NBL_SEC002_SIZE			(1)
> +#define NBL_SEC002_ADDR			(0x10417c)
> +#define NBL_SEC003_SIZE			(1)
> +#define NBL_SEC003_ADDR			(0x714154)
> +#define NBL_SEC004_SIZE			(1)
> +#define NBL_SEC004_ADDR			(0x75c190)
> +#define NBL_SEC005_SIZE			(1)
> +#define NBL_SEC005_ADDR			(0x70417c)
> +#define NBL_SEC006_SIZE			(512)
> +#define NBL_SEC006_ADDR			(0x8f000)
> +#define NBL_SEC006_REGI(i)		(0x8f000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC007_SIZE			(256)
> +#define NBL_SEC007_ADDR			(0x8f800)
> +#define NBL_SEC007_REGI(i)		(0x8f800 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC008_SIZE			(1024)
> +#define NBL_SEC008_ADDR			(0x90000)
> +#define NBL_SEC008_REGI(i)		(0x90000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC009_SIZE			(2048)
> +#define NBL_SEC009_ADDR			(0x94000)
> +#define NBL_SEC009_REGI(i)		(0x94000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC010_SIZE			(256)
> +#define NBL_SEC010_ADDR			(0x96000)
> +#define NBL_SEC010_REGI(i)		(0x96000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC011_SIZE			(1024)
> +#define NBL_SEC011_ADDR			(0x91000)
> +#define NBL_SEC011_REGI(i)		(0x91000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC012_SIZE			(128)
> +#define NBL_SEC012_ADDR			(0x92000)
> +#define NBL_SEC012_REGI(i)		(0x92000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC013_SIZE			(64)
> +#define NBL_SEC013_ADDR			(0x92200)
> +#define NBL_SEC013_REGI(i)		(0x92200 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC014_SIZE			(64)
> +#define NBL_SEC014_ADDR			(0x92300)
> +#define NBL_SEC014_REGI(i)		(0x92300 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC015_SIZE			(1)
> +#define NBL_SEC015_ADDR			(0x8c214)
> +#define NBL_SEC016_SIZE			(1)
> +#define NBL_SEC016_ADDR			(0x8c220)
> +#define NBL_SEC017_SIZE			(1)
> +#define NBL_SEC017_ADDR			(0x8c224)
> +#define NBL_SEC018_SIZE			(1)
> +#define NBL_SEC018_ADDR			(0x8c228)
> +#define NBL_SEC019_SIZE			(1)
> +#define NBL_SEC019_ADDR			(0x8c22c)
> +#define NBL_SEC020_SIZE			(1)
> +#define NBL_SEC020_ADDR			(0x8c1f0)
> +#define NBL_SEC021_SIZE			(1)
> +#define NBL_SEC021_ADDR			(0x8c1f8)
> +#define NBL_SEC022_SIZE			(256)
> +#define NBL_SEC022_ADDR			(0x85f000)
> +#define NBL_SEC022_REGI(i)		(0x85f000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC023_SIZE			(128)
> +#define NBL_SEC023_ADDR			(0x85f800)
> +#define NBL_SEC023_REGI(i)		(0x85f800 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC024_SIZE			(512)
> +#define NBL_SEC024_ADDR			(0x860000)
> +#define NBL_SEC024_REGI(i)		(0x860000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC025_SIZE			(1024)
> +#define NBL_SEC025_ADDR			(0x864000)
> +#define NBL_SEC025_REGI(i)		(0x864000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC026_SIZE			(256)
> +#define NBL_SEC026_ADDR			(0x866000)
> +#define NBL_SEC026_REGI(i)		(0x866000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC027_SIZE			(512)
> +#define NBL_SEC027_ADDR			(0x861000)
> +#define NBL_SEC027_REGI(i)		(0x861000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC028_SIZE			(64)
> +#define NBL_SEC028_ADDR			(0x862000)
> +#define NBL_SEC028_REGI(i)		(0x862000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC029_SIZE			(32)
> +#define NBL_SEC029_ADDR			(0x862200)
> +#define NBL_SEC029_REGI(i)		(0x862200 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC030_SIZE			(32)
> +#define NBL_SEC030_ADDR			(0x862300)
> +#define NBL_SEC030_REGI(i)		(0x862300 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC031_SIZE			(1)
> +#define NBL_SEC031_ADDR			(0x85c214)
> +#define NBL_SEC032_SIZE			(1)
> +#define NBL_SEC032_ADDR			(0x85c220)
> +#define NBL_SEC033_SIZE			(1)
> +#define NBL_SEC033_ADDR			(0x85c224)
> +#define NBL_SEC034_SIZE			(1)
> +#define NBL_SEC034_ADDR			(0x85c228)
> +#define NBL_SEC035_SIZE			(1)
> +#define NBL_SEC035_ADDR			(0x85c22c)
> +#define NBL_SEC036_SIZE			(1)
> +#define NBL_SEC036_ADDR			(0xb04200)
> +#define NBL_SEC037_SIZE			(1)
> +#define NBL_SEC037_ADDR			(0xb04230)
> +#define NBL_SEC038_SIZE			(1)
> +#define NBL_SEC038_ADDR			(0xb04234)
> +#define NBL_SEC039_SIZE			(64)
> +#define NBL_SEC039_ADDR			(0xb05800)
> +#define NBL_SEC039_REGI(i)		(0xb05800 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC040_SIZE			(32)
> +#define NBL_SEC040_ADDR			(0xb05400)
> +#define NBL_SEC040_REGI(i)		(0xb05400 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC041_SIZE			(16)
> +#define NBL_SEC041_ADDR			(0xb05500)
> +#define NBL_SEC041_REGI(i)		(0xb05500 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC042_SIZE			(1)
> +#define NBL_SEC042_ADDR			(0xb14148)
> +#define NBL_SEC043_SIZE			(1)
> +#define NBL_SEC043_ADDR			(0xb14104)
> +#define NBL_SEC044_SIZE			(1)
> +#define NBL_SEC044_ADDR			(0xb1414c)
> +#define NBL_SEC045_SIZE			(1)
> +#define NBL_SEC045_ADDR			(0xb14150)
> +#define NBL_SEC046_SIZE			(256)
> +#define NBL_SEC046_ADDR			(0xb15000)
> +#define NBL_SEC046_REGI(i)		(0xb15000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC047_SIZE			(32)
> +#define NBL_SEC047_ADDR			(0xb15800)
> +#define NBL_SEC047_REGI(i)		(0xb15800 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC048_SIZE			(1)
> +#define NBL_SEC048_ADDR			(0xb24148)
> +#define NBL_SEC049_SIZE			(1)
> +#define NBL_SEC049_ADDR			(0xb24104)
> +#define NBL_SEC050_SIZE			(1)
> +#define NBL_SEC050_ADDR			(0xb2414c)
> +#define NBL_SEC051_SIZE			(1)
> +#define NBL_SEC051_ADDR			(0xb24150)
> +#define NBL_SEC052_SIZE			(256)
> +#define NBL_SEC052_ADDR			(0xb25000)
> +#define NBL_SEC052_REGI(i)		(0xb25000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC053_SIZE			(32)
> +#define NBL_SEC053_ADDR			(0xb25800)
> +#define NBL_SEC053_REGI(i)		(0xb25800 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC054_SIZE			(1)
> +#define NBL_SEC054_ADDR			(0xb34148)
> +#define NBL_SEC055_SIZE			(1)
> +#define NBL_SEC055_ADDR			(0xb34104)
> +#define NBL_SEC056_SIZE			(1)
> +#define NBL_SEC056_ADDR			(0xb3414c)
> +#define NBL_SEC057_SIZE			(1)
> +#define NBL_SEC057_ADDR			(0xb34150)
> +#define NBL_SEC058_SIZE			(256)
> +#define NBL_SEC058_ADDR			(0xb35000)
> +#define NBL_SEC058_REGI(i)		(0xb35000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC059_SIZE			(32)
> +#define NBL_SEC059_ADDR			(0xb35800)
> +#define NBL_SEC059_REGI(i)		(0xb35800 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC060_SIZE			(1)
> +#define NBL_SEC060_ADDR			(0xe74630)
> +#define NBL_SEC061_SIZE			(1)
> +#define NBL_SEC061_ADDR			(0xe74634)
> +#define NBL_SEC062_SIZE			(64)
> +#define NBL_SEC062_ADDR			(0xe75000)
> +#define NBL_SEC062_REGI(i)		(0xe75000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC063_SIZE			(32)
> +#define NBL_SEC063_ADDR			(0xe75480)
> +#define NBL_SEC063_REGI(i)		(0xe75480 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC064_SIZE			(16)
> +#define NBL_SEC064_ADDR			(0xe75980)
> +#define NBL_SEC064_REGI(i)		(0xe75980 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC065_SIZE			(32)
> +#define NBL_SEC065_ADDR			(0x15f000)
> +#define NBL_SEC065_REGI(i)		(0x15f000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC066_SIZE			(32)
> +#define NBL_SEC066_ADDR			(0x75f000)
> +#define NBL_SEC066_REGI(i)		(0x75f000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC067_SIZE			(1)
> +#define NBL_SEC067_ADDR			(0xb64108)
> +#define NBL_SEC068_SIZE			(1)
> +#define NBL_SEC068_ADDR			(0xb6410c)
> +#define NBL_SEC069_SIZE			(1)
> +#define NBL_SEC069_ADDR			(0xb64140)
> +#define NBL_SEC070_SIZE			(1)
> +#define NBL_SEC070_ADDR			(0xb64144)
> +#define NBL_SEC071_SIZE			(512)
> +#define NBL_SEC071_ADDR			(0xb65000)
> +#define NBL_SEC071_REGI(i)		(0xb65000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC072_SIZE			(32)
> +#define NBL_SEC072_ADDR			(0xb65800)
> +#define NBL_SEC072_REGI(i)		(0xb65800 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC073_SIZE			(1)
> +#define NBL_SEC073_ADDR			(0x8c210)
> +#define NBL_SEC074_SIZE			(1)
> +#define NBL_SEC074_ADDR			(0x85c210)
> +#define NBL_SEC075_SIZE			(4)
> +#define NBL_SEC075_ADDR			(0x8c1b0)
> +#define NBL_SEC075_REGI(i)		(0x8c1b0 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC076_SIZE			(4)
> +#define NBL_SEC076_ADDR			(0x8c1c0)
> +#define NBL_SEC076_REGI(i)		(0x8c1c0 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC077_SIZE			(4)
> +#define NBL_SEC077_ADDR			(0x85c1b0)
> +#define NBL_SEC077_REGI(i)		(0x85c1b0 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC078_SIZE			(1)
> +#define NBL_SEC078_ADDR			(0x85c1ec)
> +#define NBL_SEC079_SIZE			(1)
> +#define NBL_SEC079_ADDR			(0x8c1ec)
> +#define NBL_SEC080_SIZE			(1)
> +#define NBL_SEC080_ADDR			(0xb04440)
> +#define NBL_SEC081_SIZE			(1)
> +#define NBL_SEC081_ADDR			(0xb04448)
> +#define NBL_SEC082_SIZE			(1)
> +#define NBL_SEC082_ADDR			(0xb14450)
> +#define NBL_SEC083_SIZE			(1)
> +#define NBL_SEC083_ADDR			(0xb24450)
> +#define NBL_SEC084_SIZE			(1)
> +#define NBL_SEC084_ADDR			(0xb34450)
> +#define NBL_SEC085_SIZE			(1)
> +#define NBL_SEC085_ADDR			(0xa04188)
> +#define NBL_SEC086_SIZE			(1)
> +#define NBL_SEC086_ADDR			(0xe74218)
> +#define NBL_SEC087_SIZE			(1)
> +#define NBL_SEC087_ADDR			(0xe7421c)
> +#define NBL_SEC088_SIZE			(1)
> +#define NBL_SEC088_ADDR			(0xe74220)
> +#define NBL_SEC089_SIZE			(1)
> +#define NBL_SEC089_ADDR			(0xe74224)
> +#define NBL_SEC090_SIZE			(1)
> +#define NBL_SEC090_ADDR			(0x75c22c)
> +#define NBL_SEC091_SIZE			(1)
> +#define NBL_SEC091_ADDR			(0x75c230)
> +#define NBL_SEC092_SIZE			(1)
> +#define NBL_SEC092_ADDR			(0x75c238)
> +#define NBL_SEC093_SIZE			(1)
> +#define NBL_SEC093_ADDR			(0x75c244)
> +#define NBL_SEC094_SIZE			(1)
> +#define NBL_SEC094_ADDR			(0x75c248)
> +#define NBL_SEC095_SIZE			(1)
> +#define NBL_SEC095_ADDR			(0x75c250)
> +#define NBL_SEC096_SIZE			(1)
> +#define NBL_SEC096_ADDR			(0x15c230)
> +#define NBL_SEC097_SIZE			(1)
> +#define NBL_SEC097_ADDR			(0x15c234)
> +#define NBL_SEC098_SIZE			(1)
> +#define NBL_SEC098_ADDR			(0x15c238)
> +#define NBL_SEC099_SIZE			(1)
> +#define NBL_SEC099_ADDR			(0x15c23c)
> +#define NBL_SEC100_SIZE			(1)
> +#define NBL_SEC100_ADDR			(0x15c244)
> +#define NBL_SEC101_SIZE			(1)
> +#define NBL_SEC101_ADDR			(0x15c248)
> +#define NBL_SEC102_SIZE			(1)
> +#define NBL_SEC102_ADDR			(0xb6432c)
> +#define NBL_SEC103_SIZE			(1)
> +#define NBL_SEC103_ADDR			(0xb64220)
> +#define NBL_SEC104_SIZE			(1)
> +#define NBL_SEC104_ADDR			(0xb44804)
> +#define NBL_SEC105_SIZE			(1)
> +#define NBL_SEC105_ADDR			(0xb44a00)
> +#define NBL_SEC106_SIZE			(1)
> +#define NBL_SEC106_ADDR			(0xe84210)
> +#define NBL_SEC107_SIZE			(1)
> +#define NBL_SEC107_ADDR			(0xe84214)
> +#define NBL_SEC108_SIZE			(1)
> +#define NBL_SEC108_ADDR			(0xe64228)
> +#define NBL_SEC109_SIZE			(1)
> +#define NBL_SEC109_ADDR			(0x65413c)
> +#define NBL_SEC110_SIZE			(1)
> +#define NBL_SEC110_ADDR			(0x984144)
> +#define NBL_SEC111_SIZE			(1)
> +#define NBL_SEC111_ADDR			(0x114130)
> +#define NBL_SEC112_SIZE			(1)
> +#define NBL_SEC112_ADDR			(0x714138)
> +#define NBL_SEC113_SIZE			(1)
> +#define NBL_SEC113_ADDR			(0x114134)
> +#define NBL_SEC114_SIZE			(1)
> +#define NBL_SEC114_ADDR			(0x71413c)
> +#define NBL_SEC115_SIZE			(1)
> +#define NBL_SEC115_ADDR			(0x90437c)
> +#define NBL_SEC116_SIZE			(32)
> +#define NBL_SEC116_ADDR			(0xb05000)
> +#define NBL_SEC116_REGI(i)		(0xb05000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC117_SIZE			(1)
> +#define NBL_SEC117_ADDR			(0xb043e0)
> +#define NBL_SEC118_SIZE			(1)
> +#define NBL_SEC118_ADDR			(0xb043f0)
> +#define NBL_SEC119_SIZE			(5)
> +#define NBL_SEC119_ADDR			(0x8c230)
> +#define NBL_SEC119_REGI(i)		(0x8c230 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC120_SIZE			(1)
> +#define NBL_SEC120_ADDR			(0x8c1f4)
> +#define NBL_SEC121_SIZE			(1)
> +#define NBL_SEC121_ADDR			(0x2046c4)
> +#define NBL_SEC122_SIZE			(1)
> +#define NBL_SEC122_ADDR			(0x85c1f4)
> +#define NBL_SEC123_SIZE			(1)
> +#define NBL_SEC123_ADDR			(0x75c194)
> +#define NBL_SEC124_SIZE			(256)
> +#define NBL_SEC124_ADDR			(0xa05000)
> +#define NBL_SEC124_REGI(i)		(0xa05000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC125_SIZE			(256)
> +#define NBL_SEC125_ADDR			(0xa06000)
> +#define NBL_SEC125_REGI(i)		(0xa06000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC126_SIZE			(256)
> +#define NBL_SEC126_ADDR			(0xa07000)
> +#define NBL_SEC126_REGI(i)		(0xa07000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC127_SIZE			(1)
> +#define NBL_SEC127_ADDR			(0x75c204)
> +#define NBL_SEC128_SIZE			(1)
> +#define NBL_SEC128_ADDR			(0x15c204)
> +#define NBL_SEC129_SIZE			(1)
> +#define NBL_SEC129_ADDR			(0x75c208)
> +#define NBL_SEC130_SIZE			(1)
> +#define NBL_SEC130_ADDR			(0x15c208)
> +#define NBL_SEC131_SIZE			(1)
> +#define NBL_SEC131_ADDR			(0x75c20c)
> +#define NBL_SEC132_SIZE			(1)
> +#define NBL_SEC132_ADDR			(0x15c20c)
> +#define NBL_SEC133_SIZE			(1)
> +#define NBL_SEC133_ADDR			(0x75c210)
> +#define NBL_SEC134_SIZE			(1)
> +#define NBL_SEC134_ADDR			(0x15c210)
> +#define NBL_SEC135_SIZE			(1)
> +#define NBL_SEC135_ADDR			(0x75c214)
> +#define NBL_SEC136_SIZE			(1)
> +#define NBL_SEC136_ADDR			(0x15c214)
> +#define NBL_SEC137_SIZE			(32)
> +#define NBL_SEC137_ADDR			(0x15d000)
> +#define NBL_SEC137_REGI(i)		(0x15d000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC138_SIZE			(32)
> +#define NBL_SEC138_ADDR			(0x75d000)
> +#define NBL_SEC138_REGI(i)		(0x75d000 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC139_SIZE			(1)
> +#define NBL_SEC139_ADDR			(0x75c310)
> +#define NBL_SEC140_SIZE			(1)
> +#define NBL_SEC140_ADDR			(0x75c314)
> +#define NBL_SEC141_SIZE			(1)
> +#define NBL_SEC141_ADDR			(0x75c340)
> +#define NBL_SEC142_SIZE			(1)
> +#define NBL_SEC142_ADDR			(0x75c344)
> +#define NBL_SEC143_SIZE			(1)
> +#define NBL_SEC143_ADDR			(0x75c348)
> +#define NBL_SEC144_SIZE			(1)
> +#define NBL_SEC144_ADDR			(0x75c34c)
> +#define NBL_SEC145_SIZE			(32)
> +#define NBL_SEC145_ADDR			(0xb15800)
> +#define NBL_SEC145_REGI(i)		(0xb15800 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC146_SIZE			(32)
> +#define NBL_SEC146_ADDR			(0xb25800)
> +#define NBL_SEC146_REGI(i)		(0xb25800 + NBL_BYTES_IN_REG * (i))
> +#define NBL_SEC147_SIZE			(32)
> +#define NBL_SEC147_ADDR			(0xb35800)
> +#define NBL_SEC147_REGI(i)		(0xb35800 + NBL_BYTES_IN_REG * (i))
> +
> +static const u32 nbl_sec046_1p_data[] = {

AI reviews says:

In v5 review, Andrew Lunn asked whether these large P4 configuration
data arrays should be marked __initdata since they're only used during
chip initialization. You acknowledged this and agreed to add __initdata,
but it wasn't included in v6 or v7.

The arrays are correctly marked const now, but should they also be
marked __initdata to free the memory after initialization completes?

Link:
https://lore.kernel.org/netdev/c5d2ba02-55b8-4839-bbd1-1d387da27f96@lunn.ch/

/P


