Return-Path: <netdev+bounces-206019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ED9B010F6
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B961C825FF
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA301537DA;
	Fri, 11 Jul 2025 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH8bjJ1t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4A1531C1
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198819; cv=none; b=E4b0E3e9xble09xFuNvdM/WLMUK7Ub6zEFY28iv0lTc9Oa6o+3S1NUqklYf2gMr3aq7FmSD4Nywqxe8u7cHDACZn0GS8eiwXxPzIRr8RvXDlWuoh+s47wDS4Z5j7ak0RxHwE3AQqrjrc2qrpdwz8WWZg6aMmOAM3UgLZq5A4vA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198819; c=relaxed/simple;
	bh=qq/z+2pkhsDn44xzhvdK6rtv2K/GvGpdX6hXp17NKyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsJg3QwuNtaO+FHqwGR6Py0wESyTmwyC4Yn3DocXun37MgdAhSS9nN5BKSHKP+NJ0rAJWJLmhZbo5YeXsHjAmSkluGzoBO/poJWkrt2UNlcHZ1sMgnDoQIaSHK3WeyxhKaekEEfBUS9d3kzqPKVRbJQAvHOLOQMxEppYEqdgjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH8bjJ1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E648C4CEF8;
	Fri, 11 Jul 2025 01:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198819;
	bh=qq/z+2pkhsDn44xzhvdK6rtv2K/GvGpdX6hXp17NKyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kH8bjJ1tuVST9BjOUYxvkoV41BmB5+lSi5Bkn+VheZWXUM4Mz8Qdj39xfApU3Te+z
	 TwuFm/h441hzyx+CJ9NwD5gAdzKvOKhphliwhe0AjhyuLPJ2LLAcXixfstbhhdkxVX
	 Y2GZ0MzVts5y/aXk0HrQYmBCFfQKk0uAvldPSFrDgJCkuPDDZ2PAG8TYchRcXwLxal
	 7fJwKGESrM1gfTYxzL/3kjo5bLtY9ToS+Ns2wJDKgIax1QsuaoeezeyZJhLV6+S4rj
	 RGczK3GBbReZiW6/i74ear984KXwjPouBsnr3X3+GGjmwbTYHVA6I1AdhWnN74UGHR
	 w1gEOmwq1kh3g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/11] tools: ynl: support packing binary arrays of scalars
Date: Thu, 10 Jul 2025 18:52:55 -0700
Message-ID: <20250711015303.3688717-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711015303.3688717-1-kuba@kernel.org>
References: <20250711015303.3688717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We support decoding a binary type with a scalar subtype already,
add support for sending such arrays to the kernel. While at it
also support using "None" to indicate that the binary attribute
should be empty. I couldn't decide whether empty binary should
be [] or None, but there should be no harm in supporting both.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
---
 tools/net/ynl/pyynl/lib/ynl.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 7529bce174ff..13f1210d0010 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -575,7 +575,9 @@ genl_family_name_to_id = None
         elif attr["type"] == 'string':
             attr_payload = str(value).encode('ascii') + b'\x00'
         elif attr["type"] == 'binary':
-            if isinstance(value, bytes):
+            if value is None:
+                attr_payload = b''
+            elif isinstance(value, bytes):
                 attr_payload = value
             elif isinstance(value, str):
                 if attr.display_hint:
@@ -584,6 +586,9 @@ genl_family_name_to_id = None
                     attr_payload = bytes.fromhex(value)
             elif isinstance(value, dict) and attr.struct_name:
                 attr_payload = self._encode_struct(attr.struct_name, value)
+            elif isinstance(value, list) and attr.sub_type in NlAttr.type_formats:
+                format = NlAttr.get_format(attr.sub_type)
+                attr_payload = b''.join([format.pack(x) for x in value])
             else:
                 raise Exception(f'Unknown type for binary attribute, value: {value}')
         elif attr['type'] in NlAttr.type_formats or attr.is_auto_scalar:
-- 
2.50.1


