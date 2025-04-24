Return-Path: <netdev+bounces-185686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D69CA9B5F5
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12B61BA04AF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A849D1FC0EA;
	Thu, 24 Apr 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNApvPhf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8FD28BA85
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518025; cv=none; b=JYIdjgaH/S29Jct+xZO4jmV305/3L5RzFLKHuHvx6Xf+0rby+jhyhd058biQTYeYOKZQY28nxly2sRVfXgxmv/GYSoVh7Cku2RyXlsQe4Ao26ObjPXYi5u7QIhphIkuNcIIYqop+6vlCgAeettafd6St49Mdz5z/HnMOTAtFTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518025; c=relaxed/simple;
	bh=ta5uwZDYWisxxM12KjjF1QgxHL63HaMu0WevHhYe1ZQ=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=kxwsPZLiGxo/lY/IZz9kYtpXtrZmETqu7XsMI9+OxVp8w5IzzAi9Md+4l4NoGdFDc8/ljOveH/59+ekfG9gn2/m1WrI8AezYLVDblHgJE2KK65Eloe14RFgOuE0n+cCH8FR8MxUo7wmANj4RPxBozq95YFcv3QfFIFm+Ha/4Atk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNApvPhf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745518022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5+vSqsQhIhaN4+ReXmp4a/18RE4upAKYHd+YtcarN9I=;
	b=GNApvPhfPL2w+c54bxephNJq/gDm98Sg/qT4h8RiaXAJFMalOEAr+e82/aKSdK1Ib4Hg2F
	H0UGacwhl4fAD0s7GlaIqkEreeXqck1ibT84se0KTI2dck4WadOH+hwPO/x0V3EzCI7UAa
	/Ubuumu4uFO6CXs3pHr2tC6DzLRF9YQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-8IGoqjXZN3CLvNUkuKphkQ-1; Thu,
 24 Apr 2025 14:07:00 -0400
X-MC-Unique: 8IGoqjXZN3CLvNUkuKphkQ-1
X-Mimecast-MFC-AGG-ID: 8IGoqjXZN3CLvNUkuKphkQ_1745518019
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBB3F19560A1;
	Thu, 24 Apr 2025 18:06:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A675180045C;
	Thu, 24 Apr 2025 18:06:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
cc: dhowells@redhat.com, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
    Tony Nguyen <anthony.l.nguyen@intel.com>,
    Paulo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Is it possible to undo the ixgbe device name change?
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3452223.1745518016.1@warthog.procyon.org.uk>
Date: Thu, 24 Apr 2025 19:06:56 +0100
Message-ID: <3452224.1745518016@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

[resent with mailing list addresses fixes]

Hi,

With commit:

	a0285236ab93fdfdd1008afaa04561d142d6c276
	ixgbe: add initial devlink support

the name of the device that I see on my 10G ethernet card changes from enp1s0
to enp1s0np0.

This is a bit of a problem for my test box because I have Network Manager set
up static configuration for that enp1s0... which no longer exists when that
commit is applied.  I could change to enp1s0np0, but then this would no longer
exist if I want to test a kernel that doesn't have that commit applied.

If the name doesn't exist, booting pauses for about a minute while NM tries to
find it (probably a NM bug), so adding both names isn't an option either :-/

(I don't use DHCP for this adapter as it's directly wired to another test box)

Alternatively, as a compromise, might it be possible to omit the "np0" bit if
the adapter only has one port?

Thanks,
David


