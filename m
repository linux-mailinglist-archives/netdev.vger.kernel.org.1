Return-Path: <netdev+bounces-92784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F395D8B8D8A
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 17:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE48B21BC3
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC41612FB20;
	Wed,  1 May 2024 15:57:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497D12F593
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579062; cv=none; b=f5EC3eZNVYNU9P8eXIYXD+jZoQgo+3YGSNwxP6b4kjL4/8lfFFBLc5zEuyoKPpmvjcFDCQ4I8o/28+DgO7gtflx57NDhet4edpbT0flwqGQHRvwh8eWaaBhv7KwTxdOVDzUTXKd1MSrVhdy4v+daG6Mt/3dtczjah8hH3PGQHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579062; c=relaxed/simple;
	bh=KRAePtk3WrWk5mKVvfbCWTazQdlkdVSM2j4Z7hHIjLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JvizZ9wO7NUw37fm2aW3rehpKNTnc0Ppm5b7D3ySWQHXdMjy9+xR1Qt9+2DvJUBG2CZXUSCj/MRoJ9fLlFifUjtfvBSfpYAZ70tRhCP/nsewKEyoNQSShCgci86PhXVxZWms/NUG6dsH9glTfKuezVeuVr4DgjuPeuc/sVMJ3Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-W0C3_tlRNXqwPQh_sHhnxQ-1; Wed,
 01 May 2024 11:57:36 -0400
X-MC-Unique: W0C3_tlRNXqwPQh_sHhnxQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95C1B3813F20;
	Wed,  1 May 2024 15:57:35 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C141840BAA2;
	Wed,  1 May 2024 15:57:33 +0000 (UTC)
Date: Wed, 1 May 2024 17:57:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jiri Benc <jbenc@redhat.com>, Breno Leitao <leitao@debian.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net] vxlan: Pull inner IP header in vxlan_rcv().
Message-ID: <ZjJmbHpHoTgoazeE@hog>
References: <1239c8db54efec341dd6455c77e0380f58923a3c.1714495737.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1239c8db54efec341dd6455c77e0380f58923a3c.1714495737.git.gnault@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-30, 18:50:13 +0200, Guillaume Nault wrote:
> Ensure the inner IP header is part of skb's linear data before reading
> its ECN bits. Otherwise we might read garbage.
> One symptom is the system erroneously logging errors like
> "vxlan: non-ECT from xxx.xxx.xxx.xxx with TOS=3Dxxxx".
>=20
> Similar bugs have been fixed in geneve, ip_tunnel and ip6_tunnel (see
> commit 1ca1ba465e55 ("geneve: make sure to pull inner header in
> geneve_rx()") for example). So let's reuse the same code structure for
> consistency. Maybe we'll can add a common helper in the future.
>=20
> Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


