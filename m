Return-Path: <netdev+bounces-112952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BB93BFE8
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257621F22030
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AD013A3E6;
	Thu, 25 Jul 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NH90/Z4J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D329CA
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903423; cv=none; b=hB6+cB694DNALiT5Z+KtKa/l5bedc92MRFJUv6eSgOa6xCZXdKvOLf2WMpC2tZJBgLcWO/RAUimKjSniLMrIPYEK6pFbCrcQERyBYjNfXBjO9Bn59E9bWfgDPA4baE6BsBXUm6ZeMJZ/+McjN9zAyRlQ5zRq9lzfACrJXCT32ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903423; c=relaxed/simple;
	bh=ok6J57tuB0ortQ0GBFomRJ5xmoXqMQLWtW28raiT9mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Be9mfJtPNOjeVtH4B3g6hAA5TG+PEH9+Vqc63UmkEms+1Ch7NjynaGTZUZ8vpt+NeWBc2nSN2UqmDQi57GJeX3e1RFd4mequDXtL/QnmxFllx3u5rdWJcpj3/e5aVKEssdLfF4UuNbxTp/zTN4B3Z0jBWJksLIa9YwUCa19m3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NH90/Z4J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721903421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4R1qS+OcAD2N9RRkkU7MPXLALFPxGCTRp53RqiXR1qs=;
	b=NH90/Z4J7YPl7wUARqTwEs19iVCXwVZnHy1emfWUJwo6biFjLFYewc5o+USbyvfttElJJ9
	++YTT6X/NP2/maCbdIO26X/GHQInIooqwWZSfGVFnTCFHF3TWXapJrQILlyWeHvIKNQ/1f
	VQpBWXhmoq3OLwgz6fieG1IwQmlqNnk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-p4bLoWicNbaoVTuE3OZJlA-1; Thu, 25 Jul 2024 06:30:19 -0400
X-MC-Unique: p4bLoWicNbaoVTuE3OZJlA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-367962f0cb0so453608f8f.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 03:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903418; x=1722508218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4R1qS+OcAD2N9RRkkU7MPXLALFPxGCTRp53RqiXR1qs=;
        b=XTqjNBaYZNMTddzOps3zEEJ3eKYQF0bBFFS1es4GaqPnf/z75PYyZC6F5sytiDcm1J
         f6+F53dtd+3lERWSJCQ1ctvwL2QDksV131awgtg2T1h9C25SJwN4XhJVdIoRSkQcdEKn
         TCS3672grkHnF7STgg7A8kDBepYnJHxHFI4jtg0a6KeOfgaOmVhuJ0h3sAs0B8hvFPi1
         1MhNwMiBly5+oeoWSnShShKR4BYjsXbeyLY+HvTCQ4QWu5OC2HcifQJSQgjSLsdp+J7Z
         8BT25Ch/L9gvWs/iptOSwRnw3cGiSPAbj75gfmqfcI2qFPldY59rQTeV8nDMgP8kQZGJ
         WZZA==
X-Forwarded-Encrypted: i=1; AJvYcCXUhkWw+uJsAimmsWtZN/pf20/AZ+C3wE8MsJvaFjq6Z/a+LU03CXWyb0AEjB5bQGQMt3aNeEHf6wrwHFpqtB+N+gLwnRl0
X-Gm-Message-State: AOJu0YyuL0r24cmK5Pp3rOr2NTIQKGiIPB37wcHKNLc/hGM8ekhmZEHg
	ZVPnBeWbL+/ks3AjvmI3+1uaMsd72IcO8OHLyXj0iP0VlcCx05Fr8ASfODIO1cyMHl525gn4t1w
	owdZnQKo+l0d+JV0AmI90jXrmr4c/jz7HQQoKTW2RtUACKA8RcgAWxo8/kTGP1tqMAmceQnt+41
	Z9yoO5flfp/7aU6OkGdNvqfv2Ma1og
X-Received: by 2002:a05:6000:108f:b0:366:e31a:500e with SMTP id ffacd0b85a97d-36b36444976mr966040f8f.63.1721903418558;
        Thu, 25 Jul 2024 03:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1IN1JaZ4BDav2BWfOItIVSf/dnm8FND0gTEOAaQoIiDveOI8rk1/PS6WbDZSF27HeaeRTmztdfpyRGMH3XJw=
X-Received: by 2002:a05:6000:108f:b0:366:e31a:500e with SMTP id
 ffacd0b85a97d-36b36444976mr966010f8f.63.1721903417946; Thu, 25 Jul 2024
 03:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722122839.51342-1-dawid.osuchowski@linux.intel.com>
In-Reply-To: <20240722122839.51342-1-dawid.osuchowski@linux.intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 25 Jul 2024 12:30:06 +0200
Message-ID: <CADEbmW2ANTgihP6rjS9Wmu6+7TYii37K+NH-opw=8eCLqnPH5A@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Introduce
 netif_device_attach/detach into reset flow
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Jakub Kicinski <kuba@kernel.org>, pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 2:30=E2=80=AFPM Dawid Osuchowski
<dawid.osuchowski@linux.intel.com> wrote:
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index ec636be4d17d..eb199fd3c989 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6744,6 +6744,7 @@ static int ice_up_complete(struct ice_vsi *vsi)
>             (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
>             vsi->netdev && vsi->type =3D=3D ICE_VSI_PF) {
>                 ice_print_link_msg(vsi, true);
> +               netif_device_attach(vsi->netdev);
>                 netif_tx_start_all_queues(vsi->netdev);
>                 netif_carrier_on(vsi->netdev);
>                 ice_ptp_link_change(pf, pf->hw.pf_id, true);
> @@ -7220,6 +7221,7 @@ int ice_down(struct ice_vsi *vsi)
>                 ice_ptp_link_change(vsi->back, vsi->back->hw.pf_id, false=
);
>                 netif_carrier_off(vsi->netdev);
>                 netif_tx_disable(vsi->netdev);
> +               netif_device_detach(vsi->netdev);
>         }
>
>         ice_vsi_dis_irq(vsi);

This is broken. ice_down leaves the device in the detached state and
you can't bring it up anymore (over netif_device_present check
in__dev_open).

This is with tnguy/net-queue.git:dev-queue from today (commit 80ede7622969)=
:
[root@cnb-04 ~]# modprobe ice
[root@cnb-04 ~]# ip link set enp65s0f0np0 up
[root@cnb-04 ~]# ip link set enp65s0f0np0 down
[root@cnb-04 ~]# ip link set enp65s0f0np0 up
RTNETLINK answers: No such device

Tony,
the patch is both net-queue and next-queue. Please drop it from both.

Thanks,
Michal


