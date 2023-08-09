Return-Path: <netdev+bounces-25861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C4D776072
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 15:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2421C2121C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 13:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93A918B05;
	Wed,  9 Aug 2023 13:18:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3918AE6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 13:18:25 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71155128;
	Wed,  9 Aug 2023 06:18:24 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76c845dc5beso419793185a.1;
        Wed, 09 Aug 2023 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691587103; x=1692191903;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjj2pw55OpJ9Ml+mCR1r9Is3y7on0GgaaZp6IQhtWX0=;
        b=a7r2lNNuJIBtJEaovPO2UiEXZq7Fe93jgoypAriBtz3Zmbvj70/Oga3pRlXe8EnZJY
         olTfyYpNTUWK/aOyR81kCyCBEQChIZFYpGJ9uP8TUDm5ZJEMPsZOnWOU+IgGbuKcZNrj
         3MimVN64leU7M/6pNYP/iGImJUgK7FizDl9wZifQIjPuCmB2sESu1913SLkNWOFKcxY+
         BczeCXx1hYiMv1u5Ru5b5bX8G6q+x57jCIBcKQchR1HDS7ntQMumaMHOC/vlJp6CmdYP
         RrHUX7KW0WMdfP+sblRN2zNHu3h8GWgIYlcc2r/1w17Kr+QbjTkboCOVD9xmCO5/odW4
         H4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691587103; x=1692191903;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sjj2pw55OpJ9Ml+mCR1r9Is3y7on0GgaaZp6IQhtWX0=;
        b=OiIX/J4N0EXuu2iKeBfydzlVXK1/30fOyBjp7PbRw5Pi0p3IET6mQ2jRe43lT7BKxB
         cuVi5E126iGRD1AIOVctDxjyiIhxaZ5SFTIZYSZoKvrPUzGfpf0pOlKenhVHK71i2WnK
         EwOuOJy1YjVH3gvLr39vZRrpVAHtAwLTpenrHWpIvg7gjnRgwdKiYwO0N/uXML8ztkwI
         Smc5yfAOVyyDsVy3jpIlWZI+PX69qL/FpbWUchV0MCYXVMejQ70WKzAc1wJz7E4bqyK6
         PN4rCbSr7bLcQVepb0pRjqlTIVHTiSRmJELKIyzoTeoWu+bXuHwqtQLbyjs1CbbiPh6x
         uQQw==
X-Gm-Message-State: AOJu0Ywxlr3WcQZDiArWRio7HG5pdRrTI5z2kiRpUYYEx1IZ0saoZruJ
	2y2MqZ4f/uHakubzZQM6kN8=
X-Google-Smtp-Source: AGHT+IEwKr/W7DJtj36rnSo26cXkG4CoslGWkhDlFQwvy2D21EJ9wyl/mAei8MbMDmbV5R2inhvM9Q==
X-Received: by 2002:a05:620a:d45:b0:76d:264c:a89e with SMTP id o5-20020a05620a0d4500b0076d264ca89emr684548qkl.76.1691587103519;
        Wed, 09 Aug 2023 06:18:23 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b00766fbeb3e7csm3940349qkk.132.2023.08.09.06.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:18:23 -0700 (PDT)
Date: Wed, 09 Aug 2023 09:18:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tahsin Erdogan <trdgn@amazon.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Tahsin Erdogan <trdgn@amazon.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <64d3921ed1f1a_267bde294f2@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230808230920.1944738-1-trdgn@amazon.com>
References: <20230808230920.1944738-1-trdgn@amazon.com>
Subject: RE: [PATCH v3] tun: avoid high-order page allocation for packet
 header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tahsin Erdogan wrote:
> When GSO is not enabled

Not GSO, but gso.hdr_len, which is a feature of IFF_VNET_HDR.

VIRTIO_NET_HDR_GSO_* does not need to be enabled to use the
header length field.

> and a packet is transmitted via writev(), all
> payload is treated as header which requires a contiguous memory allocation.
> This allocation request is harder to satisfy, and may even fail if there is
> enough fragmentation.
> 
> Note that sendmsg() code path limits the linear copy length, so this change
> makes writev() and sendmsg() more consistent.

This is not specific to writev(), equally to more common write().

Tun sendmsg is a special case, only used by vhost-net from inside the
kernel. Arguably consistency with packet_snd/packet_alloc_skb would be
more important. That said, this makes sense to me. I assume your
configuring a device with very large MTU?

 
> Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>
> ---
> v3: rebase to latest net-next
> v2: replace linear == 0 with !linear
> v1: https://lore.kernel.org/all/20230726030936.1587269-1-trdgn@amazon.com/
>  drivers/net/tun.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 5beb6b5dd7e5..53d19c958a20 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1523,7 +1523,7 @@ static struct sk_buff *tun_alloc_skb(struct tun_file *tfile,
>  	int err;
>  
>  	/* Under a page?  Don't bother with paged skb. */
> -	if (prepad + len < PAGE_SIZE || !linear)
> +	if (prepad + len < PAGE_SIZE)
>  		linear = len;
>  
>  	if (len - linear > MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> @@ -1913,6 +1913,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			 */
>  			zerocopy = false;
>  		} else {
> +			if (!linear)
> +				linear = min_t(size_t, good_linear, copylen);
> +
>  			skb = tun_alloc_skb(tfile, align, copylen, linear,
>  					    noblock);
>  		}
> -- 
> 2.41.0
> 



