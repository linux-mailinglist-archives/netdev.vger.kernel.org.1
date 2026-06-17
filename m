Return-Path: <netdev+bounces-300124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gtc3FaiCMmrZ1AUAu9opvQ
	(envelope-from <netdev+bounces-300124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:19:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C12D698F7A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:19:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TbOgSs1j;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300124-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300124-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8CA5304E709
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1869E43DA2C;
	Wed, 17 Jun 2026 10:39:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9108472784
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:39:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692793; cv=none; b=ADHIccubVu0pWHpUCpJi/d1qvx/fydV7rl3MLblBCfQQ15Gq0+OPMI2EahEckcK4Y4fBGZsV2qBMJU3f2DqnuXxMHTpRKQQuNSdOJifZFyFjwoFWVuTDotnvpogQX3YZO/ocbTUWeDF09RuMbVdWlTFBZQdvIHVC+iPFnMityo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692793; c=relaxed/simple;
	bh=htOvcjZ4CsMmi1DdyvtItQNH5Qwzow/8A6rf+XMNKxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u3T9dkI9OFFuP3D5XF7ofqhuDszqYbkAafBG+dkyWBjCWTrZhPg3JIRaX0TQSKMpr+Kcus5/xFjT+iGqvPR+9fAqhjJI5HRgyYS/YH3m3fB71k6LdbmoEodW3Ij+5eaxS3gANEAKEry6EVlfo1OKk+XWNFym2vAhJixsWDPg1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbOgSs1j; arc=none smtp.client-ip=209.85.210.44
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6f8f26d66so500462a34.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781692791; x=1782297591; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8FUq+t1MD6e0BapUC7ZG/YO+GJ1PMmP2ipHDCZaaljU=;
        b=TbOgSs1jJHc34rWX+WntOrRqBVfK8VluOem6uoYtMu+kDgRYdE0rQuHhTfEzMKU+om
         i6mQkrl8gvNS2Yy87Yphcam5i1nh0pf0eOEy2A3cHfgKNhmr22611AAy2FxPnfRJkVEa
         /+c1aQYefoMdT/COpNuHXeaCQOPaMtD75Pq1UNlkPpqeIm7K5Xoo7EanlHwXXq3ENbGF
         sO1Ps78PdMHJ3q4NyJ5E981xYDg08fIFalFwEqSUbS9v3wdau7XpOqugTfGkJLVsHcQd
         uRa9VJaRtQW1kcH40IZefk4umCrc/dZcgmw6wF1lD55KufU66/J/RX/tUIXKkpEYT0K1
         LhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781692791; x=1782297591;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FUq+t1MD6e0BapUC7ZG/YO+GJ1PMmP2ipHDCZaaljU=;
        b=UxDfMdzMKuSDPH6Lj3Q0sHvgZjQg5n23HbgorSSO3JoAKRTNaydA81dABRcV+fSO4h
         cRr2AYUMmC+O6zoMYxhlk1hfeBjaAWYvK8N+xbGqYgTCcxM0RIe3fuClW61ChEhvDQZO
         gwmGlaTnNDDcrFZb9NdlSRH8Smn1A8BLvG+wZZmo7c1cpEhi+tkJ7lI5F6YLiILw3zx4
         871B7egv9hSfwWMo9GkprPNIocsAigkHESJG66qjnEixOXfXmmce9b/JvlEOhSU1fjV7
         wuxPBQuY9XiOv33VIpWE+8TAQWL2EPi/zUA6A0CZq8n2ujZB7fBo3tc1dWlaec2OqgLA
         QakA==
X-Gm-Message-State: AOJu0YwQGzO1i5dn2uXiD1gQEEiHGtL/L5vR1RqroHKZNSfkIYrRJvlv
	Pc6/OcOpe+dxzb4lmBOhwYviZAfQA5SbyTmDYs45moKuXu3ourNTMrvl
X-Gm-Gg: Acq92OGRLjrgQkBa2dBD/I4bx83JcM2OrITy2+pLlX3YnWvdGin474zQyfU1rPnbpFA
	a5A6qrztS8wFdemn5U7VNSitPh7Ocuf0+SSUOe0oCkkQZ3oCO4ORptOLyn4R8JIFDKLcI8KkIvT
	WNEC7iQqoyNKYZ6FCmaWYMzk3tggopkqvFAqMABNN3+d/j04tWQ9bQGlO6fJWMgpzzWGyGUM3zg
	ZpHKaGslYZJM6N94GLPcBHrw0gJNHDrj2Ex3ZFpePsl3MAaSB3+NB30dQ+d3XAEStdOxMEkf0TY
	CrZlkqUCTv6EGX6ncZqKbdhmH/kz630wnoi42d855VAkvJTd8bmk/4KmztCzTiPVv+JccYgfhoR
	HDyEHmQa4dk1KTjzZZld4y8OxjD4sEm9ND/lXuTRwB//ri1jS6civ9O/hTt1h2uRlVseoMEvFnO
	JnRN/AGxWAvg==
X-Received: by 2002:a05:6820:290d:b0:69e:88f3:14ac with SMTP id 006d021491bc7-6a0b7af38dfmr1503581eaf.18.1781692790790;
        Wed, 17 Jun 2026 03:39:50 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-443090386basm4047202fac.17.2026.06.17.03.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:39:49 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 17 Jun 2026 03:39:49 -0700
Subject: [PATCH net] eth: fbnic: take netif_addr_lock_bh() around rx mode
 address programming
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-linux-fbnic-hwaddr-v1-1-3f9f5dee7f99@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHR5MmoC/x3MTQqEMAxA4atI1gZsC1XmKjILTVMNSEba8QfEu
 1tcfov3LsichDN8qgsS75LlpwWmroDmQSdGCcVgG+sbbzwuotuJcVQhnI8hhISRO0dErSXjoIR
 r4ijnO+1B+Q/f+34A1Z+3CmkAAAA=
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Sanman Pradhan <sanmanpradhan@meta.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300124-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexanderduyck@fb.com,m:kuba@kernel.org,m:kernel-team@meta.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sanmanpradhan@meta.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C12D698F7A

When __fbnic_set_rx_mode() is called from contexts other than
.ndo_set_rx_mode_async(), the uc and mc addr lists are accessed
without the addr lock that __hw_addr_sync_dev() and
__hw_addr_unsync_dev() require. Wrap these unprotected accesses with
netif_addr_lock_bh(). fbnic_clear_rx_mode() has similar issues.

Fixes: eb690ef8d1c2 ("eth: fbnic: Add L2 address programming")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 7 ++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    | 4 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c    | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 4dea2bb58d2f..44c046b25312 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -262,8 +262,11 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
 
 	eth_hw_addr_set(netdev, addr->sa_data);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev)) {
+		netif_addr_lock_bh(netdev);
 		__fbnic_set_rx_mode(fbn->fbd, &netdev->uc, &netdev->mc);
+		netif_addr_unlock_bh(netdev);
+	}
 
 	return 0;
 }
@@ -308,8 +311,10 @@ void fbnic_clear_rx_mode(struct fbnic_dev *fbd)
 	/* Write updates to hardware */
 	fbnic_write_macda(fbd);
 
+	netif_addr_lock_bh(netdev);
 	__dev_uc_unsync(netdev, NULL);
 	__dev_mc_unsync(netdev, NULL);
+	netif_addr_unlock_bh(netdev);
 }
 
 static int fbnic_hwtstamp_get(struct net_device *netdev,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 7e85b480203c..8b9bc9e8ea56 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -135,7 +135,9 @@ void fbnic_up(struct fbnic_net *fbn)
 
 	fbnic_rss_reinit_hw(fbn->fbd, fbn);
 
+	netif_addr_lock_bh(fbn->netdev);
 	__fbnic_set_rx_mode(fbn->fbd, &fbn->netdev->uc, &fbn->netdev->mc);
+	netif_addr_unlock_bh(fbn->netdev);
 
 	/* Enable Tx/Rx processing */
 	fbnic_napi_enable(fbn);
@@ -180,7 +182,9 @@ static int fbnic_fw_config_after_crash(struct fbnic_dev *fbd)
 	}
 
 	fbnic_rpc_reset_valid_entries(fbd);
+	netif_addr_lock_bh(fbd->netdev);
 	__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
+	netif_addr_unlock_bh(fbd->netdev);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index fe95b6f69646..bc0f38b6a2b2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -244,7 +244,9 @@ void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 
 	if (fbd->fw_cap.need_bmc_tcam_reinit) {
 		fbnic_bmc_rpc_init(fbd);
+		netif_addr_lock_bh(fbd->netdev);
 		__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
+		netif_addr_unlock_bh(fbd->netdev);
 		fbd->fw_cap.need_bmc_tcam_reinit = false;
 	}
 

---
base-commit: 406e8a651a7b854c41fecd5117bb282b3a6c2c6b
change-id: 20260616-linux-fbnic-hwaddr-fe83ccc72c13

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


