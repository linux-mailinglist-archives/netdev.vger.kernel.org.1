Return-Path: <netdev+bounces-157435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E07A0A479
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 16:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24B83AA3D3
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FBB1B0F01;
	Sat, 11 Jan 2025 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2dgx0bX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2911ACEB0
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736610497; cv=none; b=XyGW57jM+5qZIG3znpxcQnNAP16vky4LmA4Vn7EUFKV2NU2WA7/2ou2arHXT2y+L52pOl48GgRt/wZ5Nq9fh9NEXjQuyQuVyjzjlCjzFMSepsJ68ySL5FpwvWgQW5LL+UD8y3nMHBYDo1wTCBEvHVYOM8xBUsIXWe4Cu9qbfS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736610497; c=relaxed/simple;
	bh=+ZLKx2IeRlFKh80f8rjv1k/BRxDWjc3gNwtDVR92nI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDvcGru54Ielj0yDf80bOR6C+TmKfNCzIOpNAb6O+HA7EEfMOZHFvGpWBR+B8e5oH8NGprcPzW96tr7LkG92u+wSHEHPorqglVS8Q7arHZVu5nUXHd4hIfWlj5kua64C4v7TclHD9c9WC4/D4/v+5Z2/lHvnIstltlvWCsHb0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2dgx0bX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so1669842f8f.0
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 07:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736610494; x=1737215294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5FAHsUtIK0VZx570aOEfq5neBCfzKDo99gX3/2dnDs=;
        b=M2dgx0bXxFvIv7bTAC/859JEtYquaB7//EgVrZu6+YkpXnDwngv0httgkSgVSqA31l
         M7yoITJiqBak3N2hz99JzeXn5N0pWP1K+t0Y4RaAUc/4BS+pn8YlamQR0ZaZbCJ6ApSU
         Qd9ir234sW/FUFpiHy9/Q9T5l2GCGEqd8gwTn83WoIGP54Y6+thSlMYp5XbkWBXTgqMi
         I9UVW8PMcI5lnuikGxAfStgmhER/s4tU1ipy+jJs347w6HR8kGkU5VbvfgPOmPGd+R0o
         FLEQw2VWswO6KwALINvPXxL1ugryBQszO+fH6X6siv0IJVCgqofR2gu564+O/8hByMOm
         gOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736610494; x=1737215294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5FAHsUtIK0VZx570aOEfq5neBCfzKDo99gX3/2dnDs=;
        b=O63oY7KvFeLN4UxGiiH136fWtCw5twOUKwVflUxME0vxXrXiFhXYNlE+KW5obxFDta
         Dlds/ITCagEutGYoZVnMjQcbI+DegM7pLjUZZ3naNKkiqDg2ERxUCh8bLhSkvSiIkXb0
         y9NwqZsuvYTU9Z+8GPnsgm2t+wkfwQ2t+JdKXqUfa8xEJd1dqaiBjkHHZ0i/f+AQESfH
         S21YEzgT3VSuC1sw3BU+55wTC1SbxdyKKGUkUkWJxikanZRwZz7jmHBZBlVYmfAz8jmv
         RRqQzzrQSA9GuzC0jq1W4PH9jC4IoOvLFPeHeoN5I2krl6PsmloTTDzqg0MTvsZazvMc
         Y3PA==
X-Gm-Message-State: AOJu0Yzf8TcqtOM5bzirjRFRu64xUPPSOrF+h3+WINaAjrubZy7Ul4Yo
	SID77fI5XY3aCnOvswURQoTHoDxPjjnug0Lh/IbYPGDXtEbptSNC6WWDzQ==
X-Gm-Gg: ASbGncuX6tCyYkMeD8gZ2zvUPpFaqgg7m0+5mbm3NrwgG7k2qjODdUB/zwIorJkSEog
	j9fL2YXXRhqTiOh7rU18sHbRPT55tyUtE6gH3fw2kJRnY6D8PMHYd5+aFgkJINHuorzjKLSPTht
	L6YNne33BgKXnVmUvFIoQ+Pl1u52DsXbPfolOa9/MF3HM/WgUVLY9KEOddpNghBYpefH1RJ42Wg
	c3Ojgpu8A5svqKbLdvllrmKS+WyFHL4CllwmoScIaNfHj6m1IlQ2h26+R37l+brUrrj1w68SA==
X-Google-Smtp-Source: AGHT+IEzFADLjaEFAdYkXiFfsPIz3KM0o41EVQXqwU80rMuJysf6a/FnJZvjL688+igQd2m53LUg7Q==
X-Received: by 2002:a05:6000:1f85:b0:38a:418e:bee with SMTP id ffacd0b85a97d-38a87336d5cmr11878247f8f.42.1736610494069;
        Sat, 11 Jan 2025 07:48:14 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:5ca1:6cf:d2e5:5941])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e62116sm85083245e9.35.2025.01.11.07.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 07:48:12 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 2/2] tools/net/ynl: ethtool: support spec load from install location
Date: Sat, 11 Jan 2025 15:48:03 +0000
Message-ID: <20250111154803.7496-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250111154803.7496-1-donald.hunter@gmail.com>
References: <20250111154803.7496-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hard-coded paths for spec and schema with lookup functions so
that ethtool.py will work in-tree or when installed.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ethtool.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/pyynl/ethtool.py
index ebb0a11f67bf..af7fddd7b085 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/pyynl/ethtool.py
@@ -11,6 +11,7 @@ import os
 
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlFamily
+from cli import schema_dir, spec_dir
 
 def args_to_req(ynl, op_name, args, req):
     """
@@ -156,10 +157,8 @@ def main():
     args = parser.parse_args()
 
     script_abs_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
-    spec = os.path.join(script_abs_dir,
-                        '../../../Documentation/netlink/specs/ethtool.yaml')
-    schema = os.path.join(script_abs_dir,
-                          '../../../Documentation/netlink/genetlink-legacy.yaml')
+    spec = os.path.join(spec_dir(), 'ethtool.yaml')
+    schema = os.path.join(schema_dir(), 'genetlink-legacy.yaml')
 
     ynl = YnlFamily(spec, schema)
 
-- 
2.47.1


