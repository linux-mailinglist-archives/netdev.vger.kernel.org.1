Return-Path: <netdev+bounces-73284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D9685BBF7
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B49A28223B
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F6669968;
	Tue, 20 Feb 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOy4gxPF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337567C70
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431884; cv=none; b=poZl1UUfyELC7TodN/ziKCUvYuRSxMaFYwAcM2Jbzuw0Qga9I0fcRfhSiXnAFkEb5lAQLtI2G0UojSeJfAdAZtdU+ibHZmZ1mHmcAw5x3AGPZFssDbAm+iTmi4pGYmkkZ0d6sOrHLX0/AEbJZtMG/ga4BMQDAVwjG9bMAAZLqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431884; c=relaxed/simple;
	bh=ynvPVYn//v4GPuorcOO+1zz4hDvB7L6MwFHXwoZCmeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxi9btMJYvATbm1uRnd3HqyGkiHP/cGdZbOHIWgPv1B2A+hAxrzuLSvX/zmhFMrpE4sXmh3KXMXZGnp1e39DFQJC5TVqP7cwqpgLPj3YZxg0dlb3zNnnGDOKJA+OCDI2maD8vWjmKMOen6LZdBrpLl7jbQq+vV4H0OiCli7ByBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DOy4gxPF; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563fe793e1cso5143699a12.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 04:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708431881; x=1709036681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wYvXLfZ6v2cXKlzxrKeYwgODilmxfLPWWmiWnqKj1Q=;
        b=DOy4gxPF9djF7LLq407JsHDdwTPUqL9eYa9JW8aFMCbgJeAkrgFKVXjiMoKEWvOJmh
         hCf/FukbDN0MiJvl3qOnDPdd9rc0lzIPiodCSHBU4e7u2AIRswVM+OsLkRiUM2mZ/06Q
         Ka0N54UrS5fwgU91ACHByeDximMqDaV8vtWuor5+6UjXzIM1o1jk5kBshN0R3gruhHxu
         C2/71BsYWY7YJPtJbIX0xIBMduJn1n0XimhJvQVlEI8908c0Rc49bgqwZKDekSZ0URmI
         rRkiIh8pRidaysIpo0LITsGZe0jg7VdytB5m501l1ImWXFzG4FMUgHnOJ6xGKCWsaARt
         xLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431881; x=1709036681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wYvXLfZ6v2cXKlzxrKeYwgODilmxfLPWWmiWnqKj1Q=;
        b=nRny2lMfLuqTVsbnv/NMlhRNPH4RF4neqH8WM35fsx67L5NUQ6Q6H8C75BGxEyCDC9
         da3WCbSC6zo1yQxtRCjpbQQg2WsdTzrpv/OKfHtC78LGFp2mJTfvcyEO4zI104eRa1Bb
         bG23Q1P7eVi2yWndhRyqmkz1VIWxwqOLSDhiJmFDelpICwikLVaETQpXKfTH1t+ByEkv
         gTXWGR+SeajoO5tIvXE+VsdKYS3jqgCT3syU8JFOTygQvAFnYOgjA5oCddm/JvmaI5iX
         m8TvAJqH+F133yHdTCP0MRaAeei10Wh5l5v7by/yhicw/L4l6hdT+oMzmKlI7YCv2MHy
         806A==
X-Gm-Message-State: AOJu0YwVOcxzR0DCQ1zPdPUp9hk/SH2m9AqMEJNh/smhvbkQebBkEN7o
	pLAgeCMqmgWmkOAF/wBaIfTyYTDZ0RU3INPcwU1QD66zzxS0pFwPSaEIhUH3ksE=
X-Google-Smtp-Source: AGHT+IElMje6XxucxdmJxoNwAgbzbb9WjAtnDF9oo2/9GaChU0TCt4nLOgnR4cQGPwiVT/NrFsrhcQ==
X-Received: by 2002:a05:6402:148d:b0:564:901b:edee with SMTP id e13-20020a056402148d00b00564901bedeemr3107766edv.25.1708431880731;
        Tue, 20 Feb 2024 04:24:40 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-74-232.as13285.net. [92.18.74.232])
        by smtp.gmail.com with ESMTPSA id l8-20020a056402028800b00564427855b5sm2719852edv.44.2024.02.20.04.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:24:40 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH] tipc: fixup kerneldoc comment for struct tipc_node
Date: Tue, 20 Feb 2024 12:24:36 +0000
Message-ID: <20240220122436.485112-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following warnings

linux/net/tipc/node.c:150: warning: Excess struct member 'inputq' description in 'tipc_node'
linux/net/tipc/node.c:150: warning: Excess struct member 'namedq' description in 'tipc_node'

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 net/tipc/node.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 3105abe97bb9..c1e890a82434 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -86,8 +86,6 @@ struct tipc_bclink_entry {
  * @lock: rwlock governing access to structure
  * @net: the applicable net namespace
  * @hash: links to adjacent nodes in unsorted hash chain
- * @inputq: pointer to input queue containing messages for msg event
- * @namedq: pointer to name table input queue with name table messages
  * @active_links: bearer ids of active links, used as index into links[] array
  * @links: array containing references to all links to node
  * @bc_entry: broadcast link entry
-- 
2.44.0.rc0.258.g7320e95886-goog


