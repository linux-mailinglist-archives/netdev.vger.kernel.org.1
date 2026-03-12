Return-Path: <netdev+bounces-267032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GJyMeyrsmkjOwAAu9opvQ
	(envelope-from <netdev+bounces-267032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:05:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A805271673
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F239D30C5777
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 12:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E2539098F;
	Thu, 12 Mar 2026 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzjDlsKF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsXBKeUv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5433815F3
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317074; cv=none; b=Qo464B0WTuvty4p9gZNt6YA+IKRtMRY/zg61b8y63HKheLYwVpsO1cg1pZ7slgQdrLRLMheCPrn9dts3hhYA1oUB83sgCyXgJ1xTo909aqn/OlOvh3v6x51XFnxCD7k7sA1z9kjnqxzW9cSSnO/U8zM5WrAojKoE39bIBZ5k88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317074; c=relaxed/simple;
	bh=qvqpZTKYUMj7CZIF36fscCMJnR9QuPc/fQiAUWu4G1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OZh/ZabWBoO3uNgG4mwuZ+VaH0W8ffE0mpDDObDsOqxYyKFwwMtrxneCdLSsglvH4YGBZNAsu2aoCZqFs+p21kyoibSsDNci3XLcugxk1jBk+P5asfs8bwMF1fAqCpvOyjBF7J9sfRUSTlSPruaWkDGlZugY5m/6N4Sey4i2cDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzjDlsKF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsXBKeUv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773317070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxZd6CK3fRY8Q/6m1rKmmnXwIVXfUrvMQ63A0cOVr0s=;
	b=LzjDlsKFtfhaZvCzjHlSZxM7IKzzrpeBS74sX2Ix9fm6K4nhL7CepDnBluxQL7k2gxxQ6X
	WGiajt0xCjW+P2UWI3pRs1GMMfYqEQX8XztkQTK1nFyKIxFWq21TO+x8cmgTJn4XxOdp0/
	XQlsnlgVISq1Sj219LdhBESNW+AAMhA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-92gqLVqmMmi-21QGgxBbQw-1; Thu, 12 Mar 2026 08:04:29 -0400
X-MC-Unique: 92gqLVqmMmi-21QGgxBbQw-1
X-Mimecast-MFC-AGG-ID: 92gqLVqmMmi-21QGgxBbQw_1773317068
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso12600035e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773317068; x=1773921868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxZd6CK3fRY8Q/6m1rKmmnXwIVXfUrvMQ63A0cOVr0s=;
        b=bsXBKeUvqqV3s8eDT6P+OzpzEQNj0E0U3lUrXztK6WBIWERsOiEy99K9Ctljgn+KTm
         P+r04v+JJE77sHSpomY1q031qzKzEob6j8JKALeQG73wWzgdW92KvI6MEFYtTL0YED7g
         VMkJzU/h4TzYse63ue11f6JRHsGCcuhmTUhaBDTgnwXcwLOGkSanPxfauZjNDqhRldZx
         /Bi4e4fo4GLBQhYfFjFKHrsCiYScUfhkZO1WIRdXKtW3XBVY7hn8FlQys+lUl8ySrP1n
         Ha5czNG3ExKns7q3yMwxtDXsssPHz3gh8dowfd/aKhdseAd0LyXdgY+PWHBh7KsPUxXr
         roJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317068; x=1773921868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxZd6CK3fRY8Q/6m1rKmmnXwIVXfUrvMQ63A0cOVr0s=;
        b=jdw4De1nonoPNqSFDGNVI/yfVd0qfF9Z++1//cMOeUuaDxK7CU/YC6dLV7GobA+EsR
         9eQCghsCCLpzdadly5LAkRWeb0OOh7Vk3DvSSY8lxjDW2KpQOn+8LdTtyS+REhvkNI5n
         2bQ+HBlr6Xeig2QNzhepvfW0IKFTo6Nnb/4Zd4mShTGuNNtPV0bxValPVln1fc+APH5O
         p/tIgQ8daL8lR5enNG8oIigseIwM7RSEgvGhnXnuAmD6NJ0a0nhQq3g4ioOaZ2MHb1Mj
         /cvfEWgWnfF+duES6crRc586ve8175AtM/83Idgfr2PJMX4YewDBcjXrxnUKqwpzfpHR
         pDmg==
X-Forwarded-Encrypted: i=1; AJvYcCWKLlZ3DK+xHxGNu3MFf4qaVQ1JgmNTgkRj2Z7ziiEzAAQcQ79iKzgwanwoLNNb6kN1hjNTsaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn++d9WkpzgOaLhvCffnvxgoTXpIb4uVejiC0//e4R7no9vdmv
	7G3ted+savaysnNbb/qdiQ96Y2RjB8HLEXFlVYiLzjnt4ycpNVfHQiyQUFfMOdEFCLul8vdHjw6
	J4fwIQvskZ7eqpquXTXKyR0kXbuLD7Idwf//1AAg2pmIiAyNKraQiMNF3RQ==
X-Gm-Gg: ATEYQzyoyU3RRIL3NrLkaMTIXnh3JDCuQnrXeOHkBnAez/5qwzgiEHgRDjvSrVtqHfs
	shHQMvbBtynkL2LtvZUFlffAHH29QNwoKtuJ/SgsKwzG9On7KTh0U0PDbK+tK953Sl7mWjB3HxU
	e9USmIDmVKebRwxJdI/cCchOm0KIGsyP8mZL+zQxP97jXJp6JBmiIUGWyUaqu9IsoofbMy5uheZ
	Wwx9r1Wrk3cdAJEjYNunxTkSDjZDZKSinhlxcb8kXDp1YWTwkxlwJTaM62QqxkOXogR70wJO8U3
	Un+Ar99HJxxG5MYy2cKvbtA+Y8xWmECmlV8siVmg1wRsg1JQQabmlq/kIIwRGR+OSDwteU28e/Q
	tml5TQETLRknBqFFTuSY8RWnnI6uHVXK/Fl5NPB6MVNST1Xx92DuwPdo=
X-Received: by 2002:a05:600c:34cd:b0:485:3a27:a960 with SMTP id 5b1f17b1804b1-4854ad7238amr97707565e9.0.1773317067984;
        Thu, 12 Mar 2026 05:04:27 -0700 (PDT)
X-Received: by 2002:a05:600c:34cd:b0:485:3a27:a960 with SMTP id 5b1f17b1804b1-4854ad7238amr97707005e9.0.1773317067549;
        Thu, 12 Mar 2026 05:04:27 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b544sm8244508f8f.20.2026.03.12.05.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 05:04:27 -0700 (PDT)
Message-ID: <1b835f08-20c8-4c40-bf17-ebc300e849a9@redhat.com>
Date: Thu, 12 Mar 2026 13:04:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 08/11] net/nebula-matrix: add vsi resource
 implementation
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
 vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, edumazet@google.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260310120959.22015-1-illusion.wang@nebula-matrix.com>
 <20260310120959.22015-9-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260310120959.22015-9-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267032-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[illusion.wang:url]
X-Rspamd-Queue-Id: 6A805271673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 1:09 PM, illusion.wang wrote:
> +static int nbl_dped_init(struct nbl_hw_mgt *hw_mgt)
> +{
> +	nbl_hw_wr32(hw_mgt, NBL_DPED_VLAN_OFFSET, 0xC);
> +	nbl_hw_wr32(hw_mgt, NBL_DPED_DSCP_OFFSET_0, 0x8);
> +	nbl_hw_wr32(hw_mgt, NBL_DPED_DSCP_OFFSET_1, 0x4);
> +
> +	// dped checksum offload

Minor nit: use /* */ for comments.

> +	nbl_configure_dped_checksum(hw_mgt);
> +
> +	return 0;
> +}
> +
> +static int nbl_uped_init(struct nbl_hw_mgt *hw_mgt)
> +{
> +	struct ped_hw_edit_profile hw_edit;
> +
> +	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(5), (u32 *)&hw_edit,
> +		       sizeof(hw_edit));
> +	hw_edit.l3_len = 0;
> +	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(5), (u32 *)&hw_edit,
> +		       sizeof(hw_edit));
> +
> +	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(6), (u32 *)&hw_edit,
> +		       sizeof(hw_edit));
> +	hw_edit.l3_len = 1;
> +	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(6), (u32 *)&hw_edit,
> +		       sizeof(hw_edit));
> +
> +	return 0;
> +}
> +
> +static void nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
> +{
> +	struct nbl_shaping_dvn_dport dvn_dport = { 0 };
> +	struct nbl_shaping_dport dport = { 0 };
> +	u32 rate, half_rate;
> +
> +	if (speed == NBL_FW_PORT_SPEED_100G) {
> +		rate = NBL_SHAPING_DPORT_100G_RATE;
> +		half_rate = NBL_SHAPING_DPORT_HALF_100G_RATE;
> +	} else {
> +		rate = NBL_SHAPING_DPORT_25G_RATE;
> +		half_rate = NBL_SHAPING_DPORT_HALF_25G_RATE;
> +	}
> +
> +	dport.cir = rate;
> +	dport.pir = rate;
> +	dport.depth = max(dport.cir * 2, NBL_LR_LEONIS_NET_BUCKET_DEPTH);
> +	dport.cbs = dport.depth;
> +	dport.pbs = dport.depth;
> +	dport.valid = 1;
> +
> +	dvn_dport.cir = half_rate;
> +	dvn_dport.pir = rate;
> +	dvn_dport.depth = dport.depth;
> +	dvn_dport.cbs = dvn_dport.depth;
> +	dvn_dport.pbs = dvn_dport.depth;
> +	dvn_dport.valid = 1;
> +
> +	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), (u32 *)&dport,
> +		       sizeof(dport));
> +	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
> +		       (u32 *)&dvn_dport, sizeof(dvn_dport));
> +}
> +
> +static int nbl_shaping_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
> +{
> +#define NBL_SHAPING_FLUSH_INTERVAL 128
> +	struct nbl_shaping_net net_shaping = { 0 };
> +	struct dsch_psha_en psha_en = { 0 };
> +	int i;
> +
> +	for (i = 0; i < NBL_MAX_ETHERNET; i++)
> +		nbl_shaping_eth_init(hw_mgt, i, speed);
> +
> +	psha_en.en = 0xF;
> +	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, (u32 *)&psha_en,
> +		       sizeof(psha_en));
> +
> +	for (i = 0; i < NBL_MAX_FUNC; i++) {
> +		nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_NET_REG(i),
> +			       (u32 *)&net_shaping, sizeof(net_shaping));
> +		if ((i % NBL_SHAPING_FLUSH_INTERVAL) == 0)
> +			nbl_flush_writes(hw_mgt);
> +	}
> +	nbl_flush_writes(hw_mgt);
> +	return 0;
> +}
> +
> +static int nbl_dsch_qid_max_init(struct nbl_hw_mgt *hw_mgt)
> +{
> +	struct dsch_vn_quanta quanta = { 0 };
> +
> +	quanta.h_qua = NBL_HOST_QUANTA;
> +	quanta.e_qua = NBL_ECPU_QUANTA;
> +	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_QUANTA_ADDR, (u32 *)&quanta,
> +		       sizeof(quanta));
> +	nbl_hw_wr32(hw_mgt, NBL_DSCH_HOST_QID_MAX, NBL_MAX_QUEUE_ID);
> +
> +	nbl_hw_wr32(hw_mgt, NBL_DVN_ECPU_QUEUE_NUM, 0);
> +	nbl_hw_wr32(hw_mgt, NBL_UVN_ECPU_QUEUE_NUM, 0);
> +
> +	return 0;
> +}
> +
> +static int nbl_ustore_init(struct nbl_hw_mgt *hw_mgt, u8 eth_num)
> +{
> +	struct nbl_ustore_port_drop_th drop_th = { 0 };
> +	struct ustore_pkt_len pkt_len;
> +	int i;
> +
> +	nbl_hw_rd_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, (u32 *)&pkt_len,
> +		       sizeof(pkt_len));
> +	/* min arp packet length 42 (14 + 28) */
> +	pkt_len.min = 42;
> +	nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, (u32 *)&pkt_len,
> +		       sizeof(pkt_len));
> +
> +	drop_th.en = 1;
> +	if (eth_num == 1)
> +		drop_th.disc_th = NBL_USTORE_SIGNLE_ETH_DROP_TH;
> +	else if (eth_num == 2)
> +		drop_th.disc_th = NBL_USTORE_DUAL_ETH_DROP_TH;
> +	else
> +		drop_th.disc_th = NBL_USTORE_QUAD_ETH_DROP_TH;
> +
> +	for (i = 0; i < 4; i++)
> +		nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PORT_DROP_TH_REG_ARR(i),
> +			       (u32 *)&drop_th, sizeof(drop_th));
> +
> +	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
> +		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_DROP_PKT(i));
> +		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_TRUN_PKT(i));
> +	}
> +
> +	return 0;
> +}
> +
> +static int nbl_dstore_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
> +{
> +	struct dstore_port_drop_th drop_th;
> +	struct dstore_d_dport_fc_th fc_th;
> +	struct dstore_disc_bp_th bp_th;
> +	int i;
> +
> +	for (i = 0; i < 6; i++) {
> +		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i),
> +			       (u32 *)&drop_th, sizeof(drop_th));
> +		drop_th.en = 0;
> +		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i),
> +			       (u32 *)&drop_th, sizeof(drop_th));
> +	}
> +
> +	nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, (u32 *)&bp_th,
> +		       sizeof(bp_th));
> +	bp_th.en = 1;
> +	nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, (u32 *)&bp_th,
> +		       sizeof(bp_th));
> +
> +	for (i = 0; i < 4; i++) {
> +		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i),
> +			       (u32 *)&fc_th, sizeof(fc_th));
> +		if (speed == NBL_FW_PORT_SPEED_100G) {
> +			fc_th.xoff_th = NBL_DSTORE_DROP_XOFF_TH_100G;
> +			fc_th.xon_th = NBL_DSTORE_DROP_XON_TH_100G;
> +		} else {
> +			fc_th.xoff_th = NBL_DSTORE_DROP_XOFF_TH;
> +			fc_th.xon_th = NBL_DSTORE_DROP_XON_TH;
> +		}
> +
> +		fc_th.fc_en = 1;
> +		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i),
> +			       (u32 *)&fc_th, sizeof(fc_th));
> +	}
> +
> +	return 0;
> +}
> +
> +static void nbl_dvn_descreq_num_cfg(struct nbl_hw_mgt *hw_mgt, u32 descreq_num)
> +{
> +	u32 split_ring_prefect_num = (descreq_num >> 16) & 0xffff;
> +	u32 packet_ring_prefect_num = descreq_num & 0xffff;
> +	struct nbl_dvn_descreq_num_cfg num_cfg = { 0 };
> +
> +	packet_ring_prefect_num =
> +		packet_ring_prefect_num > 32 ? 32 : packet_ring_prefect_num;
> +	packet_ring_prefect_num =
> +		packet_ring_prefect_num < 8 ? 8 : packet_ring_prefect_num;
> +	num_cfg.packed_l1_num = (packet_ring_prefect_num - 8) / 4;
> +
> +	split_ring_prefect_num =
> +		split_ring_prefect_num > 16 ? 16 : split_ring_prefect_num;
> +	split_ring_prefect_num =
> +		split_ring_prefect_num < 8 ? 8 : split_ring_prefect_num;
> +	num_cfg.avring_cfg_num = split_ring_prefect_num > 8 ? 1 : 0;

Minor nit: prefer human readable macro names to magic numbers (8, 16, 32
above).

/P


