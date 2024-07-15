Return-Path: <netdev+bounces-111485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4C7931575
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE3DB2113B
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01C818D4A9;
	Mon, 15 Jul 2024 13:11:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923018A926
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049100; cv=none; b=cVtz7aXvjtrCj+Ir75bhM8zZE43Ikh8J+puBo/F23aDOiLPXYY9/sSVIULTrn+eC2heIlFKiR1XfPIIoRskqcEMmZwvKsRCj7zIGgfVAiyRnptm50XBuMZ52/mg6aVwN1ZVTHuo0bj4B5so8DkWkTuwND59QEi75vWUp07jedLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049100; c=relaxed/simple;
	bh=dObdQ1IsVQ2RU6Yf86U8FZ/FL0Q5hb3z2btOx7AZnU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pL8hGPniYWw2hFxEPZA2vLjEZh+5jHb0iRyoKh7qtVHHDgJcQ8j0Mxip6StPvk8LWxXk60vpymQhl0C+F8T9M+uiTopHMNhhZYiQ4heCXgG6unbS7jRwAgVeCTGBH24haXfYKAsQHZDrCArvKJwCDRbRg+YXi0jzRjYWbJqoXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-2ltflJ10ODeCPWARpRPt7Q-1; Mon,
 15 Jul 2024 09:11:33 -0400
X-MC-Unique: 2ltflJ10ODeCPWARpRPt7Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93A731955D4F;
	Mon, 15 Jul 2024 13:11:32 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B645E1955D44;
	Mon, 15 Jul 2024 13:11:29 +0000 (UTC)
Date: Mon, 15 Jul 2024 15:11:27 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 16/25] ovpn: implement peer lookup logic
Message-ID: <ZpUf_1gdsZvoLYbn@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-17-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-17-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:34 +0200, Antonio Quartulli wrote:
>  /**
>   * ovpn_peer_check_by_src - check that skb source is routed via peer
>   * @ovpn: the openvpn instance to search
>   * @skb: the packet to extra source address from

nit, just noticed now but should be fixed in patch 12: s/to extra/to extrac=
t/

[...]
> @@ -324,11 +576,11 @@ static int ovpn_peer_add_mp(struct ovpn_struct *ovp=
n, struct ovpn_peer *peer)
>  =09struct sockaddr_storage sa =3D { 0 };
>  =09struct sockaddr_in6 *sa6;
>  =09struct sockaddr_in *sa4;
> +=09struct hlist_head *head;
>  =09struct ovpn_bind *bind;
>  =09struct ovpn_peer *tmp;
>  =09size_t salen;
>  =09int ret =3D 0;
> -=09u32 index;
> =20
>  =09spin_lock_bh(&ovpn->peers->lock);
>  =09/* do not add duplicates */
> @@ -364,30 +616,27 @@ static int ovpn_peer_add_mp(struct ovpn_struct *ovp=
n, struct ovpn_peer *peer)
>  =09=09=09goto unlock;
>  =09=09}
> =20
> -=09=09index =3D ovpn_peer_index(ovpn->peers->by_transp_addr, &sa,
> -=09=09=09=09=09salen);
> -=09=09hlist_add_head_rcu(&peer->hash_entry_transp_addr,
> -=09=09=09=09   &ovpn->peers->by_transp_addr[index]);
> +=09=09head =3D ovpn_get_hash_head(ovpn->peers->by_transp_addr, &sa,
> +=09=09=09=09=09  salen);
> +=09=09hlist_add_head_rcu(&peer->hash_entry_transp_addr, head);
>  =09}

These changes to ovpn_peer_add_mp (and the replacement of
ovpn_peer_index with ovpn_get_hash_head) could be squashed into the
previous patch.

--=20
Sabrina


