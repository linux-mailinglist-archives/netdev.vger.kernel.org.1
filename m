Return-Path: <netdev+bounces-185937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2888A9C2A5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D131BC0025
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEFE242D9C;
	Fri, 25 Apr 2025 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjuSTlmI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9822E3E1
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571527; cv=none; b=buD3VNPj5BZwRWlGqDLVU8qtGbNFsUo+kvCwHWkjFfvIg2YzimnIzuGvK/YRcXr3Jgkn8RMoh1yxF/SK9UbCcYLF5Y2tzVfnfZTKb5m2xOuSMk3JyIadczvRBtIcVSDmIQy5n1vsjPe1O+KVWMMPsinV+7GUGQtHV6Tle9WQDHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571527; c=relaxed/simple;
	bh=rA0FgN8pKr6Y+NMKb7Up7vf6L8C8r8fkDH4Qrelpoao=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=DdHJ7Ox9fff/2qfSQgvfj7cPpGZkWcXwVLD0HSSgODcyI0D7aVdGQcfN32x9tgElzvl9994n+U8FNYmLDc0hU1oluKV/DC9XtLabi136F8zkKwocA9hOa9AsiiocyX7xSBkwB2GATbt1QCuZaZJtxAy0HWTYgzDuCPKotaDcEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjuSTlmI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745571523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZ2kjqGAthECdwPjzkMV1yv0jKsDaNgqhNAIusvfh0s=;
	b=EjuSTlmIrXoA65uryUdGJDA8NLREqOTpS4BW/ar1LLhb9kY1omPligxKvuxP6z9/JLdKMB
	GH2cfJxfJUOuwIv/3B9U2Kiy7WadOUK2DBpCyvSNWBppnLZS657un4W/6C/kSiGsnb+D/e
	GXD1cBv2Go3xk91hc6bgXP/SYcssO/w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-TIg2eD5LMlCc0rc8n9kbZw-1; Fri,
 25 Apr 2025 04:58:40 -0400
X-MC-Unique: TIg2eD5LMlCc0rc8n9kbZw-1
X-Mimecast-MFC-AGG-ID: TIg2eD5LMlCc0rc8n9kbZw_1745571519
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9C4219560A0;
	Fri, 25 Apr 2025 08:58:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB24818001DA;
	Fri, 25 Apr 2025 08:58:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <7b468f16-f648-4432-aa59-927d37a411a7@lunn.ch>
References: <7b468f16-f648-4432-aa59-927d37a411a7@lunn.ch> <3452224.1745518016@warthog.procyon.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: dhowells@redhat.com, Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
    Przemek Kitszel <przemyslaw.kitszel@intel.com>,
    Tony Nguyen <anthony.l.nguyen@intel.com>,
    Paulo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: Is it possible to undo the ixgbe device name change?
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3531592.1745571515.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Apr 2025 09:58:35 +0100
Message-ID: <3531595.1745571515@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Andrew Lunn <andrew@lunn.ch> wrote:

> Are you sure this patch is directly responsible? Looking at the patch

I bisected it to that commit.  Userspace didn't change.

> Notice the context, not the change. The interface is being called
> eth%d, which is normal. The kernel will replace the %d with a unique
> number. So the kernel will call it eth42 or something. You should see
> this in dmesg.

Something like this?

... systemd-udevd[2215]: link_config: autonegotiation is unset or enabled,=
 the speed and duplex are not writable.
... kernel: ixgbe 0000:01:00.0 enp1s0: renamed from eth0

or:

... systemd-udevd[2568]: link_config: autonegotiation is unset or enabled,=
 the speed and duplex are not writable.
... kernel: ixgbe 0000:01:00.0 enp1s0np0: renamed from eth0

I presume the kernel message saying that the renaming happened is triggere=
d by
systemd-udevd?

David


