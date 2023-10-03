Return-Path: <netdev+bounces-37797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFC67B737C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DF686281340
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 21:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B573D97F;
	Tue,  3 Oct 2023 21:45:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333230FA6
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 21:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C683BC433C8;
	Tue,  3 Oct 2023 21:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696369514;
	bh=8F2CzhFVxouHq0itLEFkzKMIYt3RJnXbryQLp+GYT70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UzJcFQJwQuB1OI9HGzhl5PoZBmTRpQfzKSmMF95ybyf16NtpireiD34UFKHOCrQ1b
	 7mP/QupcxVB/Ry4gmTkNlcL9nbemr5vJ66Ak5E2vSzuz3r4MgJ/oDhYoCkMcvItTcu
	 lFt7Bn65CpyvzaCQZRKGqsRvNQ3DjC1MLFxqqySKc0ulp8GqnRzcanF6607MIaUOuo
	 bikykEotmEhNikEMYd5cNQomsbfHDNoo4X1vthTHug3wcBMbNC7m7l03gUdOgbgF43
	 b4g16kyRne9ZNpyiByWj5z5mWwjaO/ymBfOskkgNlawSq+aTO52KQofRWi7n7JuATg
	 5NCV47ZCs3rMQ==
Date: Tue, 3 Oct 2023 14:45:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: uapi-header: doesn't update header include guard macros
Message-ID: <20231003144513.1d6ed0e2@kernel.org>
In-Reply-To: <5AD3137D-F5F9-42E7-984C-4C82D2DB3C65@oracle.com>
References: <5AD3137D-F5F9-42E7-984C-4C82D2DB3C65@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Sep 2023 16:41:59 +0000 Chuck Lever III wrote:
> Hi Jakub-
> 
> This is a minor nit, but I have
> 
> name: xxxx
> uapi-header: linux/xxxx_netlink.h
> 
> in my yaml spec, and the actual uapi file is named
> 
> include/uapi/linux/xxxx_netlink.h
> 
> but the generated include guard macros in that header still say:
> 
> #ifndef _UAPI_LINUX_XXXX_H
> #define _UAPI_LINUX_XXXX_H
> 
> ....
> 
> #endif /* _UAPI_LINUX_XXXX_H */
> 
> They should use _UAPI_LINUX_XXXX_NETLINK_H instead to avoid
> colliding with a human-written include/uapi/linux/xxxx.h.

Fair point, perhaps we can do something like the patch below.
LMK if it's good enough.

We don't have any family of this nature in the networking tree.
Would you need this for 6.7 i.e. the next merge window already?
I can put it on top of an -rc tag when applying, so you can merge..

----->8-----

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 18532e78e1cf..168fe612b029 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -805,6 +805,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.uapi_header = self.yaml['uapi-header']
         else:
             self.uapi_header = f"linux/{self.name}.h"
+        if self.uapi_header.startswith("linux/") and self.uapi_header.endswith('.h'):
+            self.uapi_header_name = self.uapi_header[6:-2]
+        else:
+            self.uapi_header_name = self.name
 
     def resolve(self):
         self.resolve_up(super())
@@ -2124,7 +2128,7 @@ _C_KW = {
 
 
 def render_uapi(family, cw):
-    hdr_prot = f"_UAPI_LINUX_{family.uapi_header}_H"
+    hdr_prot = f"_UAPI_LINUX_{c_upper(family.uapi_header_name)}_H"
     cw.p('#ifndef ' + hdr_prot)
     cw.p('#define ' + hdr_prot)
     cw.nl()

