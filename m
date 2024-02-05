Return-Path: <netdev+bounces-69289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBDD84A951
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9C628F2AD
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4712482E6;
	Mon,  5 Feb 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fTLjb5zJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EACB41746
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707172341; cv=none; b=TOZoYkdAaIdAIjRZOfutfDgjpH70Mc0w0CKw7UfAKmhb4NDvwHSxMMX+3qbtbOcRxTLMzN7g+seDz00WtFteWbsRmaYnE6WwOPAe4s+1SJEdN3RpeV+nu/q8qGcLD9gM9P87gaLugOKZjRGIst1xqYPRN8QtoY3Pa73nly8LCh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707172341; c=relaxed/simple;
	bh=KhqOVtn0nvtmIhPJR3UQui/tjKKWd4Ht/3vN7k78Q4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyrKdTxatMuFAk3qkEmitO/0rhPcH4HWwdzTllMhIvCla1rfYtxCma1HBEO9+vnhypRwxDzdzTfag2M6wAOo4K0b9CzrD7JJpryE+o00VZ3wE/ZU9BshEC9rwdUzDfQL1n0Ojr29/oPn9WEDXYR9F8ByzKJ6U3MKZGJ1XH+/vc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fTLjb5zJ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e14b858785so3199383a34.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707172339; x=1707777139; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/n6wG2nL+MfKB6pnX8UOLwYoNxtUZuVinAHTc4Vw70=;
        b=fTLjb5zJEPpCtyBd/vr3zCYPSR3PptGHjPCruiksmXLkJXgBHKhJoISPduVrirGmMB
         dLYaUo+eebKq3UcC9TlI34GVC9XuHxA71i2FXBll1HkwMfQm2nMKtNRetSCqgUuW1u4L
         TV0Kjk9dkfvDFnPk7Lvzw+DvkUsKq3PocUsrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707172339; x=1707777139;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/n6wG2nL+MfKB6pnX8UOLwYoNxtUZuVinAHTc4Vw70=;
        b=Xk0K9Nibiatek9MhzRYvKYYjJJc0qHScIxF6j+M4L0/h2ApqmVlnTQyXO4b7tdxUE8
         704l/N3OpSJDkI7e0B+9uZTFiojs6p3yM5QJYuKryMbjlEW0uuadgBy5mDEpi4Jui4+Q
         D82UXNZsYieSR94hvgRwKyZynQWrHJlaTa4kKY6I0EB53WnPM+Fq9Q7zz3xBmFUlIb3E
         toBkc0SBCPo0bbb+0nkzbj7SfXrWfWws//3W3gkMpNQ3Lf+6db0a+Tkz0GUpw+Fn05xv
         /MZQh+/spdRFUAsrfZDUxZBAI6gKSV5AuWPf0eVk09QZEe+Iho46eHOPoSAMJofG2iHM
         f4qA==
X-Gm-Message-State: AOJu0YzbsKVIaXOWXe9ETZVOBeoLYfhY2GQgmKW0TnPMMUuAEwx1xqW1
	i6NoGq8eyBbtT+5uDFZb14o/S8vfxmJ22ahRzDvFPEo4ytpatqXX/xV+JhHvi9ct5D14KeL7ixg
	=
X-Google-Smtp-Source: AGHT+IHWpCKOa7sbFBLFaGJE1A5RBk0DSbVYrOt8AMWJxXArrmcuL5P2TejXK/XgEvD/BitgWYOy5A==
X-Received: by 2002:a9d:6299:0:b0:6dc:5d73:d744 with SMTP id x25-20020a9d6299000000b006dc5d73d744mr1077023otk.23.1707172339026;
        Mon, 05 Feb 2024 14:32:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUwoWma2G7eCPfTznX+nH6IeLlb9TTys8YodM+84MMJDvmLdQRR3gkgX8G5JrXYp1HrlTeGog+nro5aehlh3QCq50PqAEfdGP9kTnDZhOGPREDj/Vc1MHA/4USrKtghTlsp+oRa4kZ62YeT3hrqDL/Rez8HmySRDMrQ6HgOOzvMi2B966I7IbBq5+/KDjeps487bjpWSe1HyyEtJU0rF2V9e5U=
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x11-20020ac8120b000000b0042c2d47d7fbsm340864qti.60.2024.02.05.14.32.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 14:32:18 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next 03/13] bnxt_en: Support ethtool -n to display ether filters.
Date: Mon,  5 Feb 2024 14:31:52 -0800
Message-Id: <20240205223202.25341-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240205223202.25341-1-michael.chan@broadcom.com>
References: <20240205223202.25341-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000de33e60610aa0842"

--000000000000de33e60610aa0842
Content-Transfer-Encoding: 8bit

Implement ETHTOOL_GRXCLSRULE for the user defined ether filters.  Use
the common functions to walk the L2 filter hash table.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 38 ++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 3cc3504181c7..da298f4512b5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5484,6 +5484,7 @@ static int bnxt_init_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr,
 		if (bit_id < 0)
 			return -ENOMEM;
 		fltr->base.sw_id = (u16)bit_id;
+		bp->ntp_fltr_count++;
 	}
 	head = &bp->l2_fltr_hash_tbl[idx];
 	hlist_add_head_rcu(&fltr->base.hash, head);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 2d8e847e8fdd..4d4dd2b231b8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1058,11 +1058,17 @@ static struct bnxt_filter_base *bnxt_get_one_fltr_rcu(struct bnxt *bp,
 static int bnxt_grxclsrlall(struct bnxt *bp, struct ethtool_rxnfc *cmd,
 			    u32 *rule_locs)
 {
+	u32 count;
+
 	cmd->data = bp->ntp_fltr_count;
 	rcu_read_lock();
+	count = bnxt_get_all_fltr_ids_rcu(bp, bp->l2_fltr_hash_tbl,
+					  BNXT_L2_FLTR_HASH_SIZE, rule_locs, 0,
+					  cmd->rule_cnt);
 	cmd->rule_cnt = bnxt_get_all_fltr_ids_rcu(bp, bp->ntp_fltr_hash_tbl,
 						  BNXT_NTP_FLTR_HASH_SIZE,
-						  rule_locs, 0, cmd->rule_cnt);
+						  rule_locs, count,
+						  cmd->rule_cnt);
 	rcu_read_unlock();
 
 	return 0;
@@ -1081,6 +1087,36 @@ static int bnxt_grxclsrule(struct bnxt *bp, struct ethtool_rxnfc *cmd)
 		return rc;
 
 	rcu_read_lock();
+	fltr_base = bnxt_get_one_fltr_rcu(bp, bp->l2_fltr_hash_tbl,
+					  BNXT_L2_FLTR_HASH_SIZE,
+					  fs->location);
+	if (fltr_base) {
+		struct ethhdr *h_ether = &fs->h_u.ether_spec;
+		struct ethhdr *m_ether = &fs->m_u.ether_spec;
+		struct bnxt_l2_filter *l2_fltr;
+		struct bnxt_l2_key *l2_key;
+
+		l2_fltr = container_of(fltr_base, struct bnxt_l2_filter, base);
+		l2_key = &l2_fltr->l2_key;
+		fs->flow_type = ETHER_FLOW;
+		ether_addr_copy(h_ether->h_dest, l2_key->dst_mac_addr);
+		eth_broadcast_addr(m_ether->h_dest);
+		if (l2_key->vlan) {
+			struct ethtool_flow_ext *m_ext = &fs->m_ext;
+			struct ethtool_flow_ext *h_ext = &fs->h_ext;
+
+			fs->flow_type |= FLOW_EXT;
+			m_ext->vlan_tci = htons(0xfff);
+			h_ext->vlan_tci = htons(l2_key->vlan);
+		}
+		if (fltr_base->flags & BNXT_ACT_RING_DST)
+			fs->ring_cookie = fltr_base->rxq;
+		if (fltr_base->flags & BNXT_ACT_FUNC_DST)
+			fs->ring_cookie = (u64)(fltr_base->vf_idx + 1) <<
+					  ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
+		rcu_read_unlock();
+		return 0;
+	}
 	fltr_base = bnxt_get_one_fltr_rcu(bp, bp->ntp_fltr_hash_tbl,
 					  BNXT_NTP_FLTR_HASH_SIZE,
 					  fs->location);
-- 
2.30.1


--000000000000de33e60610aa0842
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEI1/Rtt21UsNZXYCTV7jzDlGwr9ss8c
CwJ66BCX8k0QMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIw
NTIyMzIxOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCmjJ+TVGy2Y37IFmdrpqqVDki/vMupwIGr2pc4zV5l5dvkh0pz
zAtX96JmMCtUA0BZZrMGh+VTZS/U3+IRjORFydGUmnQ69FwKGk4ltPKutj1GM7C0umKEXRzABcTt
V4mh4wWdXrYB+DVRqq0hfIxBv7tosGWNVSjLGrh3yotg3ATEY6X9Tt80lKvVCybAJFeJjFoYUnQK
tSNnkq1K4L3u1NSnGVFLB5ULGje6GAC0o23RAVYIRE5tslHRszQ9BD0lR5++w+NUbm2u67io3NJK
fIHp4ugLJ0tmXeQ/+PPPvjKvZfPmzTS2uv+Qr+ODwt4hyrMwjNZyk72mpG0P0pzu
--000000000000de33e60610aa0842--

