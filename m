Return-Path: <netdev+bounces-276455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONatAps/1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:44:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E503BB6A8
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0794F3008D35
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6846388E50;
	Wed,  8 Apr 2026 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA1SwWfQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4633C52F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648661; cv=none; b=Q5yTfnAMWmwnbTArkxTm4Ioimy6qNxLnCG22zfWqTr9/qrjIbfq7h1MLruoFG7nAe3vxm85EcEjFZf2Ku56HjBmmP+DfrlGBp9G5MazukYL+/uaAE/XPNpUTBpJnq7hMOfXH8klCAt8+O9Fk9t5LoGyXUaAZdv5nTw8CpXqTAmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648661; c=relaxed/simple;
	bh=96QVc9ez6sUktzhyn8r9BvhD+HZJ6Z9rVtVSutQCrEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzpJGkrwyO61X0iHS/kZyE/F+cMuMJE2bHwW2/7qN9tEGkVGBeoViP134GwGaCkkHG+DFEgOkUNkVO+v8Uy2PqtzU+gu2gQErWCAMkUBs4e73D7DKNBFd8TZMC51Vu56ZOQCoppZJtey4X/gPivRMSWVFIfNwuzja5sb1NYO40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZA1SwWfQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775648659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=apvxNvFh6zczRf/Be5XiSSGrUuihP4EaQpIATgjjTDg=;
	b=ZA1SwWfQ9W7Kekr63q9S9y6Uw31xSk0oa1M7Issj0wGAvul13NASgxWqWnJEZad0MqH+5i
	QG0IO4T0q8dFuZDLSui7EL5LgbJblX7Un50O7054B/3yWnYlxweH5NZSqDi65yj/jtVMg5
	5CzMI/E8HBa+RqdoqvYpSp9AjMcUblQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-IOHacHi5N5KJHQgR41Yfdg-1; Wed,
 08 Apr 2026 07:44:13 -0400
X-MC-Unique: IOHacHi5N5KJHQgR41Yfdg-1
X-Mimecast-MFC-AGG-ID: IOHacHi5N5KJHQgR41Yfdg_1775648651
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3F5D18005B3;
	Wed,  8 Apr 2026 11:44:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.173])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AD8C1800361;
	Wed,  8 Apr 2026 11:44:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org
Subject: [PATCH iwl-next 0/2] i40e: implement per-queue stats
Date: Wed,  8 Apr 2026 13:43:44 +0200
Message-ID: <cover.1775648513.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276455-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2E503BB6A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The i40e driver already collects some per queue statistics, but does
not expose them to the user-space using the standard interface.

Implement the stat_ops callbacks and extends the already collected info
with basic GSO counters. Overall this allows passing the kernel NIC
drivers TSO test cases.

Paolo Abeni (2):
  i40e: implement basic per-queue stats
  i40e: keep track of per queue gso counters.

 drivers/net/ethernet/intel/i40e/i40e.h        |   9 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 144 ++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   2 +
 .../ethernet/intel/i40e/i40e_txrx_common.h    |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   2 +-
 6 files changed, 168 insertions(+), 3 deletions(-)

-- 
2.53.0


