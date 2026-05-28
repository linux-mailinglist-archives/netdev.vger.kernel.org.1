Return-Path: <netdev+bounces-292736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKbjA8VYGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:01:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D455F413C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B85E930BA547
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25158409621;
	Thu, 28 May 2026 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4LIi7Vx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDUkuO08"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A5408028
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980079; cv=none; b=KoDziD2+sZvJO9pP0oe0Z9xBKeqkbNLTs5Y7ibZgJsT5SDVfIRxVCRbK4EmgNfTXHLaK4F1lbMsuMkiqHVB00JWkauSb1EnlurpQFsiqVMW2+SYtR3nu1lGSB9qBB3peQrny1KIQB0TPhzZpkgZ0I6TybVCvl705JEiXwfc6wIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980079; c=relaxed/simple;
	bh=xpY3ZijaXiuJOkFKvi2YUN/7pNpdMH0cGhSXkrJHogw=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=g4Q56XQIlWLMHnacHqsQUlVw9ye9gOQQ1rvypocoetaSWJ0WrSxY9IexNX3G5G/zKIpmntONSss3MsvbIJHEAzMaBLqq9Ws6VPXCT4r2a5cVNFmSKyHEzFhbxm1xFxV86LcP+dNdbXHMiJKYF9mD5z4gtmzGVuRpJprSD1dQr5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4LIi7Vx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDUkuO08; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779980070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpY3ZijaXiuJOkFKvi2YUN/7pNpdMH0cGhSXkrJHogw=;
	b=h4LIi7VxcJElktK5GGPiNcjQjP5XCHg96+/phbeU24YUOg60rCaJ+1yZ29OWpFoJz0XTAM
	adj8ujFZ4I1PF7ciHZit2JKLv1JXbbRjUFbxq9IdvLFhIwj3RhgWsBPfPH/OutTU05tkZc
	uh3mAg0lv0dOpH5mmE+CTcu9HD+lydE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-ls-k2L07PyCtZa8yWY50Ew-1; Thu, 28 May 2026 10:53:24 -0400
X-MC-Unique: ls-k2L07PyCtZa8yWY50Ew-1
X-Mimecast-MFC-AGG-ID: ls-k2L07PyCtZa8yWY50Ew_1779980003
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490402ae2c1so66839695e9.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779980003; x=1780584803; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpY3ZijaXiuJOkFKvi2YUN/7pNpdMH0cGhSXkrJHogw=;
        b=LDUkuO08AYWWtM5Z98QgPF8O7oz5YY8uBkALsL4EwhEB9oVeH82Qspogbxlf25MnKN
         J+nz+rtArgFzejnn8r1lWvVlzYpPHeLd41uxwkWjpG+u+h66fw4uCR37azzLAW7QXfXM
         j0N0csfFvbImkuJWYA4FJVM6SRClSKaAJMLFfwoFfHXzyjQr9sCclj1oowDkRA2FKMq9
         T04Kt6X5OQRYWMImg1WuX2mskDHNMI8oO5FtGQOYb+Lp+LKjOBnb8s4LCeMuHyvglmaS
         goeJUTnZsx82aljSZsbnBuXgYe+cx0lazKMpLbVjjn0FKBF713EIiNot/pCwiTaYnqX9
         FAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779980003; x=1780584803;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpY3ZijaXiuJOkFKvi2YUN/7pNpdMH0cGhSXkrJHogw=;
        b=AwhHOC/NF6+gHAjbMMUKwjqnDzNh8P7VbEBsd63a9F9zbzmTdOxhCM17HzFYhKVeT7
         Z033hkbiCQZOGASNyyl5eXaIPNjnHJMI7uRffKTQTHm82iIDieLYWDfkqmXULHhwf6n5
         NBBPeYHVYqqA9jUPas1cfuFEOjIE7M7HVWNDjHtjh4u2mM9tLbFwZSlQOIpn8qpRL2JO
         YqVWV6gk53IMo3FxptVPblmaAijJ9Z9Wedh0zKZ/OvIrVk3fIyZMRBzCEKmqLwXYwnRZ
         Rj2fvNcKZ1rhVFV/O7Rx2HUO5M21SKGrToW5xJ0MVp53BVHR9abRnhR23BiZtYvXKZVe
         1m2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+970ahIi8+bTZo1KcETLUdn1nnRbEUPPmLYBidyFLaxqIYwFB3LOSqwObQZECHW+dO1pAKTd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8cxnLwnkwZoji9C8/RL4IGICoAjxJnv3j2BsOYvYF1mqt68G
	Y9urPpMGjrhH7taa+YkY/xyg0XZ3WVvx0XzZpWX6aX52iIDZZTVvBWTaG3RLAwSniDSfUHu9ejg
	tTu/L+DSEyeZ8XHgL2x3gRNcc3wncwRq7Y1LpS/eeMwnazV949SIxcIKWng==
X-Gm-Gg: Acq92OF6Y2mwtccnYnV9JfxK20/ywqLsY70WbpXmZx/C7D97HzoiL8L5NJ0UlczScVF
	7Dtqa4d4b8NKUD4Xm9/xjWdwtKe6c8vpPmiofIOlgbuPReB6FCfUqI94qJhD6R34X5jEs8tqAEM
	vl6PPmZnIcd0YnVFU7/yXejOPpjuKq4a0jVCBqtI+EdZ0vpXiCBDLHnd1IV2G+ThI9MyElC7Y5J
	PKc2U6HW3FAH2iE1i2aMIcj7bsNttv8CGjHK7u5rHk5lN4kZTEA6hp+Coe+Arsl2R62SJrf7tGx
	w8HActCqb4YkSefL1ba7Jn8No1hQ0c+FqWi6mA+GQaVJnqH2spxaUJp9k56snGdqShFv4ZyRXtW
	WZojq28HUWeB/FQlf43I5nPPFvIbFBItPDTVANnnAohg=
X-Received: by 2002:a05:600c:3ba5:b0:490:8b0b:d3b1 with SMTP id 5b1f17b1804b1-490947b0929mr26757645e9.12.1779980003047;
        Thu, 28 May 2026 07:53:23 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba5:b0:490:8b0b:d3b1 with SMTP id 5b1f17b1804b1-490947b0929mr26756975e9.12.1779980002459;
        Thu, 28 May 2026 07:53:22 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490929652c9sm43245675e9.14.2026.05.28.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:53:21 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: =?UTF-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Fernando Fernandez
 Mancera <fmancera@suse.de>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>, Ido Schimmel
 <idosch@idosch.org>, Justin Iurman <justin.iurman@gmail.com>, David Ahern
 <dsahern@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, Linux
 kernel regressions list <regressions@lists.linux.dev>, Beniamino Galvani
 <bgalvani@redhat.com>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260528165320.15b90ded@elisabeth>
In-Reply-To: <CACT4ouf5ZqGgb=RO8_7NovLCvYKLKL4vD70dEe6xUODT1UEcSA@mail.gmail.com>
References: <20260521135310.GC977@cmadams.net>
	<20260526175743.1f2c3761@kernel.org>
	<20260527010641.GA21073@cmadams.net>
	<20260526183122.348e44e7@kernel.org>
	<20260527215135.GB16443@cmadams.net>
	<675083b4-e015-4ff3-836c-798e0a971194@suse.de>
	<20260528073849.759da84a@elisabeth>
	<baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
	<20260528131250.1352ab48@elisabeth>
	<b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
	<bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info>
	<20260528153202.14900687@elisabeth>
	<CACT4ouf5ZqGgb=RO8_7NovLCvYKLKL4vD70dEe6xUODT1UEcSA@mail.gmail.com>
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
Date: Thu, 28 May 2026 16:53:21 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[leemhuis.info,suse.de,kernel.org,vger.kernel.org,redhat.com,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-292736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[passt.top:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 68D455F413C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 16:15:38 +0200
=C3=8D=C3=B1igo Huguet <ihuguet@redhat.com> wrote:

> CCing Beniamino, NetworkManager maintainer.
>=20
> On Thu, May 28, 2026 at 3:32=E2=80=AFPM Stefano Brivio <sbrivio@redhat.co=
m> wrote:
> > Not a bigger regression, but a regression definitely, even just for 'ip
> > address' or 'ip address showdump' which would now go back to display
> > / save addresses in the reversed order for IPv6 (only). =20
>=20
> One could argue that the bug had to be fixed in iproute2 and not in
> the kernel, to avoid breaking UAPI.

I think what's considered UAPI in this case isn't so clear-cut. I guess
it would have been pretty hard for anybody not familiar with
NetworkManager's codebase to imagine that an application would rely on
IPv6 addresses (and only IPv6) to be returned in the reverse order.

Pushing this to the extreme, one could argue for example that if we
accidentally byteswapped the last 16 bits of some IPv6 addresses, and
NetworkManager started to work around that, that would start being
considered established UAPI...

> > Actually, an eventually fixed version of NetworkManager doesn't need to
> > know the behaviour of the kernel: it can just order addresses by
> > timestamps instead, as Fernando mentioned. =20
>=20
> If the fix must be in NetworkManager, we only need to parse them in
> non-reverse order like IPv4, I guess.

But that would then require some form of detection, and, at least
according to Fernando, isn't the most robust option anyway, as ideally
NetworkManager shouldn't rely on the order at all.

> > And I'm not sure how relevant this is, but if we revert the fix,
> > current combinations of NetworkManager / kernel versions would be
> > anyway affected. =20
>=20
> Probably many, for who knows how much time, unless all distros
> backport the NetworkManager patch. Many don't backport much except a
> small bunch of security fixes.
>=20
> > So at this point the only robust / complete fix would be changing
> > NetworkManager to sort addresses as needed. Are you suggesting that we
> > should anyway try to minimise the temporal impact of this with a revert=
? =20
>=20
> I don't think it's the "only" robust fix. Normally one would think
> first about not breaking UAPI.

Sure... I would just argue that in this case it was pretty hard to
imagine that as an established UAPI trait.

> Kernel's UAPI is not great or intuitive
> in many places, but normally it's never improved to avoid breaking
> backward compatibility. Adding a GIVE_ME_THE_RIGHT_ORDER flag could
> help too, but I agree that it sounds a bit silly to have an opt-in
> option to force the right behaviour.
>=20
> Then, the only robust fix would be to fix pasta and iproute2.

I was mentioning that we can't really fix this in pasta (unless, again,
we implement some form of detection, or something on the lines of what
Thorsten suggested) because we're just copying addresses to a container
and we don't know much about them.

We could add detection and swap them, which is rather complicated for
us because we currently don't store them as we copy them (we don't use
dynamic memory allocation), but of course that would be on us to figure
out, somehow.

> Here we know of 2 affected userspace programs, but we don't know if
> more could be discovered in the future.
>=20
> That said, it is true that this case is very unintuitive. Insertion is
> direct-order for both IPv4 and 6. Dump is reversed, but only for IPv6.

Wait... that's how confusing it is. That's also what I thought at the
beginning of https://bugs.passt.top/show_bug.cgi?id=3D175, but it turned
out that insertion is actually reversed for IPv6. Dump isn't.

So this is also inconsistent in the kernel itself: if everything else
is equal, address selection depends on the order of addresses as
inserted, which is the opposite compared to IPv4. Maybe this is the
most surprising fact in all this.

> Userspace programs won't expect this at all. Programs that do it right
> it's probably because they encountered a bug because they were
> initially reading in direct-order, and changed to reverse-order. I
> haven't dug into NetworkManager's history but I bet this was the case.

I guess so too, yes.

> In this case I would be in favor of not reverting the kernel change,
> and fix NetworkManager, but I'd like to hear Beniamino's opinion, as
> I'm not being much involved in NetworkManager any more.

--=20
Stefano


