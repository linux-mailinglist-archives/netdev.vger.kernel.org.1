Return-Path: <netdev+bounces-271569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yITIDbfqw2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:01:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5613264FB
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAF8930AE924
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FAF3CC9FE;
	Wed, 25 Mar 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="C6kqXCoc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f228.google.com (mail-lj1-f228.google.com [209.85.208.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53E25E469
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446286; cv=none; b=S/tN35QlpP/+x+lJ5AHYYA2lB+nVxolwmSkfT8piTXYu6ndbeRLq0+QRrUl59RvMUR+zMywl1iEZPPY0RslaJxmbhH7UJu0kPlllYL1WhT1sgFuoHtJSw9CkaS0J/wFTjxJIXXo0q8uX8xdzPdFZJ26W5rYtAycfgbNnL7hIN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446286; c=relaxed/simple;
	bh=94WAVCejm7yjl+nIPIpo7hT75xUfhlHUlWEmMNuUklI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3mG7G1liqchprv27pGtS3qvdhIAiXwRte6LGE31jlR1t+VVdAezCz6BX2oqZa9b0E4onzr6VTqFUgk9sjdti9ctAUg/TKLoTBWKclJ+Awmf111wssxpmIe1kykWXP3mNeQzv7xDBc+Hk96rfDo2CVnUFMpEEQ1Nlf0nFxxXKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=C6kqXCoc; arc=none smtp.client-ip=209.85.208.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f228.google.com with SMTP id 38308e7fff4ca-38bcdda57b0so48334891fa.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 06:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774446283; x=1775051083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUsfoehVn5lZkFzrVLzZekZIzik8pjiRUWjdJgKgZ2c=;
        b=C6kqXCocLiXvAVQv4qcE9Ay/YbME9hczdlH2FHP884k6VrI/RPjandFtE9zPpxfeV2
         fBpgHN1KqoOsb22dUxy0eNBKr70gReRezJRjOJJOphAyD28xqWklfsXDalc2yStqbmiq
         bcJkYVmHC4JeQB2I29jER8mxsT0fQi8boKZN5yZmJCWdqdo2pdD+8R02wxGHfFrzSwl8
         EwokxjbpPzb3AqfhLR+nsWwz9/vHjG/7EcqnBOEen3tkAJ6Ykv9tPd49kKU+W9dYzO5N
         PiS3bXp5pYe2qiaj87Og/IKq0hMZAMzksIOe688O7XGnWWS/eZL65iljGbvNuJTxiEz/
         lgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774446283; x=1775051083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IUsfoehVn5lZkFzrVLzZekZIzik8pjiRUWjdJgKgZ2c=;
        b=JvvWZV90S8ma7Xkml8i3HyOoQ2MYsGRRtjbR1hX/gamKXE5x4E+JMrLIIjnKPmXZcl
         uM8Bo1BxilWSWBIaFtaTQ9NT6TtCDmpYRKg3HtAeu6zoh3mwTKBPMXqdGLZVAMwZlui6
         Tocc5hI42y+r2wEt/gj5OoBfYrYbHi05bPAqM6zk2scJS57BWTQ4Gn8q/cEdWOQqGB4y
         HVPTJP7cjyfdkuefFLbfM55lbmAgfihKU/A5rJdxvM3IcDz/HDwvtt60JvkJOxeUhwzU
         NWPduXZ34JYjJ8RCSIbynhKEsHE1ckwpsKjF+j+lL3uWXk8bqwxj+F4CrDdmA0rMme1t
         AyRw==
X-Gm-Message-State: AOJu0YwNmULAMkq+FxQwd6cV+JM17SMuALh/9ZibYt1KEDfyR5cp1ZjY
	6N26DqmPDvcCkLtme/8um7eZpAiZKCLVmUM6KmcEklZQ26ZFqS3qMBM0txmw3CI6VHJ3hvxId0i
	9sZhflHDh9rUVrASI44k3eIInSlZ/qbJJTA15
X-Gm-Gg: ATEYQzzVNMUbjRftBfR0Esp3S7ZY0l3U6TI7o9j0jAedUaEuoLOzpJdk1bWA4PbQMmp
	yr4B43orZSgsjNKg9HcnpUSBjG+VvRPrt7IQyOEVPJ/k7aqMdp85YJTMlxu4hW9pMmOhkBn9HEp
	kuFiZa3VBDVHpmuJKxfVXTYPxTeSpOmMyKAn7X0rAbZbp/Zr5f9zNqkVh5Y4peEPdFc2RDBs7Pq
	JYTKx41QrGFi/lR1fWPTuxGcuCmHL3R+f/nCCfW6kd3/ZPOIcEw3t9ljCen1hOpagOcv4VKCjuW
	p0JRvjt/fmfdMVJbTpIjm7iaBB0JlG4XQaS4NVtYqMx5dgr89qMXVXRm1q8A4ZpgZYRKjPbL9xC
	GwCWDkHwpCPDpN+R+f6SPlyfq0osN9FEwGyMDwKEQWUVyh5RBfwhV
X-Received: by 2002:a05:6512:a86:b0:5a2:82d2:c50a with SMTP id 2adb3069b0e04-5a29b999cfamr1152601e87.40.1774446283035;
        Wed, 25 Mar 2026 06:44:43 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5a29ac06006sm317595e87.5.2026.03.25.06.44.42;
        Wed, 25 Mar 2026 06:44:43 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 7798F1EF70;
	Wed, 25 Mar 2026 14:44:42 +0100 (CET)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v2 3/3] bonding: 3ad: fix stuck negotiation on recovery
Date: Wed, 25 Mar 2026 14:44:39 +0100
Message-Id: <20260325134439.3048615-4-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260325134439.3048615-1-louis.scalbert@6wind.com>
References: <20260325134439.3048615-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271569-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid]
X-Rspamd-Queue-Id: 7A5613264FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The previous commit introduced a side effect caused by clearing the
SELECTED flag on disabled ports. After all ports in an aggregator go
down, if only a subset of ports comes back up, those ports can no
longer renegotiate LACP unless all aggregator ports come back up.

1. All aggregator ports go down
  - The SELECTED flag is cleared on all of them.
2. One port comes back up
  - Its SELECTED flag is set again.
  - It enters the WAITING state and gets its READY_N flag.
  - The remaining ports stay UNSELECTED. Because of that, they cannot
  enter the WAITING state and therefore never get READY_N.
  - __agg_ports_are_ready() returns 0 because it finds a port without
  READY_N.
  - As a result, __set_agg_ports_ready() keeps the READY flag cleared on
  all ports.
  - The port that came back up is therefore not marked READY and cannot
  transition to ATTACHED.
  - LACP negotiation becomes stuck, and the port cannot be used.
3. All aggregator ports come back up
  - They all regain SELECTED and READY_N.
  - __agg_ports_are_ready() now returns 1.
  - __set_agg_ports_ready() sets READY on all ports.
  - They can then transition to ATTACHED.
  - Negotiation resumes and the aggregator becomes operational again.

Consider only ports currently in the WAITING mux state for READY_N in
order to avoid __agg_ports_are_ready() to return 0 because of a disabled
port. That matches 802.3ad, which states: "The Selection Logic asserts
Ready TRUE when the values of Ready_N for all ports that are waiting to
attach to a given Aggregator are TRUE.".

Fixes: 655f8919d549 ("bonding: add min links parameter to 802.3ad")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 drivers/net/bonding/bond_3ad.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 1771e406224c..86657de7143d 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -700,7 +700,8 @@ static void __update_ntt(struct lacpdu *lacpdu, struct port *port)
 }
 
 /**
- * __agg_ports_are_ready - check if all ports in an aggregator are ready
+ * __agg_ports_are_ready - check if all ports in an aggregator that are in
+ * the WAITING state are ready
  * @aggregator: the aggregator we're looking at
  *
  */
@@ -716,6 +717,8 @@ static int __agg_ports_are_ready(struct aggregator *aggregator)
 		for (port = aggregator->lag_ports;
 		     port;
 		     port = port->next_port_in_aggregator) {
+			if (port->sm_mux_state != AD_MUX_WAITING)
+				continue;
 			if (!(port->sm_vars & AD_PORT_READY_N)) {
 				retval = 0;
 				break;
-- 
2.39.2


