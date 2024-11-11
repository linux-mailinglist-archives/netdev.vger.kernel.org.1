Return-Path: <netdev+bounces-143720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199B9C3DA4
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 12:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537D51C21E13
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB42F18990D;
	Mon, 11 Nov 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2URJnrk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C915D5C5
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325475; cv=none; b=K+qmLWhaatMdBs7O79mDbZ959fbR9H3mUArxYTQ/0DR93B3qJCh7odblR4HKKLY7a7uD5CJxvgcxbq0osPONfKZZAk+Lur1xKxle5WuKkLFNlnFSNZRR2YAnBD3loJvTbQcJ1uOPsYwRPAXcuNuth7u9Idn8yB68OiQvXcJZr78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325475; c=relaxed/simple;
	bh=WiVbEbZwX7GE6FvNFFvXfXcrBQkn7qWeNINAmSp+lWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClX1rffAfuguMEPhUOYh5pOVh48gpYs+1FRX6X9IprRHxaqc9EBqi4sTnVAcU68QoJqbB4NfWAVGt4Zb/TkCT4L9oMtxkrIk9FGCOwgzP8iLsYThaUM5Xs7DAa2JwXMQSrn0In4tw7Lf/eXdlsrm9YG3cwnP65U/9eKoShVdMLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2URJnrk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731325470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrNKWWNhtD81PNKsbKwhpsIaaGhGd8JKmE0eRL/JjT0=;
	b=e2URJnrkJ6EJG/heUNJqoXjmZNWz+3j3YktMKwXfvPMYSqQNCLt9fVTTgDdGQ6PIwrOrth
	HkS72sBapmiqxBxsV/mKmTRG5kgtjGFZrOBVI7JVCY+Pl51sTjLK0gGZF8RrpCA02plzZd
	PwgZSuEgXBt4OrxhHkL11aF0ATMFJus=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-6Cud4j-bM0-c1UA-JjFrTg-1; Mon, 11 Nov 2024 06:44:25 -0500
X-MC-Unique: 6Cud4j-bM0-c1UA-JjFrTg-1
X-Mimecast-MFC-AGG-ID: 6Cud4j-bM0-c1UA-JjFrTg
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5eb75d21d3eso372830eaf.0
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 03:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731325464; x=1731930264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrNKWWNhtD81PNKsbKwhpsIaaGhGd8JKmE0eRL/JjT0=;
        b=lI+Z3LX9OygInsql75/iqkBQojkIAW//qlro4a6zTzv5iVtJqJ1xOjmwcOAk/q+Fjz
         Y2YhI6dWDfAb+jceAXfP8M1Rh0it8uAEs4uS9J93uLLribiXwH2IG0K7qz39YJg3TWer
         hOBtYa5W1fLaIoNPu3mgQ9vZTUO/dC8WrA0oQrMCTUshyqv/i+OZFMFUzwJCRL/v8tV5
         5fbU6a4tFu3LF625ce3eWcY/8MAdYNiTAXTJUxTZehQWEF1sIKj8oAlRxZQhBKYrM4ZZ
         OEQ3JESp7BMxhCk9wwaWgc74NYE6tsjW5AJpm6vBE155z39r3IIGPPGm3GQDOne9I1zK
         OI7A==
X-Forwarded-Encrypted: i=1; AJvYcCU40MesGm82vRKbmpDtMiiSQisWba34qDNuGioD44lSgbMVjZ/dfbBIsyi4/nDimCPRY5590Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9nvQYr52ejKa0wr5BzqTub/skgvpwLs+0gZ+jEafHzHbB+lgr
	WtwmjqhPE21JpqklVrbAbK2LGWo9bjdTzR1aKdmsxrAtjkqszrDSa5Tw8Q0EbN78m/I11i2YQ3G
	u+67BiYHVvO4oRB/2XlFsHRFx1h4CKqt0dIjmzUm5vc1o40LX6+F4CBcIRqdHhbLH1VmmlpJx3C
	rI0OYyIMF5IU98T6Fnb622q218B8EM
X-Received: by 2002:a05:6870:9d18:b0:291:cb6:f3cd with SMTP id 586e51a60fabf-295600f04b3mr2366964fac.8.1731325464250;
        Mon, 11 Nov 2024 03:44:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE37eDuGUNMpgsM81z+sCu4l+g2AmjHnAPzKRpJM7O2zuK4M8P9tUBlkaaYqdgsOj4PYl9dM6C8v6Uc5gSlT6E=
X-Received: by 2002:a05:6870:9d18:b0:291:cb6:f3cd with SMTP id
 586e51a60fabf-295600f04b3mr2366958fac.8.1731325463916; Mon, 11 Nov 2024
 03:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com> <20241104121337.129287-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20241104121337.129287-3-michal.swiatkowski@linux.intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 11 Nov 2024 12:44:11 +0100
Message-ID: <CADEbmW2=9s8iGJibWpPnVUraMOr7ecE6Hbpb1n3d9es-aUvA7Q@mail.gmail.com>
Subject: Re: [iwl-next v7 2/9] ice: devlink PF MSI-X max and min parameter
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com, 
	jacob.e.keller@intel.com, pio.raczynski@gmail.com, konrad.knitter@intel.com, 
	marcin.szycik@intel.com, wojciech.drewek@intel.com, 
	nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com, 
	jiri@resnulli.us, horms@kernel.org, David.Laight@aculab.com, 
	pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 1:13=E2=80=AFPM Michal Swiatkowski
<michal.swiatkowski@linux.intel.com> wrote:
>
> Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> range.
>
> Add notes about this parameters into ice devlink documentation.
>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  Documentation/networking/devlink/ice.rst      | 11 +++
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 83 ++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice.h          |  7 ++
>  drivers/net/ethernet/intel/ice/ice_irq.c      |  7 ++
>  4 files changed, 107 insertions(+), 1 deletion(-)
>
[...]
> @@ -1648,6 +1710,7 @@ void ice_devlink_unregister(struct ice_pf *pf)
>  int ice_devlink_register_params(struct ice_pf *pf)
>  {
>         struct devlink *devlink =3D priv_to_devlink(pf);
> +       union devlink_param_value value;
>         struct ice_hw *hw =3D &pf->hw;
>         int status;
>
> @@ -1656,11 +1719,27 @@ int ice_devlink_register_params(struct ice_pf *pf=
)
>         if (status)
>                 return status;
>
> +       status =3D devl_params_register(devlink, ice_dvl_msix_params,
> +                                     ARRAY_SIZE(ice_dvl_msix_params));
> +       if (status)
> +               return status;
> +
>         if (hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
>                 status =3D devl_params_register(devlink, ice_dvl_sched_pa=
rams,
>                                               ARRAY_SIZE(ice_dvl_sched_pa=
rams));
> +       if (status)
> +               return status;

Error handling looks wrong in this function.
You have to unwind the registration of the params from above or they will l=
eak.
Sorry I did not notice this earlier.

Michal


