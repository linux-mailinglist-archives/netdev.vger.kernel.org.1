Return-Path: <netdev+bounces-79859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592A387BC5C
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 12:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35641F21365
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6418F6F06C;
	Thu, 14 Mar 2024 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPSXTrzI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42EA6EB74
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417446; cv=none; b=WVzAEr3t+WD+AGAgzUkWdnvCCS5yTXJxhIV8e6dxjlvBaZHeseEkvMB4EtwM6aGva5WmqwfQxg8IOIVy3x5/t7hmOdL7b+0wertYSySgUjARf67qB3XkfWrNMql+rehrVGgD4XUGFX9MPfY8Kx1PX8rVcxMoQaOvkkgIKXhBMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417446; c=relaxed/simple;
	bh=AdMsm2idLYumEp0ZXOMFAz1fRELSXatQYvEc+3tGX+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V11QQAKlPt316QCiFFSZcys5udFkoIgAOe4jQ7Ii9kIaaGlWgSxyx1jfdf8lZq453IX7Y64OQeddnScZJL0HcvMMHIWsWBg755xBB7IqXuiYlOf5MfLDftmM3uxwRgW3JNx64tJLIHcmmJwIGWYdsH20Xb+aTRQak//Ox3LDp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPSXTrzI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710417443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6Yj68QAc/GDKe4pAWzzjDhY33mBI0iwde75NIqen9o=;
	b=dPSXTrzIMoV7B6aeCwoSvQ9J2gBNxTwLmLltloXuFQgBEAJvnktGnu3ySRx7ZAveTxlbYh
	bi4y/01xbBlwWQ8racZ48YdTtc6IU7hvXUi7IIwIlmAahqZ62JB4zJ6XE108nPkJzyQYn6
	eRCbYw2FE6hDOXwkX01pBh7stmKhpW0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-qm6Bp9afOnSxYcxTr9oXTA-1; Thu, 14 Mar 2024 07:57:20 -0400
X-MC-Unique: qm6Bp9afOnSxYcxTr9oXTA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a4531df8727so25396866b.2
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 04:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710417439; x=1711022239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6Yj68QAc/GDKe4pAWzzjDhY33mBI0iwde75NIqen9o=;
        b=fJKxIBMtbGemuFe6gTHPZ52O4OMWeIg9uJv6K0KLeZY6GTQyHLnOKQLJ42wxiUpU+K
         buj0KdjOsG5lV+el89SjgORAK44aec1E8tJK7m7RR93mhWnoUMigGpb3tm04cNpLRC8N
         dXPj6HxBHBQII5AJpDRq+iyk2Bdx77xzvYruaKpdTmw7gMZ9GPleVyxoq2irZEFMgszl
         XXo/Hbwzhnz23bvr55a/IzRpP5sF8iQlmrGBptdRptHOZGn1n8iALw893e1gW5P9FODJ
         jezVo+aiqXp41y9GAkH47wPp4/4rxJjkib2HCk6cdmOnF81nFWouEWxToqsi/AdyzzDT
         uWdg==
X-Gm-Message-State: AOJu0Yy1np8OCETNFqo7Wla7biyW1t441c127ZPSxfAEiUSCkE6cwIhS
	W0Lc+FU3pJeubmkMub5bEjgY00sPCqcbByQxTw6+9pAQR0jj1ma/KZsTNxK76x8685O5Ka4Pvp4
	N5TR5JN2QBlhfW6hHxjFDMUdwR/lzbf9Fn0cuVzxDp367dMQ5FwdL4eu5qZC+k7WotH9//7cAXd
	w/uVF4hgV1M2uhXdJ6RLfX0rS4RclM
X-Received: by 2002:a17:906:1194:b0:a45:c1a0:5c07 with SMTP id n20-20020a170906119400b00a45c1a05c07mr908081eja.17.1710417439446;
        Thu, 14 Mar 2024 04:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDd2Jv4Umtbk8PWZFo/vG9CwetRXLttChfYOuW/Phrx3fnFIjOrGAyZYjYrVlq16O3RjQTW7e3G7Su6kU5hIw=
X-Received: by 2002:a17:906:1194:b0:a45:c1a0:5c07 with SMTP id
 n20-20020a170906119400b00a45c1a05c07mr908069eja.17.1710417439108; Thu, 14 Mar
 2024 04:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313135618.20930-1-ivecera@redhat.com>
In-Reply-To: <20240313135618.20930-1-ivecera@redhat.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Thu, 14 Mar 2024 12:57:07 +0100
Message-ID: <CADEbmW1vis35ACawye9d2S11NHA-Zpemv1m_+6eurkroLCtqqQ@mail.gmail.com>
Subject: Re: [PATCH net] i40e: Fix VF MAC filter removal
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, aleksandr.loktionov@intel.com, horms@kernel.org, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 2:56=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
> Commit 73d9629e1c8c ("i40e: Do not allow untrusted VF to remove
> administratively set MAC") fixed an issue where untrusted VF was
> allowed to remove its own MAC address although this was assigned
> administratively from PF. Unfortunately the introduced check
> is wrong because it causes that MAC filters for other MAC addresses
> including multi-cast ones are not removed.
>
> <snip>
>         if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
>             i40e_can_vf_change_mac(vf))
>                 was_unimac_deleted =3D true;
>         else
>                 continue;
>
>         if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
>         ...
> </snip>
>
> The else path with `continue` effectively skips any MAC filter
> removal except one for primary MAC addr when VF is allowed to do so.
> Fix the check condition so the `continue` is only done for primary
> MAC address.
>
> Fixes: 73d9629e1c8c ("i40e: Do not allow untrusted VF to remove administr=
atively set MAC")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers=
/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index b34c71770887..10267a300770 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -3143,11 +3143,12 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_v=
f *vf, u8 *msg)
>                 /* Allow to delete VF primary MAC only if it was not set
>                  * administratively by PF or if VF is trusted.
>                  */
> -               if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
> -                   i40e_can_vf_change_mac(vf))
> -                       was_unimac_deleted =3D true;
> -               else
> -                       continue;
> +               if (ether_addr_equal(addr, vf->default_lan_addr.addr)) {
> +                       if (i40e_can_vf_change_mac(vf))
> +                               was_unimac_deleted =3D true;
> +                       else
> +                               continue;
> +               }
>
>                 if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
>                         ret =3D -EINVAL;
> --
> 2.43.0

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>


