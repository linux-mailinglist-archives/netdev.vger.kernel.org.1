Return-Path: <netdev+bounces-138999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8259AFBB3
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C48B20F1A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 07:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329511C07F7;
	Fri, 25 Oct 2024 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbYJlMYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDBD1BA89C;
	Fri, 25 Oct 2024 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843188; cv=none; b=jNbO2oGy0YWg+NkODqAoBgyk1Cr3pN4oInfLAPeCnwZgr1lV//QEUn4l0SVxF7Xxip4di784bf728fZR5zsOdSzsBN/eO3or/b5h+MT+nkhDh4cfZpGFGqA94/O4vd7f8lxaAEZ+viRJAEyEehVgDTj6AcOjvkQu0qgle+2lJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843188; c=relaxed/simple;
	bh=ZwXF6dhZ8iT7Eodpg52WajA5XEG61/ova2qtmBug/w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpuLnp6ae3rcu1HhsevJ3iglL8fLntqTT5bD/6LpaQtqtWBIwOHfVzmokX+PXUapMHKm3xih0QTmOKwBdUesIBEO6ewvXNxpq6fo0zZcKt+e4HDPeGcBRZdDYn/jC2B6TBOhIGQdaodJ64jY5R1Au+w7bFTU2o7RPBrJo+hnXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbYJlMYx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so2234805a12.0;
        Fri, 25 Oct 2024 00:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729843184; x=1730447984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd6AcB17C3pU3euiSeTb3e11OEHc2Kd+f7cjf+IstcU=;
        b=VbYJlMYx2OA0V/6uBhMfQRx8iuoErkpF1BTFzifQ0Lf+C1e9f1Ts7LTh+sEk+QkZlr
         npiED1S+PSO2q26kJlexx7s7mhJ1OG0eBn8eVQoJjzaNCi3CoGp0sLsAXjouLgVC3rjy
         JKIzmmdCH2JsPaw3+AwyMgTYa/O7hm/YnsjqDxORbVAZJdwCFDdTDboKqjtVITa7Kfrl
         n/qd2c+DB+5/cO7pxFbbehUkTSqP576MlZX8AM9ptzJaByPNGzjFm0d/EuJbPO6lSSnt
         bt004U7EAvkqEmMbTrvsD5Z4zwkUyLoxfR4KTkL3PDOpP5R63mQ9O/UymjIofXiP7sVX
         B9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843184; x=1730447984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd6AcB17C3pU3euiSeTb3e11OEHc2Kd+f7cjf+IstcU=;
        b=DT8R3lqFeEtpwa8CzNqvVj86uVAf+PloCMxiepvyGtKqTwDKCJRsfYz6+hkMEajItO
         DfSe8ElnEm7Pv1Bz6oudMTkVT6t7dTvzuRmFUrcAk/O4CfVOVAW6xHW5WU37OsEOf4w0
         jzaBSOFwr3cQfQMnnOWQ9Jr8ls/d6F7E0DoW6i4v8YJluegElOKvYgnn32G3m59Z8k/P
         1/k3w5QAuQyGW/tUPbqC52HJRm9rUFbvtaDJMUf3L9DVRBXd8KDLhdeoBpczm0ObtAif
         C4qDDCMgOsdTXqk/jOp0AzaiwP1+0wK4iSk0cCAI1+KiDQkQ0UCoJgfR0Aikt/uu/Qku
         MUVA==
X-Forwarded-Encrypted: i=1; AJvYcCU/x16OlxPnar1PtYTa8K8/863coIV4McZl2ooLrlKp23sNyXf7MvREetKiVpqaFFk/oG3gCMb8Q/0=@vger.kernel.org, AJvYcCX383ex/PBKmhIWCiNCfEmyQV0Qnlr9XB1ko16TWcNXD98BHuRbf8qeDFbdEl3rrjwcZcvou702@vger.kernel.org
X-Gm-Message-State: AOJu0YzuA4KjjL42b+Dk/Lwa9z/dYTks1wWGYVZ9qByGQtGuLtkDDBLI
	mExdnBNLmqM2eJnX2Y3YGUYgiI0kJsS8/33Hygffg5cVhvY9aUU6BepghjvLMW1ZCUIXnJC1IQC
	gSl2EttoFsyZr/xXcFhMYqPKO6B8=
X-Google-Smtp-Source: AGHT+IHHIaNSd16mI/bK14sTWeCMGJAPpmnRGnYyr02HQfUbTxyukdwWKammtzt8sMhXILaF42N8WwEsFij6DuS7Qsk=
X-Received: by 2002:a05:6402:2792:b0:5c9:893e:30d2 with SMTP id
 4fb4d7f45d1cf-5cba244dce8mr3451100a12.8.1729843183843; Fri, 25 Oct 2024
 00:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-3-ap420073@gmail.com>
 <CACKFLikBKi2jBNG6_O1uFUmMwfBC30ef5AG4ACjVv_K=vv38PA@mail.gmail.com>
In-Reply-To: <CACKFLikBKi2jBNG6_O1uFUmMwfBC30ef5AG4ACjVv_K=vv38PA@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 25 Oct 2024 16:59:31 +0900
Message-ID: <CAMArcTWEDmw5o6uVOWS_JdPueqX+rfr1NS=ynAAjtOnhcFF+sA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/8] bnxt_en: add support for tcp-data-split
 ethtool command
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, donald.hunter@gmail.com, 
	corbet@lwn.net, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 2:02=E2=80=AFPM Michael Chan

Hi Michael,
Thank you so much for the review!

<michael.chan@broadcom.com> wrote:
>
> On Tue, Oct 22, 2024 at 9:24=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > NICs that uses bnxt_en driver supports tcp-data-split feature by the
> > name of HDS(header-data-split).
> > But there is no implementation for the HDS to enable or disable by
> > ethtool.
> > Only getting the current HDS status is implemented and The HDS is just
> > automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled=
.
> > The hds_threshold follows rx-copybreak value. and it was unchangeable.
> >
> > This implements `ethtool -G <interface name> tcp-data-split <value>`
> > command option.
> > The value can be <on>, <off>, and <auto> but the <auto> will be
> > automatically changed to <on>.
> >
> > HDS feature relies on the aggregation ring.
> > So, if HDS is enabled, the bnxt_en driver initializes the aggregation
> > ring.
> > This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.
> >
> > Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v4:
> >  - Do not support disable tcp-data-split.
> >  - Add Test tag from Stanislav.
> >
> > v3:
> >  - No changes.
> >
> > v2:
> >  - Do not set hds_threshold to 0.
> >
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  8 +++-----
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  5 +++--
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 +++++++++++++
> >  3 files changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 0f5fe9ba691d..91ea42ff9b17 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>
> > @@ -6420,15 +6420,13 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *=
bp, struct bnxt_vnic_info *vnic)
> >
> >         req->flags =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PL=
ACEMENT);
> >         req->enables =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JUMB=
O_THRESH_VALID);
> > +       req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
> >
> > -       if (BNXT_RX_PAGE_MODE(bp)) {
> > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
>
> Please explain why this "if" condition is removed.
> BNXT_RX_PAGE_MODE() means that we are in XDP mode and we currently
> don't support HDS in XDP mode.  Added Andy Gospo to CC so he can also
> comment.

Yes,
The reason why the "if" condition is removed is to make rx-copybreak
a pure software feature.

The current jumbo_thresh follows the rx-copybreak value, however,
I thought the rx-copybreak value should not affect any hardware function.
So, I thought following rx_buf_use_size instead of rx_copybreak is okay.
By this change, jumbo_thresh always follows rx_buf_use_size,
so I removed the "if" condition.
Oh, on second thought, it changes a default behavior, it's not my intention=
.
What value would be good for jumbo_thresh following?
What do you think?


>
> > -       } else {
> > +       if (bp->flags & BNXT_FLAG_AGG_RINGS) {
> >                 req->flags |=3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS=
_HDS_IPV4 |
> >                                           VNIC_PLCMODES_CFG_REQ_FLAGS_H=
DS_IPV6);
> >                 req->enables |=3D
> >                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_T=
HRESHOLD_VALID);
> > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copybreak);
> >                 req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak);
> >         }
> >         req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);

Thank you so much for the review!
Taehee Yoo

