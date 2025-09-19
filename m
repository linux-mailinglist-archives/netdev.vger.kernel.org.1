Return-Path: <netdev+bounces-224674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E1B87FE4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6387AEDD9
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 06:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDD29BDAE;
	Fri, 19 Sep 2025 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C+QsZELD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02229BDAD
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758263350; cv=none; b=bqleo5lzd28CIgFcEbtJXhmiV9pUsGcUljjLMYIUakJcm0BcZdnzi/WU1Vr+/PozDBVIMFM2Rav1+19YG1BaRuEBb82UtC0lzacmcxcRceh8a+aFtCGJunExOQPD+BsZfAQy+mtwdXcJUt3sLpxkL/PMOB5tzmjTP0q6q7XSRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758263350; c=relaxed/simple;
	bh=uzfwjgumbFwr7laxCjzuhxg+2KriU+dpv9UN4OiCbog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uo0Rd2kFgJGshR/KvFudOnTjcxSuCHsHHnJ/x2V9vdwMWVFW9NMbVVbrTWG3xMnMbTmROnPB1cS/iTwunV3dSd+si36TvP/oTCXlUJNL5dt6qOQ2NNnbSN3ycDoFxZT+I4ltn0I1XDDnvL6cn2FZSRZRA4wM/ThtiZJuoLyR3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C+QsZELD; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so1331995a91.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 23:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758263348; x=1758868148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqcrUYNGnSKH09nNEKsYPiIAAW+/2TxUpcW+Ql48jlo=;
        b=sdR91TovqGNnWBHHqWNwbgTLLZKr2fmFJq3S3sFyrn+owG1gDhgHG3CnbDryplK6nP
         IhY7PYWem6/VWl3DLmPq1sfKgxTi5j/fkFni5f5lLd9YCrP/cWYfiBrckxVyqxbME01S
         zFoXwisifl0x4M2R0gsqwmGN8QAQ9KIg8hp9wb/0rQ1HFoTtXyIqSjOUT9V5f9hb1CFt
         1wTIMyFlYeIO2+TqrOoRJNOmYQ1MUAK1neNh4+87QZnHCOXZYjiEa2vuyOWByz7LFh6K
         DTL1IGoqFai6HXRbTFjHRJd4OV6K7c+vuoAUapQXqXG+ssL414TLXTI40VAFFkIzNMq8
         4eRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnRST6NDi1T5PuR/Srjn05E4XKyHoV3xXqwEA1orFQTKNzUEmjxMQiffEMF1Fy9/WH8SWGuag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bDjp5ZSMMF8A2dYwtGiyTIM0bJebbIKnNSgdOgY/frIfoGG6
	KLRpsKxg903xHU0YXP5yrK+djTW/haPnM3x7Tq6mRRyULKz+vCyAsKrOeUdMCphRLMckEs17K1O
	v4SfziH6Q/HUx2IFZYUTZe9I4abbbMLNIGXuGwcfPl00ti8awYJbsuNtOOcvTzvXte2A0bgyu4l
	r+x8LDZZC3dG3FkQC8twwziSuGVLbF6awbYRp7/2txOV6GRqExAiRJSDwSXP6x96KFIqKxHOsvv
	IsuMms8XJNyL7fNcw==
X-Gm-Gg: ASbGncsFwV2DxlIBhBlXo+Iivu4niPimA/vWuBAG2j4N7L7K5qt8m5e3LbynULdnwRC
	6rS+FvSDbUoqbRiO4EwrhaYvbVrJ22YfjTnEg43D1Mi/0JKSBRoCV9zjt+tviYZdrghjgH9zP6O
	jaUubtomjwuUc7IZZKB4aYDPqZ4/z1sgJBag4iZr6CWcwmJWfwLbof0sxi+sxquzMFqrUFK5z5H
	Ur7vP9vlDO+Z1EznECz7CLbYfhCzabhzMQYHwXz/WRlKALg87vWD2NRL79XZJFvPOdhzi/jSGTO
	926HuF6l/AdPRX6cst779Is/UFViQXx51hpO0Dszz+InwbnQcnrTo+MtghLHlEKmJFoCR1aicno
	4RiGJQtwnCUI4rkRURzhqJDQ9jmrJCM6O+U/cuTCpd0gp5QYfCdgHmjDpMGA2rR4+XxURmGmwW+
	VEJrVwh3f7
X-Google-Smtp-Source: AGHT+IHD937rh1046o+P+8jV+37za1coMQX8eyCTGIUCwZUz+7TNPbzjp2dsDnu7t+fIqA0MEKnKpYvZ2Hxw
X-Received: by 2002:a17:90b:4d89:b0:31f:ecf:36f with SMTP id 98e67ed59e1d1-3305c591623mr8505381a91.1.1758263348193;
        Thu, 18 Sep 2025 23:29:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-330604b35afsm307066a91.0.2025.09.18.23.29.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 23:29:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2697c4e7354so17807065ad.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 23:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758263346; x=1758868146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqcrUYNGnSKH09nNEKsYPiIAAW+/2TxUpcW+Ql48jlo=;
        b=C+QsZELDjVBtkzk9oVuBx80wqsJ9Sav1qycdzjtN2U4mmG2RvxdOiNqET4iF6y+BCK
         pf5bNWCMFP6NVpohUn1RiMFT70RsFeLwepAsi7I935lxiSWugaMYfMRGa1cvNJ4L1PX3
         tcsn6YkCOA5AVN2X9VyGMX0HzwuV4RWFtHn+E=
X-Forwarded-Encrypted: i=1; AJvYcCWsI01qRlF1YZd6IKfnjVE0/Qk/iXpAvHZOadzc8EnJYlaEAKHIzRpOTyHzvGDCaYNDh8l1VmQ=@vger.kernel.org
X-Received: by 2002:a17:902:f54b:b0:25b:e5a2:fb29 with SMTP id d9443c01a7336-269b7f33d9cmr34750805ad.12.1758263346518;
        Thu, 18 Sep 2025 23:29:06 -0700 (PDT)
X-Received: by 2002:a17:902:f54b:b0:25b:e5a2:fb29 with SMTP id
 d9443c01a7336-269b7f33d9cmr34750475ad.12.1758263346118; Thu, 18 Sep 2025
 23:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
 <20250911193505.24068-10-bhargava.marreddy@broadcom.com> <aa898848-810e-4a6f-9fcf-0289e620229d@oracle.com>
In-Reply-To: <aa898848-810e-4a6f-9fcf-0289e620229d@oracle.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Fri, 19 Sep 2025 11:58:54 +0530
X-Gm-Features: AS18NWA4g6se1yHRd8pRQwxwLRc1gUdB_L_j-Q2O3237PRKUWY7oS38bVFaSUkA
Message-ID: <CANXQDtYuJNGiYswsNhwLuVvm=OJ=Nzgc8p6q+G55KykHtri+jw@mail.gmail.com>
Subject: Re: [v7, net-next 09/10] bng_en: Register default VNIC
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Thu, Sep 18, 2025 at 1:48=E2=80=AFAM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
>
>
>
> On 9/12/2025 1:05 AM, Bhargava Marreddy wrote:
> > +int bnge_hwrm_vnic_cfg(struct bnge_net *bn, struct bnge_vnic_info *vni=
c)
> > +{
> > +     struct bnge_rx_ring_info *rxr =3D &bn->rx_ring[0];
> > +     struct hwrm_vnic_cfg_input *req;
> > +     struct bnge_dev *bd =3D bn->bd;
> > +     int rc;
> > +
> > +     rc =3D bnge_hwrm_req_init(bd, req, HWRM_VNIC_CFG);
> > +     if (rc)
> > +             return rc;
> > +
> > +     req->default_rx_ring_id =3D
> > +             cpu_to_le16(rxr->rx_ring_struct.fw_ring_id);
> > +     req->default_cmpl_ring_id =3D
> > +             cpu_to_le16(bnge_cp_ring_for_rx(rxr));
> > +     req->enables =3D
> > +             cpu_to_le32(VNIC_CFG_REQ_ENABLES_DEFAULT_RX_RING_ID |
> > +                         VNIC_CFG_REQ_ENABLES_DEFAULT_CMPL_RING_ID);
> > +     vnic->mru =3D bd->netdev->mtu + ETH_HLEN + VLAN_HLEN;
>
> nit: does "struct bnge_dev" hold a netdev ?
> if not should be bn->netdev->mtu.

Thanks, Alok. Struct bnge_dev also holds netdev. But, bn->netdev->mtu
looks cleaner, so I=E2=80=99ll fix it in the next patch.

>
> > +     req->mru =3D cpu_to_le16(vnic->mru);
> > +
> > +     req->vnic_id =3D cpu_to_le16(vnic->fw_vnic_id);
> > +
> > +     if (bd->flags & BNGE_EN_STRIP_VLAN)
> > +             req->flags |=3D cpu_to_le32(VNIC_CFG_REQ_FLAGS_VLAN_STRIP=
_MODE);
> > +     if (vnic->vnic_id =3D=3D BNGE_VNIC_DEFAULT && bnge_aux_registered=
(bd))
> > +             req->flags |=3D cpu_to_le32(BNGE_VNIC_CFG_ROCE_DUAL_MODE)=
;
> > +
> > +     return bnge_hwrm_req_send(bd, req);
> > +}
>
>
> Thanks,
> Alok

