Return-Path: <netdev+bounces-173897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE9EA5C2B0
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80268171984
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BF22940F;
	Tue, 11 Mar 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5f0ZTof"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28733E1
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699829; cv=none; b=p5f4BXJa1v5Lf/teQC5sl+j6d+m2hqqHtFdirP1oFtKIozDK9iiWWWEskIS95oYRDnwIq+jruPalnyel/7sGn/hC4U1CvZ6AYxtgqKWsCSmVgdxrdRJai2Ajp4qSZ5gb05eTBudK8OhjGK1bUb/WoG8CVSd2HMpPItLg6IBLS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699829; c=relaxed/simple;
	bh=l6zR6XGtKJ5X0OhwmHL3+OfRxrFGdi1TkJcer1hdk8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsoFxIfAoT0gPUQHPO+QRcM4ppsJfav9kQfbo01HzBp7EcwPt/OiEPt4TjZ/2z2cTzawf/77JA0DQIstxpav372v3BPcPBggY0H5FQYsxcqrz7wnbgHZDye1zaWzz/SvWeKjUc7uMMxDll6feiul9pzKzjOzaHDdrFR44btmpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5f0ZTof; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741699826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pEztC+tYEqmw4n/BkTKddXXttPyUOtkMeTZTPuQrQU=;
	b=W5f0ZTofHbh+KdeMBRINVFTxZ7i1StaMIBvxCU59JdB+jMwFsDIF6nZZ8EywwWTIhmAZ17
	NFMjwaBTjm5vOwJ7l1affWW8qiGh+1mkG8BXBsoqEqRbTETg3w9hZGWPuV4lI2zpdOP6ts
	5YkLImlohm117sjmwOMYwHkkSTKXdxg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-kqLrgj9lMQ6k8PpG0HaASg-1; Tue,
 11 Mar 2025 09:30:21 -0400
X-MC-Unique: kqLrgj9lMQ6k8PpG0HaASg-1
X-Mimecast-MFC-AGG-ID: kqLrgj9lMQ6k8PpG0HaASg_1741699818
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D90E91808869;
	Tue, 11 Mar 2025 13:30:16 +0000 (UTC)
Received: from fedora (unknown [10.22.88.194])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B40EF1955BCB;
	Tue, 11 Mar 2025 13:30:13 +0000 (UTC)
Date: Tue, 11 Mar 2025 09:30:11 -0400
From: Luiz Capitulino <luizcap@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm tree
Message-ID: <20250311093011.48fa9d08@fedora>
In-Reply-To: <20250311120422.1d9a8f80@canb.auug.org.au>
References: <20250311120422.1d9a8f80@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, 11 Mar 2025 12:04:22 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   mm/page_owner.c
> 
> between commit:
> 
>   a5bc091881fd ("mm: page_owner: use new iteration API")
> 
> from the mm-unstable branch of the mm tree and commit:
> 
>   8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
> 
> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

This looks good to me:

Reviewed-by: Luiz Capitulino <luizcap@redhat.com>

> -- 
> Cheers,
> Stephen Rothwell
>
> diff --cc mm/page_owner.c
> index 849d4a471b6c,90e31d0e3ed7..000000000000
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@@ -297,11 -293,17 +297,17 @@@ void __reset_page_owner(struct page *pa
>  
>  	page_owner = get_page_owner(page_ext);
>  	alloc_handle = page_owner->handle;
> +	page_ext_put(page_ext);
>  
> - 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
> + 	/*
> + 	 * Do not specify GFP_NOWAIT to make gfpflags_allow_spinning() == false
> + 	 * to prevent issues in stack_depot_save().
> + 	 * This is similar to try_alloc_pages() gfp flags, but only used
> + 	 * to signal stack_depot to avoid spin_locks.
> + 	 */
> + 	handle = save_stack(__GFP_NOWARN);
>  -	__update_page_owner_free_handle(page_ext, handle, order, current->pid,
>  +	__update_page_owner_free_handle(page, handle, order, current->pid,
>   					current->tgid, free_ts_nsec);
>  -	page_ext_put(page_ext);
>   
>   	if (alloc_handle != early_handle)
>   		/*


