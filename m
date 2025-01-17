Return-Path: <netdev+bounces-159484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C254A15990
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8356F167C24
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BED1D5ACD;
	Fri, 17 Jan 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOioszaV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6519CC27;
	Fri, 17 Jan 2025 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153814; cv=none; b=oQ1PLskW3bn9RcvZ3KYo3tlaz6sy5ipPZASeLim3FMqmeaAxDi1A6gQTjZXFpbpledOW3Gwo8RlExtV3u3lo0C/3Kcfpvb6CANpteOFt+Z8gYyTSZcZuKZqnb0+bRoqXIzEbAe4wz2XSxVpkyZDrGHoo4hY4A1vG0VIBTjv4bgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153814; c=relaxed/simple;
	bh=50uUaiGANqV+eTVjv+pUZPnWo8IjZ2+xGwYeZjmL7hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D80g+jwqcpCaP43EOeI1CTfQgodIbdPnM49qVrtw4mPXxzZKz+KUa1sOUvWvtVzhiUKOHFTswB1Fpnb9jUTEwt9caau21YjWPuv2n1QqGLxXSTQ5C6Y035Tj3q/Zr+4eMVDjvCRNLVskP1LlQX6EcYJoPEGC957kCuV+k8VCpIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOioszaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BCCC4CEDD;
	Fri, 17 Jan 2025 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737153813;
	bh=50uUaiGANqV+eTVjv+pUZPnWo8IjZ2+xGwYeZjmL7hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IOioszaVH8LLT7fa6lFj/MNgpD8sikIgmv0ceP8neLNe2fjm9UrtPXxVDwn7T7EQi
	 LIDyGK384xfOkactUZ6BeTEZ9PWA0Gw9eT56ypi3+X3ubQu5CryRY9CSfZVORzMjZk
	 WU0f4+p8uF2ukZ1LSUkYjwmCSD44IdPBQ6amSe9nMtAWAhhA0TSjsrBYb+NSivgu6j
	 jxzh94s04D/yxfnGHG3yC3ZlyEEHhiPIT31Ndb88zHog+cp5iBXi/VqiUG3dCCqUVc
	 NhxiLxL6rNo+aAgdL6fvWR1rhZDFfvP5PelzAbqMNizBRhSSgaxd2flFx6ccgevK4J
	 jrFcJ/q8CIs+A==
Date: Fri, 17 Jan 2025 14:43:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: Paul Fertser <fercerpav@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, sam@mendozajonas.com, Ivan
 Mikhaylov <fr0st61te@gmail.com>
Subject: Re: [PATCH] net/ncsi: Fix NULL pointer derefence if CIS arrives
 before SP
Message-ID: <20250117144332.7ea38896@kernel.org>
In-Reply-To: <97ec8df6-0690-4158-be44-ef996746d734@linux.ibm.com>
References: <20250110194133.948294-1-eajames@linux.ibm.com>
	<20250114144932.7d2ba3c9@kernel.org>
	<Z4g+LmRZC/BXqVbI@home.paul.comp>
	<97ec8df6-0690-4158-be44-ef996746d734@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 15:05:24 -0600 Eddie James wrote:
> I am able to reproduce the panic at will, and unfortunately your patch 
> does not prevent the issue.
> 
> However I suspect this issue may be unique to my set up, so my patch may 
> not be necessary. I found that I had some user space issues. Fixing 
> userspace prevented this issue.

The kernel shouldn't crash even if user space is buggy..
Maybe we can apply a simplified patch to return an error if !np?

