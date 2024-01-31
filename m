Return-Path: <netdev+bounces-67694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BAD8449DE
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EC1B266B6
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868C43A8F3;
	Wed, 31 Jan 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWiANN2R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4939FD8
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735954; cv=none; b=Sn7RaqKwvpsBVMVWM1mjZPZs02vuAG3zH5LmwNLJqu3s+e4pMvUSP5EXZFWFe1s6JrZQN3n/a2JCtt5WBamwSdDVsFYLrSPd/seBfS4NCTggbCPEH5NMiO4sAxLz6N/fwabLcwmfDI616bzv/BA28Q6t75GOACnNShQrl730n8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735954; c=relaxed/simple;
	bh=SYBVg46mpR9dnqUTZa2ISnJH6f7rQy4RHOcA7fPx4io=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pfGy6LU3ATE5WyHkhornbMEHeLm0EZ3LlsszudL/Kcl60IhiAfNVGA5OBfWIwT69NaHisRFFkDTzbsi5IZqWuXlcmTwLfU6lPE/ZqNjQaKhqxY+Tfrn8u9vKR7xFCSkgwrRK6t4Y/j4kCm6Z1J1pY6WqfOXy78tJgoCxaViz3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWiANN2R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706735950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3yB2kiqifBKKvpAzdxq2rUj6YaIk0/NcCYZRh82k7I=;
	b=QWiANN2R2JNhbswQ1jOYnwi9PzpnJEaCleoe0ZzDvi1bh9F2q8qWo6XtI4LBjBczPy5DnH
	TLAYRvoGLJRp2jBHG7zZQSohCqrrb+Jn+uKT2DMLE7WDEGsoNuXdQpQy7jENJuaLhbqmNn
	zJ2qfNkzZzb70FdFBiaW3tr5qOCuD1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-7dlXrQnzMXqKhRHckdmUCA-1; Wed, 31 Jan 2024 16:19:08 -0500
X-MC-Unique: 7dlXrQnzMXqKhRHckdmUCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CF6C85A588;
	Wed, 31 Jan 2024 21:19:07 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 598E81BDB1;
	Wed, 31 Jan 2024 21:19:07 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 45C2230C14EB; Wed, 31 Jan 2024 21:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 41C463F7DC;
	Wed, 31 Jan 2024 22:19:07 +0100 (CET)
Date: Wed, 31 Jan 2024 22:19:07 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Tejun Heo <tj@kernel.org>
cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
    dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com, 
    damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com, 
    peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org, 
    allen.lkml@gmail.com, kernel-team@meta.com, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
In-Reply-To: <20240130091300.2968534-9-tj@kernel.org>
Message-ID: <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-9-tj@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5



On Mon, 29 Jan 2024, Tejun Heo wrote:

> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts dm-verity from tasklet to BH workqueue.
> 
> This is a minimal conversion which doesn't rename the related names
> including the "try_verify_in_tasklet" option. If this patch is applied, a
> follow-up patch would be necessary. I couldn't decide whether the option
> name would need to be updated too.
> 
> Only compile tested. I don't know how to verity.

Download the cryptsetup package with "git clone 
https://gitlab.com/cryptsetup/cryptsetup" and run the testsuite: 
./autogen.sh && ./configure && make && make check

> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: dm-devel@lists.linux.dev
> ---
>  drivers/md/dm-verity-target.c | 8 ++++----
>  drivers/md/dm-verity.h        | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 14e58ae70521..911261de2d08 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -645,9 +645,9 @@ static void verity_work(struct work_struct *w)
>  	verity_finish_io(io, errno_to_blk_status(verity_verify_io(io)));
>  }
>  
> -static void verity_tasklet(unsigned long data)
> +static void verity_bh_work(struct work_struct *w)
>  {
> -	struct dm_verity_io *io = (struct dm_verity_io *)data;
> +	struct dm_verity_io *io = container_of(w, struct dm_verity_io, bh_work);
>  	int err;
>  
>  	io->in_tasklet = true;
> @@ -675,8 +675,8 @@ static void verity_end_io(struct bio *bio)
>  	}
>  
>  	if (static_branch_unlikely(&use_tasklet_enabled) && io->v->use_tasklet) {
> -		tasklet_init(&io->tasklet, verity_tasklet, (unsigned long)io);
> -		tasklet_schedule(&io->tasklet);
> +		INIT_WORK(&io->bh_work, verity_bh_work);
> +		queue_work(system_bh_wq, &io->bh_work);
>  	} else {
>  		INIT_WORK(&io->work, verity_work);
>  		queue_work(io->v->verify_wq, &io->work);
> diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
> index f9d522c870e6..7c16f834f31a 100644
> --- a/drivers/md/dm-verity.h
> +++ b/drivers/md/dm-verity.h
> @@ -83,7 +83,7 @@ struct dm_verity_io {
>  	struct bvec_iter iter;
>  
>  	struct work_struct work;
> -	struct tasklet_struct tasklet;
> +	struct work_struct bh_work;
>  
>  	/*
>  	 * Three variably-size fields follow this struct:

Do we really need two separate work_structs here? They are never submitted 
concurrently, so I think that one would be enough. Or, am I missing 
something?

Mikulas


