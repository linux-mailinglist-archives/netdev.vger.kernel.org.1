Return-Path: <netdev+bounces-120239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B43958ACE
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C021C218FD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BFC191F60;
	Tue, 20 Aug 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2M4n2kR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CA36B
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166781; cv=none; b=LBfwu/R9b+TflkhaMshSRNnd01yyznAQjfpRoi/a7ORhUZZPMigAKEWBWQY8JpId3Ea/QuD3dZyMayZRkKx4wN0Ad8kqJS+kk28rOrlR/SgbVybu9iz5LCHK7kWSn7mjo7bxwoU9WDqeDL2IScrBkx2BFaVwA1eTAEXUNyphf5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166781; c=relaxed/simple;
	bh=lx5WVd9G1hKvFp7/Yj+9kGlWw/xamVCJDfw2mYllk+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6y8U47E/Yu7J0jL6dIctfXBVktIQEyoTeDUKS5NwLWj6bRWtpJVOlO9IOnH7pYPtS8jZo87kjOtPdAmqsQ1gsnb5RJCAb/pt/jaMP7BWfsLGel16hPD9KARpLrH2KPLlukwXrFY2/XK0+EP3Pv5g1rBiUOEETCaLP/vxUzXabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2M4n2kR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SpLFYlOxO9M32RKKW1dTizQNscX7YI+e/7F4Va/uOw=;
	b=H2M4n2kRotrt/9E6F0163/aTwF/sJfIPoZ4X85W617mpZXqRYhVLFIR1IYGHIRQeuA3ouK
	j87PjZE2YTMZfg+hZb8qPrkk3ivN+TYFu7oTisqRkJdDmrRfzoODpPg+5yM66yiWApfO11
	tmJAqMWIrqYw3GxcnaPksyGtkXjo+2A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-OEpzy5GcNum6jY-Mjx9O7w-1; Tue,
 20 Aug 2024 11:12:54 -0400
X-MC-Unique: OEpzy5GcNum6jY-Mjx9O7w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36FC71955D4C;
	Tue, 20 Aug 2024 15:12:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4854E19560AA;
	Tue, 20 Aug 2024 15:12:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH v4 net-next 01/12] tools: ynl: lift an assumption about spec file name
Date: Tue, 20 Aug 2024 17:12:22 +0200
Message-ID: <24da5a3596d814beeb12bd7139a6b4f89756cc19.1724165948.git.pabeni@redhat.com>
In-Reply-To: <cover.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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


