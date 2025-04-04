Return-Path: <netdev+bounces-179399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3325A7C596
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 23:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297031892896
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 21:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706C20ADEE;
	Fri,  4 Apr 2025 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="Zx22RLV2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ca4viI1r"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3A14831E;
	Fri,  4 Apr 2025 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802606; cv=none; b=rXYwZhsddjCuGqW6sVkKH/SNi0zvjoZu6B21XKFiyccudBzn31p5+EveDbWdm6zwc26pRX+Pycu9BF0iSnDhk8qAxcroJB4gtGaNqgbmLpnA1ZraWbMlViQEKkvA6wKPnwPbb3d5YXN6OHg0N0JzX5rn4Ra9TJoV5KNJlgOLRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802606; c=relaxed/simple;
	bh=7Lo9G4Lthaj273tygco16fhikNEuDUblSDsgmDMYI/c=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=f9tNO8Hw3lPEIadnfYt7i+p3v/gguWfwol3iUAI6qVjrj/m+j1b0O21+Ik7Za5vDG9qR95EGfiJJIvpWWIEt9qLzQOlglMmVG6eUJ1+VhCvpKdjaPma96YK+ucM69oUeITtoWjpNuTyOPTMWp5L8qEBAd87/7azNE6YOpU2xr4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=Zx22RLV2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ca4viI1r; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B9A8413801B9;
	Fri,  4 Apr 2025 17:36:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 04 Apr 2025 17:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1743802601; x=1743889001; bh=zo0au+QCDLF6L5wqgH97BSzonpWv3jI/
	9rhAoEpMT28=; b=Zx22RLV2GjBKAnTdv4H/xSHoqIjs9emxJuyfdEH3lhabmgMJ
	0kC6IGv5GHI0jWv+k54mAUZOAp+et9V/JTAs+t6EKEq5OuMmO+El7HvwHYdszl2+
	4LA3viNZVXTRWXeY5r/URwC9s/SFm/iUE57y3d8vTYX4WU5r4LrW3WxHFhhTZZ43
	MyZ8FgAobLbCzu46wvyUue0K+rnrFvZ4XjzEt53CuO2LsjM8YX+F5likkBOM5a+r
	fReQ8q0qHnI2nBa+pmGMKAFh53+Ko7GZNoSJ3+Z6RYT9gO/tJHRO5bM/bE9BSuei
	yW//2nFrp/TkJ3SjqKcsMMLmg3UqsDd0uF8ktQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743802601; x=
	1743889001; bh=zo0au+QCDLF6L5wqgH97BSzonpWv3jI/9rhAoEpMT28=; b=c
	a4viI1rASpuq0Kc9ZrTiHEm4oXi8x2mzEkf8E4F/1HgBZTVZg5ukLzfSI4IVvf78
	wxSQ1a2c6BkeiRqcP2yxQWDsKx7CKwBLRagHMJmP1yp0FVibR75NB2ANtKqFN5lO
	6555/nnzBiIZh5aoI04CGTR41O0Le5boyS+6L0ekCn/i5H5OF2Qzti+IMC6nMzZX
	Bk3z/rnkMQgE/KBzOMkhb3yunuKg2WKzdH0agH9w/a2Su8IyqCBl6ph+YJeIRoKh
	rByjnMYpY0x4STtZx5plT2T0AfsieMrmokD6SlGuYyQt3NY4+apPC79ZCLBPHOga
	JgkeTmCI2hLSaH5+D/ELw==
X-ME-Sender: <xms:6VDwZ9mUzbB1S40g0B9sCZXtXE7o0VzCa_UHFjXQty0o2_7B7seBRg>
    <xme:6VDwZ41yRakh4QFvQH8X3CEGPccE_OavKCY3WMRVJiXG7tRPxW-_YNvDqDhhxQy89
    fbX59I16Z-wKRXmmjE>
X-ME-Received: <xmr:6VDwZzrM2E5Ys0oac_HZvm91TnMUvLpmOMTTHbMhyl1ypY6YxeEQ2zsubLk92iayGfT77Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tdejnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepgeefgffhgffhhfejgfevkefhueekvefftefh
    gfdtuddtfeffueehleegleeiuefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgriihorhessghlrg
    gtkhifrghllhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhn
    vghtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhohhrmhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthho
    pegtrhgrthhiuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvg
    guhhgrthdrtghomh
X-ME-Proxy: <xmx:6VDwZ9l8JjDkh8cM8Y0lFVm8klmGBGVOjBwwg0xA8-vP_pm0YckaPg>
    <xmx:6VDwZ73i3ZZqmXoBIdQ-21sVf6-J1hFIa60ts5anh6qft7k5ehOStg>
    <xmx:6VDwZ8v0UQMDOpM51KUcmHXnjUvU8Hq8NNYInyLKtTIBGfdHssCX0g>
    <xmx:6VDwZ_UtlTORxvonBW_PnNWgvI3i5Ur79n0dPOOkM8yW2mgt64oEUQ>
    <xmx:6VDwZ8CoF1RNzg5vrNoPHVVsGYFZYtVtoDrrKN1weftDpO59xHtg78J0>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 17:36:40 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id C4F539FC7C; Fri,  4 Apr 2025 14:36:39 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id C403C9FC4F;
	Fri,  4 Apr 2025 14:36:39 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Hangbin Liu <liuhangbin@gmail.com>
cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: use permanent address for MAC swapping if device address is same
In-reply-to: <20250401090631.8103-1-liuhangbin@gmail.com>
References: <20250401090631.8103-1-liuhangbin@gmail.com>
Comments: In-reply-to Hangbin Liu <liuhangbin@gmail.com>
   message dated "Tue, 01 Apr 2025 09:06:31 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Apr 2025 14:36:39 -0700
Message-ID: <3383533.1743802599@famine>

Hangbin Liu <liuhangbin@gmail.com> wrote:

>Similar with a951bc1e6ba5 ("bonding: correct the MAC address for "follow"
>fail_over_mac policy"). The fail_over_mac follow mode requires the formerly
>active slave to swap MAC addresses with the newly active slave during
>failover. However, the slave's MAC address can be same under certain
>conditions:
>
>1) ip link set eth0 master bond0
>   bond0 adopts eth0's MAC address (MAC0).
>
>1) ip link set eth1 master bond0
>   eth1 is added as a backup with its own MAC (MAC1).
>
>3) ip link set eth0 nomaster
>   eth0 is released and restores its MAC (MAC0).
>   eth1 becomes the active slave, and bond0 assigns MAC0 to eth1.

	This step leaves both the bond+eth1 and the independent eth0
using the same MAC address.  There is a warning printed for this, and
allowing the duplicated MAC address assignment has been the behavior for
a very long time, and to my knowledge hasn't caused issues (I presume
because swapping interfaces in and out of a bond willy nilly doesn't
happen much outside of test cases).

[ pasting in Paolo's comment from the other thread ]

Paolo says:
>It was not immediately clear to me that the mac-dance in the code below
>happens only at failover time.

	"Failover" may be a misnomer here; the dance happens when the
active interface changes, which for this scenario occurs at either a
failover (link went down, etc) or when the active interface is removed
from the bond.

Paolo says:
>I second Jakub's doubt, I think it would be better to change eth0 mac
>address here (possibly to permanent eth1 mac, to preserve some consistency=
?)

	This would cause the MAC of the bond itself to change (for the
interface removal case at issue here), which is not the current behavior
for fail_over_mac=3Dfollow.  I'm not sure how often that's a dependency in
practice, but it would be a change of long-standing behavior.

Paolo says:
>Doing that in ndo_del_slave() should allow bonding to change the mac
>while still owning the old slave and avoid races with user-space.
>
>WDYT?

[ end of Paolo's comment ]

>4) ip link set eth0 master bond0
>   eth0 is re-added to bond0, but both eth0 and eth1 now have MAC0,
>   breaking the follow policy.
>
>To resolve this issue, we need to swap the new active slave=E2=80=99s perm=
anent
>MAC address with the old one. The new active slave then uses the old
>dev_addr, ensuring that it matches the bond address. After the fix:

	Which interface is the "new active" in this situation?  Adding
eth0 back into the bond should not cause a change of active, eth0 would
be added as a backup.

>5) ip link set bond0 type bond active_slave eth0
>   dev_addr is the same, swap old active eth1's MAC (MAC0) with eth0.
>   Swap new active eth0's permanent MAC (MAC0) to eth1.
>   MAC addresses remain unchanged.

	So this patch's change wouldn't actually resolve the MAC
conflict until a failover takes place?  I.e., if we only do step 4 but
not step 5 or 6, eth0 and eth1 will both have the same MAC address.  Am
I understanding correctly?

	-J

>6) ip link set bond0 type bond active_slave eth1
>   dev_addr is the same, swap the old active eth0's MAC (MAC0) with eth1.
>   Swap new active eth1's permanent MAC (MAC1) to eth0.
>   The MAC addresses are now correctly differentiated.
>
>Fixes: 3915c1e8634a ("bonding: Add "follow" option to fail_over_mac")
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>---
>v2: use memcmp directly instead of adding a redundant helper (Jakub Kicins=
ki)
>---
> drivers/net/bonding/bond_main.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_ma=
in.c
>index e45bba240cbc..1e343d8fafa0 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -1107,8 +1107,13 @@ static void bond_do_fail_over_mac(struct bonding *b=
ond,
> 			old_active =3D bond_get_old_active(bond, new_active);
>=20
> 		if (old_active) {
>-			bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
>-					  new_active->dev->addr_len);
>+			if (memcmp(old_active->dev->dev_addr, new_active->dev->dev_addr,
>+				   new_active->dev->addr_len) =3D=3D 0)
>+				bond_hw_addr_copy(tmp_mac, new_active->perm_hwaddr,
>+						  new_active->dev->addr_len);
>+			else
>+				bond_hw_addr_copy(tmp_mac, new_active->dev->dev_addr,
>+						  new_active->dev->addr_len);
> 			bond_hw_addr_copy(ss.__data,
> 					  old_active->dev->dev_addr,
> 					  old_active->dev->addr_len);
>--=20
>2.46.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net


