Return-Path: <netdev+bounces-186377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AD7A9ECA0
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CB11888A89
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5133D26156A;
	Mon, 28 Apr 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZG81D1C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BC39ACC;
	Mon, 28 Apr 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745832440; cv=none; b=hgThvm8zqRs/Ww27cTRAk/AMp1QJyrBHm+/6XR2YDbZrSG8XuKn+r7UWQLqV3R/sm4HVdPrVA052CSMOQWXngmhZ+X1Dftl59NMLZbcfKrA4Ncsr54hnZhGqV+2DS36QfiHRAEQl2ylrfP/VUNzKZ4JwPIWACEwejKoIq/bYozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745832440; c=relaxed/simple;
	bh=AOrurvQBPdJGDSxym+li72GM0IQJ3l3EzJzWO5hc4DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5NRR+Wh+abp1s1e932XStavncBUJhRyiloprPCjAjSiqnKbyP1WdLoO2zCca7htvaKzu8vRpiHhpjI70wQcgFZn65YJQfjRm1bfTO0zXLYW9PTFvSXwoupXAiF0geoUCHtXmuduk6Axw86U3DphXOp2gFiqMbdk5EYSEV6o2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZG81D1C; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43f106a3591so5293875e9.3;
        Mon, 28 Apr 2025 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745832435; x=1746437235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lYaYDnkKtvyys/HpXygeG1INqfDgvABU5oOAJzzLV30=;
        b=LZG81D1C0alX8hYO1eA84JINb46VCFYlolYjOl+VYQq37Jqy4eM5CAdzUCx5LJcjjD
         hNUa7WvCxjx1u01BrltyKTO9Z+MkiODdu/3edXkhYqr9HX96UfMLxZaKDA/q8Zv/ra5T
         BWDXdLtnTXj6dhyI89K26eVWNe/75xfz4tmKNqt9r8SW4cdbZOMvSn9NyrOD0DiKk3V+
         e88i3ovFvhapNrjefaAz7K8i3H9fs2fFLOrexUrHflwL/69lx9ee7je0h0GAKdcpuGF+
         gbsL6TzfzUObw9sHtlm1AhUC+JP9BIIqQ94jyORURdzuVW5XXxYuou9aVPiiXqhJb8xA
         rU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745832435; x=1746437235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYaYDnkKtvyys/HpXygeG1INqfDgvABU5oOAJzzLV30=;
        b=fB5ptWAawoyQGTJCM0OgaswNLhQUVbRYdA53V5UIJ97oRC1alOzUEc8X/w06t01G+O
         0ioybpskdvx4RiTSivMq5wOVwIdINKNAjjnGZ8DatR4LHRgRGBBs97TYExb8CNa65Rvm
         ieaG+odrFjVlnD5nZ+Ip2ESBCqv6lLpJBqahVFZR6tibwUS4qzov76wBDVhBVUWCtw4f
         gQ4vgn0xtAZ2pBrZ4u6CEhyVlw0QHB8Z3MWW7PZAKuqFeuZT9ZyLkv4m3upL6aijjxNr
         brfQMRlFfuH8yUir2hoZE94ODHslm+DZxIlGzL9iEyunZ7IeV19D3HbuZYtC+aX4cspV
         vqbw==
X-Forwarded-Encrypted: i=1; AJvYcCVnnkq9MojjiqgMIvpRQEiz94JGCto6XA/X0x+xPF5oRIHr2aVPIkMgYoW4kfL7PROBNDkEtC9V@vger.kernel.org, AJvYcCWEAaFgxD4tSsUHzROkEnSXkp/xAsCbdbwlEXbkjkaIb7TqdbHI4mTr9Y2fU0qApzh2VbQlLf5v7X0Qzdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypzpYWXDldPtNk8BvFOxqQsOg5IQwUqxwa0XmJ/dJKAWZq6NJV
	cmg81TR0sNXZxFckTDvV2VwoguyvS+R8tGYVBEIFU9LrcpcC8+6e
X-Gm-Gg: ASbGnctKMohug5AabFQVCnrWJug2rQ+vNblNpphpDziQNS5ZfBipE0lhUueCisDFXfa
	Bz7+ut0szfYK85lFhkKEw11yZR3RJ8kGkaoszTF0xUKDvTAdOUy1JLgf9QvAnflcYKBbvgHVur8
	53yr1pYyb+JWqRByQDTwuOBhu5JTbXZxZ1ZY/VIe3EJyQW1QLhZjCvWGI01EXxzX6emNH/Pieq2
	RgyrkmBDRGLBHgUhcdfVe7nTIys4Y0B+4j3l0UySS/pOJ5QtUCvLlssvYnRIynYcU8a5UC0dIe7
	OMCBenzyhuz4SvQhpzMk8qAi/wvGr/swnBTFR7o=
X-Google-Smtp-Source: AGHT+IGdmXZ2WAYACHeYiosmtulUcS+64qMJ9n/kaYqoVRIYxIERpMSoHIgkytpkfgQXmZpijzs6dw==
X-Received: by 2002:a05:6000:18ae:b0:3a0:6c12:237e with SMTP id ffacd0b85a97d-3a074f8fa42mr2996394f8f.16.1745832435237;
        Mon, 28 Apr 2025 02:27:15 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2d8976sm149400125e9.27.2025.04.28.02.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 02:27:14 -0700 (PDT)
Date: Mon, 28 Apr 2025 12:27:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling
 filtering
Message-ID: <20250428092712.7owj62ct2dj5t2r4@skbuf>
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
 <20250424102509.65u5zmxhbjsd5vun@skbuf>
 <04ac4aec-e6cd-4432-a31d-73088e762565@gmail.com>
 <CAOiHx==5p2O6wVa42YtR-d=Sufbb2Ljy64mFSHavX2bguVXPWg@mail.gmail.com>
 <20250424225738.7xr36vll3vg4irzf@skbuf>
 <CAOiHx=m0nkxczOHQycCjsXcRvs-eP+wGgrUDDuB5UpSnMBSLkw@mail.gmail.com>
 <20250425114225.w24quv7gnp5vlcyd@skbuf>
 <CAOiHx==qdf+NVk5wG2J48gVBovp-UQuO1iS+6cCFbKyGyR0uqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx==qdf+NVk5wG2J48gVBovp-UQuO1iS+6cCFbKyGyR0uqw@mail.gmail.com>

On Sat, Apr 26, 2025 at 05:44:33PM +0200, Jonas Gorski wrote:
> On Fri, Apr 25, 2025 at 1:42 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > We have insufficient coverage in dsa_user_prechangeupper_sanity_check()
> > and dsa_port_can_apply_vlan_filtering(), but we should add another
> > restriction for this: 8021q uppers with the same VID should not be
> > installed to ports spanning the same VLAN-aware bridge. And there should
> > be a new test for it in tools/testing/selftests/net/forwarding/no_forwarding.sh.
> >
> > The restriction can be selectively lifted if there ever appear drivers
> > which can make the distinction you are talking about, but I don't think
> > that any of them can, at the moment.
> 
> AFAICT, we probably then also need to deny any vlan uppers on ports
> bridged via vlan unaware bridges for now, as we currently don't
> actually configure them at all.

So it seems.

> switchdev.rst says "Frames ingressing the device with a VID that is
> not programmed into the bridge/switch's VLAN table must be forwarded
> and may be processed using a VLAN device (see below)" (I thought with
> a vlan unaware bridge we do not program the VLAN table? anway ...)

I think the sentence just intended to clarify what it means for the port
to be non-filtering, but in the process introduced the ambiguity of
whether VLANs should be committed to hardware tables or not.

To be clear, from the bridge perspective, VLAN filtering = VLAN awareness
(there doesn't exist any option to, say, have per-VLAN learning but not
filtering). I suppose that if the hardware supports mechanisms of being
VLAN-aware but not filtering, and still do VLAN-unaware learning, those
mechanisms can be used as long as the bridging layer expectations are met.

> "- with VLAN filtering turned off, the bridge will process all ingress traffic
>   for the port, except for the traffic tagged with a VLAN ID destined for a
>   VLAN upper."
> 
> This is currently not happening when creating a vlan upper, at least I
> don't see any port_vlan_add() (?) calls for that. And even then, it
> would be indistinguishable from the port_vlan_add() calls that happen
> if you add a vlan to the bridge's vlan table, which you can, and DSA
> passes on, but should not be acted upon by the switch until vlan
> filtering is turned on.
> 
> Also in general vlan unaware bridges feel like they have a lot of
> complicated and probably unsupportable setups.
> 
> Like for example:
> 
> br0 { sw1p1, sw1p2, sw1p3, sw1p4 }
> br1 { sw1p1.10, sw1p4.10 }
> 
> would AFAIU mean:
> 
> - forward all traffic except vlan 10 tagged between all 4 ports
> - vlan 10 tagged traffic from sw1p1 can only go to sw1p4
> - vlan 10 tagged traffic from sw1p4 can only go to sw1p1
> - vlan 10 tagged traffic from sw1p2 and sw1p3 can go to all other ports
> 
> I'm not confident that I could program that correctly on a Broadcom
> XGS switch, and these support a *lot* of VLAN shenanigans.

You can add restrictions for these cases for 'net', as I don't think any
current DSA driver handles this correctly. Then, if you want to take a
stab at offloading these configurations, feel free to do so in net-next.

> This probably leaves:
> 
> "    * Treat bridge ports with VLAN upper interfaces as standalone, and let
>       forwarding be handled in the software data path."
> 
> as the only viable option here

Keep in mind that we haven't experimented with dynamically unoffloading
a bridge port before (calling switchdev_bridge_port_unoffload() at
runtime). That will be necessary when toggling the bridge vlan_filtering
option. It should work, but I can't guarantee that it does. In general,
software bridging was retrofitted onto DSA drivers which also support
bridge offload, and not all of them may work correctly (they may still
have address learning enabled, things like that). I'd only consider that
path as suitable for net-next.

> (I have to admit I don't really understand what the first option is
> suggesting to do).

The first option suggests that you can implement a VLAN-unaware bridge
by mapping the entire 4K VLAN space to a single VLAN within the hardware
switch. It has to be configured specially at the driver level, to always
preserve the VLAN tag (and ID) when egressing the packet. Then exempt
certain VLAN IDs (of 8021q uppers) from this treatment, and include only
the user port and CPU port in their forwarding mask.

The above can also be reinterpreted in the key that packets with a VLAN
ID that isn't in the VLAN database aren't "filtered" but forwarded as-is,
and learned all together. It seems to be similar with your own
suggestion above.

It's just an idea, and requires hardware support to achieve that. This
circles back to the idea that the port can be configured as VLAN "aware"
as long as it's not "filtering" from the bridge perspective, and there
is no address space segregation per VLAN in the FDB. The bridge doesn't
need to be aware of this custom mode of operation, the driver may decide
to transition to it only in the presence of 8021q uppers on top of
VLAN-unaware bridge ports.

