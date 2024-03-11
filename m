Return-Path: <netdev+bounces-79047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79D877968
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 02:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299831C20B2C
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 01:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5558864C;
	Mon, 11 Mar 2024 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbD8BxAW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149B631
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710119410; cv=none; b=hbCSrs6pSt59PY2R0PxRgt40cr39rzQeMhSdloZ4rgUJ6d4mh6/4e9pQ/w5FMpPs4J7MbVxopI5MhNnd98LV7bD1UqFnm2VDpiERnNuWjlsGuwt9vqMCUlTrbduSLCLvUNwQt4Z2TmOzPHeGCLvOodmkM/ITzLoocZZneF5zj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710119410; c=relaxed/simple;
	bh=0qmoNDEAoiLRFtm6J0UXmwnhvJVPbUTq4PbOTwG8zTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuNkEeTvM2I++XzOwYDp2OTyI6F7/B2T1WbtWlDEK3ukRnNc7enF7CTIsBwl6L5MJFR69+rLs6lYiCpYyB2nbhayPOvbZsYolPxEBkFCGjzalVsRJFBObCIFYNE1zPuhuRYSbRsOI5hzO/ZSoloy18tkBYX4vxJykKks5vEuwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbD8BxAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A087C433C7;
	Mon, 11 Mar 2024 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710119409;
	bh=0qmoNDEAoiLRFtm6J0UXmwnhvJVPbUTq4PbOTwG8zTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UbD8BxAWV+VN12U+QiESAaKPakrwA0myKfpO+qckFeKPSN/wE/nElE+3UpY9WdB7J
	 hvQ2myjiQdfn7TveX6KMbESl63biywZoJNqmu3UfdiIdgMBrufYALGV+J7MPX2WT7o
	 nlE8uKrTRMSwBydSQ2cKMCJI0+l62xjLQS83Lmgm1i5kHWo2h/KcaiXBmbDvjhJSUL
	 UViy0du1TzdzjO+JwWV1RH27jMFUsyhdat2KZ6ZWabxWcSVFam1w+WExFzxPQwKhO/
	 wxn5RAWGOe4vcF2QhjAk7qgKCVDWVMNaqG8HAYZC/BgXSM6vTA9iQudmrB/IdcdMp9
	 nEtOdlb17LEKA==
Message-ID: <913ad46d-4cfe-4f79-81d2-fd1f01dfb026@kernel.org>
Date: Sun, 10 Mar 2024 19:10:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] nexthop: Fix out-of-bounds access during
 attribute validation
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com
References: <20240310173215.200791-1-idosch@nvidia.com>
 <20240310173215.200791-2-idosch@nvidia.com>
 <a92e609b-f5c4-4e9a-8eb8-7e2c54f75215@kernel.org> <Ze4pIe_E4BgkCP6w@shredder>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <Ze4pIe_E4BgkCP6w@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/24 3:41 PM, Ido Schimmel wrote:
> However, I can add [1] and [2] as patches #1 and #2 and then squash [3]
> into the current patch.

yes, please. Thank you for the fixups.


