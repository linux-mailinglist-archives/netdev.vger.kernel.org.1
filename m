Return-Path: <netdev+bounces-170586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E9AA491CA
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 07:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AA116FC8E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F011C5D69;
	Fri, 28 Feb 2025 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vxydj1Bk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8B1C5496
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740725545; cv=none; b=BXkn9jGEcRtSS0PaCiFOhBO2bZQM9EraXhKdoTsGGoDJUm66qBmMErR3QsgZw/dZv0FLClBGcoZCTC49EcEg8nhXIwAtrZYUKCDzyi0iq5zyKIs1RqASXmN+fZC9ryQweVYh8E3D+Yen3ZVEcebkeTvJgn27NNv+3D6cvwXSPeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740725545; c=relaxed/simple;
	bh=Sbh5ZWWEWe26UKItzj+5zCsDrXi5+H0pVS+AgfDfnoE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=CNPAWiiRz1tmxCJdR7nGMYOGa+pI41vu7Osf6g+SJm9Xn9VJWX1Ov+oWy0nsMNeqgMtRqtdSlDaEVP2wdZpT9ZgSeHi/rBBSH1EbGQm4NqUTHnsxEpq57UPlV8v/3BEJhHwjBJcM0WtFSSq2lWIU8DDQwGwXE09OAExM+ZzIcGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vxydj1Bk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740725542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qwtQNloEq7bsSV3GNAWMqzfEITJvoRQgxNj/TQm4A+M=;
	b=Vxydj1BkFbkOKcLg1FX761Gsb6e5XloaTV3uw/4MBn/g1Emzoo34u2jax7RNPEwDIHoBEq
	3daWg1DBD6m7p6b13HrcxI8vUiIR/5DHqhTp7khI+AoTPa48xZitPn3uES9O0qJF8Goy9h
	S0TgdKefRTVNQ9sYx0h5w75k2aJhPBs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-Nl4Ayov0OOyP92iDsWZVqA-1; Fri,
 28 Feb 2025 01:52:16 -0500
X-MC-Unique: Nl4Ayov0OOyP92iDsWZVqA-1
X-Mimecast-MFC-AGG-ID: Nl4Ayov0OOyP92iDsWZVqA_1740725535
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D88C31944D01;
	Fri, 28 Feb 2025 06:52:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA825300019F;
	Fri, 28 Feb 2025 06:52:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250227164918.3b05d94e@kernel.org>
References: <20250227164918.3b05d94e@kernel.org> <20250224234154.2014840-1-dhowells@redhat.com> <174068405775.1535916.5681071064674695791.git-patchwork-notify@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, patchwork-bot+netdevbpf@kernel.org,
    netdev@vger.kernel.org, marc.dionne@auristor.com,
    davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
    brauner@kernel.org, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/15] afs, rxrpc: Clean up refcounting on afs_cell and afs_server records
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3182492.1740725529.1@warthog.procyon.org.uk>
Date: Fri, 28 Feb 2025 06:52:09 +0000
Message-ID: <3182493.1740725529@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Jakub Kicinski <kuba@kernel.org> wrote:

> Nice job pw-bot! Turns out the first 5 patches were already in the net
> tree with fixes, and now they made their way to Linus. So let's discard
> those from v2.

Yes.  I mentioned them specifically in the cover note.

> And even less of a reason for this to go via networking :(

The point wasn't those five patches, but the following rxrpc patches that I
haven't posted yet that depend on these... but never mind.

David


