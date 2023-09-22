Return-Path: <netdev+bounces-35751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB5F7AAEE0
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 964751F227C7
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA51E53F;
	Fri, 22 Sep 2023 09:56:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156611E535
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:56:16 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1099F8F
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 02:56:12 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vsd6I4O_1695376569;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vsd6I4O_1695376569)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 17:56:10 +0800
Message-ID: <1695376243.9393134-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 5/6] virtio-net: fix the vq coalescing setting for vq resize
Date: Fri, 22 Sep 2023 17:50:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Gavin Li <gavinl@nvidia.com>,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-6-hengqi@linux.alibaba.com>
 <CACGkMEuJjxAmr6WC9ETYAw2K9dp0AUoD6LSZCduQyUQ9y7oM3Q@mail.gmail.com>
 <c95274cd-d119-402b-baf1-0c500472c9fb@linux.alibaba.com>
 <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
In-Reply-To: <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 22 Sep 2023 15:32:39 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Sep 22, 2023 at 1:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> >
> >
> > =E5=9C=A8 2023/9/22 =E4=B8=8B=E5=8D=8812:29, Jason Wang =E5=86=99=E9=81=
=93:
> > > On Tue, Sep 19, 2023 at 3:49=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> > >> According to the definition of virtqueue coalescing spec[1]:
> > >>
> > >>    Upon disabling and re-enabling a transmit virtqueue, the device M=
UST set
> > >>    the coalescing parameters of the virtqueue to those configured th=
rough the
> > >>    VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did n=
ot set
> > >>    any TX coalescing parameters, to 0.
> > >>
> > >>    Upon disabling and re-enabling a receive virtqueue, the device MU=
ST set
> > >>    the coalescing parameters of the virtqueue to those configured th=
rough the
> > >>    VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did n=
ot set
> > >>    any RX coalescing parameters, to 0.
> > >>
> > >> We need to add this setting for vq resize (ethtool -G) where vq_rese=
t happens.
> > >>
> > >> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415=
.html
> > >>
> > >> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coales=
ce command")
> > > I'm not sure this is a real fix as spec allows it to go zero?
> >
> > The spec says that if the user has configured interrupt coalescing
> > parameters,
> > parameters need to be restored after vq_reset, otherwise set to 0.
> > vi->intr_coal_tx and vi->intr_coal_rx always save the newest global
> > parameters,
> > regardless of whether the command is sent or not. So I think we need
> > this patch
> > it complies with the specification requirements.
>
> How can we make sure the old coalescing parameters still make sense
> for the new ring size?

For the user, I don't think we should drop the config for the coalescing.
Maybe the config does not make sense for the new ring size, but when the us=
er
just change the ring size, the config for the coalesing is missing, I think
that is not good.

Thanks.




>
> Thanks
>
> >
> > Thanks!
> >
> > >
> > > Thanks
> >
>

