Return-Path: <netdev+bounces-124545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CE7969F12
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BC128665F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DB1CA69D;
	Tue,  3 Sep 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2GVUHuC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756123D7
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370302; cv=none; b=ZJCYjz9fEO1BJe7+N0mC0wWl71wdiPFGFu5kDk6rInJC3Wq7C8xs7E4Jj7r6ZtQPpX3cb8KW2iGdiazHkJIG9YLh+AJHb90egxUGFz5yieIIAEgELtR1uuRutba0NuZ36ZnZ4cFzWVE0ZKMPHCf8br0rdsLojpCVvudO+pHs9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370302; c=relaxed/simple;
	bh=T4fDoJoecViVmQNPo2yZrHSz6QgMk+lBYHN95sXQCDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoPrYp3LLs4A/HzVL8GRjd9mx1x6F7sxiPBZvDJPPDQK6B/utkuePsbEfCg1AYju7LnAuoMkm6rJDWju1GKRW4AFlg7tIquLN7DMSNh+D4tfZ+DYabLwvTNcnxbYRKTNVwavEGA7gwot+4SucLybnLKuN/sq8eqqIgxn/26iuUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2GVUHuC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725370298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TT0mRqhaXKCd2CqytOnVTAv17c3Kp2T7BKqKGi1Nz7Q=;
	b=V2GVUHuCWv+ptEVuB8HsKgnVnowIwE0F7sVrfuiPfWymKaVfKqtpQhztvBGIgP833cZ9xK
	agFlT8biZzMJQvtx160t8J3ZnHindVcefK9Cw5eZsU9Aa062Qt+Uo9GTtWGHFmDINHTIjZ
	pd5tAEmOZDm3Pfuy1NyIIvR4kj/T9qw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-fcoJsJo4Nb2_G771Ta1T8w-1; Tue, 03 Sep 2024 09:31:37 -0400
X-MC-Unique: fcoJsJo4Nb2_G771Ta1T8w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb5950d1aso60589335e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 06:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725370296; x=1725975096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TT0mRqhaXKCd2CqytOnVTAv17c3Kp2T7BKqKGi1Nz7Q=;
        b=VUj49ED4IDbgsor18GFoNLSpo4m6ukVLUoxfmZaBIebl4hEin8RBMVvGo6S4YjsMor
         zW1NKL9hZHuXaPP2DlMlIqkHJ9LkylLj3aakD5dBBtcbLY4t9PwR7V3t4W9TciFmxPLd
         Au0xnN81bNFr19AdRPKbrfKOSO1N2dPmHK3qzQosw8D+gp8SjgGKWU2VCNonCAb9InRA
         rWVIxfXsaAnF6AQCkZftQVVijo1WHFYJ7VpF6DyHAZi3swr3MG4arbBye6+AgvexyEEp
         KfbQ/XccZO3U1SIbP3LgqMeXUAk9cc9Me55mmFuwkdjW+tlJREMEzu7+tfdNi0xEnN9k
         kmyA==
X-Forwarded-Encrypted: i=1; AJvYcCVNu+0Npro/VUTmk1njUbCxNgPVBt8P/k96zBlszvXzeN56SYOHejwLOQ1apf51NO4CLREetV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmyR4mOgp0tlhavjxzKDcjkzj5QAkncpLAO8HdjGHUbsSTWiPs
	6CRAD0x78fPtjDwGgvUDlHsAoTgbJGiCi48ng4RsGdOrHaHIEubwgiwWrLxrydUL50GU9HWIJaD
	6OwxKM7htAUyj+i8uT17hkRB8SzRS10qUnca0NdO1VPoxoPV0k4Qnxw==
X-Received: by 2002:a05:6000:1543:b0:374:d29e:6db8 with SMTP id ffacd0b85a97d-374d29e6e46mr3758614f8f.16.1725370295655;
        Tue, 03 Sep 2024 06:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqsEsAzk28PCAKiuT1J68bc+3njl09O+FreZRAVr0nLTh3+4A6lAl/kcqqbuaWg6B53QFsug==
X-Received: by 2002:a05:6000:1543:b0:374:d29e:6db8 with SMTP id ffacd0b85a97d-374d29e6e46mr3758540f8f.16.1725370294504;
        Tue, 03 Sep 2024 06:31:34 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33b41sm171403835e9.40.2024.09.03.06.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 06:31:34 -0700 (PDT)
Message-ID: <2bc090db-7bc1-4810-80c7-61218fb49acf@redhat.com>
Date: Tue, 3 Sep 2024 15:31:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 net-next 06/11] net: hibmcge: Implement .ndo_start_xmit
 function
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830121604.2250904-1-shaojijie@huawei.com>
 <20240830121604.2250904-7-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240830121604.2250904-7-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 14:15, Jijie Shao wrote:
> +netdev_tx_t hbg_net_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
> +{
> +	struct hbg_ring *ring = netdev_get_tx_ring(net_dev);
> +	struct hbg_priv *priv = netdev_priv(net_dev);
> +	/* This smp_load_acquire() pairs with smp_store_release() in
> +	 * hbg_tx_buffer_recycle() called in tx interrupt handle process.
> +	 */
> +	u32 ntc = smp_load_acquire(&ring->ntc);
> +	struct hbg_buffer *buffer;
> +	struct hbg_tx_desc tx_desc;
> +	u32 ntu = ring->ntu;
> +
> +	if (unlikely(!hbg_nic_is_open(priv))) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	if (unlikely(!skb->len ||
> +		     skb->len > hbg_spec_max_frame_len(priv, HBG_DIR_TX))) {
> +		dev_kfree_skb_any(skb);
> +		net_dev->stats.tx_errors++;
> +		return NETDEV_TX_OK;
> +	}
> +
> +	if (unlikely(hbg_queue_is_full(ntc, ntu, ring) ||
> +		     hbg_fifo_is_full(ring->priv, ring->dir))) {
> +		netif_stop_queue(net_dev);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	buffer = &ring->queue[ntu];
> +	buffer->skb = skb;
> +	buffer->skb_len = skb->len;
> +	if (unlikely(hbg_dma_map(buffer))) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	buffer->state = HBG_TX_STATE_START;
> +	hbg_init_tx_desc(buffer, &tx_desc);
> +	hbg_hw_set_tx_desc(priv, &tx_desc);
> +
> +	/* This smp_store_release() pairs with smp_load_acquire() in
> +	 * hbg_tx_buffer_recycle() called in tx interrupt handle process.
> +	 */
> +	smp_store_release(&ring->ntu, hbg_queue_next_prt(ntu, ring));

Here you should probably check for netif_txq_maybe_stop()

> +	net_dev->stats.tx_bytes += skb->len;
> +	net_dev->stats.tx_packets++;

Try to avoid 'dev->stats' usage. Instead you could use per napi stats 
accounting (no contention).

Side note: 'net_dev' is quite an unusual variable name for a network device.

Cheers,

Paolo


