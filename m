Return-Path: <netdev+bounces-241726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1111C87B0E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0738B351CB0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 01:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E5F2F49FC;
	Wed, 26 Nov 2025 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2eczPyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0289249EB
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764120366; cv=none; b=jku2oxUxFGN8WkmHr3UDXZy79DnNzlz4gRYLe1Lwwl/4LQ+cjgj4pL1bCEz2AWjYoq3z4xOyzc7i3ZO+kEi9pRNXqlWGtiIAYPITVuBKgFYglfr3wmKQRc5VU4syvtr9RY7Ldcbn1qdubZ5C34cYa18uwcNXii5o//i6m90B/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764120366; c=relaxed/simple;
	bh=iqfLtQK8wlILYjYcLAtxiIg3XKmmnZ7vNYY1a6nak/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdJgyUbwM+c7+SRW4HtMAKDic03s6AKUk+i8gLqoX4aa3xYXDK2lu9a6uFxLI0wpwe0BT8Mtgnkp9gSsjBWUMoDMuOaUONEzbyHohLHDDwS2bJumHrg8n+aUOPpDQ3B0inCGLjC6ZnbMKZfuEkcS8A63ERiw0GaBkWU/D1zrtrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2eczPyi; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4332381ba9bso27491345ab.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 17:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764120364; x=1764725164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O06Ufx3lbs08Q7n+/UY7GMNoupECw2/m8/3ELLh3ZjQ=;
        b=h2eczPyiEpMJHmoCcP9cf3qXjbCdjeIo3epGUzW0ejdYNlLbdERymqQrwByVEqkQOs
         STRSVEKBvBMgGN5+njPoTtc0pICpKCAQCUXRXkn2pcXthG8KuKDbdozKj8gvH9SL99KN
         eiFK5cG5WG84ZOvomBRvIFRSvVzN+qYbpOobvzefSbJAs9puE+R1rver5gFUl9xgmnoy
         /cyZNDdvesX/nK40DclurFEj4Xi1DKwEN2sOaQCoGy7m0C4fYZGhpW/dA4Yk9P0JWbCt
         TbzXVPsfwhKZC9ZEoV4NobhO0s+pSYzbm/0i3c5p2ut/uZMFiMVnnwjTyQY7Ls41CeUf
         xyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764120364; x=1764725164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O06Ufx3lbs08Q7n+/UY7GMNoupECw2/m8/3ELLh3ZjQ=;
        b=Sd6Imfl08ytusSrGQ85WkYdxi/uqoxKdGinD7hbTx+eDL+H7Jkoljv4a7itu6qfWNo
         iZQVCWN3rkMhMqjpijDfzOmhoIRqxuZboPAQH+vvaPUozhqbVjHLPrJLefNWxvYJnrOe
         R6Fm51jTMKgSwOAVyG4SajGYSXQYO7veSni2j1btmduk3afNVHj5RgTo0IGtO0XC9RCd
         2glQHm1dGSqBGDe8axtPXhYINDXcAjwhQLMYP9QEFwctin0L1Zwm5SdZ69vSaEu/EZW/
         OSeIGT89IDdDrFV1pMdQv522H0WUedu1lSeTV0181WWleY+3huV2GrRWjwb1WsdCOXk9
         Oo/Q==
X-Gm-Message-State: AOJu0Yym4iSvP6E0O7c3z1kRHpSxNplmCxGwbWau5szv6DqnJ6WJcJ8n
	gU9c3Vy+1bspLAn5ZthmIfyWCBFsrAy+F5i4H9phzJ4t/xOwryxxGfwfPab7EiEm9kDJ1CDLtbq
	8CMJRh6BEqMyDPLDxnD1GwyEzczQKboM=
X-Gm-Gg: ASbGncuPyhXrH+4whAa63F9QfjXyjgqliyaIWQiYBb0GJ28zTlHIwmPdvPDg328Oe51
	OjxtFm7O05JVI6xDGuSTGcN/XBLGYxWYomxA8K8HypYRgogGu/xpVhCfJ84wFeLlyRELirdAxBX
	kmziFPdO0QLAxoXbygEgnAMdPP+n02PDhUL1tfVPfLpO45SjVB9FIhJNYLepKteFek93wrKbHt5
	nXoI/QJWA1TFG2o5VS54TWVyXZw3oFzJdJXTx2WUx5Qp7Eot8yhuSezpaQVJanS6KLppKuoiicS
	u9y6Ew==
X-Google-Smtp-Source: AGHT+IFzb7h/y63ux52ue+f6TKltptjoUjwAY+QdRgOJ7HtuBxTAJldTRmpfQJOCa3qLwdGjkpm0P3UCZVeua1TpVOQ=
X-Received: by 2002:a05:6e02:188d:b0:433:7ec4:4b85 with SMTP id
 e9e14a558f8ab-435dd112164mr54687025ab.29.1764120363709; Tue, 25 Nov 2025
 17:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125084451.11632-1-tonghao@bamaicloud.com> <20251125084451.11632-5-tonghao@bamaicloud.com>
In-Reply-To: <20251125084451.11632-5-tonghao@bamaicloud.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 26 Nov 2025 09:25:27 +0800
X-Gm-Features: AWmQ_bkd2LJNG-4Sov1Vcn2WS3Ga-Ua0aS48hfUf0gR2XcA7CfeXX0EHfMARTVY
Message-ID: <CAL+tcoCi7+8p2TA21cQvmAP2OLpWRzY03NB9Usp5p39KcgoSBQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/5] net: bonding: add the READ_ONCE/WRITE_ONCE
 for outside lock accessing
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 4:45=E2=80=AFPM Tonghao Zhang <tonghao@bamaicloud.c=
om> wrote:
>
> Although operations on the variable send_peer_notif are already within
> a lock-protected critical section, there are cases where it is accessed
> outside the lock. Therefore, READ_ONCE() and WRITE_ONCE() should be
> added to it.
>
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
>  drivers/net/bonding/bond_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 025ca0a45615..5f04197e29f7 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1204,8 +1204,9 @@ void bond_peer_notify_work_rearm(struct bonding *bo=
nd, unsigned long delay)
>  /* Peer notify update handler. Holds only RTNL */
>  static void bond_peer_notify_reset(struct bonding *bond)
>  {
> -       bond->send_peer_notif =3D bond->params.num_peer_notif *
> -               max(1, bond->params.peer_notif_delay);
> +       WRITE_ONCE(bond->send_peer_notif,
> +                  bond->params.num_peer_notif *
> +                  max(1, bond->params.peer_notif_delay);
>  }
>
>  static void bond_peer_notify_handler(struct work_struct *work)
> @@ -2825,7 +2826,7 @@ static void bond_mii_monitor(struct work_struct *wo=
rk)
>
>         rcu_read_unlock();
>
> -       if (commit || bond->send_peer_notif) {
> +       if (commit || READ_ONCE(bond->send_peer_notif) {

Also there is a lack of another bracket... It's not hard to spot this
error if you complete compilation.

Thanks,
Jason

