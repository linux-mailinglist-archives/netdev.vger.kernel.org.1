Return-Path: <netdev+bounces-242655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8BFC93757
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092933A70BB
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 03:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320C2288F7;
	Sat, 29 Nov 2025 03:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVEOlIbl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA892264C7;
	Sat, 29 Nov 2025 03:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764387902; cv=none; b=jycn7cPm+QBpwyOrC0k3nuqWX4CIm4P+Evh6SdUXo5c27sqb46rZhO8lDJv9bUYVi9FwPbLZRDF08o7leN63R2wObxRKRbdKVDRW9xyfTSCt/Y7/udEG3GkyYAqXhmwdz1sLX7C1oEr6kOHmECEfkmL4C2PhH41RhgLHRN3VVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764387902; c=relaxed/simple;
	bh=YbwilgYqtgRDLIfnce+1RpdmeG/I0gavWzH3W/YPEuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1AJBCkLiFoUxSbLZABkapaGbdOrpXyf28vj2rCJcys7sJnOm3UaIOGsLfw1ZWxoZnZVmcKFwWNSbDePBKHLWkpDhkg8uemWAGgj68s5NSmGUNNOKfMZl2jFd2IMJtPa8Re4AlCI419NZiH33qgPZiJC5Td/mtQ3fzbWSi9ZIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVEOlIbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1962C4CEF7;
	Sat, 29 Nov 2025 03:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764387902;
	bh=YbwilgYqtgRDLIfnce+1RpdmeG/I0gavWzH3W/YPEuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVEOlIblF1QknG/HWq61IMw4hCUvjx/mzlSlMiRdXinsAiZ184m8uO8Ys0NNg8A/S
	 lUqy+j1q57iHg9ubtLfqopF30HcGUDwHXFuMS1eC5jGFVBI2hVBSnEuspS8FW2+lsj
	 Q+8mcMgoc3Hj9grVNKCYAX3xm+/K5XVnDCJn+9oVFrBwD88zH6763/vPLGzpHMd1nt
	 p8LPtJl+TKzflluJFhtp6/vHaD68b5N+U8aOVy7qfr4sKbO5iWfu5xX12QdhokxcsK
	 RC8jUZf75koya68P6O4xE42NRKRgjwRjBfNW0l+AJ3XOG07Un5HAEHMWlt3GFIWP2T
	 hbwDef+gwpblw==
Date: Fri, 28 Nov 2025 19:45:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangfushuai@baidu.com
Subject: Re: [PATCH] rtnl: Add guard support
Message-ID: <20251128194500.052b780f@kernel.org>
In-Reply-To: <20251128083455.67474-1-fushuai.wang@linux.dev>
References: <20251128083455.67474-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 16:34:55 +0800 Fushuai Wang wrote:
> Introduce guard support to simplify the usage of the
> lock about rtnl.

We don't accept APIs without a user.

Also in this case please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
-- 
pw-bot: reject

