Return-Path: <netdev+bounces-148891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0293C9E357F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C488E1611AB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E19944F;
	Wed,  4 Dec 2024 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jejwctSc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9AE194147;
	Wed,  4 Dec 2024 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301204; cv=none; b=AjP1dSxGQsQuTU+HmYsQaeaXDoz+IeiU8lr0mDdxh+BtH0x4IcYwvYQC5P9oI7cxQgPsgxK47LkSEdyT4kJ5FzZP9TLfo+vRjPBc6oZYVFckBjkC+qdrq3arbftyMuCs3EMbZGznA1HeqQtWR0siB2EtjSPCQjD5E/8CvREOhbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301204; c=relaxed/simple;
	bh=qtKWy1+3TKEbOo8X493bzRcNN46Y+m4kM9GVR6iOJk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwhvBZaEWLMrM/qjEYYagxFC4QQIvt+JOdcSykMZ5jejoLfDBw3cclfbGmDV4uhK7snTC+pbpL6pKDRLaC0QvgCMOOQfFJXueq0fCNOZLzXn8POhNO9+9Hqu73ToEcBlMVH7fJ1n3zNSfEkEoeqfW8lzCqSK9ccSSS8vjdWDseM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jejwctSc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso2189886f8f.0;
        Wed, 04 Dec 2024 00:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733301201; x=1733906001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpH2cFjmsRs5iOKVHt+Ux3PzJGbqCr566H1JMqhK6/k=;
        b=jejwctScso1ueVsmvk8VrJVhQ9JsosEsaOiKJ10U56YFnhD8XDWA4pWXXyFE9WWp5B
         qdaJVK7mkJpXaq3WimT1WZo5GWLCQlVSmu/72sVzi8f7DVR2y2XM4itdxbVxvMYtiAJ5
         33CXkjAOy8SPc7sSGCv3dsfyHBYNk7dArHKAL/YzU1O6cd7cNU45ltPGv2y1Ud0V/VbY
         3nGJtSvo2fm937H+ptB0pyeWUuiAUyk7wFKcDLMNrWNGm6Hvw3/J3sgxFFT9jKEn6u2C
         whpSgoLcpTQYKtZc7OasPNe2Wl7fd/7jVp0LVpkN2XG9C8wT97qfsd+BE0EGjENfh/ry
         +mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733301201; x=1733906001;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpH2cFjmsRs5iOKVHt+Ux3PzJGbqCr566H1JMqhK6/k=;
        b=LvW2fWEEPciMrS+JFYKJUSqNft3rKGJk3co0LtjRykjj2KcWE4l1m8lwEQxFJycn//
         Pti1SEtzOCK71D9JVgJblN8NgtOxoQuh/20/q+cTdLbCK8SDPfz0dSQT7l1D3I/Jq2mG
         gd4YxATL8GIDOpHFzHNVejWg6tfrPm86WVc5Wbpn//pug15ixmb7ma7ocgsLTN4paKIJ
         uVNQ3sG45VZ5qAPlDeT5/UBE17MXc2IenyCdH+dcdBqJjkYMuftnaCfjdVpPa65uhILS
         aaG8sOyvprIZ5NtsK+d882KS3Y0xibxSMHZaq38liLdvW0OzkYEKo06JoHKoh4ESrxoQ
         CECg==
X-Forwarded-Encrypted: i=1; AJvYcCX/q58b5I7dlffo1HFQevzPv35qKlAFbss+AhkISJBVTDpjbbzTlt1cJ26fc6vTp+sJMTkG00qesI4=@vger.kernel.org, AJvYcCXcHTHglj9Bdhsk/C6hM+NfByxtRAyDwmtz9lUH1Z34dtaZobaVfifbypw/DElokg6yBDiA3Vmy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XtTGZTRcZpGEPapkjlXEPJhRNgI6Vx6SDndI41tdhaHO+8pL
	khH4HvfMnG0MUsmzP3KFFE3yX3KiHNogHFS5t1V5rrj+J8vFykuUi4rkUw==
X-Gm-Gg: ASbGncszALUN+YeTUwUhSn/QK/Gz3+TUpRwuDfUoTL/rWq+StSicpI/kWLf4T9+XmqQ
	+v7u7SWRKn2PbRIrFMTljmaszOYZXe8HQH83NpS6rq9XNgS4FMia/66QHTWkmkvckXGVd2Ebihf
	WTbkT0QZCau3f0LoYwjvPdTszsYYulcqfoWcP+e/nYi98BvQKdn1SO8w40tznmsWh6uY3fuGIVJ
	SIeYvyKn8AtT0INmdWJ/GZ3r9a+NY5NHU8LcryrYd6XKtwvLWs=
X-Google-Smtp-Source: AGHT+IFE2pGcS4AkKwzeCHdkt5QwQXOZnVFjzA1hG6M5E6ERfTgRD/qkS6g0O4V2Po2aTc3HWGoTxQ==
X-Received: by 2002:a05:6000:1787:b0:385:f16d:48aa with SMTP id ffacd0b85a97d-385fd3e8906mr5088317f8f.15.1733301200805;
        Wed, 04 Dec 2024 00:33:20 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e1824ec4sm13228947f8f.108.2024.12.04.00.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 00:33:19 -0800 (PST)
Date: Wed, 4 Dec 2024 08:33:21 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v6 23/28] sfc: create cxl region
Message-ID: <20241204083321.GA792395@gmail.com>
Mail-Followup-To: Alejandro Lucero Palau <alucerop@amd.com>,
	alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-24-alejandro.lucero-palau@amd.com>
 <20241203143749.GH778635@gmail.com>
 <19ccef4d-fcf9-d772-4a5a-4e57779ecae6@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ccef4d-fcf9-d772-4a5a-4e57779ecae6@amd.com>

On Tue, Dec 03, 2024 at 03:25:27PM +0000, Alejandro Lucero Palau wrote:
> 
> 
> On 12/3/24 14:37, Martin Habets wrote:
> > On Mon, Dec 02, 2024 at 05:12:17PM +0000, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Use cxl api for creating a region using the endpoint decoder related to
> > > a DPA range.
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> > One comment below.
> > 
> > > ---
> > >   drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> > > index 6ca23874d0c7..3e44c31daf36 100644
> > > --- a/drivers/net/ethernet/sfc/efx_cxl.c
> > > +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> > > @@ -128,10 +128,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> > >   		goto err3;
> > >   	}
> > > +	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
> > > +	if (!cxl->efx_region) {
> > > +		pci_err(pci_dev, "CXL accel create region failed");
> > This error would be more meaningful if it printed out the region address and size.
> > 
> 
> The region can not be created so we have not that info.

Ahh, ok.

Martin

> 
> 
> > > +		rc = PTR_ERR(cxl->efx_region);
> > > +		goto err_region;
> > > +	}
> > > +
> > >   	probe_data->cxl = cxl;
> > >   	return 0;
> > > +err_region:
> > > +	cxl_dpa_free(cxl->cxled);
> > >   err3:
> > >   	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
> > >   err2:
> > > @@ -144,6 +153,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> > >   void efx_cxl_exit(struct efx_probe_data *probe_data)
> > >   {
> > >   	if (probe_data->cxl) {
> > > +		cxl_accel_region_detach(probe_data->cxl->cxled);
> > >   		cxl_dpa_free(probe_data->cxl->cxled);
> > >   		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
> > >   		kfree(probe_data->cxl->cxlds);
> > > -- 
> > > 2.17.1
> > > 
> > > 
> 

