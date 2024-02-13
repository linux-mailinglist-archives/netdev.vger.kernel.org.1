Return-Path: <netdev+bounces-71118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A729E852559
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BA11C240D0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A8A4A19;
	Tue, 13 Feb 2024 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9xMT6du"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C446B5
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784174; cv=none; b=bIcvaqwF8TF8cxuAAajYex/y/fuZg0TRQg0cvEJgWsXEVACzAMojPpsUCv7Y3/2GmeiQIfI72rBNo+4R19ElIKh4b5H4WAIscudWZ5CP/KIcn6LfjRvNjB6oNprfByzq0lrVanPRi3QG/c2Udo93ZXmnJEa//ooLgrLDQtzL32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784174; c=relaxed/simple;
	bh=b221IThJbQRGe726StVNr1a3NXct61vaMR0BDf5oiO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpkLk/XYUBDF2gwC57hA3hezwMYg2i0y2GpzLx6hdWAyB9qFjiEg85YCwillqUnY3Q8G88/EI/AIazmLycERC+wZ6h7D6lenvEAt71zsvfxcBxBDgEoTG2FipkXXOx+NfMJnuHBboY4cBbzjf/g2b8n9MkMtBCzuZBx2XHtIM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9xMT6du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5B0C433C7;
	Tue, 13 Feb 2024 00:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707784173;
	bh=b221IThJbQRGe726StVNr1a3NXct61vaMR0BDf5oiO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d9xMT6dunGMN+3JWmCo4xx61lVkyISmH2kbSkV1E1Vk6uYnARNbZs+QHJigq28zSI
	 mRn47VpkGMg3zcyZJmZ89cqkAmU1q+Ku/gwE0JiYpDlDZOia61e1Ll1VFVdEVMkLF7
	 ZOF3Omhf9HeG/odQlbM+BF4XL9FZtxhTdUoTkIJ/aDc5XQ4pLSddUoj0LX/dml9GKN
	 0tMhtUNCwtO47W1SdpcZd0NbrRaaVbHriJILgGGujHjsjOemgxi+zcudYegpnvaYgQ
	 5CW9U9X3jPhIaMRASFOkrEUpQ3fGdR/+dRF5AYYj5WfA8uWCfyJ1eU5DZHNpn//DJf
	 m/YJYAwIxPQug==
Date: Mon, 12 Feb 2024 16:29:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Taras Chornyi
 <taras.chornyi@plvision.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [EXT] Prestera driver fail to probe twice
Message-ID: <20240212162932.3b438657@kernel.org>
In-Reply-To: <20240208073718.7fcb93d4@kernel.org>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
	<BN9PR18MB42519830967969DEA4E329EFDB462@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207112231.2d555d3e@kmaincent-XPS-13-7390>
	<BN9PR18MB42510F2EA6F4091E5CA3B409DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207122838.382fd1b2@kmaincent-XPS-13-7390>
	<BN9PR18MB4251F1904C5C56381FE976C4DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207153136.761ef376@kmaincent-XPS-13-7390>
	<BN9PR18MB42516CB6F1DA53D8BAD47B17DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207103135.33e01d2d@kernel.org>
	<BN9PR18MB4251BC09AAD68BDA10AD4C9FDB442@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240208073718.7fcb93d4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 07:37:18 -0800 Jakub Kicinski wrote:
> On Thu, 8 Feb 2024 07:36:54 +0000 Elad Nachman wrote:
> > Once again, existing deployed firmware does not check the enum below,
> > so this does not ensure backward compatibility.  
> 
> Okay, if it's a bigger rework - how much time do you need to get
> it fixed?

This question is hogging a spot on my todo list.
I'll earmark the driver for removal in three months if there's 
no progress. Please LMK if you have a different estimate.
It's just a question of it not falling thru the cracks.

