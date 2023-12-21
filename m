Return-Path: <netdev+bounces-59663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7C881BA2D
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 16:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A53B20EA5
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767597481;
	Thu, 21 Dec 2023 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG1scQJv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE31A41840
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-781001f5e96so58390385a.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 07:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703171160; x=1703775960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeOw15fbxT+ZjQDSBsRxLfGqZy2QfSX8zwYYPjkKM2Q=;
        b=jG1scQJv3CLDvQFp3ZLGa57qbIdMQodKzXnrU0CiBvmEhW4bKgokzmE6FFbQ0mCV7J
         MJTW4OZy/nSIfcdTZVpymesx4hm7/TavsCPYiqPCp5BuVCPrk+b9yY9rDI7e79PjETkT
         fvF7kMxQRfMQHNdHgAoKFEkgqFYWTxtAp6/SK8oTBCt55XuXl8guquRjFoRkrgQr8N0A
         NWaCeh276Bs9IYV3ujXQnt6mee1CfOdmdnwYXrYd9EBAqBAQaNzmYQ5MeQWbyfUVr+se
         B/0oQqOHSxfBM43VcLNGaqpEgDesgVEgXb4WfQrfVEHG6vTbcPIaCOMttROWSX+aXx2K
         TISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703171160; x=1703775960;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TeOw15fbxT+ZjQDSBsRxLfGqZy2QfSX8zwYYPjkKM2Q=;
        b=cAChbx9bzUcUaM+YWam4kzUambRwHqx5COS73GfGw8CdwVEP2bM67tzxXe59Awe5mR
         40EoWS6min67pcIgyWl+VaY8cxj5vjkyoLQdnYd3o32FwCzkgR85SBdLhuYJWmdhIXhV
         Vmsprd+6K7Y8qTHPxaVYcW6yKPYuXE8mQRru7jdIB0Bhighpc1PEoQhixDf6WelyVGFl
         7WD7gGxQjVGbBG/NhznvzYlVc/GuNBp26VLa+CXXaE3jg8hUaaot/nTULPyZLv6aYgVd
         09X52VLzUfspN7ndiwiHJ04JmW1rJT46Ico3O1v6gAA8vWfe9m5AaonfK/Tu+uerwYip
         c07g==
X-Gm-Message-State: AOJu0YxWwKo9gdu6NCdzumd1eV9t0GnhCvulDPPNgZL+xBf6PdtbLgd5
	jw6Qq6/LDJFvsB+ZFldtQ2c=
X-Google-Smtp-Source: AGHT+IFtawQnlrBRAL4WKTL6fd28qUc20wgO9y6xTjtlwSMWhVQCtpBwZYb9cjbFer2hx5ElwjS8GA==
X-Received: by 2002:a05:620a:5637:b0:77d:869f:ca1c with SMTP id vv23-20020a05620a563700b0077d869fca1cmr25479664qkn.65.1703171159558;
        Thu, 21 Dec 2023 07:05:59 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a0ce700b0077f249608besm700166qkj.53.2023.12.21.07.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:05:59 -0800 (PST)
Date: Thu, 21 Dec 2023 10:05:58 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Heng Qi <hengqi@linux.alibaba.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch>
In-Reply-To: <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch>
 <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Heng Qi wrote:
> =

> =

> =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruijn =E5=86=99=
=E9=81=93:
> > Heng Qi wrote:
> >> virtio-net has two ways to switch napi_tx: one is through the
> >> module parameter, and the other is through coalescing parameter
> >> settings (provided that the nic status is down).
> >>
> >> Sometimes we face performance regression caused by napi_tx,
> >> then we need to switch napi_tx when debugging. However, the
> >> existing methods are a bit troublesome, such as needing to
> >> reload the driver or turn off the network card. So try to make
> >> this update.
> >>
> >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > The commit does not explain why it is safe to do so.
> =

> virtnet_napi_tx_disable ensures that already scheduled tx napi ends and=
 =

> no new tx napi will be scheduled.
> =

> Afterwards, if the __netif_tx_lock_bh lock is held, the stack cannot =

> send the packet.
> =

> Then we can safely toggle the weight to indicate where to clear the buf=
fers.
> =

> >
> > The tx-napi weights are not really weights: it is a boolean whether
> > napi is used for transmit cleaning, or whether packets are cleaned
> > in ndo_start_xmit.
> =

> Right.
> =

> >
> > There certainly are some subtle issues with regard to pausing/waking
> > queues when switching between modes.
> =

> What are "subtle issues" and if there are any, we find them.

A single runtime test is not sufficient to exercise all edge cases.

Please don't leave it to reviewers to establish the correctness of a
patch.

The napi_tx and non-napi code paths differ in how they handle at least
the following structures:

1. skb: non-napi orphans these in ndo_start_xmit. Without napi this is
needed as delay until the next ndo_start_xmit and thus completion is
unbounded.

When switching to napi mode, orphaned skbs may now be cleaned by the
napi handler. This is indeed safe.

When switching from napi to non-napi, the unbound latency resurfaces.
It is a small edge case, and I think a potentially acceptable risk, if
the user of this knob is aware of the risk.

2. virtqueue callback ("interrupt" masking). The non-napi path enables
the interrupt (disables the mask) when available descriptors falls
beneath a low watermark, and reenables when it recovers above a high
watermark. Napi disables when napi is scheduled, and reenables on
napi complete.

3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls below
a low watermark, the driver stops the stack for queuing more packets.
In napi mode, it schedules napi to clean packets. See the calls to
netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue and
netif_tx_wake_queue.

Some if this can be assumed safe by looking at existing analogous
code, such as the queue stop/start in virtnet_tx_resize.

But that all virtqueue callback and dev_queue->state transitions are
correct when switching between modes at runtime is not trivial to
establish, deserves some thought and explanation in the commit
message.

> So far my test results show it's working fine.
> =

> >
> > Calling napi_enable/napi_disable without bringing down the device is
> > allowed. The actually napi.weight field is only updated when neither
> > napi nor ndo_start_xmit is running.
> =

> YES.
> =

> > So I don't see an immediate issue.
> =

> Switching napi_tx requires reloading the driver or downing the nic, =

> which is troublesome.
> I think it would be better if we could find a better way.
> =

> Thanks!
> =

> >
> >
> >> ---
> >>   drivers/net/virtio_net.c | 81 ++++++++++++++++++------------------=
----
> >>   1 file changed, 37 insertions(+), 44 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 10614e9f7cad..12f8e1f9971c 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -3559,16 +3559,37 @@ static int virtnet_coal_params_supported(str=
uct ethtool_coalesce *ec)
> >>   	return 0;
> >>   }
> >>   =

> >> -static int virtnet_should_update_vq_weight(int dev_flags, int weigh=
t,
> >> -					   int vq_weight, bool *should_update)
> >> +static void virtnet_switch_napi_tx(struct virtnet_info *vi, u32 qst=
art,
> >> +				   u32 qend, u32 tx_frames)
> >>   {
> >> -	if (weight ^ vq_weight) {
> >> -		if (dev_flags & IFF_UP)
> >> -			return -EBUSY;
> >> -		*should_update =3D true;
> >> -	}
> >> +	struct net_device *dev =3D vi->dev;
> >> +	int new_weight, cur_weight;
> >> +	struct netdev_queue *txq;
> >> +	struct send_queue *sq;
> >>   =

> >> -	return 0;
> >> +	new_weight =3D tx_frames ? NAPI_POLL_WEIGHT : 0;
> >> +	for (; qstart < qend; qstart++) {
> >> +		sq =3D &vi->sq[qstart];
> >> +		cur_weight =3D sq->napi.weight;
> >> +		if (!(new_weight ^ cur_weight))
> >> +			continue;
> >> +
> >> +		if (!(dev->flags & IFF_UP)) {
> >> +			sq->napi.weight =3D new_weight;
> >> +			continue;
> >> +		}
> >> +
> >> +		if (cur_weight)
> >> +			virtnet_napi_tx_disable(&sq->napi);
> >> +
> >> +		txq =3D netdev_get_tx_queue(dev, qstart);
> >> +		__netif_tx_lock_bh(txq);
> >> +		sq->napi.weight =3D new_weight;
> >> +		__netif_tx_unlock_bh(txq);
> >> +
> >> +		if (!cur_weight)
> >> +			virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> >> +	}
> >>   }
> >>   =

> >>   static int virtnet_set_coalesce(struct net_device *dev,
> >> @@ -3577,25 +3598,11 @@ static int virtnet_set_coalesce(struct net_d=
evice *dev,
> >>   				struct netlink_ext_ack *extack)
> >>   {
> >>   	struct virtnet_info *vi =3D netdev_priv(dev);
> >> -	int ret, queue_number, napi_weight;
> >> -	bool update_napi =3D false;
> >> -
> >> -	/* Can't change NAPI weight if the link is up */
> >> -	napi_weight =3D ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0=
;
> >> -	for (queue_number =3D 0; queue_number < vi->max_queue_pairs; queue=
_number++) {
> >> -		ret =3D virtnet_should_update_vq_weight(dev->flags, napi_weight,
> >> -						      vi->sq[queue_number].napi.weight,
> >> -						      &update_napi);
> >> -		if (ret)
> >> -			return ret;
> >> -
> >> -		if (update_napi) {
> >> -			/* All queues that belong to [queue_number, vi->max_queue_pairs]=
 will be
> >> -			 * updated for the sake of simplicity, which might not be necess=
ary
> >> -			 */
> >> -			break;
> >> -		}
> >> -	}
> >> +	int ret;
> >> +
> >> +	/* Param tx_frames can be used to switch napi_tx */
> >> +	virtnet_switch_napi_tx(vi, 0, vi->max_queue_pairs,
> >> +			       ec->tx_max_coalesced_frames);
> >>   =

> >>   	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
> >>   		ret =3D virtnet_send_notf_coal_cmds(vi, ec);
> >> @@ -3605,11 +3612,6 @@ static int virtnet_set_coalesce(struct net_de=
vice *dev,
> >>   	if (ret)
> >>   		return ret;
> >>   =

> >> -	if (update_napi) {
> >> -		for (; queue_number < vi->max_queue_pairs; queue_number++)
> >> -			vi->sq[queue_number].napi.weight =3D napi_weight;
> >> -	}
> >> -
> >>   	return ret;
> >>   }
> >>   =

> >> @@ -3641,19 +3643,13 @@ static int virtnet_set_per_queue_coalesce(st=
ruct net_device *dev,
> >>   					  struct ethtool_coalesce *ec)
> >>   {
> >>   	struct virtnet_info *vi =3D netdev_priv(dev);
> >> -	int ret, napi_weight;
> >> -	bool update_napi =3D false;
> >> +	int ret;
> >>   =

> >>   	if (queue >=3D vi->max_queue_pairs)
> >>   		return -EINVAL;
> >>   =

> >> -	/* Can't change NAPI weight if the link is up */
> >> -	napi_weight =3D ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0=
;
> >> -	ret =3D virtnet_should_update_vq_weight(dev->flags, napi_weight,
> >> -					      vi->sq[queue].napi.weight,
> >> -					      &update_napi);
> >> -	if (ret)
> >> -		return ret;
> >> +	/* Param tx_frames can be used to switch napi_tx */
> >> +	virtnet_switch_napi_tx(vi, queue, queue, ec->tx_max_coalesced_fram=
es);
> >>   =

> >>   	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> >>   		ret =3D virtnet_send_notf_coal_vq_cmds(vi, ec, queue);
> >> @@ -3663,9 +3659,6 @@ static int virtnet_set_per_queue_coalesce(stru=
ct net_device *dev,
> >>   	if (ret)
> >>   		return ret;
> >>   =

> >> -	if (update_napi)
> >> -		vi->sq[queue].napi.weight =3D napi_weight;
> >> -
> >>   	return 0;
> >>   }
> >>   =

> >> -- =

> >> 2.19.1.6.gb485710b
> >>
> =




