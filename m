Return-Path: <netdev+bounces-170229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C20BA47E99
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BCD1894542
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92E22F397;
	Thu, 27 Feb 2025 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qk8bfTSw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4122F178
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661842; cv=none; b=Cs2EVdRk0BsunYCJkK8Rcb/QQrU08xBbAOD9VECjFyulcoMpKqlMEjE6DSdHBZV5qcb8hytnYiuQOIk4Onm1ZgOQNL5B88wT4gWqMtL9ZqxUgtlsAWFmnCAtlGTYy8nJ/QPr1K/onvQe5awXT4pZ6Q5o4KGMJ08aGzbn1q5QjwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661842; c=relaxed/simple;
	bh=x0K9es0UVKWTnlmDD8ugRax1f8Iim+oHnXb/jzmCklw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=m6qgMm1ZeQxt3EFUGviB8VSatYjlnuCjbj0U/hV90nGKTHc7W5Fp2XUmUuPvghM0TEx06+r+3bGzw3Lmy6qBu4yCQA6OIXpPinda8KBdSs3HHOY1JBgseYuabR86iRjmh0JHuNgZURcR8nhhKE+ylhlu1BOKENpaVg3QjLfadus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qk8bfTSw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740661840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIJmqPFW7GnIJ0hY3Mu09dKEfAL2sWzM9Kk2euVLCuc=;
	b=Qk8bfTSwYU/XQaDe38RHrm/m4iOGpz1903DaRVdwC0hzmc7zUFOyNbx+Iu9HFqMRPSfvIu
	+JCt6EA+13YCZzhQeY3LwEygvIbOuywY/rkyuEoJ+l3LiRRR498jn7qblxLoTv+ThOZ1D1
	kcYHB9DwLSjLZYUZLq9lRHslHOvYeoE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-2AIoxtemOkG2Lhh5ZO9hsQ-1; Thu,
 27 Feb 2025 08:10:37 -0500
X-MC-Unique: 2AIoxtemOkG2Lhh5ZO9hsQ-1
X-Mimecast-MFC-AGG-ID: 2AIoxtemOkG2Lhh5ZO9hsQ_1740661836
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 195491944CFD;
	Thu, 27 Feb 2025 13:10:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DD781944CC9;
	Thu, 27 Feb 2025 13:10:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <899dfc34-bff8-4f41-8c8c-b9aa457880df@redhat.com>
References: <899dfc34-bff8-4f41-8c8c-b9aa457880df@redhat.com> <20250224234154.2014840-1-dhowells@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>,
    Christian Brauner <brauner@kernel.org>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/15] afs, rxrpc: Clean up refcounting on afs_cell and afs_server records
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3151400.1740661831.1@warthog.procyon.org.uk>
Date: Thu, 27 Feb 2025 13:10:31 +0000
Message-ID: <3151401.1740661831@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Paolo Abeni <pabeni@redhat.com> wrote:

> The remaining patches in this series touch only AFS, I'm unsure if net-next
> if the best target here???

Yeah.  It's tricky as the complete set of patches I would like to post spans
three subsystems.

> The rxrpc follow-up could just wait the upcoming net -> net-next merge.
> AFAICS crypto patches go trough their own tree.

Ah, no.  That doesn't work.  The rxrpc follow-up needs the crypto patches to
even compile and so needs to go through the same tree.

Further, the afs patches in this patchset are also something of a
pre-requisite for the afs part of the rxrpc follow-up.  The problem is that we
have to be able to map back from the address in a challenge packet back to the
managing socket and the server record in order that we can send find the info
to put in the response packet and the key required in order to encrypt it.

This is something that this patchset deals with, as part of fixing some a
couple of very low-probability bugs (hence why I proposed it for net-next
rather than pushing it Linuswards).

If you prefer, I can see about sending all the patches through the vfs tree or
the crypto tree rather than net-next.  Or I can see if I can push this set as
a bug fix through the VFS tree.

David


