Return-Path: <netdev+bounces-130618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF5998AEA8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE777281A1A
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF981925A2;
	Mon, 30 Sep 2024 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B8Mcb687"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442F152E1C;
	Mon, 30 Sep 2024 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729254; cv=none; b=M/0A3kPQQq80hVDOVMjiRhelw7kh3OsQCH1o8P9W5uY/pJcc8BR41UzKciwa7FDifapgI2kU1i2k+4wmue2/PvQ2sxzOO7DAwI2LDwttwfm/pw5XZTyfl4R3+8fm8+SIzxD2mtR8DytQTQWV2GteDghVJc/N8pj5WXLkqRCK+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729254; c=relaxed/simple;
	bh=cvRvFZKcSADJqST47iJbB7kk8lp/MzS24e16QXxiaq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQSxIcMjU0yGbToPzLF0HiYb6uat6WVuzuGlfc/57FaoZCzwqQ+NjFdALR5sqqCFW9y8/Fx8+Kqp0pFB3CmnX6VGDRV1VgSf3ZkvOhga7xnFlwpgdW0gB8sDY1djnn3Dr0ioaWQ6Ndvcai3Yy/2j9bne2/F6n/MMX3cDjshUokE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B8Mcb687; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LO1a7Oy+GjD8eEAZdvCAkXtpFnX4F+ctjpWcxHc6rhU=; b=B8Mcb687FIOjKs8y4eLuumzXlc
	vEjoX3oapfTobvMd73mFm5L6M5dqbKEdDTt7Hpr0GQi8nKesh5ZGXUztdi56xxczAUNTTpFAWVRFa
	jMeL4aktouR+U01T3/lnsNl4n/S15feoc/aEdrIIo45NS9hBb92vDUN8a/cA+pXLsyPk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svNIe-008fJJ-SD; Mon, 30 Sep 2024 22:47:20 +0200
Date: Mon, 30 Sep 2024 22:47:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] net: switch to scoped
 device_for_each_child_node()
Message-ID: <fa6e7b93-87d2-4dbd-a61c-cf1d9e7f7141@lunn.ch>
References: <20240930-net-device_for_each_child_node_scoped-v2-0-35f09333c1d7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-net-device_for_each_child_node_scoped-v2-0-35f09333c1d7@gmail.com>

On Mon, Sep 30, 2024 at 10:38:24PM +0200, Javier Carrasco wrote:
> This series switches from the device_for_each_child_node() macro to its
> scoped variant. This makes the code more robust if new early exits are
> added to the loops, because there is no need for explicit calls to
> fwnode_handle_put(), which also simplifies existing code.
> 
> The non-scoped macros to walk over nodes turn error-prone as soon as
> the loop contains early exits (break, goto, return), and patches to
> fix them show up regularly, sometimes due to new error paths in an
> existing loop [1].
> 
> Note that the child node is now declared in the macro, and therefore the
> explicit declaration is no longer required.
> 
> The general functionality should not be affected by this modification.
> If functional changes are found, please report them back as errors.
> 
> Link:
> https://lore.kernel.org/all/20240901160829.709296395@linuxfoundation.org/
> [1]
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Changes in v2:
> - Rebase onto net-next.
> - Fix commit messages (incomplete path, missing net-next prefix).
> - Link to v1: https://lore.kernel.org/r/20240930-net-device_for_each_child_node_scoped-v1-0-bbdd7f9fd649@gmail.com

Much better.

Just watch out for the 24 hour rule between reposts. Reposting too
fast results in wasted time. Reviewers see you v1 and give comments on
it without knowing there is a v2 which might have the issues
fixed. And you might ignore those late comments on v1 ...

I will wait a day or two to review the actual patches, to give others
time to take a look.

  Andrew

