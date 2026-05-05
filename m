Return-Path: <netdev+bounces-284332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIVkJiDL+Wn3EAMAu9opvQ
	(envelope-from <netdev+bounces-284332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:49:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB014CBCD1
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3B2C305DEFC
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82B3401A30;
	Tue,  5 May 2026 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-darmstadt.de header.i=@tu-darmstadt.de header.b="VRYSxgak"
X-Original-To: netdev@vger.kernel.org
Received: from c2682.mx.srv.dfn.de (c2682.mx.srv.dfn.de [194.95.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E40E4014A4;
	Tue,  5 May 2026 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977238; cv=none; b=iK88Uqao6R+tF71cZ/g6tA0b7ruG36tUs2PDfwt95LlVTD2yls0HPFCORfYIK0ZWUgVV+Vpo5vJt8L/FGEpx+4dP9VPUccGoaLQkKqqfhfkG3bvTUCoMcdUenhrWLvqRlqtK49uWNl+Kv5nuAWGjFiLmej7WdS2l8tKPDB+VFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977238; c=relaxed/simple;
	bh=+2czFlzCh+SQgyKoPRClNsySUQVwrE9NfB5DFlDGPCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RBqfcX/BdyH5hxnl8iBElRTNHRcqzm57n4G8gFsYcIslwgcIoy1V6Zo0kzsz9tg9pQf1tzm+9XaqUNE884YhU9YlnVqEZLAUPr9SKLwzxPs4XRIGe1msZLJDsplgRL9sT68l5Kq64G2D2RJo6K1UCCGGMjQVsZJdJ//4ALOL48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-darmstadt.de; spf=pass smtp.mailfrom=tu-darmstadt.de; dkim=pass (1024-bit key) header.d=tu-darmstadt.de header.i=@tu-darmstadt.de header.b=VRYSxgak; arc=none smtp.client-ip=194.95.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-darmstadt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-darmstadt.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-darmstadt.de;
	 h=mime-version:content-transfer-encoding:content-type
	:content-type:content-language:accept-language:in-reply-to
	:references:message-id:date:date:subject:subject:from:from
	:received; s=s1; t=1777977233; x=1779791634; bh=+2czFlzCh+SQgyKo
	PRClNsySUQVwrE9NfB5DFlDGPCU=; b=VRYSxgakPQZ7Ysc5ZefAPTKLYpa00HGU
	kbiCY0z0W/CKt4r4Db/N9xK8V/YhMabDjz+zO8dnAjkmTMLHvr7E6KuVAx1SnENw
	9Xjukf0cvY5ifqbPKQg760dHS+dNAyCOUVgC58iFam9+BybdeTw9xpdUnCEQfTxN
	VRLe0ttC8k4=
Received: from mail-relay150.hrz.tu-darmstadt.de (mailout.hrz.tu-darmstadt.de [IPv6:2001:41b8:83f:1611::150])
	by c2682.mx.srv.dfn.de (Postfix) with ESMTPS id 95731289;
	Tue,  5 May 2026 12:33:53 +0200 (CEST)
Received: from TU-EX074.ads.tu-darmstadt.de (tu-ex074.ads.tu-darmstadt.de [IPv6:2001:41b8:815:404::8:74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.tu-darmstadt.de", Issuer "GEANT TLS RSA 1" (not verified))
	by mail-relay150.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4g8vxq5V5wz43hZ;
	Tue,  5 May 2026 12:33:51 +0200 (CEST)
From: "Baier, Markus" <markus.baier@tu-darmstadt.de>
To: "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "enelsonmoore@gmail.com"
	<enelsonmoore@gmail.com>, "linmq006@gmail.com" <linmq006@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: usb: asix: ax88772: re-add usbnet_link_change()
 in phylink callbacks
Thread-Topic: [PATCH net] net: usb: asix: ax88772: re-add usbnet_link_change()
 in phylink callbacks
Thread-Index: AQHc2YkltM5mqFPK80iXo0Hdlkli/7X+lsiAgACqzzc=
Date: Tue, 5 May 2026 10:33:50 +0000
Message-ID: <6e63dac58f044e158a4ffb63d9e73fdd@tu-darmstadt.de>
References: <20260501163941.107668-1-Markus.Baier@soslab.tu-darmstadt.de>,<177794760791.1391894.7472938774024727243.git-patchwork-notify@kernel.org>
In-Reply-To: <177794760791.1391894.7472938774024727243.git-patchwork-notify@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Header-TUDa: <c2ClD7SZAmloVwti6jYOuMAwlXHaiRM7bRSsQmbODRqzyy9RpgWUjvYBAE8ql2INDT9XtkFpHRJfxOjxINGyYVKA77bvXq7NoB.1777977233>
X-TUDa-Umlauf: 8
X-Rspamd-Queue-Id: EEB014CBCD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-darmstadt.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tu-darmstadt.de:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284332-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tu-darmstadt.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.baier@tu-darmstadt.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,netdevbpf];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,


for your information,=A0the current version of the patch goes a bit too far=
,
as using the "usbnet_link_change" function in this context.
called from the "mac_link_up" or "mac_link_down" functions, works but
is not ideal.

With Oleksij's help, I have since been able to create a new patch
that specifically enables or disables only the RX URB submission.
I will submit the new patch as v2 of the current patch later today
or tomorrow at the latest.
I have completed testing of the new patch, and the results were positive.

PS: Sorry that I sent the first email in HTML format

Best regards
Markus=20


Von: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org=
>
Gesendet: Dienstag, 5. Mai 2026 04:20:07
An: Baier, Markus
Cc: o.rempel@pengutronix.de; andrew+netdev@lunn.ch; davem@davemloft.net; ed=
umazet@google.com; kuba@kernel.org; pabeni@redhat.com; linux@armlinux.org.u=
k; enelsonmoore@gmail.com; linmq006@gmail.com; linux-usb@vger.kernel.org; n=
etdev@vger.kernel.org; linux-kernel@vger.kernel.org
Betreff: Re: [PATCH net] net: usb: asix: ax88772: re-add usbnet_link_change=
() in phylink callbacks
=A0  =20
Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,=A0 1 May 2026 18:39:41 +0200 you wrote:
> Commit e0bffe3e6894 ("net: asix: ax88772: migrate to phylink") replaced
> the asix_adjust_link() PHY callback with phylink's mac_link_up() and
> mac_link_down() handlers, but did not carry over the usbnet_link_change()
> notification that commit 805206e66fab ("net: asix: fix "can't send until
> first packet is send" issue") had added.
>=20
> As a result, the original symptom returns: when the link comes up,
> usbnet is never notified, so the RX URB submission stays dormant until
> some other event (e.g. a transmitted packet triggering the status
> endpoint interrupt) wakes it up.
>=20
> [...]

Here is the summary with links:
=A0 - [net] net: usb: asix: ax88772: re-add usbnet_link_change() in phylink=
 callbacks
=A0=A0=A0 https://git.kernel.org/netdev/net/c/36bdc0e815b4

You are awesome, thank you!
--=20
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


    =

