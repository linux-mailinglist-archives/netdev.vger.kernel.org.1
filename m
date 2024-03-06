Return-Path: <netdev+bounces-78152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62275874380
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3096B21E22
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B021C1CD04;
	Wed,  6 Mar 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKz7np/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306D1CAA8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766657; cv=none; b=sHhOeI5dFTHfUqUXzYlRuJ2ZqZCsZVr3HmLvMwNFCOxahN6OO/ETu2PTLaoeVvxuqq/DEBHvFJ2sha/oftGNWUP8iLds4rvg69yl55UyjqXS1QWq+np44J9YfAiovf/L7ve37ZYdAyr+35qFon3nCaIc60nXvEd8YMr1GSZV+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766657; c=relaxed/simple;
	bh=jZrC7AfrDm2OZGxWir2yHKvxcTBBOS2qgbExbjdp3kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfO6k6STy0fZdzEo56JvDZNUb3c87XDa7UDwNlRVHlRI1mBy6VGzTXU7iRPpvoTevWgWPayEv0tcgedAzHjEu4v9rjCi5+p3Ecn06e3hblLkWA/xKELjZu7h8K8tXCxj1yCGUPc2L4sJ95w4Wne9+DFvej0k99CNzI7Vy5LeQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKz7np/h; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412fe981ef1so1614125e9.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 15:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766654; x=1710371454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAwcvaCdQDvnfiKaCjMf0rpuBeB7Hk/62QhSDffm2p0=;
        b=jKz7np/hgD6PaljUl16JzYE4JQBEn2g5TnOl23pMRqOYAT31L04kuuNDEOFEjEp9jg
         sdeuEp9OBb5qxdeEqsKmhaLGWyQcUk7gEYqkfNTw2w0esOf3lMw4GBg+0lwLbooQL4GI
         Xu4ctIQU73IhLVmvSbdpJMzi4Z85jfsPYmkobdxmzXJSiiRpOqTPWzq/y3RQqdPiv+MV
         2PnfdOgmI4I0iu/4hPN/PzhYIRKSvkE0e8COMkYjrKjekoe2xmSI4Iq8sKYjNa9uo2KI
         ccbd976IABNYRWp0YrrhkEFZ8K+7CTIKQWMYBcWZHS+VSTTrv2rAqJXU8880DdnXXz7Q
         kR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766654; x=1710371454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAwcvaCdQDvnfiKaCjMf0rpuBeB7Hk/62QhSDffm2p0=;
        b=e+7fkWdnQade87QbRpzpoMvt5Bx5a81k+IPLyM6n+Fl/glKDCYD/x4BF7IeoASqkKj
         6j7TfeIL8MBRo88qLiQ5bFozYdDyeR/UoflRa5HwDjpKEq0iFYmwOZ38LduRxYnkJ/Eo
         yllKtyutVfJl50AtSqoXwhbKsWSK4DyoFq5DdHMQi9A2arpYgP9XH9miaK5TDRTRQLeI
         lZtXXWnXvnLhDu2UlmaWbeK7d52158rJTCenmzIp9EnSaeZndDjUYsrhhafojo9G+7Ds
         mZg0u5dkXPyL7UtaXELo8hJILDROfNuq2D2RSCfPB0sh0U/8qLB4iakO5WTsYRlYPpCe
         AOWQ==
X-Gm-Message-State: AOJu0YzO5JP1noOiRc/q6TYjRS8CuyrbVcCVPAUQtdergAY4wXpNRaeG
	brNLRN/effkR+eUWlJAqYPNO1WxjhG/mZRUw1easlqztKO9DGC/bjC6GkfgbuoE=
X-Google-Smtp-Source: AGHT+IFeumxey0ahKkHjqOCoKtRQD/DE48eLSKdaIl+hWb7NfWPJ6KuYpB3MZut0at0m7bNPfCXoRg==
X-Received: by 2002:a05:600c:548b:b0:412:bb48:67da with SMTP id iv11-20020a05600c548b00b00412bb4867damr6730048wmb.0.1709766653869;
        Wed, 06 Mar 2024 15:10:53 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:952f:caa6:b9c0:b4d8])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm18722810wru.112.2024.03.06.15.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:10:53 -0800 (PST)
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
Subject: [PATCH net-next v3 3/6] tools/net/ynl: Fix c codegen for array-nest
Date: Wed,  6 Mar 2024 23:10:43 +0000
Message-ID: <20240306231046.97158-4-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306231046.97158-1-donald.hunter@gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


