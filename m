Return-Path: <netdev+bounces-256579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OByyMBrZgmnkcwMAu9opvQ
	(envelope-from <netdev+bounces-256579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:28:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF1EE1F69
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DD3A3018406
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19089353ED6;
	Wed,  4 Feb 2026 05:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBf4yPZn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34F330B29
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182934; cv=none; b=E+Siqav3gWml1nEGeBF2JHl62VXm1RPiac+RXY2rGhc822qokw0ABbGm5wy11yDZ67K4h3m58Js4rnGfUhn5sRMxpi4DT9UzX2gaD4wv+vR+hEW3Ctm+GjJZoc+kuxzvnlqKkizp5ymcTWVl4hXhAAVZLvbMICCCE/+m8DACTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182934; c=relaxed/simple;
	bh=cxGNvQLvikEv4bdXSiNmz6fOV3+v+WSDtz3DILLef3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/A/1hYaUs2RQpXN9AFU7ZC5zpOZxxsSdHqYPauYnQHDj6EBuBmutuS8Xoed+ZJnYx4Ma0lXhkPu7QZ7kxYFpHQOts+HUHb+Pwq/zctHDvue3gLDIJxtBygznGIIkgW1oRfJleHqNYubfmx+5vF8BtN+uPxTMHa9TdGLToLeYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBf4yPZn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a929245b6aso14047075ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 21:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770182933; x=1770787733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xR+YOZtW6j/QJ6GBGO3sd3oLXrKw2DbvDwK57pQQ7s8=;
        b=MBf4yPZnufBuwnuFBBN2e0blhfFAkOK0mt77SyWuLtKKq22VZHI3c95UL+zcSB4xCR
         f4/bqKsWBqtbB79x6oQX5lwkx/FtgeSSZz9VmyPhaoF08xbhe+mLYhERwua9LZYaWWue
         5iwfuMialpItF9RHl1VQ5qV4NfZdFrYJ1hxiuYE5rnSgMFoDG6EW8KGcONVBs9B3mdiC
         jem+pRl5z4Pm99JjQrftvBJFqU1r2cR/CNbfFXKzyrqZdvl1Jrca6sXZPR0PtFFNW4QX
         OvtC5FTDglFUrTBP/SahCKzVjQNhB/axqcEpSmxhMVnr14K9fSzYcWppAhZS5KsF4ZKz
         Tx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770182933; x=1770787733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xR+YOZtW6j/QJ6GBGO3sd3oLXrKw2DbvDwK57pQQ7s8=;
        b=bnOBaSIrvYeGbegM4+bfWYt+y0g0EIYoecs9PlFJWC8N6eUUpd3ahmM2tfkETqChup
         Rdek0CzHXduxlu5b1tlHfx7/CXu8pGytH8CnMDdtfRzyo1YxeynmFsEwu+oYK6RlgjoI
         D4WkXxAEes5+epnbXgrvt3DzvRIn6ZfCklH9jFQPgEUaJHHpp2QCp62LRBWmMZsSmfzM
         TkNhbIV+KAPoUIGsRpqHfQQYt6L5iQjAqbN+JiO8DtQtQLixwelHQFZHMizyu1y6/V42
         vzNP1l3jhUpUlbLHZmuJvXuvyTRiVWohwsZnnQovlN+gXb/5xFhW9ouoPo7gA7qW3qUG
         57JQ==
X-Gm-Message-State: AOJu0YywQl7pvFTYsw+FpUvFniQUk0M4yze5TjOvDc4/p7QppMuNwVKh
	DV4xu0DR5FYUzc+p5pZ6Pv334AFM0tQNiwev5t4H9JWkeESkJah1qXTjwCQ+L40I
X-Gm-Gg: AZuq6aLfZ7XH/3U9/TxXcT6kFwLq2FqyEq+s6vE7L6v79MLRZ5kDrjZ2XaMoGhvIv9n
	oUtbaNS45hIEpuo7DAQpy1seNaO62ehOH61T64TWnqNBbHjcgrB49a4IL73yg8x7SZFYpxHPZh+
	10U0qr7pmT0hVTNj2nDaxEIyfVPeavb5EQY/BC/VIxZg/0/idofCVUcEB4d53nWzwRQgUMezT0P
	aEMY2jKVXIKwVprSp8WvoXauJ69/MPXaRRo5vdfTeCTDuBCtZkYMUJHxjAvg7JTVmLz9R1ncISH
	QbfRpQNIuApTAGnlF62MuarxCL6DvDL2cUsbTPKPJH3NrvnqKeBehYCvDmlKnXt7dD34OiUlSaq
	+h4sSPuJP1phiyKDW1y9TwQYc09EsB10zLJp4MHCHif093Jigef51Is6Dn8oAh/cqXZTynnoVsp
	e1xYGV7lwOUPrPTn7uhQvAdLW0aUVrlTvG+eHiaeOWkw1x63v/OkyU+ffsSQGEmBBf2q0uQlZ6D
	wu9hCKFeVHnyjNm+dVvpOs=
X-Received: by 2002:a17:902:d54a:b0:2a7:8088:371a with SMTP id d9443c01a7336-2a933ea1404mr22076525ad.35.1770182933064;
        Tue, 03 Feb 2026 21:28:53 -0800 (PST)
Received: from d.home.mmyangfl.win (tunnel997320-pt.tunnel.tserv3.fmt2.ipv6.he.net. [2001:470:1f04:2c7::2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397c717sm10745635ad.90.2026.02.03.21.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 21:28:52 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] flow_offload: add const qualifiers to function arguments
Date: Wed,  4 Feb 2026 13:28:35 +0800
Message-ID: <20260204052839.198602-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256579-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AF1EE1F69
X-Rspamd-Action: no action

Some functions do not modify the pointed-to data, but lack const
qualifiers. Add const qualifiers to the arguments of
flow_rule_match_has_control_flags() and flow_cls_offload_flow_rule().

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/net/flow_offload.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 596ab9791e4d..5637747019c1 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -526,7 +526,7 @@ static inline bool flow_rule_has_enc_control_flags(const u32 enc_ctrl_flags,
  *
  * Return: true if control flags are set, false otherwise.
  */
-static inline bool flow_rule_match_has_control_flags(struct flow_rule *rule,
+static inline bool flow_rule_match_has_control_flags(const struct flow_rule *rule,
 						     struct netlink_ext_ack *extack)
 {
 	struct flow_match_control match;
@@ -718,7 +718,7 @@ struct flow_offload_action {
 struct flow_offload_action *offload_action_alloc(unsigned int num_actions);
 
 static inline struct flow_rule *
-flow_cls_offload_flow_rule(struct flow_cls_offload *flow_cmd)
+flow_cls_offload_flow_rule(const struct flow_cls_offload *flow_cmd)
 {
 	return flow_cmd->rule;
 }
-- 
2.51.0


