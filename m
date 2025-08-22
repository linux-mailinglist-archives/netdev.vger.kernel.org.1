Return-Path: <netdev+bounces-215870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D0FB30AC3
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AFC1D04207
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 01:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE71AB6F1;
	Fri, 22 Aug 2025 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxz/mP97"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0F19D06B
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 01:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825714; cv=none; b=Pr3ruybQttODfEIX0irwMkVmu3jo3WOYsqLzq1VmMMryZ7R7FJUNcaBCrH0FZBYpuNwBEVEeQgwwvT9F/BbaEgRKP6xGpIrEyArAt5ictDtamWbQao92KkU/yoBsHhNjI+2ctyp5dcJAXJFf1ihQtTGldZbZyy2tuNGKqJ7y0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825714; c=relaxed/simple;
	bh=ntCiTsnHyv89Ppw/YN8mIQ+gYRwhLO3TxI+GVHhT5J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPF1+6+2XPYkwzk5l2wsB9LiqWU3/+mUnNAoh6mCl+Lyc06+qL6zxrYtnG+R7xZmA+C1ME0Yh2UsN907SgFq2Hi+YcrmT6Mz7aTxijETq6pF1Fh5IBso/7TfsRHQ4C39emG2L0yMyCNqpXVW79cG3bevxoNXRw2LygHMZXmqRm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxz/mP97; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755825710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pP1gIuRFr7tSKsLKFv1sUFXkEDX22rWdnjLkvx8Dr3w=;
	b=bxz/mP970haO0GhwvMwNYNIg2XAFuRY50CEbjjXhV++QxbQ5jtkmzBx3hSmLDZUmoHcn9i
	KxUQtIDtB5Ddtc2mHSHhFDJHBCBiCjvazbpybP7tt1bJQQ2gmtstz6+s/6TCysKEZ0Djp6
	DmNAFH7luWMZDe+55rGMm39WQDGrxuw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-NdzZ7o2eMMy-971uUgmbKA-1; Thu,
 21 Aug 2025 21:21:47 -0400
X-MC-Unique: NdzZ7o2eMMy-971uUgmbKA-1
X-Mimecast-MFC-AGG-ID: NdzZ7o2eMMy-971uUgmbKA_1755825704
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BF62180035C;
	Fri, 22 Aug 2025 01:21:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18ED9180028F;
	Fri, 22 Aug 2025 01:21:29 +0000 (UTC)
Date: Fri, 22 Aug 2025 09:21:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, mic@digikod.net,
	gnoack@google.com, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] selftests: centralise maybe-unused definition in
 kselftest.h
Message-ID: <aKfGFB2MmkbA4BBC@fedora>
References: <20250821101159.2238-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821101159.2238-1-reddybalavignesh9979@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Aug 21, 2025 at 03:41:59PM +0530, Bala-Vignesh-Reddy wrote:
> Several selftests subdirectories duplicated the define __maybe_unused,
> leading to redundant code. Moved to kselftest.h header and removed
> other definition.
> 
> This addresses the duplication noted in the proc-pid-vm warning fix
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Link:https://lore.kernel.org/lkml/20250820143954.33d95635e504e94df01930d0@linux-foundation.org/
> 
> Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


