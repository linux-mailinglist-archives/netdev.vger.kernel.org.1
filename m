Return-Path: <netdev+bounces-64931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572C0837EC4
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 02:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97C929855D
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 01:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACAE13BE87;
	Tue, 23 Jan 2024 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j8KUJJgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479F13B7A1
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970764; cv=none; b=OpaJWI99qlDVeCuaH29sG5NfBCOXNyZTNV+Tf1lSFguehhQ+piY1X8stS9fvbFTPHJ2X+Byjy4mZJEideZIR8MzW0ISG31uhAufrS8cNiWl6yc1e0RSeuav+whY8ZRcu+qSzpjkNnuDdUL5me6R0bK1jZVqbiz9/5A24IO2hXEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970764; c=relaxed/simple;
	bh=rhiNkfwcsBY8pN0Aj3OX3M7epOQG7vcAhg9hdXLwAek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3TuJ66tW2b8kFepQCzMsTN738jHOcurAco8WLqWUd5k3KVbVrrK/LKW7Z7/dd6VulL8FUC2mD93Tor2K1IDgEcWRKUPBzq8Ap4krtQdcisCNTbhDtNHbea7TAIhi7VsTtJAR684QYQZlHpnrTYY6zqRAF3JKQyLyL26GtzmeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j8KUJJgt; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6dbb003be79so3314663b3a.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970762; x=1706575562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koLuWwEc6R93KvA47iKWZn4p87NyejoVGKhwRpq6uhs=;
        b=j8KUJJgt1OC46MRP1rTSCjb3ikE3ot4TXw9Tukg8wx7H+83b6ohP4LHJ9UNddjKRl2
         fSHxXLpJPJivZGL1FttjKFG88OY1GIfXdbJmN3+4oYrwPx/KuMNiKYcL0usJSbXDhAA/
         pNz4tVDi9c8HBow8e9NE5hiv1GNBnowyNm78Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970762; x=1706575562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koLuWwEc6R93KvA47iKWZn4p87NyejoVGKhwRpq6uhs=;
        b=DqltIDvpCtek8uoPt1yI1y9ILpF6ZnaLcXqukDptVrasGygUJOnQPbT7btGOnqEjao
         DscC0dhAWwybXYsi35e4/aFHu29zmKe4uqq5XqgaAqpp2CO3nGF77e1sG0t8FbTIlLqz
         1YasHiEU5V6VDYzJqVLgWZ0rZ99xxiBxrdmSIDvYJnZbYUIr1E4kvVUmLWpN+SVhqLyC
         EKs/oM6kQujw6JVXEBYRdCbswlsN6S83qDqjWl9j1dsrOrWzhqJhsaprgeQboGcFs+Jp
         MuakFgusHdXOS9JaQv7mFtqmz2Xqo3NzTaTs1u9YREbE80axlAi4uWwxOJgm6IVYUU+a
         xmuw==
X-Gm-Message-State: AOJu0YxMZKSIWFubWKUBJu+Ucit2Z2agUfx2OSItjbJgQFL4APQUdXXs
	93YP6qroyS2l1wfFoE8eJmA7u2e++pvzK03r7X50lnJSa/NDQqRh4igMqkiCRg==
X-Google-Smtp-Source: AGHT+IHnnbXv7LLoQQuo5IERPmQ1aDbHfWs5esMUO9nvMTULeZpbAQsvNcJD7PAXZFLGmSXlcp3hjA==
X-Received: by 2002:a05:6a00:1385:b0:6d9:bf50:196e with SMTP id t5-20020a056a00138500b006d9bf50196emr7531070pfg.19.1705970761998;
        Mon, 22 Jan 2024 16:46:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r5-20020aa78b85000000b006dbca81cc36sm5095359pfd.188.2024.01.22.16.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:57 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 29/82] rds: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:04 -0800
Message-Id: <20240123002814.1396804-29-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=keescook@chromium.org;
 h=from:subject; bh=rhiNkfwcsBY8pN0Aj3OX3M7epOQG7vcAhg9hdXLwAek=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgHOI22byaB9aq3JAA27hbl1bc2MNGKba4Qk
 /4yGoiLhCWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 JrEqD/9OlGCVGN2v0bgu7DOOkBDw0dRbBn44WXpE64TTI2iaigc2NjR7rlxLD88o/toMj5HP2e8
 +KNhHHhwpn/78Xvy5Fu7OSRDC9Srz2FSdC3GIXCLEy3jHqWqKwpl8s89sAkiyFxj+oaSSd2hp1Z
 yyDFk5tnp4WFMby/w16JX9RJaUhf0Pac+SlpfX6LIhCtEDu16Ym3Zfy8+niKDzyKzgFnik3iBMB
 VlX0qsJgWtq/F5TyYJsdRkzQJiC6uqDjRDOmIrgGbtONP4N3x7eTO2RPGiq6W6sD6wqCCTfno+I
 TOyJBsebkoEC/gOponWRkhVaYuIKk76Rd+mpLbYKMeJ9sXs4c3jKafZerrydOpptCgnp1tAjfY0
 ubJ/wJ50cALOah3qX7E1BFVlS8g/8Cqst3G86qmJ+jErESB4X+ju8cl4kzQJrDdmKNVd/8RAdsb
 wNPuvNZwa3p4pqL+xtVz52yuC0AAOm1Ac9cbprphOD3okeaOY4R3ObpX9GV0e/990fYjXWl4bXk
 aTpyUseDCo88l0yQhgdSuHpJyQLFga2P8uROjArZRuSEBD9HUQ3LrxEC/e8Ns++bdkQ4Yu2PgDo
 Dty8RA9kx6885engKkChV3U1u51xbiNowBg4oJDE5G4q+gYIHu+fcsm6+5uoTqYHDGNdkR/t2tx b/RZj59k1eBK/EQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: rds-devel@oss.oracle.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/rds/info.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rds/info.c b/net/rds/info.c
index b6b46a8214a0..87b35d07ce04 100644
--- a/net/rds/info.c
+++ b/net/rds/info.c
@@ -163,6 +163,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 	unsigned long nr_pages = 0;
 	unsigned long start;
 	rds_info_func func;
+	unsigned long sum;
 	struct page **pages = NULL;
 	int ret;
 	int len;
@@ -175,7 +176,8 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 
 	/* check for all kinds of wrapping and the like */
 	start = (unsigned long)optval;
-	if (len < 0 || len > INT_MAX - PAGE_SIZE + 1 || start + len < start) {
+	if (len < 0 || len > INT_MAX - PAGE_SIZE + 1 ||
+	    check_add_overflow(start, len, &sum)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -184,7 +186,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 	if (len == 0)
 		goto call_func;
 
-	nr_pages = (PAGE_ALIGN(start + len) - (start & PAGE_MASK))
+	nr_pages = (PAGE_ALIGN(sum) - (start & PAGE_MASK))
 			>> PAGE_SHIFT;
 
 	pages = kmalloc_array(nr_pages, sizeof(struct page *), GFP_KERNEL);
-- 
2.34.1


