Return-Path: <netdev+bounces-81878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D888B78C
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0072C52CB
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4174128392;
	Tue, 26 Mar 2024 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/nV8T0v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66A127B5C
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 02:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421046; cv=none; b=kaO7BU4wWDpxoXtDsDYe+xllY6o5XblCSyq9bl3e+WuA5p9CS7L2hkOooIABxp+vr9mIlCluSZHKItkbWIx+YIaN0n86yuc5zDbS1YSnj/7C2X83Dq0chGg/oTqmTeZauCC2Afv7EmTVtjBPWd+qLG9BS61WkMmIDzlhDcwbVrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421046; c=relaxed/simple;
	bh=JwyhqOUuKZOKFrfvgVM61vIBAoulNElhELpcyYx5DOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qT3Doml+25Hy+Nhn9Q/L4jsPljArOyd3ZtnUOnDVCZrMj8Y0Bjy9FSLoaaxq0i9+hO/RS9KbjF+kKSv7mY4SjPUyamF5UpDuuHzOCuMbZYBUQlbLH3xYYVbbbNv2zTvtEWbAuvz0nYs6+wQX8xaZoLx17uCQ84+rFbQLMtcHe3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/nV8T0v; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ea9a616cc4so1581551b3a.1
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711421044; x=1712025844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DT99lkvQe8eUKR0KyLaQdNX0xa+XAlT3VwCE95rFMzA=;
        b=f/nV8T0vQVuqdzv+6r42AGJL88to3HCg6KCorty8VEeyRANiS/qh/z+6yWZVCPEN1n
         Jp3q0GM1T+POJ1UhNhaOTL9DL0rEvaIzCWyn40qutaA7BYGMt9hN7m2FqKBCp/Sh1FhK
         a1ye0fQOatk7LnCPeqp0BsjJ51jtocUePNYthCe3cYaYJ93Nkr59dTFL/iKGN/sK/v9U
         Bj50q20J+x9JC2ygRXTq4H6DFTGPmuqZkVUA9e5fCv2zFI8oGrHxGiQrNNQQKB5sXTlg
         Ltgl1oVyukI1LZWDwqOkzIvrpoKBsQvDUxgRc9K9b9l0teufSpjuB6zgTIGVKCzzAj7+
         js8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711421044; x=1712025844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DT99lkvQe8eUKR0KyLaQdNX0xa+XAlT3VwCE95rFMzA=;
        b=RNE7jpS/j40vppa0ZoUOiPD4IjFM45aeaHda9p6rGBXVRxY6rQh1+60yO0ljTjsvaj
         5ZKYdRiVY7Ur4297RYg2AoUoeKpDV3OAlN1nvo/EzYLvuP2nuQEMecBuPGrFoLM2f3QG
         jAHmxTGmAyH0iyQIvWvaezz5dSDK/2mveEX8ezGh5wkcBYdHR+D+PiXClZ4cQDvPyNcy
         Q0La3vYoT+Iohbtkiclx03b12TgNpJwCDo853jYRSdsE/LBwkGxM7zsQvp9E4cv8+YKP
         F5bNBT0TMf1j/z7f44npVze8etWV8HhlXrU64xMYqPEUbaWlgV9jDPd3YZP245YA43n4
         YCwA==
X-Gm-Message-State: AOJu0Yxozn9w2rJ0zOPqH79EYeaYspb4c2eWru+Iaoo+OFZbSljRczYR
	Ulk/ePqt3DjEmfkagBP3YIHcPQOZPE5+XhFOO5282fNnFydqlwu9s6Tyiyi5jlM4A3od
X-Google-Smtp-Source: AGHT+IEeJ+29GT5Ws5NPCaFzubOAjBYhYI7l1ySTY3N36t0QhJpw/0mpHzuXagHKSffQ/ZEJWfyHYQ==
X-Received: by 2002:a05:6a20:92a9:b0:1a3:5fb7:42b5 with SMTP id q41-20020a056a2092a900b001a35fb742b5mr7308779pzg.16.1711421044265;
        Mon, 25 Mar 2024 19:44:04 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001def088c036sm5499193plg.19.2024.03.25.19.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 19:44:03 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/2] ynl: support hex display_hint for integer
Date: Tue, 26 Mar 2024 10:43:24 +0800
Message-ID: <20240326024325.2008639-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326024325.2008639-1-liuhangbin@gmail.com>
References: <20240326024325.2008639-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some times it would be convenient to read the integer as hex, like
mask values.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 5fa7957f6e0f..e73b027c5624 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -819,7 +819,10 @@ class YnlFamily(SpecFamily):
         if display_hint == 'mac':
             formatted = ':'.join('%02x' % b for b in raw)
         elif display_hint == 'hex':
-            formatted = bytes.hex(raw, ' ')
+            if isinstance(raw, int):
+                formatted = hex(raw)
+            else:
+                formatted = bytes.hex(raw, ' ')
         elif display_hint in [ 'ipv4', 'ipv6' ]:
             formatted = format(ipaddress.ip_address(raw))
         elif display_hint == 'uuid':
-- 
2.43.0


