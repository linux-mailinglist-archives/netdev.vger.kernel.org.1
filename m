Return-Path: <netdev+bounces-207652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC61DB0812B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0481917E28A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF27D21CA1D;
	Wed, 16 Jul 2025 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDjgMWB1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1D1C3C1F
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752709999; cv=none; b=iFSz5LvPcSAtxGxFKXknmsuQhnF8V8UAAOVOcpzmbt/0bayN7NekdR1uEOc1HKtksy6Z55Q1DCTUGrB1O6MEXKvO8sPIxyGi61WAXR8FlPWLUVSNZaVSRsQU9uxNdFnYzpRKEGsoSl+7w58HQL0vTKRYTZ+SIrEzjXIh0+Mur8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752709999; c=relaxed/simple;
	bh=iA31z3QTynnYqvKHL8kdQTWwmtWi7CXzsUB0DXCLaY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MylMkR9D51UsXXPss07hh1AUeHT6Fl1NgYNnNMSzOBvwag2IJzzbdmldrv6Qc7AA4FBhdxZqeurNmKHKfQHTVxkNA3fQ1c3QjKF3NT3mB7E/yiCGbIAvfSKtImCrDVVCNlRwdKW3hZTAqhpHvTKsfEe6CX3P39scnw5cL/KFSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDjgMWB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC597C4CEE7;
	Wed, 16 Jul 2025 23:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752709999;
	bh=iA31z3QTynnYqvKHL8kdQTWwmtWi7CXzsUB0DXCLaY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bDjgMWB1wOlwbYG8kNQBSo2b3YrZ/hDB5aB32Wc/Ew0zxc7lC9VT8U7HE9p73lQYM
	 GeIVYc3FgP055xbTBqeL1/phbVli9noETRe3fZv7dV8QUsmoQ6aLmxGCXka0kmXDo8
	 2XFh9OXAleAGFkWjLYrQzVtJqdAGRHE8ntfsJ3RocnV/eoE7UhP1aMZ4EYOxWcWh04
	 Ma/OD9Mb2l+so479vktO7K6PHyIGP20iCstfWe5jOyerY7CjCAX9/QzET0FQdORdu8
	 cpRmksALEjZXzv5OwI6Iv6+7EfIAYYJzjzH3PmEOHOLitbaLyjmnJbGOxYaaJLOtAr
	 pKN1+lKaQ6+FQ==
Date: Wed, 16 Jul 2025 16:53:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 pabeni@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net 2/2] selftests/tc-testing: Test htb_dequeue_tree
 with deactivation and row emptying
Message-ID: <20250716165318.3218679f@kernel.org>
In-Reply-To: <20250714031413.76259-1-will@willsroot.io>
References: <20250714031238.76077-1-will@willsroot.io>
	<20250714031413.76259-1-will@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 03:14:25 +0000 William Liu wrote:
> Ensure that any deactivation and row emptying that occurs
> during htb_dequeue_tree does not cause a kernel panic.
> This scenario originally triggered a kernel BUG_ON, and
> we are checking for a graceful fail now.

The test doesn't apply anymore, could you respin?
Perhaps try to add the testcase somewhere in the middle rather than 
at the end, maybe next to an existing HTB or netem test?
-- 
pw-bot: cr

