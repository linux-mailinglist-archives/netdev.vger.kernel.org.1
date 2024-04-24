Return-Path: <netdev+bounces-90818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEFD8B052E
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 11:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49591281B0D
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 09:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30404158A20;
	Wed, 24 Apr 2024 09:00:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9131158A16
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949200; cv=none; b=OFHhgHqB3ZsDYFpzGYsm3UZs6Oio5zlC2uNFcPzkPPzux4HMtB2sw2k+X5VH1VxEdot/T/tdI58QmhCAwRee8ZQ3hw1UA+8XYVdtj8yj9n3mDTdf93A6EIrNUMrlOhVyFZrs3l0eEU5U7NSUWxDmO4oovKIljPJxLyOWLaGh4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949200; c=relaxed/simple;
	bh=t5i8g9w59FHasVrZ4M0dhNpqO7P9HI8ZpIHC/OCwIeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BFmk03lTmgpKueCIW3wvvcWvC8aLNF9m1SBbD83g3wSc0MRHQI891CcnaVSUcQRZ2JBZH0kixx275TT4bMIVV8De3BCTXzifZ5EySkvTBJ7rocb0IlnCmxg8TJNAj4mtTXe+RckP7YTRYsk7P2ZeNZ0WPUUIH2Ru0jsJmrfA4RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-n8V0b3sIM-m6LidnFQndyQ-1; Wed, 24 Apr 2024 04:59:51 -0400
X-MC-Unique: n8V0b3sIM-m6LidnFQndyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07120834FF4;
	Wed, 24 Apr 2024 08:59:48 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 232F9C7FCEF;
	Wed, 24 Apr 2024 08:59:41 +0000 (UTC)
Date: Wed, 24 Apr 2024 10:59:40 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yossi Kuperman <yossiku@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v3 0/4] Fix isolation of broadcast traffic and
 unmatched unicast traffic with MACsec offload
Message-ID: <ZijJ_GfrzfbCEWzT@hog>
References: <20240423181319.115860-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240423181319.115860-1-rrameshbabu@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-23, 11:13:01 -0700, Rahul Rameshbabu wrote:
> Rahul Rameshbabu (4):
>   macsec: Enable devices to advertise whether they update sk_buff md_dst
>     during offloads
>   ethernet: Add helper for assigning packet type when dest address does
>     not match device address
>   macsec: Detect if Rx skb is macsec-related for offloading devices that
>     update md_dst
>   net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for
>     MACsec
>=20
>  .../mellanox/mlx5/core/en_accel/macsec.c      |  1 +
>  drivers/net/macsec.c                          | 46 +++++++++++++++----
>  include/linux/etherdevice.h                   | 25 ++++++++++
>  include/net/macsec.h                          |  2 +
>  net/ethernet/eth.c                            | 12 +----
>  5 files changed, 65 insertions(+), 21 deletions(-)

Thanks Rahul.

Series:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


