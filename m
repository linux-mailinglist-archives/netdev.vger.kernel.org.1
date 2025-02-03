Return-Path: <netdev+bounces-162310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE0A267F3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362723A54A8
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 23:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87671FF60F;
	Mon,  3 Feb 2025 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isC1NeLr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E993597D
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738625892; cv=none; b=vCrhTAwpV8OXfm3vL/qfCaOks/Ws2UzSOyOid4h4QQd4dyeV6zKzZc2nOMR3hRm5E9Jya/z3A/A6MDIVGMgZVRkOUvUojlLR7jGyJI1es6wSiVPDV7xiqz/S/6qYqmYQX7PO/nsG9H3afRnRAMGxJ5zpgVWhrZYafLNKN/rZ8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738625892; c=relaxed/simple;
	bh=wOB5APFRD7lKXceCmyUMkwRw/p9/pQ1vaUsnthrRaKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDwW/ycyRlc3Uccxsb/PIzTfepOs6zEhG1n3z0Da550v8Cx/HMf5YeV1hFrwv2COq4sIbL/kzSxlpJSKWoGT1hwZVnzIbo2SPz6he987MDZ8gJms5zbt5/PXFk/QX+AGswHa42tpOEwziuZEs6xjj/ac8UmsqFX1s2DcouBUtpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isC1NeLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9988CC4CEE0;
	Mon,  3 Feb 2025 23:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738625891;
	bh=wOB5APFRD7lKXceCmyUMkwRw/p9/pQ1vaUsnthrRaKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=isC1NeLrKVogTJGSVwzrvFyBmryftqLJnHSXnqkKExWpvC3u7ZmH7W4wslq/DywXg
	 U1RnG49mzyIGbc4pj3Q38NsYq3pSSCTxSFfMJN0EAEDvkC0H6Btu3vbT26ERQiyz1L
	 GesxiWfQ9bs4OSetOSR90sVTWo9Er+vNc2elqAfohp2grLMhMUn/iydUZj3U2eVCXb
	 RcQKCDCZZ2u1la3EM+HNtud3g8F8pAr3u7ybdNvgLYZ1ZX1kiHypUwpKz4zoUR1Spi
	 4VWzxeEO9bPyjPvYbM+1fU2qtCvrF+xUdKdHG1OpFIlwAkc+eDD470lSM0/NPSquc9
	 gyJ3eU/4cU/6Q==
Date: Mon, 3 Feb 2025 15:38:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net 15/16] flow_dissector: use rcu protection to
 fetch dev_net()
Message-ID: <20250203153810.4e68a6e2@kernel.org>
In-Reply-To: <20250203143046.3029343-16-edumazet@google.com>
References: <20250203143046.3029343-1-edumazet@google.com>
	<20250203143046.3029343-16-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Feb 2025 14:30:45 +0000 Eric Dumazet wrote:
> Fixes: 9b52e3f267a6 ("flow_dissector: handle no-skb use case")flow_dissect")

This Fixes tag looks corrupted, in case you need to post v3

