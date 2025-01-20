Return-Path: <netdev+bounces-159854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4617A17307
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 20:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F164188826A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792901EC006;
	Mon, 20 Jan 2025 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUh8NvUz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3C8479;
	Mon, 20 Jan 2025 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737400350; cv=none; b=BNAdGWZHcK6vGbZEOZJifkHXfg/c5jzuo2krQEDxiyihuknhxQGI7u7GbiqVOvK53erpdMN9xFAJ8bDNIeaiy9Adx5XnoS7iYOAxvnePqHl2Y/a45EMSOD2KiCs8QPeq8oqSVuPPXSm5L3/T2obvKcuGrEINMSaMEcJxlWtshwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737400350; c=relaxed/simple;
	bh=XwrXM9q7D0qRMHaQsPhEnJ8kaTkMghuXwEN/eQQhdS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElJnhN2Bs9JRFLXNNSzOwehtmk1Bv9oRmmuYYNedR2B9cPOg9MwKG2IO2zoRQiDRUwYLhbNAP29LSNqblBjMe5ucpk1xbY0sQ9TiJXSt01PpHlW7nEp/i3Vnne+Jt6oXOf5FXLHp3v5BrKyppvsr6Bnv9lPYZikHcwcRybraRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUh8NvUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC75C4CEDD;
	Mon, 20 Jan 2025 19:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737400349;
	bh=XwrXM9q7D0qRMHaQsPhEnJ8kaTkMghuXwEN/eQQhdS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUh8NvUzmFQb6bLEBObFhwzF/ouFutDpBPrbCqZedo+pR+9axCCzA5k/8UIfCF6Cv
	 LaPgzWSWvk1yvMBs4+R5MvAPdRdokOkm4bKDUO8lgpDuSQU3L2UV4MiXyGFtWE2LML
	 fcP5OQ1NShI/kSOXYkMnu/OYYEgR1SSXpEWT2au6hi9tW8JfHfbMcZYIve1W7qIIyb
	 1uWlSVaKpjkJN/HxGkxvLGhJ1M32sRZVXFoiO0RUabODVCmLTR0HYx1xyuqINXd4QF
	 JAJf1jwWoWp7VITSuALM8qs+Ko1xxEdpoq+e05dfPfsZkcLa4JGJgV3/3jjxkpYgXb
	 LLsX7YHByB/NQ==
Date: Mon, 20 Jan 2025 11:12:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, thomas.petazzoni@bootlin.com, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3] net: phy: Fix suspicious rcu_dereference
 usage
Message-ID: <20250120111228.6bd61673@kernel.org>
In-Reply-To: <20250120141926.1290763-1-kory.maincent@bootlin.com>
References: <20250120141926.1290763-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 15:19:25 +0100 Kory Maincent wrote:
> The path reported to not having RTNL lock acquired is the suspend path of
> the ravb MAC driver. Without this fix we got this warning:

I maintain that ravb is buggy, plenty of drivers take rtnl_lock 
from the .suspend callback. We need _some_ write protection here,
the patch as is only silences a legitimate warning.
-- 
pw-bot: cr

