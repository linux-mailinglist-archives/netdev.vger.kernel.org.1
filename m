Return-Path: <netdev+bounces-54600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73571807939
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170091C20AD7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 20:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D766EB6D;
	Wed,  6 Dec 2023 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2ke2LPn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5387710E0
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 12:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701893667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PacgWuhmHHCzD4D1wPXy5jfjcOrnk4b+8TBaenNZ01s=;
	b=M2ke2LPnjmfFfqYp+t/uWMfbL1tUpgZZWas/FfK4xWzQI8WXO4XaTKJbsgPevpjUq5WWJk
	q9b5YRU6BqDXR/Xe/sR0LrlpZCnMfTE74iqYj6rSygbpXIR/ruLUbfSUpK/i1egeeCKkQ7
	inzxkICfMcaVb8rZRTnkLe+X8Zp4MdQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-9pQh68w-PsSjBehDJ53afQ-1; Wed, 06 Dec 2023 15:14:22 -0500
X-MC-Unique: 9pQh68w-PsSjBehDJ53afQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b53d6a000so380295e9.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 12:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893661; x=1702498461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PacgWuhmHHCzD4D1wPXy5jfjcOrnk4b+8TBaenNZ01s=;
        b=XI3ii3jKq6z5QlM55/lrvmJ1XRtShs8ZNB7fIT56SNJaqftZSx3XHEyAOBNOoFXTp/
         4ZuZaSqLrW3ptix6UaMpgIHCUUommcjHGsHXi92WlSMHYrKLVSszqBnt2Yhkb4TTs0HI
         onF3gp11PWfZQiPKgvsaDwLsdQ/McPgouMsjdtheFNoFoshGvvM7yjMopZhG5tEfejTp
         Vt+hWMXjAXafWma2YMu1QNLiRVqZ5A3Uq0Srs5iERwbc7lpM7X/90JnIS/G8ULIIUftr
         6c/XLh1UzjX+qLZw8AF9BrCc1cR61akI+2n8azssvJXq903ViIXMldUmYrIfwFOtkoY5
         G+Zw==
X-Gm-Message-State: AOJu0Yzkz79+zlNoxXong++8A+J4fnn8h5r5uMwyxD0CKhVRFkexPgU2
	aA1Z50nKvyzsGXUywe5Nen1o2cpv/1j6bFiYiC/vgPm8sLjudeVPP3jLJJixXUK+GUPzNXZMOcj
	SNlwdtwCO6FbdVrKFtNHV55H4
X-Received: by 2002:a05:600c:1387:b0:40c:b81:c640 with SMTP id u7-20020a05600c138700b0040c0b81c640mr2089280wmf.0.1701893661297;
        Wed, 06 Dec 2023 12:14:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl+v8tLWrIdNVup+ULZ9PXnKDUVHIbAfUWN5tMZvHnJQKLWsqCa1sDMaipAfFRbNhmlTg28g==
X-Received: by 2002:a05:600c:1387:b0:40c:b81:c640 with SMTP id u7-20020a05600c138700b0040c0b81c640mr2089268wmf.0.1701893660930;
        Wed, 06 Dec 2023 12:14:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0040b4cb14d40sm736082wmq.19.2023.12.06.12.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:14:20 -0800 (PST)
Message-ID: <853a21e6479b44b10b8f6c9874124c82c13bed3c.camel@redhat.com>
Subject: Re: [EXT] Re: [net-next PATCH v6 1/2] octeontx2-af: Add new mbox to
 support multicast/mirror offload
From: Paolo Abeni <pabeni@redhat.com>
To: Suman Ghosh <sumang@marvell.com>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, Geethasowjanya Akula <gakula@marvell.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>, Hariprasad Kelam
 <hkelam@marvell.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,  "kuba@kernel.org"
 <kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linu Cherian
 <lcherian@marvell.com>, Jerin Jacob Kollanukkaran <jerinj@marvell.com>,
 "horms@kernel.org" <horms@kernel.org>,  "wojciech.drewek@intel.com"
 <wojciech.drewek@intel.com>
Date: Wed, 06 Dec 2023 21:14:18 +0100
In-Reply-To: <SJ0PR18MB5216F4E57D57AD4DF5013D15DB84A@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231204141956.3956942-1-sumang@marvell.com>
	 <20231204141956.3956942-2-sumang@marvell.com>
	 <f18fdc337f58317b85acb45a0ac694f9140fc022.camel@redhat.com>
	 <SJ0PR18MB5216F4E57D57AD4DF5013D15DB84A@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-06 at 16:33 +0000, Suman Ghosh wrote:
> > On Mon, 2023-12-04 at 19:49 +0530, Suman Ghosh wrote:
> > > A new mailbox is added to support offloading of multicast/mirror
> > > functionality. The mailbox also supports dynamic updation of the
> > > multicast/mirror list.
> > >=20
> > > Signed-off-by: Suman Ghosh <sumang@marvell.com>
> > > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> >=20
> > Note that v5 was already applied to net-next. But I still have a
> > relevant note, see below.
> >=20
> > > @@ -5797,3 +6127,337 @@ int
> > > rvu_mbox_handler_nix_bandprof_get_hwinfo(struct rvu *rvu, struct
> > > msg_req *re
> > >=20
> > > =C2=A0	return 0;
> > > =C2=A0}
> > > +
> > > +static struct nix_mcast_grp_elem
> > > *rvu_nix_mcast_find_grp_elem(struct
> > nix_mcast_grp *mcast_grp,
> > > +							    =20
> > > u32 mcast_grp_idx)
> > > +{
> > > +	struct nix_mcast_grp_elem *iter;
> > > +	bool is_found =3D false;
> > > +
> > > +	mutex_lock(&mcast_grp->mcast_grp_lock);
> > > +	list_for_each_entry(iter, &mcast_grp->mcast_grp_head,
> > > list) {
> > > +		if (iter->mcast_grp_idx =3D=3D mcast_grp_idx) {
> > > +			is_found =3D true;
> > > +			break;
> > > +		}
> > > +	}
> > > +	mutex_unlock(&mcast_grp->mcast_grp_lock);
> >=20
> > AFAICS, at this point another thread/CPU could kick-in and run
> > rvu_mbox_handler_nix_mcast_grp_destroy() up to completion, freeing
> > 'iter' before it's later used by the current thread.
> >=20
> > What prevents such scenario?
> >=20
> > _If_ every mcast group manipulation happens under the rtnl lock,
> > then
> > you could as well completely remove the confusing mcast_grp_lock.
> >=20
> > Cheers,
> >=20
> > Paolo
> [Suman] I added this lock because, these requests can come from some
> user-space application also. In that case, application will send a
> mailbox to kernel toad/del
> Multicast nodes. But I got your point and there is indeed chances of
> race. Let me think through it and push a fix. So, what process should
> be followed here? Are you going to revert the change? Or I can push a
> separate fix on net tree?

You can push a follow-up fix.

We could end-up reverting the patch only if the fix will take too long
to land here, and the issue will start hitting people.

Cheers,

Paolo



