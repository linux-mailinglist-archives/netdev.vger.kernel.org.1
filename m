Return-Path: <netdev+bounces-118878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0585D953672
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AA61F22097
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD93B1A7070;
	Thu, 15 Aug 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXZnrDfz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E91A7056;
	Thu, 15 Aug 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733993; cv=none; b=reMGQfZ56AKg7O3WhPLlGF9Wn+qstAx7IkV21GquaAKqg7nnkiipbD/lbav27KlyAOxVSnd4LexqhBphgR6RhAWAdwnyFjyQOtzfbPq5IbnOCYEWhEONQYa4y/s9sz/4Ky4+W/Q+TlWWDpKpgv7xhtMJeFCE5b2fbmwy9qLtnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733993; c=relaxed/simple;
	bh=axzV84sTOBkMFNDA65/4Hd30T4z6HqkNfAMeRg+7hM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+9WcuLDdJv5eh4bcmH6RQBT/1wM7mOe3+K3AcaemDdrOPXzd/TjAR271CkuS+sYk691RrNTb7yNMgcozzPc4iPtxBCm8Jyc+EU6mbKRVq1Wd0gAFlCnuu/bUPVSdPTRdzSbiQKQsU4WlyYOyPpsarMT58V/dSzz5TPm9WDQPA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXZnrDfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCDBC4AF0C;
	Thu, 15 Aug 2024 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723733993;
	bh=axzV84sTOBkMFNDA65/4Hd30T4z6HqkNfAMeRg+7hM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXZnrDfzqgsn/8IHUcrZLsOI4rbooDnR4oDfk0CD8qVga++mO4CDNPx1At8FOGeIa
	 6eTCTZhY50nvyAcPpGLVbSSdtz8LveTL5q25XuvR9tDu98h7DErok/+Vw+rwx9cAS8
	 GVusfbioZ02oBUcMtGCjMUOycB97LRkypc9qcrPM0isykvtqt/R1KQ91zpq04ubR8z
	 7vbYh+eCrznxolX/NPqXONXYcz7MIq9r60w7jQIL9W4Lo2fYohJhsXkNv9CcK/QG0j
	 5zzU7Zh+hz2Q1ZIMQkC75M7tQHSfNwnl+4GtZFklgmYBjQA8AjqPAWq+OKaVQ20n5w
	 yRn6Xgwvabs3A==
Date: Thu, 15 Aug 2024 15:59:48 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>
Subject: Re: [PATCH net-next 3/4] net: xilinx: axienet: Don't print if we go
 into promiscuous mode
Message-ID: <20240815145948.GH632411@kernel.org>
References: <20240812200437.3581990-1-sean.anderson@linux.dev>
 <20240812200437.3581990-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812200437.3581990-4-sean.anderson@linux.dev>

On Mon, Aug 12, 2024 at 04:04:36PM -0400, Sean Anderson wrote:
> A message about being in promiscuous mode is printed every time each
> additional multicast address beyond four is added. Suppress this message
> like is done in other drivers. And don't set IFF_PROMISC in ndev->flags;
> contrary to the comment we don't have to inform the net subsystem.

Hi Sean,

FWIIW, this feels like two things that could be two patches.

...

