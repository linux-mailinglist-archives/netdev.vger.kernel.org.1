Return-Path: <netdev+bounces-288337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDktHaU5B2ottwIAu9opvQ
	(envelope-from <netdev+bounces-288337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:20:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F875520C0
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BFE830FC550
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B548BD44;
	Fri, 15 May 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="YLNaK1W6"
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0FB48BD52;
	Fri, 15 May 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857890; cv=none; b=gG66oRxbBHKMtFtyz3BOwbu4w1mM6xQjZEXKNFB2dm8uZTjyZPo/C18Q34Xr441xI3jCSM7YAg+Cq5PCEHSuUQo5MMagWyEh3Fcjv1IKTHZAQI2LvFdxi7MErIXNj7poKObuf/w/OORB/OLBq3dTNCWmZTBJLpp2ZkhaA+7902Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857890; c=relaxed/simple;
	bh=NIu0Ci9yasRCP6TqXm6xmiCeZw9UVbaW4PiVBp7uO7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJkSsMkwPi5Yh1Mq3bnxOARomcIp595gtg7dC0gv7XHrp5Ma1rTHliZFQK52iOkZ9u3oL69MoaGEK9iI6oO9r86CVEcW+olUkXV3wDATZGNqg+kLy50R62+Nb5VbxAj8G0CXS1DULvPT818WIFK4urjAKK2CRp/GA3TOS/hPRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=YLNaK1W6; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gH9dQ6XPhz95xn;
	Fri, 15 May 2026 17:11:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778857882;
	bh=NIu0Ci9yasRCP6TqXm6xmiCeZw9UVbaW4PiVBp7uO7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YLNaK1W6EX0lbqQ0svrpyEPc5gnn45q0dbG9NRiC/P44oyI5nAODrYMwb/LsoFxhA
	 vrTmaQM8XMjZ5pjJnNh31EPOLtw+pV1NcmsySgsBJHJct9Wh1JiqI7MvyJ9VVT242h
	 5YglWAC5Co5YNo93tEeBWs53KO/vjS9C+qE4FKDVd2E909NzwfHaXaDANKrurj1yWx
	 hGDHKWgG0K8V2weB/Iy5SZwVewH3apzrxJ95b6vLZJqiIFqBNQpcLPK7/AGGXj1qHm
	 ml/LpVlOO85O1PJUXcQRgwCNMGSf3qDc0Eg82G1ZGR0GCGyPcDbKXDurxdGe+On710
	 f0tWfdZtWP+NQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gH9cK5JYpz7x5l;
	Fri, 15 May 2026 17:10:25 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gH9cK0RHlz8sZP;
	Fri, 15 May 2026 17:10:24 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id DC6685F9AF;
	Fri, 15 May 2026 17:10:23 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info>
Date: Fri, 15 May 2026 17:10:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: davem@davemloft.net, kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260514172340.1515042-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177885782428.2534966.14422332395235472068@mxe9fb.netcup.net>
X-NC-CID: 4VsUA7rWd/0eRMFI7BCFOcLGq7AXiqg1amkvb0XAv6M6XP83ZBw=
X-Rspamd-Queue-Id: D5F875520C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lists.linux.dev,linux-foundation.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288337-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fedoraproject.org:url,leemhuis.info:mid,leemhuis.info:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

[+Linus +Greg]

On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:
> 
>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14
> 
> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c00282:
> 
>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)

It seems this PR sadly came too late for this week's net PR to mainline
that was merged yesterday.

TWIMC, from my point of view, it would be great if we somehow could
still get the changes from this PR or at least the btmtk fix it
contains[1] to mainline this week before -rc4, as it is fixing a
regression known since 2026-04-24 that at least five people encountered
with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btmtk:
validate WMT event SKB length before struct access") [006b9943b982 in
-next].

Another reason: Greg a few hours ago backported the culprit for the
regression to v7.0.7, v6.18.30, and v6.12.88, which led to a bunch of
other reports coming in[3]. Greg could, of course, revert it, but
usually he prefers to just merge the fix. But of course the fix must
first hit mainline (or at least -next) -- and that might only happen
next Thursday, as there usually is only one net PR per week. Luiz even
wanted to "expedite a PR to have it fixed asap"[4], but that didn't work
out afaics, hence this mail.

Ciao, Thorsten

[1] btmtk: accept too short WMT FUNC_CTRL events – also available here:
https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/

[2]
https://lore.kernel.org/lkml/20260508173121.27526-1-mikhail.v.gavrilov@gmail.com/
https://lore.kernel.org/lkml/f652d5d9841a9b7c100dd19ee97c86099f580724.camel@gmail.com/
https://bugzilla.kernel.org/show_bug.cgi?id=221511
https://lore.kernel.org/lkml/20260514-bluetooh-fix-mt7922-v1-1-499c878af1e5@zohomail.in/
https://lore.kernel.org/lkml/20260514-bluetooh-fix-mt7922-v1-1-499c878af1e5@zohomail.in/
(+ one more report in a Fedora kernel chatroom)

[3]
https://bugzilla.kernel.org/show_bug.cgi?id=221521
https://lore.kernel.org/lkml/51b55b97-615b-4f5e-b454-df646f4058b7@augustwikerfors.se/
+ a four more people in
https://bodhi.fedoraproject.org/updates/FEDORA-2026-6b173ffc2a#comment-4646633

[4]
https://lore.kernel.org/all/CABBYNZ+FfhYtU2=J-V4pjKf_vKV=Y5LhVhxS_epKe-qaUUt8_g@mail.gmail.com/


> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - af_bluetooth: serialize accept_q access
>  - L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
>  - btmtk: accept too short WMT FUNC_CTRL events
>  - hci_qca: Convert timeout from jiffies to ms
> 
> ----------------------------------------------------------------
> Jiexun Wang (1):
>       Bluetooth: serialize accept_q access
> 
> Michael Bommarito (1):
>       Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
> 
> Pauli Virtanen (1):
>       Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
> 
> Shuai Zhang (1):
>       Bluetooth: hci_qca: Convert timeout from jiffies to ms
> 
>  drivers/bluetooth/btmtk.c         |  4 +-
>  drivers/bluetooth/hci_qca.c       | 33 +++++++--------
>  include/net/bluetooth/bluetooth.h |  1 +
>  net/bluetooth/af_bluetooth.c      | 87 +++++++++++++++++++++++++++++----------
>  net/bluetooth/l2cap_core.c        |  2 +-
>  5 files changed, 85 insertions(+), 42 deletions(-)
> 


