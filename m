Return-Path: <netdev+bounces-115478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE1094676A
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3922828D9
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4A713AD26;
	Sat,  3 Aug 2024 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgdlmrnB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96E9762E0
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659218; cv=none; b=pJ0uAkGq+XvgEJke6SZxrsfs+HGlNlWnmLAIBv9HCxAk7VkYhG54vBL6rhXbTzkX1Y5t91YIxVVOKMLLJYCfeoEQ0WgBNLo/wzLp9QpWaR33vVcG1obZ8VsBLrGbUBaPX9qBfD1pGoVEAlY+j9aGzJcK6Ry48YeBnrLJBrrk038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659218; c=relaxed/simple;
	bh=dI7gId/L8B6nMeZZXK6onHZD2A995y4+iTbvKlETJAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyD0Yc4zXUsxr1pxa6xxoetYcwBnJgpGbv7p2fH2RCJLsJJzCdqeempwGZgBVn28k3mSh5m6YcpXJYPBYaepuRigUJKXk5svWjEVZhw0X4XFPQTCJAfRDAFmQ8zpRNcDvd2Br59wg38EddTdMZTQIute2bmU7hkwfEOUt1kaik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgdlmrnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC27C4AF0E;
	Sat,  3 Aug 2024 04:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659218;
	bh=dI7gId/L8B6nMeZZXK6onHZD2A995y4+iTbvKlETJAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgdlmrnBc1tcIlkL336v31Rf7LSYcGpdDqMm7wfOikaxzMwK7XVx86wUVT9lbtUIv
	 y5RTcwE9zN0PSDEVuGmO0upsBS3Dx+KxxwAdBujri88or2jQxi0nHa2TqKUphSKZsa
	 T4cZPdNIBxdZcPBDWGI+81ny4Xwj+P7tdd3FvzxlL4jjqnIgrLLbgx4Ddlaawerdph
	 n9ekWiHJhPkB+0cH9Q/DhwHA5U/z4PJlHtc3qQuN4luWgdnOIptfwhozONxzo4/+OW
	 IF2ISDkjjSypgLbWFl6HivsKOfI6NxM1PZcLCajEbQa+l1zM4lGZr89JliSTtLpyw1
	 JmDnJYVWsa+Jg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 11/12] netlink: specs: decode indirection table as u32 array
Date: Fri,  2 Aug 2024 21:26:23 -0700
Message-ID: <20240803042624.970352-12-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803042624.970352-1-kuba@kernel.org>
References: <20240803042624.970352-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indirection table is dumped as a raw u32 array, decode it.
It's tempting to decode hash key, too, but it is an actual
bitstream, so leave it be for now.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 4c2334c213b0..1bbeaba5c644 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1022,6 +1022,7 @@ doc: Partial family for Ethtool Netlink.
       -
         name: indir
         type: binary
+        sub-type: u32
       -
         name: hkey
         type: binary
-- 
2.45.2


