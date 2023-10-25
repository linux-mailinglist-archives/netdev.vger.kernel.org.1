Return-Path: <netdev+bounces-44177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C397D6BE5
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF8E1C20CFE
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E75CEAEC;
	Wed, 25 Oct 2023 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKqG31BK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1026827EED
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:35:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE7129
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698237317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IIfXyZoxzqzNs1x6NcY6WinvIChe9VAS0A6uJtrJM9Q=;
	b=aKqG31BKSxVTQdelxxLCN20ZMX+8oH0jl3FAl6Gn3YdMOAmoYkG5nf+RsCkjYrkJgc7qWC
	Y4lYDkW5N+z0N0VwOj5hDbRdr5utTCGobdFLjYYVUkRbOj6yZP4bYVRZ3E2BLAjWajuXYE
	De6f3hNZrdajuEZsXgMI+C+tr3qjw1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-Q8Qxy8Y6ONSwH4z1ALu1_w-1; Wed, 25 Oct 2023 08:34:56 -0400
X-MC-Unique: Q8Qxy8Y6ONSwH4z1ALu1_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14F66811E8E;
	Wed, 25 Oct 2023 12:34:56 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.48.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CAF125C2;
	Wed, 25 Oct 2023 12:34:53 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trond.myklebust@hammerspace.com, anna@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: sunrpc: Fix an off by one in root_nfs_cat()
Date: Wed, 25 Oct 2023 08:34:52 -0400
Message-ID: <F7210412-252A-43F1-AF00-E5287C6C8DE5@redhat.com>
In-Reply-To: <856a652a7e28dde246b00025da7d4115978ae75f.1698184400.git.christophe.jaillet@wanadoo.fr>
References: <856a652a7e28dde246b00025da7d4115978ae75f.1698184400.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 24 Oct 2023, at 17:55, Christophe JAILLET wrote:

> The intent is to check if the strings' are truncated or not. So, >= should
> be used instead of >, because strlcat() and snprintf() return the length of
> the output, excluding the trailing NULL.
>
> Fixes: a02d69261134 ("SUNRPC: Provide functions for managing universal addresses")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


