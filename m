Return-Path: <netdev+bounces-235642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0F5C336EA
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 00:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E183A63FE
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 23:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F1A34C819;
	Tue,  4 Nov 2025 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnHdhGfn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E034C810;
	Tue,  4 Nov 2025 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762300626; cv=none; b=m/3e440dWUEDWA1R1q1Jw6jLieXwhDZAjCmfsEMICXpM4imm7KQBpjk74UKDe3nDI+pFUkwt214uIZMZwepBUSN5oLbWsqQl7zV4otS1BPn9ewNtpUilSGgOAF+vw0WGnuxazD6uf4e1OhOQmgJr1r3e3o27nJMznPWXahNqG2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762300626; c=relaxed/simple;
	bh=7szNuZqciomfxU784krO5KdlgMU9J1zWp2fdAKyPgB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADesrp8RZby1oBWcbysFkYLyWiCetD/2i/YuCfswILtVUzD0wdbmVkcay5KOHQ6dsffiPx5ZIopL8FUd194sUqHic6smeiLslWCArWrO3iR+1lp3pJPJC+nXpAynBRRktq/M624lnw3HmLjr2vKk3yfwGa+x4hRnfcEDgQn2Hyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnHdhGfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD272C4CEF7;
	Tue,  4 Nov 2025 23:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762300624;
	bh=7szNuZqciomfxU784krO5KdlgMU9J1zWp2fdAKyPgB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JnHdhGfnDjvzq5t75068cbUgLfpwI+6mHlEx0aAWUHaEqDxEoySHAwBQ9XMDvBWfR
	 AWInN+mIYDejZsmcuw9F8oj/XzC1gicjEI+fgmPs218q9oxT5dVvJGDzdv+01hjcdP
	 dORUQwkRUBogMT/Hw8+M5Eix8o/nP+Qz/jKSxhYXsXE2ybM3UA9WQubtrQuBOvEREy
	 5n0DZLmWnoqS9OiuLBwzuct0whtQc9W4Y3GloLNqOPdh4UMBGMX558hu9xkHi7qhIz
	 /VSajzDHA+r6YP6F+SUbdi5H5wT8u8ov5E5Q488w06F6Z9AW0z/28oH1f9pf+bH0w5
	 vMeKE/VJb8hSQ==
Date: Tue, 4 Nov 2025 15:57:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Doug
 Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Antoine Tenart <atenart@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, Yajun Deng <yajun.deng@linux.dev>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v2 0/2] Allow disabling pause frames on panic
Message-ID: <20251104155702.0b2aadb3@kernel.org>
In-Reply-To: <20251104221348.4163417-1-florian.fainelli@broadcom.com>
References: <20251104221348.4163417-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Nov 2025 14:13:46 -0800 Florian Fainelli wrote:
> This patch set allows disabling pause frame generation upon encountering
> a kernel panic. This has proven to be helpful in lab environments where
> devices are still being worked on, will panic for various reasons, and
> will occasionally take down the entire Ethernet switch they are attached to.

FWIW this still feels like a hack to work around having broken switches
to me :( Not sure how to stomach having a sysfs knob for every netdev on
the planet for one lab with cheap switches..

If anyone else has similar problems please speak up?

