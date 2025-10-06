Return-Path: <netdev+bounces-228005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983ABBEF58
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05CF934AD8A
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150372DE704;
	Mon,  6 Oct 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnCbxhJQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EB2DE6F7;
	Mon,  6 Oct 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775424; cv=none; b=q10XWy7Ba8E54oiEDnwQ/K+ctifMJz2Kqga6PRl1khrl27qInGEf6VDGVFJrnhwwWMzSDoWZ/M64RHF7bXGjZ3NbFGhUBlY8aOF2Zfm9lcA0YmNLEk59sOlwy8+djgCGa8/aka4eJWT0ij8DNtuPydlrR2JA46Uql0/pjjLs/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775424; c=relaxed/simple;
	bh=bdk7u6K8PpMBTqlKEhIiVPBy/qfBI6iyt2n82Zac3hw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rhtYqkg0+bVDJ+5vmOV6TQl4qdqpx1WAa31lMH6GdV9mR8PWAXomY0vIE+Z7XGj9x7Z9Dj4LSZXNHXTsyQGhFaQGfHOx3wipbqG38hC3NMMuj8pNwzezDSVNWFcxH8eyJRwGatgD4YoqB2ca9UuIMOwDik5dQIr85ZmSpT7chJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnCbxhJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC1EC4CEF5;
	Mon,  6 Oct 2025 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759775423;
	bh=bdk7u6K8PpMBTqlKEhIiVPBy/qfBI6iyt2n82Zac3hw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WnCbxhJQxgIN989j5eMhLZsYC0DQ4mLrs8QXCYGWJSRn0mBxhNI3k1qcIdjc6Cy3x
	 2A6T+GjQ1/lwdNnym3QbD3NQl+WaOinYX591o1vhC7SuNu7GTIxlz/laSrETaxbzLJ
	 YDX6BevWHqbV8b229xX6XRkHKa1xmZaLfPz7UHoOAS7LrmtstYgRpaUuyyEpWSqtbH
	 D4nAZ6qGQ+227vRj3wivbpKGazWVqgqhlbpZruTTaYXv4CQLlCrd96lmlVeFIyIEJL
	 kI+yuM3EVTIff9YP+Elo9lV70JX7blGpc1OfO7q14ORtqRreln7vmnh4vvtAE84sqW
	 chrfxcF/RisWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD739D0C1A;
	Mon,  6 Oct 2025 18:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] ice: ice_adapter: release xa entry on adapter
 allocation
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175977541325.1511446.4780577963402519047.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 18:30:13 +0000
References: <20251001115336.1707-1-vulab@iscas.ac.cn>
In-Reply-To: <20251001115336.1707-1-vulab@iscas.ac.cn>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: jacob.e.keller@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  1 Oct 2025 19:53:36 +0800 you wrote:
> When ice_adapter_new() fails, the reserved XArray entry created by
> xa_insert() is not released. This causes subsequent insertions at
> the same index to return -EBUSY, potentially leading to
> NULL pointer dereferences.
> 
> Reorder the operations as suggested by Przemek Kitszel:
> 1. Check if adapter already exists (xa_load)
> 2. Reserve the XArray slot (xa_reserve)
> 3. Allocate the adapter (ice_adapter_new)
> 4. Store the adapter (xa_store)
> 
> [...]

Here is the summary with links:
  - [v3] ice: ice_adapter: release xa entry on adapter allocation failure
    https://git.kernel.org/netdev/net/c/2db687f3469d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



