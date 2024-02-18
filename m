Return-Path: <netdev+bounces-72785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE96859944
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 21:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3341C20B1F
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 20:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FD96EB78;
	Sun, 18 Feb 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoUX0kco"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1365BDB
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708288875; cv=none; b=KfkhXOd4rqNuLdu11dvGHTBDrJRyfkmNmLJ/rRFhXxkRW3PDYdOiKL+r9PgytjagdF/I6BaRbwSwA4vZNQLXMOw+iyl7iPOsTdVNU2nCKJ1I2At1bvk6wzGejLf+HYrrEQzd0mrbuyaK0Klc9Zrd5VRSJUGccIx9/7nILOpYdR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708288875; c=relaxed/simple;
	bh=VomCIMguIfae0jMC4hNojAGYa2iIv1qvMX2kVJvTBNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A2HI8mHRtRpzTbFFfkrNno5DFswmH86MzLyb7QQJ42yG/d6ygI7pTTNbqALoty1aWNk8HbOUfT5iXcJrk7yeBsQGk+Fbji4pJBjq1lsB1iOAwpnqqEMYvn/hMS8tsgCQOkLmAgGMmS1qHzVcPHY0DMMtSyxVGb03kzySr8qMDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoUX0kco; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eac018059so5340796e87.0
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 12:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708288871; x=1708893671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3H4dvkKp/+4juaV0Ok4MP1DZkQEwym2PH6OcBeCk0GI=;
        b=HoUX0kcohhwhsosrQMQKbcVy3uKYxDk8QKblCXm1UNHpNgxNuH/6/1Q2hJw3EXXoqw
         gDG1SvBzQQJ+612KakaVcNIbJ6I0mh6DbqUuzwKKbGnY0isCFXCJgUZj22p3orveR2qW
         SULysN2TW+GlKRT/mzwHtiiNpGYbss1ACoAWkaXoRavde+/dlGbiicDn570Gz8o7CuUz
         +eXT0Xoi8z6xk6MSdAkH7AaZ6fIvvY/B7XaPvI1U5CGE3SgYWurNtnQU0XtehBTw2q8N
         WUssY3jghe1p39YF9QXWN7644CAMa1WgweNxnp0gYrl5Pc3R4lBgXtBu8spBEqCHoU9x
         qIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708288871; x=1708893671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3H4dvkKp/+4juaV0Ok4MP1DZkQEwym2PH6OcBeCk0GI=;
        b=MqXeTC44sZ5HIQ9CIFar8zKvDd3eCDlp6Qdfq4234obhlOjq/jcoU75m69+3n+d5KL
         FzZTj6LaUP/xJO7pkI4snMt3RKJoeYQZmycE/mGu8Od1ge5XjRd+fxJmKVEKywVVy6J7
         AZNmvZRL4qbNOsDwtv4F4siBQ3C5hMZx87BBFGEoOzUgvtZh9etnN7/LD4mt9ylFSXPG
         4JlrffppKgAQrdUYUvX71j/CKpKk6Fvh/Y8+zn8awwSdcFXmSSiX1cK+BjxU/91S+FS9
         PhZfzRjvzwZN3rBxdsSo19LIhAL+0RY1TlLds+s1JczPa7GkXHTKgoJ3fiIf4IoDlv7A
         onGA==
X-Forwarded-Encrypted: i=1; AJvYcCX1SSI2p9L3vXvEC0TDab/Im/4gZ1PhIMpQHhfws3Vj8bKzj1KejEFgmVSl/awUeuLXt0PTMNo0v4D1yvZIkV0gpm9xVW+m
X-Gm-Message-State: AOJu0YxOc6R7zEdGEfuL2TvZMZALs0/LjeuSV76sg+7Sf/gyA2cIIWIw
	uKIR0/tvGUHphDNEmrRf208tV8ehq1wBR1b/bgSA8W7epbQCUXy8
X-Google-Smtp-Source: AGHT+IGxkWHT+fof7X3ZuAGgzthet/yETgCl2NlyjCwu5JAXLrXZ7rnv06rlQgAFx1GGNJh1YWN+vg==
X-Received: by 2002:a05:6512:220d:b0:512:ac4c:abf7 with SMTP id h13-20020a056512220d00b00512ac4cabf7mr1687985lfu.65.1708288871336;
        Sun, 18 Feb 2024 12:41:11 -0800 (PST)
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651204c900b005119fdbac87sm643711lfq.289.2024.02.18.12.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 12:41:10 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] m_tunnel_key: Add check for result hex2mem()
Date: Sun, 18 Feb 2024 23:40:26 +0300
Message-Id: <20240218204026.7273-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added check for hex2mem() result to report of error
with incorrect args.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tc/m_tunnel_key.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tc/m_tunnel_key.c b/tc/m_tunnel_key.c
index ff699cc8..9bb5c2aa 100644
--- a/tc/m_tunnel_key.c
+++ b/tc/m_tunnel_key.c
@@ -575,7 +575,10 @@ static void tunnel_key_print_geneve_options(struct rtattr *attr)
 		data_len = RTA_PAYLOAD(tb[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_DATA]);
 		hexstring_n2a(RTA_DATA(tb[TCA_TUNNEL_KEY_ENC_OPT_GENEVE_DATA]),
 			      data_len, data, sizeof(data));
-		hex2mem(data, data_r, data_len);
+
+		if (hex2mem(data, data_r, data_len) < 0)
+			invarg("labels mask must be a hex string\n", data);
+
 		offset += data_len + 20;
 		rem -= data_len + 20;
 		i = RTA_DATA(attr) + offset;
-- 
2.30.2


