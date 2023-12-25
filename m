Return-Path: <netdev+bounces-60159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3228581DE9E
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 07:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4A6B20B08
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 06:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71236D;
	Mon, 25 Dec 2023 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoIz4VPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462F110E
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a22f59c6aeaso385909466b.2
        for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 22:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703486065; x=1704090865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeomeFEcFu9q02Wc7Knh1vYChhRuw9U4ir5ZybuLN6U=;
        b=MoIz4VPQYv/oHUsDqLdO9ObPoXanu69V1NSo6MFtwu8DbKiARzakH39o3HQwmO3dzV
         r79lJ/+35Hp2Y4/VwjZIhzaWiQL38bvFvYW+pDXKWYVX9YDUgLtF6G4y3ZB2LrtROoo/
         MwpiaGEiyXO8fNFmUBrMXbkAxLfiC4jV3s00aMdv39qqTs4zwWwX5y+yzxWRAv/14376
         KVhY79y0UZCDhyrlr/whAAKapfzDZWpLMkQxuGA+fvAaKez/TkZdlgMxnXqDs+bcXSQy
         Fa0dxC2fJWX5mFU+KfNkvcuXbxAh/mhOtdTPNrPABGsCNuh+eCEoIAJYfU6/8RJp/evN
         pwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703486065; x=1704090865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeomeFEcFu9q02Wc7Knh1vYChhRuw9U4ir5ZybuLN6U=;
        b=AB6yg0M0fVuZt4lx5wC6kD7/3g7Hv0ssEmDiMJHw29JZd1NdsEbhGw3Ce953w/LlcT
         LexUtDMxFC8VbocojmUk0pYhgKD6sxYzgjj8zZpbPshhMJZmCmQfasKMsbitEYTFRb5q
         o3wKsuowBOq7qr6jJcsWIaOuTrCN6f3FDVKOiVNwJixanhHWKWBkjCzMeTk9SXzJraUC
         K4gXAxI3ZEl9AXBvzlhK3EMwfNXRWBV8rA3/Gz2TC0WI05KaIbjkbgm+zh9swAyTYrY6
         hXY7sjEEPNpHVhCWB78cenBs7g7AX74dyCbCP7DkauVs6vqjNnINoVnAsfoS5WfAs/Zf
         FHAg==
X-Gm-Message-State: AOJu0YzdCuMF+72R7LiF0mdWIjC1aPTJjDbCKENVQPEPB8qbEAMIvWBg
	VGTq7zF5uqNbHxo6DlTugeyCjrE+kfI5VA8Wn3+9WInFzQwh/Q==
X-Google-Smtp-Source: AGHT+IEMxJ/h5LovoLdQonJp7UTysp6Lsme2Nws1ugvo5QB8A9ksZef6PfrnrZcUZoX4NUsrlC+Gt6dDjBbfed25inA=
X-Received: by 2002:a17:907:3e9e:b0:a23:6282:528d with SMTP id
 hs30-20020a1709073e9e00b00a236282528dmr2997969ejc.43.1703486065344; Sun, 24
 Dec 2023 22:34:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch> <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch> <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
 <CAL+tcoDM+Kqu1=11m5gc58vY3uKVA6JiggBy_FyCghHY3Za0Qw@mail.gmail.com> <CACGkMEsDFTPUVXfSj5FGTK_722F1QkKHJG3GNV3qvsaKATZV_w@mail.gmail.com>
In-Reply-To: <CACGkMEsDFTPUVXfSj5FGTK_722F1QkKHJG3GNV3qvsaKATZV_w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 25 Dec 2023 14:33:48 +0800
Message-ID: <CAL+tcoA_kXEb2uBznUY8A+-uVcB_rXx1j39Wt8UTNx+6F0iHNA@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 12:14=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Dec 25, 2023 at 10:25=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > Hello Jason,
> > On Fri, Dec 22, 2023 at 10:36=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Thu, Dec 21, 2023 at 11:06=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Heng Qi wrote:
> > > > >
> > > > >
> > > > > =E5=9C=A8 2023/12/20 =E4=B8=8B=E5=8D=8810:45, Willem de Bruijn =
=E5=86=99=E9=81=93:
> > > > > > Heng Qi wrote:
> > > > > >> virtio-net has two ways to switch napi_tx: one is through the
> > > > > >> module parameter, and the other is through coalescing paramete=
r
> > > > > >> settings (provided that the nic status is down).
> > > > > >>
> > > > > >> Sometimes we face performance regression caused by napi_tx,
> > > > > >> then we need to switch napi_tx when debugging. However, the
> > > > > >> existing methods are a bit troublesome, such as needing to
> > > > > >> reload the driver or turn off the network card.
> > >
> > > Why is this troublesome? We don't need to turn off the card, it's jus=
t
> > > a toggling of the interface.
> > >
> > > This ends up with pretty simple code.
> > >
> > > > So try to make
> > > > > >> this update.
> > > > > >>
> > > > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > The commit does not explain why it is safe to do so.
> > > > >
> > > > > virtnet_napi_tx_disable ensures that already scheduled tx napi en=
ds and
> > > > > no new tx napi will be scheduled.
> > > > >
> > > > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack can=
not
> > > > > send the packet.
> > > > >
> > > > > Then we can safely toggle the weight to indicate where to clear t=
he buffers.
> > > > >
> > > > > >
> > > > > > The tx-napi weights are not really weights: it is a boolean whe=
ther
> > > > > > napi is used for transmit cleaning, or whether packets are clea=
ned
> > > > > > in ndo_start_xmit.
> > > > >
> > > > > Right.
> > > > >
> > > > > >
> > > > > > There certainly are some subtle issues with regard to pausing/w=
aking
> > > > > > queues when switching between modes.
> > > > >
> > > > > What are "subtle issues" and if there are any, we find them.
> > > >
> > > > A single runtime test is not sufficient to exercise all edge cases.
> > > >
> > > > Please don't leave it to reviewers to establish the correctness of =
a
> > > > patch.
> > >
> > > +1
> > >
> > [...]
> > > And instead of trying to do this, it would be much better to optimize
> > > the NAPI performance. Then we can drop the orphan mode.
> >
[...]
> > Do you mean when to call skb_orphan()? If yes, I just want to provide
> > more information that we also have some performance issues where the
> > flow control takes a bad effect, especially under some small
> > throughput in our production environment.
>
> I think you need to describe it in detail.

Some of the details were described below in the last email. The
decreased performance happened because of flow control: the delay of
skb free means the delay of decreasing of sk_wmem_alloc, then it will
hit the limit of TSQ mechanism, finally causing transmitting slowly in
the TCP layer.

>
> > What strikes me as odd is if I restart the network, then the issue
> > will go with the wind. I cannot reproduce it in my testing machine.
> > One more thing: if I force skb_orphan() the current skb in every
> > start_xmit(), it could also solve the issue but not in a proper way.
> > After all, it drops the flow control... :S
>
> Yes, that's the known issue.

Really? Did you have some numbers or have some discussion links to
share? I failed to reproduce on my testing machine, probably the short
rtt is the key/obstacle.

@Eric, it seems it still exists.

Thanks,
Jason

>
> Thanks
>
> >
> > Thanks,
> > Jason
> > >
> > > >
> > > > The napi_tx and non-napi code paths differ in how they handle at le=
ast
> > > > the following structures:
> > > >
> > > > 1. skb: non-napi orphans these in ndo_start_xmit. Without napi this=
 is
> > > > needed as delay until the next ndo_start_xmit and thus completion i=
s
> > > > unbounded.
> > > >
> > > > When switching to napi mode, orphaned skbs may now be cleaned by th=
e
> > > > napi handler. This is indeed safe.
> > > >
> > > > When switching from napi to non-napi, the unbound latency resurface=
s.
> > > > It is a small edge case, and I think a potentially acceptable risk,=
 if
> > > > the user of this knob is aware of the risk.
> > > >
> > > > 2. virtqueue callback ("interrupt" masking). The non-napi path enab=
les
> > > > the interrupt (disables the mask) when available descriptors falls
> > > > beneath a low watermark, and reenables when it recovers above a hig=
h
> > > > watermark. Napi disables when napi is scheduled, and reenables on
> > > > napi complete.
> > > >
> > > > 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls below
> > > > a low watermark, the driver stops the stack for queuing more packet=
s.
> > > > In napi mode, it schedules napi to clean packets. See the calls to
> > > > netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue and
> > > > netif_tx_wake_queue.
> > > >
> > > > Some if this can be assumed safe by looking at existing analogous
> > > > code, such as the queue stop/start in virtnet_tx_resize.
> > > >
> > > > But that all virtqueue callback and dev_queue->state transitions ar=
e
> > > > correct when switching between modes at runtime is not trivial to
> > > > establish, deserves some thought and explanation in the commit
> > > > message.
> > >
> > > Thanks
> > >
> > >
> >
>

