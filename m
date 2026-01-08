Return-Path: <netdev+bounces-248105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28095D0429A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D35A30508B3
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28EE40FD83;
	Thu,  8 Jan 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCOREY3r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8A40FD82
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882507; cv=none; b=RwrYpbyXU1cb63D24Bm8x1WXBIbAiXkg/0MGAHFAG13pt1gs5aF/V3ci8z/1AkfpY8HuZ2mC7sKHIEXgJ+qyS8Y/v1XQxgCFyRz5QxvTMqSzMmIEexMzXQEc5oeC7AzHQg71p3yLTblWIGcFM5+yhIUHXV4LzoCAoKAy1E5ifns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882507; c=relaxed/simple;
	bh=D+97G85jkwq44zug9GC2GyAfPD9MnT1LhuZ3x05qiXQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=LKoUtuO0BoPdKzoVAKdmSVmA3BUGiJS1fMu0p1xty/l8nZEy3ZteKlM+TuWbMg4DwtbqDoFPCi2AWUmUxEHaYGztWz0qCCCidOlwObklwdzHE9vvL94C6ke5gCToS1kwf0VGzfqxd+3TLcE8S9uk3d+SVUHVdpbyRANtEQqabVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCOREY3r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767882505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xNexTqCHVDcVwW22lygltlD6uavxVUzC/ZSbgJIKvGg=;
	b=UCOREY3rVlHilGJzJUauOzsiaZljnhYpiYtElICeq8NvPb9xrxup31nO9V5IWBjsMsnPxH
	8RwbmUsFdfXAqphUIHV20QNKau+rlwR6T1pT5JIeyc65yYJBrlSL87mw9ZyOlAFcaT24rh
	Q+pWKoNB54fMpxCRmqO7XPOEzokkH9w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-vgsnEQTqPQS65cOOZ6Xy9w-1; Thu,
 08 Jan 2026 09:28:22 -0500
X-MC-Unique: vgsnEQTqPQS65cOOZ6Xy9w-1
X-Mimecast-MFC-AGG-ID: vgsnEQTqPQS65cOOZ6Xy9w_1767882500
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EE3718005B6;
	Thu,  8 Jan 2026 14:28:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2FC930002D2;
	Thu,  8 Jan 2026 14:28:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CANn89i+z6XzGGJRJFuL-1_FDeRXQUULZwZNnXU9RLkcptpw7jA@mail.gmail.com>
References: <CANn89i+z6XzGGJRJFuL-1_FDeRXQUULZwZNnXU9RLkcptpw7jA@mail.gmail.com> <695e7cfb.050a0220.1c677c.036b.GAE@google.com> <2744142.1767879733@warthog.procyon.org.uk>
To: Eric Dumazet <edumazet@google.com>
Cc: dhowells@redhat.com,
    syzbot <syzbot+6182afad5045e6703b3d@syzkaller.appspotmail.com>,
    davem@davemloft.net, horms@kernel.org, kuba@kernel.org,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    marc.dionne@auristor.com, netdev@vger.kernel.org, pabeni@redhat.com,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] [net?] KCSAN: data-race in rxrpc_peer_keepalive_worker / rxrpc_send_data_packet
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2744875.1767882492.1@warthog.procyon.org.uk>
Date: Thu, 08 Jan 2026 14:28:12 +0000
Message-ID: <2744876.1767882492@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Eric Dumazet <edumazet@google.com> wrote:

> LGTM, but potential load and store tearing should be avoided, using
> READ_ONCE() and WRITE_ONCE().

Fair point.

> last_tx_at being time64_t, this would still be racy on 32bit arches.
> 
> last_tx_at could probably be an "unsigned long" (in jiffies units)...

I've tried avoiding jiffies where possible.  We have way too many different
clocks with different granularities and uses in the kernel, but you might be
right.

David


