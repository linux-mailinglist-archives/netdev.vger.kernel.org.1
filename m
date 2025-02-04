Return-Path: <netdev+bounces-162453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0095A26F64
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D0C166FBB
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F2E20A5DC;
	Tue,  4 Feb 2025 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q00dKVIX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E106B207DEA
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665575; cv=none; b=CJKISsXJpBC5ltpdSAQLahX87UvNRw1EzsmEz1rx4LM+roFXjyEfsC3Lv5FmftkNR0btgiDrOOPDAxboe2tSjA2py4uhW7OxzQTpESNhxUgqlC7jDWJUtfvm9AM9s4Q7mKeMYIvhx2uWNfDdakDKrmuY+HpDqW0tz3r4fH4VeU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665575; c=relaxed/simple;
	bh=bIr9Yc0uqUIeHBf23T13j1uqyZmefpUaE6XGM6Onjjw=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=TQLFEiCbO13IlIPWxpZ9/NdxsyI5rWgnLPXYoDgCVeJTa5nl7J/1expAFLBSCFjGbAXbGN8Yc/k2IXFj+QMjnMm94F8mDc9968rYu5tTEjQ/M6jJVi3hPBQvf+2xGxK6DqN9XLkN2S68WxdUUUs/qjpjG0J5Zjq/aDqms7+aIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q00dKVIX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738665572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iryjKv+xVNCIwWrnKIDrLJIiIagMGEckd2S4eqLOxbE=;
	b=Q00dKVIXMuWXbABGtA2I67euUVzkWx5idO4aObfW03TVikyJW+K9qbYp1ZH0San5qBPo7K
	tlIKMgMvF7odtYRgV8R8tavy+pE0/eYQvSJRA0G2oafCUitJc8ONJoSDEfOCJWWEDRdUwA
	fBey7t2YFzxeI2VY14otA3WrkC+fioA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-6cGD9k6tNJKCI19fy3esiA-1; Tue,
 04 Feb 2025 05:39:29 -0500
X-MC-Unique: 6cGD9k6tNJKCI19fy3esiA-1
X-Mimecast-MFC-AGG-ID: 6cGD9k6tNJKCI19fy3esiA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0F01180035E;
	Tue,  4 Feb 2025 10:39:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 808EB19560AA;
	Tue,  4 Feb 2025 10:39:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250203110307.7265-2-dhowells@redhat.com>
References: <20250203110307.7265-2-dhowells@redhat.com> <20250203110307.7265-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net 1/2] rxrpc: Fix call state set to not include the SERVER_SECURING state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <529238.1738665563.1@warthog.procyon.org.uk>
Date: Tue, 04 Feb 2025 10:39:23 +0000
Message-ID: <529239.1738665563@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Patch 1 is broken and I've removed it from the system.  Patch 2 appears to be
okay.

David


