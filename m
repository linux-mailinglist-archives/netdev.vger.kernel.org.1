Return-Path: <netdev+bounces-202812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00E6AEF184
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4513BDD3E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2F026C3A9;
	Tue,  1 Jul 2025 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pzZ8SLb2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D826B0B9
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359300; cv=none; b=uLoxlJEu0VTe3TEKKUuo+dN7Pk0K4PO3Gw/xIv1hdifAdBaiNuEUu960ehVTvRANsbCr212zFsLP6RqbP0MupzpAuGeqfUYpM4158f8Sa5BSQCmJSj6AcAQHZoiuF/vbmqO3SozFD3zkTaFZCFGhwTxcrW4WRNQRbWPc/4FGiII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359300; c=relaxed/simple;
	bh=1nHyGmrpv5FF3xysV/SpLweCV2NUJ2mNgDUauaWEkfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2KwNEDPY5R0fZxIZJWoB8TFQaBtL5p4JKsYROLRWzTV6s+2ctYHXbwK6w38Acl+JTvPIz+c8h/n/iWZo5yqeA0V6YgR3wi71lvbrWEUIN/rNkqNLe3Zl6IvaxEIM4R/EUrKGtrmCQ6kfWc2Dg2uXdD6CHrxKaLUdtOr8vfP1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pzZ8SLb2; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ADEF93F11B
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751359293;
	bh=Z9pX1VfTmwVxaOGXavGK5NoBC/cEjdayNk20LrQfJuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=pzZ8SLb24Q9tdEBgAJ8EbeKQeakKTVhwhJnbkSc3azIdI9YuAaOgrgjnjj3sKBhRH
	 0XQXg57tpQ3PCohEV0KOAu7ajPJKxadMC4H6dHt/lujqoygbAa9YxWnvZ+3nfy9ht4
	 ke9+RUPS3EfCP5gCt6lxVqwl+vMS+ezh6KpnxGgPG1dq4EuZpv5tudA1T2NH/Ae+0S
	 guZEo7xS9+3FfPIn3SwkOXX/7UQaiBffEi8IiQR8knKqFsMFggj7CswjgSZnRDbrvs
	 Qk8mQrPJPAOrS3C13M+pZNjz3s0uVuF9/2JS+x7wvDxRHQusxgJgL27kMAh+ZtlZ22
	 KHyr1Wu+yxDKg==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ade70c2cfc1so468478166b.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 01:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359293; x=1751964093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9pX1VfTmwVxaOGXavGK5NoBC/cEjdayNk20LrQfJuk=;
        b=U3afmh2oGUoXihU4/vXnjs+Sp8R2IKZQCHb+JUIVw05k6UF3dTTINf37mN//MZaUwH
         mk6ykoUMFgkJSOsbG62D7MFzBV3rItOP/7ZESzIn7TsmD1m3B96H13aKTIQ1BiRRQzJ2
         i4voPj6bOmnt1SGVbMGY2NuRRTJ9GYlVIMLEo6kptyc5FUe6U6OO6c3NBwF77u7AOp9T
         D7rvK5yiOxcglUhynedlaaW8gS3jLXqubFdp2C6jLX8A9Ezw6OomKpSNH2f0dPyRtGXm
         0J6Y7FCI1QP1zDVrI4k3sxX/NfXNT6xPlLx779IIl2mIy/9e6eJ4Zy80XpztcQhi0XS1
         imBA==
X-Forwarded-Encrypted: i=1; AJvYcCUoLFY+4du6dkh3+c0DuOTPWhlyIQ2I/tjFbygYiYhaCVBz20zkxPpROeUyfL/FIA0m3RiYxS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMv7JHFFT42QwS25FfHBEAQuG9r/ZEWcvrjCPwJ+GxpteVjZ9E
	hMCWUQ9F0DGfsfBZx1CUdHU/qSp3KThvpZ7nnp2b/QNbXWPgimctdOR75FiMU21y2vL5cwUn71q
	domqr+wAPPyQywUrT2plsGwsTlg9JPE47EMoUQSN7xfJoZ9O30W8/xS5l/GzA9sl8qL1OQ6fnrw
	==
X-Gm-Gg: ASbGncvEBK/7GjLtpvc3bh+MF+wDF2e7B3PWBhBNm5A7dOlWbslD1XkrlfKzIpIof9C
	ayNyFF30ncgpUletYwFIhtHLbrSrvcn0ViB7LByoa7SUnXf0YU0HYMBtOtwKDRHeCO5faEc/ga/
	PauzEscj5lnp3lB4MrmDBrnF13KE97upUfmFTEE8lARHDcPI9w/LyiSl12HVtoPuK78S11z8yaz
	5Ju9wVG3Tf1YSnlDcdcI7wN8vWyB2CeIMbGhWXtw/oB8qEHvVNS206rGFA2fn2iQFYYCUimYdhO
	Y0vBfJjP5jTI1WIksDKLFm77FEyKGcBTGeVEFJPdL+fhv6gc+g==
X-Received: by 2002:a17:906:6a13:b0:ae0:de4a:3153 with SMTP id a640c23a62f3a-ae3501097c6mr1607049966b.38.1751359293106;
        Tue, 01 Jul 2025 01:41:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHYz6ade5ZUSuNmyvh/iYMmaOMtSfZC8fihJvxErHxG7jEJstf0bxN2jhvBPbeKySrJFBTJA==
X-Received: by 2002:a17:906:6a13:b0:ae0:de4a:3153 with SMTP id a640c23a62f3a-ae3501097c6mr1607047266b.38.1751359292577;
        Tue, 01 Jul 2025 01:41:32 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b416sm812427166b.28.2025.07.01.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:41:32 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/6] af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
Date: Tue,  1 Jul 2025 10:39:19 +0200
Message-ID: <20250701083922.97928-11-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
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
 include/net/scm.h | 1 +
 net/core/scm.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 597a40779269..288b4861cc68 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -8,6 +8,7 @@
 #include <linux/file.h>
 #include <linux/security.h>
 #include <linux/pid.h>
+#include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/nsproxy.h>
 #include <linux/sched/signal.h>
diff --git a/net/core/scm.c b/net/core/scm.c
index 50dfec6f8a2b..69e7e0f6390e 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -481,7 +481,7 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
 	if (!scm->pid)
 		return;
 
-	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
+	pidfd = pidfd_prepare(scm->pid, PIDFD_STALE, &pidfd_file);
 
 	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
 		if (pidfd_file) {
-- 
2.43.0


