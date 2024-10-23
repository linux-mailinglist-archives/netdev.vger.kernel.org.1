Return-Path: <netdev+bounces-138279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C21179ACC1D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606BDB21FE6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7844D1AE01B;
	Wed, 23 Oct 2024 14:19:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DED1A76AC
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693162; cv=none; b=L1HOt8zCsqY+7bgufKPq4m2jDyVS7SEC6OV4CeM0eau+b6CXXOu9HLKbgDhOGaaTcJ2aGyCuG4Auo9k+TwcBca0Hf5tMWM3OrvwmtXqT6En6DqZh3KVgukUgMv0rzztPMZsC0CfGFCwvOE0MElhlU2xmup7F2fY1dvIn2QdrN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693162; c=relaxed/simple;
	bh=YwOTXEnEQRIRKywPabGQVIRG37zNAsYxfbQJp1BiABs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DyPFHs3zF/QP8wUzzpJImYd1DfkCHNmxq7VfEa9jGGMqdQ/8Z/PDo1j6nrdsH7BPnojTRYZ4lgnzmw7qd6K4YXxacgtGxD8bwrfYn+LEZF1IhHd/JN0UqJrIRmUoOaqVfqiNfMMqEFlmc65MddOXFkWYR2MCBruefZAV6MRpfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=fail smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-b65TnEkLNbSI8cPzgSW3Fg-1; Wed,
 23 Oct 2024 10:19:08 -0400
X-MC-Unique: b65TnEkLNbSI8cPzgSW3Fg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E24041955D44;
	Wed, 23 Oct 2024 14:19:06 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA667300018D;
	Wed, 23 Oct 2024 14:19:02 +0000 (UTC)
Date: Wed, 23 Oct 2024 16:19:00 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>, Chris Mi <cmi@nvidia.com>
Subject: Re: [PATCH net V2] macsec: Fix use-after-free while sending the
 offloading packet
Message-ID: <Zxj7Xjz36bNTvz9k@hog>
References: <20241021100309.234125-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241021100309.234125-1-tariqt@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-10-21, 13:03:09 +0300, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
>=20
> KASAN reports the following UAF. The metadata_dst, which is used to
> store the SCI value for macsec offload, is already freed by
> metadata_dst_free() in macsec_free_netdev(), while driver still use it
> for sending the packet.
>=20
> To fix this issue, dst_release() is used instead to release
> metadata_dst. So it is not freed instantly in macsec_free_netdev() if
> still referenced by skb.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


