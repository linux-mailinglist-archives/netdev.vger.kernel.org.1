Return-Path: <netdev+bounces-258927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLA7IalHk2mi3AEAu9opvQ
	(envelope-from <netdev+bounces-258927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:36:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC28B1463F1
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D71B3001482
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F08D3126B2;
	Mon, 16 Feb 2026 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyuPt5M/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYzmf9MY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46742BE7A7
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259515; cv=none; b=Fl3Ao7tqK3p0iP+FPJ0XQRQIrs4saM9msolGsWzDQDHfOzk1d2YRtnJ0jlwMbAeJR++m9B76eOvmwECf3jboVObmjXPMkF0Ni19qP9aUID5dOwaULnDn5NihXX+sTeUNXp8MJWcnAdtrR6gnI95lSTawqSGuQTyia2FNOmfS3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259515; c=relaxed/simple;
	bh=+7SJriHApn6LG+ZXkqk+hATTXuG4ofS1EC6EC19EIdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHlnfUtBIoanAbitNHOdbyp8FatsYesjK+voVc9Sy0hruRTMOLcPPSJQrhF2Q+eiW6OVOkT19QIgEFuBwJvMCoY6QfY45Xwu3JAW4fxcgUSvyNME2zXPatyTTB+OKN4CdP+5RT+HMk8tXp5HTNnyZYFdSS6ByNFGOl4Yswu0JIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyuPt5M/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYzmf9MY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771259512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WkePnEG/Jhpv0IH/ZRAVd0v+S4IAU+eMmwXDSi6Vcco=;
	b=WyuPt5M/vlaupglzbUik+UAa4je6xxgyF/yHaV9g5YXgJKpLG2D4QE6SCuUxpaoGSn7l0d
	cZSpzBAfqpeJa6Z9AAPz/KIyFyjz9Bz8rYkEXKg3A+WeFzG6nA1RfwLXrC/SAi29UsWSr3
	t9sbm6pGPpar+K9Pth/rgFovKiUdvWg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-49NxCMI_O3udPyYeoX6S9A-1; Mon, 16 Feb 2026 11:31:51 -0500
X-MC-Unique: 49NxCMI_O3udPyYeoX6S9A-1
X-Mimecast-MFC-AGG-ID: 49NxCMI_O3udPyYeoX6S9A_1771259510
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43624564fc9so3395550f8f.2
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 08:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771259510; x=1771864310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WkePnEG/Jhpv0IH/ZRAVd0v+S4IAU+eMmwXDSi6Vcco=;
        b=LYzmf9MYdRl68p3q3NiyszCoOfUO0iS+htceNaZHzBzOqgU6vUDXyF+H3gglv14cIl
         Imw+BNpqTnknK0QMQ50ylleOFkoukReTm6i+5wfPWKKzrq8DQ/e+bH8ha/n8Xw0cBFuk
         e2rQuN2F+rSuSFpUwzppQw4jtw/OC6IMgaxNzyM8XrDahLlO/FlJEf3sqyh1PPvAzroD
         NfV7VwT3Ky9jcMco6wVHwdOjmYIzArJY15/G5CnyoWQz9FgXu9aiFB005fYtrHPgxiVw
         PQlizuCxRnFcUun3penpsFkDoTRpwiPqoSzh9/q8ID3E7PS3dU71yV4TFqGSTuXNxU4L
         vf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771259510; x=1771864310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkePnEG/Jhpv0IH/ZRAVd0v+S4IAU+eMmwXDSi6Vcco=;
        b=KL/pLgYlEcBtnHDNe9g/z5sQohCnuNCXeqF9mBQcc7OQFLnj1jk4Md45+FvqNX1q8n
         p16drI6KhfEeiEj4ndC0xyQBnyFo6d8MynJ2iX5qA+zNZ4RmcpBFGtXKA/zvqWxly2hq
         hRHOAZO+tpQuhIixxDZFParCLm8VoLlNw8jSIH7jbQSU1OMJ32zzj/g1VAHX0dFs/rmN
         xzfDWI1t34d7gEqd0w62g6RMh+YCn92oCEqfWSujU9/xf5eaZOOgU7hWQf/1ON/xZHp+
         jmvqh9Hu3fh+oQ0c36g50eHQk9+8qJaa62TWYy1RjBram/Vnwh7SJvGvj18X7pe7H+iE
         9WCg==
X-Gm-Message-State: AOJu0YyXIzcu1CU/n3UjnFosWleNj+v/dxLCmZXcbuFKFNAhi3O4vqrM
	JunecAR7eQWvjrVVceLyVAum/m6+/tK3jFFgYkHdkVlx1b+RpgWZb6HFAU2faBsdYcD96pD4bmD
	DCpB4kd23XGAa/RnWuwUPYgjihSqxvXEVSqw/uwkyZrhxbZs6NDOvIqVdOvy8q/7Ou9bJA6o3iw
	/pyFwC3TGqBj9RJWQ6jl1Yr+dumEuBbC+uqgU7xlfGoA==
X-Gm-Gg: AZuq6aJmfE80mESAxyiQidotWqdJwMXK2INg8k7937MnvS5JzEn2/BgG/nZF3oGGblu
	6793hKj6A8IKXENVBPvKDFYZiQXuqCoNs7BmEeMnhlrD2NXyaG8xWwr8XOUK/xX8hdOjuEY6dpG
	otlF4ZwHrYN2tVOtBWe6UFFq0Q+/bJwRq5h6i/PWROgSyI2+Wk0FG3/O7fCOZxoFXoVGGzw4gqW
	1NdDscUstJHEmRLo9FYNZpGFqua4F4wJMCb11y89eyokHt2ieISuWX9CQ+113gJo3DnPMqA2KzS
	RNBiVNXVIfja3ip7cuMels1VOEuRHPNMx4e/ZeaabOQfMkRmkSi+1VPCkq7KvOvUVfyenCJBHoI
	fJ2p2F0cRa/WOGy5toZK9MUf1PPdSbUIELlM5ojLPjph5awVXo9wCCkZXuK75xj/Y+q90/p/T
X-Received: by 2002:a5d:5f47:0:b0:435:add0:3d68 with SMTP id ffacd0b85a97d-4379dbae475mr15843999f8f.58.1771259509688;
        Mon, 16 Feb 2026 08:31:49 -0800 (PST)
X-Received: by 2002:a5d:5f47:0:b0:435:add0:3d68 with SMTP id ffacd0b85a97d-4379dbae475mr15843940f8f.58.1771259509158;
        Mon, 16 Feb 2026 08:31:49 -0800 (PST)
Received: from stex1.redhat.com (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8209sm29818473f8f.30.2026.02.16.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:31:48 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net] vsock: document namespace mode sysctls
Date: Mon, 16 Feb 2026 17:31:47 +0100
Message-ID: <20260216163147.236844-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258927-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC28B1463F1
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

Add documentation for the vsock per-namespace sysctls (`ns_mode` and
`child_ns_mode`) to Documentation/admin-guide/sysctl/net.rst.
These sysctls were introduced by by commit eafb64f40ca4 ("vsock: add
netns to vsock core").

Document the two namespace modes (`global` and `local`), the
inheritance behavior of `child_ns_mode`, and the restriction preventing
local namespaces from setting `child_ns_mode` to `global`.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
Hi,
I guess this is `net` material since we forgot to do this change with
commit eafb64f40ca4 ("vsock: add netns to vsock core") landed in Linus'
tree in the current merge window, but I'm not sure if we need a Fixes
tag.

Let me know if a Fixes tag is needed or if this patch is net-next material.

Thanks,
Stefano
---
 Documentation/admin-guide/sysctl/net.rst | 52 +++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 19408da2390b..c10530624f1e 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -40,8 +40,8 @@ Table : Subdirectories in /proc/sys/net
  bridge    Bridging              rose       X.25 PLP layer
  core      General parameter     tipc       TIPC
  ethernet  Ethernet protocol     unix       Unix domain sockets
- ipv4      IP version 4          x25        X.25 protocol
- ipv6      IP version 6
+ ipv4      IP version 4          vsock      VSOCK sockets
+ ipv6      IP version 6          x25        X.25 protocol
  ========= =================== = ========== ===================
 
 1. /proc/sys/net/core - Network core options
@@ -551,3 +551,51 @@ originally may have been issued in the correct sequential order.
 If named_timeout is nonzero, failed topology updates will be placed on a defer
 queue until another event arrives that clears the error, or until the timeout
 expires. Value is in milliseconds.
+
+6. /proc/sys/net/vsock - VSOCK sockets
+--------------------------------------
+
+VSOCK sockets (AF_VSOCK) provide communication between virtual machines and
+their hosts. The behavior of VSOCK sockets in a network namespace is determined
+by the namespace's mode (``global`` or ``local``), which controls how CIDs
+(Context IDs) are allocated and how sockets interact across namespaces.
+
+ns_mode
+-------
+
+Read-only. Reports the current namespace's mode, set at namespace creation
+and immutable thereafter.
+
+Values:
+
+	- ``global`` - the namespace shares system-wide CID allocation and
+	  its sockets can reach any VM or socket in any global namespace.
+	  Sockets in this namespace cannot reach sockets in local
+	  namespaces.
+	- ``local`` - the namespace has private CID allocation and its
+	  sockets can only connect to VMs or sockets within the same
+	  namespace.
+
+The init_net mode is always ``global``.
+
+child_ns_mode
+-------------
+
+Controls what mode newly created child namespaces will inherit. At namespace
+creation, ``ns_mode`` is inherited from the parent's ``child_ns_mode``. The
+initial value matches the namespace's own ``ns_mode``.
+
+Values:
+
+	- ``global`` - child namespaces will share system-wide CID allocation
+	  and their sockets will be able to reach any VM or socket in any
+	  global namespace.
+	- ``local`` - child namespaces will have private CID allocation and
+	  their sockets will only be able to connect within their own
+	  namespace.
+
+Changing ``child_ns_mode`` only affects namespaces created after the change;
+it does not modify the current namespace or any existing children.
+
+A namespace with ``ns_mode`` set to ``local`` cannot change
+``child_ns_mode`` to ``global`` (returns ``-EPERM``).
-- 
2.53.0


