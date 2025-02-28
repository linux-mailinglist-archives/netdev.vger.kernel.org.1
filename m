Return-Path: <netdev+bounces-170732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86908A49C17
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C10173C2B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972526E636;
	Fri, 28 Feb 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdPOTMoS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6002686A0
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753214; cv=none; b=L+yT6MUlvPQi6/G3dDEuLo51znO9aLnlJem3KyjFrxznnj2hsMCxNc+qfTLkYh4KQmHD7LioGxbTHHWDItt8XLWzywP4LURpjwv1fLWfXbwYA/Nc/9QwRdPmJMEFqQepIrdSGjKKrUo5hroGatJwulSyV98/MjkhqCQOSK6UaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753214; c=relaxed/simple;
	bh=Zgmg7JblY+/hL2U9IxAQA5UQ9MFOAnWe9NQRuo64PlQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=B+Nz1IY1dDfgAvK+/Cb1M2EakYPGw3A86iPO/gK7hpxOyh6vxVnZwhn7sIhwi/Hi9XkFRi35kkxMxt1kx267FT7k9zByRuVIqxqDVIcxTm3FJtVyOgqefUNq5ficw8rwW0/IniVXGI1G/SHqfN8FWJWA/J2sklJwphlnxdDZYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdPOTMoS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740753212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H1/lKR8OE6Oc19uEwndRksE75TBxzyMuRLQMwhnyPGk=;
	b=BdPOTMoSHyU0M7LmyREoG0h+W3JvJ/aDi6tSQZOz/+Ivkw19+xJuSLajdeArQr/EsS4SCu
	FgWeU/Qw/gR4h2UARTGZEIH8l8Niqu+e5h3UzLWxRiTJ9jLvlGpWYBMT996XOjHzZF/qjM
	EGN4LCtfGYMe4Sw5M2vP9Qp7ElVgMC8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-w6E_HGDOP5GXQP9jECoJNQ-1; Fri,
 28 Feb 2025 09:33:27 -0500
X-MC-Unique: w6E_HGDOP5GXQP9jECoJNQ-1
X-Mimecast-MFC-AGG-ID: w6E_HGDOP5GXQP9jECoJNQ_1740753206
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D4BD1954128;
	Fri, 28 Feb 2025 14:33:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 392BA1800367;
	Fri, 28 Feb 2025 14:33:20 +0000 (UTC)
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
Content-ID: <3377823.1740753199.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Feb 2025 14:33:19 +0000
Message-ID: <3377824.1740753199@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Jakub Kicinski <kuba@kernel.org> wrote:

> fs/afs/cell.c:203:5-22: WARNING: Unsigned expression compared with zero:=
 cell -> dynroot_ino < 0

Yeah, thanks - error handling bug.  I can retag it and ask Christian to pu=
ll
it again.  (unless he'd rather stack a fix patch)

David


