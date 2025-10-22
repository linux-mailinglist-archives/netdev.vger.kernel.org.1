Return-Path: <netdev+bounces-231827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF6FBFDD37
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81991A05658
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B934B1AB;
	Wed, 22 Oct 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="OK0Z9v//"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217AE346E4B;
	Wed, 22 Oct 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157641; cv=none; b=O1oCO58CJt31PmoHSJ+4DBowGmvBw7kUgOX2dV5M+oKBmqB/AozbI0s1mW9ck5onmt17hyqzpWvnOgJ8EUC2hX4F4+lOexp7YkycRxrkJqNz5hfh1H5ZQyg1Myv3ogl1eJYuGLBEiD8rQpDOhXpg7wKo7Zmn0RHMpYvHdM4XYvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157641; c=relaxed/simple;
	bh=to+++l+OT4ObaazQyXHHfgCEH6AA58+yXljgAbpH5pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJ93Xx0u/MCu+hvfRMRud1p9uSpcQLEiZO3jhhmnGNiDjgSD2+JgDfwNvvlnpHDz9gGwcZJ59Fv7vrFpov08T8EbCSPT2Nfkekc+NOfRQss7ew3OjbOfuqXMk1xaz2+OwwIJOTmWjS1M5bu1R6O0uQfr0hBA9gX06V4Njcldlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=OK0Z9v//; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761157634;
	bh=to+++l+OT4ObaazQyXHHfgCEH6AA58+yXljgAbpH5pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OK0Z9v//T6eG/JR8d+3iN9H7k3b0DenTWsup9DvVcFPDWgIHnmjwZuhobaqvLdnuo
	 bCL1hAymbbUfKXfNQYSKVHHtl+8NpV9z+lihES65djoAnV9zSy/toXydfNcViKkBD4
	 Sy2VOQA4riTggAF5xyOEJcgJU4826bHTWEQsRJUUNE0W3LfosB3tWgqa5RL82Mh/ZD
	 mGdDELSiFplFY2YRECRmHJ3IeJ7+7n4zfLMOS8p0ypsM363zRJMwjx7uKRO1gXGh0M
	 7ZRz+/28brO4SST68OdHthVcvC9C956jujdKm1Rth9UfGMRcCBwpVkALymqrnjPTTt
	 uc6+ZhWTsmxHw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7CB84600FC;
	Wed, 22 Oct 2025 18:27:14 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 8E409202268; Wed, 22 Oct 2025 18:27:09 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/7] tools: ynl: support ignore-index in indexed-array decoding
Date: Wed, 22 Oct 2025 18:26:55 +0000
Message-ID: <20251022182701.250897-3-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022182701.250897-1-ast@fiberby.net>
References: <20251022182701.250897-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When decoding indexed-arrays with `ignore-index` set, then
elide the index, aka. the nested attribute-type.

Previously the index was always preserved for sub-type nest,
but was elided for all other sub-types.

I have opted to reuse the existing `subattr` variable, as renaming
it will render the diff unreadable at least for this version.

Output if `rates` does NOT have `ignore-index` set:
  $ ./tools/net/ynl/pyynl/cli.py --family nl80211 --dump get-wiphy
  [...]
  'rates': [{0: {'rate': 60}},
            {1: {'rate': 90}},
            {2: {'rate': 120}},
            {3: {'rate': 180}},
            {4: {'rate': 240}},
            [...]

Output if `rates` has `ignore-index` set to true:
  $ ./tools/net/ynl/pyynl/cli.py --family nl80211 --dump get-wiphy
  [...]
  'rates': [{'rate': 60},
            {'rate': 90},
            {'rate': 120},
            {'rate': 180},
            {'rate': 240},
            [...]

If the above example had to be passed back though --json, then it
now aligns with the new output format, and would look like this:
  --json '{"rates":[ {"rate":60}, {"rate":90}, ... ]}'

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/lib/ynl.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 62383c70ebb95..14c7e51db6f5c 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -690,23 +690,26 @@ class YnlFamily(SpecFamily):
             item = NlAttr(attr.raw, offset)
             offset += item.full_len
 
+            subattr = None
             if attr_spec["sub-type"] == 'nest':
-                subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
-                decoded.append({ item.type: subattrs })
+                subattr = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
             elif attr_spec["sub-type"] == 'binary':
                 subattr = item.as_bin()
                 if attr_spec.display_hint:
                     subattr = self._formatted_string(subattr, attr_spec.display_hint)
-                decoded.append(subattr)
             elif attr_spec["sub-type"] in NlAttr.type_formats:
                 subattr = item.as_scalar(attr_spec['sub-type'], attr_spec.byte_order)
                 if 'enum' in attr_spec:
                     subattr = self._decode_enum(subattr, attr_spec)
                 elif attr_spec.display_hint:
                     subattr = self._formatted_string(subattr, attr_spec.display_hint)
-                decoded.append(subattr)
             else:
                 raise Exception(f'Unknown {attr_spec["sub-type"]} with name {attr_spec["name"]}')
+
+            if attr_spec.get('ignore-index', False):
+                decoded.append(subattr)
+            else:
+                decoded.append({ item.type: subattr })
         return decoded
 
     def _decode_nest_type_value(self, attr, attr_spec):
-- 
2.51.0


