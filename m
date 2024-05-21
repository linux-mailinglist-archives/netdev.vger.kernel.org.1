Return-Path: <netdev+bounces-97326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F168CAC58
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D90B2129C
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C561F57318;
	Tue, 21 May 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0TjwsOD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2392E859
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287904; cv=none; b=IhYEMSBuqgL9zdPEQ+147/nj7WLScoyoosjrE5brCLVrSTosSsoO5239MIEuU7lrEl5fjZHFgWsJGzeNx1OLw4Pno+jigsc8LBP1UoMzrhSKAG13cUu/f3utIiRwMyV09FppuBho3BYxWG81WAOEmbSeR83CkJM6+mZhBwWVaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287904; c=relaxed/simple;
	bh=grRKTTpLAlkIHKVpgeoWaLslE/a2n3quoztfCSXin1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=atMcWzZrrRNhK87E0xmijJoeYaFPRUiqaBAkLnaeSWlG7yFYMecSAkyyfE0OQe3EiN4aiMBLZxzVAC5kS6A11u5tIVG/vIxAxLU+csIH//Q437wDmxJGJZnh9V5BOG2rhKskcn1PRhqJxPCt70KrOP77BlogWf8Np2w2W2zQe40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0TjwsOD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716287901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1B8TvQlztYzOGjfTmRcZW+bSx0SgYv/ohvZJswWBwqg=;
	b=e0TjwsODGv5BUDIrKHkOQKUDvm/w3FlJQIcWgcMfmF+RRYU4OiEL2G/vII9NhdC+jjB++e
	KJUXCQiugawMi9ufGxf23VhNZ0Sn7nRx1JV4aJGQbenjkQkgv7H+DK9FORvdqh3LkopnoZ
	ahX8t2lolcknrLg1zegPib8r/XPLe0M=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-LVtqp5q3NE2gU-gb9AtFeA-1; Tue, 21 May 2024 06:38:20 -0400
X-MC-Unique: LVtqp5q3NE2gU-gb9AtFeA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51ffdd3524eso2095155e87.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 03:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716287899; x=1716892699;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1B8TvQlztYzOGjfTmRcZW+bSx0SgYv/ohvZJswWBwqg=;
        b=s8HdeiHw5JhNs3kZpjrr3zIphX1FsaqP1xdeYH69K88dQhoCcMYsEh+/z+JrhcR2vw
         pIpSUOD1ZNAL1LWpJaZJK4NjWusWG2Vbc5rfYdTSYP1BwC1n+OXWAAdwG7W8HFqfOqIi
         lyFD0WU8XKzymO7duiqmqyNrdfy9uKvbax1zHKHV44OdgokfjljvrAhP1Xj4V8C4bN5m
         wlOz9Lj9VjwqVtU2sRTjuETmMy50RIEnBEYRmCQ1Ih4RNZGpdOaKp26W9c03HHUzoCJD
         Ff8DNOWZg+AwWhfNTgeszTWMchSORKCBKbSyVzsRwWdYqsL8pHzuBWLGKZsq6YU4pw6H
         wiEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbY5gptXaSGECoPb+FwNCEjlvx/iRWMhUXZi1eKmu/jNMG+j+iiUgNjuDsWSW2zBHnqlR3icw4sRPW1LaOvwZSfdJlEy4Z
X-Gm-Message-State: AOJu0YxqslMH5SbHAdj8FMkk91A326MdxGKAfVfeYVAiZnP4tKmBKPgm
	w16xwey5e2I+1i/URdGbYk8h01Q7osMia6GcWcEkFqn4qGrpg60B5JIC5at89O/ROuwboWSeha3
	CIjhAFsaTEJSEr6o4Zm2Z7q5NvHamgRNMtRS9KsO/yTkfeGNwEIJphQ==
X-Received: by 2002:a2e:b618:0:b0:2dd:87a9:f152 with SMTP id 38308e7fff4ca-2e51fd4a736mr185313601fa.2.1716287899274;
        Tue, 21 May 2024 03:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQLlCKJUsjPAxK5GM1vALQH5GT5i+5lEknyfeBvdXdufRCRAv4UzBWcaDb049+mrDgdsY6vA==
X-Received: by 2002:a2e:b618:0:b0:2dd:87a9:f152 with SMTP id 38308e7fff4ca-2e51fd4a736mr185313501fa.2.1716287898831;
        Tue, 21 May 2024 03:38:18 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee94dasm461256145e9.32.2024.05.21.03.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:38:18 -0700 (PDT)
Message-ID: <81d39fab6a85981b28329a67b454ca92e7e377f8.camel@redhat.com>
Subject: Re: [PATCH net] enic: Validate length of nl attributes in
 enic_set_vf_port
From: Paolo Abeni <pabeni@redhat.com>
To: Roded Zats <rzats@paloaltonetworks.com>, benve@cisco.com, 
 satishkh@cisco.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: orcohen@paloaltonetworks.com, netdev@vger.kernel.org
Date: Tue, 21 May 2024 12:38:16 +0200
In-Reply-To: <20240516154248.33134-1-rzats@paloaltonetworks.com>
References: <20240516065755.6bce136f@kernel.org>
	 <20240516154248.33134-1-rzats@paloaltonetworks.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-16 at 18:42 +0300, Roded Zats wrote:
> enic_set_vf_port assumes that the nl attribute IFLA_PORT_PROFILE
> is of length PORT_PROFILE_MAX and that the nl attributes
> IFLA_PORT_INSTANCE_UUID, IFLA_PORT_HOST_UUID are of length PORT_UUID_MAX.
> These attributes are validated (in the function do_setlink in rtnetlink.c=
)
> using the nla_policy ifla_port_policy. The policy defines IFLA_PORT_PROFI=
LE
> as NLA_STRING, IFLA_PORT_INSTANCE_UUID as NLA_BINARY and
> IFLA_PORT_HOST_UUID as NLA_STRING. That means that the length validation
> using the policy is for the max size of the attributes and not on exact
> size so the length of these attributes might be less than the sizes that
> enic_set_vf_port expects. This might cause an out of bands
> read access in the memcpys of the data of these
> attributes in enic_set_vf_port.
>=20
> Fixes: f8bd909183ac ("net: Add ndo_{set|get}_vf_port support for enic dyn=
amic vnics")
> Signed-off-by: Roded Zats <rzats@paloaltonetworks.com>
> ---
>  drivers/net/ethernet/cisco/enic/enic_main.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/et=
hernet/cisco/enic/enic_main.c
> index f604119efc80..4179c6f9580d 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -1117,18 +1117,30 @@ static int enic_set_vf_port(struct net_device *ne=
tdev, int vf,
>  	pp->request =3D nla_get_u8(port[IFLA_PORT_REQUEST]);
> =20
>  	if (port[IFLA_PORT_PROFILE]) {
> +		if (nla_len(port[IFLA_PORT_PROFILE]) !=3D PORT_PROFILE_MAX) {
> +			memcpy(pp, &prev_pp, sizeof(*pp));
> +			return -EOPNOTSUPP;

I think -EOPNOTSUPP is misleading here (and below), -EINVAL should be
appropriate.

Thanks,

Paolo


