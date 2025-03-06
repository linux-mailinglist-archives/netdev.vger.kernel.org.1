Return-Path: <netdev+bounces-172437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D238A549F8
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913BC3AC00E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1D20AF8D;
	Thu,  6 Mar 2025 11:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ5//VYL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F920AF7A;
	Thu,  6 Mar 2025 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261712; cv=none; b=ps4vrXINeVDVYNO+lGSGpb6AtSLMKeZFxWpuuhpmqNW5y2RMWGw3y4i1T981IJuYjp4E6qLMWHIJxDzI24BSkPj0DMkIYGwxBHHM/QRdnOKxC+JplypxtrGCqZKsi8uXebQ+2xt32CPqM+D91Z9Cy9w8CGU3zOeDVt+q0X+bDmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261712; c=relaxed/simple;
	bh=IF8TdGmgh9xc0DtNTWthN3ZYCfRHqe6g1Azp45d5BYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5BSqp32HleB9F2BH0292/A5jGzH/vqRtuWuJjOj49zmaVP5u+d8GdeV2DKzxix/hjzHtXYphnBL5XTG85BwHJLXj7Oq3ITMjyUWXcZyjGF+DV/RgldD/Jj6Yy/U8CYhci8yRD1Z+77iCzpKM/xicwwS8jn1cdHZwL6RnebB7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ5//VYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FA6C4CEE0;
	Thu,  6 Mar 2025 11:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741261711;
	bh=IF8TdGmgh9xc0DtNTWthN3ZYCfRHqe6g1Azp45d5BYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQ5//VYLpCxsG/xCAubkudESPYQ5qH8kt9NTZ5t+VQY2/ag6rvMaXmjGltxEES25m
	 TCZWbylTTSG9DjRELO1Nkj1XhCioH5s5MElY+UXFPX1YmPNjC6z2JvUTrYzVeiHr75
	 HzNH/blt04uvxDz2fQjl5ldVEAOemeAjDhdA66g2mo4CxtJrackV3J1n095j/hkdAa
	 ETQA2gOvcdj02McygT8JgXNuGnH5ns0FrGvLeX12ynskdoYIwjZdz0RNNPWh34lEyR
	 ijhPo0DOr0FmR4pMjCtuZG5BfgQX9b6xsq9AXErPw/eMBtjMZL3dxqNv1RQtKrYkAN
	 CHBx3PIFzfHRA==
Date: Thu, 6 Mar 2025 11:48:26 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next] netpoll: Optimize skb refilling on critical path
Message-ID: <20250306114826.GX3666230@kernel.org>
References: <20250304-netpoll_refill_v2-v1-1-06e2916a4642@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-netpoll_refill_v2-v1-1-06e2916a4642@debian.org>

On Tue, Mar 04, 2025 at 07:50:41AM -0800, Breno Leitao wrote:
> netpoll tries to refill the skb queue on every packet send, independently
> if packets are being consumed from the pool or not. This was
> particularly problematic while being called from printk(), where the
> operation would be done while holding the console lock.
> 
> Introduce a more intelligent approach to skb queue management. Instead
> of constantly attempting to refill the queue, the system now defers
> refilling to a work queue and only triggers the workqueue when a buffer
> is actually dequeued. This change significantly reduces operations with
> the lock held.
> 
> Add a work_struct to the netpoll structure for asynchronous refilling,
> updating find_skb() to schedule refill work only when necessary (skb is
> dequeued).
> 
> These changes have demonstrated a 15% reduction in time spent during
> netpoll_send_msg operations, especially when no SKBs are not consumed
> from consumed from pool.
> 
> When SKBs are being dequeued, the improvement is even better, around
> 70%, mainly because refilling the SKB pool is now happening outside of
> the critical patch (with console_owner lock held).
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> The above results were obtained using the `function_graph` ftrace
> tracer, with filtering enabled for the netpoll_send_udp() function. The
> test was executed by running the netcons_basic.sh selftest hundreds of
> times.

Reviewed-by: Simon Horman <horms@kernel.org>


