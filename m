Return-Path: <netdev+bounces-101073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35DB8FD23D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF591C23556
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF804779F;
	Wed,  5 Jun 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2Lb9l+8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002743AB5
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603237; cv=none; b=TbAk42vzxsCj/hTqabUN/2Gj2Yxh8Evseijyrblj7qZMMiB/BqsRU4ldR16PDsDro9jBXa+ob316sP42ai32NZLJtmrMx54uhW14bnI2XvrQIXqXcWp1QS14H4NUEirOi1gtSKhz/0LniNUxuMJFAFfnwgKHc/JBec3SNxWOq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603237; c=relaxed/simple;
	bh=B+oO731SnbisJRO1Q+J6ZOwlEBycxwktQoCY4W0eTYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljFLBK/wFM+LXNj9rrCVmsoKNE0+Hr3A6KGG4U9ccg5BV5Ejq/5c5DzHi6DHVZfGFHurTsxaEZQVkL1b2WNCyaiU1GBes2PkrgdUJ393gtQwjUKc7ZtluI8yn4MD4EwrDLv5zpX5PE3JzhpQngLe3Aq9GGWP3mLcfeWbXSu/FuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2Lb9l+8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717603234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/DvG576v+pU/FwzqiGvbmWt13NVWqzZTh6Ot5c76wYU=;
	b=B2Lb9l+84LNnMlYRH3kAYlCx8RxXjMlDWWzM6m3t6rrVEuMFXpr7HzkQzdWzgxXU5XPAPg
	X0lmS8CLLjH0GDouUm5O8xNEg+g4aJp5/CVaf0DFZ+yWd7ODjIiKA8apgPRDvq5DxOfSIE
	/gt4/mJdzRgxzYgpvrsrrRRXb3hVA+E=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-mQzUj9hIPEeWJVEy2t99dg-1; Wed, 05 Jun 2024 12:00:32 -0400
X-MC-Unique: mQzUj9hIPEeWJVEy2t99dg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2eaa38c4396so19504901fa.2
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 09:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717603228; x=1718208028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DvG576v+pU/FwzqiGvbmWt13NVWqzZTh6Ot5c76wYU=;
        b=t2wSg5G5gWUD+tYHs5HfXCxU2NgAC4BrdxtsHpTTH0BgfLR0v5wog/jG9IsoFJ0nDS
         CdH+SmQ+Dr8xwcGGQqd1J4jbAuZNNFvnkgGtlCQ+Fa4P0H3NaHUsNq/NvnNgwkdJR4Tx
         KGqIHZNI+sO2HqOI5T/fFOM3E6IznoKrwp6JJeihCb2TtE43GvPWboyFzorc52ySWfuL
         czv/Dj9aqcFPxv4H9e6KVaSah6e3l6fpcGO28s1lJhlNyGRObyde01lOi0nRXDwN+lwj
         SFCjGMnGwhn53cGuDgJFRmHgWKQdlyZ242k1ho5gTfs++CY4ZEy7G5iAx1Ld3I4hpzE4
         F0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWXEjouG6vNq8LCc80DNKnhIVIlHgyDq9vrBQEUfPEpSXsob3ybVrTK3lz4EvWYugVi+FC1/gBEnJwh6lAukk8X/0iH+rGd
X-Gm-Message-State: AOJu0YwMGJgpClCHFuEKCu5ZxQP7aLlkLgjSw7s3En9y0BevqDa+D3Cv
	wOf5XAFE/NrT5bFqOev5KBEDp1px25emXeh1TcAp4ODwr8RL06nTOn36NLHywmFcxmw5JY7ao+n
	TfgGtaX5s1xS2VtDY9tqFs2D+gt6UTU7zZItLBJBAZ92W2FtdX/faSpjn+jFVgg==
X-Received: by 2002:a2e:960b:0:b0:2ea:93f0:cc17 with SMTP id 38308e7fff4ca-2eac7a6efe8mr14509151fa.45.1717603228617;
        Wed, 05 Jun 2024 09:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB/t7C1jG2yeOmpE3Y/HaYLya6YvPHTFM6MjMUNPSu+tH5PdudahlML3n0yMTHgoaROZ7hng==
X-Received: by 2002:a2e:960b:0:b0:2ea:93f0:cc17 with SMTP id 38308e7fff4ca-2eac7a6efe8mr14508951fa.45.1717603228175;
        Wed, 05 Jun 2024 09:00:28 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a5ca00bddsm6621359a12.72.2024.06.05.09.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:00:27 -0700 (PDT)
Date: Wed, 5 Jun 2024 18:00:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: namespaced vsock
Message-ID: <myowlo6xpjrhbawt6sptwcqktm34zbfnsxzyo5eahcbspitwzq@ypssm5pe6q7m>
References: <20240605075744.149fbf05@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240605075744.149fbf05@kernel.org>

Hi Jakub,

On Wed, Jun 05, 2024 at 07:57:44AM GMT, Jakub Kicinski wrote:
>Hi Stefano!
>
>I found you patches from 2020 adding netns support to vsock.
>I got an internal ping from someone trying to run VMMs inside
>containers. Any plans on pushing that work forward? Is there
>a reason you stopped, or just EBUSY?
>

IIRC nothing too difficult to solve, but as you guessed more EBUSY ;-)

Maybe the more laborious one is somehow exporting a netdev interface 
into the guest to assign the device to a netns. But I hadn't tried to 
see if that was feasible yet. I have some notes here:
https://gitlab.com/vsock/vsock/-/issues/2

I've been planning to take it up several times but haven't found time 
for now, if there's anyone interested I'm happy to share information and 
help with review and feedback. Otherwise I try to allocate some time, 
but I can't promise anything in the short term.

Do you have time or anyone interested in continuing the work?

Thanks,
Stefano


