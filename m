Return-Path: <netdev+bounces-273698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNKXAWv7y2mcNAYAu9opvQ
	(envelope-from <netdev+bounces-273698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:50:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F1C36D3EA
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C1B7307A572
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ED8426ED8;
	Tue, 31 Mar 2026 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Kt3v5YeF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8B42668F
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975131; cv=none; b=JDb+0yF3KcHD+GMNhS2KXkNWCNNK46unwvGzPJNqecV9JB1yxvsLrtTIn+wULA4Nnn/AUywoq3ASIg+vfPakiXhagMrKjQwpibp6SHbYCR2nD1My+mqnfpmYKLek7yZBw+So3+/hdvPVmUKUUmIkqzQ6KlFbBt6kWl4b4hD29Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975131; c=relaxed/simple;
	bh=maW/AdYWuK8BsDS8KSzSgHXYaUMsPA074OQ12rZ89jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rVMDLYSqtqCqpk9lts6yvdXdakHhUg0V5kO4dIeAoI5rT6DNqPdv77kRE+1SLM1OST3bFRNTi7osKFLfGds8KFJwPdBJH3VlfszF4zKv3Wf9Wzq2f4qYVGwirEXBJY7su1baPOZA3oBmcGCqxJzxicDcErZgcEZU1UBvvvAhBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Kt3v5YeF; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d55b97f358so3655858a34.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774975129; x=1775579929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=Kt3v5YeFa4QenhVV6/3Mnz0XS27aLE7i5/XAFoCWCKh0d3DyjxlDUgF0PZhsXrAIff
         BXueTDozJVusCwA8E7UnFlzZSl2loCjbgkG/HLSOKrooRjr2HPyv9TvoGtJalzowomUa
         E5hgWmZYdmsN63Eo0sVl1OGWpuBPv4Y2d5FAc0iw9ad3vmgi6drbrlK3mERGX6eq9YbL
         3xM6HH+t86LPCwBaw7TnW3okObLGGjdsEq2Rw2lCeqjRPX9cpw52qVwQK/7twaWuPEbN
         Mm6lSQUoYh5er0/B/3e0fOKI86iteQ2kP7Ul7L2WCAqzXBKHB+si7M/TUBMpPkryNAsf
         RUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975129; x=1775579929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtDiVIInccujlIt2Sqa5fOCnM6byWdzYUVqLrms+bSo=;
        b=oOS4mFpw4WWDceS1v/ybo3SqIKIhS+rCNBFAnLI0jpIVPbI51R5sXmeoq6EGaqK5O/
         DPvLTuM6SM3tr2L2d4BrZAG1VuCSaUVbKU2mcvDpOpEQsiS3RjDdzBSI4JCjRj2/cjEx
         cOTWD8wo7SY1pfvVFSvOeSpeksA7CMvV94EWTKazlm5CSMwmbSH7tjdaYQCnr3VkVZog
         HtljLRGayocj+LFaKxSh3f93L/9bZ5NhCIuFUcSdznk0ghV7cVjRxcf/u8wGUbJ9P0OH
         PDHB9k9iMqV/BQlB4g0luL2NDxc6Adv5oSqOfuhzlaZlExk8VTqZXB4GV0RvwljJVZL+
         OcxQ==
X-Gm-Message-State: AOJu0YykoN5tcoBf2QKnfw5qm5Ahel3XViEJsncGYew05NaqpbR/4NXp
	04q0pYdaVkqgQ9nfjQhpgpYhsWB3JzTJVSxidmqxiXZGedf680Uyt5202AgMwNZwK5wL+VKPU8A
	frXG2pRyRNA6lJwbot3ZRZj7M2N4JHFpOo+5QNCDXqoQkrbjOjBtNLXgeDs7tUrd3qTRmNTS+3X
	g6gz9+dR5dJ1zVlSPBhfmA17HR/h+QUjItaS6+UCg7xu1YCzg=
X-Gm-Gg: ATEYQzwBJFDoRtsoulPVC5MAJ3lZ54ziKCnT4i5xMj9UWtYcirFqJHtiSiQvtIB9upZ
	TX2VUPSfmCD1FUxe2dK5Bgcars0omr4ibc4BKs/HoOpxI+B5HH5xhwLmj9gJ4v2l9QrMMMkMvcZ
	drMQZAUSbPwOTSuhWtYMSv5BIdhfXUDvCiAoKQ8pRHP0zQQMYEiN0yHn58wGfpCVDU2J+o7qXV3
	CBboBOi0NUGLxJRG95vEKsfs3Cj4ogZtOaPA4JzLfCJPcbufT9ETVIFL6zOxOZH5HrRxRUAEVO6
	F8GykV1Zs2ttOfuxEkPO0+8SueEJQTebriPULnbU2awA1RqoYPf3JnUvWIIRECeRiiiCGLK5Ra0
	Ow7VPVNIcF7o3YOuvXUkdJO3LDlD6dIgfnNfiiawHVqOIFcWmalORRavyveAR1nKJTwALn5cqNY
	ljnYH7LbcaBImr4HoPB2lAaePEc8KS5jvHD7laWnepa5A3TXIjmyHS1PWZWkFZaxB6P2gs5ovy2
	t8=
X-Received: by 2002:a05:6820:905:b0:67e:4004:dc93 with SMTP id 006d021491bc7-67e4004e235mr1590843eaf.29.1774975128518;
        Tue, 31 Mar 2026 09:38:48 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-41d04d79c35sm7599651fac.18.2026.03.31.09.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:38:48 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v11 1/6] net: tls: reject TLS 1.3 offload in chcr_ktls and nfp drivers
Date: Tue, 31 Mar 2026 10:37:52 -0600
Message-Id: <20260331163757.149343-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260331163757.149343-1-rjethwani@purestorage.com>
References: <20260331163757.149343-1-rjethwani@purestorage.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273698-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97F1C36D3EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These drivers only support TLS 1.2. Return early when TLS 1.3
is requested to prevent unsupported hardware offload attempts.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c | 3 +++
 drivers/net/ethernet/netronome/nfp/crypto/tls.c                | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index f5acd4be1e69..29e108ce6764 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -431,6 +431,9 @@ static int chcr_ktls_dev_add(struct net_device *netdev, struct sock *sk,
 	atomic64_inc(&port_stats->ktls_tx_connection_open);
 	u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;
 
+	if (crypto_info->version != TLS_1_2_VERSION)
+		goto out;
+
 	if (direction == TLS_OFFLOAD_CTX_DIR_RX) {
 		pr_err("not expecting for RX direction\n");
 		goto out;
diff --git a/drivers/net/ethernet/netronome/nfp/crypto/tls.c b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
index 9983d7aa2b9c..13864c6a55dc 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/tls.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
@@ -287,6 +287,9 @@ nfp_net_tls_add(struct net_device *netdev, struct sock *sk,
 	BUILD_BUG_ON(offsetof(struct nfp_net_tls_offload_ctx, rx_end) >
 		     TLS_DRIVER_STATE_SIZE_RX);
 
+	if (crypto_info->version != TLS_1_2_VERSION)
+		return -EOPNOTSUPP;
+
 	if (!nfp_net_cipher_supported(nn, crypto_info->cipher_type, direction))
 		return -EOPNOTSUPP;
 
-- 
2.25.1


