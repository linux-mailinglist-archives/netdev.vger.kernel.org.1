Return-Path: <netdev+bounces-281495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOTODsvQ72nZGQEAu9opvQ
	(envelope-from <netdev+bounces-281495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:10:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8EB47A8A4
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C1B2300C034
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50ED3AA4E2;
	Mon, 27 Apr 2026 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUaLBK3p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0E0373BE9
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324232; cv=none; b=Re7jEGE9LvtpnBAv1PqKhhcJgGqVzkZX2mCAYe7eQCCDic6Uh/uTL8RRKj9xJWz42FqyxHX0555Idd8JQfsbcriwQ0mw859Z9UvSf+TdHR3m3OxVq5D0H3UlVOLccYNLawgJHpdfQQQEV0sK945Hd/obLDgrJLRqBdCZ2C/RbmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324232; c=relaxed/simple;
	bh=6V7qpbT9KK3t7mjymxtpEtYD0IPtR7A81/0E8rhjWrs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Suf6LpcJULXnWja/RujSZSVPt3zlVhyNKJfMcH4ZcJM0xwjUsCeNwzq1wC1TpQ5oV1S91p8S0FrMLQ+oy4x6eSxMdG4TX+sVmdav2A1vhdEINfm/D2nNyIYYi7CRQ2M4g9MeqT6xKmqwOJg19wJ0sThGX3Efd7ut64ycfl01lWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUaLBK3p; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-470145d7df5so6672679b6e.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777324230; x=1777929030; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BaEPVkmROpBqycA8DfO+wu+NP8Nw7wKc5E3/zQRUZpM=;
        b=KUaLBK3pWXxxZcbkMRW5BbcJjUWi2y6o7d8Pm30wU003VDTJtrBLWdfYukBUKBujm+
         oCHKc2lUjv0k5hG+xvswpzCfD82BhWs5nI0/WSsWVYtGOGabD/tzQ/W5tyQmpcygKL1s
         3KUadNCEVqKfwsYmR87GTzWrQEuNCj0MRq+znBs8+r0x2xc2Fw+uAk29DLWq6YvXiPzC
         nYUZj8dUf6PW7lJWyay3J5NGpJilwLt20sUh01j6HOtgWLq0Gp+zKhzUgFE0DtJuFfTe
         n80JLLzdsjXlDPNBRieRbZPZhW4mbTioo9XIrVGqwkhd5yxx4Qak4zFr4nOrkz8x1E1c
         kTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777324230; x=1777929030;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BaEPVkmROpBqycA8DfO+wu+NP8Nw7wKc5E3/zQRUZpM=;
        b=kpdkms6nZPPL3zifWnw7qiqG93yrm/4gCFcXhzxy3tfoKQiyIJcAISvK0TIQU+ataX
         /EdGz+6GQsvbwZFd26k9Hyn6PylaIbFnR25hS40CbTAsDH85EObmKnsYQ2uNM/n7mVyA
         Kgn1gJmCu3meDuAsY2Lf3LB9NTeZk68ZorTwPylaROzN8tDW/xmDWZG7xVu/ItCycYQb
         k9/+eFQbsnusMfADbDyfYNJa3f6MERj38aEj69wa5U42OclhS5eqcJdgKAC8E/NfYns+
         dl3C+emGIy0aBfhsq7VNiDHS840iADT4RMjQw6flhOCYHI6gVvJtnpoWP+6KXX7sQK3x
         b/jQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RS0MXFvyabcd1RISKiZHmDVKYASX81jtESJQNTTTgj4W0Ktzy0TVHB4OLwt37j1f8D+6dmrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAPlbu6UWIdCP6RDH6ajdtKJfcYg3iYLIvSuoKXuSns++u9qnM
	HaJItix0U42QQ9vJ82prEeU27hfJKg3BVghJ9GYYTC/pfRRLDtWMZArc
X-Gm-Gg: AeBDietrXY++0OoFGum5aioEGEYOMQeyhuVdbBMHGaDzuliAg0b18Ho4dTyB957aauK
	WYPAiItq/iXQvsEl+za2UBOVhAXpDeD4d9o9JqBnjOYNRyQPxfXDxZZg0c8nZH2rC0vcx8UV/J+
	UHoSGFae00r+sxPsyUczWDPtE74vIVIX8PQ0IFJmaFUBSqUsv/IBSnUWMUDY4b7DznuHRhmMjeE
	1m68XLlv16Xi7Qawi9uhwGuTvBcxjQv7fns11njJ8aTHfVxYEKE8NTYWzXIn3J1x6eSzvPyskop
	uy4FEiRbKIHgMjyhzpYWVFA/7cbG+r+1SgJ7G2IRAGa1Z/jVx/su2gdOLzLdHsKqFfyNP5CWh5p
	LYIZb6uEcfzgXgXqR5i9dDoGe9wEJvjUDmTn0951oOx6JxsP5c9qiV4JQ2ShETkAs4bKPRJ8KPC
	ZoGjoyG2CxjkuCqM9i+sLj3ajLNB9BUXapGjL4c52SxVzEDA40fLGhfS/lbT8N6zdmU3MMElejW
	TxUAAodl9R1u0ITE2mg
X-Received: by 2002:a05:6808:3442:b0:479:f58a:c5d5 with SMTP id 5614622812f47-47c2906fc81mr222293b6e.45.1777324230175;
        Mon, 27 Apr 2026 14:10:30 -0700 (PDT)
Received: from [192.168.2.35] (1750310-static.rochmnaa.metronetinc.net. [152.117.88.197])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c28f8e53fsm182990b6e.8.2026.04.27.14.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:10:29 -0700 (PDT)
Message-ID: <5d5524e8077bc3f169ab5ce6ea267d344efd3336.camel@gmail.com>
Subject: Re: [BUG] mlx5: VLAN-aware bridge drops all traffic in legacy
 eswitch mode without promiscuous
From: bryan <bpliscott@gmail.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com
Date: Mon, 27 Apr 2026 16:10:28 -0500
In-Reply-To: <1126aa35-1924-492f-8d7f-072c0dec9bde@nvidia.com>
References: <96b4d723ac443f3a42680fa1c8b94b929df39da3.camel@gmail.com>
	 <1126aa35-1924-492f-8d7f-072c0dec9bde@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: CD8EB47A8A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281495-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bpliscott@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:url,proxmox.com:url]

Here would be one example config (sanitized). The promisc on link is
what allows traffic to pass - I disable promisc, and traffic stops.
These are single-port CX4Lx cards. nic0 is the physical interface, no
VFs configured, SrIOV has been disabled as part of testing and
troubleshooting, Kernel 6.17 currently:

auto lo
iface lo inet loopback

auto nic0
iface nic0 inet manual
        up ip link set nic0 promisc on
auto vmbr0
iface vmbr0 inet manual
        bridge-ports nic0
        bridge-stp off
        bridge-fd 0
        bridge-vlan-aware yes
        bridge-vids 2-10 555

auto vmbr0.555
iface vmbr0.555 inet static
        address 192.168.1.123/24
        gateway 192.168.1.1


iface nic3 inet manual

iface nic1 inet manual

iface nic2 inet manual


This was ported over to use the new nic# bindings, before this it was
the standard enps0np0 naming. No difference in behvaiour.=20


>Is this even with one vlan? I ran a flow on a CX4LX pair with one vlan
>and vlan_filtering set and traffic seems to be flowing normally.

I have not checked with literally only one VLAN, as that is not at all
the use case. I can absolutely test that if it would help! Would you
like me to remove every VLAN but 555 from the interface, and leave the
rest of the config as-is?=20



>This last link seems the only one that provides some extra data. From
it I can see that the amount of VLAN ids > what the FW supports. This
could result in loss of traffic for the vlan ids > 512. Do you also see
in your dmesg these kinds of errors:

>mlx5_core 0000:19:00.1: mlx5e_vport_context_update_vlans:179:(pid
13470): netdev vlans list size (4080) > (512) max vport list size, some
vlans will be dropped

>This is not a bug, simply a limit being reached.

Considering I am only operating with 10 VLANs, as can be seen in my
config, I do not think that is my issue. I am aware that there is also
quite a bit of noise in these threads - they are just forum posts - But
that does not appear to me to be related to my issue, or the issue of
others here. I get no such messages or warnings. Additionally reports
about that bug were about some some VLANs being dropped. In my case
(and as others have reported) all VLANs are being dropped.=20

>eth2 is a PF in legacy switchdev mode.

It was my understanding that Legacy mode and Switchdev mode were two
independent modes, with Legacy done in-software and Switchdev using the
eSwitch on the NIC itself. Please excuse my ignorance if that is not
the case. Would you be able to specify if you used Switchdev mode or
Legacy mode? because Switchdev mode DOES function as a workaround and
passes traffic (but in my case results in system instability after a
time).=20

Thank You,
Bryan



On Mon, 2026-04-27 at 15:55 +0200, Dragos Tatulea wrote:
> Hi,
>=20
> On 24.04.26 13:07, bryan wrote:
> > Good day,
> >=20
> > I wanted to check whether there is an open bug report or known fix
> > in
> > progress for an issue that has been affecting mlx5 users
> > (specifically
> > ConnectX-4 Lx, but likely broader from what I have seen other
> > reporting) since at least 2021:
> >=20
> > When an mlx5 interface is added as a port to a VLAN-aware Linux
> > bridge
> > (bridge-vlan-aware yes / vlan_filtering 1) in legacy eswitch mode,
> > all
> > traffic stops passing through the bridge. Both tagged and untagged
> > traffic is affected. The same configuration works correctly with
> > non-
> > mlx5 NICs (tested Intel, Chelsio cards).
> >=20
> Is this even with one vlan? I ran a flow on a CX4LX pair with one
> vlan
> and vlan_filtering set and traffic seems to be flowing normally.
> Something like:
>=20
> # IFACE=3Deth2
> # VID=3D100
> # ip link add br0 type bridge vlan_filtering 1
> # ip link set "$IFACE" master br0
> # bridge vlan add vid "$VID" dev "$IFACE"
> # bridge vlan add vid "$VID" dev br0 self
> # ip link add link br0 name "br0.$VID" type vlan id "$VID"
> # ip addr add 10.0.0.1/24 dev br0
> # ip addr add "10.0.$VID.1/24" dev "br0.$VID"
> # ip link set "$IFACE" up
> # ip link set br0 up
> # ip link set "br0.$VID" up
>=20
> From the other side where I have a similar setup I can ping
> br0.100.
>=20
> Tested on a CX4LX with FW version 28.48.1000 and kernel 6.18.
> eth2 is a PF in legacy switchdev mode.
>=20
> > [...]
> > This is well documented in community forums but does not appear to
> > have
> > been formally reported to netdev that I have been able to find. My
> > apologies in advance if this has been reported and I wasn't able to
> > locate it. Here are a couple of forum examples where this is
> > discussed
> > among other affected users:
> >=20
> > - NVIDIA Developer Forum (opened 2021, unresolved):
> >=20
> > https://forums.developer.nvidia.com/t/vlan-aware-linux-bridging-is-not-=
functional-on-connectx4lx-card-unless-manually-put-in-promiscuous-mode/2060=
83
> >=20
> > - Proxmox Forum thread (2023, ongoing):
> >=20
> > https://forum.proxmox.com/threads/mellanox-connectx-4-lx-and-brigde-vla=
n-aware-on-proxmox-8-0-1.130902/
> >=20
> > - Community writeup with analysis:
> > =C2=A0 https://www.apalrd.net/posts/2023/tip_mellanox/
> >=20
> This last link seems the only one that provides some extra data. From
> it
> I can see that the amount of VLAN ids > what the FW supports. This
> could
> result in loss of traffic for the vlan ids > 512. Do you also see in
> your dmesg these kinds of errors:
>=20
> mlx5_core 0000:19:00.1: mlx5e_vport_context_update_vlans:179:(pid
> 13470): netdev vlans list size (4080) > (512) max vport list size,
> some vlans will be dropped
>=20
> This is not a bug, simply a limit being reached.
>=20
> > Has anyone bisected this or is there a fix already in progress that
> > I
> > did not find? This affects a fairly common hypervisor configuration
> > (VLAN-aware bridge for VM networking) and the workarounds are not
> > conducive to production use.
> >=20
> Could you provide a short repro script for this. Not being able to
> reproduce the issue makes it hard to check :).
>=20
> Thanks,
> Dragos

