Return-Path: <netdev+bounces-52759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11580011E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 02:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEC11C20A2E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E450D10E6;
	Fri,  1 Dec 2023 01:39:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3691410E2;
	Thu, 30 Nov 2023 17:39:27 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VxSqLQK_1701394764;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VxSqLQK_1701394764)
          by smtp.aliyun-inc.com;
          Fri, 01 Dec 2023 09:39:24 +0800
Message-ID: <1701394709.904543-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve performance
Date: Fri, 1 Dec 2023 09:38:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Liang Chen <liangchen.linux@gmail.com>,
 jasowang@redhat.com,
 virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kuba@kernel.org,
 edumazet@google.com,
 davem@davemloft.net,
 pabeni@redhat.com,
 alexander.duyck@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-2-liangchen.linux@gmail.com>
 <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>
 <20231129095825-mutt-send-email-mst@kernel.org>
 <b699fbc8-260a-48e9-b6cc-8bfecd09afed@linux.dev>
 <0c2efe49-03db-4616-a4e5-26ff0434e323@linux.dev>
 <1701311694.1163726-1-xuanzhuo@linux.alibaba.com>
 <c4397388-dc39-4799-b386-93ce5956c106@linux.dev>
In-Reply-To: <c4397388-dc39-4799-b386-93ce5956c106@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 30 Nov 2023 13:30:40 +0800, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>
> =E5=9C=A8 2023/11/30 10:34, Xuan Zhuo =E5=86=99=E9=81=93:
> > On Wed, 29 Nov 2023 23:29:10 +0800, Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
> >> =E5=9C=A8 2023/11/29 23:22, Zhu Yanjun =E5=86=99=E9=81=93:
> >>> =E5=9C=A8 2023/11/29 22:59, Michael S. Tsirkin =E5=86=99=E9=81=93:
> >>>> On Wed, Nov 29, 2023 at 10:50:57PM +0800, Zhu Yanjun wrote:
> >>>>> =E5=9C=A8 2023/5/26 13:46, Liang Chen =E5=86=99=E9=81=93:
> >>>> what made you respond to a patch from May, now?
> >>> I want to apply page_pool to our virtio_net. This virtio_net works on
> >>> our device.
> >>>
> >>> I want to verify whether page_pool on virtio_net with our device can
> >>> improve the performance or not.
> >>>
> >>> And I found that ethtool is wrong.
> >>>
> >>> I use virtio_net on our device. I found that page member variable in
> >>> rq is not used in recv path.
> >>>
> >>> When virtio_net is modprobe, I checked page member variable in rq with
> >>> kprobe or crash tool.=C2=A0 page member variable in rq is always NULL.
> >>>
> >>> But sg in recv path is used.
> >>>
> >>> So how to use page member variable in rq? If page member variable in
> >>> rq is always NULL, can we remove it?
> >>>
> >>> BTW, I use ping and iperf tool to make tests with virtio_net. In the
> >>> tests, page member variable in rq is always NULL.
> >>
> >> And I replaced page member variable in rq with page_pool, but the
> >> statistics of page_pool are always 0.
> >>
> >> It is interesting that page_pool member variable in rq is not used in
> >> ping and iperf tests.
> >>
> >> I am not sure what tests can make page member variable not NULL. ^_^
> > Do you mean rq->pages?
> >
> > That is for big mode.
>
> Hi, Xuan
>
> Got it. What is big mode? Do you mean big packet size? I run iperf with
> the packet size 2^23.
>
> The rq->pages is still NULL.
>
> It is interesting.

You may need to check the code of virtnet_probe().

Thanks.


>
> Zhu Yanjun
>
>
> >
> > Thanks.
> >
> >
> >> Best Regards,
> >>
> >> Zhu Yanjun
> >>
> >>
> >>> It is interesting.
> >>>
> >>> Zhu Yanjun
> >>>

