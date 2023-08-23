Return-Path: <netdev+bounces-30137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 535097861DA
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 22:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8D01C20D4D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 20:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7BF1FB41;
	Wed, 23 Aug 2023 20:58:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B11C3F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 20:58:53 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B59510C8
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 13:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vnGt/uJjkVve4zeCbfMTEK9g+SKJJZVyPBn7TFnEgLA=; b=GDpPkDAH8gbbrDLJP5pqKRse16
	YtDJkpmLbXxx45AEoILsuhep++VaQm5xrf3OeZ44TbCfA/IeNjYaqzeFu0KHNfymWMHHiNBPAe5bL
	C9NjRSe4vAr+74epVsbhRrce3bXDd8RQR6XOkGqNUFmC563zeOATgqNmhhm2Ukvo7tD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qYuw8-004vK3-1y; Wed, 23 Aug 2023 22:58:44 +0200
Date: Wed, 23 Aug 2023 22:58:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Pawel Chmielewski <pawel.chmielewski@intel.com>,
	"Greenwalt, Paul" <paul.greenwalt@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	aelior@marvell.com, manishc@marvell.com
Subject: Re: [PATCH iwl-next v2 2/9] ethtool: Add forced speed to supported
 link modes maps
Message-ID: <f001eed4-82ba-4d14-86af-9b0d9c79d708@lunn.ch>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
 <e6e508a7-3cbc-4568-a1f5-c13b5377f77e@lunn.ch>
 <e676df0e-b736-069c-77c4-ae58ad1e24f8@intel.com>
 <ZOZISCYNWEKqBotb@baltimore>
 <59906319-6171-da5b-ca78-4ab423b1cc92@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59906319-6171-da5b-ca78-4ab423b1cc92@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> it would be nice to reuse the same mapping that is common everywhere. I
> suspect the PHY code already has some mechanism to support device
> specific since not all PHYs support all link modes either....

phydev->supported is initialised with all the link modes a PHY
supports. The MAC driver when gets a chance to remove any it does not
support,

phylink has similar concepts, the MAC, PHY, and SFP declare what they
each support and then it all gets combined to resolve to a link mode,
to use.

So it should be possible to make this generic with the help of the MAC
driver indicating a mask of what is actually supports.

       Andrew


