Return-Path: <netdev+bounces-247703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9635ACFD9FE
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44AE4305FE22
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020B314A65;
	Wed,  7 Jan 2026 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDkKZdu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A643161B1
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788536; cv=none; b=sc6TamQRTF7CpXjVlhd10NaEdTT0+YJR9nhlGY84qcVrZThKkn7m7Cz89T34iAE/Vb+1mkZ9OE/2joUxgRht2++EzhhEYeArr+8swWCx9RzS8N42JQnFZNJCHwAUsk49g8139DyqhTq+w/W3fAGnO0V5KAcpmyVdMqRRutdKCjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788536; c=relaxed/simple;
	bh=egHdS2hlDtRjrCIJe2FUsvnOl3UfhkoxLjvjeC4YPPM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3wSzkWXKs7cLFd1Jgrz2cgDJufxsLfTQNFkRkE988VWNLnk/Q9cbimysuAck3uOwtxIeGl/8CEqjTvg9qTZqri9dKMrdW2NPUT3s8ktneSUEyIKFYDx6PlioM4dp3NpLNBqI2NCNwaZv1p0cS1s01GsR0koZF+uH/1G0FIBeGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDkKZdu3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775ae77516so21973215e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788533; x=1768393333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8OnKSVJBnBS0jE2Q7tvL94jmLG4UOTIQCS5eTSEBgs=;
        b=GDkKZdu3b6urCFeLFl8AVnk2F4RyCQoEtzQjClc46LE6j8EZohLnnRC3IA+fQixYfN
         eEP6G1EbpdTz24DKGjaCdzmuebFG22VmWHnte2Ryh/SPSS1FNtZlsTf009I8VKCeaHCf
         /vosak+URWbXzKyseXPU4qsrGeDgx3hMJFn8Q+nCkgBopgTqaWSmQb+q8wtmrQZBM5em
         bwWA/usbeAESxf9UdVqF7Nb5LN4IhyxiTb4vGUBNEs6NovQB6JgBs1EZ5mcgENpvGTKE
         9obbt/VxLygCgVcLr3y68l7Enm2xMTN9ticmI2P7RfeUy/avjAMJPiYN4J04bYmX10QC
         bc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788533; x=1768393333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X8OnKSVJBnBS0jE2Q7tvL94jmLG4UOTIQCS5eTSEBgs=;
        b=OvMz0qLYDIpFQSswHhBxMr0EZS9kO5aUupn97+lQiaO3gDwg5K1QGjFQwT5lN6O1i+
         lSIHQMDD7gPLl9+TGTO8Q6nb97gpVv6qy06E3X7aQNLV3gGRoj1GIv/5Ao8xHe6aYG7d
         Xo1gWLMhpkBmb/i7xOtvvGc9ptq4MTXyP6c1r9TV0/wUZz6Ww29v6XlsMn4xPQlxNW3+
         lTQPt5urYi/MFJfjjZ3E4kPD1vLIDTlub/rkFXRt6/uSRK3FMcwUo/uoQ+24exZVpfHG
         9iuNqYfSctwwWzfooIHKTX9xoA4+KSw9eQ8xOL6oAqrIJQQZPdZrEdG0L45Uyvknn0NN
         twsg==
X-Forwarded-Encrypted: i=1; AJvYcCVPJhQBWb5en/b99REXLZy28TdX+5xbXjjpR/sB+qc61XBtIlJywBX8Y2Loeif7nNBajTB6daM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYe3fQRKPWycOALfWaYkTMmavJVSNOR+ba6idSK+qf05Ck1CJ
	M9ZKnDZ5zVWFtMjW7GreH/CjhCyh8StfbMC+o+PDkUrk2V2iqFU2rqDJ
X-Gm-Gg: AY/fxX6fFc1BR1ldPgYCFf8bTvuoRKCBR3+QgHQ2zQXVXZxMgoeXHEZ9QUE5QW4oKfR
	n+8MLUWg+FJlpcPnH4OmXRsvgeybj8a630Jmdz1wp/4IJUp7Mn2WwdgFhk9EJOOs86czKtTwUkp
	Jm+JuR1HgFRaFQwgkouuPxkZhFLlUOV3jZ7YLlcTtoJCMU7uDsr5TD2vGdkrVsvEJJH4SjvZNMl
	E8foYsDqyxMNHArPhCUJGpSh4Hv8gnq0bK0HszszWHmRaalnBllVQ6amJqunibDDxLuoHuer79u
	fimGUBO+P5nKk5bXHiAZ1nSv51UxHoZd1BaE9G388j/FjE9ME2F4HURbxbRGspGIqaU3d3ogj9Q
	SP3BxadnaKmZrmOlyyEIVPsedk+m4T08Wy5OV7zWGYb+N4NKgO6n7wNRenoujjS+XfugOXvxl5l
	8YM7R2MX1XwHCMxP9aZaafJCzOMHBH
X-Google-Smtp-Source: AGHT+IGQ1Nnipuu1ciny2peE5qR8hzMsadwhCVBfjPXFu0Kv0BQH+EWGDvyEMW6fE0ZE/CgPnIcYbQ==
X-Received: by 2002:a05:600c:6306:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-47d84b1a03fmr23913085e9.15.1767788533333;
        Wed, 07 Jan 2026 04:22:13 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:12 -0800 (PST)
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
Subject: [PATCH net-next v1 09/13] tools: ynl: fix pylint issues in ynl_gen_rst
Date: Wed,  7 Jan 2026 12:21:39 +0000
Message-ID: <20260107122143.93810-10-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107122143.93810-1-donald.hunter@gmail.com>
References: <20260107122143.93810-1-donald.hunter@gmail.com>
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


