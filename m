Return-Path: <netdev+bounces-255880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKxcAwyzgGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 15:22:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1425CD457
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 15:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AB813003702
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C644136D516;
	Mon,  2 Feb 2026 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDx0u0Mt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E71836C5B5
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042065; cv=none; b=cHlwKv4TGYCwtN5y6cvLIMwncWSCvhytyBpLW3vbJCpE/Z9yzaAr3R9+64SdXGn4G32Lr7U3WTVo5WL4CrXa7vzugyEk6r4e1AzwHFUOaQ7csUWx65mvdqKQeOK8zKJWggdKPrtx82SMv0ZDj0fJzQ+I1MXy2f39dZiok0awfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042065; c=relaxed/simple;
	bh=8gO7528RUzkj9wu5Go/PvbCOEjLCeSXEx8yiDRNM9ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/jVOl2sqVfqf6YNoTYrlhNC4Pldxn+cogzuoo9Si0EqI4cTtj3sT+w/whLneKHEm/W6z0bsdQ7olmXuaGGqwtBS0jkpE0X7coiTZ5cad7R6LdE1C8O79hKRT7nKe41w53I/NwH5nVJfLR1wQS2N62b4QehFGIncQqmDci5qd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDx0u0Mt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770042063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUjfsNXbYtv1aL5ENWAmxX+YM/BhggZrRjlSYm8SL4M=;
	b=FDx0u0MtiBacSfEydEvd1f3QiJPEaZ5XrLvrInd/pHUSe6u6BqgZ3sUt0nl2nugebEop03
	W70cyA6EEpLmBaZDIcnIehsg2NiAFZ9+aJZaeVBoL39RvAXjW8NpIzfeaDYTs0MEBia3aE
	eXnSRSdtBDY0+eCI6/AYybNPyau0H5s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-KVBoOB9YNkOi2jAS-5MuRw-1; Mon,
 02 Feb 2026 09:20:59 -0500
X-MC-Unique: KVBoOB9YNkOi2jAS-5MuRw-1
X-Mimecast-MFC-AGG-ID: KVBoOB9YNkOi2jAS-5MuRw_1770042058
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3C671956054;
	Mon,  2 Feb 2026 14:20:57 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.34.1])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45C931800577;
	Mon,  2 Feb 2026 14:20:54 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@kernel.org,
	mingo@kernel.org,
	bigeasy@linutronix.de,
	matttbe@kernel.org,
	allison.henderson@oracle.com,
	petrm@nvidia.com,
	antonio@openvpn.net
Subject: [PATCH net-next v3 8/8] MAINTAINERS: Assign hsr selftests to HSR
Date: Mon,  2 Feb 2026 15:19:24 +0100
Message-ID: <d75f1cdf860f032b84673a1eae564c01e486d55c.1770041682.git.fmaurer@redhat.com>
In-Reply-To: <cover.1770041682.git.fmaurer@redhat.com>
References: <cover.1770041682.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	TAGGED_FROM(0.00)[bounces-255880-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:email,protonic.nl:email]
X-Rspamd-Queue-Id: C1425CD457
X-Rspamd-Action: no action

Despite the HSR subsystem being orphaned at the moment due to the original
maintainer being unreachable for a while, assign the selftests to the
subsystem for the future.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0caa8aee5840..d50ed2f88ff7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11586,6 +11586,7 @@ HSR NETWORK PROTOCOL
 L:	netdev@vger.kernel.org
 S:	Orphan
 F:	net/hsr/
+F:	tools/testing/selftests/net/hsr/
 
 HT16K33 LED CONTROLLER DRIVER
 M:	Robin van der Gracht <robin@protonic.nl>
-- 
2.52.0


