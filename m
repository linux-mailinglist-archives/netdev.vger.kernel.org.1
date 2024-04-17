Return-Path: <netdev+bounces-88639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A99D8A7F1D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0184B1F26765
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F2F12DD87;
	Wed, 17 Apr 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ma/1MAkK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9549212CD98
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344692; cv=none; b=HWaZIN7WOaEvJghLf/sg5+TjqQabsNxeX+og1o78t7QtZb67+6314O2O0XDKG8KFNRLR4uo7HOp9gSJP4OleCAcX6xJTBbSEoaRPn03IgNHxcCrlOtYbz0oc1+LzT1yX/3XhgqHUDQWBbrf9Cr8LhIwu1GM2CVW+yqXdTzPsffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344692; c=relaxed/simple;
	bh=qPI0pCxxPzUoBEsI0BzOZn8buvMBR2S+RPSF+No4b5c=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=RDrchOJ6F7M72UVP1FKGsX3VjUNrHVQFI0EJwmSwR1xxFRVkqgreKJAcwbu2F+4iSJvyyT8D87vNCw4NU5CDgomVqmCFzQTT5xwekL1DAWu8pITE6S2SUjLMQSh8pk4Icc43IgCmiRrg8J/ymPI2po5PTy/tz5iMSWXIy6gqzCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ma/1MAkK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713344690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0o9cqWvopzRGIbQrWEpYy4RFrMHbVHwEFIkzoBARCg=;
	b=Ma/1MAkKX1oqlz0AiByVYvBf/isWjn9ydU1rIGqNpMbc5MtbuFPAI/85gZKH502FIxEkSd
	BPKKzkpU+14vorjPk9uozg4H36FhBYCJ5TRtnK7Bc/qYHn0Xhx8Ugoljk1Az2RnJzkebHA
	KeedE3nuFRqGLCp4Jhxwsnk2/ZmhfPw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-NWduv8-0ObmjjPW5VGH_hQ-1; Wed, 17 Apr 2024 05:04:44 -0400
X-MC-Unique: NWduv8-0ObmjjPW5VGH_hQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A15C806528;
	Wed, 17 Apr 2024 09:04:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 24BDC490DD;
	Wed, 17 Apr 2024 09:04:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <f555b324b79829d6fc63da0d05995ce337969f65.camel@kernel.org>
References: <f555b324b79829d6fc63da0d05995ce337969f65.camel@kernel.org> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-18-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Matthew Wilcox <willy@infradead.org>,
    Steve French <smfrench@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/26] netfs: Fix writethrough-mode error handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28313.1713344659.1@warthog.procyon.org.uk>
Date: Wed, 17 Apr 2024 10:04:19 +0100
Message-ID: <28314.1713344659@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Jeff Layton <jlayton@kernel.org> wrote:

> Should this be merged independently? It looks like a bug that's present
> now.

Yes.  I've just posted that as a separate fix for Christian to pick up.  I
still need to keep it in this set, though, until it is upstream.

David


