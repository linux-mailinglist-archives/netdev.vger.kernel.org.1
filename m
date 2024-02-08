Return-Path: <netdev+bounces-70287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C9E84E421
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEF7281030
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165C07BAE0;
	Thu,  8 Feb 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhYsSy/a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE47640A
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406640; cv=none; b=TrgvpPVyBpO7LT7buA5Y47YXI2cTV7Liouc/O45OsC6OhsrEaBI34kaTNRcXRLpFutdwt5ngpfx5U8vsHX6HZ5tMLScFGjY/pDNgMYXE4Z6wQmLF5w1gCqz+n56/zFC7mj+fwVoz5yc6Ru9UXbFeE6qFVUTuzZhQeftV4W3e0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406640; c=relaxed/simple;
	bh=GJUn2Iv9BdzNCcDgPeLa/+beNiBpTsKWFx4RPFZY3y4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bn7B/JbRe1jhvGXfpwcaLa2fhvlsZfMf44HAwbilGV1w8GDoJ+Yrrl8TBzcjLbVk3ui50K53fwfu8aN464rnH85AOUmNjHv/TacYgp0S/gdTTUxGSH9/lgH5hXMdDJLo4LkQf9TU3Px0FEM2fmUnPXNNDHbxV5sUjMZK0fL++wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhYsSy/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C205C433F1;
	Thu,  8 Feb 2024 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707406639;
	bh=GJUn2Iv9BdzNCcDgPeLa/+beNiBpTsKWFx4RPFZY3y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MhYsSy/aSHH0K4OHxcoQTJfYFjKpax8qlbZEJKJAVo8Os261hJA4N0K1YTl+HWKtW
	 0JZ1gbn5Llhxb1zbGiMJ//I6p6gQH+vuJsxnHRmQEeqWMt9gB5ePqLgJJ0wN3BOkFu
	 Paaxa//ihaYMDg9gzQ+eOo1ILQvNy0GBL3W3pkcOK4MQKxPgZBGURAIdLL2M+n7sTj
	 TTkvRMT4v987R6/33cuDN8AHdpR8zYfApefty6lJLUA0g9vjEFjGzuCz+3LhpMzBqr
	 5E2ilcPj0+LbHaPtxaRtjREGIm4XcMp4HdjBWy1alVGcoORECKXiqsbWaWF6Nt9P6L
	 6WsnrUG1mfzBw==
Date: Thu, 8 Feb 2024 07:37:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Taras Chornyi
 <taras.chornyi@plvision.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [EXT] Prestera driver fail to probe twice
Message-ID: <20240208073718.7fcb93d4@kernel.org>
In-Reply-To: <BN9PR18MB4251BC09AAD68BDA10AD4C9FDB442@BN9PR18MB4251.namprd18.prod.outlook.com>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 07:36:54 +0000 Elad Nachman wrote:
> Once again, existing deployed firmware does not check the enum below,
> so this does not ensure backward compatibility.

Okay, if it's a bigger rework - how much time do you need to get
it fixed?

