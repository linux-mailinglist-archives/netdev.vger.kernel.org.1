Return-Path: <netdev+bounces-257217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BsyKgithGk14QMAu9opvQ
	(envelope-from <netdev+bounces-257217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:45:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3764F4347
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 078A53018BDE
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D453F0754;
	Thu,  5 Feb 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhUvjxhO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006C25FA0E;
	Thu,  5 Feb 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302659; cv=none; b=flpafulFtI81NW7xGg+D6lO6rZkjS7HCrbJqVOKVP+lQRpH031eCpgJhZtqVP0RJXxHcqH/zhv+FnG8+TNCChnTP9rI/WFdf7dbFWnrbQVgZ627Ng8QHKli8l3W+hn2FPT1N5EjGdm2KLi6rVx4mAQzbplbb+ue/R5E4HQh9Gx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302659; c=relaxed/simple;
	bh=dhAn/pdXg7ugA9PdDtASFAJ9YgV7T7ENgMTkgMTYLjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VxMQ5H07nTO4OYYYsALyqESwa4+vMkc3OyN/5XXSGf7DVPuy1cqQygsUL5beVBOOn+N64fc6JW/H+5+060MMYcGk9lFyjbLvw0p2bvEcmXLovd3AMprnsYU8lWjwejXYBI+GkjBp0v2QeW8NNHMH6tw03lDE+1e5aKnH/iQIcDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhUvjxhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C44A3C4CEF7;
	Thu,  5 Feb 2026 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770302658;
	bh=dhAn/pdXg7ugA9PdDtASFAJ9YgV7T7ENgMTkgMTYLjo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WhUvjxhOjk8bQjRijvx3dnBgorv/WZ4B7CY/A40IK7fkucWo2BzzUi2E6eAdyQ97E
	 CouQCRw/NSLylWxgddTASHhaJTLVpSGYcUhdWt9WmPK/kpINPL/QvEeY7hD5SdVK9d
	 A3x/xIYXGCBoaSTQXUUlcRINo0q7EkdxTUEyGvBDivOgz2mVRDxR7aKnGKoP2k0ZK+
	 48xo2PYHY08lPPHCQYRkhKvRBZ9QfUA7Wa8sChBotwSU0CksqbgyzqhJ11Fzkg5cJz
	 DPDE6TRj3mycyRhL3DJLZi/AxfHlMd2NkZyUuchIb8XT0oDqslIJI4Q3dn7PMXjvbo
	 9TkhZBzmYM+wA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D24EC1EBC;
	Thu,  5 Feb 2026 14:44:18 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 05 Feb 2026 15:44:05 +0100
Subject: [PATCH net-next] net: skb: allow up to 8 skb extension ids
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-skb_ext-v1-1-9ba992ccee8b@hartkopp.net>
X-B4-Tracking: v=1; b=H4sIALSshGkC/x3MQQqAIBBA0avErBNUUqqrRITZVENgoRKCePek5
 YfHzxDQEwYYmwweXwp0uxqibcCexh3IaKsNkkvNJVcsXOuCKTLDO6uFtUOvEKp+PO6U/tMEDiN
 zVcFcyge7h5FIYwAAAA==
X-Change-ID: 20260205-skb_ext-a04c61cc985e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Florian Westphal <fw@strlen.de>, Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770302657; l=1409;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=0xitE6f4X80qvcsu6zLeGOS3GWowolncxL3u1M9XXik=;
 b=n7mqLSz6Ke5GE/kkdWHvZq0icKMYfF8vtVChShC/3Pj1o2qwuQicxhqZuvlIEHc6u3fuBuSNX
 szWiAd6OiGZCS808ERBK4qSl0NwLUh3b2aeJxVmxmM8uWgyFUyGlpVr
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257217-lists,netdev=lfdr.de,socketcan.hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:replyto,hartkopp.net:email,hartkopp.net:mid]
X-Rspamd-Queue-Id: F3764F4347
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

The skb extension ids range from 0 .. 7 to fit their bits as flags into
a single byte. The ids are automatically enumnerated in enum skb_ext_id
in skbuff.h, where SKB_EXT_NUM is defined as the last value.

When having 8 skb extension ids (0 .. 7), SKB_EXT_NUM becomes 8 which is
a valid value for SKB_EXT_NUM.

This patch intentionally lacks a Fixes tag. Backporting is pointless as
former kernels did not use the entire range of skb extension ids.

Link: https://lore.kernel.org/netdev/aXoMqaA7b2CqJZNA@strlen.de/
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 648c20e19038..609851d70173 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5156,11 +5156,11 @@ static __always_inline unsigned int skb_ext_total_length(void)
 	return l;
 }
 
 static void skb_extensions_init(void)
 {
-	BUILD_BUG_ON(SKB_EXT_NUM >= 8);
+	BUILD_BUG_ON(SKB_EXT_NUM > 8);
 #if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
 	BUILD_BUG_ON(skb_ext_total_length() > 255);
 #endif
 
 	skbuff_ext_cache = kmem_cache_create("skbuff_ext_cache",

---
base-commit: 021718d2cc1a2df2f53b06968fa89280199371bd
change-id: 20260205-skb_ext-a04c61cc985e

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



