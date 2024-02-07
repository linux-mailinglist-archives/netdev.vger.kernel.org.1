Return-Path: <netdev+bounces-69689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D20384C2E7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 04:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D888DB27CD5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5B3F4E2;
	Wed,  7 Feb 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew2Z7CTA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD22F9C3
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275027; cv=none; b=di7OB7ga2tq9OHJI8pbLvCzc8XwlXSDJNIqyE/i+bQz4fPNQRHNESHO9PcfKj7KSazpWQ8BfQXARboT63KZ29P+9fVk2zwhzJBvhoIqJlDWukO+t+Fiyo4CdCS5xVlrVLtWBKLfTxDKlj4IhuGo66udR9t/qbNBwmk7FvIOrN0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275027; c=relaxed/simple;
	bh=h6EFqyNlajLP6gdOJTpcprymbM9QDQzB7srBcRs0wg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVrjGHLUqLlGUzFMpw6fMXCC43mLgnQhchS5tQfmQSqja9VPjYDPw/4+l6WnmE/zi30BPKCnaIKkFFxG4JSZOIWUFWQKCZxKi/RU3fR+pnHZcvh2EGQShop+oXIHaRHGvvFy+20sYpilqk02Kzn3NZuJWK8fkkkOGd1F0TRuFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew2Z7CTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98760C433F1;
	Wed,  7 Feb 2024 03:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707275026;
	bh=h6EFqyNlajLP6gdOJTpcprymbM9QDQzB7srBcRs0wg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ew2Z7CTA1ZhKZyjNd/vHg85wrZQIcXb/l5Amtx4r90PUaTAdF1SLF5HwDtSTv9V3v
	 fDM6tE57URCeAXnhDKUxtR6jQQyNMuZHWvtYg9u1KyVbwkq+JXOgeMGL86OGc/VAtp
	 w86nGVoF7DWWtwvuUIeEoB6DzZcogOfJYyJzFyGYQN99wB2I2Oekirv/Nxo3AvpDGu
	 CAGld83cpkAHokxxWfdE5sUIg34G9NAnWsVWXByGo2nhU+e9UiIHkGlpF3whqqNxX1
	 Q49vB+qV+eHk0+6ikDqTpiTzWhMHxWIJ5zx5VpbVVa4FqQeY9IC1+mStgiIZhYSoeZ
	 ffTbOeipLt1PA==
Date: Tue, 6 Feb 2024 19:03:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 0/2] add more drop reasons in tcp receive path
Message-ID: <20240206190344.508f278f@kernel.org>
In-Reply-To: <20240204104601.55760-1-kerneljasonxing@gmail.com>
References: <20240204104601.55760-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 Feb 2024 18:45:58 +0800 Jason Xing wrote:
> When I was debugging the reason about why the skb should be dropped in
> syn cookie mode, I found out that this NOT_SPECIFIED reason is too
> general. Thus I decided to refine it.

Please run checkpatch --strict on the patches, post v2 with warnings
fixed.

