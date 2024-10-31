Return-Path: <netdev+bounces-140616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 587429B741D
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 06:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87B9B239D0
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 05:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1B713BAE4;
	Thu, 31 Oct 2024 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fV9OuzPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A9126BFC;
	Thu, 31 Oct 2024 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730352051; cv=none; b=BWaJu9NLP1a0XMYdf3E/UY/vp5M4+v9i99XtRkE/dxjA+meIXzoX89fdvP3qd0YmLmM3M4qP7w5D20jgY7dEmFlwsZkMMaSs+VxVTRJzPyKaeNh6kVUEWz+TMRnUnk0LWfb8cHyTy1FRwwopLlcAL46CbI1qBRYrZJRj2Wip2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730352051; c=relaxed/simple;
	bh=aClHLtK+AEI94/gdFxIiOzlzJ9SMneHPTKTRAYy2zlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqL8aCCBEN8weXO2froG6W8MedG8hYDP04Hy9jhbd6E+OqeISaUl7NcEmMnmLunJR+68u498K6feeaNF6tvgiQRD2rIjzSHbskMmWq2kKv2NWPncCPQQB+08M/bA9GeJzo3Nl4YtHO89rRuaWeXp/XqQMazeqUKj07Asmtqc248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fV9OuzPN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so48082a12.0;
        Wed, 30 Oct 2024 22:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730352047; x=1730956847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmsUsqqe28XbVxqv6nSAcInoYa6pCv7UzL0hfA5wa3U=;
        b=fV9OuzPNI004oyChkd2B3BcHlf18t1YbOPjLN04nwz2cqdbvd6k0MDsBTkcTfi/JVS
         BocJTCyve9mfpTH5WRbHU6TGxtjpVCDhmeTSPDPlskzD8xjfF3qtXb31P9x+9XHZfHFO
         j5uVTdvXrSF8Y5KUQvhkUDzz1olua+2exoaZWAB9HUoaQDJPdN6byhB9ro5kLx1LT0tu
         2iLtCk2cbkCiol04zdveXD5X/oCX5fyN6E/mKnT3vcDOxaGVALLu8EjwSwdxwHqTvNdk
         2/fFljuuSvwIy57HGtTTMtZxm1h9Vdf3V0nq2Rt3AuXTxU6TvuyeDiFlHtSileI1J0Le
         SXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730352047; x=1730956847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmsUsqqe28XbVxqv6nSAcInoYa6pCv7UzL0hfA5wa3U=;
        b=TpbiPTz6aJi904t++A3X8quSlPEiiJfV0gNLZ/gYS+2khCZzqIzcKOa4v+YCwxeheM
         TqI4JWWhTexeAMBTh2mIGe+vcBAjKavzCJxByztgWqhcdn34Ra9CbB0VnZ7CNoiJbNbh
         AeE/a3+MTakpB6eKHUA2P3Fp7nz1LnQz2NoJKtwPYIx3y8RA6NsUwi9COyaLmKwSvpne
         Hb4bIEjxhZsFOX+UvlwJUaiGQSFBJinHerhn94IBgJ8CjU31+8ENqctFvtyQoAHxXrXc
         3h7Ibmj4sa6tBdcYmIOjh1mrqo71THaEg7n61dcbagIVYAmAErWA2ji1EQMO+OaHEHeB
         2oTA==
X-Forwarded-Encrypted: i=1; AJvYcCVqGGgA3u/9u0SdVlRPD4rK35HXFclzvZ19ME8OXAdQoUZkwOHcJgc77i3jhk11Kea5XUwDssZH@vger.kernel.org, AJvYcCXekG1tHEPjK4T6XWInfCVVQGIyWb2LkvtyL53WSH+veMpmD1G0VwCBjIAA/diYGwmSszeDQ4DcpRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyVxvqcRNtH2bRq/anM8+ISM68gtAzrMsRutJzL8tH8ODw1gJz
	L5Kp15HRanClXafhhfZpC1GZ6l4tI70M367S4yqDxgWorNBr5qGNxdMKN94Ol8i6FhQitr5eAk3
	ENtJS90DTLABcOP3doFxnmd6Voew=
X-Google-Smtp-Source: AGHT+IFizSI2peXzXEcoIj9qSNxVwG7SolEsGNC3ZqlOlKIfXkFbF5oCOf377eWmUfADpZXz0ofo7ek+VbCMnvNLIsk=
X-Received: by 2002:a05:6402:5109:b0:5c5:b9bb:c65a with SMTP id
 4fb4d7f45d1cf-5cea966a089mr1516274a12.1.1730352047190; Wed, 30 Oct 2024
 22:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-3-ap420073@gmail.com>
 <CACKFLikBKi2jBNG6_O1uFUmMwfBC30ef5AG4ACjVv_K=vv38PA@mail.gmail.com>
 <ZxvwZmJsdFOStYcV@JRM7P7Q02P.dhcp.broadcom.net> <CACKFLinbsMQE1jb0G-7iMKAo4ZMKp42xiSCZ0XznBV9pDAs3-g@mail.gmail.com>
 <CAMArcTWrA0ib9XHnSGGH-sNqQ9TG0BaRq+5nsGC3iQv6Zd40rQ@mail.gmail.com> <ZyKZe9a20cQwEhFd@JRM7P7Q02P.dhcp.broadcom.net>
In-Reply-To: <ZyKZe9a20cQwEhFd@JRM7P7Q02P.dhcp.broadcom.net>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 31 Oct 2024 14:20:35 +0900
Message-ID: <CAMArcTVwWp0djtXH-hXaEmm6fEyRyNTihVbxPh=dWXOiXG=t-A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/8] bnxt_en: add support for tcp-data-split
 ethtool command
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net, kuba@kernel.org, 
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

On Thu, Oct 31, 2024 at 5:39=E2=80=AFAM Andy Gospodarek
<andrew.gospodarek@broadcom.com> wrote:
>
> On Sat, Oct 26, 2024 at 02:11:15PM +0900, Taehee Yoo wrote:
> > On Sat, Oct 26, 2024 at 7:00=E2=80=AFAM Michael Chan <michael.chan@broa=
dcom.com> wrote:
> > >
> > > On Fri, Oct 25, 2024 at 12:24=E2=80=AFPM Andy Gospodarek
> > > <andrew.gospodarek@broadcom.com> wrote:
> >
> > Hi Andy,
> > Thank you so much for your review!
> >
> > > >
> > > > On Thu, Oct 24, 2024 at 10:02:30PM -0700, Michael Chan wrote:
> > > > > On Tue, Oct 22, 2024 at 9:24=E2=80=AFAM Taehee Yoo <ap420073@gmai=
l.com> wrote:
> > > > > >
> > > > > > NICs that uses bnxt_en driver supports tcp-data-split feature b=
y the
> > > > > > name of HDS(header-data-split).
> > > > > > But there is no implementation for the HDS to enable or disable=
 by
> > > > > > ethtool.
> > > > > > Only getting the current HDS status is implemented and The HDS =
is just
> > > > > > automatically enabled only when either LRO, HW-GRO, or JUMBO is=
 enabled.
> > > > > > The hds_threshold follows rx-copybreak value. and it was unchan=
geable.
> > > > > >
> > > > > > This implements `ethtool -G <interface name> tcp-data-split <va=
lue>`
> > > > > > command option.
> > > > > > The value can be <on>, <off>, and <auto> but the <auto> will be
> > > > > > automatically changed to <on>.
> > > > > >
> > > > > > HDS feature relies on the aggregation ring.
> > > > > > So, if HDS is enabled, the bnxt_en driver initializes the aggre=
gation
> > > > > > ring.
> > > > > > This is the reason why BNXT_FLAG_AGG_RINGS contains HDS conditi=
on.
> > > > > >
> > > > > > Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > > > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > > > > > ---
> > > > > >
> > > > > > v4:
> > > > > >  - Do not support disable tcp-data-split.
> > > > > >  - Add Test tag from Stanislav.
> > > > > >
> > > > > > v3:
> > > > > >  - No changes.
> > > > > >
> > > > > > v2:
> > > > > >  - Do not set hds_threshold to 0.
> > > > > >
> > > > > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  8 +++----=
-
> > > > > >  drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  5 +++--
> > > > > >  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 +++++++=
++++++
> > > > > >  3 files changed, 19 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/driver=
s/net/ethernet/broadcom/bnxt/bnxt.c
> > > > > > index 0f5fe9ba691d..91ea42ff9b17 100644
> > > > > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > > > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > > >
> > > > > > @@ -6420,15 +6420,13 @@ static int bnxt_hwrm_vnic_set_hds(struc=
t bnxt *bp, struct bnxt_vnic_info *vnic)
> > > > > >
> > > > > >         req->flags =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_=
JUMBO_PLACEMENT);
> > > > > >         req->enables =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENAB=
LES_JUMBO_THRESH_VALID);
> > > > > > +       req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
> > > > > >
> > > > > > -       if (BNXT_RX_PAGE_MODE(bp)) {
> > > > > > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_us=
e_size);
> > > > >
> > > > > Please explain why this "if" condition is removed.
> > > > > BNXT_RX_PAGE_MODE() means that we are in XDP mode and we currentl=
y
> > > > > don't support HDS in XDP mode.  Added Andy Gospo to CC so he can =
also
> > > > > comment.
> > > > >
> > > >
> > > > In bnxt_set_rx_skb_mode we set BNXT_FLAG_RX_PAGE_MODE and clear
> > > > BNXT_FLAG_AGG_RINGS
> > >
> > > The BNXT_FLAG_AGG_RINGS flag is true if the JUMBO, GRO, or LRO flag i=
s
> > > set.  So even though it is initially cleared in
> > > bnxt_set_rx_skb_mode(), we'll set the JUMBO flag if we are in
> > > multi-buffer XDP mode.  Again, we don't enable HDS in any XDP mode so
> > > I think we need to keep the original logic here to skip setting the
> > > HDS threshold if BNXT_FLAG_RX_PAGE_MODE is set.
> >
> > I thought the HDS is disallowed only when single-buffer XDP is set.
> > By this series, Core API disallows tcp-data-split only when
> > single-buffer XDP is set, but it allows tcp-data-split to set when
> > multi-buffer XDP is set.
>
> So you are saying that a user could set copybreak with ethtool (included
> in patch 1) and when a multibuffer XDP program is attached to an
> interface with an MTU of 9k, only the header will be in the first page
> and all the TCP data will be in the pages that follow?
>

I think you asked about `hds_threshold =3D bp->rx_copybreak` right?

By this patchset, rx-copybreak will be a pure software feature.
hds_threshold value will be set by `ethtool -G eth0 header-data-split-thres=
h N`.
This is implemented in 4/8 patch.
Sorry, I missed commenting in this commit message that hds_threshold
value will no longer follow bp->rx_copybreak.

If HDS is allowed when multi buffer XDP is attached, xdp program will
see only the header on the first page. But As Michael and you suggested,
HDS is not going to be allowed if XDP is attached.
If I misunderstood your question, please let me know!

> > +       if (kernel_ringparam.tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPL=
IT_ENABLED &&
> > +           dev_xdp_sb_prog_count(dev)) {
> > +               NL_SET_ERR_MSG(info->extack,
> > +                              "tcp-data-split can not be enabled with
> > single buffer XDP");
> > +               return -EINVAL;
> > +       }
> >
> > I think other drivers would allow tcp-data-split on multi buffer XDP,
> > so I wouldn't like to remove this condition check code.
> >
>
> I have no problem keeping that logic in the core kernel.  I'm just
> asking you to please preserve the existing logic since it is
> functionally equivalent and easier to read/compare to other spots where
> XDP single-buffer mode is used.

Thanks a lot for the explanation and confirmation!
I will preserve the existing logic.

>
> > I will not set HDS if XDP is set in the bnxt_hwrm_vnic_set_hds()
> > In addition, I think we need to add a condition to check XDP is set in
> > bnxt_set_ringparam().
> >
> > >
> > > > , so this should work.  The only issue is that we
> > > > have spots in the driver where we check BNXT_RX_PAGE_MODE(bp) to
> > > > indicate that XDP single-buffer mode is enabled on the device.
> > > >
> > > > If you need to respin this series I would prefer that the change is=
 like
> > > > below to key off the page mode being disabled and BNXT_FLAG_AGG_RIN=
GS
> > > > being enabled to setup HDS.  This will serve as a reminder that thi=
s is
> > > > for XDP.
> > > >
> > > > @@ -6418,15 +6418,13 @@ static int bnxt_hwrm_vnic_set_hds(struct bn=
xt *bp, struct bnxt_vnic_info *vnic)
> > > >
> > > >         req->flags =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMB=
O_PLACEMENT);
> > > >         req->enables =3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_=
JUMBO_THRESH_VALID);
> > > > +       req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_size);
> > > >
> > > > -       if (BNXT_RX_PAGE_MODE(bp)) {
> > > > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_buf_use_si=
ze);
> > > > -       } else {
> > > > +       if (!BNXT_RX_PAGE_MODE(bp) && (bp->flags & BNXT_FLAG_AGG_RI=
NGS)) {
> > > >                 req->flags |=3D cpu_to_le32(VNIC_PLCMODES_CFG_REQ_F=
LAGS_HDS_IPV4 |
> > > >                                           VNIC_PLCMODES_CFG_REQ_FLA=
GS_HDS_IPV6);
> > > >                 req->enables |=3D
> > > >                         cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_H=
DS_THRESHOLD_VALID);
> > > > -               req->jumbo_thresh =3D cpu_to_le16(bp->rx_copy_thres=
h);
> > > >                 req->hds_threshold =3D cpu_to_le16(bp->rx_copy_thre=
sh);
> > > >         }
> > > >         req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
> > > >
> >
> > Thanks a lot!
> > Taehee Yoo

