Return-Path: <netdev+bounces-44178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEFD7D6BEA
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69496281B58
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EEBEAF7;
	Wed, 25 Oct 2023 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRjPeW3S"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28027EE5
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:35:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DDD192
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698237343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZpHifrU2s5Zl3Ak7+hsd8JgtA2mkf3sTAvVq9SRCPk=;
	b=SRjPeW3SEwYFsRX0ybH1gSq/LL6L4O3p0/MbTszlJc7zQ7XtBjq6Bp7tLy31VWMKIkeKHp
	N+ISpui2s+LhO+/lswoQZHrwEKe7o70Y+KDd2kdthBFEm+HHWSWB3vO1qODWljzzu+J5C0
	0C2ymIInsW5xjPjxvmE07MnzcnC5znI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-margzujmNWm9iKyqDIlRyQ-1; Wed, 25 Oct 2023 08:35:38 -0400
X-MC-Unique: margzujmNWm9iKyqDIlRyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86848857CF6;
	Wed, 25 Oct 2023 12:35:37 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 992CF1C060AE;
	Wed, 25 Oct 2023 12:35:34 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trond.myklebust@hammerspace.com, anna@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net v2] net: sunrpc: Fix an off by one in
 rpc_sockaddr2uaddr()
Date: Wed, 25 Oct 2023 08:35:33 -0400
Message-ID: <3860625A-B435-45A7-BC53-883A50539510@redhat.com>
In-Reply-To: <31b27c8e54f131b7eabcbd78573f0b5bfe380d8c.1698184674.git.christophe.jaillet@wanadoo.fr>
References: <31b27c8e54f131b7eabcbd78573f0b5bfe380d8c.1698184674.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 24 Oct 2023, at 17:58, Christophe JAILLET wrote:

> The intent is to check if the strings' are truncated or not. So, >= should
> be used instead of >, because strlcat() and snprintf() return the length of
> the output, excluding the trailing NULL.
>
> Fixes: a02d69261134 ("SUNRPC: Provide functions for managing universal addresses")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Fix cut'n'paste typo in subject
>     Add net in [PATCH...]
> ---

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


