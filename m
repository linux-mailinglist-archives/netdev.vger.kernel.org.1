Return-Path: <netdev+bounces-185535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BEBA9AD34
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F3B19452ED
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55F22B595;
	Thu, 24 Apr 2025 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmqWHxIN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC9157A67
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497385; cv=none; b=XSqzwjyKyOKN9hULWK9uyXOW93AU4JJc2rk7Y92gvxwziz8pSZ3bFsWPcgftFVaK5/a22DhrCdy2jsVlAmVMXrOTB1QVnZUSc+RE9n5PaV7htuNY4dam4PXZaO5I4W0I8OPWym+lkISKOVxlOId3UAFC6IC1gFQWbZB3QrLePoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497385; c=relaxed/simple;
	bh=e6TIk1k6gaYrJri9pmd1FONaT03IBpI7iPR3MjIaPbc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=M+nkB8gEmSTg6bV/8pPO1qGPGfr1HyOI1CaAYKWZnCYI4VskAhoNyVPmqv+4xuMyIbPQ5Vmxt/wd0GhacFnHTB6F7jiw8C5HSJXat/m7pIe/a8opM85/goyJMBjzv7+ZrsrQipvdD4CfFULNt9UXKSzrQJvcEMMAe4sPQ9J/vu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmqWHxIN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745497382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7Ap0RPtUmDAb/aCd6HFvT2KxgtdQAWYYK6uDU1o8uU=;
	b=SmqWHxINchybyE9J+aLRN8TnLysJw0nDO4XDebNN+eFmC4ArW+hbG8TiZ31Kyz1AoWBKup
	bT7wDEkxnntg5w9MNGZv49ZkboHUOaZ3Jv3QCMI62Dhqo/QZMk2DQdYCjz25eLGiQJPW/2
	tsh/0FMN8Jlla+LSKJnQkQ8IF1tNNxw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-6UyWrLWYO1--sLyphaECkg-1; Thu,
 24 Apr 2025 08:23:01 -0400
X-MC-Unique: 6UyWrLWYO1--sLyphaECkg-1
X-Mimecast-MFC-AGG-ID: 6UyWrLWYO1--sLyphaECkg_1745497379
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 552AE1800360;
	Thu, 24 Apr 2025 12:22:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E097180047F;
	Thu, 24 Apr 2025 12:22:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250422235147.146460-1-linux@treblig.org>
References: <20250422235147.146460-1-linux@treblig.org>
To: linux@treblig.org
Cc: dhowells@redhat.com, horms@kernel.org, marc.dionne@auristor.com,
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
    pabeni@redhat.com, corbet@lwn.net, linux-afs@lists.infradead.org,
    netdev@vger.kernel.org, linux-doc@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] rxrpc: Remove deadcode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3098547.1745497373.1@warthog.procyon.org.uk>
Date: Thu, 24 Apr 2025 13:22:53 +0100
Message-ID: <3098548.1745497373@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Remove three functions that are no longer used.
> 
> rxrpc_get_txbuf() last use was removed by 2020's
> commit 5e6ef4f1017c ("rxrpc: Make the I/O thread take over the call and
> local processor work")
> 
> rxrpc_kernel_get_epoch() last use was removed by 2020's
> commit 44746355ccb1 ("afs: Don't get epoch from a server because it may be
> ambiguous")
> 
> rxrpc_kernel_set_max_life() last use was removed by 2023's
> commit db099c625b13 ("rxrpc: Fix timeout of a call that hasn't yet been
> granted a channel")
> 
> Both of the rxrpc_kernel_* functions were documented.  Remove that
> documentation as well as the code.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: David Howells <dhowells@redhat.com>


