Return-Path: <netdev+bounces-159507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E74A15AD0
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A026D167972
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 01:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC6B67F;
	Sat, 18 Jan 2025 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYDSRRZ7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909F195;
	Sat, 18 Jan 2025 01:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737163092; cv=none; b=AmF+rErQ3tZwqIkg6ixxbYYpP/MngeTq+DdOX5H2WnnMkyd71ZDb8l0e5XpeGeNC40UrgOeJkzskf+VxewlRAT+ZtzdDxXBhxIII8wn0VMryr2RK27lIYuL9dj4o/UY9jICYmoIcKG6V6w5enGTmo9sA4wnOzYsHLLTUlT4hMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737163092; c=relaxed/simple;
	bh=lxJmGCAGWDVhXp4lqRFVXP78vPeK6IArh1aFpn58QLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoLFjntiZo+JouEVKv2UG/shFGp/dqYFhHjUTGa6NnL+vEEVSO4LmMAUa/G8ARnBOEE/cuNMEtl9lc1vZ0pcfi0WrEXoRjkOPO28RuJBEby0uZh96DcWLEVgeYhw05MFoCLb76+G2jPmPiOWKQliJ9C2I8yDf/VBADA14Z6ZjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYDSRRZ7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361e82e3c3so3691845e9.0;
        Fri, 17 Jan 2025 17:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737163089; x=1737767889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZq0mZ3uQG+zZVXb05KA19D0Pj/aibNe67PJ/VEYbXk=;
        b=SYDSRRZ7B6iEV3l3sLZsFTgJgcwLyhWTK+ujZmuGbh0uuNd/FDsj1BNkkgfjw6Q/G7
         dvoO6KcmHPyq+Cg8ZK30of4HyYVw7dfyy57pm1tiGfA379EJObyEVGUv757/LmU7nHPR
         VV4zIqcYyGHsoWZf+u7ZdS1sboTBgIDeUQ91CoQZW3vaPLWYTPgsHb7Yw4uspGa/OpXw
         zpvR60a1CePUbuDXqab3IXa+gvQ2lZPXz1FtwDUF1yWCWqDIcuWDc/YZTTOckxsab1rN
         CSROx7YvkMnIAqMPYeIzPw1ncgtYydNZDTJ2sk3WH8JF+ZtLiiZM7QV2cqZOnl9vArSi
         TA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737163089; x=1737767889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZq0mZ3uQG+zZVXb05KA19D0Pj/aibNe67PJ/VEYbXk=;
        b=rTm6FRw/zyCx1h9/RXTpOXJV4Z5tKpSA7N6A8TmYcTUQykJ7HdLQKFtI2cdSwJGPQp
         VMp9ohpppl8UfJVA40wSH8LKts9RgWCKgngIT2krYEs0l8i3+05yf9jYl5nwTROg/a5x
         mtV1W/5B5ZEr+3KCMzjjV4QIKPhjN2E+qehobszOgeg1VFD0FBJ/FgGobBiAkK6lCdJJ
         3sF1k2Kfck5NuBKtyCRWl+w10AXa7DMfxjEfmsl9P+hhMOaE/SVvnPwM7HM3TZoFn+qr
         ZdDCmup69ai336C6q8EEFVffNsKU0EdolOyIvSfOJIrGeBMAoGqUNs+cpvVSlWsrqOf3
         Sx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjaugPiT5rHFl+HQu9LhucuVeoVAQbHiQQ9C88n9RUhPDoFrHBCDBYJ4wgUlx/qNAeU/eP9cVf@vger.kernel.org, AJvYcCXpxDBXEYphB9H15Hehgz84r6O8/VVGMwop8pGcQ672G8hPFu4nUtWjgM25A0DgPGpUHw4TaGWh8xG6/kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSvRAsD0V0zwUIxA5f9eaxfIZbmNekumFn2O9GBJU778+p+oE
	R6tzPTNHq1WWA6J58CT6CMgoj9a7Gem9Y9kMVaQm78mWSqlPWLaW
X-Gm-Gg: ASbGncsb3chmO3vaXgR9P6c05czB+mRMWSqKP/1eSNhmCJm3ZCAqftk7sAWQjx/bPH9
	wNhn9sznJ9s4Unhkm63dAOME9X1G8ucXbKUP59PbgrC1W6UbyBXz2O6jifH5wrYBHv8wJ2Qkuan
	LOYhc46vuwrR1tVI0XiOjvCvAyfyL/evAWpYLdK6HO+uMtAEpOWG18WEfy2voLr6c2fuF59jRPG
	TLb9rNXUcVOAHZot3TK+OCTc/XebrIc4mkZ6A+ROcneYNrx/rbNVpfM6Q==
X-Google-Smtp-Source: AGHT+IHyi9DKWolGfSCipsTjrEoXHEGGaamgvCsJHsyVyxGmzZO0O/QvSIO0FE0e3vxFmiFd8XPYHg==
X-Received: by 2002:a05:600c:cc8:b0:42c:aeee:e603 with SMTP id 5b1f17b1804b1-4389db13a7fmr11853495e9.7.1737163088385;
        Fri, 17 Jan 2025 17:18:08 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438a1f07e1bsm562285e9.7.2025.01.17.17.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 17:18:07 -0800 (PST)
Date: Sat, 18 Jan 2025 03:18:03 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Tristram.Ha@microchip.com, Arun.Ramadoss@microchip.com, andrew@lunn.ch,
	davem@davemloft.net, Woojung.Huh@microchip.com,
	linux-kernel@vger.kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, edumazet@google.com,
	UNGLinuxDriver@microchip.com, kuba@kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
Message-ID: <20250118011803.xqlvdzizpwnytii3@skbuf>
References: <20241213011405.ogogu5rvbjimuqji@skbuf>
 <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
 <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
 <CAJ+vNU3sAhtSkTjuj2ZMfa02Qk1rh1-z=1unEabrB8UOdx8nFA@mail.gmail.com>
 <55858a5677f187e5847e7941d62f6f186f5d121c.camel@microchip.com>
 <DM3PR11MB8736EAC16094D3BFF6CE1B30EC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <CAJ+vNU2BZ2oMy2Gj7xwwsO8EQJcCq9GP-BkaMjEpLUkkmBQVeg@mail.gmail.com>
 <20250117161334.ail2fyjuq75ef5to@skbuf>
 <CAJ+vNU2RT2MmyO_YgoQmkb0UdWWKS42_fb1jqYLPmLJf5XNO=A@mail.gmail.com>
 <CAJ+vNU2RT2MmyO_YgoQmkb0UdWWKS42_fb1jqYLPmLJf5XNO=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2RT2MmyO_YgoQmkb0UdWWKS42_fb1jqYLPmLJf5XNO=A@mail.gmail.com>
 <CAJ+vNU2RT2MmyO_YgoQmkb0UdWWKS42_fb1jqYLPmLJf5XNO=A@mail.gmail.com>

On Fri, Jan 17, 2025 at 01:02:31PM -0800, Tim Harvey wrote:
> The flaw with that patch is that enabling the multicast address table
> invokes other default rules in the table that need to be re-configured
> for the cpu port but the patch only configures group 0
> (01-80-C2-00-00-00). It fails to configure group 6 (01-80-C2-00-00-08)
> which is also used for STP so I would argue that it doesn't even do
> what the commit log says it does. It also has the side effect of
> disabling forwarding of other groups that were previously forwarded:
> - group 1 01-80-C2-00-00-01 (MAC Control Frame) (previously were
> forwarded, now are dropped)
> - group 2 01-80-C2-00-00-03 (802.1X access control) (previously were
> forwarded, now are forwarded to the highest port which may not be the
> cpu port)
> - group 4 01-80-C2-00-00-20 (GMRP) (previously were forwarded, now
> forwarded to all except the highest port number which may not be the
> cpu port)
> - group 5 01-80-C2-00-00-21 (GVRP) (previously were forwarded, now
> forwarded to all except the highest port number which may not be the
> cpu port)
> - group 6 01-80-C2-00-00-02, 01-80-C2-00-00-04 - 01-80-C2-00-00-0F
> (previously were forwarded, now are forwarded to the highest port
> which may not be the cpu port)
> - group 7 01-80-C2-00-00-11 - 01-80-C2-00-00-1F, 01-80-C2-00-00-22 -
> 01-80-C2-00-00-2F (previously were forwarded, now forwarded to all
> except the highest port number which may not be the cpu port)

> To fix this, I propose adding a function to configure each of the
> above groups (which are hardware filtering functions of the switch)
> with proper port masks but I need to know from the DSA experts what is
> desired for the port mask of those groups. The multicast address table
> can only invoke rules based on those groups of addresses so if that is
> not flexible enough then the multicast address table should instead be
> disabled.

The recommendation from the DSA maintainers will be to follow what the
software bridge data path does, which just means testing and seeing how
each group reacts to the known inputs which might affect it, i.e.:

- is it a group of the form 01-80-c2-00-00-0X? if yes, group_fwd_mask
  should dictate how it is forwarded by software. All that hardware
  needs to take care of is to send it just to the CPU.

- is multicast flooding enabled on the egress port?

- is there an MDB entry towards the egress port? how about another port?
  The groups outside the 01-80-c2-00-00-0X range should be treated as
  regular multicast, i.e. group_fwd_mask doesn't matter, and mdb/flooding
  does.

One easy way out, if synchronizing the hardware port masks with the
software state turns out too hard, is to configure the switch to send
all these groups just to the CPU, and make sure skb->offload_fwd_mark is
unset for packets belonging to these groups (don't call
dsa_default_offload_fwd_mark() from the tagger). The software takes this
as a cue that it should forward them where the hardware didn't reach.

Also, never exclude the CPU port from the destination port mask, unless
you really, really know what you're doing. The software bridge might
need to forward to another foreign (non-switch) bridge port which is an
Intel e1000 card, or a Wi-Fi AP, or a tunnel, and by cutting out the CPU
from the flood path, you're taking that possibility away from it.

Here's a script to get you started with testing.

#!/bin/bash

ARP=" \
ff:ff:ff:ff:ff:ff 00:00:de:ad:be:ef 08 06 00 01 \
08 00 06 04 00 01 e0 07 1b 81 13 40 c0 a8 01 ad \
00 00 00 00 00 00 c0 a8 01 ea"
groups=( \
	01:80:C2:00:00:00 \
	01:80:C2:00:00:08 \
	01:80:C2:00:00:01 \
	01:80:C2:00:00:03 \
	01:80:C2:00:00:20 \
	01:80:C2:00:00:21 \
	01:80:C2:00:00:02 \
	01:80:C2:00:00:04 \
	01:80:C2:00:00:0F \
	01:80:C2:00:00:11 \
	01:80:C2:00:00:1F \
	01:80:C2:00:00:22 \
	01:80:C2:00:00:2F \
)
pkt_count=1000

mac_get()
{
	local if_name=$1

	ip -j link show dev $if_name | jq -r '.[]["address"]'
}

get_rx_stats()
{
	local if_name=$1

	ip -j -s link show $if_name | jq '.[].stats64.rx.packets'
}

last_nibble()
{
	local macaddr=$1

	echo "0x${macaddr:0-1}"
}

send_raw()
{
	local if_name=$1; shift
	local group=$1; shift
	local pkt="$1"; shift
	local smac=$(mac_get $if_name)

	pkt="${pkt/ff:ff:ff:ff:ff:ff/$group}"
	pkt="${pkt/00:00:de:ad:be:ef/$smac}"

	mausezahn -c $pkt_count -q $if_name "$pkt"
}

run_test()
{
	before=$(get_rx_stats veth4)
	send_raw veth0 $group "$ARP"
	after=$(get_rx_stats veth4)
	delta=$((after - before))

	[ $delta -ge $pkt_count ] && echo "forwarded" || echo "not forwarded"
}

#          br0
#        /  |  \
#       /   |   \
#      /    |    \
#     /     |     \
#  veth1  veth3  veth5
#    |      |      |
#  veth0  veth2  veth4
ip link add veth0 type veth peer name veth1
ip link add veth2 type veth peer name veth3
ip link add veth4 type veth peer name veth5
ip link add br0 type bridge && ip link set br0 up
ip link set veth1 master br0 && ip link set veth1 up
ip link set veth3 master br0 && ip link set veth3 up
ip link set veth5 master br0 && ip link set veth5 up
ip link set veth0 up && ip link set veth2 up && ip link set veth4 up

for group in "${groups[@]}"; do
	ip link set veth5 type bridge_slave mcast_flood on
	with_flooding=$(run_test $group)

	ip link set veth5 type bridge_slave mcast_flood off
	without_flooding=$(run_test $group)

	bridge mdb add dev br0 port veth5 grp $group permanent
	with_mdb_and_no_flooding=$(run_test $group)
	bridge mdb del dev br0 port veth5 grp $group permanent # restore

	ip link set veth5 type bridge_slave mcast_flood on # restore

	bridge mdb add dev br0 port veth3 grp $group permanent
	with_mdb_on_another_port=$(run_test $group)
	bridge mdb del dev br0 port veth3 grp $group permanent # restore

	ip link set br0 type bridge group_fwd_mask $((1 << $(last_nibble $group))) 2>/dev/null
	if [ $? = 0 ]; then
		with_group_fwd_mask=$(run_test $group)
		ip link set br0 type bridge group_fwd_mask 0 # restore
	else
		with_group_fwd_mask="can't test"
	fi

	printf "Group %s: %s with flooding, %s without flooding, %s with mdb and no flooding, %s with mdb on another port and flooding, %s with group_fwd_mask\n" \
		"$group" \
		"$with_flooding" \
		"$without_flooding" \
		"$with_mdb_and_no_flooding" \
		"$with_mdb_on_another_port" \
		"$with_group_fwd_mask" \

done

ip link del veth0
ip link del veth2
ip link del veth4
ip link del br0

