Return-Path: <netdev+bounces-166633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8BBA36A98
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 02:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC97A3AF3ED
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976AA7DA7F;
	Sat, 15 Feb 2025 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjVpamaZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12B38DD1;
	Sat, 15 Feb 2025 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581593; cv=none; b=GszdOMk3X2AXjjhdaFAhF0Q1NZ1LorxZ3ZKLfdp9KIXTlTVI3UJv/t0kYpJXdAnITuGwHNDpTwgnuyNrODEK01enQC8xKk6p3yHT1fYL2lVvNr8f8MalMn091eiUrFYVjrztZde49pqpCTqcOyoy3KxBh84aqpnhUPd0Vmn8FS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581593; c=relaxed/simple;
	bh=Pus445Bub0Zd9+m/LdAJhiJw3HvoSxhoPfny8Y03O0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5BJuMws3PSU5Gd8LU2KwkOAkWHgqJ4qyU3Z9S5PViaOEWcmE1XXUM0pe1and5lV+5ihZxmW5saymltQdvSPNFlVc2d0kGtFd5h55FrgHq3XjmvMWBwixUGwwoRnVWfiyJmLBO9XgCgSG+veaAxa5u2EafSgoptIewnaXrTlTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjVpamaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16B2C4CEE9;
	Sat, 15 Feb 2025 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739581592;
	bh=Pus445Bub0Zd9+m/LdAJhiJw3HvoSxhoPfny8Y03O0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pjVpamaZ20uNUM9FsSV7xTB1qZ84y12mq2I0aMcaCrNGLPPexzZ3yC8PKtL4Q/KGv
	 MHNClJL7VTmpGROleprgEEEbzU0H5B2Cp8nI6jCk5HiCHHGE+9QwWFbfOpNRKTfXH+
	 +KSXReFbU4EpGHZlZ49zNpU7QMjwBA+a+uUhTHyeRq4HZhZ9SEaDDxtPcSLFhjIT+u
	 MjZ5kztzw2GXkcWzUjitzNXYCf/T2RSWFTLYamxHDcQU8qOj5scWRtG7y0dhcskUo5
	 GTQqCDSC3368Od2+Lcr7thIz7Nl5/OW3f9MecvRQY1qcPNxlIVI3Ifz21eDacqCOvz
	 k2NKoHH7khNLw==
Date: Fri, 14 Feb 2025 17:06:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev
 <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] netlink: Unset cb_running when terminating dump on
 release.
Message-ID: <20250214170631.6badcc24@kernel.org>
In-Reply-To: <20250214065849.28983-1-siddh.raman.pant@oracle.com>
References: <20250214065849.28983-1-siddh.raman.pant@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 12:28:49 +0530 Siddh Raman Pant wrote:
> When we terminated the dump, the callback isn't running, so cb_running
> should be set to false to be logically consistent.
> 
> Fixes: 1904fb9ebf91 ("netlink: terminate outstanding dump on socket close")
> Fixes: 16b304f3404f ("netlink: Eliminate kmalloc in netlink dump operation.")
> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> ---
> I found this by inspection and was thinking why it isn't being done. So
> I thought I should ask by sending a patch.

I only see uses in places called by user space. So code which can't 
be run once we're in release.

You can send as a cleanup, if you want, but with more analysis in
the commit msg, and no fixes tags.

