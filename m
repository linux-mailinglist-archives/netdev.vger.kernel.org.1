Return-Path: <netdev+bounces-108187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E656491E42E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5CB1F246E0
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49616D312;
	Mon,  1 Jul 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeH9fuSF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548916CD28
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847956; cv=none; b=c55pTgLdSp8VvIENgDXH3bLnL7Uc6QEXSgGfUJTdA0G/DJz9lb/EtcVmlwgeVdmCG5Gb0FVstqp4F0PAV79jSMBwG+xxtVx3UiP+2s2KgT6OnRSMF+ybruUWyZkRTu0HSFd/aQI7BYUS5ruBsOIVNvI8mOLkIpkhACa2Jhm3200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847956; c=relaxed/simple;
	bh=zi+8fbwcptjmw/P2wZ5lSDZ3iDkRd/wjaUHGZ/OL5lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itth1nez4sjM7y9xs7qidVvA3qg+5+IVrkzhvLPOIu3SaP/im4rFNsMQqWN7kuNKfD8UmuLpZHovdQhyFBeEzoQ4FqHgZI2sXl0W2WJdzeKYLqi08YhinBUyxmNEc1OOuppI5pxa/WXdsi2WWJFu0stjpWZBRua8abRfpis9dNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeH9fuSF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719847954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGj93uGkH1pdIY4bLcgMBtJuKm0uxksm0StLnbxqKDU=;
	b=VeH9fuSFlAT7GJ4rJl3ucb/MCixS8qq3dnlICghAA2yc+lr6v8apyYe2le65OocRN1b/0e
	hU7WDfU+GRDZoaza738VG20LO5M+lg83ma8i3RDbhHG0xZiB2uBinoabx3hVdC1bjSoeZk
	HhkjausfdC8nqIZJbGhyLuVA2otxiLY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-tagecdtZOqSOqfgWJ-tkkQ-1; Mon, 01 Jul 2024 11:32:32 -0400
X-MC-Unique: tagecdtZOqSOqfgWJ-tkkQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b077178ca4so42251556d6.0
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 08:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847952; x=1720452752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGj93uGkH1pdIY4bLcgMBtJuKm0uxksm0StLnbxqKDU=;
        b=R/cdkGEh0wD0n6PA5Wat3a4IljYcLEOOzuQUUAYBHjwHvLb+HwlckAhOaI+yBg6MKo
         ho0cA/5Y/ygvPmKuwOzUngW/j/xTNB/CDsZuzpFdAbB9zd+dnPqrDpQ7JH2pEGkbD6ef
         J/mwulGv77FS5tj3uIm1aplWs/QebE98IC1X+BCHu4nvidBBpxMB1vipUbB7iYRrOWxb
         /xIpvZ6YEBrglGjY4ba1XX2OtNNrNMtXtGlKOOKMPeV/7ZBix2YuPFDY/gWANLG17zLy
         KVqm0B8cLQN1iawmLXBMfmWOs1UHTpVQJP7XknkHsYL9kDQZvemKKu5+15GLU9qRRIC4
         c1gA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ek9SXHfZGg0AC4g6CLyK/3wvgX0GHoOx+NV2xOXARJ5M12zrWPsklE/17EtEAPJqSNE3OPp8n4ZEw4RPvu2DYLPI5BJS
X-Gm-Message-State: AOJu0YwzG7HkzPEneJYfkfiYB1U6lnhhGzw1eZdI3LpqaBCWPYzofIlg
	zCIZpti+5i57TEoUa8izToMu/3HdB4r40i6qzUN3kwmkFsylI9sLQ3L0DRAAHc3JR7sxo0c5nnc
	DShdFTowVbKKAKKeW4m5aOKY+gV3+6JIN6b5lOHcv4sGx0TffYb6cnA==
X-Received: by 2002:a05:6214:248e:b0:6af:2344:5811 with SMTP id 6a1803df08f44-6b5b71b6e5fmr96492446d6.55.1719847952316;
        Mon, 01 Jul 2024 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqlm/0WDwpS5KeYlMAis8uyUKkkCDY9gfKmx9JQ3uzDgIThn0Pe6YuT5CFCsxpsqgIj8oqrg==
X-Received: by 2002:a05:6214:248e:b0:6af:2344:5811 with SMTP id 6a1803df08f44-6b5b71b6e5fmr96492046d6.55.1719847951861;
        Mon, 01 Jul 2024 08:32:31 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.163.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e563aefsm34189636d6.38.2024.07.01.08.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:32:31 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:32:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 1/2] virtio/vsock: rework deferred credit update
 logic
Message-ID: <ua7aoa6yapzzitbg77taspl7h34mmp32lrn6zmr7m6w6xfwk26@w6hheulzftw6>
References: <20240621192541.2082657-1-avkrasnov@salutedevices.com>
 <20240621192541.2082657-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621192541.2082657-2-avkrasnov@salutedevices.com>

Hi Arseniy,

On Fri, Jun 21, 2024 at 10:25:40PM GMT, Arseniy Krasnov wrote:
>Previous calculation of 'free_space' was wrong (but worked as expected
>in most cases, see below), because it didn't account number of bytes in
>rx queue. Let's rework 'free_space' calculation in the following way:
>as this value is considered free space at rx side from tx point of 
>view,
>it must be equal to return value of 'virtio_transport_get_credit()' at
>tx side. This function uses 'tx_cnt' counter and 'peer_fwd_cnt': first
>is number of transmitted bytes (without wrap), second is last 'fwd_cnt'
>value received from rx. So let's use same approach at rx side during
>'free_space' calculation: add 'rx_cnt' counter which is number of
>received bytes (also without wrap) and subtract 'last_fwd_cnt' from it.
>Now we have:
>1) 'rx_cnt' == 'tx_cnt' at both sides.
>2) 'last_fwd_cnt' == 'peer_fwd_cnt' - because first is last 'fwd_cnt'
>   sent to tx, while second is last 'fwd_cnt' received from rx.
>
>Now 'free_space' is handled correctly and also we don't need
>'low_rx_bytes' flag - this was more like a hack.
>
>Previous calculation of 'free_space' worked (in 99% cases), because if
>we take a look on behaviour of both expressions (new and previous):
>
>'(rx_cnt - last_fwd_cnt)' and '(fwd_cnt - last_fwd_cnt)'
>
>Both of them always grows up, with almost same "speed": only difference
>is that 'rx_cnt' is incremented earlier during packet is received,
>while 'fwd_cnt' in incremented when packet is read by user. So if 
>'rx_cnt'
>grows "faster", then resulting 'free_space' become smaller also, so we
>send credit updates a little bit more, but:
>
>  * 'free_space' calculation based on 'rx_cnt' gives the same value,
>    which tx sees as free space at rx side, so original idea of
>    'free_space' is now implemented as planned.
>  * Hack with 'low_rx_bytes' now is not needed.
>
>Also here is some performance comparison between both versions of
>'free_space' calculation:
>
> *------*----------*----------*
> |      | 'rx_cnt' | previous |
> *------*----------*----------*
> |H -> G|   8.42   |   7.82   |
> *------*----------*----------*
> |G -> H|   11.6   |   12.1   |
> *------*----------*----------*

I did some tests on an Intel(R) Xeon(R) Silver 4410Y using iperf-vsock:
- kernel 6.9.0
pkt_size     G->H     H->G
4k            4.6      6.4
64k          13.8     11.5
128k         13.4     11.7

- kernel 6.9.0 with this series applied
pkt_size     G->H     H->G
4k            4.6     8.16
64k          12.2     8.9
128k         12.8     8.8

I see a big drop, especially on H->G with big packets. Can you try to 
replicate on your env?

I'll try to understand more and also an i7 on the next days.

Thanks,
Stefano

>
>As benchmark 'vsock-iperf' with default arguments was used. There is no
>significant performance difference before and after this patch.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> include/linux/virtio_vsock.h            | 1 +
> net/vmw_vsock/virtio_transport_common.c | 8 +++-----
> 2 files changed, 4 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index c82089dee0c8..3579491c411e 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -135,6 +135,7 @@ struct virtio_vsock_sock {
> 	u32 peer_buf_alloc;
>
> 	/* Protected by rx_lock */
>+	u32 rx_cnt;
> 	u32 fwd_cnt;
> 	u32 last_fwd_cnt;
> 	u32 rx_bytes;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 16ff976a86e3..1d4e2328e06e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -441,6 +441,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 		return false;
>
> 	vvs->rx_bytes += len;
>+	vvs->rx_cnt += len;
> 	return true;
> }
>
>@@ -558,7 +559,6 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	size_t bytes, total = 0;
> 	struct sk_buff *skb;
> 	u32 fwd_cnt_delta;
>-	bool low_rx_bytes;
> 	int err = -EFAULT;
> 	u32 free_space;
>
>@@ -603,9 +603,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	}
>
> 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
>-	free_space = vvs->buf_alloc - fwd_cnt_delta;
>-	low_rx_bytes = (vvs->rx_bytes <
>-			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>+	free_space = vvs->buf_alloc - (vvs->rx_cnt - vvs->last_fwd_cnt);
>
> 	spin_unlock_bh(&vvs->rx_lock);
>
>@@ -619,7 +617,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	 * number of bytes in rx queue is not enough to wake up reader.
> 	 */
> 	if (fwd_cnt_delta &&
>-	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
>+	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE))
> 		virtio_transport_send_credit_update(vsk);
>
> 	return total;
>-- 
>2.25.1
>
>


