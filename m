Return-Path: <netdev+bounces-237367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F5BC49AE2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813B03A684E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563BA1B0413;
	Mon, 10 Nov 2025 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/cMdCJC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787CE883F
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815692; cv=none; b=jg4+BSHsWi7Ix0h0OocwkS0VgZLP/W5GyAIlIdEMPWCO3cH5cctv7mPKA/vbuX5K4QJxIYQgqIIdD68aLoXXBONGBY5MtSVPNXgW6BtPkBQOgKTkjOmTvq4tUnN6kZSVSHksO2MOE23H3Kys6aftR5MG0oqz1k/zO4tKyBaZ+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815692; c=relaxed/simple;
	bh=YDyt0ignDie+Sp7OJmrOTRTs8PU5wIhTXPeVinvnHyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVjwumikSTO+dvx7W8kxj6VbMEJBizpEfNJZU4CRW4pvSRIAt9xl/Es+Bg2l0aLiRBHpp0UfNbM/8+ORzdXyk/kAhxDI5UB8gf82SBYEs7cxM63b0Nflk9KVegBqiw3H8CeOVtA9Tp5cd/khCcjWGX0EaptJdjbXevz48DgCQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/cMdCJC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b2cff817aso354251f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 15:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762815689; x=1763420489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35lZlJg1c3UneSfoREWljih+bHJcaa9Q1ULrC104ugY=;
        b=j/cMdCJCwsweH1iQOsmXVWeYsjw5UmMCOIBjEQYevKtSEDY1X9LeEXRfR4UjwOMFSJ
         G2NxZyypwxoRMJGWzPmD/EA3ULHcvc44JbAsvMhKXBM5hWW3oaO2b43R7bIayDi3q246
         UqCBhTpyzv5pe918YGcMBeCnU8VG2j3T2Mo0T6VuUMdHAQONfaiax83JxvijbUXpzkSn
         /GHcnbGbvWCspfk2YRfsFPXQ1MOUW/xRC7pVc3ifkYnK1J3GCrryp1wY567DSQ6PKHhC
         agIiD28GwA6t1pC3Xbx/660RL90N0DQoFbqIb6Y/vnoS5PE29DCB3KiK9UWjMBlf+fIj
         RSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762815689; x=1763420489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35lZlJg1c3UneSfoREWljih+bHJcaa9Q1ULrC104ugY=;
        b=C6/Ncy3uji419OiqOJfBz8LGM7EyyhDgKu9HLPwDXF34gjSpzimFZHViCHSJ20e97k
         U+m7erLv6B7lT7PWkzkn+S0j2GVeGLgKw4DX6rtDw9lnYQnj4pb97kvJDDkF9vJrl73c
         y2MrCwjJwqd6vAgrYBhz4wAvQHxQzG2n78oK+SAYQTl/l+gzrP51XdhJ3UtADY7rGLYy
         l4wc+RttQ+XqSaPro5FNUyQoEFQ2kTFRxGBTgr4B5AzqHcOvrhpWeWBE65JDXM3DyzZm
         b2mu14/gp6Nt5xhbn/op6y8jj28EhuLDzKLqUeY3j8r6RgvaYVH4MiythQSJLdxlDY+S
         wBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX29amyG6ZNfQmpCRUEBOnv2Ta37wimYfdAwTB5GQxm3qfRA1a2s8UCPczvXC6TRAhQ17EnsMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAEpRN2o/n0MUyLtaN4mrKnrmiGa/y+fCyxAT8KfKaaxH9dNTW
	iWjryvtSuqFNSU0gEFe02hpR4rNDzyjTcEIqEQvjyVZ0YdHfAhCU796x
X-Gm-Gg: ASbGncs6kZPD8JXdjXMnTUsLSExc7CEeRcCJcJpFT9mtvI22zh37mH3ZvfowjAqeDSA
	otidBYT2MZEt3sDjo93xsKG8zp5rWRl/vQIoy9kAs+kWtK8jRNNFxhFZqqqBvJwtCoYy3CqmOLR
	spBCotZOzUDJs527S2vpk0sohBgZ52dAwokzMJnzHEq0OP3LGKbRqXu85Cm7GKx2Ty7UX4rdeKi
	/lcNwg3xXlysj8x0eHHH3Intvt8c9QQ7QglkwOqNpde0vcnrLpxKwBA5a/r6ge5ixFi/pzazEg0
	pDK/bZVc5haKrRI3NhgjWktZxlFZOdRmKyaOojtg/XzEXjfXOfutrZq+RQjKGPNTzlKQ9FM0emi
	Pt8UsWBgw5LYy5GOwXGwDQx/9T7/VxPpkTGkAZ2Yy6mLswHi0gt+U5hzGFtHIYVDOWurH
X-Google-Smtp-Source: AGHT+IEQma9G6zyLe5B5+knpc1yWfr5aR5BU3vkO3qP7bT+V9QSLPfBL8FC6/0wnkteYkj7c71E+qQ==
X-Received: by 2002:a05:6000:22c1:b0:42b:3e20:f1b1 with SMTP id ffacd0b85a97d-42b4284b840mr542714f8f.2.1762815688455;
        Mon, 10 Nov 2025 15:01:28 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00b:be00:af04:5711:ff1d:8f52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b330f6899sm13053908f8f.21.2025.11.10.15.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:01:27 -0800 (PST)
Date: Tue, 11 Nov 2025 01:01:24 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/3] net: dsa: deny unsupported 8021q uppers
 on bridge ports
Message-ID: <20251110230124.7pzmkhrkxvtgzh5k@skbuf>
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110214443.342103-1-jonas.gorski@gmail.com>

Hi Jonas,

On Mon, Nov 10, 2025 at 10:44:40PM +0100, Jonas Gorski wrote:
> Documentation/networking/switchdev.rst is quite strict on how VLAN
> uppers on bridged ports should work:
> 
> - with VLAN filtering turned off, the bridge will process all ingress traffic
>   for the port, except for the traffic tagged with a VLAN ID destined for a
>   VLAN upper. (...)
> 
> - with VLAN filtering turned on, these VLAN devices can be created as long as
>   the bridge does not have an existing VLAN entry with the same VID on any
>   bridge port. (...)
> 
> Presumably with VLAN filtering on, the bridge should also not process
> (i.e. forward) traffic destined for a VLAN upper.
> 
> But currently, there is no way to tell dsa drivers that a VLAN on a
> bridged port is for a VLAN upper and should not be processed by the
> bridge.

You say this as if it mattered. We can add a distinguishing mechanism
(for example we can pass a struct dsa_db to .port_vlan_add(), set to
DSA_DB_PORT for VLAN RX filtering and DSA_DB_BRIDGE for bridge VLANs),
but the premise was that drivers don't need to care, because HW won't do
anything useful with that information.

> Both adding a VLAN to a bridge port and adding a VLAN upper to a bridged
> port will call dsa_switch_ops::port_vlan_add(), with no way for the
> driver to know which is which. But even so, most devices likely would
> not support configuring forwarding per VLAN.

Yes, this is why the status quo is that DSA tries to ensure that VLAN
uppers do not cause ports to forward packets between each other.
You are not really changing the status quo in any way, just fixing some
bugs where that didn't happen effectively. Perhaps you could make that a
bit more clear.

> So in order to prevent the configuration of configurations with
> unintended forwarding between ports:
> 
> * deny configuring more than one VLAN upper on bridged ports per VLAN on
>   VLAN filtering bridges
> * deny configuring any VLAN uppers on bridged ports on VLAN non
>   filtering bridges
> * And consequently, disallow disabling filtering as long as there are
>   any VLAN uppers configured on bridged ports

First bullet makes some sense, bullets 2 and 3 not so much.

The first bullet makes just "some" sense because I don't understand why
limit to just bridged ports. We should extend to all NETIF_F_HW_VLAN_CTAG_FILTER
ports as per the dsa_user_manage_vlan_filtering() definitions.

Bullets 2 and 3 don't make sense because it isn't explained how VLAN
non-filtering bridge ports could gain the NETIF_F_HW_VLAN_CTAG_FILTER
feature required for them to see RX filtering VLANs programmed to
hardware in the first place.

> An alternative solution suggested by switchdev.rst would be to treat
> these ports as standalone, and do the filtering/forwarding in software.
> 
> But likely DSA supported switches are used on low power devices, where
> the performance impact from this would be large.
> 
> While going through the code, I also found one corner case where it was
> possible to add bridge VLANs shared with VLAN uppers, while adding
> VLAN uppers shared with bridge VLANs was properly denied. This is the
> first patch as this seems to be like the least controversial.
> 
> Sent as a RFC for now due to the potential impact, though a preliminary
> test didn't should any failures with bridge_vlan_{un,}aware.sh and
> local_termination.sh selftests on BCM63268.
> 
> A potential selftest for bridge_vlan_{un,}aware.sh I could think of
> 
> - bridge p3, p4
> - add VLAN uppers on p1 - p4 with a unique VLAN
>   if refused, treat as allowed failure
> - check if p4 sees traffic from p1
> 
> If p1 and p4 are isolated (so implicitly p2 and p3), its fine, and if
> the configuration is rejected is also fine, but forwarding is not.

Sounds like something which would be fit for
tools/testing/selftests/net/forwarding/no_forwarding.sh.

