Return-Path: <netdev+bounces-236711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF402C3F392
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 10:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE1E188E95E
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D62305079;
	Fri,  7 Nov 2025 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="SYHfiDXB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cT6wAxxJ"
X-Original-To: netdev@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F750302155
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508450; cv=none; b=ggF9IKOwZ54M0vHjPLMEmVwecEV7rIjCDdqGxpcWzcNOjYPRG84tBqrB7pDcE+7HGDnHN92z62mha5fHylyWS1p+i4NtNN5CQGEDtCrXpbp5toegqNML+gDf4GeO/A3J2PXKU/6OXan5qI6XuXbXd4oLm/uN/PxEhIify2l7lZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508450; c=relaxed/simple;
	bh=H4VZ7BRsQRxxEpebWYiW1yybA1vJj6bju9/Zs/aPnpw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=OfzCGjzHiTl23hBjJroOadCeQaB7jdqwjbihVQAVraiXWee3LqvV13hVh65wD5WdJDJVfasF83Z/8EdllBBRynfQqUa5q13s8jRljUcpDJX0zjHQNBtYQAQZe/ATYL3Ds83egWkTyJpn3G3hsyf6aFDwtBWvTGhPLDPg38T6R48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=SYHfiDXB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cT6wAxxJ; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id E22241300249;
	Fri,  7 Nov 2025 04:40:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 07 Nov 2025 04:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1762508446; x=1762515646; bh=OW+A6XfmGnrC5ViNjXF/T
	32WDBvQr2vz6kUkY023xH4=; b=SYHfiDXBYChnbemLuenJsuq1WAhcMJXAsqgsf
	odd8A5f03QHykRpwARRNRjRAMiBQMdqH7ccEcF31DJPB3tVdXRJKCPVN9U1+snWR
	k3761Sc/H/K0Ac64XWDtjofBMyBzVxliQgyoHtgANp2Y5XgDqV+8FrjsjuadQkcc
	Yl9qdpV9O1qy1QxmBzEa5EE+dTZlaDCugbgZewf+elPiDc4WWNc3S/Mwb+saSI/z
	VS6YbdZr7zTn+10nUcAk/N8vNZurPmzX0p6WgL7jIX++cIFPA5to2LruEf/Bm6Dl
	3l453yuAhuo9Y91i1NlEZPkkGQbfoKa8+/+DECj78WUNBh2Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762508446; x=1762515646; bh=OW+A6XfmGnrC5ViNjXF/T32WDBvQr2vz6kU
	kY023xH4=; b=cT6wAxxJlyuCCxqwaSTMEYcGSOf/4/xGjoc0FN5EOl5qKPW6NHo
	OZnSaExNBZ1wzq3ONe5dce68lb0KwcWC4GtFypbOwpT8nsX3Rj04T3sLwhHPnBNX
	kGBlMJogsTqVr05teyRMHsZWARxD0QgKm3GBREpcDYQCn9ACzDNSd7iatWvm431f
	qgTFQ2U1vTO/4Z+OZcnVc9jzVjHENuWdMI7DMtcxEkE0ew0uslM/6cedlDMC7oCM
	Z/M8nBOIzDmNa/iNw9jUzSB+ZlS1Pk3XTqDmvBH8Hf7X8LbrDUT1nSBl0HjMKXcY
	Eok95UTjw8dPRjnaXukYhsa8ufnK+PKKLdg==
X-ME-Sender: <xms:nr4NaYxwi-RkgSKF7kkAQ-Trwr_klx9ktaMeFpnr_SlGZbrug3UXUg>
    <xme:nr4NabWu9U1WUC9tKzWfZ7k25rRu24QghajfMl_cw2e2kEQJxcjcqLm9Xne669UHG
    fhYvv1XVuOXua_FhTSy7798o9PiqS3w88PBKl7XE2x2IGot1Lr-CHlJ>
X-ME-Received: <xmr:nr4NaQi_-oQrTyWewFtR1AKyXWQGhmQw1J4zIdqafKmk9FUzjRCsZsQemxsjj1VHHtXTfbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghfofggtgfgfffksehtqhertdertddvnecuhfhrohhmpeflrgihucgg
    ohhssghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeeiveelffduvdevfedtheffffetfeff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvse
    hjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehnihgtohhlrghsrdguihgthhhtvghlseeifihinhgurdgtoh
    hmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthho
    pehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehprg
    gsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nr4NaTCkrWZrl1WkrXPmiTyXQvckK1L17Nc7k6ebfDbc2431bfv-vw>
    <xmx:nr4NaeuW8N1NeVJ8Wjbh1W-GFn4FxtC3oA0wCXcv7Xy8niydsEK9Yg>
    <xmx:nr4NafdhY3LzyneVU6GqtUU-M9hQ7kbVDQul8SPJBbhceAeP0ve0jQ>
    <xmx:nr4Nab_wywLjEzEhZXm3VgS3ygSnIXxAnHd8TK04kpsTxSO-gwvNYg>
    <xmx:nr4NaR7rvUk1k8nVpPLlHA3sf--KADsrMEQFx6rOmXp9Hy3KuBDq34C4>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 04:40:45 -0500 (EST)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id F3C741C04E6; Fri,  7 Nov 2025 01:40:42 -0800 (PST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id F1BAE1C01BD;
	Fri,  7 Nov 2025 10:40:42 +0100 (CET)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
cc: "David S . Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Eric Dumazet <edumazet@google.com>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Subject: Re: [PATCH net] bonding: fix mii_status when slave is down
In-reply-to: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>
References: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>
Comments: In-reply-to Nicolas Dichtel <nicolas.dichtel@6wind.com>
   message dated "Thu, 06 Nov 2025 19:02:52 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <398690.1762508442.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Nov 2025 10:40:42 +0100
Message-ID: <398691.1762508442@vermin>

Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

>netif_carrier_ok() doesn't check if the slave is up. Before the below
>commit, netif_running() was also checked.
>
>Fixes: 23a6037ce76c ("bonding: Remove support for use_carrier")
>Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>


>---
> drivers/net/bonding/bond_main.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index e95e593cd12d..5abef8a3b775 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2120,7 +2120,7 @@ int bond_enslave(struct net_device *bond_dev, struc=
t net_device *slave_dev,
> 	/* check for initial state */
> 	new_slave->link =3D BOND_LINK_NOCHANGE;
> 	if (bond->params.miimon) {
>-		if (netif_carrier_ok(slave_dev)) {
>+		if (netif_running(slave_dev) && netif_carrier_ok(slave_dev)) {
> 			if (bond->params.updelay) {
> 				bond_set_slave_link_state(new_slave,
> 							  BOND_LINK_BACK,
>@@ -2665,7 +2665,8 @@ static int bond_miimon_inspect(struct bonding *bond=
)
> 	bond_for_each_slave_rcu(bond, slave, iter) {
> 		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
> =

>-		link_state =3D netif_carrier_ok(slave->dev);
>+		link_state =3D netif_running(slave->dev) &&
>+			     netif_carrier_ok(slave->dev);
> =

> 		switch (slave->link) {
> 		case BOND_LINK_UP:
>-- =

>2.47.1
>

