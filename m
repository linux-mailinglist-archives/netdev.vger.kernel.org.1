Return-Path: <netdev+bounces-71133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD4F8526E0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA311C25460
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4429CE1;
	Tue, 13 Feb 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvAaO7vA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4529420
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786626; cv=none; b=L21oU/WySjAUNtG+qvGKdJOFPy2r1GNsoVFUFjDvmd8ylMB2nV7DdiF2Oh4hI4BMl2CqHBr27AIVwegh7/SB170j5Av3IV7riwWzYY2o2X8DgBDWKIlK/9pVVyc0Z8gF/McJjRuEvcnaq9DwLHHMGSB02rWX2Iz6kAD5Rx8kVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786626; c=relaxed/simple;
	bh=1wCCXadTPW3dSbGF0xtHBmKSUzAqsuxfDYoGZ4nrwCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G7wBnUwlEf0LHJyydVmezH3Df8puAzcHqZdCwDL4XzOr4TMvm4ZieogbOwC2gObzy8QsMyOBOhJhMOnHeYZz0gF6mUz0x6LzVsValDQm4NYj31evxGivq/m52xFtwdDTrKP6wR3zGQYH8jGvIec7W2UhAE8Ctu6+IX/tYPykVno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvAaO7vA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0DF9C43394;
	Tue, 13 Feb 2024 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786625;
	bh=1wCCXadTPW3dSbGF0xtHBmKSUzAqsuxfDYoGZ4nrwCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DvAaO7vA6q4ltq5KqmeexmSfG66F/qETGi9/oaANwqrLAlqyiRxzWHrnrHlCCbUXL
	 iBH5rxT916VpQjvRHmT3V/Q/rFccPhOlpwya7m89xK//vksC2TiiIpmg5fz+t29dkf
	 VA8LBURrBNTzYQFB+t3upp7RLEWHP38Q3CLQ+EO7iwl7IhWxnDqEkRtCegIsVEVOn+
	 D7Yoazx50DxQ9rjpkrHRXNkG8dwLq9mR/vO+kMx+lKdda3VlPYNrtzQ90PbG15wSdJ
	 fn47I2HuL0ySabJJTvU28DqwTZIB5ifGSMixXklNP6o3+Ebrff5Bc3TyOZS58y57Tc
	 uSYd8H7a18F8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 974B2D84BC6;
	Tue, 13 Feb 2024 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] i40e: Do not allow untrusted VF to remove
 administratively set MAC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170778662561.1111.13664477407499666556.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 01:10:25 +0000
References: <20240208180335.1844996-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240208180335.1844996-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, ivecera@redhat.com,
 horms@kernel.org, rafal.romanowski@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Feb 2024 10:03:33 -0800 you wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Currently when PF administratively sets VF's MAC address and the VF
> is put down (VF tries to delete all MACs) then the MAC is removed
> from MAC filters and primary VF MAC is zeroed.
> 
> Do not allow untrusted VF to remove primary MAC when it was set
> administratively by PF.
> 
> [...]

Here is the summary with links:
  - [net] i40e: Do not allow untrusted VF to remove administratively set MAC
    https://git.kernel.org/netdev/net/c/73d9629e1c8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



