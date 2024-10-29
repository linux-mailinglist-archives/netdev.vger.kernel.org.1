Return-Path: <netdev+bounces-139770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C919B4088
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 03:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41B81C21D75
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 02:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE5F1F429A;
	Tue, 29 Oct 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWyONwlq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649C1F4272
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169629; cv=none; b=YLd4C6djx4IfiE65MOG25Ba7d5Mu8W/UULiLoASHz2EubBsJxYgst9rC26HnahEwo9FKlnRIvQ60ZCDuwDH5lV1Rs9tzOaxQvXpU/5eSRHpbF2L/arYBzNfhJYyD9lZWqkjgRTqVB09QoEMQA8Msr7BbRpD/jdokDR1rjFGj/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169629; c=relaxed/simple;
	bh=N5CZce1mcLwcr/s+xON4bkSo8jZ5b6QNeoSbfol4XaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sqa5Wdsvu9Svz0bBAgM5nKQzO08FU6dNZKdkoxUyhFLcFyG75sVcaBcfY/khuANUjzG+i1WT2Dl8grO+ejp1/sZHFp9XOFe0UCu4WgoZ3mdu1b5LmsWLkEB5SeoPr4+EcfF6rCkCnY1jqIw38hHQBa/Vku34rGjNCHgsmQ/dm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWyONwlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D78FC4CEEA;
	Tue, 29 Oct 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730169628;
	bh=N5CZce1mcLwcr/s+xON4bkSo8jZ5b6QNeoSbfol4XaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bWyONwlqKDy3htoMRhlHV34kVj5N4AzGJrpuqZsEVxr/ffUSDHMcPHBwMgkYY0FdZ
	 KCNXFkr+7oY4vEpdKIspospOUrJ/GLPHl+Ru5XiYD744p18YXA35MqhMltgGi//LyN
	 grYDhxOI3IRgLNE9YyrAKAAzlNV5mYOIL8VZp3nNqLU3QJtk2mfllsubmpup4gpEAn
	 k2AImdbjZfFcARff7re16mJpSq7Iy9F4VLgOqASc0rcFz0CpiGzB1H2B2qScpdcxN1
	 s1pG1jfre87bwprJXwtNb1iGLJ4YWRZp+Ok89m0vPOk67obOjEgr3CfKK+1K/vKHKG
	 eLinD6FpYeaSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC1380AC1C;
	Tue, 29 Oct 2024 02:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vsock: do not leave dangling sk pointer in
 vsock_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173016963603.250007.13782396385062066656.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 02:40:36 +0000
References: <20241022134819.1085254-1-edumazet@google.com>
In-Reply-To: <20241022134819.1085254-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 ignat@cloudflare.com, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 13:48:19 +0000 you wrote:
> syzbot was able to trigger the following warning after recent
> core network cleanup.
> 
> On error vsock_create() frees the allocated sk object, but sock_init_data()
> has already attached it to the provided sock object.
> 
> We must clear sock->sk to avoid possible use-after-free later.
> 
> [...]

Here is the summary with links:
  - [net-next] vsock: do not leave dangling sk pointer in vsock_create()
    https://git.kernel.org/netdev/net-next/c/ba4e469e42fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



