Return-Path: <netdev+bounces-114313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA79421BE
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 22:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CE71C23FFA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BD118DF98;
	Tue, 30 Jul 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KffhwAN/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC418DF96
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372083; cv=none; b=Ea8C6Cs7gDf9nvQ3qns6b9ZJy15wVyvxE9wAZ07fj9KrICCGxMG336KlAPSCfKnT9mQGTYHL3h7MlNLz/7rFI7hv5McoeXwMlSy99khrA5hRs4R4hjnVPl4YyQ4lh2gMsz3GBnHc37m+TQNj5xygqPutU+LpcuPCEYZgDVpMrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372083; c=relaxed/simple;
	bh=lx5WVd9G1hKvFp7/Yj+9kGlWw/xamVCJDfw2mYllk+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/DWPAbU3nOORz/6EemP2xhWfhSQnPSmaZ8QkvMT6258Uiv9GstmkmPPQADl/W/Dh7GrTk5YOfBYAFXMuqkIs7+oQVY9RnI+EC/E6L/xFBHRU4PlYZoHOgEbrRVJUJwRa3r8RPRfLGfkAnQT+XeGOBEtpZtCstMs7+eJsV+yKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KffhwAN/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722372081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SpLFYlOxO9M32RKKW1dTizQNscX7YI+e/7F4Va/uOw=;
	b=KffhwAN/FwEZ/g97azWUCZJkwyUGqldXgZzqxBtifAzeEz0DgmmxQbV/jnmiOh056cY2J2
	A1fhP592NEWyY5yK1qLTpWlPjiuJF17EqhIhM69azytzjyqBwMs23mdXGvxj10PXZfpClK
	JS6BvuTvESPOYF+rXM4zYuE31Oi9uBg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-iqoS7o-0PwWLp_PFT00E6A-1; Tue,
 30 Jul 2024 16:41:17 -0400
X-MC-Unique: iqoS7o-0PwWLp_PFT00E6A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFFBD19560A3;
	Tue, 30 Jul 2024 20:41:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 820473000193;
	Tue, 30 Jul 2024 20:41:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH v3 01/12] tools: ynl: lift an assumption about spec file name
Date: Tue, 30 Jul 2024 22:39:44 +0200
Message-ID: <b8573253efb158e9554f82b4bafdaefca06adcf4.1722357745.git.pabeni@redhat.com>
In-Reply-To: <cover.1722357745.git.pabeni@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently the parsing code generator assumes that the yaml
specification file name and the main 'name' attribute carried
inside correspond, that is the field is the c-name representation
of the file basename.

The above assumption held true within the current tree, but will be
hopefully broken soon by the upcoming net shaper specification.
Additionally, it makes the field 'name' itself useless.

Lift the assumption, always computing the generated include file
name from the generated c file name.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/net/ynl/ynl-gen-c.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 51529fabd517..717530bc9c52 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2668,13 +2668,15 @@ def main():
         cw.p('#define ' + hdr_prot)
         cw.nl()
 
+    hdr_file=os.path.basename(args.out_file[:-2]) + ".h"
+
     if args.mode == 'kernel':
         cw.p('#include <net/netlink.h>')
         cw.p('#include <net/genetlink.h>')
         cw.nl()
         if not args.header:
             if args.out_file:
-                cw.p(f'#include "{os.path.basename(args.out_file[:-2])}.h"')
+                cw.p(f'#include "{hdr_file}"')
             cw.nl()
         headers = ['uapi/' + parsed.uapi_header]
         headers += parsed.kernel_family.get('headers', [])
@@ -2686,7 +2688,7 @@ def main():
             if family_contains_bitfield32(parsed):
                 cw.p('#include <linux/netlink.h>')
         else:
-            cw.p(f'#include "{parsed.name}-user.h"')
+            cw.p(f'#include "{hdr_file}"')
             cw.p('#include "ynl.h"')
         headers = [parsed.uapi_header]
     for definition in parsed['definitions']:
-- 
2.45.2


