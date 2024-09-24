Return-Path: <netdev+bounces-129469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C109840E6
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA13B2080C
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11117770E5;
	Tue, 24 Sep 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvZM/fBi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A1182A0
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167568; cv=none; b=rr78bRY7mlQCxrA+pGb8DM00DXRx+NLGv3us4zJu427PgtedyImegJCYZc+JceM/qRDGeDkBjAFDBC2dN5B1L5bxuSbDO9Q+PUUe4yoHh9RLIGqYNiFajrmYW7poLC8zigW9kE41AsrtWYl/xOTb3Y+YPzlIk7xe0kAPmjgqjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167568; c=relaxed/simple;
	bh=qp/a/vQR5ClY7NjqLsvgXcavLMzhEkXYi5R3RbwLaeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+V4VXqGeWEcYCopDpB8ZdsYDwiR76L24kzdYcn2s5Avy9+O7sGxvxrhrCSltCztmnHuqA1J0+KKOltr7+sSBIAuRMHeQYlPbiI0UTQVM2eZaM5Ew3RxbN7GSl3uAzAxSIPmqPbt2Cgr2fw6c7B3C2hR0daUq8OO5msMuOPJh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvZM/fBi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727167565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PnCAWGz8PeZWF1X8+l5uBsiOi3BTXYC+xfyDwdBet4=;
	b=bvZM/fBi/vtt+/VMADQ2/SJmCwjgwpqb9HN1dklUdAc9G+XQRxmvkSKH7xxqnNKZHrA3Ir
	lOobYXj4GQSRnNnHLyKB1RIS8EaT/uux7/CmEVu1+9KujDkf1UdvE1CgTica+Si3Z2E1Mp
	1C8y71infOct5SpCzP3aAI2MZzTgOng=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-Q2uT2geQN5247I3L45SyYQ-1; Tue, 24 Sep 2024 04:46:02 -0400
X-MC-Unique: Q2uT2geQN5247I3L45SyYQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374beb23f35so2023873f8f.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 01:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727167562; x=1727772362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PnCAWGz8PeZWF1X8+l5uBsiOi3BTXYC+xfyDwdBet4=;
        b=dNEoG0FsO0dP4YiNOKm7QP6vyoNRI/cMjcaC2T23EFs4nZXBSUs5tKRsv8rpasCiqI
         hBPbil1ixOzDFxzBrodDedi95EWTsFiUS4qdtMGjBGRYJbNOzEeUAPm73AxRVBtWq003
         UitxAHXf4MnoB3EbrQ0u5SP/pxwco4JsSczTrqdqtx01xPL5LagoY+k5Cc6f3ESuTqSV
         Y1gisWxtoo1aipVQ+evViEqDy7wlW50gLvLmUYOQ4oFL1rK2pFv8Q5mFqJlMG/WpnLqR
         f/URgmdmYkrzBfx357qGTwq21XV76Emr8aDQ1IFTWR4jbBYlRd3eowAjopjNXJSl9ut/
         ueNA==
X-Forwarded-Encrypted: i=1; AJvYcCVujMPaUHgj/C0DL/HDSEF7DhJLtSYfD6FrQyte3hTJ/WPF1A53zGSEDLx2TREKajqZtpL1j98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWJ4FJaXPJJQ6z60PbDBIsVVOjwIl7KzN4eApvtFxcx9MXVcI
	mVgzIWxdnmhkhw1kfVK3GfU9l2/U2hjZSKG+lthFVS4hCGXLTlugZS+ETiuRXqMY5gkNYbZsPGV
	x4J1pDAurETDZwe8uIjscc6gq/u3MB/p8Iexb0GJsz8ZLT4fvsfHYcg==
X-Received: by 2002:a05:6000:186c:b0:368:5bb4:169b with SMTP id ffacd0b85a97d-37a43128c93mr10082593f8f.4.1727167561601;
        Tue, 24 Sep 2024 01:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFySot47CwfCxg2Of9DQE79eD+88I4k6G5yvDEIsoBCKsYMMcveHmbBKcR9ocx0PWDRIF9ZNA==
X-Received: by 2002:a05:6000:186c:b0:368:5bb4:169b with SMTP id ffacd0b85a97d-37a43128c93mr10082576f8f.4.1727167561206;
        Tue, 24 Sep 2024 01:46:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2cf138sm975156f8f.58.2024.09.24.01.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 01:46:00 -0700 (PDT)
Message-ID: <b9ae8575-f903-425f-aa42-0c2a7605aa94@redhat.com>
Date: Tue, 24 Sep 2024 10:45:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] octeon_ep: Add SKB allocation failures handling in
 __octep_oq_process_rx()
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Veerasenareddy Burru <vburru@marvell.com>
Cc: Sathesh Edara <sedara@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Abhijit Ayarekar <aayarekar@marvell.com>,
 Satananda Burla <sburla@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240916060212.12393-1-amishin@t-argos.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240916060212.12393-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/24 08:02, Aleksandr Mishin wrote:
> build_skb() returns NULL in case of a memory allocation failure so handle
> it inside __octep_oq_process_rx() to avoid NULL pointer dereference.
> 
> __octep_oq_process_rx() is called during NAPI polling by the driver. If
> skb allocation fails, keep on pulling packets out of the Rx DMA queue: we
> shouldn't break the polling immediately and thus falsely indicate to the
> octep_napi_poll() that the Rx pressure is going down. As there is no
> associated skb in this case, don't process the packets and don't push them
> up the network stack - they are skipped.
> 
> The common code with skb and some index manipulations is extracted to make
> the fix more readable and avoid code duplication. Also helper function is
> implemented to unmmap/flush all the fragment buffers used by the dropped
> packet. 'alloc_failures' counter is incremented to mark the skb allocation
> error in driver statistics.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> A similar situation is present in the __octep_vf_oq_process_rx() of the
> Octeon VF driver. First we want to try the fix on __octep_oq_process_rx().
> 
> There are some doubts about increasing the 'rx_bytes'. On the one hand,
> the data has not been processed, therefore, the counter does not need to
> be increased. On the other hand, this counter is used to estimate the
> bandwidth at the card's input.
> In octeon_droq_fast_process_packet() from the Liquidio driver in
> 'droq->stats.bytes_received += total_len' everything that was received
> from the device is considered.
> /* Output Queue statistics. Each output queue has four stats fields. */
> struct octep_oq_stats {
> 	/* Number of packets received from the Device. */
> 	u64 packets;
> 	/* Number of bytes received from the Device. */
> 	u64 bytes;
> 	/* Number of times failed to allocate buffers. */
> 	u64 alloc_failures;
> };
> 
> Compile tested only.
> 
> v2:
>    - Implement helper instead of adding multiple checks for '!skb' and
>      remove 'rx_bytes' increasing in case of packet dropping as suggested
>      by Paolo
>      (https://lore.kernel.org/all/ba514498-3706-413b-a09f-f577861eef28@redhat.com/)
> v1: https://lore.kernel.org/all/20240906063907.9591-1-amishin@t-argos.ru/
> 
>   .../net/ethernet/marvell/octeon_ep/octep_rx.c | 80 +++++++++++++++----
>   1 file changed, 64 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> index 4746a6b258f0..6b665263b9be 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> @@ -336,6 +336,51 @@ static int octep_oq_check_hw_for_pkts(struct octep_device *oct,
>   	return new_pkts;
>   }
>   
> +/**
> + * octep_oq_drop_rx() - Free the resources associated with a packet.
> + *
> + * @oq: Octeon Rx queue data structure.
> + * @buff_info: Current packet buffer info.
> + * @read_idx: Current packet index in the ring.
> + * @desc_used: Current packet descriptor number.
> + *
> + */
> +static void octep_oq_drop_rx(struct octep_oq *oq,
> +			     struct octep_rx_buffer *buff_info,
> +			     u32 *read_idx, u32 *desc_used)
> +{
> +	dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
> +		       PAGE_SIZE, DMA_FROM_DEVICE);
> +	buff_info->page = NULL;
> +	(*read_idx)++;
> +	(*desc_used)++;
> +	if (*read_idx == oq->max_count)
> +		*read_idx = 0;
> +
> +	if (buff_info->len > oq->max_single_buffer_size) {
> +		u16 data_len;
> +		/* Head fragment includes response header(s);
> +		 * subsequent fragments contains only data.
> +		 */
> +		data_len = buff_info->len - oq->max_single_buffer_size;
> +		while (data_len) {
> +			dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
> +				       PAGE_SIZE, DMA_FROM_DEVICE);
> +			buff_info = (struct octep_rx_buffer *)
> +				     &oq->buff_info[*read_idx];
> +			if (data_len < oq->buffer_size)
> +				data_len = 0;
> +			else
> +				data_len -= oq->buffer_size;
> +			buff_info->page = NULL;
> +			(*read_idx)++;
> +			(*desc_used)++;
> +			if (*read_idx == oq->max_count)
> +				*read_idx = 0;
> +		}
> +	}
> +}

I *think* you can simplify this helper always looping:

	int data_len = buff_info->len - oq->max_single_buffer_size;

	do {
		dma_unmap_page(oq->dev,
			oq->desc_ring[*read_idx].buffer_ptr,
			PAGE_SIZE, DMA_FROM_DEVICE);
		buff_info = (struct octep_rx_buffer *)
			     &oq->buff_info[*read_idx];
		data_len -= oq->buffer_size;
		buff_info->page = NULL;
		(*read_idx)++;
		(*desc_used)++;
		if (*read_idx == oq->max_count)
			*read_idx = 0;
	} while (data_len > 0);

Thanks,

Paolo


