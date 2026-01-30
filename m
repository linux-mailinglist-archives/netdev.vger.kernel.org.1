Return-Path: <netdev+bounces-255118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YISwJFGUfGlPNwIAu9opvQ
	(envelope-from <netdev+bounces-255118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:21:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA22BA029
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4421300CC0F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD0730E844;
	Fri, 30 Jan 2026 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSj0g1Oc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C073382F4
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771917; cv=none; b=fSydjP8Jq5B97EVF2dJUEg9kM0Mtz+Ur13amGByz5s26wy783wDzTKtVoiFjG6Rgl1WXTTswWQ1qMLmoxWMNecBT1/Fd8W8z0kdE//JVbhMy7XFtMAf2lRXk2YFTAzmNUlFy92nv3rIvv8vqEoqUHFhtacOsWL5fcPh6bPjBIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771917; c=relaxed/simple;
	bh=vNx8nb+oVCRtHhU7VK+zKr7FcdtttqBanbffG81q9Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npsDxN8QIqO4ZdvxEVsZjmAS7k3X0jWX4XSzUTBvhcEBCMPwuzZVEJVnrulQPqOcCv+QZ3Ze04PTVUgGE5XZjwuvySilZoBAr2MSfqVltmraownHu/5vSS0vaRNl4JtVWX9b2pgZvqJz9HTPd+MvcpEwtQvxu9mxgm32s/JJG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSj0g1Oc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769771914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4tg8ulq7nPHZ4usQOb+sYA13ZR+J9T9Pn2vliZqr8Nc=;
	b=XSj0g1OcTXEM7/O83arZeGgcKKWY3k6aR74hRAIVTR6+M+f7v/OeCPkdLmaniiUGrG5ZtD
	WnCtB4Y6m8G3+MboUB4YfMzlVdCkulzniuyGnsD4nJp0INt7/E2duU8oNtxaJ8ei+Kth01
	2v7EA8Ml1r5DYiGUk6f4eO3vGwsBpiM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-ZoYpVqGqO0O7DomLUODz8g-1; Fri,
 30 Jan 2026 06:18:31 -0500
X-MC-Unique: ZoYpVqGqO0O7DomLUODz8g-1
X-Mimecast-MFC-AGG-ID: ZoYpVqGqO0O7DomLUODz8g_1769771909
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D3491954B0C;
	Fri, 30 Jan 2026 11:18:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.204])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35AC418007D2;
	Fri, 30 Jan 2026 11:18:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/2] net: gro: fix outer network offset
Date: Fri, 30 Jan 2026 12:17:45 +0100
Message-ID: <cover.1769771825.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255118-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFA22BA029
X-Rspamd-Action: no action

The GRO stage has still problems in some edge scenarios when dealing
with encapsulated traffic: the first patch address an issue there
leading to bad checksums.

The second patch introduces a test case covering the relevant scenario:
S/W segmentation after GRO for encapsulated traffic.

Paolo Abeni (2):
  net: gro: fix outer network offset
  selftest: net: add a test-case for encap segmentation after GRO

 net/core/gro.c                            |  2 +
 tools/testing/selftests/net/udpgro_fwd.sh | 65 +++++++++++++++++++++++
 2 files changed, 67 insertions(+)

-- 
2.52.0


