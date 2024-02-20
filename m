Return-Path: <netdev+bounces-73383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C71285C3AF
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 19:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9811C21D60
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 18:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5FA77A01;
	Tue, 20 Feb 2024 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="NtPGukj/"
X-Original-To: netdev@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C443669D01
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454444; cv=none; b=hbSsPu3yDC5W4C6g2fVjGmW/8lsmiw1MKc4liLRcEc7yYSAsZ8jCOU3GxFvPeupV6ktyDdkZTAssBGoXPHzJVqWDm81lf4Sd8qq3sxNbcXFazSixKzHNfuvlmCiSvHFG22TL0hTO2lpV3xe2CphIatIeCmDbjPP4WQUPHYs77QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454444; c=relaxed/simple;
	bh=KM9+4FhHbHX+pS0ZI/qGWFokcPU4isB+jXFDR0HQI0Q=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ezkM70uYh11GONvdoOnaENkZXDQizwrLcXPTsSxT7xuIIC4S1yaZCIuvma7IBgUFcyxQ/QDOUD0cc4fkPY5GcX71/tvH8Zc6K4xSwcTpeuR4BRiDSC8kIr7OwlYJUOyQb8nYJUW0gfzmdmsQXVIwItSrWe3ugpTaCIfkUE9DEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=fail (0-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=NtPGukj/ reason="key not found in DNS"; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 3011 invoked by uid 988); 20 Feb 2024 18:33:55 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Tue, 20 Feb 2024 19:33:55 +0100
Message-ID: <15ee0cc7-9252-466b-8ce7-5225d605dde8@david-bauer.net>
Date: Tue, 20 Feb 2024 19:33:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: David Bauer <mail@david-bauer.net>
To: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org
Subject: VxLAN learning creating broadcast FDB entry
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.999491) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.089491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from;
	bh=KM9+4FhHbHX+pS0ZI/qGWFokcPU4isB+jXFDR0HQI0Q=;
	b=NtPGukj/NYeJqrUyK9YwJweWuKWhbAdCbwOMyf/qVNBRKyXIvWCCiHC5XlMV1iXgdxcsGppT+l
	+uui0hR+vuYeDLoLIh1PnLN2HoCvscYnKWI1Uw63JwLi9U4siTQNxTVLXSViJxFvnW6uWffQDqiP
	45KWqtiwt9GBNXPAade/2PROuFldyD/hcYx44KeZCF6YHqJBMkVjEp2EAIGboJFeYDwQgcT5QaNO
	c4jtUbjHTPXWTcMtIARgtf4tSx7qy0nVWGwqdgTse1VyIiQ0oejdjIvUFgpIKX0LciXhpd1dhjMh
	kZoQHgkuQY0RABar5gUQR/mULCydvaN394KYDCJ60VFNfOite0PXFNzmq9bRRc19+6d4vQghYKMv
	jgoMXPeMtSvlzrCEsjE/bxMwQhxKAXjhONFi529Cf/xDwG+vWwmGoA6P8OmvI/8di1jQpjMIlaP5
	pTxizq4hKGOqmIyOETV+nQiLLzoILIEKjFF5JpHREEBhv27cZdb+dK4CGbni9sNu7bqCvLjg079A
	rLp8+x5go7tomE1ss9gUUwF2osGBAJu1a+to45aIuVX1nTwOmnExISLjZhRzQ4ho8GPAsQQROmYB
	eeN7t1QtzdClgwZMK84o2AwUpGMRj0MFGPjUS8nnhmUJ/ltCm+z5NS3xZub8kCZFe/3NKkKuRHXG
	4=

Hi,

we are using a VxLAN overlay Network to encapsulate batman-adv Layer 2 
Routing. This distance-vector protocol relies on originator messages 
broadcasted to all adjacent nodes in a fixed interval.

Over the course of the last couple weeks, I've discovered the nodes of 
this network to lose connection to all adjacent nodes except for one, 
which retained connectivity to all the others.

So there's a Node A which has connection to nodes [B,C,D] but [B,C,D] 
have no connection to each other, despite being in the same Layer 2 
network which contains the Layer2 Domain encapsulated in VxLAN.

After some digging, I've found out the VxLAN forwarding database on 
nodes [B,C,D] contains an entry for the broadcast address of Node A 
while Node A does not contain this entry:

$ bridge fdb show dev vx_mesh_other | grep dst
00:00:00:00:00:00 dst ff02::15c via eth0 self permanent
72:de:3c:0b:30:5c dst fe80::70de:3cff:fe0b:305c via eth0 self
66:e8:61:a3:e9:ec dst fe80::64e8:61ff:fea3:e9ec via eth0 self
ff:ff:ff:ff:ff:ff dst fe80::dc12:d5ff:fe33:e194 via eth0 self
fa:64:ce:3e:7b:24 dst fe80::f864:ceff:fe3e:7b24 via eth0 self
[...]

I've looked into the VxLAN code and discovered the snooping code creates 
FDB entries regardless whether the source-address read is a multicast 
address.

When reading the specification in RFC7348, chapter 4 suggests

 > Here, the association of VM's MAC to VTEP's IP address
 > is discovered via source-address learning.  Multicast
 > is used for carrying unknown destination, broadcast,
 > and multicast frames.

I understand this as multicast addresses should not be learned. However, 
by sending a VxLAN frame which contains the broadcast address as the 
encapsulated source-address to a Linux machine, the Kernel creates an 
entry for the broadcast address and the IPv6 source-address the VxLAN 
packet was encapsulated in.

This subsequently breaks broadcast operation within the VxLAN with all 
broadcast traffic being directed to a single node. So a node within the 
overlay network can break said network this way.

Is this behavior of the Linux kernel intended and in accordance with the 
specification or shall we avoid learning group Ethernet addresses in the 
FDB?

I've applied a patch which avoids learning such addresses in vxlan_snoop 
and it mitigates this behavior for me. Shall i send such a patch 
upstream? [0][1]

I see vxlan_fdb_update_create already disallows creating such an entry, 
but only if NLM_F_REPLACE is set, which it is not in the call-path from 
vxlan_snoop.

[0] https://github.com/freifunk-gluon/gluon/issues/3191
[1] https://github.com/freifunk-gluon/gluon/pull/3192

Best
David

