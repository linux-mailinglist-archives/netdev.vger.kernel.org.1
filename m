Return-Path: <netdev+bounces-185316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E5A99C1F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188F37A6413
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF98B230BEC;
	Wed, 23 Apr 2025 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpuMwfgF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFC13BAE3;
	Wed, 23 Apr 2025 23:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745451873; cv=none; b=GRvC+98Kzaaspy6DfDzrYVmXEVlGA8iGY7c5f8JKEpHQjDs4JjNS/ZCVyu2E5f4GIQUX6G3a42E4P3Q+05fGItMUznkyXUmAE3ySpspfea2cbDwYO2Y9w31NpxrAsfLzS2ovY3P1sBPq5DhYo14tmgBRdSDLIUVwFtHrm9vF9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745451873; c=relaxed/simple;
	bh=nfEmVFl6mVYlCBOfaDHhjTRP5olod7uxnR8QEfWiM5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDdmLFe5LCfgmreoY1yX0iZIo7/ppVE/r8yAKccKSDuFl/9HIRQSK3q6q0sg6Kp+DEL38fZr93CTu7Ftygbre+QVO1Hnszg7DZ9tccev43eXxLk3egH9N+E6Q3sTRlGMT8XsFbrQ4mTyIO+rxqD7GHmr5+0PVqbjBuAVJclH9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpuMwfgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6055C4CEE2;
	Wed, 23 Apr 2025 23:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745451873;
	bh=nfEmVFl6mVYlCBOfaDHhjTRP5olod7uxnR8QEfWiM5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TpuMwfgFALX0ANuEMW9msVslrOjlO3cBswGpHhnJe2mofHWSvV5GJAiG8bUTSnK3K
	 pthg0DSJuv+cbTukxAhqwIwychuPbCS9QTKbxdvx/hewtJxl7c0PCChM1pUEakiOA/
	 NBu14pI+VP2ysrPRZk8731WHBmEit7nt2Fgd2zeZ2aKaEw8LoC7Y/qR/7OpKhfvaL6
	 wLYDSGXzvpOucjrcm/FN5YFQCN8yIh/XtVJ2fzjL5Dun3T9pzbuINzJJaiokm8uq6J
	 bvu0waRnZLbOQdg+3F6bJG6Mb/GXE0WnGaqnfy4H1XsBtVY1b7JEUkindlHz9IkieW
	 OFk1ObuhiyI4Q==
Date: Wed, 23 Apr 2025 16:44:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v4 0/7] ref_tracker: add ability to register a debugfs
 file for a ref_tracker_dir
Message-ID: <20250423164431.7b40ecae@kernel.org>
In-Reply-To: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 10:24:24 -0400 Jeff Layton wrote:
> This version should be pretty close to merge-ready. The only real
> difference is the use of NAME_MAX as the field width for on-stack
> sprintf buffers.

Merge via which tree?

