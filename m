Return-Path: <netdev+bounces-115355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF78945F3E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757802838A4
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9426F1E4EF2;
	Fri,  2 Aug 2024 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfUWqUJp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E8E1E4EEB
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608302; cv=none; b=GlAb3vXMCJV6aA2btZFPomwx7eT7Rqvv/hXSwvTNcJiNmFI0EopzmoiWYaD9uumz6DqhJi5g44I+xNREwYEtNAfZugpDCAcQclehGgDlBzWd/6PFi9qQ5YDcl8Wa5qskBPdkeM1ULl2VIb0Ta8jwrd80FZ5rf2ybjIMN54kQgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608302; c=relaxed/simple;
	bh=Z5c5T9SO1qEs+S4zGxk90PSnPZppHdEyEZ6FALk8OgI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=R3JOqHJHURL8ifRTi6xghn5p/JRFzarnQArI5rovP9VVVPwa/hYAaQmAfB+VZdfnkM7Y8EwH0Gsm2mEy89IBH3v25UQimcogsj7A2IgHhzXpa3EjlNoiLSVEUdtPJhUFDlQ+1HUDDkjDNppKrNzdxuoCNU/Ue0ngqbj6EsbiFkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfUWqUJp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722608299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UIDX8cy8H46a6mHnpLua2nDQ7obthpcuLcvJcSVXyfU=;
	b=KfUWqUJpyjTkN2R7WvzmKWXObta/8RdJI8JhnYlEb7ikYdpEPYtFsqbrbLlDX5Iuzk489g
	McSej9e0jgQ/3ncQ7YpPnhvZ3yGRg69lYtQBD+5Dw4H7liODIBSMTIK4Jb3YwF4hPBhCJa
	sZpz4GczUUE/XUMJczKUHgwfkFySnVU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-oNOQTMjXPXOFGGA7YhgjQw-1; Fri,
 02 Aug 2024 10:18:15 -0400
X-MC-Unique: oNOQTMjXPXOFGGA7YhgjQw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 378B61955D48;
	Fri,  2 Aug 2024 14:18:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3AFCD19560AE;
	Fri,  2 Aug 2024 14:18:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240731190742.GS1967603@kernel.org>
References: <20240731190742.GS1967603@kernel.org> <20240729162002.3436763-1-dhowells@redhat.com> <20240729162002.3436763-19-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/24] netfs: Speed up buffered reading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <117845.1722608282.1@warthog.procyon.org.uk>
Date: Fri, 02 Aug 2024 15:18:02 +0100
Message-ID: <117846.1722608282@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Simon Horman <horms@kernel.org> wrote:

> If the code ever reaches this line, then slice will be used
> uninitialised below.

It can't actually happen (or, at least, it shouldn't).  There are only three
ways of obtaining data: downloading from the server
(NETFS_DOWNLOAD_FROM_SERVER), reading from the cache (NETFS_READ_FROM_CACHE)
and just clearing space (NETFS_FILL_WITH_ZEROES); each of those has its own
if-statement that will set 'slice' or will switch the source to a different
type that will set 'slice'.

The problem is that the compiler doesn't know this.

The check for NETFS_INVALID_READ is there just in case.  Possibly:

		if (source == NETFS_INVALID_READ)
			break;

could be replaced with a WARN_ON_ONCE() and an unconditional break.

David


