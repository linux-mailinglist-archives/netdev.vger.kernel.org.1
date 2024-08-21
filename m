Return-Path: <netdev+bounces-120621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF84C95A010
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C20D284577
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44530188010;
	Wed, 21 Aug 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoDuRSlo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ECC1B2504
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251051; cv=none; b=PcWCtpkALCeM7f49CsH/pJHRSvEFI2iSdUxmAAUDRrLPR4EyqjBJnCR3IOFCISK5NQ2hxLpNYswb63mDuQO28VgEq/XIgJZhPRBpE09mxnPUwMyZ2HNao3NR8SxCC3+F34x8qIl+jl0xTyTWC0FwhAQW4jUJ27ADlZJg3Y59c5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251051; c=relaxed/simple;
	bh=cajymjopKHZ+jjQT4V5JF6lTFOC/PTiG1zMY7mQ7j88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7zgHMOvj6V/fEkeamrKHXEPzeD/5RWfSwIEZeqFau6eX7W/9Wt351wLEZjTq4my79uvxUfZSIoFMouc1XI6MLO4hBUWILgw4GFo9znHA52EzmEFjW78SA7Xel843UKz6laW7LjZkR/gn2mYxz+zIPYs6NASgjExXnBwIJ3iJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoDuRSlo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724251048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cajymjopKHZ+jjQT4V5JF6lTFOC/PTiG1zMY7mQ7j88=;
	b=UoDuRSloVKibH2IC4l5UdpNq4tZfhW9iOioBRINqVziptkv+ykbYBylIj57uBibu+uZRez
	3o9zBZyWcWJOY39Kw5eUe97Vh3pbNG/DGkEB618DmpfB6Au6LTLO2idHi8nuIn+XlpPUph
	FwgaskE/FQ4VonAeUpEVN/a2XrVDGmQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-6hlsX-fTO9qToFB3FM0oKA-1; Wed, 21 Aug 2024 10:37:27 -0400
X-MC-Unique: 6hlsX-fTO9qToFB3FM0oKA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428ea5b1479so54054615e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 07:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724251046; x=1724855846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cajymjopKHZ+jjQT4V5JF6lTFOC/PTiG1zMY7mQ7j88=;
        b=kJNpS7IeMrjjTzSi5RHozI7Io+BffpmWppc069ZRf+5sveLG9ke66oa/FiZJZdLCme
         /hFu6Ffu0Va+oVh9RiWLeDsmLsZ/VqkEk+yX6Cd9xJtswqC6SSIUKYZxcRUQSCrAmsfr
         DaANxkbgk6H+FduW+7eAsr5EORyRJv0xgqpc5VDBZwyB/3IQEY4/XgqltCBijYusVMxz
         dVokPSpTN6Elc1VG/ZQ9x30sFo4cRO0DCsX1B3rtRWvWW1a5cxW1FpmU7+EwkWj5SqYC
         pPkw1RxolIX5uS1Y6r7G0fnCdXOT5PXi5VPT8RdEZmzSLeTO29zB9KJwbMBBTjYy85mk
         2rZQ==
X-Gm-Message-State: AOJu0YyoC6ihnbKvKWpuBT7L5m8xDQop2KiLQkrVqRl6HLqGwt21RI7N
	ZoQlIKp09fzFQhykrc0aB3QRYdfnZu7q1iiFj4sODQhhtdDogd/xijsbnjInLD+AqvOG/uy2r6Q
	M9u/QLe0WJbwb2fPQpvHTP+t1bbHBmJXCtJL+LHT6RlsB4XS22ss/Hg==
X-Received: by 2002:a05:600c:35c8:b0:426:6308:e2f0 with SMTP id 5b1f17b1804b1-42abd25e09emr19024875e9.26.1724251046084;
        Wed, 21 Aug 2024 07:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrZ0w1vMUzhLTU1LCWBMDSAY92DCEqfTOCresT/HxF2xp/YTkeLxR6bm7/9BsLpuZ4cUXD/Q==
X-Received: by 2002:a05:600c:35c8:b0:426:6308:e2f0 with SMTP id 5b1f17b1804b1-42abd25e09emr19024515e9.26.1724251045282;
        Wed, 21 Aug 2024 07:37:25 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86d2csm28143355e9.16.2024.08.21.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:37:24 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:37:22 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 02/12] ipv4: Unmask upper DSCP bits in
 NETLINK_FIB_LOOKUP family
Message-ID: <ZsX7oh/Ft2gazpQf@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-3-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:41PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits of the user-provided DS field before invoking
> the IPv4 FIB lookup API so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


