Return-Path: <netdev+bounces-17625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAD8752699
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302791C213B2
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F611EA9B;
	Thu, 13 Jul 2023 15:19:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0318B12
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E068AC433C7;
	Thu, 13 Jul 2023 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689261594;
	bh=VsVd6c6fcDYfKRrByNwWM9qnQW5+5Y5fBRbciDWv40I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5mdgSePHnomeUDlfS+pkzxKFrwwHpKsTuWkBqUg0484adSopLIhookQKA9b9+J7z
	 WYum0Nt1IzXiXiTYLXuJYE08RGoyhlqtANzpZdb8GwRbiikqy6vZ9lPzwpRJlVVGWu
	 LrQBNXSwL8x8zvgzAwA02tIAbpVCl6ILYu1xoaJslNOWRBh7hyqw1+bpuL73c81MyW
	 xDs/Fzh6+vMBPhjxx2U/Brmcjiy5fXO8rUzDvazvIkLv6G2AfAzb4Gccj0rzhrjcBl
	 YwjBnBZeaUPvY+7q8qht2BqYB/1m6thCFspv2U/58EJR9yA88OYfbxRImfY+eVHIKg
	 DKCbJvpV9aDFw==
Date: Thu, 13 Jul 2023 16:19:50 +0100
From: Lee Jones <lee@kernel.org>
To: Min Li <min.li.xe@renesas.com>
Cc: Min Li <lnimi@hotmail.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH mfd v2 1/3] mfd: rsmu: support 32-bit address space
Message-ID: <20230713151950.GA968624@google.com>
References: <MW5PR03MB693295AF31ABCAF6AE52EE74A08B9@MW5PR03MB6932.namprd03.prod.outlook.com>
 <20230330132600.GR434339@google.com>
 <OS3PR01MB6593BFFA683814654C957589BA37A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB6593BFFA683814654C957589BA37A@OS3PR01MB6593.jpnprd01.prod.outlook.com>

> Hi Lee

> > -----Original Message-----
> > From: Lee Jones <lee@kernel.org>
> > Sent: March 30, 2023 9:26 AM
> > To: Min Li <lnimi@hotmail.com>
> > Cc: richardcochran@gmail.com; linux-kernel@vger.kernel.org;
> > netdev@vger.kernel.org; Min Li <min.li.xe@renesas.com>
> > Subject: Re: [PATCH mfd v2 1/3] mfd: rsmu: support 32-bit address space
> > 
> > On Mon, 27 Mar 2023, Min Li wrote:
> > 
> > > From: Min Li <min.li.xe@renesas.com>
> > >
> > > We used to assume 0x2010xxxx address. Now that we need to access
> > > 0x2011xxxx address, we need to support read/write the whole 32-bit
> > > address space.
> > >
> > > Also defined RSMU_MAX_WRITE_COUNT and
> > > RSMU_MAX_READ_COUNT for readability
> > >
> > > Signed-off-by: Min Li <min.li.xe@renesas.com>
> > > ---
> > > changelog
> > > -change commit message to include defining
> > RSMU_MAX_WRITE/WRITE_COUNT
> > >
> > >  drivers/mfd/rsmu.h       |   2 +
> > >  drivers/mfd/rsmu_i2c.c   | 172 +++++++++++++++++++++++++++++++--
> > ------
> > >  drivers/mfd/rsmu_spi.c   |  52 +++++++-----
> > >  include/linux/mfd/rsmu.h |   5 +-
> > >  4 files changed, 175 insertions(+), 56 deletions(-)
> > 
> > I changed the commit message a little and reworded/moved a comment and:
> > 
> > Applied, thanks
> 
> I am writing to follow up with the following change. But I can't track it being merged with any branch, can anyone tell me where it is now? Thanks

67d6c76fc815c ("mfd: rsmu: Support 32-bit address space")

-- 
Lee Jones [李琼斯]

