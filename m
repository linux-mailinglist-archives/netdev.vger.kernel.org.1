Return-Path: <netdev+bounces-37798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DD7B7380
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E00501C203B8
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 21:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD163D981;
	Tue,  3 Oct 2023 21:48:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C03CCF9
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 21:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DD1C433C8;
	Tue,  3 Oct 2023 21:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696369692;
	bh=fWpJWXDXKeWz6CsbeOKu38y2tX3BRhnr0l0GRlf0es8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nwaw1oc/RaUM9DPLoUJRoAEcRw08jxg8AydPaYt8t6wR2nI1fhRuep4604IOrHsRl
	 nEc2zaIXhg18UYZahXZm0angwSHhHF1Uubb3MJvMX+g5MP2gbvC1Tsw8jAZno7twLx
	 /NiBlyJ6LksLtcEMQ93cf2onuMOTW4lIce+2a8B1wY81d7iEDJsFpnfyInhB6y20Wl
	 xIw8Y41DD83U6DWG/mv3PFFcSkXqfUnpAMs68K4DZpbgbPJRc2dWuX9ggoTKl5Ekvn
	 MUwUM1sPskWt7QiEuu2II3bUdhyZlx1bYvYowhtG6y8DK4y1FePhFRYWebTL+aiJMW
	 4T9Ze6H3CbghQ==
Date: Tue, 3 Oct 2023 14:48:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: uapi-header: doesn't update header include guard macros
Message-ID: <20231003144811.2101e5d7@kernel.org>
In-Reply-To: <20231003144513.1d6ed0e2@kernel.org>
References: <5AD3137D-F5F9-42E7-984C-4C82D2DB3C65@oracle.com>
	<20231003144513.1d6ed0e2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Oct 2023 14:45:13 -0700 Jakub Kicinski wrote:
> Fair point, perhaps we can do something like the patch below.
> LMK if it's good enough.
> 
> We don't have any family of this nature in the networking tree.
> Would you need this for 6.7 i.e. the next merge window already?
> I can put it on top of an -rc tag when applying, so you can merge..

Sorry I had it half-committed, this should apply more cleanly:

----->8---------

tools: ynl-gen: use uapi header name for the header guard

Chuck points out that we should use the uapi-header property
when generating the guard. Otherwise we may generate the same
guard as another file in the tree.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 897af958cee8..168fe612b029 100755
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
-    hdr_prot = f"_UAPI_LINUX_{family.name.upper()}_H"
+    hdr_prot = f"_UAPI_LINUX_{c_upper(family.uapi_header_name)}_H"
     cw.p('#ifndef ' + hdr_prot)
     cw.p('#define ' + hdr_prot)
     cw.nl()
-- 
2.41.0



