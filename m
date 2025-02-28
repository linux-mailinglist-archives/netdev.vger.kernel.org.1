Return-Path: <netdev+bounces-170741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BFFA49C57
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13411894F82
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07252702C6;
	Fri, 28 Feb 2025 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/DK31Af"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0825DAF0
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753933; cv=none; b=R3iaHULDudZ66Gl1eOYlLHFdyc2A6ic+BzJwQlFsUPZM8W+NSbsjP1eeW+kdmFXWZ5CfhtaYdoSlwMhUQZSAVB+DTeGqdP1scYuZMKJx81whIXTTFvNYe1RLN/Z9b3wnVaaTTbGwpvtmxt1ryC1bRQxbBpgrV7oZerem0zcxiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753933; c=relaxed/simple;
	bh=byHhrmUoG6SZ3TsbUshk2VRISfn1xMThT70emXrC9y4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=tQvVisorzTWwhqfDMd6sSim8xvBJICzxHsPsrEjJRf6uUwbfaW78eX41tWT5TmyYIHvbFw7zvebg2WDqWEYNt/QCs0ugfIIFT3iUZUDEWnk3VvNyu6Y4m0YCKmaMoTrfIYyw0VhqVYgX+ZOuwu78dNux1fJV4JXcFH/Ru10Zyp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/DK31Af; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740753931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U41DlrCChwyMCjiyWsF6DnAwdYiKyrfG/1RGaWwJ3j4=;
	b=N/DK31AfqlA1UZKhzoQ5EE3LR0lWv3gBVF5yLdSFA+So8OlZzaPibFvwPCfye90wJJmPb0
	Mr11GeTu4KkmBzuo4C3MQsmLL3vqyGeppRmOiqQd2r2HMf3ys31OIeUAbzLQS6FvdgEKzZ
	Qgj+wN0dfcZAwvHhuoKYgQdFCw2Uzvk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-OFd7jWtlMIW4r8DVNW-9GQ-1; Fri,
 28 Feb 2025 09:45:27 -0500
X-MC-Unique: OFd7jWtlMIW4r8DVNW-9GQ-1
X-Mimecast-MFC-AGG-ID: OFd7jWtlMIW4r8DVNW-9GQ_1740753926
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1B371954202;
	Fri, 28 Feb 2025 14:45:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2FDE1955BCB;
	Fri, 28 Feb 2025 14:45:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250228062216.77e34415@kernel.org>
References: <20250228062216.77e34415@kernel.org> <3190716.1740733119@warthog.procyon.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] afs, rxrpc: Clean up refcounting on afs_cell and afs_server records
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3399366.1740753918.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Feb 2025 14:45:18 +0000
Message-ID: <3399367.1740753918@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Jakub Kicinski <kuba@kernel.org> wrote:

> fs/afs/cell.c:203:5-22: WARNING: Unsigned expression compared with zero:=
 cell -> dynroot_ino < 0

I'll make this change:

--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -200,7 +200,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net =
*net,
        atomic_inc(&net->cells_outstanding);
        cell->dynroot_ino =3D idr_alloc_cyclic(&net->cells_dyn_ino, cell,
                                             2, INT_MAX / 2, GFP_KERNEL);
-       if (cell->dynroot_ino < 0)
+       if ((int)cell->dynroot_ino < 0)
                goto error;
        cell->debug_id =3D atomic_inc_return(&cell_debug_id);
 =


to patch 2 ("afs: Change dynroot to create contents on demand").

I'm not sure why gcc didn't warn about this - I'm sure it used to.

David


