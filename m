Return-Path: <netdev+bounces-29232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7677823BE
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 08:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090491C208C9
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 06:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2158EBB;
	Mon, 21 Aug 2023 06:32:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4236370
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 06:32:08 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58468B1
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 23:31:58 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VqB3N2T_1692599511;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VqB3N2T_1692599511)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 14:31:52 +0800
Message-ID: <1692599505.5924318-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 2/3] virtio_net: avoid data-races on dev->stats fields
Date: Mon, 21 Aug 2023 14:31:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 Eric Dumazet <edumazet@google.com>,
 syzbot <syzkaller@googlegroups.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20230819044059.833749-1-edumazet@google.com>
 <20230819044059.833749-3-edumazet@google.com>
In-Reply-To: <20230819044059.833749-3-edumazet@google.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Sat, 19 Aug 2023 04:40:58 +0000, Eric Dumazet <edumazet@google.com> wrote:
> Use DEV_STATS_INC() and DEV_STATS_READ() which provide
> atomicity on paths that can be used concurrently.
>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 494242bb9cf60cfd54381f12eef338711a558483..d0570de1b0b47ee585ff8945a438e7cd2e1a7de5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1085,7 +1085,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	if (unlikely(len > GOOD_PACKET_LEN)) {
>  		pr_debug("%s: rx error: len %u exceeds max size %d\n",
>  			 dev->name, len, GOOD_PACKET_LEN);
> -		dev->stats.rx_length_errors++;
> +		DEV_STATS_INC(dev, rx_length_errors);
>  		goto err;
>  	}
>
> @@ -1150,7 +1150,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>  		if (unlikely(!buf)) {
>  			pr_debug("%s: rx error: %d buffers missing\n",
>  				 dev->name, num_buf);
> -			dev->stats.rx_length_errors++;
> +			DEV_STATS_INC(dev, rx_length_errors);
>  			break;
>  		}
>  		stats->bytes += len;
> @@ -1259,7 +1259,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  			pr_debug("%s: rx error: %d buffers out of %d missing\n",
>  				 dev->name, *num_buf,
>  				 virtio16_to_cpu(vi->vdev, hdr->num_buffers));
> -			dev->stats.rx_length_errors++;
> +			DEV_STATS_INC(dev, rx_length_errors);
>  			goto err;
>  		}
>
> @@ -1278,7 +1278,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  			put_page(page);
>  			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
>  				 dev->name, len, (unsigned long)(truesize - room));
> -			dev->stats.rx_length_errors++;
> +			DEV_STATS_INC(dev, rx_length_errors);
>  			goto err;
>  		}
>
> @@ -1457,7 +1457,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	if (unlikely(len > truesize - room)) {
>  		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
>  			 dev->name, len, (unsigned long)(truesize - room));
> -		dev->stats.rx_length_errors++;
> +		DEV_STATS_INC(dev, rx_length_errors);
>  		goto err_skb;
>  	}
>
> @@ -1489,7 +1489,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  				 dev->name, num_buf,
>  				 virtio16_to_cpu(vi->vdev,
>  						 hdr->num_buffers));
> -			dev->stats.rx_length_errors++;
> +			DEV_STATS_INC(dev, rx_length_errors);
>  			goto err_buf;
>  		}
>
> @@ -1503,7 +1503,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		if (unlikely(len > truesize - room)) {
>  			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
>  				 dev->name, len, (unsigned long)(truesize - room));
> -			dev->stats.rx_length_errors++;
> +			DEV_STATS_INC(dev, rx_length_errors);
>  			goto err_skb;
>  		}
>
> @@ -1590,7 +1590,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>
>  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>  		pr_debug("%s: short packet %i\n", dev->name, len);
> -		dev->stats.rx_length_errors++;
> +		DEV_STATS_INC(dev, rx_length_errors);
>  		virtnet_rq_free_unused_buf(rq->vq, buf);
>  		return;
>  	}
> @@ -1630,7 +1630,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	return;
>
>  frame_err:
> -	dev->stats.rx_frame_errors++;
> +	DEV_STATS_INC(dev, rx_frame_errors);
>  	dev_kfree_skb(skb);
>  }
>
> @@ -2170,12 +2170,12 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>
>  	/* This should not happen! */
>  	if (unlikely(err)) {
> -		dev->stats.tx_fifo_errors++;
> +		DEV_STATS_INC(dev, tx_fifo_errors);
>  		if (net_ratelimit())
>  			dev_warn(&dev->dev,
>  				 "Unexpected TXQ (%d) queue failure: %d\n",
>  				 qnum, err);
> -		dev->stats.tx_dropped++;
> +		DEV_STATS_INC(dev, tx_dropped);
>  		dev_kfree_skb_any(skb);
>  		return NETDEV_TX_OK;
>  	}
> @@ -2394,10 +2394,10 @@ static void virtnet_stats(struct net_device *dev,
>  		tot->tx_errors  += terrors;
>  	}
>
> -	tot->tx_dropped = dev->stats.tx_dropped;
> -	tot->tx_fifo_errors = dev->stats.tx_fifo_errors;
> -	tot->rx_length_errors = dev->stats.rx_length_errors;
> -	tot->rx_frame_errors = dev->stats.rx_frame_errors;
> +	tot->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
> +	tot->tx_fifo_errors = DEV_STATS_READ(dev, tx_fifo_errors);
> +	tot->rx_length_errors = DEV_STATS_READ(dev, rx_length_errors);
> +	tot->rx_frame_errors = DEV_STATS_READ(dev, rx_frame_errors);
>  }
>
>  static void virtnet_ack_link_announce(struct virtnet_info *vi)
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

