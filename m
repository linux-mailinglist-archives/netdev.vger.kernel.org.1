Return-Path: <netdev+bounces-162575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECDEA27428
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD203A8B8B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27794211A1E;
	Tue,  4 Feb 2025 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvnHT2kI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0C1211490
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738678180; cv=none; b=RMMZclr6r+GqaRsy20X4+S1IvPAeIjF+AEZbmYdZc8YZto6AM4NhNEIJxTKYbN1ObpD6ExyQEG/S15OsfVOGEON3fPqVLbS9yyamHZPW5MuksXNnxUqSkFZKxQMQtCjw5R8UGAnLmG9yTITZZ5neah/souP8t/51Pv0RBg2oXdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738678180; c=relaxed/simple;
	bh=FdRV7dJVnVj1j/AEXGwiRQUI1WfYKxSdSx4eOKpjjX0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=o6DvNyVKZoJFBoXFz+NEqEGe5TJtYz8rM+9YIGyJtoJdEDR7AyBaz8Q2YP9DNRx0x2ZLQpDObO5fYmkXPkzT/7J/Pz/Jj41RJuwXXBno3MXxhFAO/tkdSfcU8Ce1Sn+mAz0UaC3bZy13gPgqUscSWs2lrbjqw2HxND1lY453pok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvnHT2kI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738678177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdRV7dJVnVj1j/AEXGwiRQUI1WfYKxSdSx4eOKpjjX0=;
	b=fvnHT2kI8othpa/kVvAW9R8TSGRjoQ6TWV8Dls7mdNQT9enOSnInU7f86/6mwj8J06BC4n
	WUx+uJG7tOSo9POTiiauubKUQ4WbLBRU+7cdLjLtf1D7lSqwQKB16P28RbbyIvPmoSdicf
	0HYMa3z+Ke2FhhtAC6Tgvqp8sH5Yb/s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-ZEO8It7fMQSrt_rjSIZfwg-1; Tue,
 04 Feb 2025 09:09:32 -0500
X-MC-Unique: ZEO8It7fMQSrt_rjSIZfwg-1
X-Mimecast-MFC-AGG-ID: ZEO8It7fMQSrt_rjSIZfwg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1B2818009C1;
	Tue,  4 Feb 2025 14:09:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 342A118008C8;
	Tue,  4 Feb 2025 14:09:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <716751b5-6907-4fbb-bb07-0223f5761299@redhat.com>
References: <716751b5-6907-4fbb-bb07-0223f5761299@redhat.com> <20250203110307.7265-1-dhowells@redhat.com> <20250203110307.7265-3-dhowells@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net 2/2] rxrpc: Fix the rxrpc_connection attend queue handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <549952.1738678165.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Feb 2025 14:09:25 +0000
Message-ID: <549953.1738678165@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Paolo Abeni <pabeni@redhat.com> wrote:

> A couple of minor nits: I think this deserves a 'Fixes' tag,

Fixes: f2cce89a074e ("rxrpc: Implement a mechanism to send an event notifi=
cation to a connection")

> and possibly split into separate patches to address the reported problem=
s
> individually.

I can do that if you really want.

David


