Return-Path: <netdev+bounces-177716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECFEA715F4
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532123B64E9
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038171DDC04;
	Wed, 26 Mar 2025 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl8NgmRK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1A1DD539;
	Wed, 26 Mar 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989234; cv=none; b=brNBLkRz4nvc14SdpVf/yn75Rnjt1C6u3I8TP72cBr9Pap3NYjqslTA5dTfyGGl5sOXj5nxdLFNz4ibevIyVsnhlP+yBh0Jazkn/Iu16Nd9BPH7aEEU8U+7uNW8X/lbEmjLT7unhe/oGdl9vkMQZ9t0THRoomabha9nikOijbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989234; c=relaxed/simple;
	bh=S4Y5Lp9S60CEFrO0+Skg6aj4t8NQylWLvEAiP2Hr4hA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxpxe9tSClMSO8zBMd1RrtfjRL3RzEI2J+Ede5t8KNgY9VmhBI7oinf9eQwAIoC2Ui76qBi0X8oTkHmqVTqkbh3Bj+NDVVjy3+GE6t9MXhjNXWOv/Aaftm237Xp61kLc1DTjmnG40kKUU7AI/5m1UhOemcuFm2mjzGJBbpWn9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tl8NgmRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC01C4CEE2;
	Wed, 26 Mar 2025 11:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742989234;
	bh=S4Y5Lp9S60CEFrO0+Skg6aj4t8NQylWLvEAiP2Hr4hA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tl8NgmRKuvPwdQPlOzI7hW11C6rkbyHIycr825TLIo5pfATVTMK5fH9v8knXlYJi9
	 XYVLLQPGqH6mPw967lyZcAb7QhyialB5dxu8DsjpZZyo8sZk1h6NDoa5uFH46SXS4s
	 wSYZTouMwpAU2PoK3ZAINJL2yblcK7S2tE68eARjQ0tsQ5wUGaVd+7q6E59FZGIEGO
	 RBQGLFNczdj7+YZ3VXYqLFiKMtwe9WbNwwjApzQTm4Ejb5YwSUwJo1/teKgLKFTo1V
	 2m01QUaLd5lb/hl3JNireEJaGdpxhfdUlZcKXLXxgpkSbhps7GkCFsYhsMaRXSLzar
	 Bzfa/pDGNq+mg==
Date: Wed, 26 Mar 2025 04:40:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Ahmed Naseef <naseefkm@gmail.com>, asmadeus@codewreck.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com
Subject: Re: [PATCH] net: usb: usbnet: restore usb%d name exception for
 local mac addresses
Message-ID: <20250326044032.7d85c359@kernel.org>
In-Reply-To: <Z-PmScfnrMXqBL_z@atmark-techno.com>
References: <20241203130457.904325-1-asmadeus@codewreck.org>
	<20250326072726.1138-1-naseefkm@gmail.com>
	<20250326041158.630cfdf7@kernel.org>
	<Z-PmScfnrMXqBL_z@atmark-techno.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 20:34:33 +0900 Dominique Martinet wrote:
> Jakub Kicinski wrote on Wed, Mar 26, 2025 at 04:11:58AM -0700:
> > On Wed, 26 Mar 2025 11:27:26 +0400 Ahmed Naseef wrote:  
> > > I hope this feedback helps in reconsidering the patch for mainline inclusion.    
> > 
> > It needs to be reposted to be reconsidered, FWIW  
> 
> I just reposted it here after this reminder:
> https://lkml.kernel.org/r/20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com

Thanks!

> I've just remembered the timing might not be great though with the merge
> window that just started, and now I'm (re)reading through
> Documentation/procss/maintainer-netdev.rst I pobably should have added
> net-next? to the subject... If it weren't closed.
> 
> I'll re-repost for net-next after -rc1, unless something happens to the
> patch earlier.

It's in a gray zone between a fix and an improvement, we can take it
via net at this stage.

