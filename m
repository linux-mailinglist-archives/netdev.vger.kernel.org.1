Return-Path: <netdev+bounces-171533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A12A4D60F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 09:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF649188D375
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 08:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A71FC0E9;
	Tue,  4 Mar 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="PKq+Px3F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED391F5829
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076320; cv=none; b=YBk004fHSQs7TP9zdXC/Pc/uJrJK9Rx+MG/RACp/696yClNjaakVoVh3P3zmdAusZmJ1zie0h7cYJvkZP/N67+1tFF85upwsw2SbWTkpXP65MUwZWKOaYQGPDju+jQ2k16ImznS5tdlXM0dO32DhAByrApIBqUcBQUWlKYDL/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076320; c=relaxed/simple;
	bh=MZcygyW82kCp7u9tCYmO6hhj2Hxe6B9gWadL8462is8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gapBpDvKHrMmf7pm6MvlX2CXotsXQZGMqAmboddfMOFFf7VzCt4pU/kg+vsLIzKfMU2vGOEoj8dsDGK5gI4d1pIqWOQcLzWyC9ICHzkq6iQlPE1sGz1WCQY+EboAfpWTaZuAGlHUpkE6Pato52EE2lJs/b1cAoOmfd0sQ5EKBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=PKq+Px3F; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fe98d173daso8500747a91.1
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 00:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741076317; x=1741681117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc0xsYnTUQhvWodmw2ejFo3Ab0lc47BeE7G2ofWx65Q=;
        b=PKq+Px3FNLwRkTOBwFJY58aZWZvV11Sn6sMDKdm902vRcOmgS4qetFZAK02QlQa3yV
         +JNfVNuFSME4LwW0sUrTrp2lheqfsnWRgA8iuM1buaYkBtG1J+1OksVXyPAJFvMuc7gy
         mhr0Gj6k5sxAHYB6uHOCGqIdHB8j7qatdlwcLlZZE3sKBIStbUh1k+yuCn+HQTygdmgN
         8YWUsL/BoOUWRqBFPJIsEtwaDpaKGKwD1qRYQ1nuamuKVtE4vaB2RmOnMMGTxOtZTG4T
         XwiUNNz2S8+P2Ny7RcqXuUj6clfZ5d6+x2GjeEKpZucDaA2eessGC7AXn5o8BubjFZys
         c+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741076317; x=1741681117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc0xsYnTUQhvWodmw2ejFo3Ab0lc47BeE7G2ofWx65Q=;
        b=Evjizv9Qr/KhO3UUYQfHtYb6qcbpzNyd/nwGLMfROBl0DjGMGIOkdXkFao0EyeFJBm
         kCRLN+BxWLefRPXOyfzfM6K2UU0oCLJJLx9mFi+FAvLZ3lTVZEQaeJM7PJM3DqaCyQjN
         SWAAhNO9VkQ8YnExaW0JpHh7CLTNTqDMJkSG+4d8/BoboN2j8gY2IjiY2WUffuhV7o/V
         DVKXOawDDHPAlopHaBw2MpdrpkhccpkjVoN4QT8yA+IR0hey9Rp5ypkL004Qu8wDwgre
         JjxgOTDUGYkiYETAWsGj1tsU5vOu2srMd2mZIoO0NoPVmB56S8TF8YsUrNy99BEgthKv
         CgZg==
X-Forwarded-Encrypted: i=1; AJvYcCWxjaostuzxYn9vfOImQD7Ir+nsxW2U6yF/TNJocF4PTlYWYcM3qbHZyTmLdgw/74JKjL4iH3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwozeHQdkiT1CwvaPJA+NaMDGkRY0c7K0jvWv3Y+fwjPNYMhP1V
	JLpLtBBwip7+wNbQSw0+pj9g2evtal0QOdPAYM0OUH2VYSh2fE/NB5HBc+9fCGw=
X-Gm-Gg: ASbGncvnNdGygy+mn0d0IlSII9Y4EC8G8YXilJ/soVB188yTDUYXYPUEhLWaCZYnbhi
	Irvshrqk36yBYQ7R3/LMPvOTUdno3o+H3hA9y7S1uyZ+xF9OTA6rTXAWu5W1vom4+03m09RsGIn
	c2V367cKqhnHZUKz3qv8WIwMMp7J/l2+wyL6b5dppM68nEig6l+1VUHlk2+v5HHuqEh7xzTyglA
	2xZewGcdw0FZ9cZL4gq20lflMxc4kbH9qFJOT59IAiVzBNtVnPAwRw+uWX8ayOUiTFkVtYm/tq0
	wypSBB/raSXgiwVV206TYO15ZCDVm9IyLamgFGv7r9v5MhSsVYxS1d20GHyoR4INqgkx55tOYdV
	c9LXPKrumhN5H2yqd0qaI
X-Google-Smtp-Source: AGHT+IFtDzCgImtuz8L9+GYRCY4LVCLrXbK0Bo8kgf88DL3yFokQ0qmw0lddBixblhsY0xBrKZj7tQ==
X-Received: by 2002:a05:6a20:734a:b0:1ee:c390:58ad with SMTP id adf61e73a8af0-1f2f4e014f9mr29817034637.34.1741076317276;
        Tue, 04 Mar 2025 00:18:37 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19d3fsm9497416a12.18.2025.03.04.00.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:18:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tpNU1-00000008fSI-4AHP;
	Tue, 04 Mar 2025 19:18:34 +1100
Date: Tue, 4 Mar 2025 19:18:33 +1100
From: Dave Chinner <david@fromorbit.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Luiz Capitulino <luizcap@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] mm: alloc_pages_bulk: remove assumption of populating
 only NULL elements
Message-ID: <Z8a3WSOrlY4n5_37@dread.disaster.area>
References: <20250228094424.757465-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228094424.757465-1-linyunsheng@huawei.com>

On Fri, Feb 28, 2025 at 05:44:20PM +0800, Yunsheng Lin wrote:
> As mentioned in [1], it seems odd to check NULL elements in
> the middle of page bulk allocating, and it seems caller can
> do a better job of bulk allocating pages into a whole array
> sequentially without checking NULL elements first before
> doing the page bulk allocation for most of existing users.
> 
> Through analyzing of bulk allocation API used in fs, it
> seems that the callers are depending on the assumption of
> populating only NULL elements in fs/btrfs/extent_io.c and
> net/sunrpc/svc_xprt.c while erofs and btrfs don't, see:
> commit 91d6ac1d62c3 ("btrfs: allocate page arrays using bulk page allocator")
> commit d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
> commit c9fa563072e1 ("xfs: use alloc_pages_bulk_array() for buffers")
> commit f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page allocator")
> 
> Change SUNRPC and btrfs to not depend on the assumption.
> Other existing callers seems to be passing all NULL elements
> via memset, kzalloc, etc.
> 
> Remove assumption of populating only NULL elements and treat
> page_array as output parameter like kmem_cache_alloc_bulk().
> Remove the above assumption also enable the caller to not
> zero the array before calling the page bulk allocating API,
> which has about 1~2 ns performance improvement for the test
> case of time_bench_page_pool03_slow() for page_pool in a
> x86 vm system, this reduces some performance impact of
> fixing the DMA API misuse problem in [2], performance
> improves from 87.886 ns to 86.429 ns.

How much slower did you make btrfs and sunrpc by adding all the
defragmenting code there?

> 
> 1. https://lore.kernel.org/all/bd8c2f5c-464d-44ab-b607-390a87ea4cd5@huawei.com/
> 2. https://lore.kernel.org/all/20250212092552.1779679-1-linyunsheng@huawei.com/
> CC: Jesper Dangaard Brouer <hawk@kernel.org>
> CC: Luiz Capitulino <luizcap@redhat.com>
> CC: Mel Gorman <mgorman@techsingularity.net>
> CC: Dave Chinner <david@fromorbit.com>
> CC: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> ---
> V2:
> 1. Drop RFC tag and rebased on latest linux-next.
> 2. Fix a compile error for xfs.

And you still haven't tested the code changes to XFS, because
this patch is also broken.

> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 5d560e9073f4..b4e95b2dd0f0 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -319,16 +319,17 @@ xfs_buf_alloc_pages(
>  	 * least one extra page.
>  	 */
>  	for (;;) {
> -		long	last = filled;
> +		long	alloc;
>  
> -		filled = alloc_pages_bulk(gfp_mask, bp->b_page_count,
> -					  bp->b_pages);
> +		alloc = alloc_pages_bulk(gfp_mask, bp->b_page_count - filled,
> +					 bp->b_pages + filled);
> +		filled += alloc;
>  		if (filled == bp->b_page_count) {
>  			XFS_STATS_INC(bp->b_mount, xb_page_found);
>  			break;
>  		}
>  
> -		if (filled != last)
> +		if (alloc)
>  			continue;

alloc_pages_bulk() now returns the number of pages allocated in the
array. So if we ask for 4 pages, then get 2, filled is now 2. Then
we loop, ask for another 2 pages, get those two pages and it returns
4. Now filled is 6, and we continue.

Now we ask alloc_pages_bulk() for -2 pages, which returns 4 pages...

Worse behaviour: second time around, no page allocation succeeds
so it returns 2 pages. Filled is now 4, which is the number of pages
we need, so we break out of the loop with only 2 pages allocated.
There's about to be kernel crashes occur.....

Once is a mistake, twice is compeltely unacceptable.  When XFS stops
using alloc_pages_bulk (probably 6.15) I won't care anymore. But
until then, please stop trying to change this code.

NACK.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

