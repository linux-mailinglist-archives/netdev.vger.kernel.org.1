Return-Path: <netdev+bounces-105132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5552590FC80
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF31F22F5D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 06:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAA12C684;
	Thu, 20 Jun 2024 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AckMBCww"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7DB657
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863597; cv=none; b=TOjeOyj1lI9zX+qouvjVjytRLgmUfDN/jVoID6Ip72f2+vBtcMAU+kj+GM1Aivhsn1+HQVxY8xlDK6B+IwRwFvgmYRt7trBfQV0ey38hLjk6eXDMlpdXp2ukvjBT0AboypEe9XzlNeUqdCxALLawBNo+dqK7U8pzXIQtd3f2Lks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863597; c=relaxed/simple;
	bh=NRstT0XAdq6rdxnclSzYP97L8sHSEcaWwWKJMByfmMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUmpYjmtU1hfn8oX2+DlhukOs78eSkmhlilV3v1uRV6wC83XTb5WhTv3vNXDVcYFGe/tOXKXaLMTyyqxWIm3ntsl2+zGj/j3ViEiF2QSk2PpntJ68WwxgR7i7y2+ctA4uzUL1lAHnWaNRXUXy5Xn7IZvZmbn1+gBgeGeqKei3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AckMBCww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718863595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyJTcoVu8te5SIWVCTtlh1pU+t8EWBPrH2LdNuhvIMg=;
	b=AckMBCwwNLMIKJ87AvEBiEi1gRdRZ4T4sYQRRob//zCHGoWkpvjY271Sfda8c9qNB4xRXS
	PMCeWuK1nfrg197dnk70k5jroywtnGhjOa0oy5sI9VgnqiOo42foz9DpByVHuCoV8nqwvp
	4fKgmC7nVXo5FvXdXP57vPiFb17Jcj8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-q2RMyyJRPQCk_azk2Ibx0Q-1; Thu, 20 Jun 2024 02:06:33 -0400
X-MC-Unique: q2RMyyJRPQCk_azk2Ibx0Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-364dfcace34so132310f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 23:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718863592; x=1719468392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyJTcoVu8te5SIWVCTtlh1pU+t8EWBPrH2LdNuhvIMg=;
        b=KmN/1S480K2IJiriKdiVweXlNzLIOCVdDdbkcO8YLfzUFSuRvAayEEA38yzIO+JOeM
         ZHGPDqntLNZm7LupZBv2/5ut1VFCHnlVNCpJyPfkLT6y0qt6hC0lUwNwh2PG03BpTY43
         lRwtcFpaIUhC89HTo/GFN1Wpy1mhDSxtZrYzyqF5yxzkeOk8Ug5WuamOnIddbxV/KCrf
         f+1R+PFQrlLHJwT0EuQ2hjfsMuQ8/27E3ZP6h3f68j03wRDguW6Babm8hhwI21Pa5W40
         LBGm7hwxGhQAWlWHFMdgc5b8jzI8wqrVtttk+/V33nGxBubcAVX8Y10UUES+vRdlGMwK
         iRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx4FPzgtTttn9wyDyhvs2XEx6jZNzT6m7LwctnWX4e1GufTPEymfRNpsJvLQcE9zHyDS7e3ghLkmEjP2SfqtLGFSgu4fEY
X-Gm-Message-State: AOJu0YwYEkjS+/N14j6rALK2MEUEQK04qgFwte0mImDDTVFa5kQmqqFW
	Vgup1d1AH9EoSbsP9bI7m0/g3DqGdVS9UUmJWng7gXGlM7w9gC7+CRV5ek/dgjLoBTm8E2Cboaj
	T/Ls5V2wvlVV3o2U52EucVG/jR/SbxEIB4etSPJUTQQ0dmqHn72FfhsHqN2TJNVV60HR9dPMdqj
	aASYLztyRkfPHbiZg4YsfQZjcNpVRD
X-Received: by 2002:a5d:6783:0:b0:35f:22ac:410d with SMTP id ffacd0b85a97d-3631989a785mr3258592f8f.56.1718863592105;
        Wed, 19 Jun 2024 23:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBSuyyU0gop5af6II7AJZ1c2QamkTjCmZ45NFJ7QUFudPWSk2DnTDh+GxsDDHmpvDhS+DLPqZ/NNS2hXZbXy4=
X-Received: by 2002:a5d:6783:0:b0:35f:22ac:410d with SMTP id
 ffacd0b85a97d-3631989a785mr3258577f8f.56.1718863591763; Wed, 19 Jun 2024
 23:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618131208.6971-1-sergey.temerkhanov@intel.com> <20240618131208.6971-3-sergey.temerkhanov@intel.com>
In-Reply-To: <20240618131208.6971-3-sergey.temerkhanov@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 20 Jun 2024 08:06:20 +0200
Message-ID: <CADEbmW0jfmgYH-jXRDRj3_AUs17+q3eJ5Ea_U9xidjuvjQDQkA@mail.gmail.com>
Subject: Re: [RFC PATCH iwl-next v1 2/4] ice: Add ice_get_ctrl_ptp() wrapper
 to simplify the code
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:53=E2=80=AFPM Sergey Temerkhanov
<sergey.temerkhanov@intel.com> wrote:
> Add ice_get_ctrl_ptp() wrapper to simplify the PTP support code
> in the functions that do not use ctrl_pf directly
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ether=
net/intel/ice/ice_ptp.c
> index 57e1e5a5da4a..a2578bc2af54 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -16,6 +16,18 @@ static const struct ptp_pin_desc ice_pin_desc_e810t[] =
=3D {
>         { "U.FL2", UFL2, PTP_PF_NONE, 2, { 0, } },
>  };
>
> +static struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
> +{
> +       return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
> +}
> +
> +static struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
> +{
> +       struct ice_pf *ctrl_pf =3D ice_get_ctrl_pf(pf);
> +
> +       return !ctrl_pf ? NULL : &ctrl_pf->ptp;
> +}
> +
>  /**
>   * ice_get_sma_config_e810t
>   * @hw: pointer to the hw struct
> --
> 2.43.0

The patch order is incorrect. Here you access the ctrl_pf member,
which is added later in the subsequent patch.

But more importantly, it looks unsafe to access another ice_pf this
way. The administrator may unbind a PF from the driver in any order.
Can the shared objects be moved into struct ice_adapter itself so that
cross-ice_pf access becomes unnecessary?

Michal


