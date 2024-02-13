Return-Path: <netdev+bounces-71286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88DD852F04
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D27EB230D7
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B6D381B8;
	Tue, 13 Feb 2024 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRsFNMxL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80607374F6
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823264; cv=none; b=XgNJ7XEyIPRP3zuAD959u7s2oCPNZD61V1M5al1LM3A3JG6lYZIJTyXkyNmiySP5IazU/+DIdXnj6C6ug4QF+JyJzaQoNRHFrYSI1uBG6MabRUKo8xg5pPq86VAs3TEyfZdw/G6RGFMzyxUuYeX47cLZ2KkPYmHLAQ6UM/WoHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823264; c=relaxed/simple;
	bh=3HRPfOimVqM1Rh5p3Z9t5SgpQ3SHT2n8myJf3l/Z13g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiq2Zv5c9kbo0wwkIk5oOnEujJ4DAUJixZc588il6nJY9GX1u0b9eRCT4w1WSL8yGwZTNRxd8jgeosx3Mnx5JZJnPtyCdsimJGFNkswo0L2FgDmSxC5+ewunakkDuUknFb3fFESxpNm+i7C3WyJwHV/mLs76+8bhTt+sFgHKgDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRsFNMxL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707823261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uIyqxHEVUrqVVB3R9NvpKjO7s51nQEsl1Za4PDo+APA=;
	b=eRsFNMxLwotN6qdFo3NwfhiwWb2Wu690iTyxg7KOOLMmZCWq3iXwIF75a7M5/EngpxOOFi
	r4M8Nqh8jrdP7YJq3cnc+jFAlOsNbprX2SsRnn3xhwVDZkNMoLmZyBYaFwsdMT3wsBOY/b
	4CiNdbT1j6UEDMNmRoax6CLieTZ4Ndc=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-gC_upk55Or-4EPmkuXJniQ-1; Tue, 13 Feb 2024 06:21:00 -0500
X-MC-Unique: gC_upk55Or-4EPmkuXJniQ-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7ce18fc04d1so1089095241.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 03:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823259; x=1708428059;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uIyqxHEVUrqVVB3R9NvpKjO7s51nQEsl1Za4PDo+APA=;
        b=fYlhhKjZTQPsU4pWQFujVTvm/3eZQ0ILONVOWclYR5ofrrxJ+4o7nL5PKKc99TZFMh
         j+b0coA55oOA1R/WcUDq3ZIQfapQaHzJ27IDgbtWvyX1CdXi2sn6IwtFYcos261fqy6M
         n/947+0bOnshh0aG8gtWtCGH752szs1DT+PM7oGOV/kRs8reqrv+3Q/JIgOWC5zjnxRR
         NWUJpmW5Fx0abxJLGT2XM4HufZGvPu962D4arcV9uquHGID+YlNQPaUzheNDN84hhV7e
         3y7gezuXQQ1HUCYLDXKBRRdParHGM3YdIuvZ6vl7NmXgPl0y4vFPKiZ9PYbGKbFRZ/pU
         e9sA==
X-Forwarded-Encrypted: i=1; AJvYcCV1MZlxWiAuZHhgUQucZLVjlewKXzKHlN3fzewbuOr8e+EQfnp4FDYOeZqNSJRZ8De1H+QHCUvXAqMVimRnBmy+C2TyT+9B
X-Gm-Message-State: AOJu0Yz/E5Rej4INvwymNS8AFJyytO/b0n+cvj5CgShKLM3ORBvT3rEF
	5FTlhWOsK1dZkETsB+Kna8aSuNDc7eEkzehyDFc0Iolkb7VFk5FHGKwSN91s9W5MqBjetLh6zdF
	tTiNXA8RBZ+6onbSfjHg6NClVJ94TeLICjhVj6dxGv/Y2hOcju9eCXA==
X-Received: by 2002:a05:6122:c83:b0:4c0:3b06:9a3b with SMTP id ba3-20020a0561220c8300b004c03b069a3bmr5120616vkb.0.1707823259415;
        Tue, 13 Feb 2024 03:20:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjQfCmKSDOtnshmCrlR/k01we4cNabIFz4i7NXoaxXgmmqvMjfb6GrNL8yMsdAzpY+omYOPg==
X-Received: by 2002:a05:6122:c83:b0:4c0:3b06:9a3b with SMTP id ba3-20020a0561220c8300b004c03b069a3bmr5120608vkb.0.1707823259005;
        Tue, 13 Feb 2024 03:20:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUc+nJ+M2eh/U2FIQIwDoR01AE2Lw6RawHHk+D978epgyCnKvioSHAjgqQOEqVJnl31cbPhYLVntk+bHu+QMIuQTncocruEJKXxtkQrj20ZvtNGASPdNef2LBR0zazz6kXjKD1Gt+PYvpHoXkrc+lJC8809ZnwYDcJ/3RslaxA3pW8LkhvvpNUGaq8H2Hz4goqkMBg6ipA=
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id pd4-20020a056214490400b0068ce843171csm632645qvb.42.2024.02.13.03.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:20:58 -0800 (PST)
Message-ID: <e8b9b82644de7acbe7a7f8059d17ed7908f3df17.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 4/9] ionic: add initial framework for XDP
 support
From: Paolo Abeni <pabeni@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com
Cc: brett.creeley@amd.com, drivers@pensando.io
Date: Tue, 13 Feb 2024 12:20:56 +0100
In-Reply-To: <20240210004827.53814-5-shannon.nelson@amd.com>
References: <20240210004827.53814-1-shannon.nelson@amd.com>
	 <20240210004827.53814-5-shannon.nelson@amd.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-09 at 16:48 -0800, Shannon Nelson wrote:
[...]
> +static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned i=
nt napi_id)
> +{
> +	struct xdp_rxq_info *rxq_info;
> +	int err;
> +
> +	rxq_info =3D kzalloc(sizeof(*rxq_info), GFP_KERNEL);
> +	if (!rxq_info)
> +		return -ENOMEM;
> +
> +	err =3D xdp_rxq_info_reg(rxq_info, q->lif->netdev, q->index, napi_id);
> +	if (err) {
> +		dev_err(q->dev, "Queue %d xdp_rxq_info_reg failed, err %d\n",
> +			q->index, err);

You can avoid some little code duplication with the usual
		goto err;

//...
err:
	kfree(rxq_info);
	return err;

> +		kfree(rxq_info);
> +		return err;
> +	}
> +
> +	err =3D xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_ORDER0, NULL=
);
> +	if (err) {
> +		dev_err(q->dev, "Queue %d xdp_rxq_info_reg_mem_model failed, err %d\n"=
,
> +			q->index, err);
> +		xdp_rxq_info_unreg(rxq_info);

and using the same label here.

> +		kfree(rxq_info);
> +		return err;
> +	}
> +
> +	q->xdp_rxq_info =3D rxq_info;
> +
> +	return 0;
> +}
> +
> +static int ionic_xdp_queues_config(struct ionic_lif *lif)
> +{
> +	unsigned int i;
> +	int err;
> +
> +	if (!lif->rxqcqs)
> +		return 0;
> +
> +	/* There's no need to rework memory if not going to/from NULL program.
> +	 * If there is no lif->xdp_prog, there should also be no q.xdp_rxq_info
> +	 * This way we don't need to keep an *xdp_prog in every queue struct.
> +	 */
> +	if (!lif->xdp_prog =3D=3D !lif->rxqcqs[0]->q.xdp_rxq_info)
> +		return 0;
> +
> +	for (i =3D 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
> +		struct ionic_queue *q =3D &lif->rxqcqs[i]->q;
> +
> +		if (q->xdp_rxq_info) {
> +			ionic_xdp_unregister_rxq_info(q);

You can reduce the nesting level adding a 'continue' here:
			continue;
		}

		err =3D ionic_xdp_register_rxq_info(q, lif->rxqcqs[i]->napi.napi_id);
		// ...

> +		} else {
> +			err =3D ionic_xdp_register_rxq_info(q, lif->rxqcqs[i]->napi.napi_id);
> +			if (err) {
> +				dev_err(lif->ionic->dev, "failed to register RX queue %d info for XD=
P, err %d\n",
> +					i, err);
> +				goto err_out;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	for (i =3D 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++)
> +		ionic_xdp_unregister_rxq_info(&lif->rxqcqs[i]->q);
> +
> +	return err;
> +}
> +
> +static int ionic_xdp_config(struct net_device *netdev, struct netdev_bpf=
 *bpf)
> +{
> +	struct ionic_lif *lif =3D netdev_priv(netdev);
> +	struct bpf_prog *old_prog;
> +	u32 maxfs;
> +
> +	if (test_bit(IONIC_LIF_F_SPLIT_INTR, lif->state)) {
> +#define XDP_ERR_SPLIT "XDP not available with split Tx/Rx interrupts"
> +		NL_SET_ERR_MSG_MOD(bpf->extack, XDP_ERR_SPLIT);
> +		netdev_info(lif->netdev, XDP_ERR_SPLIT);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!ionic_xdp_is_valid_mtu(lif, netdev->mtu, bpf->prog)) {
> +#define XDP_ERR_MTU "MTU is too large for XDP without frags support"
> +		NL_SET_ERR_MSG_MOD(bpf->extack, XDP_ERR_MTU);
> +		netdev_info(lif->netdev, XDP_ERR_MTU);
> +		return -EINVAL;
> +	}
> +
> +	maxfs =3D __le32_to_cpu(lif->identity->eth.max_frame_size) - VLAN_ETH_H=
LEN;
> +	if (bpf->prog)
> +		maxfs =3D min_t(u32, maxfs, IONIC_XDP_MAX_LINEAR_MTU);
> +	netdev->max_mtu =3D maxfs;
> +
> +	if (!netif_running(netdev)) {
> +		old_prog =3D xchg(&lif->xdp_prog, bpf->prog);
> +	} else {
> +		mutex_lock(&lif->queue_lock);
> +		ionic_stop_queues_reconfig(lif);
> +		old_prog =3D xchg(&lif->xdp_prog, bpf->prog);
> +		ionic_start_queues_reconfig(lif);
> +		mutex_unlock(&lif->queue_lock);
> +	}
> +
> +	if (old_prog)
> +		bpf_prog_put(old_prog);
> +
> +	return 0;
> +}
> +
> +static int ionic_xdp(struct net_device *netdev, struct netdev_bpf *bpf)
> +{
> +	switch (bpf->command) {
> +	case XDP_SETUP_PROG:
> +		return ionic_xdp_config(netdev, bpf);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct net_device_ops ionic_netdev_ops =3D {
>  	.ndo_open               =3D ionic_open,
>  	.ndo_stop               =3D ionic_stop,
>  	.ndo_eth_ioctl		=3D ionic_eth_ioctl,
>  	.ndo_start_xmit		=3D ionic_start_xmit,
> +	.ndo_bpf		=3D ionic_xdp,
>  	.ndo_get_stats64	=3D ionic_get_stats64,
>  	.ndo_set_rx_mode	=3D ionic_ndo_set_rx_mode,
>  	.ndo_set_features	=3D ionic_set_features,
> @@ -2755,6 +2922,7 @@ static void ionic_swap_queues(struct ionic_qcq *a, =
struct ionic_qcq *b)
>  	swap(a->q.base,       b->q.base);
>  	swap(a->q.base_pa,    b->q.base_pa);
>  	swap(a->q.info,       b->q.info);
> +	swap(a->q.xdp_rxq_info, b->q.xdp_rxq_info);
>  	swap(a->q_base,       b->q_base);
>  	swap(a->q_base_pa,    b->q_base_pa);
>  	swap(a->q_size,       b->q_size);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/ne=
t/ethernet/pensando/ionic/ionic_lif.h
> index 61548b3eea93..61fa4ea4f04c 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
> @@ -51,6 +51,9 @@ struct ionic_rx_stats {
>  	u64 alloc_err;
>  	u64 hwstamp_valid;
>  	u64 hwstamp_invalid;
> +	u64 xdp_drop;
> +	u64 xdp_aborted;
> +	u64 xdp_pass;
>  };
> =20
>  #define IONIC_QCQ_F_INITED		BIT(0)
> @@ -135,6 +138,9 @@ struct ionic_lif_sw_stats {
>  	u64 hw_rx_over_errors;
>  	u64 hw_rx_missed_errors;
>  	u64 hw_tx_aborted_errors;
> +	u64 xdp_drop;
> +	u64 xdp_aborted;
> +	u64 xdp_pass;
>  };
> =20
>  enum ionic_lif_state_flags {
> @@ -230,6 +236,7 @@ struct ionic_lif {
>  	struct ionic_phc *phc;
> =20
>  	struct dentry *dentry;
> +	struct bpf_prog *xdp_prog;
>  };
> =20
>  struct ionic_phc {
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/=
net/ethernet/pensando/ionic/ionic_stats.c
> index 1f6022fb7679..2fb20173b2c6 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
> @@ -27,6 +27,9 @@ static const struct ionic_stat_desc ionic_lif_stats_des=
c[] =3D {
>  	IONIC_LIF_STAT_DESC(hw_rx_over_errors),
>  	IONIC_LIF_STAT_DESC(hw_rx_missed_errors),
>  	IONIC_LIF_STAT_DESC(hw_tx_aborted_errors),
> +	IONIC_LIF_STAT_DESC(xdp_drop),
> +	IONIC_LIF_STAT_DESC(xdp_aborted),
> +	IONIC_LIF_STAT_DESC(xdp_pass),
>  };
> =20
>  static const struct ionic_stat_desc ionic_port_stats_desc[] =3D {
> @@ -149,6 +152,9 @@ static const struct ionic_stat_desc ionic_rx_stats_de=
sc[] =3D {
>  	IONIC_RX_STAT_DESC(hwstamp_invalid),
>  	IONIC_RX_STAT_DESC(dropped),
>  	IONIC_RX_STAT_DESC(vlan_stripped),
> +	IONIC_RX_STAT_DESC(xdp_drop),
> +	IONIC_RX_STAT_DESC(xdp_aborted),
> +	IONIC_RX_STAT_DESC(xdp_pass),
>  };
> =20
>  #define IONIC_NUM_LIF_STATS ARRAY_SIZE(ionic_lif_stats_desc)
> @@ -185,6 +191,9 @@ static void ionic_add_lif_rxq_stats(struct ionic_lif =
*lif, int q_num,
>  	stats->rx_csum_error +=3D rxstats->csum_error;
>  	stats->rx_hwstamp_valid +=3D rxstats->hwstamp_valid;
>  	stats->rx_hwstamp_invalid +=3D rxstats->hwstamp_invalid;
> +	stats->xdp_drop +=3D rxstats->xdp_drop;
> +	stats->xdp_aborted +=3D rxstats->xdp_aborted;
> +	stats->xdp_pass +=3D rxstats->xdp_pass;
>  }
> =20
>  static void ionic_get_lif_stats(struct ionic_lif *lif,
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/n=
et/ethernet/pensando/ionic/ionic_txrx.c
> index aee38979a9d7..07a17be94d4d 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
> @@ -177,7 +177,7 @@ static bool ionic_rx_buf_recycle(struct ionic_queue *=
q,
>  	if (page_to_nid(buf_info->page) !=3D numa_mem_id())
>  		return false;
> =20
> -	size =3D ALIGN(used, IONIC_PAGE_SPLIT_SZ);
> +	size =3D ALIGN(used, q->xdp_rxq_info ? IONIC_PAGE_SIZE : IONIC_PAGE_SPL=
IT_SZ);
>  	buf_info->page_offset +=3D size;
>  	if (buf_info->page_offset >=3D IONIC_PAGE_SIZE)
>  		return false;
> @@ -287,6 +287,54 @@ static struct sk_buff *ionic_rx_copybreak(struct ion=
ic_queue *q,
>  	return skb;
>  }
> =20
> +static bool ionic_run_xdp(struct ionic_rx_stats *stats,
> +			  struct net_device *netdev,
> +			  struct ionic_queue *rxq,
> +			  struct ionic_buf_info *buf_info,
> +			  int len)
> +{
> +	u32 xdp_action =3D XDP_ABORTED;
> +	struct bpf_prog *xdp_prog;
> +	struct xdp_buff xdp_buf;
> +
> +	xdp_prog =3D READ_ONCE(rxq->lif->xdp_prog);
> +	if (!xdp_prog)
> +		return false;
> +
> +	xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
> +	xdp_prepare_buff(&xdp_buf, ionic_rx_buf_va(buf_info),
> +			 0, len, false);
> +
> +	dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
> +				      0, len,
> +				      DMA_FROM_DEVICE);

in case of XDP_PASS the same buf will be synched twice ?!?=20

Cheers,

Paolo


