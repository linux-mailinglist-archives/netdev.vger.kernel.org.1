Return-Path: <netdev+bounces-19432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BE175AA7D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EBA2819DF
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E22361;
	Thu, 20 Jul 2023 09:19:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD41156D7
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:19:55 +0000 (UTC)
Received: from out-55.mta0.migadu.com (out-55.mta0.migadu.com [91.218.175.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D17126A3
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:19:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1689844790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aY5ZIHVzqKStKyl3k69PdYOrRbB8zSK0DaCbVQ7/OGA=;
	b=fgIJIFH/Cnyi8aVF1Q+r8C7Thp478NsKaKk1wRZboWWj6Yxu5jcjjRloE1Vf+YkMk9TYRF
	Vjry3TSPqhOlqODz00DJuvPXPlTSrN4jWkmXqNriwp8wp8wRDFoSIzG2qlx4ADDe1pA4fW
	0vs7WMo0+27zCZxIXo9ZCp6oCIt/rnI=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	poros@redhat.com,
	mschmidt@redhat.com,
	netdev@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH net-next 01/11] tools: ynl-gen: fix enum index in _decode_enum(..)
Date: Thu, 20 Jul 2023 10:18:53 +0100
Message-Id: <20230720091903.297066-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Remove wrong index adjustement, which is leftover from adding
support for sparse enums.
enum.entries_by_val() function shall not subtract the start-value, as
it is indexed with real enum value.

Fixes: c311aaa74ca1 ("tools: ynl: fix enum-as-flags in the generic CLI")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 tools/net/ynl/lib/ynl.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 1b3a36fbb1c3..3908438d3716 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -420,16 +420,14 @@ class YnlFamily(SpecFamily):
     def _decode_enum(self, rsp, attr_spec):
         raw = rsp[attr_spec['name']]
         enum = self.consts[attr_spec['enum']]
-        i = attr_spec.get('value-start', 0)
         if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
             value = set()
             while raw:
                 if raw & 1:
-                    value.add(enum.entries_by_val[i].name)
+                    value.add(enum.entries_by_val[raw & 1].name)
                 raw >>= 1
-                i += 1
         else:
-            value = enum.entries_by_val[raw - i].name
+            value = enum.entries_by_val[raw].name
         rsp[attr_spec['name']] = value
 
     def _decode_binary(self, attr, attr_spec):
-- 
2.27.0


