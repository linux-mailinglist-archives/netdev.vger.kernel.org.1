Return-Path: <netdev+bounces-152253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A81BC9F33A8
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779BB7A36DA
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53566136337;
	Mon, 16 Dec 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BpVqLhdN"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13C41C94
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360639; cv=none; b=Sk8Hi6r9gIEVeUXvojB1bxRbOxB3z0BadeTqC91i4vhXbvkxPD+yGHXKC9ghEoJ942pj92txkFlkR7oBQG25kZegF04g4FmRFWx0AQ4ZlLsUI4i7gNCO7cShSVB8MrHuSrOVEgitdwh0vTXgFeahxR6jZ6UNqLAKdYWW34y0C6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360639; c=relaxed/simple;
	bh=cwiK/y8/WJtEzcxQAUkIdUBoMoOHoPHdLjpAoSveGxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxzLNIjO4ysUUAwtVzJkXtUdOeuRA9j34rhd3rajQ3HSxNx2z/8KXXhOlKivSmDuXoHvMY1a5g2Rs+5xwKjbPwNtDXP7X3KVq2TG51wMgKnJcZPVRYlpKxibOulBh53mu/MtyEuF9kIhQgPp+Jlh2Tarl7fF6WOAWvXw20rQUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BpVqLhdN; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 192841140100;
	Mon, 16 Dec 2024 09:50:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 16 Dec 2024 09:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734360635; x=1734447035; bh=Gv6SqJK97OVNAKbYdZBrC0Wq2JBVgTDjSCU
	mbwctFxc=; b=BpVqLhdNEyQjGc/M/6bzl27sOFjgA8AvIsx+0qEYe3r0M9iIx6C
	1HyskibFF993iCYsmMgqmBRrFVaa8YiwBQZKEPG6TfS8TJXRer4cVUdr15M5ETj/
	5Cf0k24nMjmAAHzrI7zBbnB/5XWbb111uzOkagXQWdq/Nt6cEvEOshn0IWyHC93p
	WvUqqlZMZ733mMKTeKGOmEK6FcfjoCNZMB7cPeSGLJMmgGIhXJ590ZOdQSQQm+lC
	0DG6zEt6L2AtFPDmbbbjnuI2JOlTngTISGiNTMuo2rmQEy6Eeq2Kvp9jjPwMmIaE
	mg0ge3T023qbplXZ62U9zBplcsRcNmegxyQ==
X-ME-Sender: <xms:Oz5gZ82fAeCjKMHb7eFIQMQGJCmrDyCUkx8dnaXNbKj9Ndun3L0JiA>
    <xme:Oz5gZ3FUNTVkI-uPO29_bn0OczBzqamaos9fiAohhHtxxuW4kj7DlRO9KXJed0VbS
    QsRvoSVfYdPuVc>
X-ME-Received: <xmr:Oz5gZ07SHl_JFalIpTJ-xQwPiNKXd4FuaqeGCypIaWtk4oGR37R9VCuiIs-B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    pedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitghhrggvlhdrtghhrg
    hnsegsrhhorggutghomhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhho
    fhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhh
    grthdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
    pdhrtghpthhtohepphgrvhgrnhdrtghhvggssghisegsrhhorggutghomhdrtghomhdprh
    gtphhtthhopegrnhgurhgvfidrghhoshhpohgurghrvghksegsrhhorggutghomhdrtgho
    mh
X-ME-Proxy: <xmx:Oz5gZ10L3fmuxjtwhXCd1BVTlrnnkw61-4qgJxIckZ49iZV-8mbTLQ>
    <xmx:Oz5gZ_EoU1dyVo5h8vyn-mYn4FYsAdLMUUvATF3FW57YvOEuRrKrlw>
    <xmx:Oz5gZ--QQyJ-OVT75zrQDU7Bri_4Q6o4i51v-cAFOYK1TWGqk9c_ZQ>
    <xmx:Oz5gZ0kB7Zu4IynG6t7o6I88u8BzvNuV1oEfie96CDS5uYdmAFxpaw>
    <xmx:Oz5gZ2C9b04xJn63cUSpIfUW9-EP-iljFDcwTMOzVZgP_436Yht_3oYT>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 09:50:34 -0500 (EST)
Date: Mon, 16 Dec 2024 16:50:32 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next 2/6] bnxt_en: Do not allow ethtool -m on an
 untrusted VF
Message-ID: <Z2A-OMk82UKOjJzH@shredder>
References: <20241215205943.2341612-1-michael.chan@broadcom.com>
 <20241215205943.2341612-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215205943.2341612-3-michael.chan@broadcom.com>

On Sun, Dec 15, 2024 at 12:59:39PM -0800, Michael Chan wrote:
> @@ -4480,6 +4486,9 @@ static int bnxt_get_module_eeprom_by_page(struct net_device *dev,
>  	struct bnxt *bp = netdev_priv(dev);
>  	int rc;
>  
> +	if (BNXT_VF(bp) && !BNXT_VF_IS_TRUSTED(bp))
> +		return -EPERM;
> +

Nit: You can use 'extack' here to help users understand why the
operation failed.

>  	rc = bnxt_get_module_status(bp, extack);
>  	if (rc)
>  		return rc;

