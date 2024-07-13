Return-Path: <netdev+bounces-111194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E690930346
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6B51C21521
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A4449651;
	Sat, 13 Jul 2024 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="qLYOi3DA"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE338F9C;
	Sat, 13 Jul 2024 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837168; cv=none; b=PKMjL/XrfSeCM88LZeECZvNXwy4WMVPiEgHMe3zn2XyRqonVIdHWvw0rlkAU2IZ2CF7fU9Bua3BHfgnUU+4k09p05hG/9qWZndLDmru2f6w+snz0iLpUBpAZQQd8DZp+7vJWv31s+P0VYFA1ySkBXw0HzccXBgVZ6Wx2rF3gjM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837168; c=relaxed/simple;
	bh=YN8RInaCr1oKobFdS8dmq2lr5ugxNcMFE+hIw2zkmHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVEwB42t27yfG3DeFQ8EwVDjL2SoNf32fUTlCUnk1RlQU71RmaAyJrpIgC0ojf3XIeD/DC1vz/V7A7k+Xl9t62Ecnh4kUDJEM5jKD2Gpi6zAEAjPnliZQOo6uXySjJvP7s/creYMqbW2GQFqFX2KwE/A9ukF0yIWIqQFsTReZe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=qLYOi3DA; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837160;
	bh=YN8RInaCr1oKobFdS8dmq2lr5ugxNcMFE+hIw2zkmHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLYOi3DAzyxnLWHITE3++nV9OOIzpTIIQ8enky8AUhwegB4bH3aky3BcbrNPkN+Lg
	 gRxbeT7PZwKp89/SB2o1DN8weEKbccTe1Db5gEcGFTUgWLBpdFOCo+POxuql0+X1sx
	 +kJ3DJ7ocDgjjOc7r49xpxxMMVXoVasC1KEdJsWr4e6Qp2wo56OPsyj/8/C9+KnWiQ
	 XH/7EB6TsYhOGTBNUaTVB561IRGkRbtn8H0UpmWs2OypRFaWu4eO7U29Qu+9VzyxxX
	 N7N3lZqFYCF5NVccJM1/t+/i7W3qX+iHvXb8rq299YQiNJNGCMQ4EDCsF1Ks+6g9Av
	 M2dy+vQ5KD+cg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 65FA760078;
	Sat, 13 Jul 2024 02:19:17 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 8658C204C90; Sat, 13 Jul 2024 02:19:12 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 10/13] doc: netlink: specs: tc: flower: add enc-flags
Date: Sat, 13 Jul 2024 02:19:07 +0000
Message-ID: <20240713021911.1631517-11-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713021911.1631517-1-ast@fiberby.net>
References: <20240713021911.1631517-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Describe key-enc-flags and key-enc-flags-mask.

These are defined similarly to key-flags and key-flags-mask.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/tc.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index aa574e3827abc..b02d59a0349c4 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -2763,6 +2763,18 @@ attribute-sets:
         name: key-spi-mask
         type: u32
         byte-order: big-endian
+      -
+        name: key-enc-flags
+        type: u32
+        byte-order: big-endian
+        enum: tc-flower-key-ctrl-flags
+        enum-as-flags: true
+      -
+        name: key-enc-flags-mask
+        type: u32
+        byte-order: big-endian
+        enum: tc-flower-key-ctrl-flags
+        enum-as-flags: true
   -
     name: tc-flower-key-enc-opts-attrs
     attributes:
-- 
2.45.2


