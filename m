Return-Path: <netdev+bounces-306667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 67fLFuFGUWr2BgMAu9opvQ
	(envelope-from <netdev+bounces-306667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:24:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1473DB88
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:24:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DCQIAD7c;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306667-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306667-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC852301822C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1503876D6;
	Fri, 10 Jul 2026 19:22:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61A383C6B
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:22:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711375; cv=none; b=cS3UJ/BzB1FRTEKnF9k7K3W5JTsikwHyL0kYLJqDUKx4KycqtxqRDlkEPJStDeMEgvgDrDBSXbgIJL9DQ3TaRVl0CHIChrWNMl/SvHhfRU+wphG77hJ7pxxmf2ydCD0Lbtz/2jiP1RZQnR6BFrkYjycgbdS8Mh6cdqtqgKP3Zt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711375; c=relaxed/simple;
	bh=Y0e4LMYcGWBIC2Fiar+YM5QEQ18z1tw1hUk+Gbjj1Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGEfpb/gQMB5TxcCsYSX1coQFjoC+CXhKkm2Io85Z5OJ/Jpo7Mewb8QWjr0RPgVS17niWf6jxm4p0r+kU8RD7slIrV9s997sO/YXZ7zjJUA0Gju/bE/AZBHzHYpnnYSAAiRAsnh0USCMDUQEl0mMKga9M0TEh459BpRHw/qPrO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCQIAD7c; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD5tbgQuNoEFcDdB8RstSE+j32aBC6LqDMVcfCgYO5w=;
	b=DCQIAD7cgcRzg+mRWaD9X19I5vi4UxVCuPCbyjPVvnCdFiyGVI8dRN2Vcuo5l9NfpXBkEf
	rvAozWyIOXJdnk9MSmbZ6+QX0QCKz9VfSiXjFZfkMOQpbeuz0l1akNcIJU2zsF/HcKIjRn
	GXsH/KIikmQhUB8eXjY+0oP976cqsDo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-NoeVyrNWM8O-g7dBpQ7M5A-1; Fri,
 10 Jul 2026 15:22:49 -0400
X-MC-Unique: NoeVyrNWM8O-g7dBpQ7M5A-1
X-Mimecast-MFC-AGG-ID: NoeVyrNWM8O-g7dBpQ7M5A_1783711368
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A2521956059;
	Fri, 10 Jul 2026 19:22:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACEC01800661;
	Fri, 10 Jul 2026 19:22:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH net v2 04/16] afs: Fix two delivery functions to pass back -EAGAIN
Date: Fri, 10 Jul 2026 20:22:06 +0100
Message-ID: <20260710192220.1922433-5-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306667-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,auristor.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,davemloft.net:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DF1473DB88

Fix afs_deliver_cb_init_call_back_state3() and afs_deliver_cb_probe_uuid()
to pass back -EAGAIN when returned afs_extract_data() as that indicates
that more data is needed.

Fixes: d001648ec7cf ("rxrpc: Don't expose skbs to in-kernel users [ver #2]")
Fixes: 9396d496d745 ("afs: support the CB.ProbeUuid RPC op")
Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/cmservice.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index d579a665e3da..3c12a0ecee8e 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -332,11 +332,8 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 	case 1:
 		_debug("extract UUID");
 		ret = afs_extract_data(call, false);
-		switch (ret) {
-		case 0:		break;
-		case -EAGAIN:	return 0;
-		default:	return ret;
-		}
+		if (ret < 0)
+			return ret;
 
 		_debug("unmarshall UUID");
 		call->request = kmalloc_obj(struct afs_uuid);
@@ -450,11 +447,8 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 	case 1:
 		_debug("extract UUID");
 		ret = afs_extract_data(call, false);
-		switch (ret) {
-		case 0:		break;
-		case -EAGAIN:	return 0;
-		default:	return ret;
-		}
+		if (ret < 0)
+			return ret;
 
 		_debug("unmarshall UUID");
 		call->request = kmalloc_obj(struct afs_uuid);


