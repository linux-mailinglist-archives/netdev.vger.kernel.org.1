Return-Path: <netdev+bounces-77912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B141A873723
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CBF1C212D8
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD58131726;
	Wed,  6 Mar 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClBLBASr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4697130AFC
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729835; cv=none; b=vFBqgc5iPf7jiNvnDehaGboy/1D6btqHATN9wIYUWfVUSzfqpsZhT5cs7N3auzFkbVs6cjZDk2DbsT9TKhr2WMOAuAw+sJU0VP75fEkXnwBDNBW5UlSO6EIjSRN+olgGd0y3Rz6IDDsHJR3jdWM5qHb1/ZvDd9W2GoJJGJ0Y1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729835; c=relaxed/simple;
	bh=mg/UZ10lUIJR6L8vBorKVPxjtr0FBSGdxnD0GdZmyn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQDIvPfFfin4OhiN+8SqnPcTk5qiu1TICHurPWwhIfRUbWipL4tbymvCgDQSfMK10dKW+hen8ZSEzTWjwSAo010LuUQT6I3O+rU3qzbeI5l/YwMC4gtuMQ/AgCzaMwZI/yYSpLeXLLWE82yxRlF2AY9hXvw+Chg/8ajzlZRHCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClBLBASr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412fe981ef1so1228555e9.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 04:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709729832; x=1710334632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rByjwE896DjP1LtWWLouiY+4s6xLQ7nyieKzDD4yd3c=;
        b=ClBLBASr24WlUvPqBfS+Gc5bnQ/AcsuX1s1ygHs50NyB1qCfFlhGWO4lH7ZHgt6B/Z
         +o946f12BOMTC8XotCy+L1mFby1NyNkb6YcELHmUv65sIBJfTne6zSjPM420H+aVmRir
         LCwaPIAEumZ0CtZtXzWUZm0yE1JTrMPttECtfemcRVUNgjftVhV9Afz12XmCyuAqn0js
         l7niUXS26DjSp/OuEW5Yu14TAiyNhPsJlL7faQA8BMyezAnxC5iE55T4eCNYLVsZur56
         /loY7QAZaaCDk5t7zrOUH9TM9MfpBQqU7+ezsUIenbAG4+e+9HY5pgTzrcZWdjfRrYqM
         8Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729832; x=1710334632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rByjwE896DjP1LtWWLouiY+4s6xLQ7nyieKzDD4yd3c=;
        b=sNgbhNTNQYvoKjna24V32brv9xGsWnU308OsMnnqI887cC9fApDxB7QE5gA9SeJVqB
         tW2a75Hd0PxUz9Is5DxjPVkOrI8kmDYt0Vn3o2WRqVWC+s10oci4/CA7wbt03MX/XbGl
         XIBsyLJO2+MMEo+tp69mwpxaLB/KVqH2Jjju0DfvZ+uYalKHwePSw+L8jteE0ecJ8ShE
         xFtDat2UTchrwdui1eXENWbZdfrwsJezEnhHkPxeLLjnwEl/dzCWLpDMejawDfmVZiAH
         9dyxVk1N19KLnbYOemoLjW5iZcCPhey5WC/HzdQpJexi2UZ7YhINE5TlMqwJONyop3av
         OECg==
X-Gm-Message-State: AOJu0YxA2Z7cUHjTw1tuhOxgfBskUlMuIrS9UnOFzKQyu/XX8G7yqXqC
	m0QEtfdn3OTj2+nlPuvrNKzi8f0ni8NQ4qcLpth2USUEHGcxHcpkdaG1KdlpyKA=
X-Google-Smtp-Source: AGHT+IFigH0qeQs0sVpVQbaCNzTRLdRn7gJmt6uK9+GhhEq1V53oTwY3bs31MlOxsExstCfCBQ5QPg==
X-Received: by 2002:a05:600c:4e4f:b0:412:b02d:71f9 with SMTP id e15-20020a05600c4e4f00b00412b02d71f9mr5136952wmq.2.1709729831711;
        Wed, 06 Mar 2024 04:57:11 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:503c:e93d:cfcc:281b])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b00412b6fbb9b5sm11857279wmq.8.2024.03.06.04.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:57:10 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 3/5] tools/net/ynl: Fix c codegen for array-nest
Date: Wed,  6 Mar 2024 12:57:02 +0000
Message-ID: <20240306125704.63934-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306125704.63934-1-donald.hunter@gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ynl-gen-c generates e.g. 'calloc(mcast_groups, sizeof(*dst->mcast_groups))'
for array-nest attrs when it should be 'n_mcast_groups'.

Add a 'n_' prefix in the generated code for array-nests.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 2f5febfe66a1..67bfaff05154 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1667,7 +1667,7 @@ def _multi_parse(ri, struct, init_lines, local_vars):
         aspec = struct[anest]
 
         ri.cw.block_start(line=f"if (n_{aspec.c_name})")
-        ri.cw.p(f"dst->{aspec.c_name} = calloc({aspec.c_name}, sizeof(*dst->{aspec.c_name}));")
+        ri.cw.p(f"dst->{aspec.c_name} = calloc(n_{aspec.c_name}, sizeof(*dst->{aspec.c_name}));")
         ri.cw.p(f"dst->n_{aspec.c_name} = n_{aspec.c_name};")
         ri.cw.p('i = 0;')
         ri.cw.p(f"parg.rsp_policy = &{aspec.nested_render_name}_nest;")
-- 
2.42.0


