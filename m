Return-Path: <netdev+bounces-54377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92EF806CDD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DBA28199A
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAF230653;
	Wed,  6 Dec 2023 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3W0jyI/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE610D45
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701860317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ws+hgkygHt/vtC7PcuOkC3qv40aLWwHeYDQTmLjEFPw=;
	b=V3W0jyI/70PxABB6rNlwQrF6b+YcAC6ZktzhgWdOh/WIqdF6nL/93r9N0Xfr8CInUmOzQg
	yENse54kKSlLDzdlncDYuycz2Pun4Lg9OndHK4GR+iK5W0C9d1+w4oFTyNkYsXPF2jSJH9
	7LOKvzYRUTSJruIO1oHsYp9X97hgLzI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-cWFgAFzzNkenZ31Xw6_EvQ-1; Wed, 06 Dec 2023 05:58:36 -0500
X-MC-Unique: cWFgAFzzNkenZ31Xw6_EvQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5450c83aa5dso881083a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 02:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860315; x=1702465115;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ws+hgkygHt/vtC7PcuOkC3qv40aLWwHeYDQTmLjEFPw=;
        b=lF/dMvTS7q/J6vXsQKgTuhBYca25wvuXVpYLDv89A2ZQkYCImr2RmVs7VyCh9gjs7y
         QfLLyGOMPzjwzSPdL5Lz+DH3xKdiVKljNAFuDMO7zlQm4iGb00Jp419Ay10LhIaRipHh
         eR7pSg17oOUeOXLAaHTWt0CKiWQWuIzNW3BwMD4ajrt+c8KNacSF7N235Wz6wJZD5zn/
         V6OKIcDSWeNImI91LNMR2CTOYrR5Y39DTUNKYcx8b94GDB/CLZtLHe7z6SdsW+c6Ru4W
         kWy13BUvf91jC+4X/83BH8tNtOIE+J3rU5NpL7I2xVGNN05+MOFnhVk9iFsjIVrYPKY+
         E6bg==
X-Gm-Message-State: AOJu0YxjBgGfVRF/NvMgP2VCM2pdY88wm27TkPnpe6e3vf854d7njrdJ
	UNtkeSuwoZTkm2Q40lWrOoMCKvgb3HMU7z0yGaRwjomrMY4D13GjiS/0wKEUsLV0xNbloY65akt
	MqMmi7chaE2G2DVwg
X-Received: by 2002:a17:906:57c8:b0:a1a:541c:561b with SMTP id u8-20020a17090657c800b00a1a541c561bmr994470ejr.6.1701860314994;
        Wed, 06 Dec 2023 02:58:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWly6Sn6L5UhvuHcIpOPIEOfYoGl6GmooOAkWFEeTSkRUFQqvojaS4yL0eew8srCAFkMPLSg==
X-Received: by 2002:a17:906:57c8:b0:a1a:541c:561b with SMTP id u8-20020a17090657c800b00a1a541c561bmr994456ejr.6.1701860314628;
        Wed, 06 Dec 2023 02:58:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id y21-20020a17090629d500b00a1d3b1c311csm1260323eje.164.2023.12.06.02.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:58:34 -0800 (PST)
Message-ID: <f18fdc337f58317b85acb45a0ac694f9140fc022.camel@redhat.com>
Subject: Re: [net-next PATCH v6 1/2] octeontx2-af: Add new mbox to support
 multicast/mirror offload
From: Paolo Abeni <pabeni@redhat.com>
To: Suman Ghosh <sumang@marvell.com>, sgoutham@marvell.com,
 gakula@marvell.com,  sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com,  kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lcherian@marvell.com, jerinj@marvell.com, horms@kernel.org, 
 wojciech.drewek@intel.com
Date: Wed, 06 Dec 2023 11:58:32 +0100
In-Reply-To: <20231204141956.3956942-2-sumang@marvell.com>
References: <20231204141956.3956942-1-sumang@marvell.com>
	 <20231204141956.3956942-2-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 19:49 +0530, Suman Ghosh wrote:
> A new mailbox is added to support offloading of multicast/mirror
> functionality. The mailbox also supports dynamic updation of the
> multicast/mirror list.
>=20
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Note that v5 was already applied to net-next. But I still have a
relevant note, see below.

> @@ -5797,3 +6127,337 @@ int rvu_mbox_handler_nix_bandprof_get_hwinfo(stru=
ct rvu *rvu, struct msg_req *re
> =20
>  	return 0;
>  }
> +
> +static struct nix_mcast_grp_elem *rvu_nix_mcast_find_grp_elem(struct nix=
_mcast_grp *mcast_grp,
> +							      u32 mcast_grp_idx)
> +{
> +	struct nix_mcast_grp_elem *iter;
> +	bool is_found =3D false;
> +
> +	mutex_lock(&mcast_grp->mcast_grp_lock);
> +	list_for_each_entry(iter, &mcast_grp->mcast_grp_head, list) {
> +		if (iter->mcast_grp_idx =3D=3D mcast_grp_idx) {
> +			is_found =3D true;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&mcast_grp->mcast_grp_lock);

AFAICS, at this point another thread/CPU could kick-in and run
rvu_mbox_handler_nix_mcast_grp_destroy() up to completion, freeing
'iter' before it's later used by the current thread.

What prevents such scenario?

_If_ every mcast group manipulation happens under the rtnl lock, then
you could as well completely remove the confusing mcast_grp_lock.

Cheers,

Paolo


