Return-Path: <netdev+bounces-238690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2E8C5DB71
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1ED64F661B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2D132693B;
	Fri, 14 Nov 2025 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="E7nwDY9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3B324B1F
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131439; cv=none; b=aIkENGbbpl5qVlfrNn1Ov3wVq3UqlVTlAMdj4RObXmpTNl/q0VE9rAwV7HCnPyweCtZoZzbfKhIfqMpP8jLlaWB3YCldW6XCX5hJnua033azsJXAzJq3gQ1WRCwsTjYAUySOtaHJj3lKL4PeOsEaiWdHrHJPrmJEVWYLoeScQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131439; c=relaxed/simple;
	bh=noBED6JJFeBnXGfTgkpfqH5f7ruXGF+ZudHJLqI5M+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VDTusTX+usux9CRaHjceTCVPjn6708nk4ZdwWTwGY0y9/oTcVy/e+W0IyXgArbZzVvmhR3y7LKFgjnmDVhD7XbJUDXznqWVDfzaHe7sJpZdkT6dGZWcFuG3/hYBXndlkHt2Ck0++yLLaR4rLY6WPhoDYmhxkLn6SMl1qYW8mf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=E7nwDY9n; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47774d3536dso18171205e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 06:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1763131436; x=1763736236; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GVAysmbBJxrO83Dvu2cU1QRzNlUaS2l/2JXSPvo3ArM=;
        b=E7nwDY9nllla6NAY82ylIIKq33E708JwOLxsNkUnvvz+KpRdAnmNooAlIECdC/VyJz
         mQBM7bbbh2mnaACSwmNha2D65c/eAOZD1htsFsfCIQkDXsPVEF90WmOwRPwtFpoz9PNK
         cH3uVvAwLdsEI76+tot3nbAenFeIMrfJ5Q+6/tZPx/LRVy89zuJGydZLcHYp/RcXtwi9
         tDC61oR6RNDLEUpg7bmypPrpjtl8ZBMogtQCZpb6jaepE87HzvuF/rM2v8CzqtUixOiQ
         fXE1t8Swho0StXS4MP0xqJmotOi4V0VhYtoU8UcK72dCcahPypxXnQePb96BLTBG4xc8
         4mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763131436; x=1763736236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVAysmbBJxrO83Dvu2cU1QRzNlUaS2l/2JXSPvo3ArM=;
        b=AqNBTk2CTPMC1oRasgzfAwMh7PyO9DDewm5IHTjXLDjO5yX4VixWym+vh8jpfShha8
         dtl3jgYn3qE3GS/ZIg4Ovrko/wwTcyF5/RA94MHy2F82X6WzUwo8oLjzIt9atZBJWgDJ
         evWG+eZ8yIwv7ys5JmKbzDvRa38Dq82lbZn9OcHE5reU68+XVZkMN5+EPg5jJzDsvMnf
         hdmnSEyRRTd8abDSX/vqblvYuwAGiGZVIKXQhFps7hkYk0CWvqsUOMwYrYdLDO3CI+k5
         Cgs+LQTrqpi5AqmMK6xq2USrmJ93xczqtKrkJkDMCe+78ry3MPqpCaEUW9BH1BzFBfuN
         znhg==
X-Forwarded-Encrypted: i=1; AJvYcCXFhCC6wm7XnY2n3MqZgwJQaBuviYJFja7Rq90fFCr/lPMF1O6wBHHRrDQkzC87hphy7/zAApI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPg6PkiaZgOeJMyrj1TYTHAz75+wQDs62j2xe7dQUuroKijzl
	Tv6uPYgWCDcXKbd422gBw5J6w8b/5QS5hqIHTVf/RoDtwptSRBh7ualQdkU5VfqvXM4=
X-Gm-Gg: ASbGncvwksBNBtibtjbB/OM+iIrYP7f0Pg4s3KLnhRbHQ9ogNolVK505c9oY9jrm4Sd
	mFq40l7HHB0Uykn2QusL3h5oNsQGJrq3Ixjl3aAbMnd76qIdibAuhX/j96o3khXoUSfszvcMJnV
	N2n1YMXp4ocZouKFcUxxzdV1725zgyaqBXbGrMAlxGvZd4IZg4SmK3lSVu4+wM42bNY8jp4dNle
	zRZInI0K3zHD/+8zNShZlhUjtSBhKvikfRT97iDfhdGqFlVXPrR5X1SRzjarb64WDT1xrlJr5yQ
	H9T3gRVOYbLNxPZ1oVaiVqYzLnCSsoGhuiOMZqZvwUYu+kQhoB1IbO2Mg7t2V9ZnoWSnnfQMGjE
	uJOAeg9lnle6NVa+JW5+DmsBn8pKw55U2vEq1VwGGONal59VOdJCt5ipzLE613h6RbtwNxprcGd
	hrNp6L8QucK+bRfBIzMeoYNtYhr9hv8VZpJU33agScuOvI5omdCuXSh1eCVQ==
X-Google-Smtp-Source: AGHT+IEDyvDkVhBLEoOJXpkAQkGIXX/PFhnKgrfUdlbf+kwkK0WC6NBbM/jhpxz3Nf9rYFK+8iGCSQ==
X-Received: by 2002:a05:600d:486:20b0:471:793:e795 with SMTP id 5b1f17b1804b1-4778bf41181mr46049535e9.0.1763131436025;
        Fri, 14 Nov 2025 06:43:56 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2bcf9sm153289615e9.3.2025.11.14.06.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:43:55 -0800 (PST)
Message-ID: <e811259e74177870349459ae1a4342001e6f4e5a.camel@mandelbit.com>
Subject: Re: [PATCH net-next 3/8] ovpn: notify userspace on client float
 event
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Antonio Quartulli
 <antonio@openvpn.net>, 	netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni	 <pabeni@redhat.com>
Date: Fri, 14 Nov 2025 15:43:55 +0100
In-Reply-To: <aRc7H4ne5cCgZvyL@krikkit>
References: <20251111214744.12479-1-antonio@openvpn.net>
	 <20251111214744.12479-4-antonio@openvpn.net>
	 <20251113182155.26d69123@kernel.org>
	 <fdf87820e364dda792a962486bef595cd6428354.camel@mandelbit.com>
	 <aRc7H4ne5cCgZvyL@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-14 at 15:22 +0100, Sabrina Dubroca wrote:
> 2025-11-14, 10:26:31 +0100, Ralf Lici wrote:
> > On Thu, 2025-11-13 at 18:21 -0800, Jakub Kicinski wrote:
> > > On Tue, 11 Nov 2025 22:47:36 +0100 Antonio Quartulli wrote:
> > > > +	if (ss->ss_family =3D=3D AF_INET) {
> > > > +		sa =3D (struct sockaddr_in *)ss;
> > > > +		if (nla_put_in_addr(msg,
> > > > OVPN_A_PEER_REMOTE_IPV4,
> > > > +				=C2=A0=C2=A0=C2=A0 sa->sin_addr.s_addr) ||
> > > > +		=C2=A0=C2=A0=C2=A0 nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT,
> > > > sa-
> > > > > sin_port))
> > > > +			goto err_cancel_msg;
> > > > +	} else if (ss->ss_family =3D=3D AF_INET6) {
> > > > +		sa6 =3D (struct sockaddr_in6 *)ss;
> > > > +		if (nla_put_in6_addr(msg,
> > > > OVPN_A_PEER_REMOTE_IPV6,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 &sa6->sin6_addr) ||
> > > > +		=C2=A0=C2=A0=C2=A0 nla_put_u32(msg,
> > > > OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
> > > > +				sa6->sin6_scope_id) ||
> > > > +		=C2=A0=C2=A0=C2=A0 nla_put_net16(msg, OVPN_A_PEER_REMOTE_PORT,
> > > > sa6->sin6_port))
> > > > +			goto err_cancel_msg;
> > > > +	} else {
> > >=20
> > > presumably on this branch ret should be set to something?
> >=20
> > You're right, otherwise it would return -EMSGSIZE which is not what
> > we
> > want here.
>=20
> But that should never happen with the current code, since
> ovpn_nl_peer_float_notify is only called by ovpn_peer_endpoints_update
> when salen !=3D 0, and in that case we can only have ss_family =3D AF_INE=
T
> or ss_family =3D AF_INET6? (and otherwise it'd be an unitialized value
> from ovpn_peer_endpoints_update)
>=20
> (no objection to making ovpn_nl_peer_float_notify handle that
> situation better in case it grows some other callers/contexts)

True, with the current code we can't reach that branch. But as you
noted, if the calling context evolves, we're already covered and IMHO
the cost of handling this case right now is negligible.

--=20
Ralf Lici
Mandelbit Srl

