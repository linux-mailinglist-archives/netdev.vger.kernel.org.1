Return-Path: <netdev+bounces-292663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IxUEhUkGGrkeAgAu9opvQ
	(envelope-from <netdev+bounces-292663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:16:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBD65F1262
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C7AB3035D4E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4313C3C00;
	Thu, 28 May 2026 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fILIPJYg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nvAhNE46"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847038D41E
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966778; cv=none; b=AXfdHctZwoyG71mSXSIeOiIjFGRoxWnam25V2uxTFDbW+crF0TrsOxFm3hAkIPPddkgGBIGhG/ky7t5dv9HnNbrZbl6aZqk2pynUCuY7r2G8mzUKFF2lrHMhLkYOYJgYiLej1VDc5k3MATG2rrtL/s41aCKRMXsVLJVSkUwG9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966778; c=relaxed/simple;
	bh=0a1V/N7E/8NsBwys5c+xRO2ZTJ396PNj/irrGllELPI=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=t3/77ocySgbVL8rw4VuU6OgTXsBkelrSXec1VIgW7d1GoGldmC+L2GWI4OBra0Vpl6py9TOVRE0cAOwYHPD8qSzlUuQNwWfAUviAuESqSHN3T68MOBhU9kdGHcPqEfs4e6lTAbKkHGkrdRsa+Bq7rkLGNmUnioeca/40gZtdq+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fILIPJYg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nvAhNE46; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779966776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdki11Mg5/sH2qgsMlQeXUJCBva0iy7+rkwX1SiR5Kk=;
	b=fILIPJYgIFxqNMCdBSLliGHGQMDP/IghWmjJ0vjTawUi22aqSaCH5Wc9dLX6ik37hMCI+m
	TxXnFpZyWG2A2Gt3zcrfEvq97O+xbEElBXRKL9BcX2MFhTOjHnOsg5HFCMfjs3uCP6Nyq6
	9IOmQgn//x+ARChtt7oEIiUMezp9YDw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-rveci7DVNQ-o26oPj1wRuw-1; Thu, 28 May 2026 07:12:54 -0400
X-MC-Unique: rveci7DVNQ-o26oPj1wRuw-1
X-Mimecast-MFC-AGG-ID: rveci7DVNQ-o26oPj1wRuw_1779966773
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49048e21ea7so31962375e9.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 04:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779966773; x=1780571573; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdki11Mg5/sH2qgsMlQeXUJCBva0iy7+rkwX1SiR5Kk=;
        b=nvAhNE46j57IGXzNlXkx4yAGTO3y9OUuErnOzMz5Uswkrxm1ESoLz18sVoqAn2o83z
         eg6Kt1H7kSZSxb20eHVO/Nhk5DrE1H31UYBAimcxv3WF0e9D585Caxlphgf6OPy5Lorp
         dNXIPTCUWAzHh1p0WbMvGUOU1Kk9UOo+lVI2bghUHT4D1h5+1dnRcKpst8zN9L4UBhJ9
         IQ6zZXIsI9Gom7H8wHO8ij5LiCkpzDNnp97yBXAUVH3AjJ2GgXlGLkiDWgsP7xdXuTC+
         SkU8hiRTZC6Spgt3KPnIREekCiPHHLy7Ntxt7fREipjXk+dHoA0ingmsJUk+9xZOaSXw
         6bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779966773; x=1780571573;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdki11Mg5/sH2qgsMlQeXUJCBva0iy7+rkwX1SiR5Kk=;
        b=WXqtDHA7v1ZJtQY7B8V4AtGUo0oRYPaA3ernTBgnz1Oy/kf9ULrdacuoUcK9g1lGyp
         fPM3ou/B9UJH3tFqJiZN3BPwUxJIpPrPQhvW7Z51qbZ71yYnbJ9N+AIlE3m+P4lBacj7
         PhckyUn6p2VVxZcMXlR8MvYLLG40vH9p0kvPoEyTcrca+dJw1tTgxtadt+L0ei0sGzci
         /FmpGCrNlUHh7PuBr+U0O3eB8B/x6sncCghJx2A2zS8yNvdREzgvN3eczStLz3KETlMH
         QAHzEdFZn0WaQSCBxYeiRrpQ49bIVi16rXEwT4kPn168eI6TIcJCIR3Mk75142U/CyZr
         mENg==
X-Forwarded-Encrypted: i=1; AFNElJ9fZTerWattx3RBNKiZo1BY02QOxrYBOSwaPKoe/wipUXMv2Ag0IajtuT0n4S+noMh8wJ8/D8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw87GfE0w0h+AVGDnH+V81r/YOzlyVuA/JmgvXz9R2CbEDepP/b
	RBZ4rSqRFjDbqOL3AGWD2mktxOKYhIAw+Jlm6OwLOkoWrhJ60AVLK/J+FKtwZ3+2zijNY+cjS/Q
	zBlyXWGic50KuBeIBQ8n6AhkLonq5N/Nmbz7tfp6ZkHo6ojOGhrutAHbZ9A==
X-Gm-Gg: Acq92OFxlDgIqgbjr+1fTHW82IIdSqrTlQ9fhzqROeKDEkTqaJou3p44htDMYv1aVaW
	dDBLiyiV2OzwybLldXkijYV5EsOJESnlSGsUfdLl0E/4diF0/ICgQ30nmJmoyi9qrMEZ8li6wE8
	kg9AMDUFJhCRY3BPSk/2zUiaiJBQ3bJwlyWDy1K/Fx01QNWIXvPIg5ttqoS2Bl8UWNINikZvMRZ
	x49U+OKiuPWNwGZGCiQZJ8vqztfYHnwcLMaLQ6t4T+b4flaAyHTbmhSZ7GKZEVlNarMLd3obOyz
	recMB5xuqhF8aJzKWog8Z8n9mWdjrR6OSuhmbh+Tdo6/tFb3nwn8Qu8NlclCrDhPHTAIrn+ZF1A
	wyDt5sNgj1TNbEo2XsxHG5nuj8u9sSuF7ZtXxzZVtiT1l6kpVimYDtid1tBg2
X-Received: by 2002:a05:600c:3549:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-490947b4beemr16831155e9.13.1779966773300;
        Thu, 28 May 2026 04:12:53 -0700 (PDT)
X-Received: by 2002:a05:600c:3549:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-490947b4beemr16830545e9.13.1779966772634;
        Thu, 28 May 2026 04:12:52 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a925acsm60987145e9.14.2026.05.28.04.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:12:52 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Yumei Huang
 <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, Justin Iurman
 <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>, David Gibson
 <david@gibson.dropbear.id.au>, ihuguet@redhat.com
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260528131250.1352ab48@elisabeth>
In-Reply-To: <baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
References: <20260521135310.GC977@cmadams.net>
	<20260526175743.1f2c3761@kernel.org>
	<20260527010641.GA21073@cmadams.net>
	<20260526183122.348e44e7@kernel.org>
	<20260527215135.GB16443@cmadams.net>
	<675083b4-e015-4ff3-836c-798e0a971194@suse.de>
	<20260528073849.759da84a@elisabeth>
	<baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
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
Date: Thu, 28 May 2026 13:12:51 +0200 (CEST)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-292663-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,idosch.org,gmail.com,gibson.dropbear.id.au];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,passt.top:url]
X-Rspamd-Queue-Id: ACBD65F1262
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 12:46:05 +0200
Fernando Fernandez Mancera <fmancera@suse.de> wrote:

> On 5/28/26 7:38 AM, Stefano Brivio wrote:
> > Hi Fernando, Jakub,
> >=20
> > On Wed, 27 May 2026 23:59:47 +0200
> > Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> >  =20
> >> On 5/27/26 11:51 PM, Chris Adams wrote: =20
> >>> Once upon a time, Jakub Kicinski <kuba@kernel.org> said: =20
> >>>> On Tue, 26 May 2026 20:06:41 -0500 Chris Adams wrote: =20
> >>>>>> Hi! Adding more people to CC. Do you know if you upgraded from 6.18
> >>>>>> or 6.19? =20
> >>>>>
> >>>>> It was 6.19 to 7.0.
> >>>>>    =20
> >>>>>> Would you be able to try testing with some commits reverted?
> >>>>>> On a quick look the candidates would be:
> >>>>>>
> >>>>>> cb3de96eea66 ("ipv6: preserve insertion order for same-scope addre=
sses") =20
> >>>>>
> >>>>> It's this one. =20
> >>>>
> >>>> Phew, the second one was mine :)
> >>>>    =20
> >>>>> I figured out that it happens after stopping a VM (and I usually
> >>>>> start/stop a VM for a bit in the morning, which is why it happened =
more
> >>>>> than once).  So I set up a VM with a nested VM, running up-to-date
> >>>>> Fedora 44, and then was able to bisect pretty easily, and it landed=
 on
> >>>>> this commit.
> >>>>>
> >>>>> Fedora is using NetworkManager, and IIRC NM does some part of priva=
cy
> >>>>> address management (right?).  NM didn't change, so maybe this commi=
t is
> >>>>> confusing something in NM? =20
> >>>>
> >>>> Sounds plausible, pretty sure we knew this commit was risky to begin
> >>>> with, but we had no direct proof that it'd break real life users.
> >>>>
> >>>> Revert is the right course of action here. Would you be willing/able
> >>>> to send the revert with your problem description and a Fixes tag
> >>>> pointing to the reverted commit? =20
> >>>
> >>> I did want to add a little more test note:
> >>>
> >>> It's definitely an interaction with NetworkManager.  If I stop NM and
> >>> run my VM start/stop test, nothing unexpected happens after.  If NM is
> >>> running and I do my VM test, when the next router advertisement is
> >>> received, NM replaces the privacy addresses.
> >>>     =20
> >>
> >> As someone that is experienced in NetworkManager, I can confirm it is
> >> related. NetworkManager is querying the IPv6 address and when the
> >> connection is configured with ipv6.ip6-privacy=3D2 (prefer-temp-addr),
> >> NetworkManager creates a route to make the system use the temporary
> >> address for outgoing connections by default.
> >>
> >> If the order is messed up, the address picked will likely be too. One
> >> could argue that this is partially fault of NetworkManager and that it
> >> should check the timestamps or preferred times rather than order.. but
> >> well, the rule is "do not break userspace".
> >>
> >> I hope this clarifies things. =20
> >=20
> > Not entirely. I'm looking into this right now, but note that the purpose
> > of that commit is to *preserve* the order of addresses as they were
> > inserted, not to mess it up.
> >=20
> > Before that, addresses were stored and returned via netlink *reversed*
> > compared to the insertion, which is rather surprising, also because
> > it's the opposite of what we do for IPv4 addresses, and caused issues
> > with pasta(1) as it copies addresses into containers in the same order
> > as reported via netlink.
>=20
> Right, to make it clear. I agree with you here. The current order is the=
=20
> *right* or rather intuitive order.
>=20
> > Do you happen to know exactly in which way the order happens to be wrong
> > now?
>=20
> It is not wrong, but userspace applications were parsing addresses and=20
> expecting them in the previous order whether it was correct or not. Now,=
=20
> that parsing is broken because they are coming in an unexpected (maybe=20
> more intuitive) order.

Ouch, I see.

Two questions:

- could there be other issues coming from the fact that NetworkManager
  relies on a particular order (whether right or wrong) of addresses? If
  yes, I guess NetworkManager would benefit from a fix in any case
  (that is, we broke it a bit harder, but maybe it was already broken?)

- regardless of this, would there be a way to make NetworkManager
  robust to the order?

  I'm asking this because yes, strictly speaking, you might say this
  change breaks userspace (NetworkManager), but at the same time it
  fixes another part of it (pasta), and changing it back would break
  pasta again (in a way we can't really fix).

  Now, I suppose NetworkManager is much more universally used and it's
  definitely a more mature project so it's a bigger userspace breakage,
  but at the same time it's a ton of containers (Podman uses pasta by
  default, Docker/moby optionally via rootlesskit) we might introduce a
  regression for.

So I'm wondering if in practice it wouldn't be better to fix
NetworkManager instead.

> FWIW; I=C3=B1igo Huguet (CC'ed) pointed out that this is breaking a=20
> NetworkManager test and they were going to report it.
>=20
> > Also note that userspace was broken and fixed a couple of times:
> >=20
> >    https://bugs.passt.top/show_bug.cgi?id=3D175#c10
> >=20
> > so I would look into fixing that properly if doable. If it takes too
> > long and this is causing issues for a lot of people meanwhile of course
> > it might make sense to revert, but I'd give it a quick try at least.
>=20
> I think the solution shouldn't modify the order of the list by default.=20
> Maybe we can introduce a flag for the dump operation?

I'm a bit struggling with the name and how complicated a description
would be. NLM_F_RIGHT_ORDER? I guess you're suggesting to get the
"wrong" / reversed order by default... even though it's the opposite
compared to IPv4? Or NLM_F_REVERSED, otherwise? Is it really worth it?

--=20
Stefano


