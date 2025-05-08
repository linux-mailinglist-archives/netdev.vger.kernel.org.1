Return-Path: <netdev+bounces-188874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08673AAF1DD
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 05:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3A47A19BB
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6120C001;
	Thu,  8 May 2025 03:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0oA4O+9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40552209F5A
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 03:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746676468; cv=none; b=hvuRw8eJW5fnUTAIZ0GNlQu4DJ2IBnTGk2dMmHNDc0yrXCnOh6/TTunb2Is4/gSFKcL5nEIYOVr4+PTrO6lmQqWH/fdeBjkfKtiHk0LbtoJaC84iHHrOM6S2Lt66g2U2wCm1mS02PUsr43JnmteVklWLQ3np2dPy+U3aNRDaT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746676468; c=relaxed/simple;
	bh=skHzgM/7c75Ruzix+mEMJv2NqsKbzgRGxpHXVwpf3+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpbXnVZT4dOmhmFHP4SSxxnfxOMBmtTOOYOY35l8lNUNUnJLSMLAVHBbQBPfxHf9ohLWVKPJBtsDp3YAZaqpzeUDy29kq6yKFEAgc5huvOg4uqkNngOh4+YZy9jhoLk58hOleCC6dpzG0a4p0FQbMy4XXk9k7TulvMWARnw8Tig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0oA4O+9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so460805b3a.3
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 20:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746676466; x=1747281266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPQjNoEdFRjH1TgxloW1ZEdG+HasLwfJBstlDbhPTK8=;
        b=S0oA4O+97pV3RwkZKVYKNGgpMatkSKJAvAiFlG2khpWyBSw7fuln7f3NzM0S/fChxm
         r4uJoDT6z+YgowPNgdUPyXrHn9sybtWWvw5U3ab3zG8EUvLzlSLS5qAXB5qLupjZ5iQS
         EZGLy+M2Y4VFyoek1KjAXtY+jB4/vYG9E0JslhLpl7wyw5mLmg/kuweXbWKWsHfTUncQ
         8zFfEB/2iQ4dZAJlJt6pW7DiQn+foaOeJDPF8Y+pi38e20rvOIqi7Hh6PUPYSy4shN9/
         W9lxq/tnhZjk+OUc4HphYHIzsSNj7voJIju+UFHccX7oNWwH5xxB7AiPLhlws/xsxwn3
         d09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746676466; x=1747281266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPQjNoEdFRjH1TgxloW1ZEdG+HasLwfJBstlDbhPTK8=;
        b=MsUCm+MRlFyGbr5ms9bzTKQeurbBBFOHWfQm5JUzeXpILxZANdI3DoPaYYi09UbAs8
         lVChBLo98Z8DptgwuERorVKbXxVCXdqSXZQds74LipzW4Nq58W92DpbG8Z6vgKFvb7ZH
         Imbz7YIFg8VUHhUvQafScHzGcwnVUe4OZ1wpF8BU3QwxPAIE97pK2rHy2ymQl7bJ8Oi8
         rFtedTsculOSlCfi0bCqbXTL60p76JwFB1J5mV9wJ8Onc4B4kHao5sL/zqBfZmYlRveY
         uOhiD0HLklTKqCVkNNrLQoQTJ8oaprwYTQEpn4DyoUOJViM8aQZh205RAGNiZdZ+FCDZ
         zyYg==
X-Gm-Message-State: AOJu0YxKhEvNj605jFZLwH/e7aRpJWcU2/DR9uVx4ImEb/soYrkA8rDj
	OktIQYqsIemIokRVJ8WY+SrHOauHIG2Io49opay5NwawFWErbBhHzC1tbzu9+6U=
X-Gm-Gg: ASbGnct0gRL7daD8QahKDk5kr1sP5ceocl7vsLdIRGtvm1bkXi8ItdJMTZ8McYUxd40
	8hrh5h2sI/xVTi1+s0Xgz0KiyPgP3RbKWmqOThpHEZffYvI0+YkBv1K2kA8BdsrNv2LIOr2GGA1
	tkruIXyKEWGaKNvfMXu80kCGGOIljkEFvdBA8XNHjIfl+A13i2TFZoAxUwZ0betMCxI4hvxymA7
	rANhbCPa7ANsyOfUsNRrY9NpAYV0V7vutQ1fqCXs5tLHY0ryWYLTz61YIQbEtK/c8Jfzj/T8IRO
	QY8IMD7iO69kxrxLJsv4oo3PSaVXaPsEMsUfm99uyytvgTZHX+M+ECd4CrHkQnkppzT04wo=
X-Google-Smtp-Source: AGHT+IHp4svkr0d509aCOCAP+I86eSbN0OeA+/CXW4ZoecHrUK2iq+/VooIl+TvIzHkvKyUfpRR3aQ==
X-Received: by 2002:a05:6a21:3a4b:b0:1ee:e46d:58a2 with SMTP id adf61e73a8af0-2148b42d38fmr9637293637.3.1746676466182;
        Wed, 07 May 2025 20:54:26 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405905d10bsm12118630b3a.124.2025.05.07.20.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 20:54:25 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] tools/net/ynl: ethtool: fix crash when Hardware Clock info is missing
Date: Thu,  8 May 2025 03:54:14 +0000
Message-ID: <20250508035414.82974-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a crash in the ethtool YNL implementation when Hardware Clock information
is not present in the response. This ensures graceful handling of devices or
drivers that do not provide this optional field. e.g.

  Traceback (most recent call last):
    File "/net/tools/net/ynl/pyynl/./ethtool.py", line 438, in <module>
      main()
      ~~~~^^
    File "/net/tools/net/ynl/pyynl/./ethtool.py", line 341, in main
      print(f'PTP Hardware Clock: {tsinfo["phc-index"]}')
                                   ~~~~~~^^^^^^^^^^^^^
  KeyError: 'phc-index'

Fixes: f3d07b02b2b8 ("tools: ynl: ethtool testing tool")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/pyynl/ethtool.py | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
index af7fddd7b085..cab6b576c876 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/pyynl/ethtool.py
@@ -338,16 +338,24 @@ def main():
         print('Capabilities:')
         [print(f'\t{v}') for v in bits_to_dict(tsinfo['timestamping'])]
 
-        print(f'PTP Hardware Clock: {tsinfo["phc-index"]}')
+        print(f'PTP Hardware Clock: {tsinfo.get("phc-index", "none")}')
 
-        print('Hardware Transmit Timestamp Modes:')
-        [print(f'\t{v}') for v in bits_to_dict(tsinfo['tx-types'])]
+        if 'tx-types' in tsinfo:
+            print('Hardware Transmit Timestamp Modes:')
+            [print(f'\t{v}') for v in bits_to_dict(tsinfo['tx-types'])]
+        else:
+            print('Hardware Transmit Timestamp Modes: none')
+
+        if 'rx-filters' in tsinfo:
+            print('Hardware Receive Filter Modes:')
+            [print(f'\t{v}') for v in bits_to_dict(tsinfo['rx-filters'])]
+        else:
+            print('Hardware Receive Filter Modes: none')
 
-        print('Hardware Receive Filter Modes:')
-        [print(f'\t{v}') for v in bits_to_dict(tsinfo['rx-filters'])]
+        if 'stats' in tsinfo and tsinfo['stats']:
+            print('Statistics:')
+            [print(f'\t{k}: {v}') for k, v in tsinfo['stats'].items()]
 
-        print('Statistics:')
-        [print(f'\t{k}: {v}') for k, v in tsinfo['stats'].items()]
         return
 
     print(f'Settings for {args.device}:')
-- 
2.46.0


