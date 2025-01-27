Return-Path: <netdev+bounces-161103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BFCA1D647
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 13:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503A11887503
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 12:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3131FF1D9;
	Mon, 27 Jan 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQa98a9D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059C53BE;
	Mon, 27 Jan 2025 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737982474; cv=none; b=ZAlgYfaelCbPQrrS7MzT4dHPe2yA5BD5RlmLHaPh7cxeSBWDxMru3IvkGe3HkTd2tGGmOHKqu4NwXSy6XqJSHHhcTZdoWkLKBki1Rernq34eONuJA6sGsyInBngHCIN35KbXhY2b/tDNAKCQ2r45AnAMpkjVNVEV6Cho8dc8Xf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737982474; c=relaxed/simple;
	bh=IB3IHnQSnxKySl7FLNAvIGgqY5iP+FSKkGo5/1yRdAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SubEKezCJEp51Xf1l+hek02DKzXiF1rCi/LPrNEhfpMT5P7ZV5+dDLhPP9M++y3WrOxFmh0V6zF4lU4TRTc2/1f3MnmDku0WZxKlNrv8ka0iAUsb2h+aPQO+Xmdiz6yGHp7ROPL+HXt+N/Er9rVC9rEiX+MPhOHgWYStadbRkl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQa98a9D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436284cdbe0so6984395e9.3;
        Mon, 27 Jan 2025 04:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737982470; x=1738587270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wOd4PpIhrX4OTnewXAmSuwevn3+mehxSVY1BiVFb7MA=;
        b=UQa98a9Dn4fCE8DbC1F0pytWjQqwKuw5dx9Ny4gSD3jwNXwT0pfdIGuU102xuEWtEl
         ll9GvFatZoPlR+py3aGRYKXc4erwzRDbiO0QrDQFXxShQIeL9DlkkSqlAK5upnUT1a3E
         i7OCY4mwxaI57mhAxcDplr5lTt7nI/fzqEXXwfmksU056LPF+a6zmYQDO6KB/o1qGyEE
         09Irg8J22CIH2c/fA+5eB7z+3/syRi+FjH6NZnWZ4WC29ACKAW0KELj5M89y7wbx1kAa
         TM36YEyW71SaW2W4ZTtfgK+S4X3Er/Yo7wxJ8+EEwaVtx0il2hT6I9EswFmAGfCA+Wrq
         rwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737982470; x=1738587270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOd4PpIhrX4OTnewXAmSuwevn3+mehxSVY1BiVFb7MA=;
        b=CxuvcDNi8aHq8XlzkvyyMfvh7vQquZ83mFl+S9pW+HHd+BkagpwsFQoUgjZgELEOsr
         u8rnBlDycVT7BDa/rmJY/369eVqtdu9n7bUkx8fJPzCwplY99NXbP19OeXi6NDVRgnsg
         NbPOumgZ8BBb867RmNZ9NTC1DhbZdsFu6XpmUxutbmT6vV2Uh34qOSRM2EYfRUvtI4g0
         UGoU3G6jmLq1LotrMSn28qXoFAW3mz2xWwohfJ2PQQXTTErGifm0S35WVGZGAISX1nRw
         Y804y9FC/xGxxGtpg2GHJ9Qk7irIWOwz/V5iUrjuN378a3ZHmnh9ilzuK0Ftht8Mgixa
         4u/g==
X-Forwarded-Encrypted: i=1; AJvYcCX3xKho5c4U9heKNmRJ/OoYVGiODlGEZZRV9qXHVNiTcFDugzEHwr8/CZF1oMyC7XUmK/8NXVf3@vger.kernel.org, AJvYcCXJ/4nG7ajjRl8NteDHZ1XR3pkhUa4WOwuDBhGVApmMXb4tOwz+r4FYkUbLpPFr2cDNaSwvAzJXVHc6LlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTMP0penqggXV7b74ti47AkwrMSktdtkQy0Y3/9QcYaWXfGrCF
	wdL6SXjjxJynAuH6m8eliYLCDhNbGDgr8//iKU41tgGqCuo8iK98
X-Gm-Gg: ASbGncv4m8Y3Hwb1gU2qG6mPFbmmQah83ooHmQebU0GhVmcYEDMk68cFNLWINmM/no1
	7LD05T0z3/fJW/z0Z8rhjb1OpFeYRI1FECoodHQDAgLC0inqaB13ys0Q1wH5/IgcdGgCI+ZQZ0z
	XgBglJw607a+2CH044DTwWrPgHVnypKVhroAwvdT2JT9qwuNuItt+tNw7YPO6E4bCw3/jBfUpHF
	ol+8duknb7TeswUNCukWWK5sE/B6TsG+giN1oO1pwZ+tE+/GnIfdzUKGn9x2xB6NA7Z
X-Google-Smtp-Source: AGHT+IGCqFD5NEJ5PckxdeKY9ZtBJw+HVHN0DVvmoLKTH665fe5jTa5i29yS0tjvQ9PMslcUHeBdhw==
X-Received: by 2002:a05:600c:1f88:b0:42c:aeee:e604 with SMTP id 5b1f17b1804b1-4389146ed11mr139174725e9.8.1737982470142;
        Mon, 27 Jan 2025 04:54:30 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd48574csm132226245e9.9.2025.01.27.04.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 04:54:29 -0800 (PST)
Date: Mon, 27 Jan 2025 14:54:26 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Tristram.Ha@microchip.com, Arun.Ramadoss@microchip.com, andrew@lunn.ch,
	davem@davemloft.net, Woojung.Huh@microchip.com,
	linux-kernel@vger.kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, edumazet@google.com,
	UNGLinuxDriver@microchip.com, kuba@kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
Message-ID: <20250127125426.3b7cdkb75o5dbcr5@skbuf>
References: <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
 <CAJ+vNU3sAhtSkTjuj2ZMfa02Qk1rh1-z=1unEabrB8UOdx8nFA@mail.gmail.com>
 <55858a5677f187e5847e7941d62f6f186f5d121c.camel@microchip.com>
 <DM3PR11MB8736EAC16094D3BFF6CE1B30EC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <CAJ+vNU2BZ2oMy2Gj7xwwsO8EQJcCq9GP-BkaMjEpLUkkmBQVeg@mail.gmail.com>
 <20250117161334.ail2fyjuq75ef5to@skbuf>
 <CAJ+vNU2RT2MmyO_YgoQmkb0UdWWKS42_fb1jqYLPmLJf5XNO=A@mail.gmail.com>
 <20250118011803.xqlvdzizpwnytii3@skbuf>
 <CAJ+vNU1R7zCsEGoM2LP5XDaTseLxiTaa+jD1STcW9ZNgaO16Sw@mail.gmail.com>
 <CAJ+vNU1R7zCsEGoM2LP5XDaTseLxiTaa+jD1STcW9ZNgaO16Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU1R7zCsEGoM2LP5XDaTseLxiTaa+jD1STcW9ZNgaO16Sw@mail.gmail.com>
 <CAJ+vNU1R7zCsEGoM2LP5XDaTseLxiTaa+jD1STcW9ZNgaO16Sw@mail.gmail.com>

On Wed, Jan 22, 2025 at 05:48:51PM -0800, Tim Harvey wrote:
> On Fri, Jan 17, 2025 at 5:18 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> > On Fri, Jan 17, 2025 at 01:02:31PM -0800, Tim Harvey wrote:
> > > The flaw with that patch is that enabling the multicast address table
> > > invokes other default rules in the table that need to be re-configured
> > > for the cpu port but the patch only configures group 0
> > > (01-80-c2-00-00-00). it fails to configure group 6 (01-80-c2-00-00-08)
> > > which is also used for stp so i would argue that it doesn't even do
> > > what the commit log says it does. it also has the side effect of
> > > disabling forwarding of other groups that were previously forwarded:
> > > - group 1 01-80-c2-00-00-01 (mac control frame) (previously were
> > > forwarded, now are dropped)
> > > - group 2 01-80-c2-00-00-03 (802.1x access control) (previously were
> > > forwarded, now are forwarded to the highest port which may not be the
> > > cpu port)
> > > - group 4 01-80-c2-00-00-20 (gmrp) (previously were forwarded, now
> > > forwarded to all except the highest port number which may not be the
> > > cpu port)
> > > - group 5 01-80-c2-00-00-21 (gvrp) (previously were forwarded, now
> > > forwarded to all except the highest port number which may not be the
> > > cpu port)
> > > - group 6 01-80-c2-00-00-02, 01-80-c2-00-00-04 - 01-80-c2-00-00-0f
> > > (previously were forwarded, now are forwarded to the highest port
> > > which may not be the cpu port)
> > > - group 7 01-80-c2-00-00-11 - 01-80-c2-00-00-1f, 01-80-c2-00-00-22 -
> > > 01-80-c2-00-00-2f (previously were forwarded, now forwarded to all
> > > except the highest port number which may not be the cpu port)
> >
> > > To fix this, I propose adding a function to configure each of the
> > > above groups (which are hardware filtering functions of the switch)
> > > with proper port masks but I need to know from the DSA experts what is
> > > desired for the port mask of those groups. The multicast address table
> > > can only invoke rules based on those groups of addresses so if that is
> > > not flexible enough then the multicast address table should instead be
> > > disabled.
> >
> > The recommendation from the DSA maintainers will be to follow what the
> > software bridge data path does, which just means testing and seeing how
> > each group reacts to the known inputs which might affect it, i.e.:
> >
> > - is it a group of the form 01-80-c2-00-00-0X? if yes, group_fwd_mask
> >   should dictate how it is forwarded by software. All that hardware
> >   needs to take care of is to send it just to the CPU.
> >
> > - is multicast flooding enabled on the egress port?
> >
> > - is there an MDB entry towards the egress port? how about another port?
> >   The groups outside the 01-80-c2-00-00-0X range should be treated as
> >   regular multicast, i.e. group_fwd_mask doesn't matter, and mdb/flooding
> >   does.
> >
> > One easy way out, if synchronizing the hardware port masks with the
> > software state turns out too hard, is to configure the switch to send
> > all these groups just to the CPU, and make sure skb->offload_fwd_mark is
> > unset for packets belonging to these groups (don't call
> > dsa_default_offload_fwd_mark() from the tagger). The software takes this
> > as a cue that it should forward them where the hardware didn't reach.
> >
> > Also, never exclude the CPU port from the destination port mask, unless
> > you really, really know what you're doing. The software bridge might
> > need to forward to another foreign (non-switch) bridge port which is an
> > Intel e1000 card, or a Wi-Fi AP, or a tunnel, and by cutting out the CPU
> > from the flood path, you're taking that possibility away from it.
> >
> > Here's a script to get you started with testing.
> >
> > #!/bin/bash
> >
> > ARP=" \
> > ff:ff:ff:ff:ff:ff 00:00:de:ad:be:ef 08 06 00 01 \
> > 08 00 06 04 00 01 e0 07 1b 81 13 40 c0 a8 01 ad \
> > 00 00 00 00 00 00 c0 a8 01 ea"
> > groups=( \
> >         01:80:C2:00:00:00 \
> >         01:80:C2:00:00:08 \
> >         01:80:C2:00:00:01 \
> >         01:80:C2:00:00:03 \
> >         01:80:C2:00:00:20 \
> >         01:80:C2:00:00:21 \
> >         01:80:C2:00:00:02 \
> >         01:80:C2:00:00:04 \
> >         01:80:C2:00:00:0F \
> >         01:80:C2:00:00:11 \
> >         01:80:C2:00:00:1F \
> >         01:80:C2:00:00:22 \
> >         01:80:C2:00:00:2F \
> > )
> > pkt_count=1000
> >
> > mac_get()
> > {
> >         local if_name=$1
> >
> >         ip -j link show dev $if_name | jq -r '.[]["address"]'
> > }
> >
> > get_rx_stats()
> > {
> >         local if_name=$1
> >
> >         ip -j -s link show $if_name | jq '.[].stats64.rx.packets'
> > }
> >
> > last_nibble()
> > {
> >         local macaddr=$1
> >
> >         echo "0x${macaddr:0-1}"
> > }
> >
> > send_raw()
> > {
> >         local if_name=$1; shift
> >         local group=$1; shift
> >         local pkt="$1"; shift
> >         local smac=$(mac_get $if_name)
> >
> >         pkt="${pkt/ff:ff:ff:ff:ff:ff/$group}"
> >         pkt="${pkt/00:00:de:ad:be:ef/$smac}"
> >
> >         mausezahn -c $pkt_count -q $if_name "$pkt"
> > }
> >
> > run_test()
> > {
> >         before=$(get_rx_stats veth4)
> >         send_raw veth0 $group "$ARP"
> >         after=$(get_rx_stats veth4)
> >         delta=$((after - before))
> >
> >         [ $delta -ge $pkt_count ] && echo "forwarded" || echo "not forwarded"
> > }
> >
> > #          br0
> > #        /  |  \
> > #       /   |   \
> > #      /    |    \
> > #     /     |     \
> > #  veth1  veth3  veth5
> > #    |      |      |
> > #  veth0  veth2  veth4
> > ip link add veth0 type veth peer name veth1
> > ip link add veth2 type veth peer name veth3
> > ip link add veth4 type veth peer name veth5
> > ip link add br0 type bridge && ip link set br0 up
> > ip link set veth1 master br0 && ip link set veth1 up
> > ip link set veth3 master br0 && ip link set veth3 up
> > ip link set veth5 master br0 && ip link set veth5 up
> > ip link set veth0 up && ip link set veth2 up && ip link set veth4 up
> >
> > for group in "${groups[@]}"; do
> >         ip link set veth5 type bridge_slave mcast_flood on
> >         with_flooding=$(run_test $group)
> >
> >         ip link set veth5 type bridge_slave mcast_flood off
> >         without_flooding=$(run_test $group)
> >
> >         bridge mdb add dev br0 port veth5 grp $group permanent
> >         with_mdb_and_no_flooding=$(run_test $group)
> >         bridge mdb del dev br0 port veth5 grp $group permanent # restore
> >
> >         ip link set veth5 type bridge_slave mcast_flood on # restore
> >
> >         bridge mdb add dev br0 port veth3 grp $group permanent
> >         with_mdb_on_another_port=$(run_test $group)
> >         bridge mdb del dev br0 port veth3 grp $group permanent # restore
> >
> >         ip link set br0 type bridge group_fwd_mask $((1 << $(last_nibble $group))) 2>/dev/null
> >         if [ $? = 0 ]; then
> >                 with_group_fwd_mask=$(run_test $group)
> >                 ip link set br0 type bridge group_fwd_mask 0 # restore
> >         else
> >                 with_group_fwd_mask="can't test"
> >         fi
> >
> >         printf "Group %s: %s with flooding, %s without flooding, %s with mdb and no flooding, %s with mdb on another port and flooding, %s with group_fwd_mask\n" \
> >                 "$group" \
> >                 "$with_flooding" \
> >                 "$without_flooding" \
> >                 "$with_mdb_and_no_flooding" \
> >                 "$with_mdb_on_another_port" \
> >                 "$with_group_fwd_mask" \
> >
> > done
> >
> > ip link del veth0
> > ip link del veth2
> > ip link del veth4
> > ip link del br0
> 
> Hi Vladimir,
> 
> Here is the output of your script with Linux 6.13:
> Group 01:80:C2:00:00:00: forwarded with flooding, not forwarded
> without flooding, forwarded with mdb and no flooding, not forwarded
> with mdb on another port and flooding, can't test with group_fwd_mask
> Group 01:80:C2:00:00:08: not forwarded with flooding, not forwarded
> without flooding, not forwarded with mdb and no flooding, not
> forwarded with mdb on another port and flooding, forwarded with
> group_fwd_mask
> Group 01:80:C2:00:00:01: not forwarded with flooding, not forwarded
> without flooding, not forwarded with mdb and no flooding, not
> forwarded with mdb on another port and flooding, can't test with
> group_fwd_mask
> Group 01:80:C2:00:00:03: not forwarded with flooding, not forwarded
> without flooding, not forwarded with mdb and no flooding, not
> forwarded with mdb on another port and flooding, forwarded with
> group_fwd_mask
> Group 01:80:C2:00:00:20: forwarded with flooding, not forwarded
> without flooding, forwarded with mdb and no flooding, not forwarded
> with mdb on another port and flooding, can't test with group_fwd_mask
> Group 01:80:C2:00:00:21: forwarded with flooding, not forwarded
> without flooding, forwarded with mdb and no flooding, not forwarded
> with mdb on another port and flooding, can't test with group_fwd_mask
> Group 01:80:C2:00:00:02: not forwarded with flooding, not forwarded
> without flooding, not forwarded with mdb and no flooding, not
> forwarded with mdb on another port and flooding, can't test with
> group_fwd_mask
> Group 01:80:C2:00:00:04: not forwarded with flooding, not forwarded
> without flooding, not forwarded with mdb and no flooding, not
> forwarded with mdb on another port and flooding, forwarded with
> group_fwd_mask
> Group 01:80:C2:00:00:0F: not forwarded with flooding, not forwarded
> without flooding, not forwarded with mdb and no flooding, not
> forwarded with mdb on another port and flooding, forwarded with
> group_fwd_mask
> Group 01:80:C2:00:00:11: forwarded with flooding, not forwarded
> without flooding, forwarded with mdb and no flooding, not forwarded
> with mdb on another port and flooding, can't test with group_fwd_mask
> Group 01:80:C2:00:00:1F: forwarded with flooding, not forwarded
> without flooding, forwarded with mdb and no flooding, not forwarded
> with mdb on another port and flooding, forwarded with group_fwd_mask
> Group 01:80:C2:00:00:22: forwarded with flooding, not forwarded
> without flooding, forwarded with mdb and no flooding, not forwarded
> with mdb on another port and flooding, can't test with group_fwd_mask
> Group 01:80:C2:00:00:2F: forwarded with flooding, not forwarded
> without flooding, forwarded with mdb and no flooding, not forwarded
> with mdb on another port and flooding, forwarded with group_fwd_mask
> 
> Why did you choose these addresses?

I took these addresses from your previous reply. You can customize as
needed, to find out the bridge behavior for any group, of course.

> 
> The original complaint I'm trying to address was that LLDP used to be
> forwarded on the ksz9477 prior to the enabling of the hw multicast
> address table and now is not. LLDP uses both 01-80-c2-00-00-00 and
> 01-80-c2-00-00-0e and while 01-80-c2-00-00-00 is forwarded currently
> on the ksz9477 01-80-c2-00-00-0e is not. It's the same for the
> software bridge scenario above - when I add 01-80-c2-00-00-0e to the
> test, it's not forwarded. Where are the above rules implemented for
> the software bridge and why are these the choices?

If you see the "can't test with group_fwd_mask" error, it means that the
bridge is outright refusing to forward this particular group. See
https://elixir.bootlin.com/linux/v6.12.6/A/ident/BR_GROUPFWD_RESTRICTED
for more details.

For example, the bridge refuses to forward 01-80-c2-00-00-00 and the
question is why you would want to do that. "Previous behavior" doesn't
always mean "correct behavior".

Whereas group 01-80-c2-00-00-0e, as far as I can see, can be forwarded
fine by the software bridge when BIT(14) is set in the bridge group_fwd_mask.
For such groups, an accelerator has nothing more to do than ensure
skb->offload_fwd_mark = 0 on RX, and trap them exclusively to the CPU.

