Return-Path: <netdev+bounces-80061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B69E87CCF0
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 12:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFEA1C21814
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0041C294;
	Fri, 15 Mar 2024 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoypR1av"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952D1BC4D
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503338; cv=none; b=Kj2eTpu8f2qplg82lRo1iiLI4XipwIF/qDMg1Q75MaZt5cG/yYhOaRoctu85WMO3S1Sug4AzfqxPAMejtArjfPJ+XzIn0mB4jjTTjf14vTnhRBspf2Z73SFHVhCIlycZH//6DuAVmsnkFvCP5GW8KRtGwbkumfNqJ1GyWIXnqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503338; c=relaxed/simple;
	bh=xwGKfZufaUhiXCXYsJDtgBgzcdvqo9CJ7vHMJisCpaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4L51BfNAeaVdeQm5+qqkWVTq3F/EAjPDCuut6aa1Vi900KmvFC+yCzG8MzZCGYBJot93weCqa9lMK0LqpbbgVDW8MBOdoIe9pJ3yknhLlks1oah3y0V8ODB2Y+kNG0KTPZAKqks4C7dBMBGcbhXWszJSvynVPM4Lulqp+EoouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoypR1av; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710503334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xwyrO4Nw6XTQrs6yfETpHuCrbfSZVrTnmqnSwO+IBo=;
	b=XoypR1avg8kOwcHJfAqr3swqMR0IAlus5EAo821RkhxfZkStyS99WqMJynXr5Z8l7aIJB7
	QEEshSlVwvz7OOleuOVfUsZGOs8TzQNrYoFPZofsJbw0yHwrYeTT4vWAT7JCgQvf9wb4p4
	kY8/AC4m+Nil00ZLBHih8PKgVnFjbG8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-EjYmC7XnOK2DuP1DOQp9rg-1; Fri, 15 Mar 2024 07:48:52 -0400
X-MC-Unique: EjYmC7XnOK2DuP1DOQp9rg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a462e4d8c44so95897066b.1
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 04:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710503331; x=1711108131;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xwyrO4Nw6XTQrs6yfETpHuCrbfSZVrTnmqnSwO+IBo=;
        b=bWhvivJWWS7r7/X/nGWkPAbNBixG25Mntsem4XIkKbX13+Akg/ytjOuDir+p7DpGWP
         Wf8dOxoQh60niXp5hZZ/lvFUbolqJlPc/0lpEV6vyMd4KVuXOgDkaAHox/Q3KIDalJmh
         zQxN7T+auraQout0TSPzuAqmnU+Jajdd9GFlxWWLOmqb8LEJhDhiNp/vwPsdgiP15bKw
         Nf2KRZo7KxZ+JtQUVcSYi7tavvzYk1B6nNEKLbA5TX7EOYCTSU4gkg9cxR5x8wgTNrL0
         6w2RJ9zrDXqtqjsBZ9dcDYPTcBpSiamZaGLcasKNG3w2kVRXLrYp9lVYKPUOd/83iWiY
         Xsgw==
X-Forwarded-Encrypted: i=1; AJvYcCWje6zJZDNeyfsG0YEFBaQDWm+GTHyFJ5GhfNRG6jEinH1IxfFc9pCYtyjO891+FwlMUc9odLQsXJ3YLe+M377NeFB9h4+s
X-Gm-Message-State: AOJu0YyfWIWnNd3ngSui25SNXiJFKsXYV+P7qpn4+78T1mzMvYSUgt6G
	kVn1B4P0iM1P0RoKMWzwgnROlGLEaV3LGkIvlU+oOV1pOSMW8oO3opYliqsb8I7o+XW/Rdsv4I3
	E4xXNJtA/ThT87vxyt+Dka/MtQohFcbFPP8j750IN5UzmU9oGKuUL6g==
X-Received: by 2002:a17:906:6bd4:b0:a44:1e32:a503 with SMTP id t20-20020a1709066bd400b00a441e32a503mr3190478ejs.22.1710503331518;
        Fri, 15 Mar 2024 04:48:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4rijzPw95HZZMGtM6WYg0TbO/IMk3iMsl8cBCJ65BDgxDM5NoP6dJg1i0hsPqej4NTsP76Q==
X-Received: by 2002:a17:906:6bd4:b0:a44:1e32:a503 with SMTP id t20-20020a1709066bd400b00a441e32a503mr3190455ejs.22.1710503331020;
        Fri, 15 Mar 2024 04:48:51 -0700 (PDT)
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id bw9-20020a170906c1c900b00a4650ec48d0sm1645765ejb.140.2024.03.15.04.48.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2024 04:48:49 -0700 (PDT)
Date: Fri, 15 Mar 2024 12:48:08 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, idosch@idosch.org,
 johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org, Martin Pitt
 <mpitt@redhat.com>, Paul Holzinger <pholzing@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Message-ID: <20240315124808.033ff58d@elisabeth>
In-Reply-To: <20240303052408.310064-4-kuba@kernel.org>
References: <20240303052408.310064-1-kuba@kernel.org>
	<20240303052408.310064-4-kuba@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.36; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat,  2 Mar 2024 21:24:08 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> Make sure ctrl_fill_info() returns sensible error codes and
> propagate them out to netlink core. Let netlink core decide
> when to return skb->len and when to treat the exit as an
> error. Netlink core does better job at it, if we always
> return skb->len the core doesn't know when we're done
> dumping and NLMSG_DONE ends up in a separate read().

While this change is obviously correct, it breaks... well, broken
applications that _wrongly_ rely on the fact that NLMSG_DONE is
delivered in a separate datagram.

This was the (embarrassing) case for passt(1), which I just fixed:
  https://archives.passt.top/passt-dev/20240315112432.382212-1-sbrivio@redh=
at.com/

but the "separate" NLMSG_DONE is such an established behaviour,
I think, that this might raise a more general concern.

=46rom my perspective, I'm just happy that this change revealed the
issue, but I wanted to report this anyway in case somebody has
similar possible breakages in mind.

> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jiri@resnulli.us
> ---
>  net/netlink/genetlink.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 50ec599a5cff..3b7666944b11 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -1232,7 +1232,7 @@ static int ctrl_fill_info(const struct genl_family =
*family, u32 portid, u32 seq,
> =20
>  	hdr =3D genlmsg_put(skb, portid, seq, &genl_ctrl, flags, cmd);
>  	if (hdr =3D=3D NULL)
> -		return -1;
> +		return -EMSGSIZE;
> =20
>  	if (nla_put_string(skb, CTRL_ATTR_FAMILY_NAME, family->name) ||
>  	    nla_put_u16(skb, CTRL_ATTR_FAMILY_ID, family->id) ||
> @@ -1355,6 +1355,7 @@ static int ctrl_dumpfamily(struct sk_buff *skb, str=
uct netlink_callback *cb)
>  	struct net *net =3D sock_net(skb->sk);
>  	int fams_to_skip =3D cb->args[0];
>  	unsigned int id;
> +	int err =3D 0;
> =20
>  	idr_for_each_entry(&genl_fam_idr, rt, id) {
>  		if (!rt->netnsok && !net_eq(net, &init_net))
> @@ -1363,16 +1364,17 @@ static int ctrl_dumpfamily(struct sk_buff *skb, s=
truct netlink_callback *cb)
>  		if (n++ < fams_to_skip)
>  			continue;
> =20
> -		if (ctrl_fill_info(rt, NETLINK_CB(cb->skb).portid,
> -				   cb->nlh->nlmsg_seq, NLM_F_MULTI,
> -				   skb, CTRL_CMD_NEWFAMILY) < 0) {
> +		err =3D ctrl_fill_info(rt, NETLINK_CB(cb->skb).portid,
> +				     cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				     skb, CTRL_CMD_NEWFAMILY);
> +		if (err) {
>  			n--;
>  			break;
>  		}
>  	}
> =20
>  	cb->args[0] =3D n;
> -	return skb->len;
> +	return err;
>  }
> =20
>  static struct sk_buff *ctrl_build_family_msg(const struct genl_family *f=
amily,

--=20
Stefano


