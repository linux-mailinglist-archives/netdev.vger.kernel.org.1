Return-Path: <netdev+bounces-83936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B5894ECB
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156A81F22C56
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AF058228;
	Tue,  2 Apr 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aYBvx3th"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7321E525
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050539; cv=none; b=CUOFQMfYg/TJguqHTT2Eb7Cb0RqCa87iudFqqEkpNcQBq9njVNT9yZIStBA21l9TBSuti0yMhgATJWE6J2cCd3+IOBvvjJqYH4sJ1U5QonPchwOUYbImGzzxJoIR+G7jS/ByMaGrpNJTMvi2FnqwwmS9MhN03ioxT9tX6DEchMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050539; c=relaxed/simple;
	bh=FUHlpvQyN1efWvroWvswyMxrhwQ98V/kAEVp4PErJy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkDIc/Be84Tve+qezLlt4VkHgmureLB5fZ39KUiFDD+thyv2LfwLkaA4HysvND4dr6Ad5zsYo6VpiXlbB2AC2cAjBb11D3a1ftJVd8uvwltDqE4tyCvzb9hMhKzsul0yiw2PcrUiRlXDAEsgleAsYAXyM0MTxqLoggF0Se5zN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aYBvx3th; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22e691c754cso437041fac.2
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712050537; x=1712655337; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0WOMoWOF667ES2q5lxVkv1CFX/bJar9MFPKJsTgFpU=;
        b=aYBvx3th8dM7XdO/g4ZSXXVqL0ZWSYDpSM5O+gqruAWWtIBXxL7BEzShtB2SM8L5wI
         eZwR2SkMOroIFzTR5n2vDOwMhA74+njWbrHdpGEIWoEoHVIyUCH6A0xwE7diw3yDwCvD
         kfs5zscEhmvQVurk0fW/glpGZGY8FYQyS+NRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712050537; x=1712655337;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0WOMoWOF667ES2q5lxVkv1CFX/bJar9MFPKJsTgFpU=;
        b=nXIjmKMhn2j475WDy7UqTAqFtn+Ta5ZURl/slhX146L1Hm9ddSGnbY7JOGS+78NPhs
         /pjWS4uFjY9rvRHwSuzNGL5Ab73MK/8BLsCi/LPueWmhfAida5Psl4a0JUE5N/Lh2os+
         C10rUTznRAouA2/v32ZzpRbL2ZTEHZt2jMWZFzn0oIMxMsr4vgXXcXjWpqBFtxR9s986
         0cBFVeONKWcodo+iWs1ada1voY0NiUerF+tiZjr6QZOzwAwEaFHFeotzyFuCv/D0mk8h
         seolT81gAOOpcmZ0ExShGSjSi1i6h4u96PLOGLRZ5epmCmjzVBlhgQuJD/4zgUmyp674
         DHew==
X-Forwarded-Encrypted: i=1; AJvYcCVubLNmcAA3+j3qDiisMxd/yTFiv3utdLb8N0ZsHNuBhaQsK/E8rI0WSFbsy5SBMvvps7YUkJFFoZ9Uf5VQfPFUjFdZm6vy
X-Gm-Message-State: AOJu0YzuUxN3wVSIFfSTXSImVwJ68ap+nota6dCL6g8kuh8NuLQWZ+eY
	4hByciukxaHjtz4AhjBVAu+KTkSEuVLK6uyP1g2mHQ9TAwc1oHM3ZYtVBhL0GA==
X-Google-Smtp-Source: AGHT+IGZOsSRpYaJVS9anIOzP9+MFO/W+gxqI5MxyXvSsTAz3CJauoN6TADR7rEf+587CvKHQ9X/Dw==
X-Received: by 2002:a05:6870:898d:b0:22a:4ea0:d8ff with SMTP id f13-20020a056870898d00b0022a4ea0d8ffmr11957828oaq.51.1712050536817;
        Tue, 02 Apr 2024 02:35:36 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q19-20020a62e113000000b006e5a3db5875sm9702087pfh.13.2024.04.02.02.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:35:36 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: michael.chan@broadcom.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	gospo@broadcom.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v2 2/7] bnxt_en: Enable XPS by default on driver load
Date: Tue,  2 Apr 2024 02:37:48 -0700
Message-Id: <20240402093753.331120-3-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240402093753.331120-1-pavan.chebbi@broadcom.com>
References: <20240402093753.331120-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001ee6d3061519d414"

--0000000000001ee6d3061519d414
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

Enable XPS on default during NIC open. The choice of
Tx queue is based on the CPU executing the thread that
submits the Tx request. The pool of Tx queues will be
spread evenly across both device-attached NUMA nodes(local)
and remote NUMA nodes.

Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
v2: Fixed formatting issues (double spaces, 80 chars)
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 46 ++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e24a341ad28..44b9332c147e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11804,6 +11804,46 @@ static void bnxt_cfg_usr_fltrs(struct bnxt *bp)
 		bnxt_cfg_one_usr_fltr(bp, usr_fltr);
 }
 
+static int bnxt_set_xps_mapping(struct bnxt *bp)
+{
+	int numa_node = dev_to_node(&bp->pdev->dev);
+	unsigned int q_idx, map_idx, cpu, i;
+	const struct cpumask *cpu_mask_ptr;
+	int nr_cpus = num_online_cpus();
+	cpumask_t *q_map;
+	int rc = 0;
+
+	q_map = kcalloc(bp->tx_nr_rings_per_tc, sizeof(*q_map), GFP_KERNEL);
+	if (!q_map)
+		return -ENOMEM;
+
+	/* Create CPU mask for all TX queues across MQPRIO traffic classes.
+	 * Each TC has the same number of TX queues. The nth TX queue for each
+	 * TC will have the same CPU mask.
+	 */
+	for (i = 0; i < nr_cpus; i++) {
+		map_idx = i % bp->tx_nr_rings_per_tc;
+		cpu = cpumask_local_spread(i, numa_node);
+		cpu_mask_ptr = get_cpu_mask(cpu);
+		cpumask_or(&q_map[map_idx], &q_map[map_idx], cpu_mask_ptr);
+	}
+
+	/* Register CPU mask for each TX queue except the ones marked for XDP */
+	for (q_idx = 0; q_idx < bp->dev->real_num_tx_queues; q_idx++) {
+		map_idx = q_idx % bp->tx_nr_rings_per_tc;
+		rc = netif_set_xps_queue(bp->dev, &q_map[map_idx], q_idx);
+		if (rc) {
+			netdev_warn(bp->dev, "Error setting XPS for q:%d\n",
+				    q_idx);
+			break;
+		}
+	}
+
+	kfree(q_map);
+
+	return rc;
+}
+
 static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
 	int rc = 0;
@@ -11866,8 +11906,12 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		}
 	}
 
-	if (irq_re_init)
+	if (irq_re_init) {
 		udp_tunnel_nic_reset_ntf(bp->dev);
+		rc = bnxt_set_xps_mapping(bp);
+		if (rc)
+			netdev_warn(bp->dev, "failed to set xps mapping\n");
+	}
 
 	if (bp->tx_nr_rings_xdp < num_possible_cpus()) {
 		if (!static_key_enabled(&bnxt_xdp_locking_key))
-- 
2.39.1


--0000000000001ee6d3061519d414
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJd97eQmYBVSub+nKi+x5n3k8vkkPguA
LM/dsxT6cNsZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQw
MjA5MzUzN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAjuNyNNSpo/j5z/7dIiIlaycnUghRqCxGzU55nQ/33vp0lFrJM
IYw4vPY+ND4lnBr4YUMNwPedvOfLT365NrhHdO1heKOoubimVSC/7OOzMV+sjbgEF+0MedamrdaA
2Z2VW1990QPFIRhu9jM1XUrR4iJpok9T1yeAL/Ey1s3PTHhZPF2yKC4HUaMSKV4dbDAunDdDr8KF
LJgYR96lIV2kBVBA2mEdIxihVAaL934bTVwuAQDxlPxUPc3keHuFMhBXkEi8YRsMQfdEZVrItNCZ
Dc9meNqy/9s2PeR3gRSji+9T3gTTamRJFxxH2txwBRcoVKa5D0mDRMiFoYR+YaC7
--0000000000001ee6d3061519d414--

