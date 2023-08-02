Return-Path: <netdev+bounces-23488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A533D76C2B8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 04:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD10B1C21147
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A383A2A;
	Wed,  2 Aug 2023 02:11:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B57E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 02:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66295C433C7;
	Wed,  2 Aug 2023 02:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690942259;
	bh=DQ/KDWOGALWyuzyoM61Yt4hVHiJAe+Q7zLw2E6AYw/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AtFi2aAmfUP2CLhNRXwbB5I9Qb8M/I65QFuvTdf3u7baHoc2iosEdzPJsCu5hcVHK
	 dIbywIe5FU1K92sa+RGcVvyd3iU/w+tWdf9MVlOkYz1G4xM7EFnU4LJXuqzZ8YLxsS
	 G63LvBlyhyaMiiVT0QhTVg8PkofvhJRavhwO+wTPG6lmG7ahkAo65J7mZzYLH4+M0w
	 zUlFeA03EGhLQq3kdw84PH24TEf4cqFwegyiQvCrfvt/YL5aCNMx4DSwsUDyIPTdCQ
	 twifv+hM/acoRUo09ceq+MicOs65r0wxq80pWk3ImeP62cugb43AGFDNDlPUfy7TP1
	 gKw0GPhhcP9rQ==
Date: Tue, 1 Aug 2023 19:10:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <simon.horman@corigine.com>
Subject: Re: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Message-ID: <20230801191058.0664b1b8@kernel.org>
In-Reply-To: <cad2b715-14fc-8424-f85d-b5391e0110dc@huawei.com>
References: <20230801064318.34408-1-yuehaibing@huawei.com>
	<CANn89iJO44CiUjftDZHEjOCy5Q3-PDB12uWTkrbA5JJNXMoeDA@mail.gmail.com>
	<20230801131146.51a9aaf3@kernel.org>
	<0e3e2d6f-0e8d-ccb4-0750-928a568ccaaf@kernel.org>
	<cad2b715-14fc-8424-f85d-b5391e0110dc@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Aug 2023 09:28:31 +0800 YueHaibing wrote:
> > that pattern shows up a few times:  
> 
> Ok, I will test and fix these if any.

Thanks, we may also want to add a 
  DEBUG_NET_WARN_ON_ONCE(len > INT_MAX)
in skb_push() but perhaps that's an overkill.
Most of those cases are probably legit (skb_.*_offset()
can well be negative if headers were already pulled).

