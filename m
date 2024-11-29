Return-Path: <netdev+bounces-147895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4113F9DED97
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 00:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03106163248
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 23:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E7319924D;
	Fri, 29 Nov 2024 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpX+dV0N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C193C38FAD
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922522; cv=none; b=jB4CbMnLPgWHlo5kOG0Zy0x2jhjNBcDfaJwczEA56dBzrFPWWH/PwlR/xOXcvtud6xJS1GDNwvdgLaFD6DSOs3yxH6W4MUMRnYXmOUN14GnzSY9/70Wx6dMXyju3zMLkxhzDkyuaJ7pDOXqVESWit9BaLCgsDXLFx+YBzhfJmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922522; c=relaxed/simple;
	bh=QczMR6aVvMlpbCas2+NPD57SjVwelS+H/vXC/WtLPww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEuE2DSXuXIjMb+WapoJQIVmDwnqx1iao4bco84nkgMCzvmJCgJrxy8bV1ZwZwxdrk7YQ76cBely+jWK1sFK9WQHfnAwWr3aWUNRMY+nRZlxfeomgabHQnEDiBLk9GgbBE8tYuWpn4Dx5jZSvx0Uc65Kira3PvvUoRui7lGREL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpX+dV0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564B8C4CECF;
	Fri, 29 Nov 2024 23:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732922522;
	bh=QczMR6aVvMlpbCas2+NPD57SjVwelS+H/vXC/WtLPww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HpX+dV0Njtq4BOGDvk5AUlruwxF+MCJT+XgD9J22/Al7ReQWqjxrcXetT8F0a3DtA
	 AOmLHShy1rm8YJ0wQIFa/xdaFqkrkHGvQzZ8xMwttba+DqLfWx4x6B+rF/bFDIh49X
	 P/Ksr8CgLAiOecAfa9QnHdFGYsgEmZJjRsn6AOl7MwMLnkHxjDY9L8gJb1KT2BJpVm
	 LpbezBMOWewyWDjPyyBBkqeCL6Lh/jzH/6GgvcFOKVm5/lQf3odXSXR/wfvtCC+3fi
	 YKnBBx3KAXOdyY4jpcA7E30y/5xe3YNOIB/h5eWqeYBjsP0nPUW8QuOleiPjhK7pKL
	 9endbXTIe4oag==
Message-ID: <5f7a9548-b321-4737-a86c-9b90d1beb661@kernel.org>
Date: Fri, 29 Nov 2024 16:22:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipmr: tune the ipmr_can_free_table() checks.
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
References: <fe340d0aaea857d7401b537f1e43e534b69470a2.1732875656.git.pabeni@redhat.com>
 <a4ad9242-2191-4f64-9a92-25d11941cf2b@kernel.org>
 <7eec1423-d298-4fc1-bbbd-b4a7ed14d471@redhat.com>
 <14c9b1de-7dd5-4f94-a604-6007991ac17b@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <14c9b1de-7dd5-4f94-a604-6007991ac17b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 11:02 AM, Paolo Abeni wrote:
> Thinking again about it, I would use 'net_initialized', unless someone
> has a better option.

works for me.

