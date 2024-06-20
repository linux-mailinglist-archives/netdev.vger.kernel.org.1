Return-Path: <netdev+bounces-105157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B077E90FE70
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B6D8B21031
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194C17C21D;
	Thu, 20 Jun 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ro0UStxI"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32517B50D;
	Thu, 20 Jun 2024 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871327; cv=none; b=l3UpLKv2K/ZXbcibw0fT3hiHMhV4UQOxO/AAud351QVGu2BoDE9oyAOknW84TIJ5bBYapAW3zs4kHUdoQHjN5ihR2hSZPPCQVuuzCqchB/iYXydMcNMJHMsy3IkyaeO3Rm07bArzLHXplEIMpLJu9FycJtu8naXJEm2NYM3hgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871327; c=relaxed/simple;
	bh=QQN5MWcgFvej1lFWyiOc0hlQXuyKb17sEjfAfzK8yE4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=N2ZWgbbsZo6UueijpW2iEISVfNEQnjswzK1Xn2nR4k9mgPjPbsmAA4g7m1KC9kfimcgFiZiUxPIWid2EdrEZ5APUhZr6MeWVle8pBIA1ObOlWk7XS26jHw9MdhkexkPBV9KI9R3XufOdjjXm9MMDMuCyol8aPhO8RcM0FebL3bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ro0UStxI; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718871321; h=Message-ID:Subject:Date:From:To;
	bh=IWsqLolJNxTdvFPMcucDRzIAOF+b9AvIwc4qt2sjbVw=;
	b=ro0UStxIi6MMURDFhPf5kChmcBGLC/l5rwXM9JrxjwNifQ80RZN89zMQXATPtKMFgXczAOPntK4272bVZOKeeVz/uLfPBvCA2kJQ9G3AFExGeCI7p8w2FaGjc7/W8WcFSD6uEdgWEkcPmAGKGcPC0BBCJIQGr1+ozAtx9YxeqTo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W8qgb1u_1718871320;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8qgb1u_1718871320)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 16:15:20 +0800
Message-ID: <1718871314.1931674-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] net: virtio: unify code to init stats
Date: Thu, 20 Jun 2024 16:15:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>,
 linux-kernel@vger.kernel.org
References: <fb91a4ec2224c36adda854314940304d708d59ef.1718869408.git.mst@redhat.com>
In-Reply-To: <fb91a4ec2224c36adda854314940304d708d59ef.1718869408.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 20 Jun 2024 03:44:53 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Moving initialization of stats structure into
> __free_old_xmit reduces the code size slightly.
> It also makes it clearer that this function shouldn't
> be called multiple times on the same stats struct.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>
> Especially important now that Jiri's patch for BQL has been merged.
> Lightly tested.
>
>  drivers/net/virtio_net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 283b34d50296..c2ce8de340f7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>  	unsigned int len;
>  	void *ptr;
>
> +	stats->bytes = stats->packets = 0;
> +
>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>  		++stats->packets;
>
> @@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>
>  static void free_old_xmit(struct send_queue *sq, bool in_napi)
>  {
> -	struct virtnet_sq_free_stats stats = {0};
> +	struct virtnet_sq_free_stats stats;
>
>  	__free_old_xmit(sq, in_napi, &stats);
>
> @@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  			    int n, struct xdp_frame **frames, u32 flags)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	struct virtnet_sq_free_stats stats = {0};
> +	struct virtnet_sq_free_stats stats;
>  	struct receive_queue *rq = vi->rq;
>  	struct bpf_prog *xdp_prog;
>  	struct send_queue *sq;
> --
> MST
>

