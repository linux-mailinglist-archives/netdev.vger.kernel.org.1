Return-Path: <netdev+bounces-98846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F828D2AE1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 04:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF44F282CB8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FE732C85;
	Wed, 29 May 2024 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjZe8C7H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71A17E8F0
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716950006; cv=none; b=LhQvXm5yjNCnYa7J5SErlNGJ1zkktrqyTqXyqiehnKfii4KC0117dJhVZKVXelQRsx044mrJQOkk4/Vha3xjGAw9DSSiAe4BqawMVzB9aEwg8s7vfqVXRP2L28ZJDmaYJq2VUMc0kZmc6dO36TKZlm+YTRNH22d+grHZ8yhbmR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716950006; c=relaxed/simple;
	bh=5RBFDHb7CYSETRyLZo9G3Rob1svtNyz2WiH9hLZ4VSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N9tTuQUSkQ07BcOvNVwZQ7t55IWm3e9OUqMcf4pxbN4ZV3sHTwfIjc578wqezenkwyS6RWtURaqBih6Hf7gleFVL2L0rYPFVDaDVL7cTRXz7TdeYtMql9t9YhFlN0a/OHjKCWqRRrevpQiVnXq7+lhiTwxDaxSCVk8neMDpkJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjZe8C7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EBEC3277B;
	Wed, 29 May 2024 02:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716950005;
	bh=5RBFDHb7CYSETRyLZo9G3Rob1svtNyz2WiH9hLZ4VSw=;
	h=From:To:Cc:Subject:Date:From;
	b=KjZe8C7H5kekM1CeCOZBW112So7GYYwrpYIe8ZaWtx4gm2DG0HhwGo2b3wy5phb2a
	 kCu6IwlNe87sQEf2tIWiX3AZF1oDSo/mD0688Yw6SaUtbl2qwgbk6SOgGkYFYk4dcn
	 it3CILhPQk25eXfYAUqeXBiVymw9yy+0E3RsE0QcNZTSa1ynyUuVA6/oowXIvOSOUl
	 i9uxecYej00//L11VpCtgCE0oBgM4AGYAhcU7X2Y7RGbbvrazZfKdltLSyK+SdI6+T
	 Pr92I9nKX/M76W938u3TUJ6KKwodpfuMqeWPfzjdxpu2VqrSfHjY1Z7qAxmReez456
	 bQhUjT+TQrihQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: fjes: correct TRACE_INCLUDE_PATH
Date: Tue, 28 May 2024 19:33:22 -0700
Message-ID: <20240529023322.3467755-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A comment in define_trace.h clearly states:

 TRACE_INCLUDE_PATH if the path is something other than core kernel
                                                           vvvvvvvvvvvvvv
 include/trace then this macro can define the path to use. Note, the path
 is relative to define_trace.h, not the file including it. Full path names
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 for out of tree modules must be used.

fjes uses path relative to itself. Which (somehow) works most of
the time. Except when the kernel tree is "nested" in another
kernel tree, and ../drivers/net/fjes actually exists. In which
case build will use the header file from the wrong directory.

I've been trying to figure out why net NIPA builder is constantly
failing for the last 5 days, with:

include/trace/../../../drivers/net/fjes/fjes_trace.h:88:17: error: ‘__assign_str’ undeclared (first use in this function)
   88 |                 __assign_str(err, err);
      |                 ^~~~~~~~~~~~

when the line in the tree clearly has only one "err". NIPA does
indeed have "nested" trees, because it uses git work-trees and
the tree on the "outside" is not very up to date.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/fjes/fjes_trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fjes/fjes_trace.h b/drivers/net/fjes/fjes_trace.h
index 6437ddbd7842..2d3f0dddd375 100644
--- a/drivers/net/fjes/fjes_trace.h
+++ b/drivers/net/fjes/fjes_trace.h
@@ -358,7 +358,7 @@ TRACE_EVENT(fjes_stop_req_irq_post,
 
 #undef TRACE_INCLUDE_PATH
 #undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_PATH ../../../drivers/net/fjes
+#define TRACE_INCLUDE_PATH ../../drivers/net/fjes
 #define TRACE_INCLUDE_FILE fjes_trace
 
 /* This part must be outside protection */
-- 
2.45.1


