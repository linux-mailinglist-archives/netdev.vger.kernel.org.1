Return-Path: <netdev+bounces-66884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A38A8415AE
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7CB3B2271C
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C1E4F1FA;
	Mon, 29 Jan 2024 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyaFG3ES"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BC23741;
	Mon, 29 Jan 2024 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567725; cv=none; b=VECsVr0qdfn7Zknny+sek/eIu25n+ayecf3Aw/hL0EmMx+RjnmI+37PE/Qfoin0Zdzs2A6vDtLkYTDrHneGxtBGHC6mCw+P8Vv4MLfRp3g6coOdyiwahsJP35BTQC+hUZiD5jk8WAvRi7/PbJhMQRFHTCq6vCGWmAQd3p3iYszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567725; c=relaxed/simple;
	bh=pnOBYK3Dw5OML6lGYNUMdydJOPAQ8Agj60vUhHWg+7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLxL4yoVhqcxUyBLNxHlKLPV36S6ab48UMuygX9hG8LAH27aICO9os9ml6F+DwUn8VOsmGhEvQeQOeBNbwVOkT33PT/YIhPpgJSJTsoWK/lz+1Lmjm9dgzpAwD4Ct6ThlwToVkUZ3QbNsUdNdVLAJlQp4moPyrHQ0v5Y14lp2sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyaFG3ES; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eec4984acso26169035e9.2;
        Mon, 29 Jan 2024 14:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567722; x=1707172522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9uk4F3L3/3yW82w3MBXJrp38V2fn9DHxZ2lnS7OUfo=;
        b=EyaFG3ESCAJ8lzoJ3G+LuV3ZBPq8LBy5X3M5UFXoS/0/ZbfJwhlrQ+XCxgLVgqZbek
         Mts2dsosWWqVP6ilKIMqCCFl3ageD/3WceaVSm1+W0ALTIoWotSF03Vol4Ds99lx5Gip
         lM1uDDAPNUnd3GDaH6v37k9BS8Ms0NN+C7Mh+6jLKqe/wMhoW96GWNG5pXCx3uinlKvW
         SLBBzGluWA99HBZe9iVcfyW3D80erwzE8v6nHPGgmz8FEgHfD6xgz4icgglNcq0SYVgi
         D7GNpXHCe78G9sSWksYUp4oXFaSq0WzmkyN19XqfQGkbIjJ6x8Mzy3ZD5868tiMOxHGI
         qk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567722; x=1707172522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9uk4F3L3/3yW82w3MBXJrp38V2fn9DHxZ2lnS7OUfo=;
        b=wM8CxPtVleT2yKaUvZ1ULDqBdvh8j+K5uh+875JtQOHpNOrpJCqB527nBT/hA9u9IO
         AAgepI1tVMy0oisg1WVgp4qL0RjAcXBx1GfRS7DGU+tGmMD83/eMmKC0JBzwAAsD6U6V
         HzLLVAPUv7EmwAsYf8zIuQ0pqFnLYuCA/UZcgYVTZJysGqULH4FgCugeE5vWEsqRhwif
         36q5NMVOVeDqd4kfoiAj37lvOD6guoyt0eyAXfeteQWYZZwo4FQ+K1G+KNou15HjjE4F
         GRVHimeQa57KN7n3BAymxa1Ay6vXy7yu3b0e2DJdz2/duZSRpa1JU1Esoo4vLo0lJMo8
         y11g==
X-Gm-Message-State: AOJu0Yz3jFMiVnPZ0kR9VZ45uVyo2P2X884UlOK40teY4fufj/k168j/
	LenvTzS7HiSLDvt8MR150RvtBsinptHsfDKbXq0aOEE3JCXznw3X+bOe+jra0Mc=
X-Google-Smtp-Source: AGHT+IGoKqQgv7ENUuxMM14iQqWmhVlROHpHYbY/JncUrBw2ZQKJeApVPy4FPSgg9iQEmssbdczuDA==
X-Received: by 2002:adf:e603:0:b0:337:6e1b:2e9f with SMTP id p3-20020adfe603000000b003376e1b2e9fmr4503272wrm.20.1706567721865;
        Mon, 29 Jan 2024 14:35:21 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:21 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 01/13] tools/net/ynl: Add --output-json arg to ynl cli
Date: Mon, 29 Jan 2024 22:34:46 +0000
Message-ID: <20240129223458.52046-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240129223458.52046-1-donald.hunter@gmail.com>
References: <20240129223458.52046-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ynl cli currently emits python pretty printed structures which is
hard to consume. Add a new --output-json argument to emit JSON.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 tools/net/ynl/cli.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 2ad9ec0f5545..0f8239979670 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -9,6 +9,15 @@ import time
 from lib import YnlFamily, Netlink
 
 
+class YnlEncoder(json.JSONEncoder):
+    def default(self, obj):
+        if isinstance(obj, bytes):
+            return bytes.hex(obj)
+        if isinstance(obj, set):
+            return list(obj)
+        return json.JSONEncoder.default(self, obj)
+
+
 def main():
     parser = argparse.ArgumentParser(description='YNL CLI sample')
     parser.add_argument('--spec', dest='spec', type=str, required=True)
@@ -28,8 +37,15 @@ def main():
     parser.add_argument('--append', dest='flags', action='append_const',
                         const=Netlink.NLM_F_APPEND)
     parser.add_argument('--process-unknown', action=argparse.BooleanOptionalAction)
+    parser.add_argument('--output-json', action='store_true')
     args = parser.parse_args()
 
+    def output(msg):
+        if args.output_json:
+            print(json.dumps(msg, cls=YnlEncoder))
+        else:
+            pprint.PrettyPrinter().pprint(msg)
+
     if args.no_schema:
         args.schema = ''
 
@@ -47,14 +63,14 @@ def main():
 
     if args.do:
         reply = ynl.do(args.do, attrs, args.flags)
-        pprint.PrettyPrinter().pprint(reply)
+        output(reply)
     if args.dump:
         reply = ynl.dump(args.dump, attrs)
-        pprint.PrettyPrinter().pprint(reply)
+        output(reply)
 
     if args.ntf:
         ynl.check_ntf()
-        pprint.PrettyPrinter().pprint(ynl.async_msg_queue)
+        output(ynl.async_msg_queue)
 
 
 if __name__ == "__main__":
-- 
2.42.0


