Return-Path: <netdev+bounces-185107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26AA988C1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BB63A4033
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480426D4DA;
	Wed, 23 Apr 2025 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NAszZ++H"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB02D613
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408530; cv=none; b=uyDY7C3w10k79ARfUgBL3SJbXlm97hd0zHhTQska4vUeO/x/r0inx8t7UQyAYTydbxMUtbbGjBZCcATqf/NISFOZlU1acTNq2UI6lNr5jof/5pgwn/P/v3ti5cVJ5//2UUZhnB6KFdMp+o/hmgQMi+NOw0yrL5JNH4eE/zo67/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408530; c=relaxed/simple;
	bh=VUPg3bhuJzoixVUf9RA2/3LNeJxMosdnsdvYxq4lsyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbMuY/EAg74xMkAEH02mLgnbvDgYZ0sKpXDr8s4lu/lqFMalVZMUOZ6mktl2RYRUr+aNJcVzt2gYyz9CPN/+XK7nI5VgIyvoP1K9N/aXSrsrweptpYSbXVTrrCrs7mh7VVYxVqDh73oJDT+4hc4G32tQHdeWAomCkMh7f/OVc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NAszZ++H; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 774511140243;
	Wed, 23 Apr 2025 07:42:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 23 Apr 2025 07:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745408527; x=1745494927; bh=19RyRxh26IWFroPv+t2vQombPFFwkLMUiJq
	Aa6moRYM=; b=NAszZ++Hqc7xzAcOB0HheKkAv5RXAVs6T3R7ySCrMqdUOGUgjP2
	0NANAi8XyRo71i0hynNC/iUCAPyF9Ec6HSchiVNua2hYWh4RlHO6+koccjIO+0U0
	2Jr3S590dX0kiQvihbmJqH+VOBZPiIicDOdkcw2voW3WUkTPUFKCbhRhR4VhG23x
	5gxCvVOZz73NhP5xymjyjeoZ+HNdbYEaO+1E6xOzQgb8UU1WF6KoRDT8AdnznlrX
	lqy8Ju8paQ6/MibwFYJjUgSMJPGvusD1RIfkm9+fu3FwrVpdkEStBMzj0ZNfxb0r
	KZPnPK10Qw9WV3LkSxOByUTy/pQK1wit03g==
X-ME-Sender: <xms:D9IIaAdO3xX9XiGYgXNX6YEmXaY-gSuCRZm1gusA16aqmfRXKGcs3g>
    <xme:D9IIaCOfmDjoFzGbUrZ9Duen6cmj8OHgw5fHTA3BKWuiiKoZc58pwaNo9pXARw6y6
    0Vi_c4OdS-FlrI>
X-ME-Received: <xmr:D9IIaBiMmT3LjRC0vJoiwAy8hNWA_VbqSZMAskOr-70qu0QxAc6Nth8BJHz9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhimhhonhhksggrsg
    ihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:D9IIaF-iQWlNNsad8EuC5_i-QwUsnFLE3_BTgXxv83cGMmwFV31q1A>
    <xmx:D9IIaMtAqxbKaiXh_-XAj0WfF1UdfrmSZ6EAvacn11G7Ev1Mx-VKIg>
    <xmx:D9IIaMGUK8n1RqLvs5QB__T2PdnqemRtSq9a28dylOubN3XSFNqh8g>
    <xmx:D9IIaLNNvcGn9PBRe5hCqYiQoyP3ktFiUnBWJrj479LmEBgN39tmEw>
    <xmx:D9IIaJNXM4fGf0-22hqnJGhIs4v2x1Ssi5EdBAXtKDWihPtF5HFKdsRB>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 07:42:06 -0400 (EDT)
Date: Wed, 23 Apr 2025 14:42:03 +0300
From: Ido Schimmel <idosch@idosch.org>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: query on EAPOL multicast packet with linux bridge interface
Message-ID: <aAjSCwwuRpI8GdB7@shredder>
References: <CAEFUPH1Erfh9YUctVDHxL8TWsiVfs+Fr8aJLtrjiKECbiGTxHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEFUPH1Erfh9YUctVDHxL8TWsiVfs+Fr8aJLtrjiKECbiGTxHQ@mail.gmail.com>

On Tue, Apr 22, 2025 at 06:42:58PM -0700, SIMON BABY wrote:
> Hello,
> 
> I have a difficulty with making EAPOL packet forwarding with the Linux
> bridge interface.
> 
>  I have configured the group_fwd_mask parameter with the below value.
> 
>  echo 8 > /sys/class/net/br0/bridge/group_fwd_mask
> 
> I still could not see the EAPOL packets being forwarded  from the
> linux bridge interface . However I can see the EAPOL packets are
> forwarded if I use it as a regular interface.
> 
> Do we have any more settings?

What do you mean by "linux bridge interface"? The bridge device itself
or a bridge port? Also, what is "regular interface"?

The following script [1] seems to work fine for me:

EAPOL packets on h2 without group_fwd_mask: 0
EAPOL packets on h2 with group_fwd_mask: 1

Can you adjust it to show the problem you are referring to?

Thanks

[1]
#!/bin/bash

# Setup
#
for ns in h1 h2 br; do
	ip netns add $ns
	ip -n $ns link set dev lo up
done

ip -n h1 link add name veth0 type veth peer name veth1 netns br
ip -n h2 link add name veth2 type veth peer name veth3 netns br

ip -n h1 link set dev veth0 up
ip -n h2 link set dev veth2 up

ip -n br link add name br0 up type bridge
ip -n br link set dev veth1 up master br0
ip -n br link set dev veth3 up master br0

tc -n h2 qdisc add dev veth2 clsact
tc -n h2 filter add dev veth2 ingress pref 1 proto all \
	flower dst_mac 01:80:c2:00:00:03 action pass

# Without group_fwd_mask
#
ip netns exec h1 mausezahn veth0 -a own -b 01:80:c2:00:00:03 -c 1 -q
sleep 1
pkt=$(tc -n h2 -s -j -p filter show dev veth2 ingress | \
	jq ".[] | select(.options.handle == 1) | .options.actions[0].stats.packets")

echo "EAPOL packets on h2 without group_fwd_mask: $pkt"

# With group_fwd_mask
#
ip -n br link set dev br0 type bridge group_fwd_mask 0x0008
ip netns exec h1 mausezahn veth0 -a own -b 01:80:c2:00:00:03 -c 1 -q
sleep 1
pkt=$(tc -n h2 -s -j -p filter show dev veth2 ingress | \
	jq ".[] | select(.options.handle == 1) | .options.actions[0].stats.packets")
echo "EAPOL packets on h2 with group_fwd_mask: $pkt"

# Cleanup
#
for ns in h1 h2 br; do
	ip netns del $ns
done

