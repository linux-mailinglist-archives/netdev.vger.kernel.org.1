Return-Path: <netdev+bounces-110138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E96F392B143
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A441F22842
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 07:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40D146D6D;
	Tue,  9 Jul 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIog7Qk/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90A13AD20
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510558; cv=none; b=Ji9b5ngRKAe67eVB+w9nIVI4bnZ+US3DQ6viPSG9qxGi6YA1SWrXam2GaOXTI2ir7lXHi2l1T6nB2Rf9VMCDeuiLx+S2k5anAoMnxbPdCpdNPnclO6V/UsrtBfzqPyWYbaAHUahKBwQguVEBaz20WpXgXn7ducWlCmFw3EA4Wvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510558; c=relaxed/simple;
	bh=bk6TipIY+YZoexVbFgevxA604DBUzZ7+Qxg6gsX5klE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNcbsx/QEQ/QceKEsxK2uaDPJ5hZ5WSv6yVJYJqat27fB2ku9pnC/bQh0dm/IoMCPTquLMcRBsp1V2+WJjuUBR0OyBYoLEATj45ETWTZaPx/nR6CPrSjknC4i3YoWU105vF+jLxyeF4nQAlxublbAeMV6wa29+e0uhUkDgxcpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIog7Qk/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720510555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/aFi9ih4y79YK2CY+Ehp2n7r5MFyUbmdEljfkFAxlY=;
	b=YIog7Qk/jmXs2uh6rk8ALHCS13LBztZLXIw+s7NnyC6I10LYBFix2+RrWR11kYXn6TzfE9
	cJRbmyxKsQLt9ZMwU/xHhv7/EHxM0i4V+VQUGdWzNdHRiLLGTrJuUPOujuaPz9lv2Bf7DU
	08A5Ohc9O/5aXAoPKrUjKvLy23J2aGY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-210mkSwoPu-fRopk25xvsg-1; Tue, 09 Jul 2024 03:35:53 -0400
X-MC-Unique: 210mkSwoPu-fRopk25xvsg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-58c38bcd765so4021050a12.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 00:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510551; x=1721115351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/aFi9ih4y79YK2CY+Ehp2n7r5MFyUbmdEljfkFAxlY=;
        b=fBsv8Si6upmeq+lwFSuWNLmqMt8ZE/EgyKrinwdI64g2fJVCPdio1Fbuy6jUGWoqIH
         yU3YfcI8w+HihFvbtSRyumDtMhOifFOz/dccNf6ZXrevBp9fERh2yVPPaMg7HaZ1hwDV
         Imv+UN/FqpvZnCPYFtToaO9j8su6wmQJP1itDkJwqd4ubV3Pgb6VmXB+seQtV6v5OJ+t
         IMsmGMYHqNGXMtH7woS3yUNFy0uZk4mucOP/KjuISDPOsIiv68ZscFtntTs4vCfqePDj
         ap3TlgWxCaP9r7gvUClK5yzc19KyRi8T+VZ1thD1XA1ckURzHyWAVy+m347LN/87RicV
         gIIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMSkttXxCpNVSZzQCGewzl0VQ1OVwyfKPKTqJGUYEuvnveENT94EwcnsyBYKW+YOmPV5nb/whrjQIJtMu74M0Y7/P7fcXP
X-Gm-Message-State: AOJu0Yw2MIpKkUcRtwiUqYqMwCBavf7Ba7tv0pAQ++fTD9XJe9VdoV8P
	1H3Qk6WnHvXo4RTquSyE9VnOT1DwgtZjeRYdvtKH6CeZMcfFcAgQQuGIQ6Lik1XYjdykJ/lotxG
	AMeTSEBXnYne8D/ruJVNNihUZLBlTrbfUm7E/oefL25VzGarart83hYAhhgIkMHrhRHQbUMuRLz
	I2S2nmWgnHqPH8nOBcxsr9+bkJEcpr7VXwnlog
X-Received: by 2002:aa7:d98f:0:b0:57d:105c:c40c with SMTP id 4fb4d7f45d1cf-594bb67e9e9mr997095a12.24.1720510551377;
        Tue, 09 Jul 2024 00:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiWni+LJU+6yVhYpIE9XYIpyjrSEJCag4tVtoxMKRcXeymx8yfK8l7rFpFU9jUUkq9Rln8XyB6tiM44nsNR3c=
X-Received: by 2002:aa7:d98f:0:b0:57d:105c:c40c with SMTP id
 4fb4d7f45d1cf-594bb67e9e9mr997083a12.24.1720510551112; Tue, 09 Jul 2024
 00:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709045609.GA3082655@maili.marvell.com>
In-Reply-To: <20240709045609.GA3082655@maili.marvell.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 15:35:13 +0800
Message-ID: <CACLfguUYny6-1cYABsGS+qtdzO+MKp3O09t_gt-bMM4JgdpZqA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 12:56, Ratheesh Kannoth <rkannoth@marvell.com> wrote:
>
> On 2024-07-08 at 12:25:49, Cindy Lu (lulu@redhat.com) wrote:
> > +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> > +                               struct vdpa_device *dev,
> > +                               const struct vdpa_dev_set_config *add_config)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > +     struct mlx5_core_dev *mdev = mvdev->mdev;
> > +     struct virtio_net_config *config = &ndev->config;
> > +     int err;
> > +     struct mlx5_core_dev *pfmdev;
> nit: reverse xmas tree; may be, split assigment and definition.
>
Thanks, Will change this
Thanks
cindy
> >
>


