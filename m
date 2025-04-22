Return-Path: <netdev+bounces-184500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F3A95D41
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 07:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCD91895F17
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 05:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8C2199E8D;
	Tue, 22 Apr 2025 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9rdP31s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F60BE46
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 05:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745299165; cv=none; b=nADPRBPLWwxHgpqBT5ox+xq8Euji/fYJzytkoS7tbk57DXgUIyO74AV8WBapogE5v9dALSzliuavFAWsrjhAC5h2f9/lxSIZp9bhryaK4Eo/K4dEjoEDHX3y7+4xcfCS9DNx8dw3XqRcGKXU3m/4fqYy/UOkBKqEpznmq6aAcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745299165; c=relaxed/simple;
	bh=GiLrJHAphI+n6PRCloYe4eIIwU8ik9EKOuYfUe32uiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cR7Wyee+rgBWK33Tx5bhlQUPdzImrkGgQ+PNwn90uoIsHdZ5sIzFY4aN1gGDFsk69g168b+XnrvXKlFQVIzTf8YsEHiB/K4wf7FvdtmvFEESxijHDz4RXdm6EpjdTeOgyTQ5DsGX1qDyC9OLRYOP0tN0X1c2fEksDQuY/VxJO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9rdP31s; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so3601515a12.2
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745299162; x=1745903962; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpIiZ2TqTMSi465S16JvfP6iXTOFpbmWnwZGW0qW098=;
        b=E9rdP31sKi0Xlo1ign8JLut/Yyb7w5nsZzeAPwD6OwZFU9NhHR55KCa7modXrQUaZt
         e8zkGG6h0sRbnJ5ntSS2kIzRftgmI1ic2BB7gWTpTRmnZa/7tk7o8tRl1OW7O2Fsqbz7
         xk833bnvXuwa3n7iiC1KBHCWzztrfvMeFoFDpYZpw7LFBHHAXBaZU+S++4e/EY9qcTTf
         cogZ98uIFG3fVryPMuhwLTtz6hBJxaUyYcGEapGDD6tnyq5raBySPuxU71fvbGKT+1AA
         x8floPNkuFAqs2xAuBqBbFGERMK8E3TK/HJ0I4Ana9vPS4+HOc5h0BN8gYA7ASkfRVCt
         7ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745299162; x=1745903962;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpIiZ2TqTMSi465S16JvfP6iXTOFpbmWnwZGW0qW098=;
        b=b3zCd4/3hHTTzWx5/kWzopGvc5FjIN40FNufQLW5rWf29Q6TYamYETH+jAXl1LyBzb
         gqo7RqZ+wU8y7Wg2oOd9emn5Zgf/k111NZpqU1Ier+waoXBq4GN0O5KW7TsBfBnzj8Gc
         LIGIH2uyzEpjfKhsfBsYvTl7QgF0QKPgEetRqkPeo1z3Gne0EA74O39m6oOGNa47OkA3
         RUWOlOYRGcQxapjZo4Vjpm8LdeP905EccZlcOgVcjQA8JjM8ExhVA+9gDJrhV64pEEp9
         JbjHmZBa2xvli/7YFu6mPV1UUK/uPopSSG/Dcn/hFiRhLjG4Og68Lu8ekjl72DlsUpUi
         uWMA==
X-Gm-Message-State: AOJu0Yz3gvojhNu83200f+A3/RaaSeaiAN7gxmhQqcekKEUELKuEIsKi
	QP5wP02F1+JB9eVFKOJg+Jrjyi4Dy1EONjjCr6lI8usv+PvZbkXH/ZwQ+jrRZP0UjA83vxCyrbz
	rLQxR+wctAS5hZh9y2cBIxJnL2VmIc40c
X-Gm-Gg: ASbGncsRbngT13FKZ+PDCwHhPgZa7RvMZp2JYxEVlPZtAEh2z4tWEuK+77Qlp/JomMq
	q8Qz9lfD/IECP28nNSoxPzxyEYwla6onaPWtAIjYN3yd2wUFyVE7T/6gSUJV+5GqnruGAjSLDX6
	JPkfQswPynG+fSOZUmE/C5VOXz3zzZpZ19fzLVUUNpK20dxYAmB9RPHcIl
X-Google-Smtp-Source: AGHT+IEm1E27UZrUz+Y3A8y1pFyG04D8SYuLP0UcfH+TTdGaBDGncIbRCYZM2TVJCnCjYTofzmPNc8vhqF2ukse9wEY=
X-Received: by 2002:a17:903:2094:b0:22c:3609:97ed with SMTP id
 d9443c01a7336-22c535b46a0mr144544495ad.30.1745299162337; Mon, 21 Apr 2025
 22:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEFUPH2HVZDxLmhqfmiGnFt15KnhpWwRVswMzmTDxY7-zBub2Q@mail.gmail.com>
In-Reply-To: <CAEFUPH2HVZDxLmhqfmiGnFt15KnhpWwRVswMzmTDxY7-zBub2Q@mail.gmail.com>
From: SIMON BABY <simonkbaby@gmail.com>
Date: Mon, 21 Apr 2025 22:19:10 -0700
X-Gm-Features: ATxdqUF8ZWfw9unw-PYhSHDcl76E_zBwjb-TKTZ-GG0yncMQ3MlMpmSZ19Jc7KE
Message-ID: <CAEFUPH2DxA6c9By1V4_YqRof7n2-SR74zBVEzTx1AWBxqZim=A@mail.gmail.com>
Subject: Re: query on hostapd
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Do we have to enable anything in the bridge interface in Linux for
processing EAPOL packets ? Currently the bridge in my setup cannot
detect EAPOL packets.  However the DSA lan ports are able to detect.
The bridge interface contains the lan port.

Regards
Simon

On Wed, Apr 16, 2025 at 10:42=E2=80=AFPM SIMON BABY <simonkbaby@gmail.com> =
wrote:
>
> Hello team,
>
> I have an issue with hostapd on bridge vlan interface (with marvel DSA po=
rts)
>
> I have a linux bridge interface br0.50 (created using bridge vlan
> filtering with br0 as master bridge) with ports lan1, lan2 and lan5
> (DSA enumerated ports)
>
> br0.50 have an IP address 192.168.50.2/24. The DHCP range for the
> clients is 192.168.50.1 to 192.168.50.100.
>
> Radius server is running on IP 10.20.0.1/24 and lan4 is connected to
> the radius server. lan4 is a member of  br0.40 with IP address
> 10.20.0.2/24.
>
> A laptop with client certs is connected to lan3.
>                                                         lan4
> radius server-----------------------------br0.40-----hostapd----lan5-----=
-----------------------------------client
> 10.20.0.1                                         10.20.0.2
>       br0.50  192.168.50.2
>
>
> My hostapd configuration is below:
>
>
>
> oot@sama7g5ek-tdy-sd:~# cat /etc/hostapd.conf
>
> ##### hostapd configuration file ########################################=
######
>
> # Empty lines and lines starting with # are ignored
>
>
>
> # Example configuration file for wired authenticator. See hostapd.conf fo=
r
>
> # more details.
>
>
> interface=3Dbr0.50
>
> driver=3Dwired
>
> logger_stdout=3D-1
>
> logger_stdout_level=3D0
>
> logger_syslog=3D-1
>
> logger_syslog_level=3D2
>
>
>
> ieee8021x=3D1
>
> eap_reauth_period=3D3600
>
> ap_max_inactivity=3D86400
>
>
>
> #use_pae_group_addr=3D1
>
>
>
>
>
> ##### RADIUS configuration ##############################################=
######
>
> # for IEEE 802.1X with external Authentication Server, IEEE 802.11
>
> # authentication with external ACL for MAC addresses, and accounting
>
>
>
> # The own IP address of the access point (used as NAS-IP-Address)
>
> #own_ip_addr=3D127.0.0.1
>
>
>
> # Optional NAS-Identifier string for RADIUS messages. When used, this sho=
uld be
>
> # a unique to the NAS within the scope of the RADIUS server. For example,=
 a
>
> # fully qualified domain name can be used here.
>
> #nas_identifier=3Dhostapd.teledyne.com
>
>
>
> # RADIUS authentication server
>
> auth_server_addr=3D10.20.0.1
>
> auth_server_port=3D1812
>
> auth_server_shared_secret=3Dtest123
>
>
>
>
>
> # Enable CRL verification.
>
> # Note: hostapd does not yet support CRL downloading based on CDP. Thus, =
a
>
> # valid CRL signed by the CA is required to be included in the ca_cert fi=
le.
>
> # This can be done by using PEM format for CA certificate and CRL and
>
> # concatenating these into one file. Whenever CRL changes, hostapd needs =
to be
>
> # restarted to take the new CRL into use.
>
> # 0 =3D do not verify CRLs (default)
>
> # 1 =3D check the CRL of the user certificate
>
> # 2 =3D check all CRLs in the certificate path
>
> check_crl=3D1
>
>
> I observed that with the above configuration, radius server is not
> receiving any packets ( interface=3Dbr0.50)
> If I change interface=3Dlan5 in the hostapd.conf file, I can see radius
> server is receiving packets from hostapd.
> Do you know anything I need to change to work with the bridge vlan
> interface for hostapd ? My design is to have hostapd listen on
> multiple lan interfaces.
> How do we make sure that before the 802.1x authentication is completed
> DHCP packets are not going through? Is this handled by hostapd or do
> we need to manually change the port status or by iptables manually ?
>
> Looking forward to your help.
>
>
> Regards
> Simon

