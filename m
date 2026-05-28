Return-Path: <netdev+bounces-292815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KyPOPCVGGoMlQgAu9opvQ
	(envelope-from <netdev+bounces-292815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26D5F7013
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACF663011A58
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CFB34D384;
	Thu, 28 May 2026 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ef1kOf5v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuDtjHJf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A532B11D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996141; cv=none; b=HmtcF4SyKmrb+hx3MU7DlyCMtOjvvrzIxqTCQkSJ2cZWzWC9U/N8a6cIP/sKAsZPFd1ZKNgjbgwpjH/k419XIcZdoICXZCKqVvxLgDsS4gfxEgCHVOvI9MYb4y/3/in6MMFb0rKLEzcQs6jRGyzFpuuy+0j+7Zg8tBV1mhpx3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996141; c=relaxed/simple;
	bh=NUwpRhe8WcueYyPJ0tzoOPl37nRdd5bT/kEcrM+PMqc=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=ERtNoVwdgA5WLaV3pd9WXIl+nyXFdKqktJFK8ITY9zObnLdNIvFnHp6kJ6JWCbueWklWQQh9lHSAWC61sIyNNI9XdRvB4d0eG1bDqVRSzSPom42u981RIIuflANfgpzDT8DBA/De8xSnJOkNDDe1XPRa+ggefgPNG86UaHSWVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ef1kOf5v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuDtjHJf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779996139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dx/6eLItiucIm4A2R0ZnASp+ymf3y4PKplbSYqHwDcA=;
	b=ef1kOf5v/DtU9CYymq+8MT0NOvs2lFSiwXCuoT2v/AgClxN5Si6LlUtd6zG4JcTtKOleNp
	dPID0hfiCTWKC626YUvo+53oM3IaxHUOVmYRttSbWNN8l6PuLyipiQUTNwD5N9ElR0kUhg
	F9WjaUxkuyEvZdsUCqHWKR6uFgT4X94=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-b05mXAO2MDucGimyRtIasw-1; Thu, 28 May 2026 15:22:18 -0400
X-MC-Unique: b05mXAO2MDucGimyRtIasw-1
X-Mimecast-MFC-AGG-ID: b05mXAO2MDucGimyRtIasw_1779996137
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49058e91639so40651265e9.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779996137; x=1780600937; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx/6eLItiucIm4A2R0ZnASp+ymf3y4PKplbSYqHwDcA=;
        b=AuDtjHJfiAdC7JIrV9X2HKpBlE2yJyPC8R5udqYEJ55mFMKqTOLoh+LGx5fkUocYAb
         WO5BMff3VQ1BndRy8DWqiANpqHT5EZwR7Ry5gyaqd/CoIx4866WJj0GxMAW4xk9khYfE
         6g+ZK2OPkf/2HlKi0lvzJN59X1wkp6njWc4wJRJYWwNDJe3hXr03WbMPpBcflOV89QtE
         zdjIHBq0P3lBDWdUcojtB9ruPVyeHg9TNc1LWdapMs1w9qa4HCyq3jfiGH4UiLlHkYVO
         URoxJ9iuwiikMILlPDV58Drc+HaKCqC9rJM7AP9tuwwbKFEB0U5tSd4NW/2Lek6ZaPhY
         MZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779996137; x=1780600937;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dx/6eLItiucIm4A2R0ZnASp+ymf3y4PKplbSYqHwDcA=;
        b=LP5x3b8/ht9O536IC+xloPM1Cw2tSMKj4a1hJ0IMTEPgA93aTbWVnF2kZLXNklEQ+r
         XjVS2TlzG5muE+bGj7wdVKqeTUN2Q0oOsdXpWNiejbRmSwz3oSBOabC8Ypos9rC8pZ/o
         ZfAE3QClPttu+z0houJwX7hYBw6JLRRVlK0EWNkzm2Zk0z7OWgJvke1CTYSCVayO01bz
         OdroZjxYoMsISAdgo4iFnE/sLEiviri351jdLOO5bZW+mKyhKEwHsaZ75n0/j+l3eevK
         Qn4vcRCABNvftHJUPPQQqbz3egk6E4w7DTnpEuHHwGrcz+Gsghjmd7RV+92fxb7XPa/f
         XfYw==
X-Forwarded-Encrypted: i=1; AFNElJ8d4BvSPYCeyoI6UjvImABZl2FY2LsL64M0TISCRjA3s6EVAAV0VIfSctHKBH74ERcfn1HSacg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7kb6/heCZSjuwNFAHb9rtxozOiEpAKEn3tpIQqg+SipcFHmf
	1uyaS6v4K9ZJo83wxc646ty+h4SHSdr2XqQI+tpB86KGD7t44uf/3VWhJlt6Zy3gVx7UiwZxNgD
	B9lmTRlFbqpvFZoNfsE7Pd5hg4VqmtpmuStdqc57J2KJHM1CYQEc3gTeTYg==
X-Gm-Gg: Acq92OElSt6SOOcUTPoXMSkBQHdM1X6hntfTKCWR1M5g/bBN/S92TG6l6q22cekHxGG
	E7UTO5M09z3EWukiOmWLbIuSWjUnQvRAkZ+b4qKNNxzBfAkp5+DHT19XECLNgWvnuCEKUz+FxCa
	kZktTe2cK3PscpaRGPOyYKoSt8rYfHlKcjDW+H8U7yXFB020qGGc7ocfANhjHLvShEc2UWcO+mC
	40jP9BDygAU7kQ4hJa5/nJ4gtp+FiRj+LJHO0wPYYkfQ1gijHmoFb2G+V4YlRmzepXXH7c7Kkv+
	wFr6h1dVVM5XSpm5L97SCb7uD8cLlsnX1WzMkqLSYvg270kLy2j2bzQrJ2aFeZa84oX0816l6v9
	2P7U10cOL3Oo/Fqkq8jL47V5x/3tnj4pkfzqMzyDiKAWhWG6dH0jB51eWq4Yl
X-Received: by 2002:a05:600c:35c8:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-49044ebc2d5mr519116565e9.30.1779996136510;
        Thu, 28 May 2026 12:22:16 -0700 (PDT)
X-Received: by 2002:a05:600c:35c8:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-49044ebc2d5mr519115935e9.30.1779996135923;
        Thu, 28 May 2026 12:22:15 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909bba94aasm374245e9.16.2026.05.28.12.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:22:15 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Beniamino Galvani <bgalvani@redhat.com>, =?UTF-8?B?w43DsWlnbw==?= Huguet
 <ihuguet@redhat.com>, Thorsten Leemhuis <regressions@leemhuis.info>, Jakub
 Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Yumei Huang
 <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, Justin Iurman
 <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>, David Gibson
 <david@gibson.dropbear.id.au>, Linux kernel regressions list
 <regressions@lists.linux.dev>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260528212213.4aa613f8@elisabeth>
In-Reply-To: <e91507d6-cbfc-447c-8236-d9b3d91f18c5@suse.de>
References: <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
	<20260528073849.759da84a@elisabeth>
	<baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
	<20260528131250.1352ab48@elisabeth>
	<b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
	<bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
	<20260528153202.14900687@elisabeth>
	<CACT4ouf5ZqGgb=RO8_7NovLCvYKLKL4vD70dEe6xUODT1UEcSA@mail.gmail.com>
	<20260528165320.15b90ded@elisabeth>
	<CACT4oue2EMM9Kfsm9Jii2rG9ooi=D37PK=8886cpLuBkwhrOxw@mail.gmail.com>
	<ahhm1-XfnsWyIWDV@tp>
	<20260528192143.31c9e9ea@elisabeth>
	<ed954836-742a-44c3-8c2d-65dd06c3514e@suse.de>
	<e91507d6-cbfc-447c-8236-d9b3d91f18c5@suse.de>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 21:22:14 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,leemhuis.info,kernel.org,vger.kernel.org,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292815-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5A26D5F7013
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 20:50:48 +0200
Fernando Fernandez Mancera <fmancera@suse.de> wrote:

> On 5/28/26 8:42 PM, Fernando Fernandez Mancera wrote:
> > On 5/28/26 7:21 PM, Stefano Brivio wrote: =20
> >> On Thu, 28 May 2026 18:01:27 +0200 Beniamino Galvani
> >> <bgalvani@redhat.com> wrote:
> >> =20
> >>> On Thu, May 28, 2026 at 05:24:28PM +0200, =C3=8D=C3=B1igo Huguet wrot=
e: =20
> >>>> On Thu, May 28, 2026 at 4:53=E2=80=AFPM Stefano Brivio
> >>>> <sbrivio@redhat.com> wrote: =20
> >>>>> I think what's considered UAPI in this case isn't so clear-
> >>>>> cut. I guess it would have been pretty hard for anybody not
> >>>>> familiar with NetworkManager's codebase to imagine that an
> >>>>> application would rely on IPv6 addresses (and only IPv6) to be
> >>>>> returned in the reverse order. =20
> >>>>
> >>>> IMHO it's not because an application would rely on the order.
> >>>> It's because the order matters, as the first one is considered
> >>>> the primary. =20
> >>
> >> Yes, that's also the case, but:
> >> =20
> >>>> This is not NetworkManager specific. Or I am mistaken? I'm
> >>>> speaking by memory =20
> >>
> >> ...from what I understood of the issue at hand there's a part that's=20
> >> specific to NetworkManager here, because NetworkManager replaces /=20
> >> deletes the Privacy Extensions addresses, instead of different=20
> >> addresses, because it relies on that specific (reversed) order.
> >>
> >> Anyway, yes, I see your point about UAPI now.
> >> =20
> >>> Yes, exactly. If you do:
> >>>
> >>> ip addr add dev X 3fff::1/64 ip addr dev dev X 3fff::2/64
> >>>
> >>> then the old kernel chooses the address that was added last as
> >>> source address for outgoing communications. With the new kernel it
> >>> chooses the address that was added first.
> >>>
> >>> I think that any script or network management tool that cares
> >>> about the source address selection is impacted. Indeed, the commit
> >>> had effects on one of the selftests, which had to be modified to
> >>> change the order of iproute2 invocations.
> >>> =20
> >>>>>> If the fix must be in NetworkManager, we only need to parse
> >>>>>> them in non-reverse order like IPv4, I guess. =20
> >>>>>
> >>>>> But that would then require some form of detection, and, at
> >>>>> least according to Fernando, isn't the most robust option
> >>>>> anyway, as ideally NetworkManager shouldn't rely on the order
> >>>>> at all. =20
> >>>>
> >>>> True =20
> >>>
> >>> Correct, if the new behavior is considered better, there should be
> >>> a way to detect which order must be used. Otherwise userspace
> >>> tools won't be able to maintain the same behavior with different
> >>> kernels. =20
> >>
> >> My remark here is about whether NetworkManager needs to detect this
> >> at all. If it used timestamps to detect recent / older addresses, as=20
> >> Fernando mentioned, then you wouldn't need any detection at all,
> >> right? Or is there something else we're missing?
> >> =20
> >=20
> > Ohno. Now that Beniamino and I=C3=B1igo mentioned it, this will likely =
break
> > many other environments. In essence, many tools relies on the previous=
=20
> > ordering to identify which address is the primary one.
> >=20
> > E.g cloud tooling communicating with the metadata server via IMDS(v2) t=
o=20
> > configure IPv6 primary and secondary addresses. They are likely relying=
=20
> > on the ordering for that.

I haven't seen any tool specifically relying on insertion order for
this so far and I'm having a hard time believing this kind of tooling
wouldn't rely explicitly on home / care-of addresses or different
labels -- see RFC 5014 and RFC 6724 Section 5. (or, perhaps clearer,
the examples in section 10.1, in particular rule 4. and rule 6.

But I'll look for more convincing examples in a bit (maybe you have some
at hand?)

This is all implemented by __ipv6_dev_get_saddr() and friends, by the way.

> > So maybe we could fix whatever is wrong with NetworkManager and=20
> > temporary addresses order but I don't think this will scale for the=20
> > cloud tooling with the primary/secondary issue.
> >  =20
> >> By the way, if really needed, one could detect that with the
> >> equivalent of:
> >>
> >> ip a a ::2 dev lo && ip a a ::3 dev lo && [ $(ip -6 -j a | jq -rM '.
> >> [] .addr_info[0].local') =3D ::3 ] && echo wrong || echo right
> >>
> >> ...depending on the application, that's not necessarily practical,
> >> but so far we have no evidence of any application needing to do that
> >> at all.
> >=20
> > Plenty of tools (NetworkManager included) uses netlink so this isn't=20
> > useful for them.
> >=20
> > For now I am more in favor of the revert and to look for an alternative=
=20
> > for pasta situation (like using a flag or something). But I am not a=20
> > maintainer so it isn't my call :)

One question I started wondering about later is: should the flag affect
insertion or reporting, in case? I think we would need one for
insertion, otherwise it's not really generic / functional.

> *facepalm* I just noticed the "with the equivalent of", disregard this=20
> last part tho.

Right, yeah, having a netlink implementation makes that a bit more
convenient. :)

--=20
Stefano


