Return-Path: <netdev+bounces-111908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88A934157
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09176281697
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C248A183066;
	Wed, 17 Jul 2024 17:18:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7D717F39B
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236695; cv=none; b=AhsGsoEODgryj6G64AUxNOIwCduWkzQZ2BX6p6IHSTvP+OV1eEGyiNJowsqTtijvKWxcW/seFpQupoX04hA5gylGzNUbOe7OwZ1WWC6VCAdpy0mKKML1ueGGLTZtgoIVE7iubTDuNVb1lrNWDS11X98QOki1P3plONZMquXB/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236695; c=relaxed/simple;
	bh=lCJojwSi328ESn1dgIwJgLWa3DbetbhKJIZdiwhEw88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ulfJtdHy4GzQ9R3wjbZblHKaOiSN66PYEFk5cLC9+M60GsrNbTHNPIqMEniaZiOKkG4bQZQ8cGpXVf9a0SWtBRN0Ekik9kvai2lZM05CjaZkDH8189y8uTex8I9GlueHTruz7jzRLr2PvNRalwwpduMMu/jTorQY+WbzFy0f+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-2YLqD4WtPu6wX5vZdR4-8g-1; Wed,
 17 Jul 2024 13:18:08 -0400
X-MC-Unique: 2YLqD4WtPu6wX5vZdR4-8g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE6D11892A62;
	Wed, 17 Jul 2024 17:17:57 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1997F1955F3B;
	Wed, 17 Jul 2024 17:17:33 +0000 (UTC)
Date: Wed, 17 Jul 2024 19:17:31 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 21/25] ovpn: implement key add/del/swap via
 netlink
Message-ID: <Zpf8q731wtyXMpkd@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-22-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-22-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:39 +0200, Antonio Quartulli wrote:
> This change introduces the netlink commands needed to add, delete and
> swap keys for a specific peer.
>=20
> Userspace is expected to use these commands to create, destroy and
> rotate session keys for a specific peer.
>=20
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  Documentation/netlink/specs/ovpn.yaml |   2 +-
>  drivers/net/ovpn/netlink-gen.c        |   2 +-
>  drivers/net/ovpn/netlink.c            | 199 +++++++++++++++++++++++++-
>  3 files changed, 198 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlin=
k/specs/ovpn.yaml
> index 68ed88d03732..21c89f0bdcbb 100644
> --- a/Documentation/netlink/specs/ovpn.yaml
> +++ b/Documentation/netlink/specs/ovpn.yaml
> @@ -153,7 +153,7 @@ attribute-sets:
>            decryption
>          type: u32
>          checks:
> -          max: 2
> +          max: 7

Looks like this got squashed into the wrong patch.

--=20
Sabrina


