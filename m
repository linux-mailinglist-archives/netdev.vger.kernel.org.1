Return-Path: <netdev+bounces-218778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B3B3E7E3
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578557B164E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC4B335BAB;
	Mon,  1 Sep 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="SfTXFqew"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5EC2EDD76;
	Mon,  1 Sep 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738339; cv=none; b=clnQpwz1Fp4mwT3MH2DXQ9gyZ0S+3nZYcGWU/ScCw/tS7T9ktAiGP6aW586jCs0Ws5fqQMuJIdFDceOyqg6q8TQK9cr5JYVkxnrA53+936zOHwg2OrfSt/XgwkB9M/ewPUSyr1Z+GMGfO+XNUV4oK457fPXrW7WQAsZvewHaYW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738339; c=relaxed/simple;
	bh=bwutvYte2v5M5foMclZwyKV+peJI6XWuEXuXe4HoaBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfo5efzLoP4TSwfIKbZKHkMPmpFT039q/d1c90e/TVbwgafy87LoV2nbRhoHYcDlfS1yc1qx/9j/otdmst4rS5dcQJ3qDSoOvLpd1NiPJEQ4QyonbCporQBaD/nOtu/P3+Xb3nF/lhCu4q5vhW062h5DLQcCKF4X+LoVn6fSzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=SfTXFqew; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1756738334;
	bh=bwutvYte2v5M5foMclZwyKV+peJI6XWuEXuXe4HoaBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SfTXFqewM4mrjsNbqjjJYpkzNzQSs7ILBxImJU2Q2lcDK1cdNpH0oOh/BRtAGjOvy
	 +telnDst07ECMTXoE312nn9vwMyp6X3wGPj5qjxhBZeX/5zuOSmk0Zf7muQPW8wmgQ
	 nSRlxYeZKCZ7N21bs9DYXi+6ZFjbHLa52GINp5PCyUY4h5filyjlPVzm4V8rFL6qgz
	 szjTmpdfv4rm/y/KomFOD05ixOEbs74pQF72HHQH3SzQ9TY7PbB4ioCChQOCsexwsC
	 TCATXFxr/xnZicSZUWjWdYzqEUGJ1+Jl64mnFRP9uBHxn4cSDlPpwaBJsvRQGkdEnk
	 PGuFwq/cqDh8A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id EADA26012E;
	Mon,  1 Sep 2025 14:51:16 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 1106A202271; Mon, 01 Sep 2025 14:50:56 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/4] tools: ynl-gen: use macro for binary min-len check
Date: Mon,  1 Sep 2025 14:50:21 +0000
Message-ID: <20250901145034.525518-3-ast@fiberby.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250901145034.525518-1-ast@fiberby.net>
References: <20250901145034.525518-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch changes the generated min-len check for binary
attributes to use the NLA_POLICY_MIN_LEN() macro, and thereby
ensures that .validation_type is not left at NLA_VALIDATE_NONE.

This doesn't change any currently generated code, as it isn't
used in any specs currently used for generating code.

Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index ef032e17fec44..52f955ed84a7f 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -556,7 +556,7 @@ class TypeBinary(Type):
         elif 'exact-len' in self.checks:
             mem = 'NLA_POLICY_EXACT_LEN(' + self.get_limit_str('exact-len') + ')'
         elif 'min-len' in self.checks:
-            mem = '{ .len = ' + self.get_limit_str('min-len') + ', }'
+            mem = 'NLA_POLICY_MIN_LEN(' + self.get_limit_str('min-len') + ')'
         elif 'max-len' in self.checks:
             mem = 'NLA_POLICY_MAX_LEN(' + self.get_limit_str('max-len') + ')'
 
-- 
2.50.1


