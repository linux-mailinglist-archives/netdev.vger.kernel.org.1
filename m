Return-Path: <netdev+bounces-141630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5550C9BBD3D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D6CB20B7F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4775B1CACD0;
	Mon,  4 Nov 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BcIOfNgz"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397221C6F70
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744652; cv=none; b=czZLASBfHSMrAVSxSRpnunHnbUc4a2Aus0q1p/aWe35j7Du9hST9Co4Xw77wjtNb3/XA2ndlxzQqEPnNMgQfdmXfUkBWIcVQTmZKk5cQsOeJbJNbhfIfOhd87xMzcsB33h774dEmyvJE3JooUBIBllBPzrGTgiUJ97xbGVyKFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744652; c=relaxed/simple;
	bh=wCTAqgKdkSa0YuEkuz7gnB4EPPV0CnF4SXiM6iliv5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tnn5+CPk2L3zfkDa7WFJkMLRp/+fD9gZYSr8DBOixT3CQIaxja0sAHJUqzqEOb7munZuupd8wsVzrXjcSi7fMLhvtB94GbqbxqwcCeCpDvHiAtNJYjV4/HuN2qBlNZ0c83MG+4B/VX34NFjExbBmvK9x5/71Pa9yjNriAPy8kPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BcIOfNgz; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0AEFD2540170;
	Mon,  4 Nov 2024 13:24:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 04 Nov 2024 13:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730744648; x=1730831048; bh=KrEZgdZ6WSUOVpe3h/G/+NPMfNurDWWDIiN
	ecQ2Gmdg=; b=BcIOfNgzlIQZwtyJLI9l3IEFU1pk4ABma8iOee1cFaPnKAMYI2E
	BanoLXvDWDMsdRm8VaHSYbyeegF0AidK7Yn07Ubmz4FoNHxAFa+NdnMyCw5RKbgZ
	7ZR19ee9gL5/bxGhD8rvEjSKneYjoeY/ieYe73YHrA2rNa8D406eMZrS3Sui1vXS
	lmUjYSX6gW2tiGKpdZcXheOUcc2t4Lh3jQRk0Xe3SjMG2os/A8UUJ1HVCJR5X6DF
	m417lvSzd65TOjpdectd5d9+++4GoIm5Ak4GGBzkvJymBDKgkSzfEBb+a/qteWl2
	SwFaDD4KMIWirOggyPMlPdcOGpagIqfJLAA==
X-ME-Sender: <xms:SBEpZ07mV0I-YW_nO_rlBYuuFVMKjpg3sjq009KJfqM2sEb4Y6OmOg>
    <xme:SBEpZ14_NXSJ684Dq1xhdNMecTJs3_gc4g4Uxg4kZ-_bLcr67Bwy_6FztFDL_D9pa
    o6LqlH3zmchtSk>
X-ME-Received: <xmr:SBEpZzfHojfhnQGYadQKilmBhynoGfzE_W3KZu0vweGCYPIm8doJ0M0X8q2i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguohhnrghlugdrhhhunh
    htvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhm
    rgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepughonhgrlhgurdhhuhhnthgvrhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepgh
    hnrghulhhtsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:SBEpZ5Ko4Yx3Qe3eEryE_xnPCsFYHBW5X05KoIBqnslsxY_hYOW_rw>
    <xmx:SBEpZ4K2Y_jvhXoshyXmMVdocJBHS1Y0B2ErQpxgQNDaiaC2sazAgA>
    <xmx:SBEpZ6wdLNVRY3mlIWkPxn0XDM_tmTYziXkYYkTVDTNCJis5nOZl1g>
    <xmx:SBEpZ8K7nlsXf22aCy2zGyMHfC83T41Z0FYXOzEAcMCQ2Gzw2qjXNw>
    <xmx:SBEpZ3_rfYJmqRHnZ_zsvzY8CLIbLdWCYLWDZgfZoK8G0BLpxb0WKDoT>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 13:24:08 -0500 (EST)
Date: Mon, 4 Nov 2024 20:24:06 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, donald.hunter@redhat.com,
	gnault@redhat.com
Subject: Re: [PATCH net-next v1 2/2] netlink: specs: Add a spec for FIB rule
 management
Message-ID: <ZykRRvZ-lvfEz_EG@shredder>
References: <20241104165352.19696-1-donald.hunter@gmail.com>
 <20241104165352.19696-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104165352.19696-3-donald.hunter@gmail.com>

On Mon, Nov 04, 2024 at 04:53:52PM +0000, Donald Hunter wrote:
> Add a YNL spec for FIB rules:
> 
> ./tools/net/ynl/cli.py \
>     --spec Documentation/netlink/specs/rt_rule.yaml \
>     --dump getrule --json '{"family": 2}'
> 
> [{'action': 'to-tbl',
>   'dst-len': 0,
>   'family': 2,
>   'flags': 0,
>   'protocol': 2,
>   'src-len': 0,
>   'suppress-prefixlen': '0xffffffff',
>   'table': 255,
>   'tos': 0},
>   ... ]
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

[...]

> +attribute-sets:
> +  -
> +    name: fib-rule-attrs
> +    attributes:
> +      -
> +        name: dst
> +        type: u32
> +      -
> +        name: src
> +        type: u32
> +      -
> +        name: iifname
> +        type: string
> +      -
> +        name: goto
> +        type: u32
> +      -
> +        name: unused2
> +        type: pad
> +      -
> +        name: priority
> +        type: u32
> +      -
> +        name: unused3
> +        type: pad
> +      -
> +        name: unused4
> +        type: pad
> +      -
> +        name: unused5
> +        type: pad
> +      -
> +        name: fwmark
> +        type: u32
> +        display-hint: hex
> +      -
> +        name: flow
> +        type: u32
> +      -
> +        name: tun-id
> +        type: u64
> +      -
> +        name: suppress-ifgroup
> +        type: u32
> +      -
> +        name: suppress-prefixlen
> +        type: u32
> +        display-hint: hex
> +      -
> +        name: table
> +        type: u32
> +      -
> +        name: fwmask
> +        type: u32
> +        display-hint: hex
> +      -
> +        name: oifname
> +        type: string
> +      -
> +        name: pad
> +        type: pad
> +      -
> +        name: l3mdev
> +        type: u8
> +      -
> +        name: uid-range
> +        type: binary
> +        struct: fib-rule-uid-range
> +      -
> +        name: protocol
> +        type: u8
> +      -
> +        name: ip-proto
> +        type: u8
> +      -
> +        name: sport-range
> +        type: binary
> +        struct: fib-rule-port-range
> +      -
> +        name: dport-range
> +        type: binary
> +        struct: fib-rule-port-range

Donald,

We added a new DSCP attribute in the last release. Can you please
include it in the spec? Tested the following diff [1].

Thanks!

[1]
diff --git a/Documentation/netlink/specs/rt_rule.yaml b/Documentation/netlink/specs/rt_rule.yaml
index 736bcdb25738..8d1a594e851d 100644
--- a/Documentation/netlink/specs/rt_rule.yaml
+++ b/Documentation/netlink/specs/rt_rule.yaml
@@ -169,6 +169,9 @@ attribute-sets:
         name: dport-range
         type: binary
         struct: fib-rule-port-range
+      -
+        name: dscp
+        type: u8
 
 operations:
   enum-model: directional
@@ -199,6 +202,7 @@ operations:
             - ip-proto
             - sport-range
             - dport-range
+            - dscp
     -
       name: newrule-ntf
       doc: Notify a rule creation

