Return-Path: <netdev+bounces-187424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBA7AA7139
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 14:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01061782B8
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 12:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB6723E34D;
	Fri,  2 May 2025 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ne6WrvAq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260ED22A7E2
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187632; cv=none; b=LU622ype7+BMhingVulx4rMGHGp0YIrGozBkLKw/A0DaxDnjWTNqJV3F6HSPWexlgWCLxn2LIzpuVDFpHDSttqg9ND1km7YtfK6E6RW+kg5munitGbNI81D6cHX0i2QryNJrVAeQXpzV2fSAe9z3iRQQZ5pZRvN/3RepVp0sW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187632; c=relaxed/simple;
	bh=kIgtsR0E40tENH6ISH0aV+gRosKq3D0NGUAeY0vwGfo=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=bdlkhrFDubT/F1Rs3HGOumKygD3x/vMdSPIT7zAVtl9lOhyCntd098C7uumMU8uHCGlCRCy3+Y324bhpRJ86UPX9qGInqD8gOKRAV0TvcJj1wGmUQiAvpmhRmlZrnlRCqvYrCCpZRxTA+nzX1RkEGZ77WyN3MESGEUdQld7/0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ne6WrvAq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746187628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lYlHXnRQJFK1D2h7mJBqszXkQeRxBGosQvo1Uia/g4M=;
	b=Ne6WrvAq7Fzj0t2MW7kQBmBDRcPdd12WBsXGj+1OSlnNU5g0/5gzs0dZEe6vfDMyjg7RuC
	gsvN9qr6Vlpx4+Ko5JTiHqRzs59rdUAx34/x0fadK0P8xMryum1WYTeB3uy1ew/x0S//Vr
	q9ju1oBFQkMqfzmAOMop5RW1y3lWXOU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-LpNYRDsCM2m5So0E8QJV6w-1; Fri,
 02 May 2025 08:07:05 -0400
X-MC-Unique: LpNYRDsCM2m5So0E8QJV6w-1
X-Mimecast-MFC-AGG-ID: LpNYRDsCM2m5So0E8QJV6w_1746187624
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F3F41800ECB;
	Fri,  2 May 2025 12:07:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8CB11800871;
	Fri,  2 May 2025 12:07:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>
cc: dhowells@redhat.com, willy@infradead.org, netdev@vger.kernel.org
Subject: How much is checksumming done in the kernel vs on the NIC?
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1015188.1746187621.1@warthog.procyon.org.uk>
Date: Fri, 02 May 2025 13:07:01 +0100
Message-ID: <1015189.1746187621@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Dave, Jakub,

I'm looking into making the sendmsg() code properly handle the 'DIO vs fork'
issue (where pages need pinning rather than refs taken) and also getting rid
of the taking of refs entirely as the page refcount is going to go away in the
relatively near future.

I'm wondering quite how to do the approach, and I was wondering if you have
any idea about the following:

 (1) How much do we need to do packet checksumming in the kernel these days
     rather than offloading it to the NIC?

 (2) How often do modern kernels encounter NICs that can only take a single
     {pointer,len} extent for any particular packet rather than a list of
     such?

Thanks,
David


