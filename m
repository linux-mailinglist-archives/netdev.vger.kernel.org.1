Return-Path: <netdev+bounces-232550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5E5C067B4
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C47754F0B23
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2729631D389;
	Fri, 24 Oct 2025 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQS0ub4B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7231CA5B
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312334; cv=none; b=G9IFL6SzomjhDlU2aTc98fWu+GZyWrtxso8huMTu9cTMyjPp9s4JfnYVBErSqmeLbh/gojtlHyLQvqk0zUz7eYKN0k149j2jibO6ChSqGnbmemEjAcTX2r7J18GI2OBh62jQUgylujbZ6oe0kiBG2wAk9Eh4aTAqx4Q6k7RX5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312334; c=relaxed/simple;
	bh=mBf4mnaGcfALj0V00XU63ToI/IMNO7pa5UlytqOLXb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/I+wl7zX+50RKQqGd5vQoLQN7guxpKU86iBtnuKe0jBR4vJTHMcmPEVtYGKU3nQfoVfLf4UwXk+pp9OChzQn7aqJc6YoTgGigW6i1iLOeFgswl/eRO14fFQUw8Q2Izu83SpD7RjzjOmWyLv9hY4bLxaHteKHsfcB3CKBAtJlzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQS0ub4B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761312331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FlzBCflH9SvRTtMrOksDcMHlWo7c8Sb/jjoLNT1rHCc=;
	b=dQS0ub4B/HAo6PwHNezwkL4yokQBC39hob4xuS51ssCnvj14uzFqOrwbUmk6cngp8JhHgz
	FO3zc1ohjg0oK+pFqeFb51KGPJ8EFxc0zGkffQQxpYJkhFU0qWPxfL85i9nCF0hbl71xeT
	u5+uaw7vwFoWEHuKKdsFBe3bMScGKBY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-P4oJxubeOzaD9znGgDpfeQ-1; Fri,
 24 Oct 2025 09:25:28 -0400
X-MC-Unique: P4oJxubeOzaD9znGgDpfeQ-1
X-Mimecast-MFC-AGG-ID: P4oJxubeOzaD9znGgDpfeQ_1761312326
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61F2519560B4;
	Fri, 24 Oct 2025 13:25:26 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.33.192])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C2CC19540EB;
	Fri, 24 Oct 2025 13:25:22 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Petr Oros <poros@redhat.com>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Cc: ivecera@redhat.com,
	mschmidt@redhat.com
Subject: [PATCH net] tools: ynl: fix string attribute length to include null terminator
Date: Fri, 24 Oct 2025 15:24:38 +0200
Message-ID: <20251024132438.351290-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The ynl_attr_put_str() function was not including the null terminator
in the attribute length calculation. This caused kernel to reject
CTRL_CMD_GETFAMILY requests with EINVAL:
"Attribute failed policy validation".

For a 4-character family name like "dpll":
- Sent: nla_len=8 (4 byte header + 4 byte string without null)
- Expected: nla_len=9 (4 byte header + 5 byte string with null)

The bug was introduced in commit 15d2540e0d62 ("tools: ynl: check for
overflow of constructed messages") when refactoring from stpcpy() to
strlen(). The original code correctly included the null terminator:

  end = stpcpy(ynl_attr_data(attr), str);
  attr->nla_len = NLA_HDRLEN + NLA_ALIGN(end -
                                (char *)ynl_attr_data(attr));

Since stpcpy() returns a pointer past the null terminator, the length
included it. The refactored version using strlen() omitted the +1.

The fix also removes NLA_ALIGN() from nla_len calculation, since
nla_len should contain actual attribute length, not aligned length.
Alignment is only for calculating next attribute position. This makes
the code consistent with ynl_attr_put().

CTRL_ATTR_FAMILY_NAME uses NLA_NUL_STRING policy which requires
null terminator. Kernel validates with memchr() and rejects if not
found.

Fixes: 15d2540e0d62 ("tools: ynl: check for overflow of constructed messages")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 tools/net/ynl/lib/ynl-priv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 29481989ea7662..ced7dce44efb43 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -313,7 +313,7 @@ ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
 	struct nlattr *attr;
 	size_t len;
 
-	len = strlen(str);
+	len = strlen(str) + 1;
 	if (__ynl_attr_put_overflow(nlh, len))
 		return;
 
@@ -321,7 +321,7 @@ ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
 	attr->nla_type = attr_type;
 
 	strcpy((char *)ynl_attr_data(attr), str);
-	attr->nla_len = NLA_HDRLEN + NLA_ALIGN(len);
+	attr->nla_len = NLA_HDRLEN + len;
 
 	nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
 }
-- 
2.51.0


