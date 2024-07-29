Return-Path: <netdev+bounces-113593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D993F3F5
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2021C21B19
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF4F145B21;
	Mon, 29 Jul 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNscfaXk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B52144D01;
	Mon, 29 Jul 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252244; cv=none; b=GuM97q8xsFTVMXB/8gwghWkFJhyjIEwV+uzIgGI2QNEQKBO82ysR6f/R7g95NhC7kUobyN3t/59FTmW6AUSAHtibJJ8vsSdrCI6kH3BucjOTj05ELWQKnJbzNp9YR7ZbvHpA/Sk6ggAlJpKB/8Kfq2l/Gt/IOEUZtlhMysb3kEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252244; c=relaxed/simple;
	bh=5waAH00rUEegT+y5tOiOOjYIeQTGw6i7qeM1HGNnVDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oc7IaBiGSXXha7+kWnGBUJh/24PG6T8s0MHYdImzVB6+LmRYEacHnvFV9aYcL7m5oqg3hYvsDbsrUFACpghg/Moaj9jy4CUZcR+M0jLuGojNi8x+iuz76m7XDL8EcQdtV+IrrsaJLv0dmwsWQGROocqiOHWHHKvTrY5zw2KVN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNscfaXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 575CFC4AF0C;
	Mon, 29 Jul 2024 11:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722252244;
	bh=5waAH00rUEegT+y5tOiOOjYIeQTGw6i7qeM1HGNnVDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sNscfaXklNnwpGUP3RBmVCwM/mb0DNgaZqBy7SvNjXit56eo+qpqHkGKzDHggeEIY
	 YLTKL+IuTUo0hM8kCIWI8luZ/ayVfsqsalO3w9dJk1L5hdE9DEHHHCRqsfwUtq83Kh
	 IwFWlTH1BVIql3JjfOCVErls/REZ7U+vnTQM22ahLI7/55oVaOpWSXPHwtmmY8vPnq
	 Ob2NLxCySefZ9EpVFzQHfCvpR8KaQ4rtYNZHxJUs+rkqcbOTWfPtKCe6oei+EtFFAW
	 Hx4U65yaXw7RK/GlYKPINcyXiGNamjlm+c35dT/jsoPx7knegQzNBH3L1RY8oCuPCN
	 Mo/sJ/eY9Ch8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CDF2C4332D;
	Mon, 29 Jul 2024 11:24:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: axienet: start napi before enabling Rx/Tx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172225224431.15294.4080149929042366779.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 11:24:04 +0000
References: <20240726-dev-andyc-net-fixes-v1-1-15a98b79afb4@sifive.com>
In-Reply-To: <20240726-dev-andyc-net-fixes-v1-1-15a98b79afb4@sifive.com>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 robert.hancock@calian.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Jul 2024 15:06:50 +0800 you wrote:
> softirq may get lost if an Rx interrupt comes before we call
> napi_enable. Move napi_enable in front of axienet_setoptions(), which
> turns on the device, to address the issue.
> 
> Link: https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg06160.html
> Fixes: cc37610caaf8 ("net: axienet: implement NAPI and GRO receive")
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> 
> [...]

Here is the summary with links:
  - net: axienet: start napi before enabling Rx/Tx
    https://git.kernel.org/netdev/net/c/799a82950750

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



