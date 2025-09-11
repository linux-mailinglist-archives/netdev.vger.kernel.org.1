Return-Path: <netdev+bounces-222291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD99B53CD8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C36487E49
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B2A263C8F;
	Thu, 11 Sep 2025 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="rR6tl7ON"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039191DBB13;
	Thu, 11 Sep 2025 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621133; cv=none; b=MUplM2dN4YwXAHaYgCX/Bedd/ntY9KcqdtxvbrUVJFv83TzGM2XEqG9uYqsVp8bZlblsEKWeL8rIt406fy6LF9wTuva/4ZxOvFJAr3rlnIWzyWQxt51lDXCmIJkquqCT3YUV0+6yWWnfs0CdvfUWZAjmkuW+ykq0dZoNvhJFjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621133; c=relaxed/simple;
	bh=pnz1Z9RsFEA/w79qMxEPA9j3gcVp4d2qUkVblwMqsWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqA5aVBHDLuIBXLjqoJFl/CrqfSXztDu1vSSBobXCDklkmlBq2Srat5JYvvK2aDfroncvMXVcsJCWVdjYhHTF/8L55geecRuUie+5hvpJKkFuurxBlCQDSarMcoTQok92BOe7ZtYKWwdq2gFrlnml9OTahwSQKMZ1tJqcpx3IOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=rR6tl7ON; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=pnz1Z9RsFEA/w79qMxEPA9j3gcVp4d2qUkVblwMqsWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rR6tl7ON3KGjavAVSATs4mNIhcvrOV+Pox69ZgQCXF5PJmFZMrLRJBKHyfSaBjN7G
	 +/FyJSwlHeDeQkp2eO7zztFZUoOJCPpNpmpLW3EM6MfuPyW9VvASCl7wwrNNfLXuO0
	 fDUTrlX1jgFA/I5/qA+VuLGzueY3WZjaH1e+8Oj1NoBJrE2vBAbJkB7WnKNcag0XTR
	 JfOVw/OuNGpqU4O3aXqVgbNN2lOfjXDVTy1Z5i0oKTokHoWyIVK08i/xsyFsBOyMQI
	 eNJkCfkRFAMXo944xdNKq7GCVt66ZJYcrqm6U/9tfxORTRSC1gCRbrG1pvKTbgtQg+
	 kXh861lb2dmJQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 885EC6000C;
	Thu, 11 Sep 2025 20:05:26 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id D7098202A89; Thu, 11 Sep 2025 20:05:20 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 01/13] tools: ynl-gen: allow overriding name-prefix for constants
Date: Thu, 11 Sep 2025 20:04:54 +0000
Message-ID: <20250911200508.79341-2-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911200508.79341-1-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow using custom name-prefix with constants,
just like it is for enum and flags declarations.

This is needed for generating WG_KEY_LEN in
include/uapi/linux/wireguard.h from a spec.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 101d8ba9626f..c8b15569ecc1 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3208,8 +3208,9 @@ def render_uapi(family, cw):
             cw.block_end(line=';')
             cw.nl()
         elif const['type'] == 'const':
+            name_pfx = const.get('name-prefix', f"{family.ident_name}-")
             defines.append([c_upper(family.get('c-define-name',
-                                               f"{family.ident_name}-{const['name']}")),
+                                               f"{name_pfx}{const['name']}")),
                             const['value']])
 
     if defines:
-- 
2.51.0


