Return-Path: <netdev+bounces-271727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAtTGv5BxGlHxwQAu9opvQ
	(envelope-from <netdev+bounces-271727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:13:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEC332BB1F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B40993077D39
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E73536828B;
	Wed, 25 Mar 2026 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LKnSy6Yt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19B367F5C
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469521; cv=none; b=iRBtIlUTzAatetmmtTyaxomY1bMOKXNiy/8+DjvW1AaPVWZ5dBkZjOHnMMPnDPSvYw607beM4Bfg3wPluGUejUMfCysoA2+4g32HREtBZzpKy7GRsp5j/tqKZo/cow0/jiLWEGSdGXMoeOr0NvXiOUJXJsIZZOtVcSRfyLsLIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469521; c=relaxed/simple;
	bh=AMSE7Bs/MZKuLM6hrnKnX+2i7bncB0wloo9AGDyWfUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5LJD4iO57S17mWiSz/4aald6H6XR6xXrjOOB81KEJT0gMrErfXjDQ/QI0aN/t/8WtUsQxEJLeSPSYyXJ8H9BlJgXw3HLIFQgysl3orf2LKpcpD3YbxhI5hOo+Qc/Fc6I5UfUWyK9RtRyc/q/WE32WRe4NGPQdPfvCNeQZK6OOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LKnSy6Yt; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-67e00a230adso196642eaf.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1774469516; x=1775074316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqHZwYBZ42AZ2CSQh5u+QvxE5CToH719GXie9Td1RjA=;
        b=LKnSy6YtzsxvjgOg4Bm5JREE98sq5NRvIlyBjxVbNklC5YK/3eQeDuMcs/KyuXk1Yn
         RAADCWLm3chd25MOc9fTIopW3jIbqPXNgQMd40qEQ0eQaJFY5vx11EcdjdZP+0BxlBUd
         g95I0hK+yNh+xQSB74O90o9/qmr1Qm80EyiJ2sUe5iY9MS7Y0SumcRJfyWXxe0p1SAkt
         44lFzJx27QO8cLMn5U3Rq3h0y3cliz1LNAvuK1HVeJuDbIp0Yc7wBRvmT7M7fudeawd1
         4wLsUh9psq7mMnvwkE28rtK9REQd9JNzMsK1BS1SXP9Kcq7FDUCrkDYxVWcCuHci37QW
         9/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469516; x=1775074316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jqHZwYBZ42AZ2CSQh5u+QvxE5CToH719GXie9Td1RjA=;
        b=rA7EclMy+9U4RBFqdn4EeXUb7MMg7NxXLclko5Z8mlj0AFe/HsRSq0ezmjEqF246vB
         5mE/RP6BCbv3SLtLdK0ORd0AwzcGozMSMPHmxUXQSNQ8JhgCxZmJ6zr3QIKFdjhK9ZtM
         pEEVpW7BJF7os/mJ0rSXW4Es8pVX44YMYIseO5qPIvceReMrEIrU8UzoSU35rEzWtHZd
         SuEl+k1Y/jZcZlU4zsJH2rrkEgwSO37Vyq0nTUdTkjC5gMVDABylFdi60pZ3OfiG78zN
         XIF94YOafKNR7YIkGio9M8zHkc7dR27UgRbHrMFXFthfjODGpUovZ2a4IxiIEGqkTJUU
         zJuw==
X-Gm-Message-State: AOJu0YwMEJHg/0zgysCTi8oRoX9An2gr4CiLN3aH42MMUiLlI01ffIrk
	FVdmWn0Vdh/cLFn3PXbeb2242pwyHY5z8YrxRVElm4wXlFZ3Mcu05hB5rPAQkvZYhCJoagI7ijU
	UaEWlgQegxg==
X-Gm-Gg: ATEYQzzKRFbQSoTz3wnYrgbgBmqvrIGZRVIaDnvvl6jlbVR8RFtUG/dNCadlo3qi3Xj
	0cG51bwfIejinP3As7IkKdpSfRReTr2np3Z2NosAdtZdwfC5Vl3+jMGGXz0AfARElOG0N09d0Zy
	A5USTGpcaIobnrLVorIodLMANsaADt2WYgg6Gyi6uXe+9+I18QRPLPwUngun/B+8lI9/nrB3Bfg
	QJClWcer1b5gKg87c+12JoAMHY8Fwk0Yb21D7PJvceR1P7YiW5aGe1h31xVkejtc4KkmWRW8Q24
	0Q+ZddF0ilw2URSkmOPq5bYkmGlq9s246jX+7qaqImXfDCixCAQiyz0f2O96lOzf3oMEVx/4m8H
	Fms8axPUR6CHPavw6xpGSJphuqpro54uVzMB3nZtaL24jj/W92lOXmHFxTIIE2AP870uvIq6b2/
	UeQ6YHWRa23dWtyBUJYdykioc=
X-Received: by 2002:a05:6820:1506:b0:67c:e09f:39dc with SMTP id 006d021491bc7-67dff24ef04mr2529701eaf.0.1774469516464;
        Wed, 25 Mar 2026 13:11:56 -0700 (PDT)
Received: from 20HS2G4.aus01.local ([2a09:bac6:bf21:2632::3ce:1a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab274c7sm549764eaf.13.2026.03.25.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:11:56 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net,
	joe@dama.to,
	gospo@broadcom.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>
Subject: [PATCH net-next v5 4/6] bnxt_en: Implement XDP RSS hash metadata extraction for V3_CMP
Date: Wed, 25 Mar 2026 15:09:50 -0500
Message-ID: <20260325201139.2501937-5-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325201139.2501937-1-carges@cloudflare.com>
References: <20260325201139.2501937-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271727-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Queue-Id: DCEC332BB1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds another conditional when cmp_type is CMP_TYPE_RX_L2_V3_CMP for
drivers that support this completion format.

This re-uses bnxt_rss_ext_op to provide similar functionality. One
limitation is for L4 hash-types, protocol-specific bits can't be
determined.

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
v5: no changes
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 1f920464b426..babcd463e50e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -514,6 +514,16 @@ int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 		default:
 			break;
 		}
+	} else if (xdp->cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
+		struct bnxt *bp = netdev_priv(xdp->xdp.rxq->dev);
+
+		if (rxcmp1->rx_cmp_flags2 & cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE))
+			hash_type |= XDP_RSS_TYPE_L3_IPV6;
+		else
+			hash_type |= XDP_RSS_TYPE_L3_IPV4;
+
+		if (bnxt_rss_ext_op(bp, rxcmp) == PKT_HASH_TYPE_L4)
+			hash_type |= XDP_RSS_L4;
 	}
 
 	*rss_type = hash_type;
-- 
2.43.0


