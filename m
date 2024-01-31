Return-Path: <netdev+bounces-67720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B76844AA6
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 23:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415181C20DE0
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBB639FC7;
	Wed, 31 Jan 2024 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHKezBPZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3206C39AC8
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738571; cv=none; b=ZMlfbd+ZtWOBPoznlmPi0KaTy4CdAMp0eJRORdICB2kgzbvL8EqOcL6zxyzqRScBRdpe8XtU1FLzERUbOwpwfZIYqmIOMOeDPuCCAUrlmL74zrAvNVt64XTjZBUbFju5OA7Mltg9yqZptDVRiXS82lU1mhxm9u6/+6XKK1MzDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738571; c=relaxed/simple;
	bh=zYpL4lqLZcMZwHPGsHutXjfMxMqLdIP4q+lWTgr3/5g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cjdC6Ch5u5+rinoM5HrPW6EQspdvKXBgJ7I/IhrEGrba8yPzlk0kM0LeYHXbYH3IvA/Lm5wr1oXmCwmUTYljw+S0Qsd79CNG3a9aWFdV6UEwr4lsciCAFo9Nw02paMFSMqQQIyUirm/s3adeLN0A7R/Qb9KfLwHB6PXAQWt8lhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iHKezBPZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706738569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdbEKrpyLSr/XfltsGu0Y6emup0IET0jljTchC3c+Yk=;
	b=iHKezBPZinxgysCtAIDondAT+m1XmxRvj9T/zpuMY19zvz+5gzgHLdn/v8gQ8XxyZ3TuYL
	CebU/bLOFro+103hsG5mmQKJEjkCIjkcRhBMU0eyVhBW+IrVxpEZdEZMuA2mOB+R5luFjN
	K09GnL68L7WJw2xz0Xd89ykvUaKw65I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-HIqzZnzXPwy0fqocRmRlKw-1; Wed, 31 Jan 2024 17:02:44 -0500
X-MC-Unique: HIqzZnzXPwy0fqocRmRlKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E29BD85A58C;
	Wed, 31 Jan 2024 22:02:43 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9776F40C1231;
	Wed, 31 Jan 2024 22:02:43 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 7F50730C14EB; Wed, 31 Jan 2024 22:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 7CA4A3F7DC;
	Wed, 31 Jan 2024 23:02:43 +0100 (CET)
Date: Wed, 31 Jan 2024 23:02:43 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Tejun Heo <tj@kernel.org>
cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
    dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com, 
    damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com, 
    peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org, 
    allen.lkml@gmail.com, kernel-team@meta.com, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
In-Reply-To: <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
Message-ID: <f48626b7-d1c-d696-7138-39fbc1c9cebd@redhat.com>
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-9-tj@kernel.org> <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com> <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2



On Wed, 31 Jan 2024, Tejun Heo wrote:

> Hello,
> 
> On Wed, Jan 31, 2024 at 10:19:07PM +0100, Mikulas Patocka wrote:
> > > @@ -83,7 +83,7 @@ struct dm_verity_io {
> > >  	struct bvec_iter iter;
> > >  
> > >  	struct work_struct work;
> > > -	struct tasklet_struct tasklet;
> > > +	struct work_struct bh_work;
> > >  
> > >  	/*
> > >  	 * Three variably-size fields follow this struct:
> > 
> > Do we really need two separate work_structs here? They are never submitted 
> > concurrently, so I think that one would be enough. Or, am I missing 
> > something?
> 
> I don't know, so just did the dumb thing. If the caller always guarantees
> that the work items are never queued at the same time, reusing is fine.
> However, the followings might be useful to keep on mind:
> 
> - work_struct is pretty small - 4 pointers.
> 
> - INIT_WORK() on a queued work item isn't gonna be pretty.
> 
> - Flushing and no-concurrent-execution guarantee are broken on INIT_WORK().
>   e.g. If you queue_work(), INIT_WORK(), flush_work(), the flush isn't
>   actually going to wait for the work item to finish. Also, if you do
>   queue_work(), INIT_WORK(), queue_work(), the two queued work item
>   instances may end up running concurrently.
> 
> Muxing a single work item carries more risks of subtle bugs, but in some
> cases, the way it's used is clear (e.g. sequential chaining) and that's
> fine.

The code doesn't call INIT_WORK() on a queued work item and it doesn't 
flush the workqueue (it destroys it only in a situation when there are no 
work items running) so I think it's safe to use just one work_struct.

Mikulas


