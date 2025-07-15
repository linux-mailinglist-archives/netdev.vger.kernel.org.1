Return-Path: <netdev+bounces-207032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A902B05620
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1EA1896368
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886EB2D541B;
	Tue, 15 Jul 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFYemaIU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE6231A30;
	Tue, 15 Jul 2025 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571189; cv=none; b=uj1hN7VbUaez+PDvRrDC3ZBW4bsXeDddkNTy/5ftttorpg5HHx6D+Ptk1YhIKk1n1Qon0usyD7hti6T0RSfwV1h7eYklGNraqJTC6Bf0qNn0tF4P4v3z8wMNqSQ9SJ4FqLXcDoQp3bpGVbNcjp5qgBeRXVgqS/uLlyNObFJKdiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571189; c=relaxed/simple;
	bh=icE/day+g6/mFQP4EzLECOQ6Ku7rwKD0ZHKFcA1F8po=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W46ESNwpvgjgpSm3vXcL2XYm5EuOWNCyLjA+sQte+fdzPK0DgJqQQrCyYB9TpxSr8o7FX/jHHuV/q4fTa8Kw4iYM8LhywOXXt9eMxGxtNoB6jjYmyqaLIlJkFfIzVzl0aPNHo3FDcE+Ngr7f33M12rmMQKVfMF+zqGHEfHsD7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFYemaIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC69C4CEF5;
	Tue, 15 Jul 2025 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752571188;
	bh=icE/day+g6/mFQP4EzLECOQ6Ku7rwKD0ZHKFcA1F8po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IFYemaIUbetI8+7ysY790W59mDa8HlMDuZoJZitus7BQCdzb7ZdEMpwayU53eJgPl
	 NmOVEtC0OMPNQanfkWrvV/lV+Es+ecce+p0PTzHRphnowSUi1BlOYh2zmzkIfT6BIS
	 yDA5pPqdnK21YPYpIwdYQpYuDhTZT1Bt1Udq3g6Uh6BAWsI3O1VeaImwTCNo3tliBS
	 EUIy6Fv+X9fh6AOKdLQLQSddZWxnhBgZgBCihb9bA7iHtm8saXm+JaWiD8+rAo2Mu/
	 FAQPYpqrHYrin9PkTQdrq77yTJh6Tk87ooONyR8V92SV+YU/OzbjgZ9O/MmZABZwKl
	 r5ryxQk3Qu4TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AC3F7383BA08;
	Tue, 15 Jul 2025 09:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv6: mcast: Avoid a duplicate pointer check
 in
 mld_del_delrec()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175257120949.4175211.2185798893217859855.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 09:20:09 +0000
References: <20250714081949.3109947-1-yuehaibing@huawei.com>
In-Reply-To: <20250714081949.3109947-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuniyu@google.com, Markus.Elfring@web.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 14 Jul 2025 16:19:49 +0800 you wrote:
> Avoid duplicate non-null pointer check for pmc in mld_del_delrec().
> No functional changes.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: early return if (!pcm) true as Kuniyuki Iwashima suggested, also revise title
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv6: mcast: Avoid a duplicate pointer check in mld_del_delrec()
    https://git.kernel.org/netdev/net-next/c/a8594c956cc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



