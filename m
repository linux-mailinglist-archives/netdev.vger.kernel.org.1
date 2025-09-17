Return-Path: <netdev+bounces-223915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B12B80544
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9AC47B44CD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921C82D879A;
	Wed, 17 Sep 2025 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G+nDvf96"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4639283FF9
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100675; cv=none; b=c0kLaLdJ6fqOwnR3y8rJRfRNyls6/P5o6KaOfVXJVPPGZkW9FlOzlLaXiZztR5EdvDyJN5ImjS3P51OOQ5tQbvUSstsjgjaCfPTowqs39PWxilmop/irFKHJAfFHIUfPlu+M0Nk2/R8W3VjNv3yiCt+7BzC4yi+iMx3xE6gnFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100675; c=relaxed/simple;
	bh=qm3bg1cLQIgvDbkKFLLfraSKQYjv0Ui9EAjdf1WU5nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dt75jtqibkUlValDok/kirKNE/XoFbzkWyFinb/EiCCfnsGpUZdeW1FdiYI5OLN4F/hC5Sx6SsDK8epw51cAJD0GqclQXzc8mhP1uZABJ1akpoWSwoYXR1G80JNcFhhzJh+GJSw2WFoy6IEFOzL0bg8zsBl9WGxba/zoeBJKutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G+nDvf96; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-e94d678e116so6760621276.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758100673; x=1758705473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QZjl7xUdiHrixmyewVn7wWqGdvkno1wrDDckkMZ74U=;
        b=dTe2tp8Er7Ec0PVz1k9PnoaYzejwVojcrAEKjDFFODUsm/qDB8zS63mzlp7XC4rJLY
         3JKHrFls0+efAhvawJzDue06iAtt+AxcP4f9P0LK0bimfMkLbCHtw8qjHgB+22xzSaJt
         guF2bKra6wNUTz9pPzJ9h/dBOgK34257a86SWqFzJKn5yL09hK7BXp87/VF4cCyd+mRg
         8ur5rjuKiZQHv/kVotA9wrsWzygZUHvzowEFZBed9NDy5hp7BbkbssnFCu8Q4NKT3/D/
         UBJpjA01C++PeC6PENHx1IlAyKAdJmxDlMnxtvwvap+QCEr5rzYCxNzsRehOeH9r2P+c
         cSOw==
X-Forwarded-Encrypted: i=1; AJvYcCVXtLmfCpMK+n1uGej4wfr7ve6crKAwJKu/PN1Idvrfa+FiJL9Hkgrx1DnlZJGoLRPLlnebiNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyrkvBLZL7b0Vwta9QkiDasMMHfTcQNNjYAytVCTHGQLv1tafj
	2HAqUtwBbO6wtQdbwOXvazRxDtSyKCzXYYO663+qxlavK/5vKlov3IQcn/MpAqmIcKHtUA4OBsb
	L53zWEBkfxJe7onWE6/Z6vAudmzE3ULxHmUw+aitC3aAkLv+j9EVKd7sAM+ew2yNo5EUAkPMeDe
	yBXsc/Xka/ItzajZU3ZY5sYwe5ZM7gaAJXeTvE0/M/IdqFqoyp/MRHzBk7fHeIMmsERW0vJ1oEg
	N9SQv2spg==
X-Gm-Gg: ASbGnctH81gunNh9shBXaMcMrdBxyFoSMFLelm/Y0JoX5lE3JX61Enr+mqttjY573z8
	ndgnyQmsBV0hNK+uofeIaWscxG/70Lv00Ne5CgpMreGvU+2KDvl9KpC3I4LcqgzYzcb2brSEo27
	EsWbeP/UOkcl97KzfzjvkJcF2rbIFzkTDwtgwUUKqAy2QHJsuGyEtyvTjAGwqo9cNkeETBR2jgv
	TWk3co/+sQTt1ikt3L3aPSMZ2Wp/rB2XWt/q790G9eB4i5Kk5P6Q9xxpcvX9Ajby0Lr0B7BPcgm
	b7ctweR08J1YyoXec1HQTaWX8jCR8ePf6H0XqFxEMNgPtUX1DBPkTE3S5gr49ochM9Ok/dIiond
	z0r0i5pKBaMBSgY6gEQfO3ITEgfrvbbaHVc6VksHLckLIU1JUIx+wmmdoXVgCDgLRtMj3H2nctA
	==
X-Google-Smtp-Source: AGHT+IH9LPkQg+huqkI0FU/hr3wkbK1Pedzz1ryABIA/LtYtIn/ip/2PQqCmLHMOpwJbbQ783tSHT9WkkK1G
X-Received: by 2002:a05:6902:6c09:b0:ea3:f8e4:56ef with SMTP id 3f1490d57ef6-ea5c038c0d0mr1257032276.19.1758100672596;
        Wed, 17 Sep 2025 02:17:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-ea5abe92179sm229952276.14.2025.09.17.02.17.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Sep 2025 02:17:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3234811cab3so6081378a91.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758100671; x=1758705471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QZjl7xUdiHrixmyewVn7wWqGdvkno1wrDDckkMZ74U=;
        b=G+nDvf96v9YZO2tY9XgN74lDbLnrKGhttH1Z2AIn12uCl4BH1UOr34qpJi+rX+o/yP
         k9CZrn5xtsMxvAihchVrLlKP/fpjiYL76Xz9CkuPPrWFwkkcJDDgoY3vfPXCyT/VmAZs
         mg1hDo5+36xRnYcF4cxT+3sBG/wI9g3htUnD0=
X-Forwarded-Encrypted: i=1; AJvYcCW8xpTqfnjBChfhl210uNzVezcM5OKaq9wxFXuL8/0wSpUKeVdXLIspW5JlGiwN8BeD6zWyeqs=@vger.kernel.org
X-Received: by 2002:a17:90b:3b43:b0:32e:2798:9064 with SMTP id 98e67ed59e1d1-32ee3f53712mr1779585a91.35.1758100670767;
        Wed, 17 Sep 2025 02:17:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3b43:b0:32e:2798:9064 with SMTP id
 98e67ed59e1d1-32ee3f53712mr1779551a91.35.1758100670350; Wed, 17 Sep 2025
 02:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-3-siva.kallam@broadcom.com> <20250916123412.GZ224143@horms.kernel.org>
In-Reply-To: <20250916123412.GZ224143@horms.kernel.org>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Wed, 17 Sep 2025 14:47:38 +0530
X-Gm-Features: AS18NWC1FAX_3F4P8tDVwYa487VwQeeRgPm_3QNeMr2aLN-dKga9hLjkT3q0MYs
Message-ID: <CAMet4B5jDjzbi15f7jNvs31hGgX-pidtC_uvd7+dMjgay4=Law@mail.gmail.com>
Subject: Re: [PATCH 2/8] RDMA/bng_re: Add Auxiliary interface
To: Simon Horman <horms@kernel.org>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, Usman Ansari <usman.ansari@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, Sep 16, 2025 at 6:04=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Aug 29, 2025 at 12:30:36PM +0000, Siva Reddy Kallam wrote:
> > Add basic Auxiliary interface to the driver which supports
> > the BCM5770X NIC family.
> >
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
>
> ...
>
> > diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniban=
d/hw/bng_re/bng_dev.c
>
> ...
>
> > +static int bng_re_add_device(struct auxiliary_device *adev)
> > +{
> > +     struct bnge_auxr_priv *auxr_priv =3D
> > +             container_of(adev, struct bnge_auxr_priv, aux_dev);
> > +     struct bng_re_en_dev_info *dev_info;
> > +     struct bng_re_dev *rdev;
> > +     int rc;
> > +
> > +     dev_info =3D auxiliary_get_drvdata(adev);
> > +
> > +     rdev =3D bng_re_dev_add(adev, auxr_priv->auxr_dev);
> > +     if (!rdev || !rdev_to_dev(rdev)) {
>
> Hi Siva,
>
> Sorry if somehow this is a duplicate, it got stuck in my outbox somehow.
>
> GCC 15.1.0 says:
>
>   .../bng_dev.c: In function 'bng_re_add_device':
>   .../bng_dev.c:54:22: warning: the comparison will always evaluate as 't=
rue' for the address of 'dev' will never be NULL [-Waddress]
>      54 |         if (!rdev || !rdev_to_dev(rdev)) {
>         |                      ^
>   In file included from drivers/infiniband/hw/bng_re/bng_dev.c:8:
>   ./include/rdma/ib_verbs.h:2812:41: note: 'dev' declared here
>    2812 |                 struct device           dev;
>         |
>
> > +             rc =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     dev_info->rdev =3D rdev;
> > +
> > +     return 0;
> > +exit:
> > +     return rc;
> > +}
Hi Simon,
No problem. rdev_to_dev check is not needed. We will fix it in the
next version of the patchset.
Thanks
>
> ...

