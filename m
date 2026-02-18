Return-Path: <netdev+bounces-259342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONuvBTQBlmlHYAIAu9opvQ
	(envelope-from <netdev+bounces-259342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:13:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12D158987
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABAC1305AC90
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57157346FA5;
	Wed, 18 Feb 2026 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sxjp1ngr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF2346ACD
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438276; cv=none; b=YQ4ZeiJ1/B0cpP1bYf6WvxrXQkWFXf4XEtpkqBzdxkXLgwuXwkQ6YZKc9vi46fRtamLLeiq7+drIPJS7NBH3XlX2rH294J4WLeVGnVeUzO73gNhNhw5214xG+SIuBe5lhyk+dojwHPW1t/ch8EBUF1JnDO8Xspq52PadaUAKKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438276; c=relaxed/simple;
	bh=uGK41uj6PP/iNYJl90nhzFCAJOq4jOu74IyB8IEiN9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHNDApRDEvI6Azf7duVxkjyTMgqDnxx4Xt7Ye0APMs6PJwBkE/i6IjDs5B8cQjdAgxkfk8gTHan3F5SG+Q8RpTDKh0WUG75DfQXtoRDcP2ElUJBSk4//YvIOJzRuty8S6VmGuQVOImdhYB3SyaYLbV2iiEdl14UcRIYyanhkzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sxjp1ngr; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7947cf097c1so1221717b3.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 10:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771438273; x=1772043073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1wgGIa8//Y21Q1yl9IMhAVoEJrPKjw/0p7B3ammqNo=;
        b=Sxjp1ngrbm61KM1SssCgtg53oRQ57xddq335xU0Tr5P9gbgY3OvVgSzoHEjupl7Qiz
         qeShLNItOV+R3zhWkx+a49rTqh4sozGV9SvpO82vAtoBN+Rj7nV8rVpv8Lk92TbpqBcZ
         bfCZLNXGQubvFMGEUg5p7dAxzqmq5zAWL9tXQmhlx+F1w8Ka8X8lZdHUhRcCus/5dNPS
         sOYNDLYVwrz+8awLMJhb4QWtGUz1zXTFYwd5lR0zUkRgiPSYjJ/SsGcHqhck9Ihw//ac
         37aNH6AxotXpF3p2ChXd3VIXZJQMovwbHgWXD9xpsMQAaslXWg2P+pLSz/fzEZAiD8Kd
         RblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771438273; x=1772043073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l1wgGIa8//Y21Q1yl9IMhAVoEJrPKjw/0p7B3ammqNo=;
        b=GzxdlW3CkVjxqc45SZgTQbwOYROMuOxCOJ0lYJNjNDzFRqMc0KK9O3XujWNMMnpX9U
         d7YAvOaqLj6tCmF2FhktTQxuRZwvSbAw4cOmKVMosUx4P4lUvf8o2EcGS5c4KE5m5Qkn
         kmD5DJMVQn1kOpbVbLA4AXlsvl593SXYV67jNGfx4OGvHTdN0Y/bAIi9kgKj+MyiVkUB
         jo+7MNFh2zuuxYdU2kTtN86Q8Qdy4zqyd4pTYsGhI2wOAlHioeTRTeb3Vt4jbigbVgNt
         TT3kOs0AH2R0QEDGPG+Kpo1Ell1najCv1+JH5M+cidqoSSs+Jy3D1NpIFSLyNVvB2ELY
         AlJg==
X-Forwarded-Encrypted: i=1; AJvYcCUgkoo6zOjcjuyeLRGXlQy19LDyP11YVxrx72iRkmFRG2bhADSUKdEgRuRjnI0f32Q8U2o4DWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ATy8PZC0Ui5hgnfdLmzXMnLAGoJBocAf6Hb1wKCuTVu4AFVL
	U76kAZZtPW3zqSd36xQOnu8t3Y7+81/1LOrKcbDQIjgNDGDIoU2AHga+
X-Gm-Gg: AZuq6aLnmwxdMunlvNOgvDEGuzHK+3HkF44AGTBbBy3onM9Dsk1+sSPGLAEN1gZR3Ho
	U7na2+3TzrjGxJhFxWHWxj9YUL6NCgnZ5YJvA6O2fzTx712dkQ5lkUyFZCwsTBMVyPwtIzBK3L7
	NlXWzsDWPz4LMnz6DM8Zye/9KFckwVh9jo1fzpklCA4vtJjxOntLF/UbuLDBekxn4ZZfGH3gnXs
	uJ34nKkWydqtDO6Qc9qTnxdxbmiCpwbh1DLCkSaF7Q/ku0xVQfzRrsSQTbatmyuQcH6oNFyQgCL
	qgdGi0JluEl6DwSKirNLkt25TundoyCpmn5pcrWUKtQO8BUjiQaPAOQhr8Q6mk+4J3t2SLLHYln
	5mi6JGk8E/TgqjXJB8hkgwmhV8vdaOAMNsUULhNDeFSlHWYKPM2a9SFnKt7f19+RYZXHWPOInc4
	U6cT70bss9mt/uR9a6MJDd0Q==
X-Received: by 2002:a05:690c:dc6:b0:798:3a6:3f4 with SMTP id 00721157ae682-79803a60431mr1995927b3.43.1771438273356;
        Wed, 18 Feb 2026 10:11:13 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c257ed5sm124246567b3.45.2026.02.18.10.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:11:13 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 18 Feb 2026 10:10:38 -0800
Subject: [PATCH net v2 3/3] vsock: document write-once behavior of the
 child_ns_mode sysctl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-vsock-ns-write-once-v2-3-19e4c50d509a@meta.com>
References: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
In-Reply-To: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259342-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 5A12D158987
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Update the vsock child_ns_mode documentation to include the new the
write-once semantics of setting child_ns_mode. The semantics are
implemented in a different patch in this series.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 Documentation/admin-guide/sysctl/net.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index c10530624f1e..976a176fb451 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -581,9 +581,9 @@ The init_net mode is always ``global``.
 child_ns_mode
 -------------
 
-Controls what mode newly created child namespaces will inherit. At namespace
-creation, ``ns_mode`` is inherited from the parent's ``child_ns_mode``. The
-initial value matches the namespace's own ``ns_mode``.
+Write-once. Controls what mode newly created child namespaces will inherit. At
+namespace creation, ``ns_mode`` is inherited from the parent's
+``child_ns_mode``. The initial value matches the namespace's own ``ns_mode``.
 
 Values:
 
@@ -594,6 +594,10 @@ Values:
 	  their sockets will only be able to connect within their own
 	  namespace.
 
+``child_ns_mode`` can only be written once per namespace. Writing the same
+value that is already set succeeds. Writing a different value after the first
+write returns ``-EBUSY``.
+
 Changing ``child_ns_mode`` only affects namespaces created after the change;
 it does not modify the current namespace or any existing children.
 

-- 
2.47.3


