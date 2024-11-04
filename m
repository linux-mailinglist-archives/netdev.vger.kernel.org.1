Return-Path: <netdev+bounces-141615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED919BBCDE
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E24B211B3
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7A11C75EB;
	Mon,  4 Nov 2024 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tw2NzOch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921C7224F0
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743764; cv=none; b=Jjue2fVQh+DQjWkJUL5ODk7CAmOFcSqolkmgrDh7TpFoD6I+i5QECoNkUBk2ATRhBwswEigS2RCwzFOmghtPe+WSbbic2FBzsF4vML+jhFOgW6vDWu7UhSFKlgS9MDq3+MoSjhQMgP5rG7hzzR3HdKKu4o1GnM6WlDkNvsOwOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743764; c=relaxed/simple;
	bh=7fno4xA9s4diq0R6Efp6P5LyDgiFTpYMkefMEnHNwXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvB9MKyQ1OCW54c1m/IR1AkxRm9MimqHwx1cm5P9+UPE96fQe344jcKPQTy7b3gNwDZhYV16i2VVfMKLmVb7QM+P6BCCCQx+uGHaJjpZtKHFru/LsyVpgqFQkRAWP/dy15oEn3j5/XobSlQ3Wn1EXlnoo1nWZEwAOCY6CvkQOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tw2NzOch; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c714cd9c8so45971715ad.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 10:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730743762; x=1731348562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbKmIqLpWGgO6atOsrXs70SXAENYfKKC4XlNk/KA5yc=;
        b=tw2NzOchTu+z9r91l8w9pTx1D++k2GyG7S2HzLgAkNK+r4Rz8XED/ze/NQ7OskKCtl
         N8LysdBCMhOF5DqCHORmi7Rhayd4VR7+Vu9sdYjkTIuyfXVB9lEKvlt93GKAgerK5dbm
         Zs80A2AC9HqlsiMuPjq/pQCShGZUPeYHyTQQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730743762; x=1731348562;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbKmIqLpWGgO6atOsrXs70SXAENYfKKC4XlNk/KA5yc=;
        b=UVifEvMd5eEig1hSAM44a3YbRSWLl18KYlyZSbZTyJLft0PfxJHng2/8NPV9lNvPdr
         7NkdyKdX8FaitOCJYRk7lDKOnrtx3K4Dj4GJvWe2R95fs9c+Cim6kW2chXiwbRH6qEk2
         g0YEgwMYg4Sm5SZ0VwSIcTQ5IqLktqXz4NN5xdv/bhomunI5bXyqpeiFQnUbrJIChiZ/
         UUeR49SdL3Nic6F1Tpx0iHFgg5t1POQHWBrfKquAZXR53Ue6tCCb/d1MT9HNkgq9DCu7
         OtIWlfTYxPUH8mn2O0ZqGuH0LUUlWXbdiGrqHUN1NNkxykp3ILEeRNDgmua2yNMqfpQZ
         y9uA==
X-Gm-Message-State: AOJu0YzKmUY5kZAScT+tWBt0zQ+WeVsdXFZYzrSupQ+ptHiTB2KXoa2x
	0TsZl4dC9q3BDLqCU/SpkuNwf0bBmNIHoi+vFMRxezdRyYzRyQbs2CQGYfjlp1U=
X-Google-Smtp-Source: AGHT+IHWkl6i5dZPn4DNoi9+ipc6zh9LM3yX/auN1cqhvIZ/nOjoUOEJrAUMTupWTbw/TNCF8tw+Ag==
X-Received: by 2002:a17:902:e5c9:b0:20c:8f78:67be with SMTP id d9443c01a7336-2111afd698emr173776165ad.40.1730743761677;
        Mon, 04 Nov 2024 10:09:21 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452b1643sm7394155a12.38.2024.11.04.10.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:09:21 -0800 (PST)
Date: Mon, 4 Nov 2024 10:09:18 -0800
From: Joe Damato <jdamato@fastly.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, kernel-team@meta.com,
	sanmanpradhan@meta.com, sdf@fomichev.me, vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: Re: [PATCH net-next v5] eth: fbnic: Add support to write TCE TCAM
 entries
Message-ID: <ZykNzvV3d5SXe7Yn@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kuba@kernel.org, andrew@lunn.ch,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
	sdf@fomichev.me, vadim.fedorenko@linux.dev, horms@kernel.org
References: <20241104031300.1330657-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104031300.1330657-1-mohsin.bashr@gmail.com>

Feel free to take my review with a large grain of salt as I am not
as experienced as others on this with giving good reviews, but I
left a few comments you may want to consider below:

On Sun, Nov 03, 2024 at 07:13:00PM -0800, Mohsin Bashir wrote:
> Add support to redirect host-to-BMC traffic by writing MACDA entries
> from the RPC (RX Parser and Classifier) to TCE-TCAM. The TCE TCAM is a
> small L2 destination TCAM which is placed at the end of the TX path (TCE).
> 
> Unlike other NICs, where BMC diversion is typically handled by firmware,
> for fbnic, firmware does not touch anything related to the host; hence,
> the host uses TCE TCAM to divert BMC traffic.
> 
> Currently, we lack metadata to track where addresses have been written
> in the TCAM, except for the last entry written. To address this issue,
> we start at the opposite end of the table in each pass, so that adding
> or deleting entries does not affect the availability of all entries,
> assuming there is no significant reordering of entries.
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
> V5: Add sign off at the right place
> V4: https://lore.kernel.org/netdev/20241101204116.1368328-1-mohsin.bashr@gmail.com
> V3: https://lore.kernel.org/netdev/20241025225910.30187-1-mohsin.bashr@gmail.com
> V2: https://lore.kernel.org/netdev/20241024223135.310733-1-mohsin.bashr@gmail.com
> V1: https://lore.kernel.org/netdev/20241021185544.713305-1-mohsin.bashr@gmail.com
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  20 ++++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   1 +
>  drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   | 110 ++++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |   4 +
>  5 files changed, 136 insertions(+)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index fec567c8fe4a..9f9cb9b3e74e 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -48,6 +48,7 @@ struct fbnic_dev {
>  	struct fbnic_act_tcam act_tcam[FBNIC_RPC_TCAM_ACT_NUM_ENTRIES];
>  	struct fbnic_mac_addr mac_addr[FBNIC_RPC_TCAM_MACDA_NUM_ENTRIES];
>  	u8 mac_addr_boundary;
> +	u8 tce_tcam_last;
>  
>  	/* Number of TCQs/RCQs available on hardware */
>  	u16 max_num_queues;
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> index 79cdd231d327..dd407089ca47 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> @@ -397,6 +397,14 @@ enum {
>  #define FBNIC_TCE_DROP_CTRL_TTI_FRM_DROP_EN	CSR_BIT(1)
>  #define FBNIC_TCE_DROP_CTRL_TTI_TBI_DROP_EN	CSR_BIT(2)
>  
> +#define FBNIC_TCE_TCAM_IDX2DEST_MAP	0x0404A		/* 0x10128 */
> +#define FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_0	CSR_GENMASK(3, 0)
> +enum {
> +	FBNIC_TCE_TCAM_DEST_MAC		= 1,
> +	FBNIC_TCE_TCAM_DEST_BMC		= 2,
> +	FBNIC_TCE_TCAM_DEST_FW		= 4,
> +};
> +
>  #define FBNIC_TCE_TXB_TX_BMC_Q_CTRL	0x0404B		/* 0x1012c */
>  #define FBNIC_TCE_TXB_BMC_DWRR_CTRL	0x0404C		/* 0x10130 */
>  #define FBNIC_TCE_TXB_BMC_DWRR_CTRL_QUANTUM0	CSR_GENMASK(7, 0)
> @@ -407,6 +415,18 @@ enum {
>  #define FBNIC_TCE_TXB_BMC_DWRR_CTRL_EXT	0x0404F		/* 0x1013c */
>  #define FBNIC_CSR_END_TCE		0x04050	/* CSR section delimiter */
>  
> +/* TCE RAM registers */
> +#define FBNIC_CSR_START_TCE_RAM		0x04200	/* CSR section delimiter */
> +#define FBNIC_TCE_RAM_TCAM(m, n) \
> +	(0x04200 + 0x8 * (n) + (m))		/* 0x10800 + 32*n + 4*m */

Is the 0x04200 here FBNIC_CSR_START_TCE_RAM ? If so, maybe it can be
replaced with define?

Does the macro need to be on its own line? Maybe it does due to line
length, not sure.

[...]

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index c08798fad203..fc7d80db5fa6 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -273,6 +273,7 @@ void __fbnic_set_rx_mode(struct net_device *netdev)
>  	/* Write updates to hardware */
>  	fbnic_write_rules(fbd);
>  	fbnic_write_macda(fbd);
> +	fbnic_write_tce_tcam(fbd);
>  }
>  
>  static void fbnic_set_rx_mode(struct net_device *netdev)
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> index 337b8b3aef2f..908c098cd59e 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> @@ -587,6 +587,116 @@ static void fbnic_clear_act_tcam(struct fbnic_dev *fbd, unsigned int idx)
>  		wr32(fbd, FBNIC_RPC_TCAM_ACT(idx, i), 0);
>  }
>  
> +static void fbnic_clear_tce_tcam_entry(struct fbnic_dev *fbd, unsigned int idx)
> +{
> +	int i;
> +
> +	/* Invalidate entry and clear addr state info */
> +	for (i = 0; i <= FBNIC_TCE_TCAM_WORD_LEN; i++)
> +		wr32(fbd, FBNIC_TCE_RAM_TCAM(idx, i), 0);
> +}
> +
> +static void fbnic_write_tce_tcam_dest(struct fbnic_dev *fbd, unsigned int idx,
> +				      struct fbnic_mac_addr *mac_addr)
> +{
> +	u32 dest = FBNIC_TCE_TCAM_DEST_BMC;
> +	u32 idx2dest_map;
> +
> +	if (is_multicast_ether_addr(mac_addr->value.addr8))
> +		dest |= FBNIC_TCE_TCAM_DEST_MAC;
> +
> +	idx2dest_map = rd32(fbd, FBNIC_TCE_TCAM_IDX2DEST_MAP);
> +	idx2dest_map &= ~(FBNIC_TCE_TCAM_IDX2DEST_MAP_DEST_ID_0 << (4 * idx));
> +	idx2dest_map |= dest << (4 * idx);
> +
> +	wr32(fbd, FBNIC_TCE_TCAM_IDX2DEST_MAP, idx2dest_map);
> +}
> +
> +static void fbnic_write_tce_tcam_entry(struct fbnic_dev *fbd, unsigned int idx,
> +				       struct fbnic_mac_addr *mac_addr)
> +{
> +	__be16 *mask, *value;
> +	int i;
> +
> +	mask = &mac_addr->mask.addr16[FBNIC_TCE_TCAM_WORD_LEN - 1];
> +	value = &mac_addr->value.addr16[FBNIC_TCE_TCAM_WORD_LEN - 1];
> +
> +	for (i = 0; i < FBNIC_TCE_TCAM_WORD_LEN; i++)
> +		wr32(fbd, FBNIC_TCE_RAM_TCAM(idx, i),
> +		     FIELD_PREP(FBNIC_TCE_RAM_TCAM_MASK, ntohs(*mask--)) |
> +		     FIELD_PREP(FBNIC_TCE_RAM_TCAM_VALUE, ntohs(*value--)));
> +
> +	wrfl(fbd);
> +
> +	wr32(fbd, FBNIC_TCE_RAM_TCAM3(idx), FBNIC_TCE_RAM_TCAM3_MCQ_MASK |
> +				       FBNIC_TCE_RAM_TCAM3_DEST_MASK |
> +				       FBNIC_TCE_RAM_TCAM3_VALIDATE);
> +}
> +
> +static void __fbnic_write_tce_tcam_rev(struct fbnic_dev *fbd)
> +{
> +	int tcam_idx = FBNIC_TCE_TCAM_NUM_ENTRIES;
> +	int mac_idx;
> +
> +	for (mac_idx = ARRAY_SIZE(fbd->mac_addr); mac_idx--;) {

This is probably not a kernel / networking cosmetic thing and
probably just me, but I personally find this style of for loop quite
odd where one field is elided.

Maybe a while loop could be used instead and it'd be easier to read?

int mac_idex = ARRAY_SIZE(fbd->mac_addr);

while (mac_idx--) { ...

> +		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[mac_idx];
> +
> +		/* Verify BMC bit is set */
> +		if (!test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam))
> +			continue;
> +
> +		if (!tcam_idx) {
> +			dev_err(fbd->dev, "TCE TCAM overflow\n");

In the error case does fbd->tce_tcam_last need to be set ?

> +			return;
> +		}
> +
> +		tcam_idx--;
> +		fbnic_write_tce_tcam_dest(fbd, tcam_idx, mac_addr);
> +		fbnic_write_tce_tcam_entry(fbd, tcam_idx, mac_addr);
> +	}
> +
> +	while (tcam_idx)
> +		fbnic_clear_tce_tcam_entry(fbd, --tcam_idx);
> +
> +	fbd->tce_tcam_last = tcam_idx;

Wouldn't this end up setting tce_tcam_last to zero every time or am
I missing something?

> +}
> +
> +static void __fbnic_write_tce_tcam(struct fbnic_dev *fbd)
> +{
> +	int tcam_idx = 0;
> +	int mac_idx;
> +
> +	for (mac_idx = 0; mac_idx < ARRAY_SIZE(fbd->mac_addr); mac_idx++) {
> +		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[mac_idx];
> +
> +		/* Verify BMC bit is set */
> +		if (!test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam))
> +			continue;
> +
> +		if (tcam_idx == FBNIC_TCE_TCAM_NUM_ENTRIES) {
> +			dev_err(fbd->dev, "TCE TCAM overflow\n");

As above, in the error case does fbd->tce_tcam_last need to be set ?

> +			return;
> +		}
> +
> +		fbnic_write_tce_tcam_dest(fbd, tcam_idx, mac_addr);
> +		fbnic_write_tce_tcam_entry(fbd, tcam_idx, mac_addr);
> +		tcam_idx++;
> +	}
> +
> +	while (tcam_idx < FBNIC_TCE_TCAM_NUM_ENTRIES)
> +		fbnic_clear_tce_tcam_entry(fbd, tcam_idx++);
> +
> +	fbd->tce_tcam_last = tcam_idx;

As above, wouldn't this always set tce_tcam_last to
FBNIC_TCE_TCAM_NUM_ENTRIES every time?

Sorry if I'm missing something here.

> +}

