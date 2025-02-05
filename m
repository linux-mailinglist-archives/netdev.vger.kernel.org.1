Return-Path: <netdev+bounces-163175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1659A297ED
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6537318870BE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863661FC7F9;
	Wed,  5 Feb 2025 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXI8jDyz"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA31DDC2E
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777741; cv=none; b=IFjAkv/LYFsV8M0+nj5ayprEOeFkjyTalkbvV2I6f0au0+UV6Nqf/ZWSzl7XtPBiewgdtkfy5HcKsgOTPdeC9b5M3IrbwKGkTYVdJGr3+oP66ygzuCh69M92h8mibHFCfykg3ldJ0yOLpJywJv+rZeiak68zlYUxI5kPKx4GKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777741; c=relaxed/simple;
	bh=1MWoRg5t72EEoZQoeULR1gql2L5PlTz0JTIEbJlUGRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHwXkW3kFfcieqjHFkSodwA/qOqfCYyzZ2k+qllL51/tHuV54YH24VMq0NutzGiz1ie9OYXtvdqEBrw0828ZUibIy7HMhJjbnsqs4JPX/BLLYHPSHsUe97KNii21NPPEDzKhTJ22WB3jxkROpKHNJ6DWrK9ZI0gKNJHnM9/K+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXI8jDyz; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C248A2540196;
	Wed,  5 Feb 2025 12:48:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Feb 2025 12:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738777738; x=1738864138; bh=ZQJH3Vgzpez4pytmAYWHVpi708BSsvjDUOy
	VGmyJR/0=; b=cXI8jDyzT9KXRChegvtDSwGFvK7fN+K3S5sEeKvkbz5LmgDW1da
	PvtclhVYWO7ymggBTRoEZ4fyG9azuLmHZ08BZrotv4kQFZdP5YvKBdASxZ5X2UPO
	qcizLEnTYZaAbbUG45pJCc+pO+ybHYTWVD1lus1m8220wCyRXM9Wq8/8+x++e8j2
	eNt7sbqcZhyfDHR1HHNPctSccI20pV/I7gM7psBdtObSiMSl4onV6PtUxlP5CVoy
	K090QKWPusM8NvecrXX0IvjweUOBIUAzubp7ozzvitQJqJm3ohKoF+imCfl51ePZ
	qeAe1VUlbk+/AIOovMukQgOD+WpyE8EZrFA==
X-ME-Sender: <xms:iqSjZ_Xdh5yI4iaTHXZ3vVf1S0Pd0jBmCNBCMhSiaN-M4UvYZox_DA>
    <xme:iqSjZ3m7FRPZSTWfYeAGi4bwKj3XlrEA80DXzMEq5kHa7_SauTKCPIrHILhvp9APf
    3TFl-g1jvSx6NQ>
X-ME-Received: <xmr:iqSjZ7bgm18nZaCAQDkrjIGbJ1XBwuS_sgISsGpGP8BUFph_a2XpwybGfRrj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrgiiohhrsegslhgrtg
    hkfigrlhhlrdhorhhgpdhrtghpthhtohepiihnshgtnhgthhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohep
    nhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iqSjZ6Wd7QFUJdD5i8ygjENu5-9gDrDUTqSSnzjzz4uh8yw-iiupvA>
    <xmx:iqSjZ5khLvTTmvw4ht7XoT0N1fouvHj571KITO8esguK_Qi6tjwBhQ>
    <xmx:iqSjZ3dgxpGLgyKp82YbZ8g8D7C3o0AknEcIMPVx8TbKUTwD5rbORg>
    <xmx:iqSjZzGOc94UjgkT16BNrl-SDE-13_P-_r-34IFRx1Lx4kXB8JX4XQ>
    <xmx:iqSjZ_UVOUk2gRJLVK0PCHwpF9foGq69t0_vPfMB2r5T5ijJCCj2AbLE>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 12:48:57 -0500 (EST)
Date: Wed, 5 Feb 2025 19:48:55 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ted Chen <znscnchen@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] vxlan: vxlan_rcv(): Update comment to inlucde
 ipv6
Message-ID: <Z6OkhzUHMPuSD6YM@shredder>
References: <20250205114448.113966-1-znscnchen@gmail.com>
 <7fcca70c-9bfe-4fd7-b82d-e21f765b8b87@blackwall.org>
 <Z6NcWfVbqDJJ4c11@t-dallas>
 <e5373a02-959b-4609-8a3f-7e25c69d97b8@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5373a02-959b-4609-8a3f-7e25c69d97b8@blackwall.org>

On Wed, Feb 05, 2025 at 02:48:36PM +0200, Nikolay Aleksandrov wrote:
> On 2/5/25 14:40, Ted Chen wrote:
> > On Wed, Feb 05, 2025 at 02:12:50PM +0200, Nikolay Aleksandrov wrote:
> >> On 2/5/25 13:44, Ted Chen wrote:
> >>> Update the comment to indicate that both net/ipv4/udp.c and net/ipv6/udp.c
> >>> invoke vxlan_rcv() to process packets.
> >>>
> >>> The comment aligns with that for vxlan_err_lookup().
> >>>
> >>> Cc: Ido Schimmel <idosch@idosch.org>
> >>> Signed-off-by: Ted Chen <znscnchen@gmail.com>
> >>> ---
> >>>  drivers/net/vxlan/vxlan_core.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> >>> index 5ef40ac816cc..8bdf91d1fdfe 100644
> >>> --- a/drivers/net/vxlan/vxlan_core.c
> >>> +++ b/drivers/net/vxlan/vxlan_core.c
> >>> @@ -1684,7 +1684,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
> >>>  	return err <= 1;
> >>>  }
> >>>  
> >>> -/* Callback from net/ipv4/udp.c to receive packets */
> >>> +/* Callback from net/ipv{4,6}/udp.c to receive packets */
> >>>  static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
> >>>  {
> >>>  	struct vxlan_vni_node *vninode = NULL;
> >>
> >> Your subject has a typo
> >> s/inlucde/include
> > Oops. Sorry for that.
> >  
> >> IMO these comments are unnecessary, encap_rcv callers are trivial to find.
> > I'm fine with either way. No comment is better than a wrong comment.
> > Please let me know if I need to send a new version to correct the subject or
> > remove the comments for both vxlan_rcv() and vxlan_err_lookup().
> > 
> 
> Up to you, I don't have a strong preference. You have to wait 24 hours
> before posting another version anyway, so you have time to decide. :)

Looks like nobody will miss these comments, so I think they can be
safely removed in v2 :)

