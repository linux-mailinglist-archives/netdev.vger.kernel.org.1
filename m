Return-Path: <netdev+bounces-145646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2689D0451
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 15:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9449828133E
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4A21D8A16;
	Sun, 17 Nov 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTl8Zjxd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DC194088;
	Sun, 17 Nov 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731853616; cv=none; b=tsD4SP7esby8jRr72X+cfYt8YL6BQdItfcrj8HtqWJ1k3FBaCVcv2yToe+krMcRIJZigOrL5nJzn6kUyP4Rp5gKVXAyNjOpiS2qzZjqAkv+a1BfGQ0oIvOknCotQu+VUKYcIgMBaJ4qlD8jaFz7DRPG1LJSqD9HOx56h4zUpMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731853616; c=relaxed/simple;
	bh=rlGPExjWpNNdeYED0JKWdYccNVu9hTYOhBpVymvppKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msgTTuWWFLNvIYdZJz2oEc6AeDvFWrFOYvtg/TSoETLJYDvX+/RaB/oN9NriSPEen5Zb4JVc8Bkp+WtquykufCzbilFb5j9dFIx6S1SYTFc+9rKIPmGtIlJYFt8BfjJcv0jDv8uMD+9SznjdS8jnBk14uj5QRS/dKuBOVHONNsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTl8Zjxd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa4b439c5e8so26731066b.2;
        Sun, 17 Nov 2024 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731853613; x=1732458413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HYiKCaAhfV0M9qDtG+udDyORRLxqLDx9oebdtmTlck=;
        b=jTl8Zjxdqn4Lco9HtJpho/Tb70duRIo2WOCPxBuX1i5t7ZOqCYsczGpF6PAbeD8Gc8
         doXs0UnKKhgESfwiEhPk15YkeoQQ7HSAsJotjWsdosrfdvuq+/cu+wwv9NiYXN3AXZ5V
         2gkMfaCmff4byKjHWM+CAYMND3lhsNsgcIsqyaQB8GyLhz/vJu5dlB8VVjPcQUbzaAG7
         eSFvjMIP8wIGUUX34kyM2zUw8DjFqgoHK4yPoVOnbFsobdZJKSlbOllq89exfBL4fc4N
         x5q/XfPSkL5oT+Y5DvXXwCRFOnMqBU7mq82Q6j/uvNq2XYwKXYWO+2qFmZBT2e56JoFs
         GZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731853613; x=1732458413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HYiKCaAhfV0M9qDtG+udDyORRLxqLDx9oebdtmTlck=;
        b=mPklFg8RLVQM0UBPI3xe5XWQ17mYLJj98Eo0+T0FfTw9RlHK7M32mWV9BSn+luCKlM
         tptQAKsUAvaIeqJAqJPOp7aqNx+YbrCau4fzv2yLxAMUtpicUUGuFxMMRAjphOiKRT/Y
         GlA5rNLk+YVm52YC1ic6uqHg44kBBBPyQYNXyIqbivgw2H0vtocajmcQyL2B0hFTYCrz
         xpMHsL3aRFCTy/yibIv7XhgK0yPQsPIykS2aUk/OJa3klc/k7ecUid9N1OE/EZWJtDua
         FrMn8cA/y90DrxYe5htoaofjAk+z0Ping2MJ88708xoBaR9Eogw0RZusPW09bVn5BrtY
         0lLA==
X-Forwarded-Encrypted: i=1; AJvYcCV2uNuUVnNMrH0sFhs3epse3QVCCBVbcvJqw+9o8KtIJIysjtxUMzj2kP+blaVEa+hvRWBaXNzAXc4=@vger.kernel.org, AJvYcCXtZcDy89VwB88BoD6YjxE+vvAzkL5MV2aENDoS/Hcfr2kIQYpD0bAWKuWQXqPSpRaeP/A2TvIF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35mMbxzie6NAGb6pxSCwVKzRC19JaR6CjUW6XQEq3ntppBKH1
	4JvzgndPDl1o/xNfbxBWfjHzp2TmPaLUpuRtUazpatAycx3hR8yJeV3Ev2R0SS9gIZWF3EWFv/I
	NGT7ue1FJuVgTf2BoO9WWlp9t9Fo=
X-Google-Smtp-Source: AGHT+IGpRXIdaCjVtS0/8nCw0jeYpNLDY6OFi2E11trjvxCzNUnXNhV4LABh36/oWe1DYD7m5zxltJcd/OTQwhi4XZM=
X-Received: by 2002:a17:907:70e:b0:a99:f945:8776 with SMTP id
 a640c23a62f3a-aa483426424mr875418666b.24.1731853612416; Sun, 17 Nov 2024
 06:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113173222.372128-1-ap420073@gmail.com> <20241113173222.372128-5-ap420073@gmail.com>
 <ZzeusGr18H98xSQN@x130>
In-Reply-To: <ZzeusGr18H98xSQN@x130>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 17 Nov 2024 23:26:40 +0900
Message-ID: <CAMArcTWwnz8gLekM8vY0cZ1H4XEZOywhQP325Z-rvRN7Y+8chA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/7] net: ethtool: add support for configuring header-data-split-thresh
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, donald.hunter@gmail.com, 
	corbet@lwn.net, michael.chan@broadcom.com, andrew+netdev@lunn.ch, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, dw@davidwei.uk, 
	sdf@fomichev.me, asml.silence@gmail.com, brett.creeley@amd.com, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 5:27=E2=80=AFAM Saeed Mahameed <saeed@kernel.org> w=
rote:
>

Hi Saeed,
Thank you so much for the review!

> On 13 Nov 17:32, Taehee Yoo wrote:
> >The header-data-split-thresh option configures the threshold value of
> >the header-data-split.
> >If a received packet size is larger than this threshold value, a packet
> >will be split into header and payload.
> >The header indicates TCP and UDP header, but it depends on driver spec.
> >The bnxt_en driver supports HDS(Header-Data-Split) configuration at
> >FW level, affecting TCP and UDP too.
> >So, If header-data-split-thresh is set, it affects UDP and TCP packets.
> >
> >Example:
> >   # ethtool -G <interface name> header-data-split-thresh <value>
> >
> >   # ethtool -G enp14s0f0np0 tcp-data-split on header-data-split-thresh =
256
> >   # ethtool -g enp14s0f0np0
> >   Ring parameters for enp14s0f0np0:
> >   Pre-set maximums:
> >   ...
> >   Header data split thresh:  256
> >   Current hardware settings:
> >   ...
> >   TCP data split:         on
> >   Header data split thresh:  256
> >
> >The default/min/max values are not defined in the ethtool so the drivers
> >should define themself.
> >The 0 value means that all TCP/UDP packets' header and payload
> >will be split.
> >
>
> Users will need default/min/max so they know the capabilities of current
> device, otherwise it's a guessing game.. why not add it ? also we need an
> indication of when the driver doesn't support changing this config but
> still want to report default maybe when (min=3D=3Dmax). And what is the d=
efault
> expected by drivers?

I defined ETHTOOL_A_RINGS_HDS_THRESH_MAX, which indicates the maximum
value of HDS-threshold from drivers. ethtool will show this value.
I think the description needs to be changed.

I'm sure that if a driver doesn't support changing this value,
it indicates that the driver only supports 0 as hds-threshold value.
If so, I think It's okay to set ETHTOOL_A_RINGS_HDS_THRESH_MAX to 0.
This is a GVE case, GVE doesn't support changing this value,
it support only 0.

I'm also sure that there is no case that NIC doesn't support changing
HDS-thresh but the default value is not 0.

I think the default value would be 0 if there are no special cases.
The bnxt_en driver's default value is 256 because it has been being used.

>
> >In general cases, HDS can increase the overhead of host memory and PCIe
> >bus because it copies data twice.
>
> what copy twice ? do you mean copy header into skb->data ?
> this is driver implementation, other dirvers don't copy at all..

Sorry for the ambiguous description,
This means that DMA transfers the header/payload separately.

>
> >So users should consider the overhead of HDS.
> >If the HDS threshold is 0 and then the copybreak is 256 and the packet's
> >payload is 8 bytes.
> >So, two pages are used, one for headers and one for payloads.
> >By the copybreak, only the headers page is copied and then it can be
> >reused immediately and then a payloads page is still used.
> >If the HDS threshold is larger than 8, both headers and payloads are
> >copied and then a page can be recycled immediately.
> >So, too low HDS threshold has larger disadvantages than advantages
> >aspect of performance in general cases.
> >Users should consider the overhead of this feature.
> >
>
> I really don't understand this example, rx-copybreak and hds shouldn't be
> mixed up and the performance analysis you are describing above is driver
> specific, some drivers build skbs around the whole frame, and in hds arou=
nd
> the header only, meaning for non hds case rx-copybreak doesn't make lots =
of
> sense and has no advantage, and for hds it's only one copy..
>
> Maybe we should define what rx-copybreak should behave like when enabled
> with hds.. for many drivers they implement copybreak  by copying the whol=
e
> fresh into a fresh skb->data wihtout splitting the header,
> which would be wrong in case of hds enabled.
>

Sorry for the driver-specific description, I will remove this example.

I thought HDS with rx-copybreak is okay, but as per your concern,
it could change that user expects for rx-copybreak.
what do you think about it? should we disallow HDS + rx-copybreak?

Thanks a lot!
Taehee Yoo

> >Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> >Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> >---
> >
> >v5:
> > - No changes.
> >
> >v4:
> > - Fix 80 charactor wrap.
> > - Rename from tcp-data-split-thresh to header-data-split-thresh
> > - Add description about overhead of HDS.
> > - Add ETHTOOL_RING_USE_HDS_THRS flag.
> > - Add dev_xdp_sb_prog_count() helper.
> > - Add Test tag from Stanislav.
> >
> >v3:
> > - Fix documentation and ynl
> > - Update error messages
> > - Validate configuration of tcp-data-split and tcp-data-split-thresh
> >
> >v2:
> > - Patch added.
> >
> > Documentation/netlink/specs/ethtool.yaml     |  8 ++
> > Documentation/networking/ethtool-netlink.rst | 79 ++++++++++++--------
> > include/linux/ethtool.h                      |  6 ++
> > include/linux/netdevice.h                    |  1 +
> > include/uapi/linux/ethtool_netlink.h         |  2 +
> > net/core/dev.c                               | 13 ++++
> > net/ethtool/netlink.h                        |  2 +-
> > net/ethtool/rings.c                          | 37 ++++++++-
> > 8 files changed, 115 insertions(+), 33 deletions(-)
> >
> >diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/ne=
tlink/specs/ethtool.yaml
> >index 93369f0eb816..edc07cc290da 100644
> >--- a/Documentation/netlink/specs/ethtool.yaml
> >+++ b/Documentation/netlink/specs/ethtool.yaml
> >@@ -220,6 +220,12 @@ attribute-sets:
> >       -
> >         name: tx-push-buf-len-max
> >         type: u32
> >+      -
> >+        name: header-data-split-thresh
> >+        type: u32
> >+      -
> >+        name: header-data-split-thresh-max
> >+        type: u32
> >
> >   -
> >     name: mm-stat
> >@@ -1398,6 +1404,8 @@ operations:
> >             - rx-push
> >             - tx-push-buf-len
> >             - tx-push-buf-len-max
> >+            - header-data-split-thresh
> >+            - header-data-split-thresh-max
> >       dump: *ring-get-op
> >     -
> >       name: rings-set
> >diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentatio=
n/networking/ethtool-netlink.rst
> >index b25926071ece..1fdfeca6f38e 100644
> >--- a/Documentation/networking/ethtool-netlink.rst
> >+++ b/Documentation/networking/ethtool-netlink.rst
> >@@ -878,24 +878,35 @@ Request contents:
> >
> > Kernel response contents:
> >
> >-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >-  ``ETHTOOL_A_RINGS_HEADER``                nested  reply header
> >-  ``ETHTOOL_A_RINGS_RX_MAX``                u32     max size of RX ring
> >-  ``ETHTOOL_A_RINGS_RX_MINI_MAX``           u32     max size of RX mini=
 ring
> >-  ``ETHTOOL_A_RINGS_RX_JUMBO_MAX``          u32     max size of RX jumb=
o ring
> >-  ``ETHTOOL_A_RINGS_TX_MAX``                u32     max size of TX ring
> >-  ``ETHTOOL_A_RINGS_RX``                    u32     size of RX ring
> >-  ``ETHTOOL_A_RINGS_RX_MINI``               u32     size of RX mini rin=
g
> >-  ``ETHTOOL_A_RINGS_RX_JUMBO``              u32     size of RX jumbo ri=
ng
> >-  ``ETHTOOL_A_RINGS_TX``                    u32     size of TX ring
> >-  ``ETHTOOL_A_RINGS_RX_BUF_LEN``            u32     size of buffers on =
the ring
> >-  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``        u8      TCP header / data s=
plit
> >-  ``ETHTOOL_A_RINGS_CQE_SIZE``              u32     Size of TX/RX CQE
> >-  ``ETHTOOL_A_RINGS_TX_PUSH``               u8      flag of TX Push mod=
e
> >-  ``ETHTOOL_A_RINGS_RX_PUSH``               u8      flag of RX Push mod=
e
> >-  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``       u32     size of TX push buf=
fer
> >-  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX``   u32     max size of TX push=
 buffer
> >-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >+  ``ETHTOOL_A_RINGS_HEADER``                        nested  reply heade=
r
> >+  ``ETHTOOL_A_RINGS_RX_MAX``                        u32     max size of=
 RX ring
> >+  ``ETHTOOL_A_RINGS_RX_MINI_MAX``                   u32     max size of=
 RX mini
> >+                                                            ring
> >+  ``ETHTOOL_A_RINGS_RX_JUMBO_MAX``                  u32     max size of=
 RX jumbo
> >+                                                            ring
> >+  ``ETHTOOL_A_RINGS_TX_MAX``                        u32     max size of=
 TX ring
> >+  ``ETHTOOL_A_RINGS_RX``                            u32     size of RX =
ring
> >+  ``ETHTOOL_A_RINGS_RX_MINI``                       u32     size of RX =
mini ring
> >+  ``ETHTOOL_A_RINGS_RX_JUMBO``                      u32     size of RX =
jumbo
> >+                                                            ring
> >+  ``ETHTOOL_A_RINGS_TX``                            u32     size of TX =
ring
> >+  ``ETHTOOL_A_RINGS_RX_BUF_LEN``                    u32     size of buf=
fers on
> >+                                                            the ring
> >+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``                u8      TCP header =
/ data
> >+                                                            split
> >+  ``ETHTOOL_A_RINGS_CQE_SIZE``                      u32     Size of TX/=
RX CQE
> >+  ``ETHTOOL_A_RINGS_TX_PUSH``                       u8      flag of TX =
Push mode
> >+  ``ETHTOOL_A_RINGS_RX_PUSH``                       u8      flag of RX =
Push mode
> >+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``               u32     size of TX =
push
> >+                                                            buffer
> >+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX``           u32     max size of=
 TX push
> >+                                                            buffer
> >+  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH``      u32     threshold o=
f
> >+                                                            header / da=
ta split
> >+  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX``  u32     max thresho=
ld of
> >+                                                            header / da=
ta split
> >+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> >
> > ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT`` indicates whether the device is usab=
le with
> > page-flipping TCP zero-copy receive (``getsockopt(TCP_ZEROCOPY_RECEIVE)=
``).
> >@@ -930,18 +941,22 @@ Sets ring sizes like ``ETHTOOL_SRINGPARAM`` ioctl =
request.
> >
> > Request contents:
> >
> >-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >-  ``ETHTOOL_A_RINGS_HEADER``            nested  reply header
> >-  ``ETHTOOL_A_RINGS_RX``                u32     size of RX ring
> >-  ``ETHTOOL_A_RINGS_RX_MINI``           u32     size of RX mini ring
> >-  ``ETHTOOL_A_RINGS_RX_JUMBO``          u32     size of RX jumbo ring
> >-  ``ETHTOOL_A_RINGS_TX``                u32     size of TX ring
> >-  ``ETHTOOL_A_RINGS_RX_BUF_LEN``        u32     size of buffers on the =
ring
> >-  ``ETHTOOL_A_RINGS_CQE_SIZE``          u32     Size of TX/RX CQE
> >-  ``ETHTOOL_A_RINGS_TX_PUSH``           u8      flag of TX Push mode
> >-  ``ETHTOOL_A_RINGS_RX_PUSH``           u8      flag of RX Push mode
> >-  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``   u32     size of TX push buffer
> >-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >+  ``ETHTOOL_A_RINGS_HEADER``                    nested  reply header
> >+  ``ETHTOOL_A_RINGS_RX``                        u32     size of RX ring
> >+  ``ETHTOOL_A_RINGS_RX_MINI``                   u32     size of RX mini=
 ring
> >+  ``ETHTOOL_A_RINGS_RX_JUMBO``                  u32     size of RX jumb=
o ring
> >+  ``ETHTOOL_A_RINGS_TX``                        u32     size of TX ring
> >+  ``ETHTOOL_A_RINGS_RX_BUF_LEN``                u32     size of buffers=
 on the
> >+                                                        ring
> >+  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``            u8      TCP header / da=
ta split
> >+  ``ETHTOOL_A_RINGS_CQE_SIZE``                  u32     Size of TX/RX C=
QE
> >+  ``ETHTOOL_A_RINGS_TX_PUSH``                   u8      flag of TX Push=
 mode
> >+  ``ETHTOOL_A_RINGS_RX_PUSH``                   u8      flag of RX Push=
 mode
> >+  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``           u32     size of TX push=
 buffer
> >+  ``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH``  u32     threshold of
> >+                                                        header / data s=
plit
> >+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > Kernel checks that requested ring sizes do not exceed limits reported b=
y
> > driver. Driver may impose additional constraints and may not support al=
l
> >@@ -957,6 +972,10 @@ A bigger CQE can have more receive buffer pointers,=
 and in turn the NIC can
> > transfer a bigger frame from wire. Based on the NIC hardware, the overa=
ll
> > completion queue size can be adjusted in the driver if CQE size is modi=
fied.
> >
> >+``ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH`` specifies the threshold va=
lue of
> >+header / data split feature. If a received packet size is larger than t=
his
> >+threshold value, header and data will be split.
> >+
> > CHANNELS_GET
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> >index ecd52b99a63a..b4b6955d7ab9 100644
> >--- a/include/linux/ethtool.h
> >+++ b/include/linux/ethtool.h
> >@@ -79,6 +79,8 @@ enum {
> >  * @cqe_size: Size of TX/RX completion queue event
> >  * @tx_push_buf_len: Size of TX push buffer
> >  * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
> >+ * @hds_thresh: Threshold value of header-data-split-thresh
> >+ * @hds_thresh_max: Maximum allowed threshold of header-data-split-thre=
sh
> >  */
> > struct kernel_ethtool_ringparam {
> >       u32     rx_buf_len;
> >@@ -89,6 +91,8 @@ struct kernel_ethtool_ringparam {
> >       u32     cqe_size;
> >       u32     tx_push_buf_len;
> >       u32     tx_push_buf_max_len;
> >+      u32     hds_thresh;
> >+      u32     hds_thresh_max;
> > };
> >
> > /**
> >@@ -99,6 +103,7 @@ struct kernel_ethtool_ringparam {
> >  * @ETHTOOL_RING_USE_RX_PUSH: capture for setting rx_push
> >  * @ETHTOOL_RING_USE_TX_PUSH_BUF_LEN: capture for setting tx_push_buf_l=
en
> >  * @ETHTOOL_RING_USE_TCP_DATA_SPLIT: capture for setting tcp_data_split
> >+ * @ETHTOOL_RING_USE_HDS_THRS: capture for setting header-data-split-th=
resh
> >  */
> > enum ethtool_supported_ring_param {
> >       ETHTOOL_RING_USE_RX_BUF_LEN             =3D BIT(0),
> >@@ -107,6 +112,7 @@ enum ethtool_supported_ring_param {
> >       ETHTOOL_RING_USE_RX_PUSH                =3D BIT(3),
> >       ETHTOOL_RING_USE_TX_PUSH_BUF_LEN        =3D BIT(4),
> >       ETHTOOL_RING_USE_TCP_DATA_SPLIT         =3D BIT(5),
> >+      ETHTOOL_RING_USE_HDS_THRS               =3D BIT(6),
> > };
> >
> > #define __ETH_RSS_HASH_BIT(bit)       ((u32)1 << (bit))
> >diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >index 0aae346d919e..0c29068577c4 100644
> >--- a/include/linux/netdevice.h
> >+++ b/include/linux/netdevice.h
> >@@ -4028,6 +4028,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff=
 *skb, struct net_device *dev,
> >
> > int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *pr=
og);
> > u8 dev_xdp_prog_count(struct net_device *dev);
> >+u8 dev_xdp_sb_prog_count(struct net_device *dev);
> > int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
> > u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode);
> >
> >diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/e=
thtool_netlink.h
> >index 283305f6b063..7087c5c51017 100644
> >--- a/include/uapi/linux/ethtool_netlink.h
> >+++ b/include/uapi/linux/ethtool_netlink.h
> >@@ -364,6 +364,8 @@ enum {
> >       ETHTOOL_A_RINGS_RX_PUSH,                        /* u8 */
> >       ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,                /* u32 */
> >       ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,            /* u32 */
> >+      ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH,       /* u32 */
> >+      ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_MAX,   /* u32 */
> >
> >       /* add new constants above here */
> >       __ETHTOOL_A_RINGS_CNT,
> >diff --git a/net/core/dev.c b/net/core/dev.c
> >index 13d00fc10f55..0321d7cbce0f 100644
> >--- a/net/core/dev.c
> >+++ b/net/core/dev.c
> >@@ -9474,6 +9474,19 @@ u8 dev_xdp_prog_count(struct net_device *dev)
> > }
> > EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
> >
> >+u8 dev_xdp_sb_prog_count(struct net_device *dev)
> >+{
> >+      u8 count =3D 0;
> >+      int i;
> >+
> >+      for (i =3D 0; i < __MAX_XDP_MODE; i++)
> >+              if (dev->xdp_state[i].prog &&
> >+                  !dev->xdp_state[i].prog->aux->xdp_has_frags)
> >+                      count++;
> >+      return count;
> >+}
> >+EXPORT_SYMBOL_GPL(dev_xdp_sb_prog_count);
> >+
> > int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
> > {
> >       if (!dev->netdev_ops->ndo_bpf)
> >diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> >index 203b08eb6c6f..9f51a252ebe0 100644
> >--- a/net/ethtool/netlink.h
> >+++ b/net/ethtool/netlink.h
> >@@ -455,7 +455,7 @@ extern const struct nla_policy ethnl_features_set_po=
licy[ETHTOOL_A_FEATURES_WANT
> > extern const struct nla_policy ethnl_privflags_get_policy[ETHTOOL_A_PRI=
VFLAGS_HEADER + 1];
> > extern const struct nla_policy ethnl_privflags_set_policy[ETHTOOL_A_PRI=
VFLAGS_FLAGS + 1];
> > extern const struct nla_policy ethnl_rings_get_policy[ETHTOOL_A_RINGS_H=
EADER + 1];
> >-extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_T=
X_PUSH_BUF_LEN_MAX + 1];
> >+extern const struct nla_policy ethnl_rings_set_policy[ETHTOOL_A_RINGS_H=
EADER_DATA_SPLIT_THRESH_MAX + 1];
> > extern const struct nla_policy ethnl_channels_get_policy[ETHTOOL_A_CHAN=
NELS_HEADER + 1];
> > extern const struct nla_policy ethnl_channels_set_policy[ETHTOOL_A_CHAN=
NELS_COMBINED_COUNT + 1];
> > extern const struct nla_policy ethnl_coalesce_get_policy[ETHTOOL_A_COAL=
ESCE_HEADER + 1];
> >diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
> >index c12ebb61394d..ca836aad3fa9 100644
> >--- a/net/ethtool/rings.c
> >+++ b/net/ethtool/rings.c
> >@@ -61,7 +61,11 @@ static int rings_reply_size(const struct ethnl_req_in=
fo *req_base,
> >              nla_total_size(sizeof(u8))  +    /* _RINGS_TX_PUSH */
> >              nla_total_size(sizeof(u8))) +    /* _RINGS_RX_PUSH */
> >              nla_total_size(sizeof(u32)) +    /* _RINGS_TX_PUSH_BUF_LEN=
 */
> >-             nla_total_size(sizeof(u32));     /* _RINGS_TX_PUSH_BUF_LEN=
_MAX */
> >+             nla_total_size(sizeof(u32)) +    /* _RINGS_TX_PUSH_BUF_LEN=
_MAX */
> >+             nla_total_size(sizeof(u32)) +
> >+             /* _RINGS_HEADER_DATA_SPLIT_THRESH */
> >+             nla_total_size(sizeof(u32));
> >+             /* _RINGS_HEADER_DATA_SPLIT_THRESH_MAX*/
> > }
> >
> > static int rings_fill_reply(struct sk_buff *skb,
> >@@ -108,7 +112,12 @@ static int rings_fill_reply(struct sk_buff *skb,
> >            (nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
> >                         kr->tx_push_buf_max_len) ||
> >             nla_put_u32(skb, ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN,
> >-                        kr->tx_push_buf_len))))
> >+                        kr->tx_push_buf_len))) ||
> >+          ((supported_ring_params & ETHTOOL_RING_USE_HDS_THRS) &&
> >+           (nla_put_u32(skb, ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH,
> >+                        kr->hds_thresh) ||
> >+            nla_put_u32(skb, ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH_M=
AX,
> >+                        kr->hds_thresh_max))))
> >               return -EMSGSIZE;
> >
> >       return 0;
> >@@ -130,6 +139,7 @@ const struct nla_policy ethnl_rings_set_policy[] =3D=
 {
> >       [ETHTOOL_A_RINGS_TX_PUSH]               =3D NLA_POLICY_MAX(NLA_U8=
, 1),
> >       [ETHTOOL_A_RINGS_RX_PUSH]               =3D NLA_POLICY_MAX(NLA_U8=
, 1),
> >       [ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN]       =3D { .type =3D NLA_U32 }=
,
> >+      [ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH]      =3D { .type =3D N=
LA_U32 },
> > };
> >
> > static int
> >@@ -155,6 +165,14 @@ ethnl_set_rings_validate(struct ethnl_req_info *req=
_info,
> >               return -EOPNOTSUPP;
> >       }
> >
> >+      if (tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH] &&
> >+          !(ops->supported_ring_params & ETHTOOL_RING_USE_HDS_THRS)) {
> >+              NL_SET_ERR_MSG_ATTR(info->extack,
> >+                                  tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_=
THRESH],
> >+                                  "setting header-data-split-thresh is =
not supported");
> >+              return -EOPNOTSUPP;
> >+      }
> >+
> >       if (tb[ETHTOOL_A_RINGS_CQE_SIZE] &&
> >           !(ops->supported_ring_params & ETHTOOL_RING_USE_CQE_SIZE)) {
> >               NL_SET_ERR_MSG_ATTR(info->extack,
> >@@ -222,9 +240,24 @@ ethnl_set_rings(struct ethnl_req_info *req_info, st=
ruct genl_info *info)
> >                       tb[ETHTOOL_A_RINGS_RX_PUSH], &mod);
> >       ethnl_update_u32(&kernel_ringparam.tx_push_buf_len,
> >                        tb[ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN], &mod);
> >+      ethnl_update_u32(&kernel_ringparam.hds_thresh,
> >+                       tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRESH], &m=
od);
> >       if (!mod)
> >               return 0;
> >
> >+      if (kernel_ringparam.tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT=
_ENABLED &&
> >+          dev_xdp_sb_prog_count(dev)) {
> >+              NL_SET_ERR_MSG(info->extack,
> >+                             "tcp-data-split can not be enabled with si=
ngle buffer XDP");
> >+              return -EINVAL;
> >+      }
> >+
> >+      if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max=
) {
> >+              NL_SET_BAD_ATTR(info->extack,
> >+                              tb[ETHTOOL_A_RINGS_HEADER_DATA_SPLIT_THRE=
SH_MAX]);
> >+              return -ERANGE;
> >+      }
> >+
> >       /* ensure new ring parameters are within limits */
> >       if (ringparam.rx_pending > ringparam.rx_max_pending)
> >               err_attr =3D tb[ETHTOOL_A_RINGS_RX];
> >--
> >2.34.1
> >
> >

