Return-Path: <netdev+bounces-69929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392B984D134
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD121F23770
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30B31B7E5;
	Wed,  7 Feb 2024 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJbOg3zz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1E39856
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330696; cv=none; b=jCIxzXm0c8YZbKoQ/NKJsCmXV60rZr2m1FKYmPEVRnBC5SVsq3egrsjvc2sv0HZuAWGZ0iASmtbA5NYFZWrbuCsnhHAGvRkpS6ODTatXbs+xyfntZd5MuxoULBAroU3+JNTJtdVy2KDn8HWQtdeezDBLuY2yBL5/F0fcniLcOhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330696; c=relaxed/simple;
	bh=SYbBpndsKsTYZxQZF/korjmPiyKys6sNC39CvfVH2Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKLF1d5hAHsUm/keCzUh9CyH/QmorYBbV93a0A9ERHqhLzpjzckxqmc6PMuw5D/RNSpUyDB/lr33oZA3y7ccITIaqkq4kLSfMhha4MWo/0BqQZysISeiyCtZFJB6/BLjVZwYA72zlz+0oG8HkHsuf4fV1h8EsFtD4pOY3ZTahIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJbOg3zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F59EC433C7;
	Wed,  7 Feb 2024 18:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707330696;
	bh=SYbBpndsKsTYZxQZF/korjmPiyKys6sNC39CvfVH2Wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YJbOg3zzLri6e4eoHH/vPHasHirxavS/hDINxvcL1L9ILOtci4wmhlIb9vSyuqOsA
	 kvCOUVKoohFpkBmSQmIlhqhEwl2wpxXf61Ipx0ogdWDyeBYKK4fw4LFN6emAjNC/Ta
	 Qw/OnZukyWVhBzm9kVRZhzK+qzLnZtyUEgGzrn3LYrIxJjyp556xBkQBsgBJz6emvJ
	 hWETH5ASGl5/SvOTIsm0RRZOFK5olgyfHIrSRnP9ALliOcYN8iPJGH+zCbb5xvPqz7
	 8kjFOx65GmCYZzAMiIIYtKehoPoxn5J9xxgJa+40OMw7ThqqLBOVSUs7o/7jl1Y9VI
	 sphpsrKCJXvfQ==
Date: Wed, 7 Feb 2024 10:31:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Taras Chornyi
 <taras.chornyi@plvision.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [EXT] Prestera driver fail to probe twice
Message-ID: <20240207103135.33e01d2d@kernel.org>
In-Reply-To: <BN9PR18MB42516CB6F1DA53D8BAD47B17DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240206165406.24008997@kmaincent-XPS-13-7390>
	<BN9PR18MB42519830967969DEA4E329EFDB462@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207112231.2d555d3e@kmaincent-XPS-13-7390>
	<BN9PR18MB42510F2EA6F4091E5CA3B409DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207122838.382fd1b2@kmaincent-XPS-13-7390>
	<BN9PR18MB4251F1904C5C56381FE976C4DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
	<20240207153136.761ef376@kmaincent-XPS-13-7390>
	<BN9PR18MB42516CB6F1DA53D8BAD47B17DB452@BN9PR18MB4251.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 15:06:34 +0000 Elad Nachman wrote:
> MAGIC value is cleared after FW is downloaded to RAM, just before it is executed.
> So checking the MAGIC value to determine if the firmware is running is useless.
> 
> You will get the MAGIC value read correctly only when firmware is
> during the download process, which does not help you implementing the
> logic you want.

I'm not aware of other networking drivers which cannot be reloaded /
rebound. I think it's part of base expectations for upstream drivers.
Could you work on fixing this?

IIRC we have enum devlink_param_reset_dev_on_drv_probe_value to control
whether device is always reset on driver load. You can make resetting
an opt-in if you're concerned about backward compatibility.

