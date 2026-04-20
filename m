Return-Path: <netdev+bounces-279879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLDlE0Rg5mkxvgEAu9opvQ
	(envelope-from <netdev+bounces-279879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:20:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AF0431020
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 251E1300D77D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43583A1D1C;
	Mon, 20 Apr 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+/d1ek0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BA3A16A3
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705527; cv=none; b=WRTTw073ZtF9tAxfYAbecu6Dp3JNAG9EdbKw7J3Db1YGpJGwsl+HHSYtdhVa1qk74LUemiQrLocqwMA/irSLeOBl9vbOt1OnDEYLE8gqX0y78hpam3L16ZwGfVzIoaOG2eNwhdw88vKBEkDOI7+tfrIGa/JzDW9ouJg8XO6en8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705527; c=relaxed/simple;
	bh=8O3b3Qe7OMgCHoNg+DiP0hK3ss+m+yydWKT5V3D/PVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kB7B6nDMWxeq6E/xLjk8ppgwsL51Rmf7Buy+ppcr+u16levoWCt1VdeuBHLAKLDmJhVfViSuYhC4gWSy7mBKWJo45FkFjgMdfnyao6kZpBr6lRagk31U3oYvugx7OCmAz47cfZfxGC23O+zviw2Zj87xZwwvVyjRcj9XkEuS70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+/d1ek0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35fbb5779e8so3807017a91.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776705526; x=1777310326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2Wff/1M87WllLQ253qBp/0GFiYpAWG5OoBPum9csgI=;
        b=s+/d1ek0eYWKyo9FlOJl6eodJwXQY176qnv47efPy9x8rtd0/whgzHB0FRj8nATz9J
         CHbokX4bCrDScuJSQxO/WS6XEga6DuoVVqT1qIGdnhuytXsyhYyL5mOvxyidrgY47KvY
         axyG3P4d9aCdFDaRi8iHLirIssUoewM3IRQBzQITiMVP/tBWKuZrFzNzXZvQ9QvhKahO
         Q5UU8YLvE2c1q4CedpiaPk86Zhizn/vmGxe2g751E45OVaY2iO/AS20lwEBgbhW1SbNa
         prOcZaRow0kWLvSFGiLk1dPKG1yq9f1omZI3QK8owZu5HzZqkwSZlfNL+Tk7T0UQOFAJ
         TMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776705526; x=1777310326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2Wff/1M87WllLQ253qBp/0GFiYpAWG5OoBPum9csgI=;
        b=PcxkjiynefY/M4u7S0lPKl5uZU0KQgXaL3i5jMcwfDiMqXoSI8nbq7CWKGR4/CKn39
         y7K2X/cZ4sBZtpaDR5Cp1t85Iu0X/EtnS18DcWnJIS+8fjM2TwfI2jPD7D0iNVw92QZW
         spEKiz8BNO4z4Rm6Q/TzopOjexrsGa7sEq+itRYWFuV/k9fgRNYxk2CEB5LmyFn6f7In
         Cqy8BcXQlU/AZkEUAKDtzqGXIQ3sYxYnaB0Jdw9c63UvAz33s5KPaSkKWzDc4OkO5yi3
         TPjrFvsqVejMr1SnmPLJmbhBveJ4jKt5lT1dz+SnR8Ms6WCscxcILgAyw9OenKI2Eckm
         zCQw==
X-Gm-Message-State: AOJu0Yw1saH7Bv3cBupYQ49H7lNmhvlYOTnOOPrrw4LZfX5LSwX15uoo
	ssrMOJBtN/AGCxJrBZPIejUVTH28mK3vSwLmEiHqRLJnk4Rd1P7pcCGfsTYIhsLOYwRF33i/8CF
	qT66ngppNi9pe52o8UjVI8WQfJVbKzXX4evX/jTqmGVgw9nTIWRiiiu6VgLIf4WR0PusElxr88s
	1Q05j3tDTqQ37cD6GEEI3KvAXIo5TOFm5o2Wfz4MKEnIHxWiCh0w8CG3jt14xedzo=
X-Received: from pjbge22.prod.google.com ([2002:a17:90b:e16:b0:35e:4617:916b])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e704:b0:35b:9896:cbcd with SMTP id 98e67ed59e1d1-361404b9b70mr13958806a91.27.1776705525487;
 Mon, 20 Apr 2026 10:18:45 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:18:36 +0000
In-Reply-To: <20260420171837.455487-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420171837.455487-4-hramamurthy@google.com>
Subject: [PATCH net 3/4] gve: Use default min ring size when device option
 values are 0
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279879-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6AF0431020
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pin-yen Lin <treapking@google.com>

On gvnic devices that support reporting minimum ring sizes, the device
option always includes the min_(rx|tx)_ring_size fields, and the values
will be 0 if they are not configured to be exposed. This makes the
driver allow unexpected small ring size configurations from the
userspace.

Use the default ring size in the driver if the min ring sizes from the
device option are 0.

This was discovered by drivers/net/ring_reconfig.py selftest.

Cc: stable@vger.kernel.org
Fixes: ed4fb326947d ("gve: add support to read ring size ranges from the device")
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index b72cc0fa2ba2..57d898f6fa82 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -189,7 +189,9 @@ void gve_parse_device_option(struct gve_priv *priv,
 		*dev_op_modify_ring = (void *)(option + 1);
 
 		/* device has not provided min ring size */
-		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
+		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_rx_ring_size) == 0 ||
+		    be16_to_cpu((*dev_op_modify_ring)->min_tx_ring_size) == 0)
 			priv->default_min_ring_size = true;
 		break;
 	case GVE_DEV_OPT_ID_FLOW_STEERING:
-- 
2.54.0.rc0.605.g598a273b03-goog


