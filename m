Return-Path: <netdev+bounces-107058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B69198C8
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 22:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21481C20ABC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 20:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C74B192B69;
	Wed, 26 Jun 2024 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hReO/9Lg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085EF190686
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432757; cv=none; b=SjYWZ1gFNan9RtgW829d1HcF5+Oh3xf9qSOZlJ+876sIHhbEQri1/3/Cdsrhhq3zY+hUiMFp3GJu5dpo22MRw9nxO+bw2f5d3tG1xpeL/dPgW1cg+yBEzokgel6Za52qQcxMt/8i+DAzvEMI1MfQIO5nR8BW7ws1oJanP4WWT6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432757; c=relaxed/simple;
	bh=1yopoV//etmu85H4Qc1ZZHZq+avdbfGBnFKGOQVVgU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOhZFeBFCKJA+m4n0CZn1VooAHB35ZRObPgKqxnj78GA0m0iUC9Gmcwj/aM94zK31IAyAIWkI7srf5v5SIoHYCl9+XuOiXJfA+poWKBH0ugCZ1+xOYmMFcvWvhDpBZnDebf1R/SIw7W3fsGwBzrk/cr5GHxBY15OJ8DBPR0xlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hReO/9Lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C915C32786;
	Wed, 26 Jun 2024 20:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719432756;
	bh=1yopoV//etmu85H4Qc1ZZHZq+avdbfGBnFKGOQVVgU8=;
	h=From:To:Cc:Subject:Date:From;
	b=hReO/9Lgf760ehqk1Umaa4TJZG9D7LQlY1qG48Fpd14bffCXxXBUZNXmiY9Lu9z6m
	 dpnq4bner3YcE5XRKjEu4sZVfN2n7kSOKaiOu9iVGJprx7qdCu4EwiQ7gFA1C1yzCF
	 RN2UI5lzo+ZKeoJX6ysQbRJFZnktjpCTaD42S30rPo4rg0LlIDFqN+oOrcfnDezz+s
	 ohiQ/vyhKsezKP6UdG0ZE4rdseFealkIQ/bxGlQ6cKs7JibRVdIu3Wkkhyib/chHBg
	 CLMFFNAI/D2WP8rgabyHNzLm/u5tP090+gPxcx8Z4MYY0sWS5GnlRHodAodDlSE7FF
	 ChQdee274oWRA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net-next] tools: ynl: use display hints for formatting of scalar attrs
Date: Wed, 26 Jun 2024 13:12:34 -0700
Message-ID: <20240626201234.2572964-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use display hints for formatting scalar attrs. This is specifically
useful for formatting IPv4 addresses carried typically as u32.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jiri@resnulli.us
---
 tools/net/ynl/lib/ynl.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 35e666928119..d42c1d605969 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -743,6 +743,8 @@ genl_family_name_to_id = None
                 decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
                 if 'enum' in attr_spec:
                     decoded = self._decode_enum(decoded, attr_spec)
+                elif attr_spec.display_hint:
+                    decoded = self._formatted_string(decoded, attr_spec.display_hint)
             elif attr_spec["type"] == 'indexed-array':
                 decoded = self._decode_array_attr(attr, attr_spec)
             elif attr_spec["type"] == 'bitfield32':
-- 
2.45.2


