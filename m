Return-Path: <netdev+bounces-131751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B028798F6DE
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB481F21C0F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E181ABEBD;
	Thu,  3 Oct 2024 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKNXzzeM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A47768FD;
	Thu,  3 Oct 2024 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982840; cv=none; b=F5Q9p4oWzY0K83VZtDl+4ou7HKYxmR84qsF1sMMVRQdgY26pmuFLHjHkAFOn2YnMX3yU/qyZlG2Qz+dFWcB4I+/urNvnjwAbzRc0TM8DCxfarFQh6qcnJzsPKkmv0FI+t64tzvaslj56gbpELcJY7CORBTTg2/C8ovjJs6ZsXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982840; c=relaxed/simple;
	bh=rUpIlU9CxfluuN2X6xBMhc5YUcJlcPM5txNkuRo1cfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuWyfX22CFI4ectnaNVzKoF2HzUVG9Z1h0MyGcwoRF0aoIJYSTipeJerffVbYg3XmsG6b+K4jE3pvZrNPQFilhHEk/WZlaZbTlZdHTcCYY3sV5tuoRq1worIdqLXeEofA2nl8BR2EzzuGXm+HZ5CmjDEbvrPHtifCdLd8htVCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKNXzzeM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5398e53ca28so1574862e87.3;
        Thu, 03 Oct 2024 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727982837; x=1728587637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUpIlU9CxfluuN2X6xBMhc5YUcJlcPM5txNkuRo1cfA=;
        b=LKNXzzeM8Op8BsTUg7PrxXsUETUYB2NnsJMJRERPONc3CdkZqX52jyhG9tsY66uM60
         T7RjXlGbAbGJlYY9RAeECX4CDvz5SFVD9kPnDhNQlMj6pIo+mSAMfJWYopWWDuqRn8yh
         7odXShpP3U/2G3IoF2vQ2FoX5V4IqbhhWwXoKytbVnoOZN5I6ak5VLqDj7XcwimsVOHN
         am4NHt1qst47ilrxzGYfE504rvNjXuR8t59xMq30mmjmgVU7JDrtEOpt7OkzarIgBtO+
         JiCXldqkUo2djLy+ifWhApsMej8acmLa3OiY4ax3qVaaac7orS6V/oXlK22ygfNJJ7AL
         rc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727982837; x=1728587637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUpIlU9CxfluuN2X6xBMhc5YUcJlcPM5txNkuRo1cfA=;
        b=H1kogJlPD9A4NAIPIAdvaxP2Rr3r9jqWVnLqX6UjcWEVoTXY+be+sNRJNo7F3Eowuw
         lv17GWfUGw0toi7ObmWui/lBKHEYWxpOoirOBW4DSFqKcvf2WzprG5AAQmTisXL27VPL
         YNDxmeDhcY/oynGmeX1r1C3KJhsIVR0+P+u7+ncYT7Z2c971ELaOVclSsxNI7JgEFtNp
         /Y0qlItPnjITHlZ8KqAUUoL/tEnILh1VpK4voXZGzPIPZqz6P2H9dPoeTAJpS7k6POi6
         qcx5nQX7wiO9NvM7zLoldrv/PYEQbFpzcfBzJQydzJtmjmutkMG9RzJ29GcBisVrF9An
         TfBA==
X-Forwarded-Encrypted: i=1; AJvYcCVPMDV8kAhTnyL5aUZkqERIOTYugRhMgksd/Hj3SxfidHFdvgqJHVAsvGnkIeMznm2wFmTbWUJY@vger.kernel.org, AJvYcCWoML6mxI9yYSyGI5Q5+OOzOVsv3y8ZLNMKIkMEeXuotlqT1qHi/gm4t460v/H8oGan2csEEWkNa0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAnx4EY7uCVsLXEnwMEcs22oJUx0yHdt+R0LdY33+P/Rpxlzk
	6XUPNNVCQh3IFxin4G+qnVIkxpwAddAsbnAmaXBuUFQ+SIXVrss1sSdwoY7L7+AiYkbOfeGKkoV
	gSVxc/EtOvP82Smg4W8/7L5StOFo=
X-Google-Smtp-Source: AGHT+IEmnB3eGreIjWOb6opisiIa52GM2HVtMY/aA2HRWo3FEUHoTXl+HWYb+rccvXwXxMqlsy+LvJimS6X/dYUCMfI=
X-Received: by 2002:a05:6512:3d87:b0:52e:9b9e:a6cb with SMTP id
 2adb3069b0e04-539ab876cedmr237065e87.15.1727982836210; Thu, 03 Oct 2024
 12:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-5-ap420073@gmail.com>
 <0913d63c-1df5-407a-a7c0-d5bef0210e8e@amd.com>
In-Reply-To: <0913d63c-1df5-407a-a7c0-d5bef0210e8e@amd.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 4 Oct 2024 04:13:44 +0900
Message-ID: <CAMArcTVQi2j-i4jk+ZgSafz=+Dc96Ls1bha2G3giX3U2VjuEtw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] bnxt_en: add support for
 tcp-data-split-thresh ethtool command
To: Brett Creeley <bcreeley@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, kory.maincent@bootlin.com, andrew@lunn.ch, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, paul.greenwalt@intel.com, rrameshbabu@nvidia.com, 
	idosch@nvidia.com, asml.silence@gmail.com, kaiyuanz@google.com, 
	willemb@google.com, aleksander.lobakin@intel.com, dw@davidwei.uk, 
	sridhar.samudrala@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:13=E2=80=AFAM Brett Creeley <bcreeley@amd.com> wro=
te:
>
>
>
> On 10/3/2024 9:06 AM, Taehee Yoo wrote:
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > The bnxt_en driver has configured the hds_threshold value automatically
> > when TPA is enabled based on the rx-copybreak default value.
> > Now the tcp-data-split-thresh ethtool command is added, so it adds an
> > implementation of tcp-data-split-thresh option.
> >
> > Configuration of the tcp-data-split-thresh is allowed only when
> > the tcp-data-split is enabled. The default value of
> > tcp-data-split-thresh is 256, which is the default value of rx-copybrea=
k,
> > which used to be the hds_thresh value.
> >
> > # Example:
> > # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 256
> > # ethtool -g enp14s0f0np0
> > Ring parameters for enp14s0f0np0:
> > Pre-set maximums:
> > ...
> > TCP data split thresh: 256
> > Current hardware settings:
> > ...
> > TCP data split: on
> > TCP data split thresh: 256
> >
> > It enables tcp-data-split and sets tcp-data-split-thresh value to 256.
> >
> > # ethtool -G enp14s0f0np0 tcp-data-split off
> > # ethtool -g enp14s0f0np0
> > Ring parameters for enp14s0f0np0:
> > Pre-set maximums:
> > ...
> > TCP data split thresh: 256
> > Current hardware settings:
> > ...
> > TCP data split: off
> > TCP data split thresh: n/a
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v3:
> > - Drop validation logic tcp-data-split and tcp-data-split-thresh.
> >
> > v2:
> > - Patch added.
> >
> > drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
> > drivers/net/ethernet/broadcom/bnxt/bnxt.h | 2 ++
> > drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ++++
> > 3 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index f046478dfd2a..872b15842b11 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -4455,6 +4455,7 @@ static void bnxt_init_ring_params(struct bnxt *bp=
)
> > {
> > bp->rx_copybreak =3D BNXT_DEFAULT_RX_COPYBREAK;
> > bp->flags |=3D BNXT_FLAG_HDS;
> > + bp->hds_threshold =3D BNXT_DEFAULT_RX_COPYBREAK;
> > }
> >
> > /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flag=
s must
> > @@ -6429,7 +6430,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp=
, struct bnxt_vnic_info *vnic)
> > VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
> > req->enables |=3D
> > cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
> > - req->hds_threshold =3D cpu_to_le16(bp->rx_copybreak);
> > + req->hds_threshold =3D cpu_to_le16(bp->hds_threshold);
> > }
> > req->vnic_id =3D cpu_to_le32(vnic->fw_vnic_id);
> > return hwrm_req_send(bp, req);
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.h
> > index 35601c71dfe9..48f390519c35 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > @@ -2311,6 +2311,8 @@ struct bnxt {
> > int rx_agg_nr_pages;
> > int rx_nr_rings;
> > int rsscos_nr_ctxs;
> > +#define BNXT_HDS_THRESHOLD_MAX 256
> > + u16 hds_threshold;
>
> Putting this here creates a 2 byte hole right after hds_threshold and
> also puts a 4 byte hole after cp_nr_rings.
>
> Since hds_threshold doesn't seem to be used in the hotpath maybe it
> would be best to fill a pre-existing hole in struct bnxt to put it?
>

Yes, hds_threshold makes an additional 2bytes hole.
I checked pre-existing holes in struct bnxt, and almost all members
are sorted by purpose.
However, I think under num_tc would be a pretty good place for hds_threshol=
d.

Before:
/* size: 7000, cachelines: 110, members: 185 */
/* sum members: 6931, holes: 21, sum holes: 64 */
/* sum bitfield members: 2 bits, bit holes: 1, sum bit holes: 6 bits */
/* padding: 4 */
/* paddings: 7, sum paddings: 25 */
/* last cacheline: 24 bytes */

After:
/* size: 6992, cachelines: 110, members: 185 */
/* sum members: 6931, holes: 19, sum holes: 56 */
/* sum bitfield members: 2 bits, bit holes: 1, sum bit holes: 6 bits */
/* padding: 4 */
/* paddings: 7, sum paddings: 25 */
/* last cacheline: 16 bytes */

So, I would like to change it in a v4 patch if there are no objections.

Thanks a lot!
Taehee Yoo

> Thanks,
>
> Brett
>
> >
> > u32 tx_ring_size;
> > u32 tx_ring_mask;
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/driver=
s/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > index e9ef65dd2e7b..af6ed492f688 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > @@ -839,6 +839,9 @@ static void bnxt_get_ringparam(struct net_device *d=
ev,
> > else
> > kernel_ering->tcp_data_split =3D ETHTOOL_TCP_DATA_SPLIT_DISABLED;
> >
> > + kernel_ering->tcp_data_split_thresh =3D bp->hds_threshold;
> > + kernel_ering->tcp_data_split_thresh_max =3D BNXT_HDS_THRESHOLD_MAX;
> > +
> > ering->tx_max_pending =3D BNXT_MAX_TX_DESC_CNT;
> >
> > ering->rx_pending =3D bp->rx_ring_size;
> > @@ -871,6 +874,7 @@ static int bnxt_set_ringparam(struct net_device *de=
v,
> > case ETHTOOL_TCP_DATA_SPLIT_UNKNOWN:
> > case ETHTOOL_TCP_DATA_SPLIT_ENABLED:
> > bp->flags |=3D BNXT_FLAG_HDS;
> > + bp->hds_threshold =3D (u16)kernel_ering->tcp_data_split_thresh;
> > break;
> > case ETHTOOL_TCP_DATA_SPLIT_DISABLED:
> > bp->flags &=3D ~BNXT_FLAG_HDS;
> > --
> > 2.34.1
> >

