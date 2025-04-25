Return-Path: <netdev+bounces-185806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74124A9BC72
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 03:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532713B45B3
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A597C7DA73;
	Fri, 25 Apr 2025 01:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou6yKk7Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B36F25776;
	Fri, 25 Apr 2025 01:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745545147; cv=none; b=XNdAX/IpM7IWPq1xTfi9cXyNv57CyL8dGjsy5z6oD2bq9/KMYo3OJg5njwRhBf/vXjy2Z4LAoL4wQiPbkoSinqPzMAESsTB//iTQyef0nweEHDpuU0m4yvy/q5Y7+uRgfdk2KkGcBI6bHji2RuyBSQMtBm8ycPT8bHNJpFoXttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745545147; c=relaxed/simple;
	bh=rZrWpBEGOinJoTikyl3nBGQMLhKZuCs4BaByhevjX+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYRnqiO8FYTKLxPhqBbLfHbC20bBTqTWIZZ7l3Qz0sOcvGgwrCCifOJWeREuT3X8JNGprscyJSBV4RQGu6bg8RfkPX+ZUQsPgjmenU/gbniBVupHhRwq+qJEug+WVDnWU91g23mtEmMxXB/9j7CfOkTWZiweaxyVgUunbVD+rfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou6yKk7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680ABC4CEE3;
	Fri, 25 Apr 2025 01:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745545147;
	bh=rZrWpBEGOinJoTikyl3nBGQMLhKZuCs4BaByhevjX+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ou6yKk7Zzs4lrrP4KfnCcxPDW2tGW0z2lDfsqiqsxtv5N57aR1rJhrs2LVHnfp+ba
	 tqog9EFqcDuET9AqLB0ht1Z20eSgco5+17ZPkHnjiTi77G7JJYy2J7+ybsnj+13IS9
	 HtTW7j3JXQ57iDLvJ/aGbpDABBlyzTzrortH3LK3l95jub4LVbI7TxDu8UsQFmABom
	 SdRhgVfOCDqUUZmb9eDVNmn4I4anJbJvfEUbOGgO8Rz9zawBYKT1lEuDxVuVnSdm40
	 I87bgm0Ph6F+xr6cbA9KlmCTp7n62vhYj5Yn1UPlLtPQdHH+hyRNC/YZfkXhyjaB0r
	 XfrFTjIOTc2CA==
Date: Thu, 24 Apr 2025 18:39:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Joe Damato <jdamato@fastly.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next] rtase: Use min() instead of min_t()
Message-ID: <20250424183905.5de1f149@kernel.org>
In-Reply-To: <aApttwNRkiMP6xMJ@LQ3V64L9R2>
References: <20250424062145.9185-1-justinlai0215@realtek.com>
	<aApttwNRkiMP6xMJ@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 09:58:31 -0700 Joe Damato wrote:
> This looks fine to me and the patch is against net-next according to
> the subject line (I think?).

Agreed, Justin please repost this and the next patch without the Fixes
tags. The fixes tag is used for backporting in the stable tree. 
This commit will not be backported.
-- 
pw-bot: cr

