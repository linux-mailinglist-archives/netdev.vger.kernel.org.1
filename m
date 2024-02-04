Return-Path: <netdev+bounces-68887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CF3848B29
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 06:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01AD1F227BE
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 05:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ED71C3D;
	Sun,  4 Feb 2024 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHZCX/Yl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F256127
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707023454; cv=none; b=qpV+bzLoNyeEF5TLLZNL47W5dVc+v+SYw2NyCW/LF6HqUV23GDWcsvxyvbgEqWHjB8hc78OcWP+u3PNuHCMSheVvXc9x465lggb74Ure/CE0yVEvPSdvkRRw/UJz83nBLJHgFDPW3QMxo9iESoYlRyH8ikkFcxxmNvgOlPKtRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707023454; c=relaxed/simple;
	bh=Zyn1Rdwh4JCD2WvQSdX7ii8CELfSmU/aGxNTF1zHpow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1Uv0br/H9G/XETN8hlrq+agSfEl8I903Q0y1eq39bVFVZl8B1xEcTygq/4giL2K/rylFbITup6U9JCHj3xs4ZRKcRfKDMSOMktW+nk424uaxuo88MUQGxejJD1GdhmfM0skVdsWl9I3C4pcvp09UDc+tj+CvI8K8OGt5RnY2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHZCX/Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD96C433F1;
	Sun,  4 Feb 2024 05:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707023453;
	bh=Zyn1Rdwh4JCD2WvQSdX7ii8CELfSmU/aGxNTF1zHpow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tHZCX/YlRaLblOttzRDmSp9YZynwgMVw2RiM8gmGW7q1ZrbgEWy1rc3nYS4Uz8OZc
	 H0vxH0woFugAr/uI698mLJSmeBEuaMvCTAUCxt4NnudKP8hwSghQqyJVQ3jb5l3Hys
	 tJC9U83QhOeAXywLawS6AKm7PukH7qYMCbnDIHfC1wRvIgK+rQNQiPmq0wAxZ8ZXU5
	 m5yJivJjtwZmB01hkbk96qPC29rtBUqjprEXqfGcE/f3L3ydPI2Hfs29X/zoH7Aufu
	 n6+BvXpnmLRaW5sM5iCcnNTPmMwqI7E6rMWejbH5vOoBLVQpltGbp6Wocl5GqpoVkb
	 gEMYFGriokAiQ==
Date: Sat, 3 Feb 2024 21:10:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Antoine Tenart <atenart@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 15/16] bridge: use exit_batch_rtnl() method
Message-ID: <20240203211052.30905ae4@kernel.org>
In-Reply-To: <20240202174001.3328528-16-edumazet@google.com>
References: <20240202174001.3328528-1-edumazet@google.com>
	<20240202174001.3328528-16-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Feb 2024 17:40:00 +0000 Eric Dumazet wrote:
> exit_batch_rtnl() is called while RTNL is held,
> and devices to be unregistered can be queued in the dev_kill_list.
> 
> This saves one rtnl_lock()/rtnl_unlock() pair per netns
> and one unregister_netdevice_many() call.

This one appears to cause a lot of crashes in the selftests:

https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-02-03--21-00&pw-n=0&pass=0

Example crash:

https://netdev-2.bots.linux.dev/vmksft-bonding/results/449900/vm-crash-thr0-2
-- 
pw-bot: cr

