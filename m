Return-Path: <netdev+bounces-124599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B624696A210
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E912E1C23AFC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55602192B90;
	Tue,  3 Sep 2024 15:17:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C14192588
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376636; cv=none; b=VFLXupt/uCxF4Oky1sIzW+ZuOzQVH3AL465MgmiNlWNmaX8dOS6GqSxkjlk0hipmoLzrBsMdcngJKgxPeb9bTpm41nBz4iVHmSR/+SsYuLVpFpBlnLl3DDBoVSLm4qS6FoJZ6Hl1Ld8LG7bHFY0KUHZ6/Y9omlVYuRYXtV0g8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376636; c=relaxed/simple;
	bh=pCaVpDEm6Ng2F+8SFYjiOym0Xf9CmBuQqG1f8ZQ+6GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oRS3iifwiqO9Y+LYwNX+VuLiCcufDy34pruCWMZaQo33csZIMobsa+8Eo/nSM/yDMp5zvJFvTS0xOh238DR4piE2b6/wXLITF2ORh18TyLDoYytFRJxqxt50cr7fTIedo1OUoHE9TMt5ORt1KGfwL3jVOP1TR71qmVNZXyUDJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-cEMKjh3nMrGRo52kUkGaXw-1; Tue,
 03 Sep 2024 11:17:09 -0400
X-MC-Unique: cEMKjh3nMrGRo52kUkGaXw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD87B1955D57;
	Tue,  3 Sep 2024 15:17:07 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1C7519560AE;
	Tue,  3 Sep 2024 15:17:04 +0000 (UTC)
Date: Tue, 3 Sep 2024 17:17:02 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v6 17/25] ovpn: implement keepalive mechanism
Message-ID: <ZtcoblYi68X8t3Bd@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-18-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240827120805.13681-18-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-27, 14:07:57 +0200, Antonio Quartulli wrote:
> +static time64_t ovpn_peer_keepalive_work_mp(struct ovpn_struct *ovpn,
> +=09=09=09=09=09    time64_t now)
> +{
> +=09time64_t tmp_next_run, next_run =3D 0;
> +=09struct hlist_node *tmp;
> +=09struct ovpn_peer *peer;
> +=09int bkt;
> +
> +=09spin_lock_bh(&ovpn->peers->lock_by_id);
> +=09hash_for_each_safe(ovpn->peers->by_id, bkt, tmp, peer, hash_entry_id)=
 {
> +=09=09tmp_next_run =3D ovpn_peer_keepalive_work_single(peer, now);
> +
> +=09=09/* the next worker run will be scheduled based on the shortest
> +=09=09 * required interval across all peers
> +=09=09 */
> +=09=09if (!next_run || tmp_next_run < next_run)

I think this should exclude tmp_next_run =3D=3D 0.

If we have two peers, with the first getting a non-0 value and the 2nd
getting 0, we'll end up with next_run =3D 0 on return.

If we have three peers and ovpn_peer_keepalive_work_single returns
12,0,42, we'll end up with 42 (after resetting to 0 on the 2nd peer),
and we could miss sending the needed keepalive for peer 1.

> +=09=09=09next_run =3D tmp_next_run;
> +=09}
> +=09spin_unlock_bh(&ovpn->peers->lock_by_id);
> +
> +=09return next_run;
> +}

--=20
Sabrina


