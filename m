Return-Path: <netdev+bounces-170923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD87A4AB2F
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 14:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F447A9150
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E260D1DEFD9;
	Sat,  1 Mar 2025 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZEsfTCr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D1C1DEFC6
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740835427; cv=none; b=nd4BJGNaAyBgP2WnN9vZ85nnQoxTK/W8Fp076Cswl5N7HYyqV0uSelKyDv6TQgTF8rde9gnC0S9UBs33j+xQrXTTtTcmoLb3C3Kn/YeW6mzcQR8+sDuwx+D1dNGQ2MnsRgFlSeP8MR92trq84SAddkQM92pkpuonBh6PWUWkQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740835427; c=relaxed/simple;
	bh=e0rnZMhEMiAUQTxbgiZzUSFZ5nBLEt4/w7x9kl/MjuY=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=aa5Di7rBDRgTwaS31UCzz+yYsf548j+flFSKvcLFWz59dQCVVE0KHzrO9CeDEgGYtLDg143DHW8MUnxWNNBHaHnRZs1a59trXIfeFDgwjzzyGZwsy2ZfOmrGXUisPKX/hh3zsslnVoEYJ3qMBu2zIBHWI+OQy2bYEWrDEDpUj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZEsfTCr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740835425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dz7l8w6UiNg+5Zdj84Y/hcID0P1LPNoS3K4bE+q9Cts=;
	b=RZEsfTCrorw5AXD1zkpDuUJHe4ZT88xl3EHCoFm1pBQhjxoxuTU7JEQ6ifODvMo7W0tvwl
	0sAssK0OmTRfl6plH9Gb89VRYJEO9YdSkpSSstoEPeHdaTNh+OF1jpGit8YALxjchyIMI2
	yYbXbTm/3Ejdbfdi9xfNcRghV6tHZhs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-oiz-hgX8P_GB2jjBtel0Hw-1; Sat,
 01 Mar 2025 08:23:32 -0500
X-MC-Unique: oiz-hgX8P_GB2jjBtel0Hw-1
X-Mimecast-MFC-AGG-ID: oiz-hgX8P_GB2jjBtel0Hw_1740835410
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21B141801A0D;
	Sat,  1 Mar 2025 13:23:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3FC4619560AB;
	Sat,  1 Mar 2025 13:23:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3399367.1740753918@warthog.procyon.org.uk>
References: <3399367.1740753918@warthog.procyon.org.uk> <20250228062216.77e34415@kernel.org> <3190716.1740733119@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
    Christian Brauner <brauner@kernel.org>,
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
Content-ID: <3475524.1740835404.1@warthog.procyon.org.uk>
Date: Sat, 01 Mar 2025 13:23:24 +0000
Message-ID: <3475525.1740835404@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

David Howells <dhowells@redhat.com> wrote:

>         cell->dynroot_ino = idr_alloc_cyclic(&net->cells_dyn_ino, cell,
>                                              2, INT_MAX / 2, GFP_KERNEL);
> -       if (cell->dynroot_ino < 0)
> +       if ((int)cell->dynroot_ino < 0)
>                 goto error;

That's not right.  I need to copy the error into 'ret' before jumping to
error.  Probably better to do:

	ret = idr_alloc_cyclic(&net->cells_dyn_ino, cell,
                               2, INT_MAX / 2, GFP_KERNEL);
	if (ret < 0)
		goto error;
	cell->dynroot_ino = ret;

David


