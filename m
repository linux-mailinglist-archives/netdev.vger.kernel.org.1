Return-Path: <netdev+bounces-116269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200DF949B7F
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437791C22A4E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F3E173345;
	Tue,  6 Aug 2024 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="JDXTHnKO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyqm8j8E"
X-Original-To: netdev@vger.kernel.org
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52A17166E
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984217; cv=none; b=ITfA9i3ULZI9npwvggFo0u+78awVkjoVKASmGv/16n2pZqbvwfVIly+wlQl9vVxiEOtiQWFqq/RH2ITI1uPN/y6tFcupw3sRb84QDKSofJxukbsOcDW6QxehgHBhEeAU7UjvbFITICoiKOuhflyQyDpzSbFKWaUHSriAjGhu7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984217; c=relaxed/simple;
	bh=J40VHMMWkh0kl6kCZd8XyxdOnEYP0+e9B8ZAIHuW8rA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=Lq71oPsh6MSFbGL8IvrpAkJuF6DhcQmVU28Kj6Lvd7MedI+OrsHccSFMqGJJkYTSs+5z+Wvg4wurQqXHBwn+KrRDNfYfRteHCGDT9PEcX5aw4siZT6YgP04IE2B9XHWhX9eMCSAhxguEYJXDpA82UoWFhasji5q/wHLP6gj83BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=JDXTHnKO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hyqm8j8E; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailflow.nyi.internal (Postfix) with ESMTP id DE0CD201012;
	Tue,  6 Aug 2024 18:43:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 06 Aug 2024 18:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1722984213; x=1722987813; bh=IuiNZDC4U1bd3gBKrqgwl
	Txcb4/QWZaEfGNRECGqOyQ=; b=JDXTHnKOyxwCXnsogrYDFwk5HOp/yD3sJSr6F
	NSVVlaPuFp3tJtDOiZ2A7PRAdKetUe35Ol3gByaPOPBk7gXl0QPv1NVmK0QXBHGP
	rvYQAVg1g8MwHj7WLwPOTki7yOpzIvehRvzbHa6no9J7M9MJ8jrhnOa880mBaIaW
	MBbza2B7kNDO9DGj9DYDHuI76Ye73scvONYYogRyMExrNUNR6NBuRm+Rsd8Xlz6T
	inU63q0Us0Y1XbY43RodQGxvL144lEwUIXwNkACxeWyXWkvNBT2/FcM9qs5O8mRf
	zx22G1fZpw56vPyEXmnUmM7Mx1ut3oqBdMF1R81Q0/oGNvCEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722984213; x=1722987813; bh=IuiNZDC4U1bd3gBKrqgwlTxcb4/Q
	WZaEfGNRECGqOyQ=; b=hyqm8j8EwMUBxzFq69nKybB0giG2yaqllyxmUfhUsquG
	K7h/xHj6Ng3PaKtASMah4UFcNyH5Nz+MsvTKQ7RW1AvJh+Dm0eOdef2uaYz93mhA
	H+iFy3EMwPKOEzwnETdfb+2AryUD0K8ElO1QUhRHA19AXXzyzyrW3xYED7907NrB
	rOLLBQToKorSZVtc6dm01ITBEhvRTR/KUmmaYsCUdrDk+R1I2lpY4V2Go9izcZk+
	PSsDjnggWRVFg3lCQrFy3rv3iZzvY6kjcFjB32zvRJMjeoOD03aHukp1VA/HCHJD
	Zr2FALpi14whuxuyXbBX1zBlVSU6a5fkIzhA0L4e6g==
X-ME-Sender: <xms:FaeyZlCpv_z5EJZ6-CKIT0bUvxM7QpyTHkPOPI6GFagoCufhug5FFA>
    <xme:FaeyZjgTb43H7hHU4Up7gBxEB54BOilhUQn7WTS2JrImgNF3ePoBQJ_tFu0aPGjmr
    unWh3zyTpalmhSqSso>
X-ME-Received: <xmr:FaeyZgnXj0IlFpwg5_LcdI7gMF_s3umfyFGSIkCs6EmvBAsy7WvtnzESy3bMDe-hgw_SJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicu
    gghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtth
    gvrhhnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteef
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvh
    esjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:FaeyZvwQoOEkzpxX-gD7z_NYutGylRJMUxL3sPWVjKemWlZH0-MyHQ>
    <xmx:FaeyZqRn_UxuiqwjxWoNboWM3UnAKOq5FJxcLk0qivhA6GOkqTehzw>
    <xmx:FaeyZiYVGbcLZNqLS96RhEkjXKtRj9wjRZFDEgJmexlRjNppx9UbOg>
    <xmx:FaeyZrS2U2Qcp-sRLbFBcNrrdJorQH1tb3L1tIulaI7E5alH7NzRNA>
    <xmx:FaeyZoBPa3xmm9Y4U_-NZgnGPlWGDC95e0uE61ERcdiCQF--MvqJX6kp>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 18:43:33 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 3661B9FCB8; Tue,  6 Aug 2024 15:43:32 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 356739FBA2;
	Tue,  6 Aug 2024 15:43:32 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Simon Horman <horms@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    Nathan Chancellor <nathan@kernel.org>,
    Nick Desaulniers <ndesaulniers@google.com>,
    Bill Wendling <morbo@google.com>,
    Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
    llvm@lists.linux.dev
Subject: Re: [PATCH net-next] bonding: Pass string literal as format argument
 of alloc_ordered_workqueue()
In-reply-to: <20240806-bonding-fmt-v1-1-e75027e45775@kernel.org>
References: <20240806-bonding-fmt-v1-1-e75027e45775@kernel.org>
Comments: In-reply-to Simon Horman <horms@kernel.org>
   message dated "Tue, 06 Aug 2024 10:56:52 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3239344.1722984212.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Aug 2024 15:43:32 -0700
Message-ID: <3239345.1722984212@famine>

Simon Horman <horms@kernel.org> wrote:

>Recently I noticed that both gcc-14 and clang-18 report that passing
>a non-string literal as the format argument of alloc_ordered_workqueue
>is potentially insecure.
>
>F.e. clang-18 says:
>
>.../bond_main.c:6384:37: warning: format string is not a string literal (=
potentially insecure) [-Wformat-security]
> 6384 |         bond->wq =3D alloc_ordered_workqueue(bond_dev->name, WQ_M=
EM_RECLAIM);
>      |                                            ^~~~~~~~~~~~~~
>.../workqueue.h:524:18: note: expanded from macro 'alloc_ordered_workqueu=
e'
>  524 |         alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags),=
 1, ##args)
>      |                         ^~~
>.../bond_main.c:6384:37: note: treat the string as an argument to avoid t=
his
> 6384 |         bond->wq =3D alloc_ordered_workqueue(bond_dev->name, WQ_M=
EM_RECLAIM);
>      |                                            ^
>      |                                            "%s",
>..../workqueue.h:524:18: note: expanded from macro 'alloc_ordered_workque=
ue'
>  524 |         alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags),=
 1, ##args)
>      |                         ^
>
>Perhaps it is always the case where the contents of bond_dev->name is
>safe to pass as the format argument. That is, in my understanding, it
>never contains any format escape sequences.
>
>But, it seems better to be safe than sorry. And, as a bonus, compiler
>output becomes less verbose by addressing this issue as suggested by
>clang-18.
>
>Signed-off-by: Simon Horman <horms@kernel.org>

Acked-by: Jay Vosburgh <jv@jvosburgh.net>

>---
> drivers/net/bonding/bond_main.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index 1cd92c12e782..f9633a6f8571 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -6338,7 +6338,8 @@ static int bond_init(struct net_device *bond_dev)
> =

> 	netdev_dbg(bond_dev, "Begin bond_init\n");
> =

>-	bond->wq =3D alloc_ordered_workqueue(bond_dev->name, WQ_MEM_RECLAIM);
>+	bond->wq =3D alloc_ordered_workqueue("%s", WQ_MEM_RECLAIM,
>+					   bond_dev->name);
> 	if (!bond->wq)
> 		return -ENOMEM;
> =

>

