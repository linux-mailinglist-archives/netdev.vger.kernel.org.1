Return-Path: <netdev+bounces-230265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B779BE5FED
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 02:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7595E5426
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D271548CFC;
	Fri, 17 Oct 2025 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RFTiJfSa"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADE168BD
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760662684; cv=none; b=GPuiDOPwwAIbacBrajllKIz1W0+JsACuU2NHy/pPIuf5/fG5i709IYrxLtxFcOdXJWeG5B1nItHXbEhuVyXBEgLG8rqn4m0eV1S9PaVhcEHNIGgaCmOrqllFmho5V4IciA4cRzocNnOw2kgUqHkgUec2adFoc/Dv9H8XWBRivKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760662684; c=relaxed/simple;
	bh=cikAfzhjErC0zNYhTw+YhZa1pZhEIUvvHOKlGbvjKac=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=dfPpXYLs4AsAoEWCfTvMViScevfHQecbxALefVR7XBnQa+aPGGlUSc1FoDs7ybxei11MmvDIgDvsTVNRvMh6Yx37EhKlpIGtnj2nCzMOTkPWE8n9wlYVWUsH3SL/IkeA8weSZnQgtliiPI3YFVHZQG4GV37vKjLSOGc5WVvy3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RFTiJfSa; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760662679; h=Message-ID:Subject:Date:From:To;
	bh=bIANy4Ycj+HBtemaCXpipLOBIsrD9gM6qo8E04r1ozY=;
	b=RFTiJfSaB2GogOY1bXunslwOnjhAS+htXjXQCvNLUrrvl94gJZ/P0opbQLkry2BL38HES3L55chVxRtZ0dL8Tv+8XkecGUmaS9GfHpFHhdsCU5Cocg2n/siDA9iSESSEJtqU4W3DIhOXavh5C6rz0qmCqc4jTfkgCp5qhHh0bH4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqMOOPm_1760662678 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 08:57:59 +0800
Message-ID: <1760662656.1338146-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: fix header access in big_packets mode
Date: Fri, 17 Oct 2025 08:57:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Wen Xin <w_xin@apple.com>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 virtualization@lists.linux.dev,
 Wen Xin <w_xin@apple.com>,
 netdev@vger.kernel.org
References: <20251016223305.51435-1-w_xin@apple.com>
In-Reply-To: <20251016223305.51435-1-w_xin@apple.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

http://lore.kernel.org/all/20251013020629.73902-1-xuanzhuo@linux.alibaba.com

do the same thing.


On Thu, 16 Oct 2025 15:33:05 -0700, Wen Xin <w_xin@apple.com> wrote:
> In Linux virtio-net driver's (drivers/net/virtio_net.c) big packets mode (vi->big_packets && vi->mergeable_rx_bufs), the buf
> pointer passed to receive_buf() is a struct page pointer, not a buffer
> pointer. The current code incorrectly casts this page pointer directly as
> a virtio_net_common_hdr, causing it to read flags from the page struct
> memory instead of the actual packet data.
>
> Signed-off-by: Wen Xin <w_xin@apple.com>
> ---
>  drivers/net/virtio_net.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7646ddd9bef7..c10f5585bc88 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2566,7 +2566,13 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	 * virtnet_xdp_set()), so packets marked as
>  	 * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
>  	 */
> -	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> +	if (vi->big_packets && !vi->mergeable_rx_bufs) {
> +		struct virtio_net_common_hdr *hdr = page_address((struct page *)buf);
> +
> +		flags = hdr->hdr.flags;
> +	} else {
> +		flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> +	}
>
>  	if (vi->mergeable_rx_bufs)
>  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> --
> 2.39.5 (Apple Git-154)
>

