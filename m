Return-Path: <netdev+bounces-109662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C41929724
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 10:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA42C1C20957
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887D6CA40;
	Sun,  7 Jul 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n4HtYaYW"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0528F6D
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720341337; cv=none; b=h9xc8UzKgGkJ86Z7M+qAePdFpy5/Cl60pRft0/GuUFmAYKSMVdbxTXTyefyWACFIBiYS2hm3sG2bYRka4ifUxKMov6mu/WjsHQ+ImKQcZRFHHq38Yqmh3EWfc00Fo5k1QW2kc2vqdK0QsYiWAkU7MiXyVDWaTOvEEtUwryuHrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720341337; c=relaxed/simple;
	bh=v+zFAlNFojbALv0EFpt75YVPNO90BZ6Z+pgpkTReU/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkU0JadW+4BhvVwoRO/gvyAbiBbzmIcloqxxixuFt4NiTcDWAQK5i8ketJmQNOkhfkY/xC4tB8gWZ6jDO79J3KrhpKI+Ef6cBQUou06V1WDvjtAX43CLFfUVgE8x4TxSODuS+dx8gki4C6H46KYed7KDOpqeFIl0/75EkniQTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n4HtYaYW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5D6A31140427;
	Sun,  7 Jul 2024 04:35:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 07 Jul 2024 04:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720341334; x=
	1720427734; bh=cwFZ7KjnCFXvCqJTtHeX7Vl8AAjM3nxrPY07G5A3hFI=; b=n
	4HtYaYWjm2wesfdyIRHTkn6XZNBrmv2B0mRbXBQVv5KhDNy2S3pSk7MNi1GSCTre
	KYiIV6cXaxdEfOPnwktZ9AY8FfoOC8rCIsyh3INCfZL+xVITNTuCOPIvcXC1kNp6
	B9s+54plC1C6fJGQV047sCVI4RYb2k5k7ju3Rje382BJgX/obDuw4BRvkosYrJH3
	YZFURIcHyy/Y435GPudkQLIsbG5q3t9Y7fMDgxpDZtZDUeBZRDvPlTDcY8ISpYrk
	z+Gt/G4Gy4COANWih7P+R2i9mQ3bifHW1pcNhqsInGwibmWAooB5AvdS4oSROd7F
	8QiF/+xwCfXO8q7eiBYPg==
X-ME-Sender: <xms:VVOKZq7LLT5rfju5S5nsQXxlaboL1kn0n-XMjSODJf7mZvbJBpvI-g>
    <xme:VVOKZj4p3I6ODs-MPCuOw3X5E2vDeILo6y3-CF-_FhFswqoDgOwoHw8X6cHny1cWj
    Tj2uMjopXRFX6U>
X-ME-Received: <xmr:VVOKZpebU2GEXKjccQEAwp78YhB0UtRQBuD6ZB0pa5A5N7EUy_4DCnsDHafx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepudelvdejjeehgfdvteehfeehteejjeefteejveeijefgueejffelffegkeff
    ueeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:VVOKZnJVejTIr_KrgVPmgDvB6wBiIpaF3N31YIXVZt_3B7eObRKzbQ>
    <xmx:VVOKZuKRNh5Ajp4T4DdtWHFMcdz4rbWgWBaq1URennS20ld7UAijxQ>
    <xmx:VVOKZozFi92vab4F2TMtXM6HZDCqLeJfv-AfarYR-QpVGRF_AjhmMA>
    <xmx:VVOKZiJ2rN9tUooRAwkeN80FmyPmDLtM-AF6ayGSKV8gEq1cc0Oiiw>
    <xmx:VlOKZq3QmsWVJTz8YtOQRLAm8nucriD_y5Yyvz04foH9rhRJLTeDQV3E>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jul 2024 04:35:33 -0400 (EDT)
Date: Sun, 7 Jul 2024 11:35:26 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Dan Merillat <git@dan.merillat.org>, Michal Kubecek <mkubecek@suse.cz>,
	netdev <netdev@vger.kernel.org>
Subject: Re: ethtool fails to read some QSFP+ modules.
Message-ID: <ZopTTqrHRekd8d8u@shredder.mtl.com>
References: <54b537c6-aca4-45be-9df0-53c80a046930@dan.merillat.org>
 <ZoJaoLq3sYQcsbDb@shredder.mtl.com>
 <ZoJdxmZ1HvmARmB1@shredder.mtl.com>
 <49bf6eca-9ad0-49a7-ac8d-d5104581f137@ans.pl>
 <8711f66b-9461-4e3c-8881-5bda2379b926@ans.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8711f66b-9461-4e3c-8881-5bda2379b926@ans.pl>

On Thu, Jul 04, 2024 at 05:27:49AM -0700, Krzysztof Olędzki wrote:
> On 03.07.2024 at 07:36, Krzysztof Olędzki wrote:
> > Good morning,
> > 
> > On 01.07.2024 at 00:41, Ido Schimmel wrote:
> >> Forgot to add Krzysztof :p
> >>
> >> On Mon, Jul 01, 2024 at 10:28:39AM +0300, Ido Schimmel wrote:
> >>> On Sun, Jun 30, 2024 at 01:27:07PM -0400, Dan Merillat wrote:
> >>>>
> >>>> I was testing an older Kaiam XQX2502 40G-LR4 and ethtool -m failed with netlink error.  It's treating a failure to read
> >>>> the optional page3 data as a hard failure.
> >>>>
> >>>> This patch allows ethtool to read qsfp modules that don't implement the voltage/temperature alarm data.
> >>>
> >>> Thanks for the report and the patch. Krzysztof Olędzki reported the same
> >>> issue earlier this year:
> >>> https://lore.kernel.org/netdev/9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl/
> >>>
> >>> Krzysztof, are you going to submit the ethtool and mlx4 patches?
> > 
> > Yes, and I apologize for the delay - I have been traveling with my family and was unable to get into it.
> > 
> > I should be able to work on the patches later this week, so please expect something from me around the weekend.
> > 
> >>>> From 3144fbfc08fbfb90ecda4848fc9356bde8933d4a Mon Sep 17 00:00:00 2001
> >>>> From: Dan Merillat <git@dan.eginity.com>
> >>>> Date: Sun, 30 Jun 2024 13:11:51 -0400
> >>>> Subject: [PATCH] Some qsfp modules do not support page 3
> >>>>
> >>>> Tested on an older Kaiam XQX2502 40G-LR4 module.
> >>>> ethtool -m aborts with netlink error due to page 3
> >>>> not existing on the module. Ignore the error and
> >>>> leave map->page_03h NULL.
> 
> BTW - the code change does what we have discussed, but I think the comment
> may be incorrect? Before we call nl_get_eeprom_page, there is a check to
> verify that Page 03h is present:
> 
>         /* Page 03h is only present when the module memory model is paged and
>          * not flat.
>          */
>         if (map->lower_memory[SFF8636_STATUS_2_OFFSET] &
>             SFF8636_STATUS_PAGE_3_PRESENT)
>                 return 0;
> 
> In this case, it seems to me that the failure can only be caused by either
> HW issues (NIC or SFP) *or* a bug in the driver. Assuming we want to provide
> some details in the code, maybe something like this may be better?
> 
> +	/* Page 03h is not available due to either HW issue or a bug
> +	 * in the driver. This is a non-fatal error and sff8636_dom_parse()
> +	 * handles this correctly.
> +	 */

Looks fine to me although I believe an error in this case will always be
returned because of a driver bug. Reading a page that does not exist
should not result in an error, but in the module returning Upper Page
00h. Yet to encounter a module that works in a different way. From
SFF-8636 Section 6.1:

"Writing the value of a non-supported page shall not be accepted by the
slave. The Page Select byte shall revert to 0h and read/write operations
shall be to Upper Page 00h. Because Upper Page 00h is read-only, this
scheme prevents the inadvertent corruption of module memory by a host
attempting to write to a non-supported location."

> 
> We were also discussing if printing a warning in such situation may make sense.
> As I was thinking about this more, I wonder if we can just use the same check
> in sff8636_show_dom() and if map->page_03h is NULL print for
>  "Alarm/warning flags implemented"
> something like:
>  "Failed (Page 03h access error, HW issue or kernel driver bug?)"
> 
> We would get it in addition to "netlink error: Invalid argument" that comes from:
> ./netlink/nlsock.c:             perror("netlink error");

I think it's better to print it in sff8636_memory_map_init_pages() as
that way the user can more easily understand the reason for "netlink
error: Invalid argument":

# ./ethtool -m swp13                                                                                                                                                                                                                                                                 
netlink error: Invalid argument
Failed to read Upper Page 03h
        Identifier                                : 0x11 (QSFP28)
        Extended identifier                       : 0xcf
[...]

BTW, just to be sure, you are going to post patches for both ethtool and
mlx4, right?

