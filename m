Return-Path: <netdev+bounces-227491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D78CBB109D
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 17:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823B17A11C2
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 15:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DBF267AF1;
	Wed,  1 Oct 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URxChHjt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A226158B
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332038; cv=none; b=mVaEXTKgp+vckOcCkwSfl2E/yOpDhJoSbHfNottOgeETxdpRfjoBj6sbJg3HJk/SL3MmAK6RPtOCXHN9vVymbtloMc7SEPR2AH9VF9ufcoqq4OX9Vk+lp1Sq1zC3IBgZBV9SVQnbCBzV199RhVEtBjoY0+s8cLbRZDBS4K+GAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332038; c=relaxed/simple;
	bh=BmUBA6ZOBJs6FMvXK0vpIKuB+p2pN2+0A5070Nj519U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FHrZnVgJYaJVUWQm+Osag4MlTdK/PKhcsy8z1hUfr16U+5C0veOLxhFJ7aQumrDeVpUlBP6L4aEn5PXZVKheG6O/vKERnT2VszlfFN6t2P/A/21Juu1Xj2QHjNgM2F6LXHq/CwaARWLHO6fkpI0ZUdgrtp2wJxnpP5duXFSZZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URxChHjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40F0C4CEF5;
	Wed,  1 Oct 2025 15:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759332037;
	bh=BmUBA6ZOBJs6FMvXK0vpIKuB+p2pN2+0A5070Nj519U=;
	h=Date:From:To:Cc:Subject:From;
	b=URxChHjt/VMcr7uhUWhQyiLDbbZBCZTnNDfP8HLnm/P+diZm+aKi6Lo6QAGdZgOwO
	 h8jXcjcLfWlRvyS9DHFw3CP4gvtFOwgm0cXfsNhoBltGWi3fliQjARP5pGUM2ylT1z
	 mPBS0p8eBzC1JnvtDmi3LqqvCHx2UfbaVBdh/d7cyXLnAUW7kgf9BJMLWKM1nhRvqg
	 g8pNFcZuuF4jDK7ia1cM2fhZmXgOgG95kLtoQF4NKxmZYVD79ML07NfZdnRMpR9A7A
	 reMp3xuLOYivUAenwGvj4kSB+K7CVrGvasFs6Jl9qj2zDvKyaabyTLgv16lVUo51PZ
	 Q5/0uAdXkz4Kw==
Date: Wed, 1 Oct 2025 08:20:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org
Subject: deadlocks on pernet_ops_rwsem
Message-ID: <20251001082036.0fc51440@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

We started hitting a deadlock on pernet_ops_rwsem, not very often,
these are the CI branches were we saw it:

 2025-09-18--03-00
 2025-09-18--15-00
 2025-09-18--18-00
 2025-09-19--21-00
 2025-09-21--15-00
 2025-09-21--18-00
 2025-09-22--00-00
 2025-09-22--09-00
 2025-09-23--06-00
 2025-09-24--21-00
 2025-09-27--21-00
 2025-09-28--09-00
 2025-10-01--00-00
 2025-10-01--06-00

First hit seems to be:
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/302741/65-l2tp-sh/stderr
Two most recent:
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/321640/110-ip-local-port-range-sh/stderr
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/321281/63-fdb-notify-sh/stderr

The stack traces aren't very helpful, they mostly show the victim not
who caused the deadlock :(

Any ideas?

