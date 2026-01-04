Return-Path: <netdev+bounces-246785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BD2CF12B7
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 18:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A81F63007244
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 17:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D48B27F74B;
	Sun,  4 Jan 2026 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0k8MCf8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0581DDC33;
	Sun,  4 Jan 2026 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767548570; cv=none; b=tHrghmT8jKnTi5PZPh2SE36yO2ga9BM4krmWRVYO4RiCep5Uf6WLLEg6rZRDxCSNoyz/JO+LbPLgONjTcN0aHJnPnIPzJRViITPvJp3lOCLLZG8/4cUkJu9uejRFgJHa0B2127qUEz8T8EoqcSSLYwd5JhHBWIdjUL5QMxnj5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767548570; c=relaxed/simple;
	bh=7HPLYiRs6eVA1oHmhI4XjenQKhTHv3G0mq88Tc9aAoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6qWnDLAjSaNav3G4GvIqpAx1C4M96KG4/ZSI1joyMNirJetPN7i1uTXPas7Fa4En3x+is+4qVEH/YLxM/AyTMfSYI2Dy2mgN6X5o1713lsNsCRF1Z+zTVrPyMUubUZTj9lD+DP1kkHEg0JtRyy2vNF5X1kgUWWMYRRmPMNHDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0k8MCf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1989EC4CEF7;
	Sun,  4 Jan 2026 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767548570;
	bh=7HPLYiRs6eVA1oHmhI4XjenQKhTHv3G0mq88Tc9aAoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y0k8MCf8kM/8hrKaEO91p5+Eou/AgniBgTUZkYMpEHlAP31sdN4X6bhgKO8S/VnGi
	 g4I5uTru49lOOpDTM+mAt7fcDxDVkK6ykeQPboHnDAiesih/Qvb7Bf11xCPKcE1Qlf
	 MA9eByJII650OXuEwb91mlaaQr+mVeMzs7xZtSLjQ4uP2cD8i5UL+dw0eEHlgKOs2b
	 DcwF8YQXVN77dM0vacGRb9rOfK4wrMxGDlDF7/hSycwXTAhfw3kCi+el6/tXRR1Lf+
	 EcVscwxYMprBRUjUSBffreqKZ6G1qu9xnzXWBbB9w/M8whrVBKhKIPrL4XCu7FGJwj
	 9N7+ArutxIGjg==
Date: Sun, 4 Jan 2026 09:42:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] atm: idt77252: Use sb_pool_remove()
Message-ID: <20260104094249.5ebd5eee@kernel.org>
In-Reply-To: <20251229114208.20653-2-fourier.thomas@gmail.com>
References: <20251229114208.20653-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Dec 2025 12:42:01 +0100 Thomas Fourier wrote:
> Subject: [PATCH net] atm: idt77252: Use sb_pool_remove()
> 
> Replacing the manual pool remove with the dedicated function.

You need to explain the motivation for the patch.
If this is a pure code cleanup it may be not worth it as ATM is
on its deathbed, anyway.
Otherwise:
If this is a fix please add a Fixes tag
If this is not a fix please use net-next rather than net as subject tag.
-- 
pw-bot: cr

