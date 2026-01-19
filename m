Return-Path: <netdev+bounces-251332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34BD3BC01
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 00:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DAB83022A9A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 23:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7968019CC14;
	Mon, 19 Jan 2026 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoLRiC/8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B618FC97
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768866379; cv=none; b=b9Gr11Csh1cJw1xtIxwxZYbl4mqIWjr60ApnLyiRA7QSjiCy6+Xa7PYwmiNRDDYUVf7BM/EFYjEICz7ZEGRVfNXwC+NTAAnabt2Gt6pZsqxunNs2G4sWm8vWXTp8nB1hHjcWnwk8QUTwiOBfvqRlQJ3KDCtxUu18LjTxh1zLmHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768866379; c=relaxed/simple;
	bh=vAcyr6CvZ1hAKKeJKUw8gu5zteILb8IzmgmFU9Mc9iw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=BuxKPWhRBX+S32pS8996MGuDLrI05F6EPK51P1JRYzsQl6zBvjJrMA0uKP5mDfLnejI3KbjNT/WPrvO//D1H35tqMWNgoaI8ZlIQ2yvxJth4cse3OnqEEGa0brNT3zfZy2JT3Jz0SURQn1aWMWimw12wKIo3vvH4ybPfTsT5klk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoLRiC/8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768866376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAcyr6CvZ1hAKKeJKUw8gu5zteILb8IzmgmFU9Mc9iw=;
	b=MoLRiC/8mH/cY/EQNjE2GA9aEv5O0TYMIt+gcHqwM2tjNz2kKaQ+wBiksYZVLh7ys0dyVj
	F5BFVfr0JdFKgZLuODJjeAa/Qkbq/uJtclERQ6O4T8pSWH8gPQPltmXbIBpWM0qQk+3ZfR
	IcUlGwJY/q70/Qb4U6PBjBgRU+8qbDY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-_3zG3Y7RO_KUK3h6cdG-9w-1; Mon,
 19 Jan 2026 18:46:12 -0500
X-MC-Unique: _3zG3Y7RO_KUK3h6cdG-9w-1
X-Mimecast-MFC-AGG-ID: _3zG3Y7RO_KUK3h6cdG-9w_1768866371
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61F06195609E;
	Mon, 19 Jan 2026 23:46:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FC5719560AB;
	Mon, 19 Jan 2026 23:46:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260119093945.7929e3cb@kernel.org>
References: <20260119093945.7929e3cb@kernel.org> <20260118002427.1037338-2-kuba@kernel.org> <89226.1768426612@warthog.procyon.org.uk> <916127.1768737781@warthog.procyon.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org
Subject: Re: [net,v2] rxrpc: Fix data-race warning and potential load/store tearing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1048143.1768866369.1@warthog.procyon.org.uk>
Date: Mon, 19 Jan 2026 23:46:09 +0000
Message-ID: <1048144.1768866369@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Jakub Kicinski <kuba@kernel.org> wrote:

> Right, total nit pick. It's mostly for consistency with other fields in
> the same print statement that are READ_ONCE()d.

On further thought, it might be worth doing it anyway to stop KCSAN
complaining about it.

David


