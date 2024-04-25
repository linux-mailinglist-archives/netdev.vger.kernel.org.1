Return-Path: <netdev+bounces-91434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6028B28CB
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDB01F22B8A
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0951509B1;
	Thu, 25 Apr 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFWuVuEd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826A146A74
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072228; cv=none; b=Y5NWAsTvaamV+YCn3TOQOVl/qtA0AW7KB0KY8PV3/xchwm+r3glopqz2l7UJLYn0VM6bWk3aPSWCQXo9ZbanlBAWyvoUpipXSO6cjLPMWABIrOFArr7f3DRnLUNzeX5tfk9kFhxVsxOojSzqSp33939mQ4Hs8C7Fqadn3lU/CTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072228; c=relaxed/simple;
	bh=Nm7FTU4uR/QQ/4Pa2f/hMLw/t5Pah+F475PICHAm52A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ozzJJD5o1Ne6RAcwhLEHjX0+1CFURuGv1fKkXbkT2G+k87JQZ4svAF21OolJNwGmgWH/gbFOB9oEv18n6rdXKJRm8A1eMuoJwu8ABa98JhiNMMXph5+BphySuTO1vt7lKlqid91eGJhlOs31DB7WeTfDMYfVN8wnkKce4KTaxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFWuVuEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D7E3C113CE;
	Thu, 25 Apr 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714072228;
	bh=Nm7FTU4uR/QQ/4Pa2f/hMLw/t5Pah+F475PICHAm52A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oFWuVuEdZWM72zp8ipMHlbsa2Q/jF/KLmIZxrXmrl6Xxr2Bs/EThC8tz9siXbYh/N
	 bFOJYxQnRugJMtAdPkla4nifCYHxClk9hqjDuvPPBwv5mA7GWTZVT1CBlmZhNX1mky
	 ny7Nk8a2wJIlvxrKDqEByDpX7JxHT81YagcHRb2lunlmx69m3g02SAq5IJOjZn7T8+
	 wq4DN0P5H/j8RxpfZPWkJfT8Ai104VsLweqbpFhEBt2yXOqAplYSNF3HuKfBcQfXxp
	 /XP3OwVDgNl9KtlS5jtvisfSshIxEQ0lugBYOGYJfYgVxMVlaO2PSJ7Fud8UXhe+Zn
	 8s3H6Cup9gU7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D0D5C595C5;
	Thu, 25 Apr 2024 19:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ip: Exit exec in child process if setup fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171407222811.4720.17945762397454480196.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 19:10:28 +0000
References: <20240423183819.22367-1-yedaya.ka@gmail.com>
In-Reply-To: <20240423183819.22367-1-yedaya.ka@gmail.com>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 23 Apr 2024 21:38:20 +0300 you wrote:
> If we forked, returning from the function will make the calling code to
> continue in both the child and parent process. Make cmd_exec exit if
> setup failed and it forked already.
> 
> An example of issues this causes, where a failure in setup causes
> multiple unnecessary tries:
> 
> [...]

Here is the summary with links:
  - ip: Exit exec in child process if setup fails
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=70ba338cd831

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



