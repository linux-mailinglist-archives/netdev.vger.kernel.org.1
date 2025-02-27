Return-Path: <netdev+bounces-170333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EF1A4831E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC967A37AD
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C57326B95D;
	Thu, 27 Feb 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5VJ4E1N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624FD26B959
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670605; cv=none; b=IHKLkOFPQf9PRW3uS4QBWYTaXpRrQj8Rs1que0Y/TYFL1u2eO43qlrKUIBuxEZn/KkjDOm1hoYayImwGGb6iJwVX6D9hDTPKzsKISgjvUNXNxZjYqFPUkGcJjB2zluHyFI8wzj5oarPIqwRtKYs19pd4nkvPdXSRhnLjJFiuy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670605; c=relaxed/simple;
	bh=/w6Iwr/eip4sWrku2LH/504RAKTBWVQAlp9hp1HEszE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=UJcXoc4YLIAxyFoy8XjReWwIh0hpFwiQFtiTwR3rBg5ykhFJeM1CY7DBF3Lz571LyuQHDMFce6hn6nEV847Js+j9ubF2W+jpyAjMiipKbfrLJvdA5J+Mr6GS1MCSHaz0+q61ecqGo2+U3nK2xWvy+M76z1cZVRWRlArjdVRZzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5VJ4E1N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740670602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=654arh+d2qPqPE5taP6iEWvMfqZLmub5tQb2i6ChSXQ=;
	b=R5VJ4E1NhUR2GOo+HNhN20R1YL97Epsnn6UBK3Fl80gIvIH2BOKlZoNIHvSLyT5lF4v8Sr
	GN1VMt3veUqVAuy+PvaTPFyBiMszb5NrIniKZK20C43IQSnoe0QIRpTUiWWbVA7ngRge87
	lXmItIYK63+VQiiJaOGPHLCRPv21n2c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-kfhOam6CPliKK65O7dYukg-1; Thu,
 27 Feb 2025 10:36:39 -0500
X-MC-Unique: kfhOam6CPliKK65O7dYukg-1
X-Mimecast-MFC-AGG-ID: kfhOam6CPliKK65O7dYukg_1740670597
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 402FB1801A17;
	Thu, 27 Feb 2025 15:36:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4125E19560AB;
	Thu, 27 Feb 2025 15:36:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <da1d5d1a-b0ae-4a40-907d-386bd035954c@redhat.com>
References: <da1d5d1a-b0ae-4a40-907d-386bd035954c@redhat.com> <899dfc34-bff8-4f41-8c8c-b9aa457880df@redhat.com> <20250224234154.2014840-1-dhowells@redhat.com> <3151401.1740661831@warthog.procyon.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>,
    Christian Brauner <brauner@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Which tree to push afs + crypto + rxrpc spanning patches through?
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3158045.1740670591.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Feb 2025 15:36:31 +0000
Message-ID: <3158046.1740670591@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Paolo Abeni <pabeni@redhat.com> wrote:

> >> The remaining patches in this series touch only AFS, I'm unsure if ne=
t-next
> >> if the best target here???
> > =

> > Yeah.  It's tricky as the complete set of patches I would like to post=
 spans
> > three subsystems.
> =

> Possibly sharing a stable tree somewhere, and let the relevant subsystem
> pull the tree specific deps/bits could help?

The networking tree would still have to take the afs and crypto bits in or=
der
to take the rxrpc bits so that the code compiles.  Unfortunately, the rxrp=
c
bits depend on the other two.

If you're okay with the rxrpc bits not going through the networking tree a=
nd
if Herbert is okay with the krb5 library not going through the crypto tree=
, I
can try pushing the whole lot through the filesystem tree.

David


