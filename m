Return-Path: <netdev+bounces-85365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F989A6D1
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 00:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27D71C209AB
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606D9177995;
	Fri,  5 Apr 2024 21:56:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5217965C
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354184; cv=none; b=kCjSYjr+Y+vbKdFRsa26QU5UDS7aG6goFPp0lTq2KbUXnMJ9pMWFonotgbCvarXCZHRdHHccz/pJ2qima64HiU0jbSagJ8jqJOX8EThgdgP3gscKKSFWk8l3XYW9rs1hqBAt7ybkpey4JB7Nnd/JLJjb7CF4HXW/1693si30340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354184; c=relaxed/simple;
	bh=BqjvhAxg6BWVOoK/EilnAwK4JCnBhofTRwh/AWLiIIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=R3yAK/qI8go8ksLW+SQrUvqCvvmCQCGKxTrjDjcC8JtTuJSX4k2WQEl/fZmhXz0SzymkB9D8xsjaTesKny8wcazznD1+2q4gAxAepr4b0Txw+6cnExYfGLAd78ic3zLceiNuuAfDxDu4Dy+P9b/HzsVpfsbrrj5NWhZxpC4M+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425--rZsijIINiOCKAADuUAiUg-1; Fri, 05 Apr 2024 17:56:08 -0400
X-MC-Unique: -rZsijIINiOCKAADuUAiUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8598985A5B7;
	Fri,  5 Apr 2024 21:56:07 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 94E962166B33;
	Fri,  5 Apr 2024 21:56:05 +0000 (UTC)
Date: Fri, 5 Apr 2024 23:56:00 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH ipsec-next v6] xfrm: Add Direction to the SA in or out
Message-ID: <ZhBzcMrpBCNXXVBV@hog>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Antony,

2024-04-05, 14:40:07 +0200, Antony Antony wrote:
> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> xfrm_state, SA, enhancing usability by delineating the scope of values
> based on direction. An input SA will now exclusively encompass values
> pertinent to input, effectively segregating them from output-related
> values.=20

But this patch isn't doing that for existing properties (I'm thinking
of replay window, not sure if any others are relevant [1]). Why not?

[1] that should include values passed via xfrm_usersa_info too,
    not just XFRMA_* attributes

Adding these checks should be safe (wrt breakage of API): Old software
would not be passing XFRMA_SA_DIR, so adding checks when it is provided
would not break anything there. Only new software using the attribute
would benefit from having directed SAs and restriction on which attributes
can be used (and that's fine).

Right now the new attribute is 100% duplicate of the existing offload
direction, so I don't see much point.

> This change aims to streamline the configuration process and
> improve the overall clarity of SA attributes.
>=20
> This feature sets the groundwork for future patches, including
> the upcoming IP-TFS patch.
>=20
> Currently, dir is only allowed when HW OFFLOAD is set.
>=20
> ---

BTW, everything after this '---' will get cut, including your sign-off.

> v5->v6:
>  - XFRMA_SA_DIR only allowed with HW OFFLOAD
>=20
> v4->v5:
>  - add details to commit message
>=20
> v3->v4:
>  - improve HW OFFLOAD DIR check check other direction
>=20
> v2->v3:
>  - delete redundant XFRM_SA_DIR_USE
>  - use u8 for "dir"
>  - fix HW OFFLOAD DIR check
>=20
> v1->v2:
>  - use .strict_start_type in struct nla_policy xfrma_policy
>  - delete redundant XFRM_SA_DIR_MAX enum
> ---
>=20
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

nit: If I'm making non-trivial changes to the contents of the patch, I
typically drop the review (and test) tags I got on previous versions,
since they may no longer apply.

--=20
Sabrina


