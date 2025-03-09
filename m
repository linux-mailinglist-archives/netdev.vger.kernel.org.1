Return-Path: <netdev+bounces-173278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76281A58445
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C1916B66A
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 13:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B562E1DE2D4;
	Sun,  9 Mar 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Na0O5okq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC301DD88D
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527000; cv=none; b=pqCeZ62CdkYgQ6fPkxn0yexC8DnJFM6QRyhuZf0SJ7QPaQW9bEI2rMakv0WZcT8eWhIBPhog1IUl5dKvLD/AWkWUsLQ3ZZjjbRgOYXiK0p7mNV1wbZ3DRwrJw4siOX55x1c+fPJ38EWZ7ftfexP67IH9T4/HIqaxOq+WnxrWfsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527000; c=relaxed/simple;
	bh=HBzrftBgtmyJjSlrkubZ14+wzgBNDhuJgvNUC0ysav8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6hQRtjHi0Ap47pwVhKfTwwGaNJr7LJTvP3RnMZeRynU4Q4i6SNyyfH/w0iWPRAzkJX6VsD2B75v3klKVLFvaZb0O/RX+6dJu7d2rh4Rdjt5+Vco73W1BL9QEhXb/TKCSybUxjEfh5RfNFx9hi9i7IoDXPWES2RHUTxsFjFM80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Na0O5okq; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B55C403E3
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 13:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526988;
	bh=De9T9eT10I0LuI5V7o8PivgIMdFcydoHgbUnBTWTEUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=Na0O5okqMczoRCXSIY/inK7gbzvLkWF4vIxlnotNd5ER9Tm0UxYVyDREa4LzSSP0t
	 0rYbJqS5MfMhpjUY0kTVCOAary+U5oUASnagy1Q7csF9sqJvhz+oZ9qGj87ousHOYY
	 9QQfbAcCRqnQcg2mT5KmdYYat9Xv0MkOOpAMAdUq/sBMExnIb+Ml3fuBYw8CWtD8mb
	 w03+wO9Zsmhp2lCra1lYZS5x9+w7/K/vlzxY+fGqvOOHiwvHfDiA5z298km4mAbCS6
	 rhz5FxQQv7vmsTmyGRKxW0+p0annYpH6904XBq/BuwNegAaMRyQeQEOmyJ5MM3KaCr
	 9oSKwAv3kxgNw==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac1e442740cso317835466b.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 06:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526983; x=1742131783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=De9T9eT10I0LuI5V7o8PivgIMdFcydoHgbUnBTWTEUw=;
        b=ssLH4ejdEHXD5YxA2yqN41XaylQatyIvCGR5OrbWb1HltoDOs/5CWtZB4Iv+CtIE2j
         PGEALqMd6RbpFwbwnG3iZALxp/ajUDx7QKQwc89yuPn6y2TBaUZNWneAlxD4/Mgvu3QO
         PHCCDv3VgJ8kJ0s4n0aUml5fhPDWhOm29jea2sEMGPE1DAcOBzQ8P/sFAYKN/czBLyo+
         D5vtnOBW3U0joxt25E3+fNl+xxSjKfyblVvDWd1TqCMhGQZMAYnypGq5uznm9WELjRPv
         pRvWQ65Wmvop7yIQcaYYMCW5IkfIgFkzqKnugsEuxLP7Qms20L5HJEb9hGua8LVY08O8
         VaUA==
X-Forwarded-Encrypted: i=1; AJvYcCVONdZ6H222dLLbi4tSLyDOVOL7gjOXVhVLKP+wkjfTAHr4g2RwazCn46t8kL/gXg9e49pigds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjMjuJcAWTzXRkyozv2riHH0SZUVFEInqX7i8uLrloG5JwVxH
	Q5c1HEDRy6HtCpCf1xWUz6JuvUhYaQbSViq02rnT9LkiuHqtAY2aY8SEDx1ufL3KlYVuok5iaa3
	IRZyHx4O8OKABX1n7Zo2etuIbwGoEjmpkgUgkRIlIMjl6iV7K3ZFtjI+vR/KKnVmr8RjRRy1WSB
	zJJw==
X-Gm-Gg: ASbGnctE4a3+hMCJH1LTlbOCdCAmH11JXIgXyVvToC8KnAXhAqyfW1klnA0HZu2paf4
	Ge3+5Bc//T8gTOe1P7KNgXNkxVg+CGZhEZQAMrN6f5iJUV/xRIjyktwlnq0ktIOGXhP/0r/LLxk
	AEvsTE3P7UiAIt51eG40DmwvgqPvrkhpFZtNV+S5SuzcxA3FofnSxYLYmcwbPqle2XjMCef/38x
	6LMr3+et16xGCb6KitRhNyEP3jRwz7nGSV5a/dysqf4Nj7xrtdQsHELhM8Avmz/kxs+XJOCFOd+
	DWGdvHOtefcX/nOoEhJvDiMfjNqiEwGcYlDAw9irdMh2t5TOzf8mVjLE/wWPyPlnXBjXMPp6MXI
	ErqNOsnpPTATO+O6JtA==
X-Received: by 2002:a17:907:97d5:b0:abf:6166:d0e0 with SMTP id a640c23a62f3a-ac252fb9c80mr1252827366b.35.1741526983265;
        Sun, 09 Mar 2025 06:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Jp1lBL5UEDOmoLhr3/1+wDXXnEG000YcKS7uOUaGglmKZVGqoQ8LvIDpjopxUUJhpkTkFg==
X-Received: by 2002:a17:907:97d5:b0:abf:6166:d0e0 with SMTP id a640c23a62f3a-ac252fb9c80mr1252824566b.35.1741526982866;
        Sun, 09 Mar 2025 06:29:42 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:42 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 3/4] tools/testing/selftests/cgroup/cgroup_util: add cg_get_id helper
Date: Sun,  9 Mar 2025 14:28:14 +0100
Message-ID: <20250309132821.103046-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 15 +++++++++++++++
 tools/testing/selftests/cgroup/cgroup_util.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 1e2d46636a0c..b60e0e1433f4 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -205,6 +205,21 @@ int cg_open(const char *cgroup, const char *control, int flags)
 	return open(path, flags);
 }
 
+/*
+ * Returns cgroup id on success, or -1 on failure.
+ */
+uint64_t cg_get_id(const char *cgroup)
+{
+	struct stat st;
+	int ret;
+
+	ret = stat(cgroup, &st);
+	if (ret)
+		return -1;
+
+	return st.st_ino;
+}
+
 int cg_write_numeric(const char *cgroup, const char *control, long value)
 {
 	char buf[64];
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 19b131ee7707..3f2d9676ceda 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <stdbool.h>
+#include <stdint.h>
 #include <stdlib.h>
 
 #include "../kselftest.h"
@@ -39,6 +40,7 @@ long cg_read_key_long(const char *cgroup, const char *control, const char *key);
 extern long cg_read_lc(const char *cgroup, const char *control);
 extern int cg_write(const char *cgroup, const char *control, char *buf);
 extern int cg_open(const char *cgroup, const char *control, int flags);
+extern uint64_t cg_get_id(const char *cgroup);
 int cg_write_numeric(const char *cgroup, const char *control, long value);
 extern int cg_run(const char *cgroup,
 		  int (*fn)(const char *cgroup, void *arg),
-- 
2.43.0


