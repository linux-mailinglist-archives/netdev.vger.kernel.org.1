Return-Path: <netdev+bounces-255847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPyKAoSOgGkl+wIAu9opvQ
	(envelope-from <netdev+bounces-255847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:46:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE0CBE2D
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 12:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E874430022CE
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F48364037;
	Mon,  2 Feb 2026 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfAdtyD2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945C735EDC9
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032769; cv=none; b=nTwarWhLiqPnM7qeDf+fwhlbH42WxbxZbn+xanijhVMObSKZpngHJvySpbFojypc8vQMiUXjR4qezzrUJtsopzWxUIJYCUqj5IHAEnqqyeiVBiY4+6Xnf7INevENW6tSMkmuDGU/O8U5O3rVuO9uwLeYmvabz6iNu5xh7srFa/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032769; c=relaxed/simple;
	bh=3hNBtBGDkQPJWapZDKQ/bB2f1GQppgKQ2llQ4Eq+yIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqTE/9Io2Iw3nu259lzxAbuagcV5vICsMzIdtzXX6MOQeyaivrJvS5rqqtsdEjvErUMMIPNd2+0kkyZ6dRBN3yJ+tnXMuesyRlzHyATeBXBaIy9yNH1ruAUsC7QvovjqPYTyoWVHFMO8hXEewjPKMlnk73MyDUE3wLqSmG+wAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfAdtyD2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770032767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0m2WNskmehLOpzG2Tsn8qxJQ9fl2058+6Lxdh3ceV8s=;
	b=AfAdtyD2+KYfBhl940djlJa3tFGP+OCTrEuxb2U8+ecphNKof8m/y/CHtuLP/Pt0W6jubD
	74irPaZ5TMbNS7fcijfnE5Fgck4xEdW4MDsoeIch/1cEP+nR/IbTCSZFANmRr69A+YKYq+
	QKA0TTbBeinSU76E/ZmUpAYK1rtaa4E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-n2Vt-5pGNTSAQUG7d_9Bhw-1; Mon,
 02 Feb 2026 06:43:37 -0500
X-MC-Unique: n2Vt-5pGNTSAQUG7d_9Bhw-1
X-Mimecast-MFC-AGG-ID: n2Vt-5pGNTSAQUG7d_9Bhw_1770032615
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1386E180045C;
	Mon,  2 Feb 2026 11:43:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.250])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C28BE1956056;
	Mon,  2 Feb 2026 11:43:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	linux-kselftest@vger.kernel.org,
	aleksander.lobakin@intel.com
Subject: [PATCH v2 net 0/2] net: gro: fix outer network offset
Date: Mon,  2 Feb 2026 12:43:13 +0100
Message-ID: <cover.1770032084.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255847-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0AE0CBE2D
X-Rspamd-Action: no action

The GRO stage has still problems in some edge scenarios when dealing
with encapsulated traffic: the first patch address an issue there
leading to bad checksums.

The second patch introduces a test case covering the relevant scenario:
S/W segmentation after GRO for encapsulated traffic.

v1 -> v2:
  - fixed typos in patch 2/2

Paolo Abeni (2):
  net: gro: fix outer network offset
  selftest: net: add a test-case for encap segmentation after GRO

 net/core/gro.c                            |  2 +
 tools/testing/selftests/net/udpgro_fwd.sh | 64 +++++++++++++++++++++++
 2 files changed, 66 insertions(+)

-- 
2.52.0


