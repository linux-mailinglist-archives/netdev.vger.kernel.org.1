Return-Path: <netdev+bounces-213516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4BFB25777
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 01:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F801C80F11
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 23:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9E72FC864;
	Wed, 13 Aug 2025 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB0HYIpg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7730146B;
	Wed, 13 Aug 2025 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127631; cv=none; b=iuJcEzZ/AVKtM2dUC6DlxxUEvNsXAFlLjque4sQMqyHFITHUD+3Pf3NSrDykSqqCI8aWcGcJP+hOmTEDktPmHYkwkHRDYqWBPcfuvnhfGq4uqbedsoiCQVnSzrN/+Hr04FFJea9GjUWhRLZ3hD41rqnxAvsw08tTE51RCRKLdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127631; c=relaxed/simple;
	bh=/+uRyQIzqvnBbZB6lbuoe2WVnbGT3rLMGwqUpYez6Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppDhHAEUoVRMuDvr22EWErf+P7nV/i1z7nBiKfRpxUjywNCtQFtHg0Qg9BPwpyLt9lf3e7AdK1tDbK+nVJAVYB0MMC7vZkFsIaPNagvHrmuRN9XwZgsVPgR7kbS0lAxmOAZljoTnHe+UTh8CFBz9sllSNefFchjTcWqDzl0rv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB0HYIpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2344CC4CEEB;
	Wed, 13 Aug 2025 23:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755127630;
	bh=/+uRyQIzqvnBbZB6lbuoe2WVnbGT3rLMGwqUpYez6Uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XB0HYIpgH8KcYNjhEqKyOFZfN6oNVG8YZuEjF5NK4hjAj+QJntLrO8/IDzenBjiWw
	 TPQIR3Zj0aP05DjXrzQOBLz9Lh7JxD6IhKlYtUdtLHIvbXgmMQWRbWBevgoOXeT/h2
	 OFnlp23AzrGHtqrrjfx51WwQy8xaEUf4Ky3ha1Gy0ooqFJIxaRCY11bqfUHX5vZV/R
	 HhH/KJBUNSLkjMXebrcTcum4ty06B+pntpwFYGie6B5lng0HBx1paaWPPr7/eeqaqb
	 XqFKCyAtH+raEO+A6iuPIqiONP2+hvQ6ZEwyI0X/V7kAy7DiDZLjvfcvRpagc8JbxO
	 AR73bkVy3e+Aw==
Date: Wed, 13 Aug 2025 16:27:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pengtao He <hept.hept.hept@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Mina Almasry
 <almasrymina@google.com>, Jason Xing <kerneljasonxing@gmail.com>, Michal
 Luczaj <mhal@rbox.co>, Eric Biggers <ebiggers@google.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH net-next v3] net/core: fix wrong return value in
 __splice_segment
Message-ID: <20250813162709.6d876ba4@kernel.org>
In-Reply-To: <20250811232801.28489-1-hept.hept.hept@gmail.com>
References: <20250811232801.28489-1-hept.hept.hept@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 07:28:01 +0800 Pengtao He wrote:
> Return true immediately when the last segment is processed,
> avoid to walking once more in the frags loop.

Please explain this change more clearly in the commit message.

Took me a minute to realize you're concerned about the caller
behavior not __splice_segment() itself.
-- 
pw-bot: cr

