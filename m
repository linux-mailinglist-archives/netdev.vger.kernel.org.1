Return-Path: <netdev+bounces-225478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B576EB93F8D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 04:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8703A442DDD
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17926CE04;
	Tue, 23 Sep 2025 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMSQel88"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F226B2D2
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758593409; cv=none; b=E5k29aqDq7bvN/EfvMXivHrRHXbFoC4EIGZktmM0neU8ewJ0jC70LN+lg/dijBvN1M7AuhJxgX7zA0DAmmqbHxjhPvmDR4mRSJW0jVTcCttb2CpvJJott5A12QrAPdbnEOkzunZwkYNwMlZHpa5rGd9r0wc6nuQFvg5jxUm4+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758593409; c=relaxed/simple;
	bh=tNtlblwbhuXX4L2L46AZOaPrJZP/ACNJ3TbRHZgfQr4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tYnwAAjSzl5HE0Jteb0kwT1IIqG4rMZGRMNmZqaBFjDfCv0fGI8hjxnMqXjQa9/xdD7nOOKsbyScKBG850jdc1QpYg78O/nAioMkhoz1bhYAcrSUC0rnIqv4m2LaoJMr1xDXf9Twr3HmAmUX0ZijTxFOSDqmwf912/mZo9ruDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMSQel88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD8DC4CEF0;
	Tue, 23 Sep 2025 02:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758593408;
	bh=tNtlblwbhuXX4L2L46AZOaPrJZP/ACNJ3TbRHZgfQr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RMSQel88rmaCMuuFqrBXWLya+DW6hurXWzyqN9+iMo0KifZcth9yqos7ym4trES68
	 jzBJ8OvcHsnSwLnY32I6d/ZmzSkIQywsxks3GUTRgtFCGAK+iPOORPVBhXR2o2YUkL
	 VifU7QjuFw7oEuW65Ni6t4fFm/cZ3KKk0HM0J5ja5mEkaDdICjCLvSD8IWW9gz57WD
	 /jx5r7HjxciYGnKHntcB9HS4hNa5vpESDLbn3owIHC9P5BZ8oRX7PhqYehvwlwNkx+
	 u/OlWRJwZnlsturM9bImwg0CzwTKkExDWeDoAFiA/ySVViJYnk+T3QcPFib9FyPHWM
	 Pu9oE941frAfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7F39D0C20;
	Tue, 23 Sep 2025 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: correct offset handling for IPv6 destination
 address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175859340625.1231487.12544692897469923771.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 02:10:06 +0000
References: <20250920121157.351921-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250920121157.351921-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: netdev@vger.kernel.org, somnath.kotur@broadcom.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Sep 2025 05:11:17 -0700 you wrote:
> In bnxt_tc_parse_pedit(), the code incorrectly writes IPv6
> destination values to the source address field (saddr) when
> processing pedit offsets within the destination address range.
> 
> This patch corrects the assignment to use daddr instead of saddr,
> ensuring that pedit operations on IPv6 destination addresses are
> applied correctly.
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: correct offset handling for IPv6 destination address
    https://git.kernel.org/netdev/net/c/3d3aa9472c6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



