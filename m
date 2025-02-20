Return-Path: <netdev+bounces-168101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ED3A3D7D8
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFB4189CE3A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618531DE3A7;
	Thu, 20 Feb 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FkQ9bk2A"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576191D79B6
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049706; cv=none; b=B+C9iwA3FBivqe8qLTxX7IenL+paWYHCE/JBPEgSnJknUtqWDDGm00mtp+fqK4NXMRzILtGNBYoAUoLDiUsVAwbsDK2CQKfynp7Xz05XfznYFQ4aorlxIGoJtRWNaTq4PNKNQOeh8GFgilyUEP2wnya0EiPNeBYKI9VCPXUPdkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049706; c=relaxed/simple;
	bh=oXJNr/gxxvxCZ5rhqqjVPyBrGe3PMFy7vb+NY47McLg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KMbqC5Tn8aIa9MBC7iP6rEp1PoZhJRh3YXjmSDjN9Uc9YlVkft4eJowatph93r7IPh7azWP5N8xW41FPA+fSWX04hCHrCIcL7PqnxRG/GvA+32ga97ql+mQptDge3qGAhr0y38g7ThLV/k2F1aDqmCVpdBiVbT24x9KeU+sNef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FkQ9bk2A; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740049701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DN4B67Rzb5ZccHJbDxzAn/tcklLewziqHZr7OFYX8jU=;
	b=FkQ9bk2AuLs0vWYjGGMFl6Lj+vVHipDJNXzsfpR7qS2n8jL8M96eIdFpqZE0mkEsqBqrup
	cXcIpwu3Kelk+l0cIb0cIlOSPBSR9iJueirwtjD9w41qDY85XqUVQ5MafO4G2AYBfQMMUO
	sq+0vFTMJlrysK918r42sAWxc6fsiew=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] net/mlx5: Use secs_to_jiffies() instead of
 msecs_to_jiffies()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250220071327.GL53094@unreal>
Date: Thu, 20 Feb 2025 12:08:07 +0100
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>,
 Itamar Gozlan <igozlan@nvidia.com>,
 netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9694B455-87B0-4A70-93C0-93FE77E3CD17@linux.dev>
References: <20250219205012.28249-2-thorsten.blum@linux.dev>
 <48456fc0-7832-4df1-8177-4346f74d3ccc@intel.com>
 <20250220071327.GL53094@unreal>
To: Leon Romanovsky <leon@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 20. Feb 2025, at 08:13, Leon Romanovsky wrote:
> On Wed, Feb 19, 2025 at 03:45:02PM -0800, Jacob Keller wrote:
>> On 2/19/2025 12:49 PM, Thorsten Blum wrote:
>>> Use secs_to_jiffies() and simplify the code.
>>> 
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> 
>> nit: this is a cleanup which should have the net-next prefix applied,
>> since this doesn't fix any user visible behavior.
>> 
>> Otherwise, seems like an ok change.
> 
> IMHO, completely useless change for old code. I can see a value in new
> secs_to_jiffies() function for new code, but not for old code. I want
> to believe that people who write kernel patches aware that 1000 msec
> equal to 1 sec.

Using secs_to_jiffies() is shorter and requires less cognitive load to
read imo. Plus, it now fits within the preferred 80 columns limit.

This "old code" was added in d74ee6e197a2c ("net/mlx5: HWS, set timeout
on polling for completion") in January 2025.

Thanks,
Thorsten

