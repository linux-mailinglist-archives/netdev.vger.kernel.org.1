Return-Path: <netdev+bounces-292779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJnjCit8GGrbkQgAu9opvQ
	(envelope-from <netdev+bounces-292779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:32:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8E35F5A84
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2420D300B877
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F0D3BE621;
	Thu, 28 May 2026 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXW+SrUb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ntaja/sN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1392FB632
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988912; cv=none; b=UBriaJ41uvaerWgCsMsqbsgHQ8ja0ktRxY7hqgMtNHjnhjt0LLN2D6QrSjJEYpyKA8/tlCCRdwuqnukXL5fVxSMdJ3xVUJX21qONa4Aco0R+EuwwSkhVgd6QPDfPByPFs+gOMIzuUb86OyDAi+BylCzQoDHGWEl/LKjlmUce31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988912; c=relaxed/simple;
	bh=ak+9VaQCwa+2eObY8aFqnl+wMj19EhLRsG/oy7TP2zo=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=R1NbFpAdPj53gZn1wHNi7B9ddtL7zQ7BEfXOVajXLYRmjE3H/4nsrnQCa18m8jqrMzmwcMUHKFzfcFtg9b3X76qxm350DOJ0FOYE5Og1d2M3GJjN48C/wjoECugINw6HiRLQL7QVDSPFbc3U4+BMHfxDq98t0ZUBcXUZyPzYSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXW+SrUb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ntaja/sN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779988910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IAWVLrtIzQ5xVgTvqwLoqJOfqrR7MpH88SIQQGUoj4=;
	b=CXW+SrUb3LmUCd1iWW0h/vdvrBy+3e6eTWCS/aC/6NdbskYJpyCsOyWerQfcU2c3r6q9yR
	vXj8R7VU/NL5M2CQ1BBMRtNpvczI3BYPiizd8zL8MF5dNCM/kbjlbWPiT4VqfONZK6vv7F
	IQn06j/Yh+aK1JsjkhyQe9Mu0+3FTNE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-l0rh1HDVM2avM2-39NnmrQ-1; Thu, 28 May 2026 13:21:49 -0400
X-MC-Unique: l0rh1HDVM2avM2-39NnmrQ-1
X-Mimecast-MFC-AGG-ID: l0rh1HDVM2avM2-39NnmrQ_1779988908
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d789cebcfso8711390f8f.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779988907; x=1780593707; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IAWVLrtIzQ5xVgTvqwLoqJOfqrR7MpH88SIQQGUoj4=;
        b=ntaja/sNUpYOAKtcwsxStszKpOc5F5I9/AUwPTztwzCRSf3Qo1IOjq0ISjX76EIplR
         ALdaq375z6L9hB9M/LwKHfibWO+/dsbIqDGnR9+h/VcV9kLC3T4gSojMJ7cbdyWVqeFH
         4xM2JQnWhPMY5uOqy2yapdvkK3qYccxHAX1ot2GlIXM6r/oiwZMHBWHU4ey98P7VWh3j
         8XZ9xWGyCi/z3WxxFygn4OQHrxX5jDg+Jpf+pewqOqlAHO3Szu02NEjZk3jmp+sJ82WV
         SwtpqZScPfQvu8VP1IL41LyCMISpFy5oARiYPt8REmYRLCQ82JmoFSCtbBHSQGRCl9E4
         /T4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779988907; x=1780593707;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IAWVLrtIzQ5xVgTvqwLoqJOfqrR7MpH88SIQQGUoj4=;
        b=CpSGKMOv/P+KW+IF6vZNLYVTCuTtDoY3FVWrEAkA6ENsTKdMnADwNjy30MszrT0uSC
         uC/tJvrKTE3Te6htDcl8iYpqB3Cb4ummUxmXgIx9WuqpiTith33gcr8HcPFxiJeyCvv1
         1AkTc8xfIXjKm9jkL+YNx8G5+V+71XDJCC5NhrD+/fZzM3jRVdU6A17zIWVK9zKkz/m0
         r+9NagsobYdJXGyYiUG1khEq0iHyjim4KskC/kf9v16kmLRl3IoHCjaJ9WcEgei/wSIN
         Lo5JzGNEDMVwr4s1WxR2iviujWyx83tBkmyteGb9KjFhuMim+xLmpsJWBAzauiXfSnNV
         4tEw==
X-Forwarded-Encrypted: i=1; AFNElJ/XaDd3R+vlIsftlsBFbJiTyFRwO3KHeBSOtIx448UJ2zJg40yp9U3gWVMFAUAUkdnwTj4ioKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLXTn1XgtR0c/5pvdVEQp8+cc/+Mw+BdeRbDtBDTfrByfJ6Jm
	RDK6MQAqq+q4HgsnlS7K5HUfEzFUJvHaURV3Y/cDQuPeeGos/tFU1Jvr2TX4POCmi3PUx740EcV
	au5BeMbcPIIsBPIFFIKd4u/OoNwQnHqixcqTU+sfsWMU16PknqhJl8CIIUw==
X-Gm-Gg: Acq92OEH+l8Sc70dYtoNnW8SaZk2s8bE9VVXxTKA294oWAWVbsZ2qG9c8g0JZXLAAbd
	vqv8g4bwF727h/RMW5KWgN72OY9U+soQa4EOYb00Er2ZJtJzj+qZmgx9icNz9eQUySHekY9Y+LI
	CozlxcdLDXn+urrXpo0EWQIWFTPTCSfh8dEx5DzpQLzeg1p/VK+N/uAHV08lGUDBGQm2PEOHeon
	+/6L+LpXYwmiiHwikosHAYAyx5CeAl5NPxdm8j6RKAJ4CQgJLIdnD3gck+MRLtz0u3hnyBK4cs6
	UEV/mJX/7nVE6fZPoX2bzz/9yjQkF6yaQTvbu9NhZ4oJsfbBzQb7bujNU3IfTabrCaCg/+LzVoD
	FR2TUYazgFhV+JprR1I1LjYoDOv6Be8TtUmJIBXvbJ7I=
X-Received: by 2002:a05:600c:5359:b0:488:a502:8955 with SMTP id 5b1f17b1804b1-49094777acdmr30132295e9.4.1779988907533;
        Thu, 28 May 2026 10:21:47 -0700 (PDT)
X-Received: by 2002:a05:600c:5359:b0:488:a502:8955 with SMTP id 5b1f17b1804b1-49094777acdmr30131815e9.4.1779988907012;
        Thu, 28 May 2026 10:21:47 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b19aasm15998612f8f.25.2026.05.28.10.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:21:46 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Beniamino Galvani <bgalvani@redhat.com>
Cc: =?UTF-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>, Fernando Fernandez Mancera <fmancera@suse.de>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Yumei Huang
 <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, Justin Iurman
 <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>, David Gibson
 <david@gibson.dropbear.id.au>, Linux kernel regressions list
 <regressions@lists.linux.dev>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260528192143.31c9e9ea@elisabeth>
In-Reply-To: <ahhm1-XfnsWyIWDV@tp>
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
Date: Thu, 28 May 2026 19:21:45 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[redhat.com,leemhuis.info,suse.de,kernel.org,vger.kernel.org,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-292779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D8E35F5A84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 18:01:27 +0200
Beniamino Galvani <bgalvani@redhat.com> wrote:

> On Thu, May 28, 2026 at 05:24:28PM +0200, =C3=8D=C3=B1igo Huguet wrote:
> > On Thu, May 28, 2026 at 4:53=E2=80=AFPM Stefano Brivio <sbrivio@redhat.=
com> wrote: =20
> > > I think what's considered UAPI in this case isn't so clear-cut. I gue=
ss
> > > it would have been pretty hard for anybody not familiar with
> > > NetworkManager's codebase to imagine that an application would rely on
> > > IPv6 addresses (and only IPv6) to be returned in the reverse order. =
=20
> >=20
> > IMHO it's not because an application would rely on the order. It's
> > because the order matters, as the first one is considered the primary.

Yes, that's also the case, but:

> > This is not NetworkManager specific. Or I am mistaken? I'm speaking by
> > memory

...from what I understood of the issue at hand there's a part that's
specific to NetworkManager here, because NetworkManager replaces /
deletes the Privacy Extensions addresses, instead of different
addresses, because it relies on that specific (reversed) order.

Anyway, yes, I see your point about UAPI now.

> Yes, exactly. If you do:
>=20
>  ip addr add dev X 3fff::1/64
>  ip addr dev dev X 3fff::2/64
>=20
> then the old kernel chooses the address that was added last as source
> address for outgoing communications. With the new kernel it chooses
> the address that was added first.
>=20
> I think that any script or network management tool that cares about
> the source address selection is impacted. Indeed, the commit had
> effects on one of the selftests, which had to be modified to change
> the order of iproute2 invocations.
> =20
> > > > If the fix must be in NetworkManager, we only need to parse them in
> > > > non-reverse order like IPv4, I guess. =20
> > >
> > > But that would then require some form of detection, and, at least
> > > according to Fernando, isn't the most robust option anyway, as ideally
> > > NetworkManager shouldn't rely on the order at all. =20
> >=20
> > True =20
>=20
> Correct, if the new behavior is considered better, there should be a
> way to detect which order must be used. Otherwise userspace tools
> won't be able to maintain the same behavior with different kernels.

My remark here is about whether NetworkManager needs to detect this at
all. If it used timestamps to detect recent / older addresses, as
Fernando mentioned, then you wouldn't need any detection at all, right?
Or is there something else we're missing?

By the way, if really needed, one could detect that with the equivalent
of:

  ip a a ::2 dev lo && ip a a ::3 dev lo && [ $(ip -6 -j a | jq -rM '.[] .a=
ddr_info[0].local') =3D ::3 ] && echo wrong || echo right

...depending on the application, that's not necessarily practical, but
so far we have no evidence of any application needing to do that at all.

--=20
Stefano


