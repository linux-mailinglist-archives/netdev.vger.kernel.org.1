Return-Path: <netdev+bounces-263309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKLbOLAMp2kDcgAAu9opvQ
	(envelope-from <netdev+bounces-263309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:30:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 745121F3D06
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53EB1319A287
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20F54E3784;
	Tue,  3 Mar 2026 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm9fJ8t3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887B4DBD6D
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555035; cv=none; b=Ccg1VzulKcK0JXiBrGAkBUuHgY1gQEa1dgyaJCSbYjV1Tod9f0AeafbKNsu3Swh1eKNEQ2iv++MPfU8/T/A7Lduon9TkUkUgYNQhN4ZT0ShGngnWyKUXsT6jxiezF3IQhKdd3Wnn/iBRd2ixK/Xdk/XqaTxsVDIV6tPOpB6+gBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555035; c=relaxed/simple;
	bh=0Mad6XA1ZznQcSRHUz3PpH3lPRdMURQoYVbNPkSJ6Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYW90x9cql8XcnGa71TCjwSQY/VrPsnE2UkCCvdv4BuVDSBdKkDxZzmTHn/FwkUf8USzxz9ajUEDXVNIttbuOll2kFCVMH9Xx7Nji5d0NOmTk6MG5ra0jbaJ/DwB61fb0tZ+IpqD8NmNhqh5nc/H0yebGKWc704yg2f7tQxssgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm9fJ8t3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB83C2BCAF;
	Tue,  3 Mar 2026 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555034;
	bh=0Mad6XA1ZznQcSRHUz3PpH3lPRdMURQoYVbNPkSJ6Mo=;
	h=From:To:Cc:Subject:Date:From;
	b=dm9fJ8t3T4RLAQDOo/gOheTk9JuWFxDTsTXuvtPJAzsHqDFiD8Hhhh7/bUGLslLer
	 1L/oeRhLGWXzU/Mbn+vMs8iA0ukvubNgXe6fAzhA8s5/SKNm+ezYC1S4AVnpzizqdN
	 lY4RrUfeAvuh34WVCS+IE4Zs47yPLh7eoT38tNc8fXNTVYxYhLL3pGtO6F81iZZWgp
	 Q9Vj+GN3FkHlYpQ8chSgd6onn82vkU08OV2sBs05JXaFCh8HioJx0DGKsbiN7ijEly
	 XbXKnwf4efkClGhoWohwwQlWLvh1NmkOrEPyq9R2ilLSSzMhYrrQmsKiN6optcmtEG
	 4Mf4pRvRz2MDQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/5] nfc: fix leaks and races surfaced by NIPA
Date: Tue,  3 Mar 2026 08:23:40 -0800
Message-ID: <20260303162346.2071888-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 745121F3D06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263309-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

I recently added the nci test to NIPA. Somewhat surprisingly it runs
without much settup but hits kmemleaks fairly often. Fix a handful of
issues to make the test pass in a stable way.

Jakub Kicinski (5):
  nfc: nci: free skb on nci_transceive early error paths
  nfc: digital: free skb on digital_in_send error paths
  nfc: nci: complete pending data exchange on device close
  nfc: nci: clear NCI_DATA_EXCHANGE before calling completion callback
  nfc: rawsock: cancel tx_work before socket teardown

 net/nfc/digital_core.c |  8 ++++++--
 net/nfc/nci/core.c     | 18 ++++++++++++++++--
 net/nfc/nci/data.c     | 12 ++++++++----
 net/nfc/rawsock.c      | 11 +++++++++++
 4 files changed, 41 insertions(+), 8 deletions(-)

-- 
2.53.0


