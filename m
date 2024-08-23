Return-Path: <netdev+bounces-121520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0B695D7DB
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA05A2821EC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429AB1C6F72;
	Fri, 23 Aug 2024 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="bgLgYUcW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F0dT6d+M"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42B1C174A
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445205; cv=none; b=n6A2IzS/Yw4Q1/RwXBSY9gcm2PurplHF0ekkpqJb08Qg0Q1FTOYrgglxOPkzwSsLk0wOy8cXl64r/JJuYS7vnL/0mYoa5LjEVvv2sSdgZB3egCUbio+7IzcNDYetD1tmOwvYCsoJ/tjluu0a8vLslEXbfPPDFANZbYwbm1DCcac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445205; c=relaxed/simple;
	bh=jUtlnbpi9yVdSZiNQsiPoZgq1ZUxFpsKB2ZxQCsl7fI=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=XLIZAEeuP2jFbXITLc4dGVe1mE4WfaNoGusI/ItgvgXTFmAfJoZBP+82wratuPRLU8FG5xIqiwD+9Mq1Bw+x/sUjcjOo+dbPLV8Hf4Ejo8xbnWzCpNGWmZP9VkCig/mQcrDdFn8Hz/zLEwniRcLX5RWDxYo3VL1nJ++6XUkxaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=bgLgYUcW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F0dT6d+M; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DE36A11506D1;
	Fri, 23 Aug 2024 16:33:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 Aug 2024 16:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1724445201; x=1724531601; bh=KxnSWFCK7OfAn9pfRV8hY
	oKI8ExPYFota+B4VN+wQdU=; b=bgLgYUcWFkJN+Zplc4Qdx95kumcVQjRGRXNXO
	KfivsNiXZaaXqbKV7qhusZ+XGPoTsmgjR6R2ae2nUH6RXJU29c205agnQyOd/RwP
	ssvbSUAfOg4ETCHKfaPSLoRmfzXkVKO6J1v6QcNWw0hEZ4hFeLeCp5XmpmkbvIYO
	qtk5+OIOTuto2h3HSF51BksieVHcCktHMpYmfsTZowULx8J+Elm3LOpGzBE7gH0M
	NCfTiiQkrTjg/ccjqVS4n+JU7PcieKLaLsxCCGvqj7ONHFn3GcYrKf0jNy/OH8D8
	I7zPWr857tcNyQc8ed6XlHG2s3vFzRBurk8V4j+/fu5t4edUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724445201; x=1724531601; bh=KxnSWFCK7OfAn9pfRV8hYoKI8ExP
	YFota+B4VN+wQdU=; b=F0dT6d+Md8VYuUeKQp6Ou6Qv/UNz6Hqv2TuVsGjUZy4k
	JppwI8bbzBxYcPMk01lKOfgARDkn14YkO74nYbtq8h6+kgpiLGqq9St8CuxEXMif
	mHfN5d9yXXsBWDha0MJISDa1yCqnin/bUxF7/UEZUAwQ30v3LkioqOWcMIomzdoG
	qcBvtxjLGCu/mT3aUU3X5uvlT3NV/0/dWRJmCEezHmwcfXdD06BtG9fFo3ai5L7L
	1LqLjCt5Njr6PmFiOif9ZqiKfiI75C1wDk08ujo85dX+eZd3RyFw2+9dMp1kJ5jS
	M31RiRjGyjkhRm98zxvXvmtAgAj7wL+RzpmL/zcA2g==
X-ME-Sender: <xms:EfLIZlvZ_DX_1JaD_BQ3olGa8h6sNH8KF_Aqx6i6bGzGZihQ5ZRrwA>
    <xme:EfLIZudpyrkxCbJ7a_1LooDDUhTLaMKW8xvTjiNLiDm153BDqWO28Z7PoQtk_mPkj
    Rf3PR1bH_3uLq-ZQYI>
X-ME-Received: <xmr:EfLIZoz5qOAPocB5u070WXTl1XVQZwd3nJ6m5eLC_WZy8kuPoEAmRhGTUamooMJASP6XFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredt
    vdenucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrd
    hnvghtqeenucggtffrrghtthgvrhhnpeeifedvleefleejveethfefieduueeivdefieev
    leffuddvveeftdehffffteefffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthht
    ohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvg
    hmlhhofhhtrdhnvghtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegrnhguhiesghhrvgihhhhouhhsvgdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghgrlhesnhhvihguihgrrdgtohhmpdhrtghpth
    htohepjhhirghnsgholhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhnrhho
    sehnvhhiughirgdrtghomhdprhgtphhtthhopehsrggvvggumhesnhhvihguihgrrdgtoh
    hm
X-ME-Proxy: <xmx:EfLIZsN0GTJQOMppJBulu2_0SdMauSkRAztRVblUrE850YdRQizO9w>
    <xmx:EfLIZl-txS1AO7m0cxxKPvwKBlehibCMVpIirqlGM09WL1ITmubsRQ>
    <xmx:EfLIZsXHaM354elk_U9Medl801E1DswAupgRrHync5dxLcfi184BhA>
    <xmx:EfLIZmeeUQusWA_1AsNclrkbMPKVu9T_Utf_9l6BY8IuvL-zgCMPWQ>
    <xmx:EfLIZoUGTpAjwJ0neQxkmzsKPGKe9AaywXmalNRsv0UH5vQ7jBwIV9sB>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 16:33:21 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 164099FBF6; Fri, 23 Aug 2024 13:33:20 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 12FF79FBC2;
	Fri, 23 Aug 2024 13:33:20 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jianbo Liu <jianbol@nvidia.com>
cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
    pabeni@redhat.com, edumazet@google.com, andy@greyhouse.net,
    saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com,
    liuhangbin@gmail.com, tariqt@nvidia.com
Subject: Re: [PATCH net V6 0/3] Fixes for IPsec over bonding
In-reply-to: <20240823031056.110999-1-jianbol@nvidia.com>
References: <20240823031056.110999-1-jianbol@nvidia.com>
Comments: In-reply-to Jianbo Liu <jianbol@nvidia.com>
   message dated "Fri, 23 Aug 2024 06:10:53 +0300."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <194956.1724445200.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Aug 2024 13:33:20 -0700
Message-ID: <194957.1724445200@famine>

Jianbo Liu <jianbol@nvidia.com> wrote:

>Hi,
>
>This patchset provides bug fixes for IPsec over bonding driver.
>
>It adds the missing xdo_dev_state_free API, and fixes "scheduling while
>atomic" by using mutex lock instead.
>
>Series generated against:
>commit c07ff8592d57 ("netem: fix return value if duplicate enqueue fails"=
)
>
>Thanks!
>Jianbo

	I am not sufficiently familiar with the innards of IPsec to
comment on whether or not those aspects are correct, but the the other
changes look good to me.

	For the series:

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

	-J

>V6
>- Add netdev_hold/netdev_put to prevent real_dev from being freed for
>  bond_ipsec_add_sa, bond_ipsec_del_sa and bond_ipsec_free_sa.
>
>V5:
>- Rebased.
>- Removed state deletion/free in bond_ipsec_add_sa_all() added before,
>  as real_dev is not set to NULL in Nikolay's patch. =

>
>V4:
>- Add to all patches: Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>.
>- Update commit message in patch 1 (Jakub).
>
>V3:
>- Add RCU read lock/unlock for bond_ipsec_add_sa, bond_ipsec_del_sa and b=
ond_ipsec_free_sa.
>
>V2:
>- Rebased on top of latest net branch.
>- Squashed patch #2 into #1 per Hangbin comment.
>- Addressed Hangbin's comments.
>- Patch #3 (was #4): Addressed comments by Paolo.
>
>Jianbo Liu (3):
>  bonding: implement xdo_dev_state_free and call it after deletion
>  bonding: extract the use of real_device into local variable
>  bonding: change ipsec_lock from spin lock to mutex
>
> drivers/net/bonding/bond_main.c | 159 +++++++++++++++++++++-----------
> include/net/bonding.h           |   2 +-
> 2 files changed, 106 insertions(+), 55 deletions(-)
>
>-- =

>2.21.0
>

---
	-Jay Vosburgh, jv@jvosburgh.net

