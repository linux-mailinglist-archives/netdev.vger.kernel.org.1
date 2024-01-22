Return-Path: <netdev+bounces-64853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B83B8374D7
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08031F26772
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB26447F69;
	Mon, 22 Jan 2024 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QuiDbSWd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C947A6D
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957588; cv=none; b=u6O93Kf3SUblIAi1PWMDaxqBar8AEk+Ir0G/pdz5Y2xEpNMaLV04485qVd46+b2slE1tVvF+Si3hchJijR6rBN4pf/DvPTY/Va6YjvY00csoMB9OBetmcOzj1cTdp0X2c44Oo7+Q0ulBA9/fQ5ppoNMkC5dQ2BL5GxwLcFFF2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957588; c=relaxed/simple;
	bh=R5NFm9Vn2Ry+J7lRv8Yxdqvgnal/4a4PhPeLxeyLFzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nVacppFxxVknMn1dVHD5e3qgI+T2917bBiJZHmhYhVJRAyrJQzi/stii20Q7oopC1urVjlWFU7eap0/oXmXYaiAn4cpmvIwDmCZwCS9C3YDHUOr/vs+f6rxBFBbKrIV8EiSkVBE7HcnVN0kN15F1G/QR0qxdw+fmybIUyDczofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QuiDbSWd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so1771619b3a.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 13:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705957585; x=1706562385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTTBUbPLLX22gXQYpGSKcgT+U6sNZgRatKr6dDm48ic=;
        b=QuiDbSWdFlNF/79ek5uPEuK/jbZdk6Nd66WaYy4Yj91tgv2ldOl/bn60OFoKxjOeCD
         3tR0SvxwInGNhI68bz3xt6ViYUCyS0NCWwkESMvyTXWWfzmGYekFYMWY5sXXjNQwrvxl
         FzSvEqCOkjvpf4tf2Jvi+to56+LaNOTvXUil7N+m0c1eTdNbTv8KXaWNKcbB37D68QzY
         bK/x4CiwsTe6rC/uezq+APbTVa++5Y2+AO+WDdGV+4lHji90liLd3+QI5ylr+OsACEnO
         sCXod4ld4XQVt5bRB408bTVLXbOgpKdoofsFZgEOCvcSzL+eUamJc3dqZDVfyC4yUUy+
         0sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705957585; x=1706562385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTTBUbPLLX22gXQYpGSKcgT+U6sNZgRatKr6dDm48ic=;
        b=LjixgrWLIeOu+/BItHxsv7UtU/wCyu3GTTV6hWC3cpPY3zuDEvk++8oKVkmJNpMqJV
         nfu3dvP0S8+KLKTXsZiUHtJtYimwsmAkVysSdQlxBt8X4U/p4+AesOxc2aG5EYFIC6hB
         YOPq3Wsd8vrE/zG0ycQx8WAgFo1HjtJS8SqbIik48+YahnR9W1Xmv3uci+yBDyrYys+1
         sDDAuTKUBr0lgNeZctJ6QbhzalP2XQvaH15waA0HEUw8pmbfE7hcsAQuzc8wFkYypPTp
         eb0SNcDSJp3fPxkfGd7Jick4LtAyBulNIs8pIjfMH2Df2wiK7f3NUuV7p2zZRlcYRn1h
         ujkQ==
X-Gm-Message-State: AOJu0YyxOa4sRMiSjKI/qQHL0M+PLvtmKnAxquWRMKpDdrHTK2/+10Kd
	anH84zUOxKJCCwpDicENGPLWdFJLH4A90K/yqxZKPsUgt63UHMjL7aN20I5Jso3GyBESPu/ybR1
	OGQ==
X-Google-Smtp-Source: AGHT+IF/lChGsMkCgmCg+5aiYMU6Ll6k1FkIn1K+sesuVRKCAa4NlWcTt0lBfdu0U4nYwTig3L8I/g==
X-Received: by 2002:a05:6a00:2d1c:b0:6dd:5cfd:808 with SMTP id fa28-20020a056a002d1c00b006dd5cfd0808mr113127pfb.51.1705957585388;
        Mon, 22 Jan 2024 13:06:25 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id r11-20020a056a00216b00b006dbce4a2136sm4559306pff.142.2024.01.22.13.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:06:25 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH iproute2 2/2] bpf: include libgen.h for basename
Date: Mon, 22 Jan 2024 18:05:46 -0300
Message-Id: <20240122210546.3423784-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122210546.3423784-1-pctammela@mojatatu.com>
References: <20240122210546.3423784-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In musl basename() is only available via libgen.h

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 lib/bpf_legacy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bpf_legacy.c b/lib/bpf_legacy.c
index 844974e9..741eec8d 100644
--- a/lib/bpf_legacy.c
+++ b/lib/bpf_legacy.c
@@ -18,6 +18,7 @@
 #include <stdarg.h>
 #include <limits.h>
 #include <assert.h>
+#include <libgen.h>
 
 #ifdef HAVE_ELF
 #include <libelf.h>
-- 
2.40.1


