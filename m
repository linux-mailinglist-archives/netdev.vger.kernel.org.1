Return-Path: <netdev+bounces-248158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA1DD046FD
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A11430870FF
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999DF243956;
	Thu,  8 Jan 2026 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt2Xo+SG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF442D8370
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888856; cv=none; b=DQm40erkPt2Z0IedA+MVDfOOe8XB7/uiTGPSumnNanR1Yoohk/OwjKdUauahHBRCciIAB1CKmpsTRk/9sf389SA65JRyiLrI5OlxakMpz24lqvWRpvM1FavunKT+kNmHWK+R8OYZNjm87T15zousvxqDPAT76WW/qzMmzXRLsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888856; c=relaxed/simple;
	bh=egHdS2hlDtRjrCIJe2FUsvnOl3UfhkoxLjvjeC4YPPM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDm144ceHA6RixIaAPD/XZ3Ffr67PpniBzGtuomeR87vWSaPUddAWMab2rDCP5H9ilYkpXCm6+1AgWiT9ufCtk5fc9G9aTEuUKhx6cfI7CJ+4d3xayi+34ET85amDkU9cZnKjHAzwmAZhoSSQFXOpeMSCGxLdo0hSgM4bRecAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt2Xo+SG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43277900fb4so989160f8f.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767888853; x=1768493653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8OnKSVJBnBS0jE2Q7tvL94jmLG4UOTIQCS5eTSEBgs=;
        b=Pt2Xo+SGVPyhyacw6mDzWAyyRzLS8Gls7dlxD1Oeo8Ew2Ss7nRXKCd9sXWqvreqHdq
         y8Ek/5XABq3n5cV7RqV34T2Ulcwsq4pay0DsPo6K/T1Sgh3qR6chIBwrMmkWVKHw0df2
         Gl3bEQgEEtkPvm/X4gLXNrOKmhsmgJeR6oVdoY+n5U0zHFt1ico5wyT+4LSpKdxr2ID4
         5S6Fqx9hBE8lc9vKa8e6HSjBeECmcF8R3IRzO9HQ7EKHlC3gr/vPLy+j8hfGrtMJLJ1L
         N/GU+UtX/Z8aZdQyXCrWBAu/8QZz6eAOREZjEArKC0+9RrrHh/9RJm3m3qSn+vWnB1mw
         xpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767888853; x=1768493653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X8OnKSVJBnBS0jE2Q7tvL94jmLG4UOTIQCS5eTSEBgs=;
        b=U3d1oE6qT3NbTRiN4PjA38dfwNhluszGfiVxut6pBsC+NB1D46TO3jNYjSFN3buNzo
         aGlCXvguG9wHrBOYlkSBVSbJNcg/zo9m5hXNRrz0rOSTf0NhfgLlRcQrdcx6wThZBC5E
         Zpuua0K9KJgEBK2RkoNyM8xYyl2yFV/oa7ZXLImJEJvtX8PG1uGJbLRKH/Ll4hazE+9c
         eSpDuyAkB4BFM2iX9lCcHcEKP1UtEJ3XKOP4FpmSquEDVeSWCC47P3zlpZpoWjvKL+Xs
         RwUX1n5yGTFk1z3z0RG8ejasslCkFK3Gc9uliJhi3bPnm1HGI0WCLXibDN+b014lBqPY
         FpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp88w9QK+BQ+9t61Lu0MOzvIB5E7mi26+F4keGq4MGFGBYaINAFiMfnYwUOqYKk2I8Wslxc6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4z8r1RjODYtkRjIARWgSHJB7bqLnUdxSN865XpkxExx1LEIk
	dikzbChykh2saHomtLOoXJiHJQIqhEACVNaallGkt3KFyKLHMhrWv+SO
X-Gm-Gg: AY/fxX5MtzYEUm+kRDgDTnLzm0TZIhnCDw9i33GLiS0k4nBqvjwf8xQbJUkqcOiIBNY
	TTgyQuod10cgcHeCfmvk8N/+JWznYJVspc40vRIJ4cCR8LK1YPiNZ9P1v0Be6ZK9+npYgautQbP
	JicL2rNsT7NCFaDU+N3aRdwOWEaqqtyoeuvg9+7NZIw97qLc4AE48yVDa11lGYWpNoIVEg/tU8T
	3FEdF0JUb70BGynBvyykl9kQax3wsl7jU2XH+1T40rgd1jrE2GCbm1lvOo3N9LbJbC0sSbnMW0q
	zLVG04b93JUHhMeSHMwgfY0LXBt0KhAyHzUVxWSetCXYna4Lp/gmWAKYQO1Nlq8xgj7bWT9Q35q
	1NIF3s+YoAhFYUXTsb1yss5yv/ZikJVrS3yGyBGxyCwNkyM3eQ7uLHkw5RywSgPBjw0y5zafJRY
	AkIOJ8Z7KRphWcYDlmWR8rSy4Mkisz4t19iyWN4KY=
X-Google-Smtp-Source: AGHT+IEzVb2n/kdQE1cAl5q+tY0zJN0E9xSfP2aEPBEIODvU9mWrokpUFfPO767mnnvsfYNycm1RMg==
X-Received: by 2002:a05:6000:25c4:b0:429:cb8b:b58e with SMTP id ffacd0b85a97d-432c3778c36mr9288402f8f.28.1767888852629;
        Thu, 08 Jan 2026 08:14:12 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm17140039f8f.29.2026.01.08.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:14:12 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ruben Wauters <rubenru09@aol.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 09/13] tools: ynl: fix pylint issues in ynl_gen_rst
Date: Thu,  8 Jan 2026 16:13:35 +0000
Message-ID: <20260108161339.29166-10-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108161339.29166-1-donald.hunter@gmail.com>
References: <20260108161339.29166-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a couple of pylint suppressions to ynl_gen_rst.py:

- no-name-in-module,wrong-import-position
- broad-exception-caught

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_rst.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_rst.py b/tools/net/ynl/pyynl/ynl_gen_rst.py
index 90ae19aac89d..30324e2fd682 100755
--- a/tools/net/ynl/pyynl/ynl_gen_rst.py
+++ b/tools/net/ynl/pyynl/ynl_gen_rst.py
@@ -19,6 +19,7 @@ import sys
 import argparse
 import logging
 
+# pylint: disable=no-name-in-module,wrong-import-position
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlDocGenerator    # pylint: disable=C0413
 
@@ -60,6 +61,7 @@ def write_to_rstfile(content: str, filename: str) -> None:
         rst_file.write(content)
 
 
+# pylint: disable=broad-exception-caught
 def main() -> None:
     """Main function that reads the YAML files and generates the RST files"""
 
-- 
2.52.0


