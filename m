Return-Path: <netdev+bounces-92108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1468B57A0
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 14:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B84B25994
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285FF5380B;
	Mon, 29 Apr 2024 12:11:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA253807
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392705; cv=none; b=jc3MoPZt3TQ8/ELa9eXOCUmIIjqH3l7/4deDmyHh4nGixp8VPdzF4wS9K031WIuSuTWnVtHUOdzbpcxr3Y43eUDEVdSJOQFh3ypruwiPPShk8/kkTUY9/Z5RkNSJt40mUTCnx/9WcErLvKaLd5TyljpPxIUBbZkDViUabRt6TFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392705; c=relaxed/simple;
	bh=a+0zT6CcnM8ty2cmKCndZtgy1nqayRcqE5kDOvpZkqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dWOq8CASHWpGHrQCm3v8NMIHHfrc04XbNKAzGQ95xtNS2aEM8fF4bOHjiUg2qtz+5f8vIX5Zd1yZWc3FvCSFkwncfpIgEk7gi/3EArMO/A9gT5EWTb2FNQ0pzCHxV8ev/vNZWNtqeWDQW9oJqEuVKX3l+iOQul1SZEXGX9k9w3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-sl8JIxUKNam_momG4F-aRQ-1; Mon, 29 Apr 2024 08:11:36 -0400
X-MC-Unique: sl8JIxUKNam_momG4F-aRQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0F9380D678;
	Mon, 29 Apr 2024 12:11:35 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE8DE400EB2;
	Mon, 29 Apr 2024 12:11:33 +0000 (UTC)
Date: Mon, 29 Apr 2024 14:11:32 +0200
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
Subject: Re: [PATCH ipsec-next v13 1/4] xfrm: Add Direction to the SA in or
 out
Message-ID: <Zi-OdMloMyZ-BynF@hog>
References: <cover.1714118266.git.antony.antony@secunet.com>
 <21d941a355a4d7655bb8647ba3db145b83969a6f.1714118266.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <21d941a355a4d7655bb8647ba3db145b83969a6f.1714118266.git.antony.antony@secunet.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-26, 10:05:06 +0200, Antony Antony wrote:
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 810b520493f3..65948598be0b 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -358,6 +383,64 @@ static int verify_newsa_info(struct xfrm_usersa_info=
 *p,
>  =09=09=09err =3D -EINVAL;
>  =09=09=09goto out;
>  =09=09}
> +
> +=09=09if (sa_dir =3D=3D XFRM_SA_DIR_OUT) {
> +=09=09=09NL_SET_ERR_MSG(extack,
> +=09=09=09=09       "MTIMER_THRESH attribute should not be set on output =
SA");
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
> +=09}
> +
> +=09if (sa_dir =3D=3D XFRM_SA_DIR_OUT) {
> +=09=09if (p->flags & XFRM_STATE_DECAP_DSCP) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Flag DECAP_DSCP should not be set for o=
utput SA");
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
> +
> +=09=09if (p->flags & XFRM_STATE_ICMP) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Flag ICMP should not be set for output =
SA");
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}

Maybe also XFRM_STATE_WILDRECV? It looks pretty "input" to me.

> +
> +=09=09if (p->replay_window) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Replay window should be 0 for output SA=
");
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
> +
> +=09=09if (attrs[XFRMA_REPLAY_VAL]) {
> +=09=09=09struct xfrm_replay_state *replay;
> +
> +=09=09=09replay =3D nla_data(attrs[XFRMA_REPLAY_VAL]);
> +
> +=09=09=09if (replay->seq || replay->bitmap) {
> +=09=09=09=09NL_SET_ERR_MSG(extack,
> +=09=09=09=09=09       "Replay seq and bitmap should be 0 for output SA")=
;
> +=09=09=09=09err =3D -EINVAL;
> +=09=09=09=09goto out;
> +=09=09=09}
> +=09=09}
> +=09}
> +
> +=09if (sa_dir =3D=3D XFRM_SA_DIR_IN) {
> +=09=09if (p->flags & XFRM_STATE_NOPMTUDISC) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Flag NOPMTUDISC should not be set for i=
nput SA");
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
> +
> +=09=09if (attrs[XFRMA_SA_EXTRA_FLAGS]) {
> +=09=09=09u32 xflags =3D nla_get_u32(attrs[XFRMA_SA_EXTRA_FLAGS]);
> +
> +=09=09=09if (xflags & XFRM_SA_XFLAG_DONT_ENCAP_DSCP) {

Shouldn't XFRM_SA_XFLAG_OSEQ_MAY_WRAP also be excluded on input?

Sorry I didn't check all the remaining flags until now.


Apart from that, the series looks good now, so I can also ack it and
add those two extra flags as a follow-up patch. Steffen/Antony, let me
know what you prefer.

Thanks.

--=20
Sabrina


