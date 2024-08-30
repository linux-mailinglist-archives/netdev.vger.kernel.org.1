Return-Path: <netdev+bounces-123781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DAF9667C5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D291C22C77
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACFA1B5813;
	Fri, 30 Aug 2024 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoQCbaV4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2B1BAEC0;
	Fri, 30 Aug 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038087; cv=none; b=dLLA80GHCOL3dtvBNR1A+m/zZ2q0Xcbk5rgxdO+4OjLdMjnVxP1mLdbxJ4Jty7hCP2qYJQEn+SvEEn0vySfj0B+FuCOU8L3i/+dqJsfzv3L5zWACVvdWZkDszy6JUYhzBLU/9D904Bs+Zn3qyibaI9gFCZsl0pNoWMc+ZkI7zfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038087; c=relaxed/simple;
	bh=6muzqNrp6/GvlVRaKgN/ToIdt+fZp8wXmbCAVwe1h10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJl4J008av3wqWUeRSZcfZWNY4WkIM1bPGzSQjUqJjqOgCio7MQEdzWl+ahNBn3eIJDa1Q1JUmbTp1q6sau7DvxgiL01F9RVK52cIm4x0TJgk5NshS4wALLUtq/hOh9N+JAVmqo4bDvFLAJ6SDLnoeOHwVXh+tWxy17ufIebny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoQCbaV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A3DC4CEC2;
	Fri, 30 Aug 2024 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725038085;
	bh=6muzqNrp6/GvlVRaKgN/ToIdt+fZp8wXmbCAVwe1h10=;
	h=From:To:Cc:Subject:Date:From;
	b=HoQCbaV4Sma/OmVwNJKJhSSmosaeZaRaGTzl0eFYwMHDDRb9D4IFcsJAjGVnk6hVm
	 14Uc7IeKiy8modfD687HKdKizKozosTB+LWdZ1Bc+wJ5gQxQtGtmcoca9GMstMUsIh
	 fbgzOss/mYUWLFwZlzKk/SbXL3pASxnTjw4LFksf7Hpa8IMvTm8tEbu6N80sWfhdF0
	 4bv5msTpQKN4EfhD8WA3kW2lNRsEdQo7z7mqssdsKngImIYjwFjn+V0n3xW4+Hae5H
	 FZg7OA6RZweRHLPyOPHiffFPsLCTN181zLgo9CJ0AVQX2u+EoVt2rkzH7AaVMOsm/Y
	 rJyo/kfbGAMJQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew@lunn.ch>,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH net v2] docs: netdev: document guidance on cleanup.h
Date: Fri, 30 Aug 2024 10:14:42 -0700
Message-ID: <20240830171443.3532077-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document what was discussed multiple times on list and various
virtual / in-person conversations. guard() being okay in functions
<= 20 LoC is a bit of my own invention. If the function is trivial
it should be fine, but feel free to disagree :)

We'll obviously revisit this guidance as time passes and we and other
subsystems get more experience.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: horms@kernel.org
CC: corbet@lwn.net
CC: linux-doc@vger.kernel.org

v2:
 - add sentence about revisiting later to commit msg
 - fix spelling
v1: https://lore.kernel.org/20240829152025.3203577-1-kuba@kernel.org
---
 Documentation/process/maintainer-netdev.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 30d24eecdaaa..c9edf9e7362d 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -375,6 +375,22 @@ When working in existing code which uses nonstandard formatting make
 your code follow the most recent guidelines, so that eventually all code
 in the domain of netdev is in the preferred format.
 
+Using device-managed and cleanup.h constructs
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Netdev remains skeptical about promises of all "auto-cleanup" APIs,
+including even ``devm_`` helpers, historically. They are not the preferred
+style of implementation, merely an acceptable one.
+
+Use of ``guard()`` is discouraged within any function longer than 20 lines,
+``scoped_guard()`` is considered more readable. Using normal lock/unlock is
+still (weakly) preferred.
+
+Low level cleanup constructs (such as ``__free()``) can be used when building
+APIs and helpers, especially scoped iterators. However, direct use of
+``__free()`` within networking core and drivers is discouraged.
+Similar guidance applies to declaring variables mid-function.
+
 Resending after review
 ~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.46.0


