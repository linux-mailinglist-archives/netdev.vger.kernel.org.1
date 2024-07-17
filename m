Return-Path: <netdev+bounces-111861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C5F933B4E
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 12:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01204B20CEE
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7FF14AD19;
	Wed, 17 Jul 2024 10:42:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A683374C2
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212957; cv=none; b=iDkVbFSY0e4P4sQA+lL7iJYZ5qyU9W9QYtMJzB6R5Q3i8Tzct587Yyh8xR0WT1erTOt6vNd3mmScRcivkWlJqA9tZDEAs5l8/kr/VbCadtzlc2D3SS9m4SqlUw0kVU4iKrYKkyJWyGIwjV18a5wBb8ieUqEfcgGwMYGhbho8sws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212957; c=relaxed/simple;
	bh=tms+96drg+fR7tdfeqDvea2c/Set5uJJPeWhys1LXOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BsAJctgUrou5z/rpra3Qgh4Wz56RXHMqS3Lk3be+Rtqc8wioKOHccmDWTSY3Ipg0QeAVf1WfuWBJQU2v/+mxUop4DzLTAViBFjUaxQ6XAP1p/wsfUtTRErPQX0lJNm2Eg3A+CEcdr+2hK4GBZpZB2oku//ocF/fWdtZrHhV0o+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-4Qbn45h5MG2mic1cE9w3cw-1; Wed,
 17 Jul 2024 06:42:29 -0400
X-MC-Unique: 4Qbn45h5MG2mic1cE9w3cw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95C9C1955F3B;
	Wed, 17 Jul 2024 10:42:27 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B253019560B2;
	Wed, 17 Jul 2024 10:42:24 +0000 (UTC)
Date: Wed, 17 Jul 2024 12:42:21 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 22/25] ovpn: kill key and notify userspace in
 case of IV exhaustion
Message-ID: <ZpegDb1F4-uBMwpe@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-23-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-23-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:40 +0200, Antonio Quartulli wrote:
> IV wrap-around is cryptographically dangerous for a number of ciphers,
> therefore kill the key and inform userspace (via netlink) should the
> IV space go exhausted.
>=20
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/netlink.c | 39 ++++++++++++++++++++++++++++++++++++++
>  drivers/net/ovpn/netlink.h |  8 ++++++++
>  2 files changed, 47 insertions(+)
>=20
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> index 31c58cda6a3d..e43bbc9ad5d2 100644
> --- a/drivers/net/ovpn/netlink.c
> +++ b/drivers/net/ovpn/netlink.c
> @@ -846,6 +846,45 @@ int ovpn_nl_del_key_doit(struct sk_buff *skb, struct=
 genl_info *info)
>  =09return 0;
>  }
> =20
> +int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer)

This is not getting called anywhere in this version. v3 had a change
to ovpn_encrypt_one to handle the -ERANGE coming from ovpn_pktid_xmit_next.

Assuming this was getting called just as the TX key expires (like it
was in v3), I'm a bit unclear on how the client can deal well with
this event.

I don't see any way for userspace to know the current IV state (no
notification for when the packetid gets past some threshold, and
pid_xmit isn't getting dumped via netlink), so no chance for userspace
to swap keys early and avoid running out of IVs. And then, since we
don't have a usable primary key anymore, we will have to drop packets
until userspace tells the kernel to swap the keys (or possibly install
a secondary).

Am I missing something in the kernel/userspace interaction?

--=20
Sabrina


