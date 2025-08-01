Return-Path: <netdev+bounces-211372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8D5B1861F
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 19:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6FD62558A
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B91C3BE0;
	Fri,  1 Aug 2025 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BdKQwNse"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F461A08CA
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067618; cv=none; b=GIn8WZj/+P/fw8SQi+VB/UPCw/0cjfcfesmHbuDRE1MgeNkrnaTBbffibkfjdC8Av+iaCj2mVur+TZV4Zg6RGwiUIURK8QpzKKPDttaP1WIKUA5q18bIT0pXVRiTJRwSxtUvZcOYcqLlcqHE7VJSgOctBvg/wN32rBPXGh5d+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067618; c=relaxed/simple;
	bh=ixzhB2IWkCoD0F1aKbqXUptaL4fTvucgYZy4AJNb4ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU2LGDPjW+ThQh7nHxYezBrQEOMt9WznYyKY15GzyTG2LbQGhllUMTDH3ER6oFokKf9Rx7NuhKsijuubaItwjpb4M5ldU0AU4/TZVI5cn9oNqao3nU5SFsvOXjyBWW4vIJWO2kg6q5rmdU34fItpd71fg8X9FPKUt2wMa/bhdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BdKQwNse; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e2c920058fso339032785a.0
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754067616; x=1754672416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QwE+9sTgjNRdMVVYO7khCffe4vKwvJxjH8fF2V6zz5I=;
        b=BdKQwNse6pRrj/tOebPDpz5/au+yyTJVkZhAEihoTdxL5JLbjUtin2tHbPSdTwKDZS
         k+nbnR1YyNnEWE8XAyHqo/lk5tgdlq97oe48JGWIFhhLeW/O/XOGnF2T7ItGvxs7mKpc
         Hm2g2aS06SNiMrrCVcq9jnvLV0FryY1hWIcL9ksE516v2sOnS7IirX5sA9n7oWY4PFMV
         97zLmaElZJ+G4Its4Z6Lol3SZJAjPJ3WM5DHoLxE+N4HD9/9nMTTqhml9kpWsJV5C/u1
         GOQy3m1WTTy+cUzJqdHSZO7bNxEXRa/olGZufNJvzFSbbTHt9DWg9/K4vUiBF5NUxitL
         J71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754067616; x=1754672416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwE+9sTgjNRdMVVYO7khCffe4vKwvJxjH8fF2V6zz5I=;
        b=QlUgMgOgPGzk69YeZ/+lqePK/ye/jdXvnwYV+ji3iaJsMVnvZQtvMrhSf28s1VgUMa
         YjiwANCuC9mKVXQxAU2i/cCHyae6I5yT64lCzwBuTPmJeRcnDMg9WVm3HbLxEFMDlDkB
         ZMqQztL54xqDR36Tm3JLSgEjNveti1DoY/oFM1x5Vid7uxNc3/3dqaRQt5aozYnSMk0i
         TWX2tPHA0QNHiHiExkX2tV9NobzCuRvZCo0PULdW5p/xIvtOQWaj9UFrDTiMXZeDRRvL
         aXF9OEjgrvBfTPUWuBXRQmHhJAkMmNEeaebNdHHu+a1QXeIbomDc2rjg6p8HL0z/2n3s
         WbuA==
X-Forwarded-Encrypted: i=1; AJvYcCUrde3X1S4WScsCCGxIKHoHWW2T/eFMRT+HIJL3XIOxCZu4mI6VNxwDPTtGkkr+Q4/PFShbqSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZkxLwVXhpN3Z+boWz54m89PkHjt8+rDcijKUvPQSeZ6gZFnOi
	5difUA0I3CKwU7Astus2jvsat5y4Wo+PtsuP2zb2OX/IQNLmQr9LWv9JBUWj0PKGLLA=
X-Gm-Gg: ASbGnctUaw65+iOEZuMpU3aE5eNQR4mj8ltszD6OknbUtjhOBv3AYIj+TVZndO9uJAF
	ocFXR5jueaHUyBW093aj+B0K+b+rdENUruFgBw7x+ywc5EnwBsioxa9EeCAQNYVrPDtO6c8gjqo
	VgBggdcAicBtCdmMARF0F7rjwur7pQuawiS4e1v4C0H8vDfk2uwZq+AilLpxWABvmvXZUgO/83a
	lpjYbF0DRrjN8vuEBB5ddIOh/WPxgSS6YIvbEAsvlhbPp2z6hwAJ9rckeGpA4gu83XhyO+8bQDC
	qJnfmHt5xMvHqmSRIOpYUyL8XOI5Ts1rf1YVh9msfDDTSfHMHrFq8G7jg+yZ3UZtFlPy3l2tWAR
	PGmqclpQBeHs7ZxB6iNP/T1PUS938LFVO+W/2/ZM6W9fcLc95BAnaCByZpSuRoQGXCo4i6PuaZ7
	SScTs=
X-Google-Smtp-Source: AGHT+IGeo72sFurahqpXhqOszMWIFx1nBofLsBki44tDG5x4fiYUv0PBxN8jfJdDWgnL5yoXO3nTZg==
X-Received: by 2002:ae9:f10d:0:b0:7e6:5f1c:4d78 with SMTP id af79cd13be357-7e696650ea8mr57651285a.33.1754067616031;
        Fri, 01 Aug 2025 10:00:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f75c053sm235155785a.81.2025.08.01.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:00:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uht78-000000013Jb-2qVs;
	Fri, 01 Aug 2025 14:00:14 -0300
Date: Fri, 1 Aug 2025 14:00:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Simon Horman <horms@kernel.org>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>, shannon.nelson@amd.com,
	brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, leon@kernel.org,
	andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/14] net: ionic: Export the APIs from net driver to
 support device commands
Message-ID: <20250801170014.GG26511@ziepe.ca>
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-4-abhijit.gangurde@amd.com>
 <20250725164106.GI1367887@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725164106.GI1367887@horms.kernel.org>

On Fri, Jul 25, 2025 at 05:41:06PM +0100, Simon Horman wrote:
> On Wed, Jul 23, 2025 at 11:01:38PM +0530, Abhijit Gangurde wrote:
> > RDMA driver needs to establish admin queues to support admin operations.
> > Export the APIs to send device commands for the RDMA driver.
> > 
> > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> 
> Hi Abhijit,
> 
> Perhaps I misunderstand things, or otherwise am on the wrong track here.
> But this seems to open the possibility of users of ionic_adminq_post_wait(),
> outside the Ethernet driver, executing a wide range or admin commands.
> It seems to me that it would be nice to narrow that surface.

The kernel is monolithic, it is not normal to spend performance
aggressively policing APIs.

mlx5 and other drivers already have interfaces almost exactly like this.

Jason

