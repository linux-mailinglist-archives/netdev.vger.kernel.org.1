Return-Path: <netdev+bounces-256400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGWUKJw0gmlTQgMAu9opvQ
	(envelope-from <netdev+bounces-256400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:47:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F23DD0DD
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F815316E8E8
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC22194C96;
	Tue,  3 Feb 2026 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCPknCbp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F833A9FF
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140452; cv=none; b=l8M/gFDTWNJKMZHgcGNZKJItOhMtW6FEms/NZv1z9OnTsaWLH03r0bJVMyP17qrdUgcR4ht/BQs2xmB2weEhANPKRIrMq6FHeUoTU1escuItk5Hy54adseq+6YiTq0UggfAp6XLsYSp/W7H7jx6qBze2fae94jjMNyABZwgvUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140452; c=relaxed/simple;
	bh=tZTZrazsnU5+1P1Le5tSCa3vKdTxBVzBdTbfHHlKL0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUFILlTsI2Rnf6FwMbv8QDkPjuISFKr4vtl6iSyI6UKdZhATRpHvnL68VPv52rzkRO6i0m+CSquZGBF920zrFbc+FKrAu7fbEg9MdxVTGI2Dgzip45gsuj/iW+B97lMI5nGNHBJQbWWUf2YhzqwqKiAVz4Y+gN5au2a6CwNmDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCPknCbp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770140450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBmYOQu1HbXXIGYjKiGL7F/z2NmzMJqt9ZutoxF0liM=;
	b=FCPknCbpHXsPJZg8mivkgtu7bZC3tsUeP5zXogAelX4MifNQ4Z/QdZylP28AMKJL5q4VoZ
	JwWLDZpXr+Symdy1bIPGSJcQ6/0qaJAidbApw4/T+c747MnQQ6NKMVPd4uoE6I7S6b15pn
	fe+wQ0+vjO0PIZu79gAOR/T6hLLk/zM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-9U3qrlHUM5qeUpQnKAN7Cg-1; Tue,
 03 Feb 2026 12:40:46 -0500
X-MC-Unique: 9U3qrlHUM5qeUpQnKAN7Cg-1
X-Mimecast-MFC-AGG-ID: 9U3qrlHUM5qeUpQnKAN7Cg_1770140443
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5144B19560A1;
	Tue,  3 Feb 2026 17:40:43 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A61C30001A7;
	Tue,  3 Feb 2026 17:40:37 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 5/9] dpll: zl3073x: Add support for mux pin type
Date: Tue,  3 Feb 2026 18:39:58 +0100
Message-ID: <20260203174002.705176-6-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-1-ivecera@redhat.com>
References: <20260203174002.705176-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256400-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46F23DD0DD
X-Rspamd-Action: no action

Add parsing for the "mux" string in the 'connection-type' pin property
mapping it to DPLL_PIN_TYPE_MUX.

Recognizing this type in the driver allows these pins to be taken as
parent pins for pin-on-pin pins coming from different modules (e.g.
network drivers).

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/prop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index 4ed153087570b..ad1f099cbe2b5 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -249,6 +249,8 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 			props->dpll_props.type = DPLL_PIN_TYPE_INT_OSCILLATOR;
 		else if (!strcmp(type, "synce"))
 			props->dpll_props.type = DPLL_PIN_TYPE_SYNCE_ETH_PORT;
+		else if (!strcmp(type, "mux"))
+			props->dpll_props.type = DPLL_PIN_TYPE_MUX;
 		else
 			dev_warn(zldev->dev,
 				 "Unknown or unsupported pin type '%s'\n",
-- 
2.52.0


