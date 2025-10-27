Return-Path: <netdev+bounces-233192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9380C0E2DE
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAC118874B2
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7330506B;
	Mon, 27 Oct 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goZ0Z5y1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D225B30D
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573201; cv=none; b=HBYzgeWcuGkYxtzucSEb3nSUuhY/qc4EwvubkaVWOy4EQp+rYyvAVVP0SWvy24A5Rxzjn+dYzySOuff16CI1QgHQvMB/6nykn7q/vwmGh011Q0JbTywX4TCj3MPxI87Gpub/U245McSh720Ti6w8TFahC6DVqSIHSjk8lNr4H+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573201; c=relaxed/simple;
	bh=mznCAq1bAPkFzATnT1YJVKibc88cDROi+veP4/o+ihs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeU1eVENc9Gvbx0tqCz2q/j2SoV7YNoaqLdQhmBvVEm9Eilly+2XQPoN2gcebTQ8jR2ZffPBel/L17PTpTriw9CVPUBltPGMqohKFVEGxZMCF2NuP52enol0QP2hTH/Lxo4TQLYn0kCd6IV+YYz3du8mWEb5s6DmfZZBhrn9qfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goZ0Z5y1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761573198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e6T3LsArfWAbeCwhCC6O0tQsJ9usGBnZPiP8w5oHA1o=;
	b=goZ0Z5y1YPPBuCbnk+mOnkuk5esjQQacIXhqCFU40pSHASrrBNhucmcGV+Pnxdc6BFvJfN
	QPQMvuy2JlTakDBALJFZdB41pYAzl+C4RvVkzAuagKmDptnJEfCw7MryiDSVtH+vfnFcgN
	jEhEc2vF8H6zAJFf0IEzzCola7xcG24=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-YZgvVIX_N6SkYiBMeoPNdQ-1; Mon,
 27 Oct 2025 09:53:17 -0400
X-MC-Unique: YZgvVIX_N6SkYiBMeoPNdQ-1
X-Mimecast-MFC-AGG-ID: YZgvVIX_N6SkYiBMeoPNdQ_1761573196
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CF93195608A;
	Mon, 27 Oct 2025 13:53:16 +0000 (UTC)
Received: from fedora (unknown [10.44.32.108])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE3721955F1B;
	Mon, 27 Oct 2025 13:53:13 +0000 (UTC)
From: Jan Vaclav <jvaclav@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	Jan Vaclav <jvaclav@redhat.com>
Subject: [PATCH iproute2-next] iplink: hsr: add protocol version to print_opt output
Date: Mon, 27 Oct 2025 14:52:06 +0100
Message-ID: <20251027135205.3523660-2-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Since this attribute is now exposed by kernel in net-next[1],
let's also add it here, so that it can be inspected from
userspace.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=16a2206354d1

Signed-off-by: Jan Vaclav <jvaclav@redhat.com>
---
 ip/iplink_hsr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ip/iplink_hsr.c b/ip/iplink_hsr.c
index 42adb430..d79a4a40 100644
--- a/ip/iplink_hsr.c
+++ b/ip/iplink_hsr.c
@@ -165,6 +165,9 @@ static void hsr_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_HSR_PROTOCOL])
 		print_hhu(PRINT_ANY, "proto", "proto %hhu ",
 			  rta_getattr_u8(tb[IFLA_HSR_PROTOCOL]));
+	if (tb[IFLA_HSR_VERSION])
+		print_hhu(PRINT_ANY, "version", "version %hhu ",
+			  rta_getattr_u8(tb[IFLA_HSR_VERSION]));
 }
 
 static void hsr_print_help(struct link_util *lu, int argc, char **argv,
-- 
2.51.0


