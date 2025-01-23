Return-Path: <netdev+bounces-160450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF79A19C99
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 02:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318C03A1301
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 01:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB641448C7;
	Thu, 23 Jan 2025 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="nTAgnPCe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1E712C475
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596945; cv=none; b=OMKl5kYfC2l48L7zjPsNdK7NSsTrm/Lj/CQegqT5ZDZ/tQZQkP77D8+Et26spPOQPMp/RxINrMtQfskHct7zrmaUmy37gLPauj5IGrTyI1V/Lyt1zZYlArgUYslTgmrAwE7dTGk1PpAFCWnD9iJ1z0Fms7AZK47x8mK5BK+mxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596945; c=relaxed/simple;
	bh=FOqwu3J9BbRjsf0nBXvmXdS3UjDCW16gIMoobpmqra4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZgCZXUuhjc7kz5wVRkkKliUksHJKq/VOS/p/IaEmSnPzytPJbaZ4dqOX60GU98F4z/iWdGph3wp2fftrgnBb2mNvvwVT2IVoIH+PCbOe8WmhUKYmaXWUFxv5a9VANEFN9Y5dTzTLSA72e+BZgtUXVB9qK1vUfzf7YsZqdny8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=nTAgnPCe; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5773c5901aso2579198276.1
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 17:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1737596942; x=1738201742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTMvzOx+g7P2AI2OsH8o2q7wN6OHLNKMeH37KLEmM3Y=;
        b=nTAgnPCe/f0Jm2Ld29vvz7TFFwenUuyg0sVBxXcOiRR3Fz1RpNlb4ddaQzlsUkW/2I
         iPce8YaCDh5wOn57k931BgePn1qITedxAL5mhMfALvWwMMcuur2rRKKL8v/yqK/JQzan
         nfjXMfozl+mrU0meUdKFP9cqdpAm6BcmguFX4xlVnl8ofKwxmSghW90zUeprH5vm3Z55
         RRt9hNEQkF9V1TWnE198MV9GSNWFTRg/VBhro164l5YuEq9zrCVBhRKfUS2ChVgC/wVb
         cTCn0+sg8IG2JAS1CQMzcSlw9Vm28TWccNX83hLMSAJThMYnl4Dzkn0zqfr1tBrXXFid
         0k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737596942; x=1738201742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTMvzOx+g7P2AI2OsH8o2q7wN6OHLNKMeH37KLEmM3Y=;
        b=RiRz8oh+mXw9FJMHGf6/WxlIx5iakBGlqKynBpzov8nyCqEetuPE3ptA6d6y1ybh+l
         drt3EqG5pkBbthkbI7ulXgY7fhAoLtflGAM1Ec8cVr4JCnjSlj6a3tqHRy5XtbTI+2sk
         0aWOIqYm8BqadNZb2KLVo6UA98Xd1nVgBqKnCiFzxEw78/ADqSZSCdjEXhdtl/pd3iB0
         5daUFAcWFUyPs04rXDj6PgcBxyNpz/XC2NeehL+JHn2HRObFJGMhwGKJTipJ/CrlGQD8
         migZ6HCcDwVIto1+rtalJHju+osF9cnAb7CNtOPUHYXG1JsW2c6GaSN6kuCyBIAUrTOO
         Xjew==
X-Forwarded-Encrypted: i=1; AJvYcCWawzILiZ/kk9ZOeh/r5ZDWx8Te1NOyMWtn6cHG04RZUvZDtvmMuHedwI7DiwMNfkfuJC9lLUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUv1EH3agkeqYnAg3beYFn2px4CZ3sqDi7uG6PJcR28cDWckV
	D59sGeNxtS+qkozuf0WjMOwx1npYfILq97Ch12A7h62/Xr9H51M+VJ2idx51LfZP01+Xi26r5m2
	xsonfXPZNo3m+lwJvw346amAS5d5OfGUnAR3SCA==
X-Gm-Gg: ASbGncug3ZxhdLknUlCD39Xga6atQutl44nEAzd9RZhFxrGsNSNVNykkPP6LHfBBMzM
	pCml9PMVvEBnk00Mqjri5RwmX4ZyNu7yH7ZntBJ6MJcpKULu/DGxbsn5MHzaDpA==
X-Google-Smtp-Source: AGHT+IHOYhWzxti8i4RF6hbwCHfC8S0G/qw5EJBbURgLn4VvyYDwjV44QBn6Ig+xCrj3DcH5LzKEM7Rp6ydSROX6R7o=
X-Received: by 2002:a05:690c:c1b:b0:6ee:7916:2fa3 with SMTP id
 00721157ae682-6f748c7d39amr13563377b3.2.1737596942410; Wed, 22 Jan 2025
 17:49:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213011405.ogogu5rvbjimuqji@skbuf> <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
 <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
 <CAJ+vNU3sAhtSkTjuj2ZMfa02Qk1rh1-z=1unEabrB8UOdx8nFA@mail.gmail.com>
 <55858a5677f187e5847e7941d62f6f186f5d121c.camel@microchip.com>
 <DM3PR11MB8736EAC16094D3BFF6CE1B30EC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <CAJ+vNU2BZ2oMy2Gj7xwwsO8EQJcCq9GP-BkaMjEpLUkkmBQVeg@mail.gmail.com>
 <20250117161334.ail2fyjuq75ef5to@skbuf> <CAJ+vNU2RT2MmyO_YgoQmkb0UdWWKS42_fb1jqYLPmLJf5XNO=A@mail.gmail.com>
 <20250118011803.xqlvdzizpwnytii3@skbuf>
In-Reply-To: <20250118011803.xqlvdzizpwnytii3@skbuf>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 22 Jan 2025 17:48:51 -0800
X-Gm-Features: AWEUYZmemhVk-FUnuqgjgX5q1-HdinSVvoSI-vpf2nyjX3b1VmG4_npYlzlMRdI
Message-ID: <CAJ+vNU1R7zCsEGoM2LP5XDaTseLxiTaa+jD1STcW9ZNgaO16Sw@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com, Arun.Ramadoss@microchip.com, andrew@lunn.ch, 
	davem@davemloft.net, Woojung.Huh@microchip.com, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, edumazet@google.com, 
	UNGLinuxDriver@microchip.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 5:18=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Fri, Jan 17, 2025 at 01:02:31PM -0800, Tim Harvey wrote:
> > The flaw with that patch is that enabling the multicast address table
> > invokes other default rules in the table that need to be re-configured
> > for the cpu port but the patch only configures group 0
> > (01-80-C2-00-00-00). It fails to configure group 6 (01-80-C2-00-00-08)
> > which is also used for STP so I would argue that it doesn't even do
> > what the commit log says it does. It also has the side effect of
> > disabling forwarding of other groups that were previously forwarded:
> > - group 1 01-80-C2-00-00-01 (MAC Control Frame) (previously were
> > forwarded, now are dropped)
> > - group 2 01-80-C2-00-00-03 (802.1X access control) (previously were
> > forwarded, now are forwarded to the highest port which may not be the
> > cpu port)
> > - group 4 01-80-C2-00-00-20 (GMRP) (previously were forwarded, now
> > forwarded to all except the highest port number which may not be the
> > cpu port)
> > - group 5 01-80-C2-00-00-21 (GVRP) (previously were forwarded, now
> > forwarded to all except the highest port number which may not be the
> > cpu port)
> > - group 6 01-80-C2-00-00-02, 01-80-C2-00-00-04 - 01-80-C2-00-00-0F
> > (previously were forwarded, now are forwarded to the highest port
> > which may not be the cpu port)
> > - group 7 01-80-C2-00-00-11 - 01-80-C2-00-00-1F, 01-80-C2-00-00-22 -
> > 01-80-C2-00-00-2F (previously were forwarded, now forwarded to all
> > except the highest port number which may not be the cpu port)
>
> > To fix this, I propose adding a function to configure each of the
> > above groups (which are hardware filtering functions of the switch)
> > with proper port masks but I need to know from the DSA experts what is
> > desired for the port mask of those groups. The multicast address table
> > can only invoke rules based on those groups of addresses so if that is
> > not flexible enough then the multicast address table should instead be
> > disabled.
>
> The recommendation from the DSA maintainers will be to follow what the
> software bridge data path does, which just means testing and seeing how
> each group reacts to the known inputs which might affect it, i.e.:
>
> - is it a group of the form 01-80-c2-00-00-0X? if yes, group_fwd_mask
>   should dictate how it is forwarded by software. All that hardware
>   needs to take care of is to send it just to the CPU.
>
> - is multicast flooding enabled on the egress port?
>
> - is there an MDB entry towards the egress port? how about another port?
>   The groups outside the 01-80-c2-00-00-0X range should be treated as
>   regular multicast, i.e. group_fwd_mask doesn't matter, and mdb/flooding
>   does.
>
> One easy way out, if synchronizing the hardware port masks with the
> software state turns out too hard, is to configure the switch to send
> all these groups just to the CPU, and make sure skb->offload_fwd_mark is
> unset for packets belonging to these groups (don't call
> dsa_default_offload_fwd_mark() from the tagger). The software takes this
> as a cue that it should forward them where the hardware didn't reach.
>
> Also, never exclude the CPU port from the destination port mask, unless
> you really, really know what you're doing. The software bridge might
> need to forward to another foreign (non-switch) bridge port which is an
> Intel e1000 card, or a Wi-Fi AP, or a tunnel, and by cutting out the CPU
> from the flood path, you're taking that possibility away from it.
>
> Here's a script to get you started with testing.
>
> #!/bin/bash
>
> ARP=3D" \
> ff:ff:ff:ff:ff:ff 00:00:de:ad:be:ef 08 06 00 01 \
> 08 00 06 04 00 01 e0 07 1b 81 13 40 c0 a8 01 ad \
> 00 00 00 00 00 00 c0 a8 01 ea"
> groups=3D( \
>         01:80:C2:00:00:00 \
>         01:80:C2:00:00:08 \
>         01:80:C2:00:00:01 \
>         01:80:C2:00:00:03 \
>         01:80:C2:00:00:20 \
>         01:80:C2:00:00:21 \
>         01:80:C2:00:00:02 \
>         01:80:C2:00:00:04 \
>         01:80:C2:00:00:0F \
>         01:80:C2:00:00:11 \
>         01:80:C2:00:00:1F \
>         01:80:C2:00:00:22 \
>         01:80:C2:00:00:2F \
> )
> pkt_count=3D1000
>
> mac_get()
> {
>         local if_name=3D$1
>
>         ip -j link show dev $if_name | jq -r '.[]["address"]'
> }
>
> get_rx_stats()
> {
>         local if_name=3D$1
>
>         ip -j -s link show $if_name | jq '.[].stats64.rx.packets'
> }
>
> last_nibble()
> {
>         local macaddr=3D$1
>
>         echo "0x${macaddr:0-1}"
> }
>
> send_raw()
> {
>         local if_name=3D$1; shift
>         local group=3D$1; shift
>         local pkt=3D"$1"; shift
>         local smac=3D$(mac_get $if_name)
>
>         pkt=3D"${pkt/ff:ff:ff:ff:ff:ff/$group}"
>         pkt=3D"${pkt/00:00:de:ad:be:ef/$smac}"
>
>         mausezahn -c $pkt_count -q $if_name "$pkt"
> }
>
> run_test()
> {
>         before=3D$(get_rx_stats veth4)
>         send_raw veth0 $group "$ARP"
>         after=3D$(get_rx_stats veth4)
>         delta=3D$((after - before))
>
>         [ $delta -ge $pkt_count ] && echo "forwarded" || echo "not forwar=
ded"
> }
>
> #          br0
> #        /  |  \
> #       /   |   \
> #      /    |    \
> #     /     |     \
> #  veth1  veth3  veth5
> #    |      |      |
> #  veth0  veth2  veth4
> ip link add veth0 type veth peer name veth1
> ip link add veth2 type veth peer name veth3
> ip link add veth4 type veth peer name veth5
> ip link add br0 type bridge && ip link set br0 up
> ip link set veth1 master br0 && ip link set veth1 up
> ip link set veth3 master br0 && ip link set veth3 up
> ip link set veth5 master br0 && ip link set veth5 up
> ip link set veth0 up && ip link set veth2 up && ip link set veth4 up
>
> for group in "${groups[@]}"; do
>         ip link set veth5 type bridge_slave mcast_flood on
>         with_flooding=3D$(run_test $group)
>
>         ip link set veth5 type bridge_slave mcast_flood off
>         without_flooding=3D$(run_test $group)
>
>         bridge mdb add dev br0 port veth5 grp $group permanent
>         with_mdb_and_no_flooding=3D$(run_test $group)
>         bridge mdb del dev br0 port veth5 grp $group permanent # restore
>
>         ip link set veth5 type bridge_slave mcast_flood on # restore
>
>         bridge mdb add dev br0 port veth3 grp $group permanent
>         with_mdb_on_another_port=3D$(run_test $group)
>         bridge mdb del dev br0 port veth3 grp $group permanent # restore
>
>         ip link set br0 type bridge group_fwd_mask $((1 << $(last_nibble =
$group))) 2>/dev/null
>         if [ $? =3D 0 ]; then
>                 with_group_fwd_mask=3D$(run_test $group)
>                 ip link set br0 type bridge group_fwd_mask 0 # restore
>         else
>                 with_group_fwd_mask=3D"can't test"
>         fi
>
>         printf "Group %s: %s with flooding, %s without flooding, %s with =
mdb and no flooding, %s with mdb on another port and flooding, %s with grou=
p_fwd_mask\n" \
>                 "$group" \
>                 "$with_flooding" \
>                 "$without_flooding" \
>                 "$with_mdb_and_no_flooding" \
>                 "$with_mdb_on_another_port" \
>                 "$with_group_fwd_mask" \
>
> done
>
> ip link del veth0
> ip link del veth2
> ip link del veth4
> ip link del br0

Hi Vladimir,

Here is the output of your script with Linux 6.13:
Group 01:80:C2:00:00:00: forwarded with flooding, not forwarded
without flooding, forwarded with mdb and no flooding, not forwarded
with mdb on another port and flooding, can't test with group_fwd_mask
Group 01:80:C2:00:00:08: not forwarded with flooding, not forwarded
without flooding, not forwarded with mdb and no flooding, not
forwarded with mdb on another port and flooding, forwarded with
group_fwd_mask
Group 01:80:C2:00:00:01: not forwarded with flooding, not forwarded
without flooding, not forwarded with mdb and no flooding, not
forwarded with mdb on another port and flooding, can't test with
group_fwd_mask
Group 01:80:C2:00:00:03: not forwarded with flooding, not forwarded
without flooding, not forwarded with mdb and no flooding, not
forwarded with mdb on another port and flooding, forwarded with
group_fwd_mask
Group 01:80:C2:00:00:20: forwarded with flooding, not forwarded
without flooding, forwarded with mdb and no flooding, not forwarded
with mdb on another port and flooding, can't test with group_fwd_mask
Group 01:80:C2:00:00:21: forwarded with flooding, not forwarded
without flooding, forwarded with mdb and no flooding, not forwarded
with mdb on another port and flooding, can't test with group_fwd_mask
Group 01:80:C2:00:00:02: not forwarded with flooding, not forwarded
without flooding, not forwarded with mdb and no flooding, not
forwarded with mdb on another port and flooding, can't test with
group_fwd_mask
Group 01:80:C2:00:00:04: not forwarded with flooding, not forwarded
without flooding, not forwarded with mdb and no flooding, not
forwarded with mdb on another port and flooding, forwarded with
group_fwd_mask
Group 01:80:C2:00:00:0F: not forwarded with flooding, not forwarded
without flooding, not forwarded with mdb and no flooding, not
forwarded with mdb on another port and flooding, forwarded with
group_fwd_mask
Group 01:80:C2:00:00:11: forwarded with flooding, not forwarded
without flooding, forwarded with mdb and no flooding, not forwarded
with mdb on another port and flooding, can't test with group_fwd_mask
Group 01:80:C2:00:00:1F: forwarded with flooding, not forwarded
without flooding, forwarded with mdb and no flooding, not forwarded
with mdb on another port and flooding, forwarded with group_fwd_mask
Group 01:80:C2:00:00:22: forwarded with flooding, not forwarded
without flooding, forwarded with mdb and no flooding, not forwarded
with mdb on another port and flooding, can't test with group_fwd_mask
Group 01:80:C2:00:00:2F: forwarded with flooding, not forwarded
without flooding, forwarded with mdb and no flooding, not forwarded
with mdb on another port and flooding, forwarded with group_fwd_mask

Why did you choose these addresses?

The original complaint I'm trying to address was that LLDP used to be
forwarded on the ksz9477 prior to the enabling of the hw multicast
address table and now is not. LLDP uses both 01-80-c2-00-00-00 and
01-80-c2-00-00-0e and while 01-80-c2-00-00-00 is forwarded currently
on the ksz9477 01-80-c2-00-00-0e is not. It's the same for the
software bridge scenario above - when I add 01-80-c2-00-00-0e to the
test, it's not forwarded. Where are the above rules implemented for
the software bridge and why are these the choices?

Best Regards,

Tim

