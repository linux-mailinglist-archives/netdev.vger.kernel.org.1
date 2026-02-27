Return-Path: <netdev+bounces-261659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOqdDYH2oGk8oQQAu9opvQ
	(envelope-from <netdev+bounces-261659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:42:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF091B1951
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FD25300D77C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3D28D8DB;
	Fri, 27 Feb 2026 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="idR/M650";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qsLyARwu"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CCE27E07E;
	Fri, 27 Feb 2026 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156540; cv=none; b=FDq68RXm9gLvt7bRxlehfgFGVi+z8amvoprHUDOr//7efvqbHxG4sMJf9W8aPuLvKEFXoLb6VKLB7FYnLLxJ7TXRGhpVqaDoBHswliFp2Ubof3l6RUXdNwtiwJfpN8aDB+1VpUHFT+2TNuNrJhnmlWlQM4vtNgYN5UZRm9TS1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156540; c=relaxed/simple;
	bh=MH1JbKo8U096w/4SFfWy4iZNR02/r/hu8EgOy22BlKk=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=FcrhLCon2UPneUquLAgjhgwZ3//1wZgvXTLJSE1q0V2Bt2//MS7Q+wFD3MH4Ph3N4f8i1ieAKQg/S6cWQ8YpDjshIT+73wfj16+YsEM9NaR5ivTGtgkCrbVLoeOmTQMpNRKZNgKBlpEMFqRNaQBruqNmAaYoep6RMq7Zcm1dSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=idR/M650; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qsLyARwu; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 719A87A0099;
	Thu, 26 Feb 2026 20:42:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Feb 2026 20:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772156535; x=1772242935; bh=S/8T4N0Phog8PIfQ8l0W0QujJkGhGj3J
	ItKbBB/XGc8=; b=idR/M650cmCb/Acd4RmNsTvOv3qnPVsI/GVTq8P812r2Es0h
	GWEqxFWLIIb6GjQx5d4hBkWHcHy4ib7Gq44qwvf0gADs67PWwKFh4g/djg3qGPo2
	MVc7S9fRM6yY6101dQu4Hyp7XleXtIApkuX3QHxmC1lmXSK+3Yo1N7sdOzvHnzuJ
	n97i5UAcm8JAv1Kx2duaVh4tuIHP78RY2ZsmzXqRmqSCxKRoRiUDWCS6rs9SPHJr
	uI+hwP623TspAw2UUpVRBR5/g5fx/NZx94yUO3z2G9CwiEmTH453FLw0OwKZ2TO3
	YI1qFE5x9noO2Lo176jwyD/2Vxy4jeLXgYfvhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772156535; x=
	1772242935; bh=S/8T4N0Phog8PIfQ8l0W0QujJkGhGj3JItKbBB/XGc8=; b=q
	sLyARwu1vOdFk/bbX3XRdtCG+hui5jIBf5SyKWOS1VMP8TINKrXhS/DdxqCvmlKg
	j2JWcNibba+T/KY2LWdO5Q1dVXLUoEYVEJOgVUinorwIgKLSlyYewl22ey9VxmLt
	tvWjqqMD7RX+oBJ0SfSHy8UUHafi4QrDENzq1yUpbSOKpXN7bDw59tnIanKBIpMb
	y2S7m2e100HboX9/cs3HbMdWI7YH0TdoP4mX21eEjoqpSALeZ5hSbJK/MX0VkOQ+
	dSubL4asiMpScAZyB8yinwPjavjk0mCR7IkqV3urKBPoSwlzMjWl5ACx3jBwScxu
	POiUO5kT2zCQ2a5hnbQIw==
X-ME-Sender: <xms:dvagaXq7UM6RSv7pYlFJ0yIB48WX6qt2IeKDiYE6-RwLX8w9swKrAQ>
    <xme:dvagaeW68Q5I82egxXZzlKbWsi7Aw0-NyLYX05YoxKxEJQpMtV7xRDCtXdDpZu9Ez
    r2a1k8asrpawA7uxFPyjRKEe1-ZZIeEDHAQpIap0mpcihHWAI1k0ZM>
X-ME-Received: <xmr:dvagaYE04OUvt4fR23K6pVlK1TVmJjMrUCgjPSh2x4jnQtm1Y39aLUBy5GJoUx2kQzqiaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertdejnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepgeefgffhgffhhfejgfevkefhueekvefftefhgfdtuddtfeffueehleegleeiuefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhgriihorhessghlrggtkhifrghllhdrohhrghdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhiuhhh
    rghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehmrghhvghshhgssehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhu
    nhhnrdgthhdprhgtphhtthhopehlihgrlhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:dvagaVA0VDIfNxUiRLPPFugt6870usuUHILOvxZA2VufL0G0JHTVcw>
    <xmx:dvagaaxzEXYBTnuaWrYbONWrzdZYTvcyBPjFbzrNouOwMyRCQm4H2w>
    <xmx:dvagabcPa-4YVtTKlA9KsJBTvFlsIeb-X8WA6wPO90nzpVsRA8f4Rg>
    <xmx:dvagafui0gFQdijlSAfUxBcevUrIC6brhzEVPE-N0c4r5R7rXVzHcw>
    <xmx:d_agaXSoz4SZuQdj4RKJqRmQIVVxCbQQqCNx1Alybdo5niG3fEMLw2Cg>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 20:42:14 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 99F159FCB1; Thu, 26 Feb 2026 17:42:13 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 98F5E9FC39;
	Thu, 26 Feb 2026 17:42:13 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Mahesh Bandewar <maheshb@google.com>, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCHv3 net 2/3] bonding: restructure ad_churn_machine
In-reply-to: <aaDq5vTsk8SW4bIA@fedora>
References: <20260226125331.28147-1-liuhangbin@gmail.com> <20260226125331.28147-3-liuhangbin@gmail.com> <941081.1772152606@famine> <aaDq5vTsk8SW4bIA@fedora>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Fri, 27 Feb 2026 00:52:54 +0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Feb 2026 17:42:13 -0800
Message-ID: <943602.1772156533@famine>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261659-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jvosburgh.net:email,jvosburgh.net:dkim,messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CBF091B1951
X-Rspamd-Action: no action

Hangbin Liu <liuhangbin@gmail.com> wrote:

>On Thu, Feb 26, 2026 at 04:36:46PM -0800, Jay Vosburgh wrote:
>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>>=20
>> >The current ad_churn_machine implementation only transitions the
>> >actor/partner churn state to churned or none after the churn timer expi=
res.
>> >However, IEEE 802.1AX-2014 specifies that a port should enter the none
>> >state immediately once the actor=E2=80=99s port state enters synchroniz=
ation.
>> >
>> >Another issue is that if the churn timer expires while the churn machin=
e is
>> >not in the monitor state (e.g. already in churn), the state may remain
>> >stuck indefinitely with no further transitions. This becomes visible in
>> >multi-aggregator scenarios. For example:
>> >
>> >Ports 1 and 2 are in aggregator 1 (active)
>> >Ports 3 and 4 are in aggregator 2 (backup)
>> >
>> >Ports 1 and 2 should be in none
>> >Ports 3 and 4 should be in churned
>> >
>> >If a failover occurs due to port 2 link down/up, aggregator 2 becomes a=
ctive.
>> >Under the current implementation, the resulting states may look like:
>> >
>> >agg 1 (backup): port 1 -> none, port 2 -> churned
>> >agg 2 (active): ports 3,4 keep in churned.
>> >
>> >The root cause is that ad_churn_machine() only clears the
>> >AD_PORT_CHURNED flag and starts a timer. When a churned port becomes ac=
tive,
>> >its RX state becomes AD_RX_CURRENT, preventing the churn flag from bein=
g set
>> >again, leaving no way to retrigger the timer. Fixing this solely in
>> >ad_rx_machine() is insufficient.
>> >
>> >This patch rewrites ad_churn_machine according to IEEE 802.1AX-2014
>> >(Figures 6-23 and 6-24), ensuring correct churn detection, state transi=
tions,
>> >and timer behavior. With new implementation, there is no need to set
>> >AD_PORT_CHURNED in ad_rx_machine().
>> >
>> >Fixes: 14c9551a32eb ("bonding: Implement port churn-machine (AD standar=
d 43.4.17).")
>> >Reported-by: Liang Li <liali@redhat.com>
>> >Tested-by: Liang Li <liali@redhat.com>
>> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>>=20
>> 	I missed this last time it was posted, but reading it now I
>> think the functional change looks good, but I question the usefulness of
>> including the 25 line ASCII art version of the state diagram.
>>=20
>> 	The standard is publicly available, so a comment saying that the
>> state machine logic conforms to IEEE 802.1AX-2014 figures 6-23 and 6-24
>> should be sufficient.  Anyone seriously checking the code against the
>> standard will need to read the relevant text, so they'll be looking it
>> up anyway.
>
>I added it here to help new readers and reviewers understand the logic
>quickly. If you think there=E2=80=99s no need to include it in the code, m=
aybe
>we can move it to the commit description?

	Personally, I'd leave it out, and just put a reference.

	The churn machine isn't that critical, even the standards
committee didn't like it and removed it from the 2020 edition of
802.1AX.

	Still, whatever we provide should work in accordance with the
2014 standard we're nominally conforming to, so functionally the patch
looks fine to me.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net


