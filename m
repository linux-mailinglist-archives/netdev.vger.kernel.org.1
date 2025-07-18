Return-Path: <netdev+bounces-208200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F48B0A8FF
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 19:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1B27B236B
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3091A5B8B;
	Fri, 18 Jul 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTqfOBch"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EC26ADD
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858072; cv=none; b=cg9LnP/XU4KCC7EvkmHZOUXT8dHrIKA24mgKAeOMvO5F3HUGFdeVK4v4xgFSULHCM1maj1Sosfg9JRbgQEAmymR13k7J1RN3qVrHyGwLu1mnl5lkSs4tkkJF+SYR8xUMX0Ckeew25JzVUxzSc6JVx9e01izYRhtN41jTc4FSWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858072; c=relaxed/simple;
	bh=clGFMCcL5StwhW6g0FwTBFUj4I3gRGuvbq4VPogxOQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz/RNxot+oIy3pAtekR6LKv+4/CIFEYG/u4RGZ3XLKY3lB7S5cYCLeGgktHEtYPb8ptCK09BfcJV7NzTJbxJO/on3xluJ0BVggfOR2Y+bAmhtbdqVgTXGxvAAP3nqjLzBtHpl44ojCmVtUVl6QRF51e978tsnU0DmODDL8KoLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTqfOBch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46500C4CEEB;
	Fri, 18 Jul 2025 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752858072;
	bh=clGFMCcL5StwhW6g0FwTBFUj4I3gRGuvbq4VPogxOQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTqfOBchq+e957oMQID9ZtR6cJ2eAYod2gVbu0GsgbRT59lpnRS/PsEWJyCKCSpkS
	 GXGiFBV/VoXSlfMFOXyN35udz42bVs4drOMJst0N1K8uZ+FII/3E5knDG96yAb/otS
	 EYu1aD9fOL5xZ7YQXYmHp0KBXvT4T4CyOMq2ieUXzIeEtHzEYsR+gx4M9CLfj/2Zhp
	 baO9x8Tyh47Q652HeLSQN77RNXWTpXoTtVFO2EwXTsfD2w+rA+jU8DABl8d7pnSrIF
	 pZRroT1XhyHYM3Ij2LGcZRUsQvZPbMp2Ncz+1hOeLXE0h8gVNd5n7BXTQCdy3gqJJg
	 2uRrHEXp/griA==
Date: Fri, 18 Jul 2025 18:01:08 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: somnath.kotur@broadcom.com, ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] be2net: Use correct byte order and format
 string for TCP seq and ack_seq
Message-ID: <20250718170108.GK2459@horms.kernel.org>
References: <20250717193552.3648791-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717193552.3648791-1-alok.a.tiwari@oracle.com>

On Thu, Jul 17, 2025 at 12:35:47PM -0700, Alok Tiwari wrote:
> The TCP header fields seq and ack_seq are 32-bit values in network
> byte order as (__be32). these fields were earlier printed using
> ntohs(), which converts only 16-bit values and produces incorrect
> results for 32-bit fields. This patch is changeing the conversion
> to ntohl(), ensuring correct interpretation of these sequence numbers.
> 
> Notably, the format specifier is updated from %d to %u to reflect the
> unsigned nature of these fields.
> 
> improves the accuracy of debug log messages for TCP sequence and
> acknowledgment numbers during TX timeouts.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>


