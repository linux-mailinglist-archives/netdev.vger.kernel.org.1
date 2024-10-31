Return-Path: <netdev+bounces-140823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05AC9B85CE
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754F8281887
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 21:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F851CCEE8;
	Thu, 31 Oct 2024 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENxtWT27"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9331C8FD2
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411904; cv=none; b=P008V39P6hK5UY4905w5R1T0vOhGY37bsL914awtQ9Jb7pRJ21uvYC6aRBo9auZXtVlTZOOKxhJvWmAG+K1JXrvs6wCK0lH1t0oGfQVEgsMhCJ2P3bk6ieLOKT8vT81U1euCdXrWPruZnbAJubJht1BdnHh60pxnYQLAnwQGoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411904; c=relaxed/simple;
	bh=y9KhKR9fssTo+Ky68YPqpbHdMkJA2YuSPxJjtTcSOS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcFsEPTf9+nFJz85LMptPHCW9Rzfg9EDn650z8HkXOTOPDdfvPuJIYC9bsRHK4iairmWJVAf+CCu0pfLtgutaaVhKKNs069T2ck4EsOYtWQ39ZFl6zGaCxSpwybi/YRVrTWFIpuINTkzS3sNdecH7stz2bI5KtpB0Zkcpc2/OR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENxtWT27; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730411897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSBZyzb21Wct1l11Sz0DybMSdtPJ3nHRtrI7+9b+O0Y=;
	b=ENxtWT27jaTxHMHtb3Dbd5k6Z6T6iAhgiWyWeXqpcp5Au8IY14T5YuLXWqtbIAZKY1/ibB
	yQB6pEXmyzWeg0twIcT1mKLuyc1x7+ghvzfhp3df0bipfIh59FHHzgSGvusFFQ0x4KXg8I
	m2ootMIskRMYMPONNc5IbIqii6IksHk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-OZlEAhjGNlaCm17-TOzgAw-1; Thu, 31 Oct 2024 17:58:15 -0400
X-MC-Unique: OZlEAhjGNlaCm17-TOzgAw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e65ee715eeso218052b6e.2
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730411895; x=1731016695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSBZyzb21Wct1l11Sz0DybMSdtPJ3nHRtrI7+9b+O0Y=;
        b=m0yhLZOHXPxriaCLMlrfOO95vtXELxnEgSih9Yp7jBXUCmfgDZjCZv/xI99+HEqYMk
         gCgms2MBzFJKxWaaOZOck1PuZYxyBF9DMZGN2HQSIxHFkRL3+qFgyay4nVGCKlvE5Cst
         PyzHyb/M/GE9i7Xv21c1bpGzgxe2xZGHf1kEwlX0PbzcOOmu+FvoizoDBFik6iEwYPiL
         7FhrcRmBmcsi4RC01J0cxDNYre6Dipgl2Pad0jcXB2SqwoQZxIhRhJp/vxcLWRshuu01
         xTxA8isC56+AGn6G/tm8LgRzbJu67NzVKGdDMbxSrywhfztX/9n40AmvdoJ03E4vgq0w
         3vhw==
X-Forwarded-Encrypted: i=1; AJvYcCU9/+KS+zGSqGYyD/Lv4VFoxL3masEdYKU+S8QoPv8xMjydfni6iCFu0bAGx2n8sx1fIKjL4Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQVUO+0OzkHS4F9pw3oYb9FPJMtDPxXc8PIbBdI801iMUFd/n
	5xqhbgy2bRK4rmZNbuz+LqcdUeO2l5ntXG+OFIWXqVZTKkyCKYNHzZFz9wUtoxxLqNcPRJZUa3e
	DHX/7VHlHazlyKEFNUbA7N5lc8DX8K+tF+6UtfQHxv4EMoqXyaqY4PShduexS0h4Uy1rpND01lU
	NpjuNQR/YieEPHfqDAlwYfUXL/DSGl
X-Received: by 2002:a05:6870:8a07:b0:27b:9f8b:277b with SMTP id 586e51a60fabf-29051dd5067mr4336568fac.14.1730411894819;
        Thu, 31 Oct 2024 14:58:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESNcTMa68P7z7o0tSurldw54FQv2CVU4AtiyglGrHtbDB/d3JICxvbApHzc4NkM3WzWVTF+14/wa3eO27u+34=
X-Received: by 2002:a05:6870:8a07:b0:27b:9f8b:277b with SMTP id
 586e51a60fabf-29051dd5067mr4336566fac.14.1730411894541; Thu, 31 Oct 2024
 14:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028100341.16631-1-michal.swiatkowski@linux.intel.com> <20241028100341.16631-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20241028100341.16631-3-michal.swiatkowski@linux.intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 31 Oct 2024 22:58:03 +0100
Message-ID: <CADEbmW1EzEVGZnxEQOUngTRKVnQQnU4mpsOoe_E0SeojcF3D6w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [iwl-next v6 2/9] ice: devlink PF MSI-X max and
 min parameter
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com, 
	jacob.e.keller@intel.com, pio.raczynski@gmail.com, konrad.knitter@intel.com, 
	marcin.szycik@intel.com, wojciech.drewek@intel.com, 
	nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com, 
	jiri@resnulli.us, horms@kernel.org, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 11:04=E2=80=AFAM Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> range.
>
> Add notes about this parameters into ice devlink documentation.
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  Documentation/networking/devlink/ice.rst      | 11 +++
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 83 ++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice.h          |  7 ++
>  drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>
...
> @@ -1526,6 +1548,37 @@ static int ice_devlink_local_fwd_validate(struct d=
evlink *devlink, u32 id,
>         return 0;
>  }
>
> +static int
> +ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
> +                                union devlink_param_value val,
> +                                struct netlink_ext_ack *extack)
> +{
> +       struct ice_pf *pf =3D devlink_priv(devlink);
> +
> +       if (val.vu16 > pf->hw.func_caps.common_cap.num_msix_vectors ||
> +           val.vu16 < pf->msix.min) {
> +               NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
> +                                union devlink_param_value val,
> +                                struct netlink_ext_ack *extack)
> +{
> +       struct ice_pf *pf =3D devlink_priv(devlink);
> +
> +       if (val.vu16 <=3D ICE_MIN_MSIX || val.vu16 > pf->msix.max) {

Shouldn't this be "<" instead of "<=3D" ?

Michal


