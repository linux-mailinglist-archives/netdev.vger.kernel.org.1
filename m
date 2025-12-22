Return-Path: <netdev+bounces-245727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D0CD6430
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 14:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 016B9307E4D0
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06A32AAB0;
	Mon, 22 Dec 2025 13:54:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396A2FE591
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766411669; cv=none; b=fzRNvEjOXLTYytRzGd5tYY/eyxEtTDOfeHKV8p8Li1iMXQhVxlNwHeBTs183DOGUd4RnqWTdWsnbBl9okDY1Z0/z3kYXG5DOcxKtl6aHzifeHM0GiVMhKbVPVk0CQNsW1dWRzf0oia8H/9Nmpn64WH6EXbNce9kXdSldkrTqpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766411669; c=relaxed/simple;
	bh=j7JwmdGuNwXd1c/LzYJR6g3+ykDa8PgTKoYX1S+/DWw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dg8Amgasc0+FSae7o4AjzYCLHBte//RqH71s5ySeCrKOhLMM4IS/+UnmUZKSJzhmbcjUXqYPxphEYSPAg+VeTfX44Obi+riHYaWwbOkIE+LLQT3uLrv+yPR1kTgCkNTHnYE75oz/n+BlzbsBSBj7TgeZrN7jifXrBOo56AsmVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz3t1766411647tfa7386e6
X-QQ-Originating-IP: 7uKNygx0wYU14Cm3m22Yd94i+WQQjY6po+vdsAa018U=
Received: from smtpclient.apple ( [183.241.15.10])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Dec 2025 21:54:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10734455048497223007
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v3 1/4] net: bonding: use workqueue to make sure
 peer notify updated in lacp mode
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <aS2ecn0U6rlNHP0r@fedora>
Date: Mon, 22 Dec 2025 21:53:54 +0800
Cc: Jay Vosburgh <jv@jvosburgh.net>,
 netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Jason Xing <kerneljasonxing@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <54901B52-BB42-4C0F-AAFB-B04CED5C3257@bamaicloud.com>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-2-tonghao@bamaicloud.com> <aS08d1dOC2EOvz-U@fedora>
 <AACE3A98-C0C0-4B24-BC29-B8EC3A758D90@bamaicloud.com>
 <aS1ocogQc01owxSC@fedora>
 <7FEDE75E-551D-4B29-86A2-526AA3556CDC@bamaicloud.com>
 <aS2ecn0U6rlNHP0r@fedora>
To: Hangbin Liu <liuhangbin@gmail.com>,
 Jay Vosburgh <jv@jvosburgh.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N9Q2tJ4LIODSfkLVAZz/uCL3mIpomTvl4J6tdyfD3eqhOHYDrRimBhNW
	jF05me+gwPlNheGAgTg7OK2i285gDVVQvhYBjSmh4zGQxQvtz6DtqoDvbJ2lGVIaxMuWbAv
	57kY/2w6cCqoLiiGn8MPUtykx4iODk0GUKfe0fFzyjjt6bGBOZJStGiq9Es1d2YWmR1dzZF
	xOlcTYE7IBYRnD3IT013p7aa4Ol7EhnxhDWmdmJbFN+EZ0J9XgTM3BHz2HRODvmkxoNR2aZ
	oxjSJmvjdo5WrQZGJ/n4wvucJnuR8wfi8GVDokQjo+TOfKSpBX49gCWWUNWA1ZMPAXQ4Wxf
	ZZMfbUSgcGl3GncBSnBnBHT6v5TDG+I3yKBVumJax0q1e+QaEEvZz6vrGgUQwpbEGmvK8dg
	h7JARFaWs4B/lIwXrafVJ1IzHJxeJPgaOhabH8DVuzAvmtY0eQXJOdAIrXC9JONPMabTq5T
	CCIQplnIqguY9Zjz4jTYTWyjLL7sYelUrdFVs0GpeNJe3sVPcOuWLw3R8hAIO4tONCkAZQh
	QLjuAs50bySvaXZ7a6z/f+SzrWLYyrlB9OswoLbufNFwzbhwzmG+T1tRF8EoVBz8nL0jLL8
	LPipJBeLhURqEFNo8B/oM/eAI23aWiU8aIANZmPu6pT9SFtz8oeh6dpoZRZvYsso4BGzBRw
	ZKSDrQqZWB/7A+/05Ndc1fP6vO7OdYzD9fk9b95tE1tAAHC3Zz/c4h8vjAVW0QSMPTMnwro
	J369VljoICb6eC5n/1NUtTaOtOX791Xw+2ZyuyJWkeNQKGUE+GgY1cpxrCYUdzyJtz2v9QA
	7brcJGm1v8Q5kmS7+mumHPVfHOhadFddE7xsfyBpvaRVbuYWLJuBgu6E4vC0jkNoei/GF/c
	dtXpB+auKpCImKEM3GOiEhiSEjnyg2ptWuQAnK5VyH43xGhg2ks+QBT1Ep+MAPVEqjugZZL
	55LMTOZxUiS3LVJNbTudRK5AdV6GFYBc9EibwAI1h3ILirae3Q8gVPJS9
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0



> On Dec 1, 2025, at 21:56, Hangbin Liu <liuhangbin@gmail.com> wrote:
>=20
> On Mon, Dec 01, 2025 at 07:01:23PM +0800, Tonghao Zhang wrote:
>>>>> I don=E2=80=99t see the benefit of moving NETDEV_NOTIFY_PEERS =
before NETDEV_BONDING_FAILOVER.
>>>>> Is there a specific reason or scenario where this ordering change =
is required?
>>>> No, to simplify the code, and use common peer notify reset =
function.
>>>=20
>>> bond_change_active_slave() is called under RTNL lock. We can use
>>> bond_peer_notify_reset() here. But I don't think there is a need to =
move
>>> NETDEV_NOTIFY_PEERS before NETDEV_BONDING_FAILOVER.
>> Is there a dependency relationship between NETDEV_NOTIFY_PEERS and =
NETDEV_BONDING_FAILOVER?
>> In vlan, macvlan, ipvlan netdev, NETDEV_NOTIFY_PEERS and =
NETDEV_BONDING_FAILOVER use the same action.
>> net/8021q/vlan.c
>> drivers/net/macvlan.c
>> drivers/net/ipvlan/ipvlan_main.c
>=20
> Quote from ad246c992bea ("ipv4, ipv6, bonding: Restore control over =
number of peer notifications")
>=20
> """
>    For backward compatibility, we should retain the module parameters =
and
>    sysfs attributes to control the number of peer notifications
>    (gratuitous ARPs and unsolicited NAs) sent after bonding failover.
> """
>=20
> In theory we should send notify after failover. The infiniband driver =
also
> has specific functions to handle NETDEV_BONDING_FAILOVER. I'm not sure =
if the
> miss-order affect it. Maybe Jay knows more.
Hi Jay,
any idea about the order NETDEV_NOTIFY_PEERS and =
NETDEV_BONDING_FAILOVER? It seems that there is no dependency between =
them in infiniband driver.

>=20
> Thanks
> Hangbin



