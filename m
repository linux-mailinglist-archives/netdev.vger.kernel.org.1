Return-Path: <netdev+bounces-65103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A155F839431
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434D71F275B1
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17856166E;
	Tue, 23 Jan 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+YQB/a+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C536612FA;
	Tue, 23 Jan 2024 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025950; cv=none; b=Qv/dEc9qLSp7UcmDGvnWVepweaj1uRipzllCF5cgbV4TXhqPKccV6FHmwwG/Uu0yh5D+PByuaLREfxwCd0bDGz7wglkjbqOAX7DuZWM99cZtQx5etYLfLAyI2ja34CIPvPCtq8kyYD5onf4W4Bj2VTmqN2frS0toRZdUV4QTjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025950; c=relaxed/simple;
	bh=yWpCLzZbzVzuWXL/mj6oIkzz72O4S3+Cmw8etxhgQ84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB221v677y7d4UR1MXld06XAy2z6iwal2ENOTfeuWyHWiDQYNQoVCm+Uf4TKIEXrJ2oiX8zPRqnDdKOGjnBlysOraJPkcGXsu1HY7E9WV3TDnXrhvRWQKQ8h+mED7VMh9kft3GtKGkE8DM4YdliJboqXHPXgto0I85t3ysJOQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+YQB/a+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337b8da1f49so3991880f8f.0;
        Tue, 23 Jan 2024 08:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706025946; x=1706630746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YrGD4aatZXX/E7lPRaB1ID2sz5ALtn3xMWSx/R9VMo=;
        b=E+YQB/a+BrNsiDGk71d5KU2rHc/hKRDWUax45oyxz7YB5VIYgf+yhoRUYEcWft8yW+
         z8Qgw2aBDA3G5cZ7v+QbNCu7oYMFpgraH5uVpw3nO4H3mG/6ZeQ6I/cUvXiXllqYRYAP
         RilZSshzKMdbc2q6ciCIPKU0wRl4MkruA9x9GHITCrS9Vuj6OHUqWGn+jr8h8fLHm+mV
         PEQAIkuOEcicWFE1Zpgw0AKwS82StYXMrCdsPAkh6cNUgRqBIPw1NUtlK0+lJ9oZAZep
         glBCOFb5kWBCDe7jXKXs2F2AFyPeQ6PmYOyxDCsK95HmQotAhrf7mEu+7ekSZbQwS1q8
         HNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025946; x=1706630746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YrGD4aatZXX/E7lPRaB1ID2sz5ALtn3xMWSx/R9VMo=;
        b=Kb7soSwG7UUCIPXT4e2985MwNbv4MQHpo11xZPfqazxqhzNTHXOWdZgAvoctMsULtz
         Yii8yR88//fXhp7IrRB6psTSbFaWTX1W2aIKJvt+wJ1+6Anq7OAbfrPsHSMWLfCyU7WP
         02DWWevTb1ycZuEyO8bDEJYJLlScUFrcYjvVUMvl8yDAQ8E/dUsvvTVSoIhluMzgZN5Z
         ioaELWabk5/uzpAAdfDuqu2ZYrDe7rO1V/STRnWLEe+HUg1vh748Q5+bNRqFLVw8neln
         8yxnmi0pIvK6imltAn7T9dtb3Ug4V6dg3jqbUSLT3u8kXFkoKEQ2LyTaD8ELWSg5+Ml7
         Hu6w==
X-Gm-Message-State: AOJu0Yw4SX+K8rd95vAH2ap5xZ47lz6H43tdKZg1/5eyOnPJO1GPS0T8
	hxaj1JKwUiJaujJDG+MiXl0pnlE36bL26gIO7OHvTqivDbyBAhl2k/kO6OFLQD6VFgR8
X-Google-Smtp-Source: AGHT+IFZJAYE5pDo1GTKT1FjL4gsHuQUK3EIJblx8pyM1wEVLN1In2WTJPOE5R7NScPk74A2XLxqXA==
X-Received: by 2002:adf:a39b:0:b0:337:c031:76fc with SMTP id l27-20020adfa39b000000b00337c03176fcmr2617859wrb.137.1706025945722;
        Tue, 23 Jan 2024 08:05:45 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b949:92c4:6118:e3b1])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d42c4000000b003392c3141absm8123830wrr.1.2024.01.23.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:05:43 -0800 (PST)
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
Subject: [PATCH net-next v1 01/12] tools/net/ynl: Add --output-json arg to ynl cli
Date: Tue, 23 Jan 2024 16:05:27 +0000
Message-ID: <20240123160538.172-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240123160538.172-1-donald.hunter@gmail.com>
References: <20240123160538.172-1-donald.hunter@gmail.com>
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


