Return-Path: <netdev+bounces-143455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6A79C27C8
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 23:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFB9BB2265E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB171E00B6;
	Fri,  8 Nov 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="VAbsZfNV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/Bnt4cd"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D07194C83
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731106262; cv=none; b=J5o4xF2/qUnqKFyUc3+iih3AgxYsXvYDNNMvoaL06OSzVp1Y0tVQRNYxBuZ3QKiw6TbVLykvs9cPFeSDVVLuRkMdfDqs86ougq9tNiH1/AK21UvqfeaWlsqhySPg6FkA/oEp6GuMzNOCx4cUm8VT/U90pbo71N/J4KwfBGpO+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731106262; c=relaxed/simple;
	bh=boP6ZGJd8MeG0+CSAK3HrjSkEB6dp/K5VhReKQTr73c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IknlvAmnnHOkjfi+mQnMe4EmB60+3cu19xUZYHcJ5qc8YpSKQLGHNSEDq+M4x5vhMH6SIThUgKzZu/KD5H75D27TntXdl2qiE1vlTorDYMoreesYSfqmD2wU62/9fOqkJuypwC22PrVuPvHkrwTUagCZc8F/zVEhSGsxvVTENZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=VAbsZfNV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/Bnt4cd; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 546431140123;
	Fri,  8 Nov 2024 17:50:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 08 Nov 2024 17:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731106259; x=1731192659; bh=bCbBxNqESq
	fB+4+jDWo4Gg7vhmLSF4wi3ugq67Vv05o=; b=VAbsZfNVGXEALEymdOq6b6pTB8
	mNmP5P12XkfhYlbHGZ2oCSzhebokX35KV6u6O23aXYRbdEbhQhv/Nz/5ifBU/pqL
	hEFQcgxoYNeJZZmqdAEJu3PfBs9Q4crKLtdzmI3veXc+wTfSGk93w0qySKNH/Qqy
	ftSsqJfvQOxFyCl585xrcSx7xKlCk8WO5d/MyVwXJbo+LRHyDLBiTATOhmmuYF8P
	IylC1YJpmjmJUffecykuscg1u3mzISAoXAGVtKEY+lUNfrnZJGU8xxz6ZTPC5fXo
	rDp++R2sD/wAugYoIOHnPZ0THVUG2gO6JfiMuIF5q6A42pnVMagxoXsUb8cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731106259; x=1731192659; bh=bCbBxNqESqfB+4+jDWo4Gg7vhmLSF4wi3ug
	q67Vv05o=; b=J/Bnt4cdLjyUno8thp8OiGjF9d94o/FfunZu969MIdm46nXa0gQ
	OO3Rx4YV+7BIafBCHeaQSNk4Lr2y1/vnbrO2o4EbMqgs5y21GZy1DU4TZwlanzyX
	kZvg2v506KEZy5yybfBQd755PJo+ayD3J1kvB2g/resKfLDvTu71SXzukT7ppScb
	EG0qvh4UHmTUjiIuG2+fl9cvCCJbuIsIiFmx8ohlVZBcvFzYtR+nbQdkRg562p3C
	dDqTEra96mbuiHXh0yyxiTFAp3EY6n9nDMx1kmUUEV23XE8UHT8Xki/MZpZcqKTs
	ckBKo+zSdYOOGMnPMJg46oQfmrwgsffF1OQ==
X-ME-Sender: <xms:0pUuZ5lkHX8cXS9CAAMeSXtPxB4WubJh9ASTgk8ySjAb8AZMaDccqw>
    <xme:0pUuZ01n5zpdZLGNp19yLLUwd5Oa_08UHtNFP4PyJIi7TNanNAf3fUOgXKxdhjwcO
    bdN3xUN3E-VKhNH4g>
X-ME-Received: <xmr:0pUuZ_qBsvMpwaSHmJ_Zb3smePnpdbzR7HxFsrcN96kiugXvXP-sop_d-qYWH0_5m2JVQPxUq9qic_I5_T6u2644EgKPZTZeEUQhfxE4CuKPdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdejgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugi
    huuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeu
    udekheduffduffffgfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvtghrvggvrdigihhlih
    hngiesghhmrghilhdrtghomhdprhgtphhtthhopehjuggrmhgrthhosehfrghsthhlhidr
    tghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htohepmhhkuhgsvggtvghksehsuhhsvgdrtgiipdhrtghpthhtohepkhhusggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:0pUuZ5lfIwfM7DSc08TfjCGWVauUI_XF1GgoP-kZA4i75SUGSOT5JQ>
    <xmx:0pUuZ33uQt1WgalwS4f8X1VeRsJZK62azCdkD45USG0gyR9xT0ZUMQ>
    <xmx:0pUuZ4t15hmUUQXYwRM61RAa7H40H339VvZoz9zq5wVd4OY1kekYOA>
    <xmx:0pUuZ7V_fG0Lz2TiPWWCWjMDZ6_RDN8ozMBJSh9nl69gzjtlNKakUA>
    <xmx:05UuZwLdTSIOlXwY8Wkw-GrUmpJQAqxlrU6KcQjGm54vZ-B49YOsYJf3>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 17:50:57 -0500 (EST)
Date: Fri, 8 Nov 2024 15:50:56 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, davem@davemloft.net, mkubecek@suse.cz, 
	kuba@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context action
 explicit
Message-ID: <3466lphn3dex3shqg73lkya4g3pt5idvfdtyjgyhrklxwkfkkx@t4mdww7m4pwx>
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
 <ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
 <Zy516d25BMTUWEo4@LQ3V64L9R2>
 <58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>

Hi Ed, Joe,

Thanks for looking at this so quickly.

On Fri, Nov 08, 2024 at 09:13:50PM GMT, Edward Cree wrote:
> On 08/11/2024 20:34, Joe Damato wrote:
> > On Fri, Nov 08, 2024 at 07:56:41PM +0000, Edward Cree wrote:
> >> I believe this patch is incorrect.  My understanding is that on
> >>  packet reception, the integer returned from the RSS indirection
> >>  table is *added* to the queue number from the ntuple rule, so
> >>  that for instance the same indirection table can be used for one
> >>  rule distributing packets over queues 0-3 and for another rule
> >>  distributing a different subset of packets over queues 4-7.
> >> I'm not sure if this behaviour is documented anywhere, and
> >>  different NICs may have different interpretations, but this is
> >>  how sfc ef10 behaves.
> 
> I've looked up the history, and my original commit[1] adding RSS +
>  ntuple specified this addition behaviour in both the patch
>  description and the ethtool uapi header comments.  The kerneldoc
>  comment for struct ethtool_rxnfc still has this language:
>  * For %ETHTOOL_SRXCLSRLINS, @fs specifies the rule to add or update.
>  * @fs.@location either specifies the location to use or is a special
>  * location value with %RX_CLS_LOC_SPECIAL flag set.  On return,
>  * @fs.@location is the actual rule location.  If @fs.@flow_type
>  * includes the %FLOW_RSS flag, @rss_context is the RSS context ID to
>  * use for flow spreading traffic which matches this rule.  The value
>  * from the rxfh indirection table will be added to @fs.@ring_cookie
>  * to choose which ring to deliver to.
> The ethtool man page, however, does not document this.

FWIW, bnxt on 6.9-ish is probably non-compliant (assuming this is the
correct usage of the API):

    # ethtool -N eth0 flow-type ip6 dst-ip ::1 context 1 queue 5
    Added rule with ID 0

    # ethtool -n eth0
    32 RX rings available
    Total 1 rules

    Filter: 0
            Rule Type: Raw IPv6
            Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
            Dest IP addr: ::1 mask: ::
            Traffic Class: 0x0 mask: 0xff
            Protocol: 0 mask: 0xff
            L4 bytes: 0x0 mask: 0xffffffff
            RSS Context ID: 1
            Action: Direct to queue 0

Note the "Direct to queue 0" even though I specified queue 5. I'm
running a new batch of tests on 6.11 next week so I'll update here if
it magically got fixed.

> 
> > I just wanted to chime in and say that my understanding has always
> > been more aligned with Daniel's and I had also found the ethtool
> > output confusing when directing flows that match a rule to a custom
> > context.
> > 
> > If Daniel's patch is wrong (I don't know enough to say if it is or
> > not), would it be possible to have some alternate ethtool output
> > that's less confusing? Or for this specific output to be outlined in
> > the documentation somewhere?
> 
> I think sensible output would be to keep Daniel's "Action: Direct to
>  RSS context id %u", but also print something like "Queue base offset:
>  %u" with the ring index that was previously printed as the Action.
> If the base offset is zero its output could possibly be suppressed.
> And we should update the ethtool man page to describe the adding
>  behaviour, and audit device drivers to ensure that any that don't
>  support it reject RSS filters with nonzero ring_cookie, as specified
>  in [1].
> Does this sound reasonable?

That sounds good to me. I'll send out a v2 for the ethtool changes.

I'm probably not qualified enough to do an audit. But since I've been
poking around the bxnt driver the past week I'll give it a look and see
if I can convince myself of anything.

Thanks,
Daniel

