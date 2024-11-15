Return-Path: <netdev+bounces-145333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D02439CF14E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F419FB34F0A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D231B85D1;
	Fri, 15 Nov 2024 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfW7j8iQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5B1E4A6;
	Fri, 15 Nov 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687501; cv=none; b=au3sZnFydRNOUo+X+flSBIqSDhauQoul9fpobU9R4HddTPUrQkYbVm/+hvaMmMlZcHLV52XZc9i55awopQOaXd5sQuL9GmDhVayIKv9d1g4dIjQ+Ie2YOjOW4PobUaHPVjhTRa40TA6TTiOLzx6q7vqQT1g94nggV+FDWR8enjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687501; c=relaxed/simple;
	bh=PUQJmgEvZ1ng5xf+lwUF/L4jPRkhm2uaPJgPiZEELH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcmfBQprcRQsuN2NJGuU8PCSs0amyXIHUOGBnEjW+1rX4wjPac9+jAfFS8dfwL3imkH/suiolHdRDua7nDlg/GOSJVCVJ+BBpCampxTG8c0tk53wV0CyelSPmIJ83pCHY9O8j8HmNPUGCEOH1swPvE1hfo3EVQHcS6PvgIAwsbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfW7j8iQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so3275051a12.0;
        Fri, 15 Nov 2024 08:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731687498; x=1732292298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sSrr5iczKm1ll/ded/c4M15Et5AbusRPFHE8YPOwEg=;
        b=SfW7j8iQpaS/g07epepRPDwTh8VfpwsiRz19VvK1Qz2zpY6uylh3ifz/7tBOovsBxb
         z1XefWtgyyKtsLYRkyYm9dlgrGruk1UJ3Qks2fIiaKqW7fBKFqBjLAXLdzv+HiyJ7jKB
         mKd+fEvkG3Ip+qzKnCIqiluh8bi5dlkeqH44qFxWWeyyYoxlAdzrzWEiNeQ7pAfaB+ED
         ur9PoCeJVXqvtPYHPnox82uvhmX67QppA2vOOq0DsnL0IjPW0b7W2nOxAd5g+LgSFAYh
         H+FQJQSyqHHlvs/nDY8rADr3iP4OYFLxTMtCiLRzPtqzZr0J69mUkDrUqDemR+FdXcxk
         EcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731687498; x=1732292298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sSrr5iczKm1ll/ded/c4M15Et5AbusRPFHE8YPOwEg=;
        b=qEUkHxmsWUXaAixYZFkSMsUv8Ukt8dJcU3v4WxG0nTE3gzYaGoZ/q6cz+0SPGB/iuF
         5co0jwYM68oQmWrinSFOiVnJQFgFKbJPFiD+KWbHZzIdNh/57BJ4zZMuwD/o2KDTAPfS
         oIAw/XUXIw+oStyyOfvE/isNNzgbxhtL5wOyU0N9YmGap2DtkvADRNDsyuv8bIoifwZq
         1MS3k3Jcu6DChdtRjth360XX3gKJoCRiWbM77Y+1JKaOXvNjcY676KRuCjmTnQev1Hfe
         cBBwhfYlplEWwIpSR9a+BjX16Uc0+xqb/E3YB4Oc3QpXH0UBdIBAqCxBqYJG28At/p6L
         c7Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWD37+JDhZ4B+9/rV9siHbEkDnbO2c7mu3gCjImko3h22llPSRjzqk6Qc71C4rEHrsbkqn0gf0MfeQ=@vger.kernel.org, AJvYcCWvDK6Z2W2WIDdPawJ/4Ncu/KKVhEXBdCvQxdqVhm0nPXCatS009eksP36XKnKyqovyWgHr33RA@vger.kernel.org
X-Gm-Message-State: AOJu0YxAbTjoOz8kHmmm3xKxwMZlDAYi0zw+4mxmrQqI3cxJe61j4TJk
	zrp1fSq3Hbt1e0QdmIfcaOr6fye754KQVk5OMJkZ6hb4rxLIBhUud2XNYq/wcaVDJfHjbtW0kQI
	HHORVV7eaSmgHUFBH58HZOI2LUSo=
X-Google-Smtp-Source: AGHT+IH3jMWUtl6OFhXMk6nGfPBhMPcL3Y5FHmbcaieMSWDOsB1B/3bA9NRBdcgVq6Rd2eVJ2+d4+UGQRqc06Y5t+DM=
X-Received: by 2002:a05:6402:2807:b0:5cf:8449:e757 with SMTP id
 4fb4d7f45d1cf-5cf8fc8b6d8mr2442751a12.13.1731687497945; Fri, 15 Nov 2024
 08:18:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113173222.372128-1-ap420073@gmail.com> <20241113173222.372128-6-ap420073@gmail.com>
 <ZzZ_ub26phtVNmnK@JRM7P7Q02P> <CACKFLimmY1CBdu9VhG6nUd=o4DjdQwxHVHxbnky7qUWhZK9KDw@mail.gmail.com>
In-Reply-To: <CACKFLimmY1CBdu9VhG6nUd=o4DjdQwxHVHxbnky7qUWhZK9KDw@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 16 Nov 2024 01:18:05 +0900
Message-ID: <CAMArcTU5Ew4yrpjy9ceB4iSgU0rn_GiH0KqyZe_aGtsuAN75Og@mail.gmail.com>
Subject: Re: [PATCH net-next v5 5/7] bnxt_en: add support for
 header-data-split-thresh ethtool command
To: Michael Chan <michael.chan@broadcom.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, almasrymina@google.com, 
	donald.hunter@gmail.com, corbet@lwn.net, andrew+netdev@lunn.ch, 
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

On Fri, Nov 15, 2024 at 9:27=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:
>

Hi Michael,
Thank you so much for the review!

> On Thu, Nov 14, 2024 at 2:54=E2=80=AFPM Andy Gospodarek
> <andrew.gospodarek@broadcom.com> wrote:
> >
> > On Wed, Nov 13, 2024 at 05:32:19PM +0000, Taehee Yoo wrote:
> > > The bnxt_en driver has configured the hds_threshold value automatical=
ly
> > > when TPA is enabled based on the rx-copybreak default value.
> > > Now the header-data-split-thresh ethtool command is added, so it adds=
 an
> > > implementation of header-data-split-thresh option.
> > >
> > > Configuration of the header-data-split-thresh is allowed only when
> > > the header-data-split is enabled. The default value of
> > > header-data-split-thresh is 256, which is the default value of
> > > rx-copybreak, which used to be the hds_thresh value.
> > >
> > >    # Example:
> > >    # ethtool -G enp14s0f0np0 tcp-data-split on header-data-split-thre=
sh 256
> > >    # ethtool -g enp14s0f0np0
> > >    Ring parameters for enp14s0f0np0:
> > >    Pre-set maximums:
> > >    ...
> > >    Header data split thresh:  256
> > >    Current hardware settings:
> > >    ...
> > >    TCP data split:         on
> > >    Header data split thresh:  256
> > >
> > > Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> > > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> >
> > Tested-by: Andy Gospodarek <gospo@broadcom.com>
> >
>
> > > @@ -2362,6 +2362,8 @@ struct bnxt {
> > >       u8                      q_ids[BNXT_MAX_QUEUE];
> > >       u8                      max_q;
> > >       u8                      num_tc;
> > > +#define BNXT_HDS_THRESHOLD_MAX       256
>
> As mentioned in my comments for patch #1, our NIC can support HDS
> threshold of up to 1023, so we can set this to 1023.  Thanks.

Thanks for checking, I will change it to 1023.

Thanks a lot!
Taehee Yoo

