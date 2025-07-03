Return-Path: <netdev+bounces-203943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F65AF8358
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 00:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB97F6E609B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 22:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8F329C339;
	Thu,  3 Jul 2025 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nYdxqGH1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3752AF19
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581440; cv=none; b=K4Ix+co2BJa6NAuHHNNXUbL9tDY1RqFwQ9W78jvQZWsbprrISVuyT0NIH5vb2oK0iPbSu+nIiX9g4bgg8zGeQ3bHs/QO+05T3R+hMP/3TDslYQ7/EVKTSvuYassGNogRmCWLXdTW57Z+1fKdC6EBDY5gP7Os1C4oiqd9tajG5E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581440; c=relaxed/simple;
	bh=76jAgqwnRdt0PkgsmBh+2CH7T1W71cnmvzvOLXA8MWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8xEz9/Jr/u6PBso9BYb9yEOy1Dn4J1r4KE2cDSooPmqJEGhiBUGkv4CRQh1ftAodCJ7PERIhdF9tO82BPXDC10X6D37dIdaMaGFEtNlkGhwt0LZIcRFGTCfwl4CYVakGl6xVq3nC3kmTpHdaHTogTWGou+y9LkruRiY6IxZeiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nYdxqGH1; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AD5353F919
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751581432;
	bh=VswAsDFL0zNUvK6Slvz23luzH3RQ+gAmm3nQvl/AzzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=nYdxqGH1tYW8sWcgeMk8GB3iiKqgE3C6czSap5o6asqQHjHb/PKN969iNPrC97Cht
	 rL7e1jXSPD4L2tUJ6NT041ihUHr/wo/2Gsb7KI5/i6AG/PvEkc67Y7Om49WVJN1rWY
	 dog3R2iAKDgkOqmX+gIRthrJEvO6R/AGRIyy2mvndcTWoWhrkcmo+fP9aiMtWPgDog
	 UDYwDUWNz13EyGi6CGTExO+BUQMenlVTFDlDbmxhq+nwZszwG1SOBKVBXacRuFUASC
	 hTRcGgAosZjDTdtJGc+RqGh/RP2LR1WViZF1ZgyN40I+U9Ic6ewCmrArcG3/F3C7VR
	 sV5j9w7zzT+wA==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-60724177a1fso256823a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 15:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751581431; x=1752186231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VswAsDFL0zNUvK6Slvz23luzH3RQ+gAmm3nQvl/AzzM=;
        b=Tf9nKACgHgjG1t2+a3ZMaiqWBC7W0DA8Y6FEh5Ng2ncGYLGqfHpqEQPMFZL/U9mfFz
         +c4B8EoqDGj0y78kngP+pBU6hcfOoLLrH4Xv5c8kXdOCxhieFqdCMOb8p08AgcoxBXi7
         Nl3fF86RKtfD72l/o+AkTRewdHUVrhjR8hxUpEf5drUnqY7v9ZX3PRXuG7IlYosTKVtk
         MpspzBRCjUkAWStE+V8QGxD/wtvs0epXpxOqnq5x39C9C8vGmr8FGx8LDokNvWe8qZ72
         biR7xYn5n3NgHdeLHSW2MuGaOqYU+yTfUfnA9TaH2fxEV4PPLQW0Agg+N9QFjwPXRTiD
         4gkw==
X-Forwarded-Encrypted: i=1; AJvYcCU3LnAYZV/0+5/CefcmflgXzqiqhjuJliBKxs8sPcSj2NT0++pMiuQ7r8n8u19n1PaL8aZ0/K4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rGcoIJ+zkeD7cn6orVRqmaPMot/cxb3TTrKMrYW9mv/ZmttI
	ZDkkms2iYOrVMfZLc9AUFOaTQeOKptsBS7nXXDDKNIeS1UeFIGdcqbl2OK9SnXzVb0vVkPngyEm
	9E/41t4LfGnxcF53mFQay/kbuhcagTtgr2KvwLOjLtsgsqn6bhHigscBHDdEbv0Vw+Lh/vmgVhQ
	==
X-Gm-Gg: ASbGncsnyLvCA5u4VJtV2wPjRv7fGgYp/KJY1rU3OWcpKENLRQrzSV8bCLHL1idiHhS
	4AHeU5Mgn+gWFr3lAaT7dklnaiVqi6kxAT9Wl6nMxTKLWe9+SejrZaUzx9+iT+M9cpfZ0ZV3PTe
	oiyw2CWrFYVFuC2pog5KB47/RCbLJtlB0llPlZTfn5p1dC1VlmJLoGRKVjDqF02Nnl/YUYeT/th
	qFd4KUKNDwLrJH84iRvC1GCQAvh2VS2cwZvcu3CZdklGzZfhIogpXQQefMn192Znybfusb1HaPL
	23kIHlnellTYIgpZJqcCXqtZhRAVKgaJbrW1IRjJWhJQ7KIYFg==
X-Received: by 2002:a05:6402:3588:b0:60c:6a48:8047 with SMTP id 4fb4d7f45d1cf-60fd322483dmr239240a12.11.1751581431513;
        Thu, 03 Jul 2025 15:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFPhWZ0KYGjmFv+0GQApSZDavL8SiqBWwO+aZo2jCUxgX0FmWRVcBX+bYx4jduoymluOqpJA==
X-Received: by 2002:a05:6402:3588:b0:60c:6a48:8047 with SMTP id 4fb4d7f45d1cf-60fd322483dmr239220a12.11.1751581431164;
        Thu, 03 Jul 2025 15:23:51 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1fb083sm355164a12.62.2025.07.03.15.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:23:50 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH net-next v3 6/7] af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
Date: Fri,  4 Jul 2025 00:23:10 +0200
Message-ID: <20250703222314.309967-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now everything is ready to pass PIDFD_STALE to pidfd_prepare().
This will allow opening pidfd for reaped tasks.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 net/core/scm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index 358a4e04d46c..072d5742440a 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/pid_namespace.h>
 #include <linux/pid.h>
+#include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
@@ -482,7 +483,7 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
 	if (!scm->pid)
 		return;
 
-	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
+	pidfd = pidfd_prepare(scm->pid, PIDFD_STALE, &pidfd_file);
 
 	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
 		if (pidfd_file) {
-- 
2.43.0


