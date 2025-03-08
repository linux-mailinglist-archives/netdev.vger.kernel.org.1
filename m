Return-Path: <netdev+bounces-173159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE388A578CA
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 07:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CC51897098
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 06:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC0E192B7F;
	Sat,  8 Mar 2025 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="hBq38/8k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4218C03F
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741416240; cv=none; b=JQjVJBRGGRv1H9baBhGbOgrHeZvx+RQzxupRKLHU7sg1k2ol7WAnI9uDHiz4o5qEVpbwCaAKwVW7Hfxvxk1gDt7l2QycpLZ+gwJy9v5Pi94jaO+Ix+o11mhQ0NdXEeCi6Y9SY/1vAuu4mfhoIJMbSFEzluM7ElyiL45g+1wWaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741416240; c=relaxed/simple;
	bh=UtKF8Vg/8ur3x9ZZufYsKRKBGlH122N5R3zj7Hw67+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfOJI9vArH6WoamMaMNjpftL25vKllESq/IqhGqKPVVVLXsQOLP9+6rW9SR0bfIZyP1nKBqv97nQICAG+365IfLHlEUmHbhW+KzyESQ4PoNjZ2P0y4Ak25OZ29sAjHbdeaXt4e8Q1KUSuxCjmRmfKn+z8IVsiwY8ZSQe/t5svwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=hBq38/8k; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22113560c57so49671015ad.2
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 22:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741416238; x=1742021038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7XYd6bILvV5S9oc7kfROdvIGE+piMUFy2TT1wDFAAs=;
        b=hBq38/8k028Va2ySOoTHwKdiKsj47KxvXgVyw1QjDEvkQVbbmnktfS9gZgnxJs4omi
         /zRohCnJckwGkAkjzlZWpMGd8vBYYc55AGBnbQ/SpMKLg2j1VDpjewriDESP9B7bGWwe
         D3hamTpXTsvbTwD3kxAZdonKLf3gXW2NTlhEzmwWDjEsjk7Z5x+C4Ci4m3z+Y0qhceZF
         0BIOgI/mVTYbcI/Bfkm6BdnZ4LjYGvQ4e3CU2I4o6YxwctehxzfgE+56qS5A+ZJgefsB
         Of/PVXd8GmBwZF2oyzqtXqS7c5YvC4ypHMtlO5Bbzuf+07wr5AVZ0XpRn1LQfMfRl9S7
         1gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741416238; x=1742021038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7XYd6bILvV5S9oc7kfROdvIGE+piMUFy2TT1wDFAAs=;
        b=YB+KZdYEzvOMmj9GgvrpXdhY1W7CJgL1Iu7aLZiqJx5wKqP/XAFO8MK3+ChGblV7n4
         cCGtsc1NR0ZadNq3/OwS5+mhhEIQVfFsz8f/q6m78PdNlAhjZgSlzxmeUmSHFPkmic1k
         d1+jJIIB/1BSubjWW8XhLTvww79E+jRr+1v94CPG5Ftqq0+2FYwli11W+YI2u9e+92zP
         dTS4txZEre3suKqqerCVQl1qy/HJYSzffzaZZgPiSeZB8Y7EP5+Z9ddHenZOOY7za6i3
         +/hkUq4n9AchMCbz2c0CouorA1OXtBCMnvR4VPxZfKGM+a57pA6pYKTiQLOXV4CszBQj
         24jg==
X-Forwarded-Encrypted: i=1; AJvYcCVucy7n9UlqHpbwFwQyHpAlDZF9Vd/y2v7AFzcMvzQeBd8b6jFtdo2IJ8dFwF9zy+OOX93aiUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydAjrbhbMZtRzrwdmwwGl1dfOMBNjFzyqmQNwMfdv9h2KJ1ySJ
	3Gm7AYsAzDQjtVrwSkovxmSbgUR2Mg3KEmD+VfOVJjEGURXRdhGv9hWwbOtEKHI=
X-Gm-Gg: ASbGncvf0eDYyGTnt/EyXmN6OIYqbEtiI4jit1u9CRbN0ozoOvjF/PxTqr7bFbal66N
	jgGiCjm0P1VyGIUkv8Py6aehBu6tcMi5yZXBWoGfgFFCiMmi/GhNayiTWERJQtTzNSZO2MAyFaf
	DRwg9XeXF+MVX9XkO/xsXVFtSjM2TTlNSIHq3nFnfNZerNUDAqugQUBEAN9C2NXxtGtTbsj47CL
	jRH00dWQ1Gj1TWFJO/woV58F9Usf6EIt8GG4uNxaRSxoZEC8+1c+7fr0B4UgUJ0t8I89DUgpmrK
	AFDuQwSIeblX91lYoIUnQTb0xmVcbGh7PysuR35LBi/4PqwpfDrK9kDE3MhqHjKdTiCSxvqvYFZ
	bP0cfiyqxTpIjiuOf79ep
X-Google-Smtp-Source: AGHT+IF/hoytkHf/78nzK/gEIzqXnGG5MP6Y8FgGhVp8Zx6LE+l7N0K13IdyKh5Omm9Q6AhxhqYyLg==
X-Received: by 2002:a17:903:98b:b0:223:397f:46be with SMTP id d9443c01a7336-22428ad4a09mr106979815ad.47.1741416237682;
        Fri, 07 Mar 2025 22:43:57 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e816csm40661065ad.54.2025.03.07.22.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 22:43:57 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tqnuc-0000000ALct-08Dn;
	Sat, 08 Mar 2025 17:43:54 +1100
Date: Sat, 8 Mar 2025 17:43:53 +1100
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
Message-ID: <Z8vnKRJlP78DHEk6@dread.disaster.area>
References: <20250228094424.757465-1-linyunsheng@huawei.com>
 <Z8a3WSOrlY4n5_37@dread.disaster.area>
 <91fcdfca-3e7b-417c-ab26-7d5e37853431@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91fcdfca-3e7b-417c-ab26-7d5e37853431@huawei.com>

On Tue, Mar 04, 2025 at 08:09:35PM +0800, Yunsheng Lin wrote:
> On 2025/3/4 16:18, Dave Chinner wrote:
> 
> ...
> 
> > 
> >>
> >> 1. https://lore.kernel.org/all/bd8c2f5c-464d-44ab-b607-390a87ea4cd5@huawei.com/
> >> 2. https://lore.kernel.org/all/20250212092552.1779679-1-linyunsheng@huawei.com/
> >> CC: Jesper Dangaard Brouer <hawk@kernel.org>
> >> CC: Luiz Capitulino <luizcap@redhat.com>
> >> CC: Mel Gorman <mgorman@techsingularity.net>
> >> CC: Dave Chinner <david@fromorbit.com>
> >> CC: Chuck Lever <chuck.lever@oracle.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> Acked-by: Jeff Layton <jlayton@kernel.org>
> >> ---
> >> V2:
> >> 1. Drop RFC tag and rebased on latest linux-next.
> >> 2. Fix a compile error for xfs.
> > 
> > And you still haven't tested the code changes to XFS, because
> > this patch is also broken.
> 
> I tested XFS using the below cmd and testcase, testing seems
> to be working fine, or am I missing something obvious here
> as I am not realy familiar with fs subsystem yet:

That's hardly what I'd call a test. It barely touches the filesystem
at all, and it is not exercising memory allocation failure paths at
all.

Go look up fstests and use that to test the filesystem changes you
are making. You can use that to test btrfs and NFS, too.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

