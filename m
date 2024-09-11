Return-Path: <netdev+bounces-127454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498B5975763
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38521F25ABD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8B01AB6FD;
	Wed, 11 Sep 2024 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS9Edj4t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B61AB6C4;
	Wed, 11 Sep 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069377; cv=none; b=MH/uNvmJ8r+9KUJb0MpkEQYLWO2HNYgb2UsXnqIPBEMqjubwKlq7iAsVDQO2ZZm56od+a5q1u12dRd0f07N/mSbfslKBPYgttinaDGKPYPPwtAHA5t7v4v9f6d5AB0ONOfTjx8NA9p2bczgoUmRMY85sIhyRoojPvjf7TZcYrnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069377; c=relaxed/simple;
	bh=MbvVqZGONoi9xRogSHKwRv0mgVBMPrhMOqpZF6LdC8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGP8bCYLF3RmJfcphNXeGm1MHSe4+ON7S7m6CNq+zFGtjQQmedmsg0KldRM0NzeR529OZwvy7zl5FFbKZrpr46TnLa1sXRiNnuvqNMyb0UzLCInzqZ70amj1mu1yGP25uqMArD7JmO4319IYLfrLwVAao/qgifk86tVOBfMkf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BS9Edj4t; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso2461691a12.3;
        Wed, 11 Sep 2024 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726069374; x=1726674174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGIspQpkeVQDpNq/uFmnrcfXuIOQPJvDSgxM7vSKnDY=;
        b=BS9Edj4tRL1iWCeV1QF7uyEYSEoKhOpzpRh9IGeAxyHRwm3mGb5GSjigwaAdKQD37z
         2ObWq8WOXwQcsZ9HhXfHYZp9s7PiQasBk1nqa7JuyDbSXs7YttLc94GvuwSpsDYUx/A+
         Jqb/O+FKrMzrbuAZi30zThStoWT8puuVc2EyWKdO9geXX1ax7fNGS+C/ZaB8rObYBXIV
         rqTCPSdHD/e2kyZrrHS/w0/D0tSgra646d8NDjQdyUVh68C4OInuUCMKFh3kLk4m+tOq
         IaunxGD+V71S0cJ27SbLnGggaZsmrhv1l3sZfZhHDONwEytCTMt9EnZh+GMnNuJMd4cv
         F0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726069374; x=1726674174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGIspQpkeVQDpNq/uFmnrcfXuIOQPJvDSgxM7vSKnDY=;
        b=mFR1pXDWlKET4WNnoBkt3ykeSAZuJJ94+uLOog8lojL3Nk+HnKc2gWJK2eAnDhyigB
         deoETpeDRAk7WVxk4RVP5oOH8ss7UGzviJGmzgXigV5RRDq/ao7QwlVcvIDsnE8ej2ku
         YT3lT+JnUxW4Lhaif9+yEKZt0+faH2xP5Q+hUYSOPf9CjNSH9m4zBUgbJjSSLa6rSt5a
         5RwTA+Pr/cmbbvEYoIC0h9ypLgETvzIdT+U/3pDKBaRnIO1blOEEcg3CW0iDsP5OPIxn
         7D25uHQq0hxPSEb0fC5NPYHaFrwzx3vHsIjOqIU5I5J860wbUAp1m48BGHijwIUL/Xcd
         5n1w==
X-Forwarded-Encrypted: i=1; AJvYcCUTiS95qJseKAlFC7sXtkxcNu/yR5ISO9t5D2CcIuOAw7ab5ThLZ2KDq1GsM6BsloZXd0itBu/P4qE=@vger.kernel.org, AJvYcCXrHQZGvuEJImAvrTcfLA3qToz+RJM272PDgTOhxwi+Amq3TBiBtHMAp4RktUXlLZ47NYeAmMju@vger.kernel.org
X-Gm-Message-State: AOJu0YwdWZd6B1PhVJ8PPhelIKKo4oz9ka88xvh0qn6QyKab9XxDtAVr
	VFygzkOBBrPVakPdqgOf5fogIhIjTysXBayM7+8ChMquq2EZdIs7CZX5VhPrsPDvVtuJ1tC6iMy
	HAp7qdIcQZUFklpqrqyD4TnuDCfw=
X-Google-Smtp-Source: AGHT+IG221I51edoVedLxSDYG3TjVyZESt6QVmRnWFHYfxUWuKeAya9Q/xYmjIT+3Mk9PdOPa2YzVLTnCC1D/3stMms=
X-Received: by 2002:a05:6402:90a:b0:5c2:5f07:9f65 with SMTP id
 4fb4d7f45d1cf-5c40bc2d913mr3075250a12.18.1726069374162; Wed, 11 Sep 2024
 08:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911145555.318605-1-ap420073@gmail.com> <20240911145555.318605-4-ap420073@gmail.com>
 <20240911172642.28c7cb96@kmaincent-XPS-13-7390>
In-Reply-To: <20240911172642.28c7cb96@kmaincent-XPS-13-7390>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 12 Sep 2024 00:42:42 +0900
Message-ID: <CAMArcTUXpDHW2+67gT5tUh9Sw-02zVMGWD85fjmuJ2vy431Ydw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] ethtool: Add support for configuring tcp-data-split-thresh
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, corbet@lwn.net, michael.chan@broadcom.com, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, paul.greenwalt@intel.com, rrameshbabu@nvidia.com, 
	idosch@nvidia.com, maxime.chevallier@bootlin.com, danieller@nvidia.com, 
	aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 12:26=E2=80=AFAM Kory Maincent
<kory.maincent@bootlin.com> wrote:
>

Hi Kory, Thank you so much for the review!

> On Wed, 11 Sep 2024 14:55:54 +0000
> Taehee Yoo <ap420073@gmail.com> wrote:
>
> > The tcp-data-split-thresh option configures the threshold value of
> > the tcp-data-split.
> > If a received packet size is larger than this threshold value, a packet
> > will be split into header and payload.
> > The header indicates TCP header, but it depends on driver spec.
> > The bnxt_en driver supports HDS(Header-Data-Split) configuration at
> > FW level, affecting TCP and UDP too.
> > So, like the tcp-data-split option, If tcp-data-split-thresh is set,
> > it affects UDP and TCP packets.
>
> Could you add a patch to modify the specs accordingly?
> The specs are located here: Documentation/netlink/specs/ethtool.yaml
> You can use ./tools/net/ynl tool and these specs to test ethtool netlink
> messages.
>
> Use this to verify that your specs update are well written.
> $ make -C tools/net/ynl

Thanks a lot! I will add a patch for ethtool.yaml.

>
> > diff --git a/Documentation/networking/ethtool-netlink.rst
> > b/Documentation/networking/ethtool-netlink.rst index
> > ba90457b8b2d..bb74e108c8c1 100644 ---
> > a/Documentation/networking/ethtool-netlink.rst +++
> > b/Documentation/networking/ethtool-netlink.rst @@ -892,6 +892,7 @@ Kern=
el
> > response contents: ``ETHTOOL_A_RINGS_RX_PUSH``               u8      fl=
ag of
> > RX Push mode ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``       u32     size of =
TX
> > push buffer ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX``   u32     max size =
of TX
> > push buffer
> > +  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH`` u32     threshold of TDS
> >    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> It seems there is a misalignment here. You need two more '=3D=3D'
>
> >  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT`` indicates whether the device is usa=
ble
> > with @@ -927,18 +928,20 @@ Sets ring sizes like ``ETHTOOL_SRINGPARAM`` =
ioctl
> > request.
> >  Request contents:
> >
> > -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -  ``ETHTOOL_A_RINGS_HEADER``            nested  reply header
> > -  ``ETHTOOL_A_RINGS_RX``                u32     size of RX ring
> > -  ``ETHTOOL_A_RINGS_RX_MINI``           u32     size of RX mini ring
> > -  ``ETHTOOL_A_RINGS_RX_JUMBO``          u32     size of RX jumbo ring
> > -  ``ETHTOOL_A_RINGS_TX``                u32     size of TX ring
> > -  ``ETHTOOL_A_RINGS_RX_BUF_LEN``        u32     size of buffers on the=
 ring
> > -  ``ETHTOOL_A_RINGS_CQE_SIZE``          u32     Size of TX/RX CQE
> > -  ``ETHTOOL_A_RINGS_TX_PUSH``           u8      flag of TX Push mode
> > -  ``ETHTOOL_A_RINGS_RX_PUSH``           u8      flag of RX Push mode
> > -  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``   u32     size of TX push buffer
> > -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +  ``ETHTOOL_A_RINGS_HEADER``                nested  reply header
> > +  ``ETHTOOL_A_RINGS_RX``                    u32     size of RX ring
> > +  ``ETHTOOL_A_RINGS_RX_MINI``               u32     size of RX mini ri=
ng
> > +  ``ETHTOOL_A_RINGS_RX_JUMBO``              u32     size of RX jumbo r=
ing
> > +  ``ETHTOOL_A_RINGS_TX``                    u32     size of TX ring
> > +  ``ETHTOOL_A_RINGS_RX_BUF_LEN``            u32     size of buffers on=
 the
> > ring
> > +  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``        u8      TCP header / data =
split
> > +  ``ETHTOOL_A_RINGS_CQE_SIZE``              u32     Size of TX/RX CQE
> > +  ``ETHTOOL_A_RINGS_TX_PUSH``               u8      flag of TX Push mo=
de
> > +  ``ETHTOOL_A_RINGS_RX_PUSH``               u8      flag of RX Push mo=
de
> > +  ``ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN``       u32     size of TX push bu=
ffer
> > +  ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT_THRESH`` u32     threshold of TDS
> > +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> same here.

Thanks, I will fix this too.

>
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

Thanks a lot!
Taehee Yoo

