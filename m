Return-Path: <netdev+bounces-140873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E159B887C
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89801282301
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840515A7B8;
	Fri,  1 Nov 2024 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5Znif3r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7352F88;
	Fri,  1 Nov 2024 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424570; cv=none; b=m8qrLp74GOFzAC98Mu3gviRlES4VPcyq/wzcmg8E5k4bm7el/0kCggoMFn4O9t/4Wfzw4oMiZ0J4DTyB0wjVsLSbWoNCDETXOGUEg0BrOboSmo2ELmvl3uFUYu32t15mVbdOGB2VdTv56eON60ft1JTYsB1my9EcGQVvjZaYm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424570; c=relaxed/simple;
	bh=uHSIMvYShQpOGxo3YSOBhurKjE9wCeg9u+l5nq6I4es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+xp6IfWB+85/07wHKyUZqqQ7Z5J40Ftuxdp1x13xfQLJObfPtAJxm5w4Heq3kcUyez5uzvAdC4c2x74X/RYRmbbICrPPpFyvz0IdQleDncniGZkZHevX19UacH9SZXVOK8OiUpF4BxtnaqJEmFftEOr/qrxXC23lo0K+ECIp2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5Znif3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954B8C4CEC3;
	Fri,  1 Nov 2024 01:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730424569;
	bh=uHSIMvYShQpOGxo3YSOBhurKjE9wCeg9u+l5nq6I4es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j5Znif3rnkUb+aXBiO/ZtXTuuyoNsno793f2LzYmTu8FO6EyPPwJTFl4UboLWOwKC
	 SsTr+j2S4OhkOLt+ZWNC1OGf25KFX/yMyYNRmn0DwnCk6jU1R42ufWUTUrpGg4fGgI
	 m8vP1MWmPB9jc4ADq7sd9TN8tiviiC62ilVpk69cjJIwBrNY9VHnW6jX2iXJf/4DeN
	 6+hsSVOWTzf3SkPb7t6P6biugjt0bkv8jWsisLh6cT0jxeRYpDv6LWUCUsFsQHzwiY
	 DTMrsiGlEycNNx53RiEQ+NJQjl46JFBAkey8W68AQnZcDaQwibjhqpWSDXHhVZpnL+
	 yZ+XAaj9PmOrw==
Date: Thu, 31 Oct 2024 18:29:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, vlad.wing@gmail.com,
 max@kutsevol.com, kernel-team@meta.com, jiri@resnulli.us, jv@jvosburgh.net,
 andy@greyhouse.net, aehkn@xenhub.one, Rik van Riel <riel@surriel.com>, Al
 Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 3/3] net: netpoll: flush skb pool during
 cleanup
Message-ID: <20241031182927.342fa345@kernel.org>
In-Reply-To: <20241025142025.3558051-4-leitao@debian.org>
References: <20241025142025.3558051-1-leitao@debian.org>
	<20241025142025.3558051-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 07:20:20 -0700 Breno Leitao wrote:
> +	skb_queue_head_init(&np->skb_pool);

This belongs in the previous patch
-- 
pw-bot: cr

