Return-Path: <netdev+bounces-111126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6827D92FFFF
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 19:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0891C20A39
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF44175560;
	Fri, 12 Jul 2024 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Wea00ivg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA7143C52
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806822; cv=none; b=lE2c3Tc03UjT0nnTecmgvhvf5QqtEwRcDYWL5FRrKLBR1sJzUlUjG5jDvEuwR+LIxjV+HbBRi4w7OthaYDXRc6b05G9pMiexGCTJ0jPU/x0d6JXplh+btKpUqyhOyoMQs70aL6k8oaCgnI2Fymi+qTcqTZA47UhJGZ+LdQBP3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806822; c=relaxed/simple;
	bh=s7OkU22KnYuK+N3/nsGjLWPD6EzLkbx09gIJ9bzcDCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QSapyNQSaZ+cmQeWE+be+kB1mtR4VCjHKCpbR6+CodN+U0ieM4S+EEYMTMzWXi0ZzIxwPCSdquUKuT+HcQveqP185S6qtDQXv2u4kASd6Tr52zUVRZMQaYc4d/M4Dxf64nKt0RL/72byaQ7w3Hmsk9VEPluzBTRo2ctbUwzt+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Wea00ivg; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7611b6a617cso1688998a12.3
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 10:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720806820; x=1721411620; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WZll8+lHXNn5NsE6Fyf3O+JOLu/Zx91658E6m3BX5qc=;
        b=Wea00ivgC8yvXwPfnjGxZIgu1ix6B59gjcr0Z3in+VpDsSocmY7irbG5s8ajDvnxpG
         8txRNRUKyqc8dq6AJ6Ey3bJp4o3DIfcfCv5nMh9fRlGi+91FtxSru9J2lWyxHEUVKu6m
         MR0YE7S+OYOlXoATpgLws6Ly/18utsXO+ykvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720806820; x=1721411620;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZll8+lHXNn5NsE6Fyf3O+JOLu/Zx91658E6m3BX5qc=;
        b=eenwNhPHJpUg0AvK1ZuiB9LgfraeO0Euik0jA3Adck45Ftevq0CJ5fMt2nz7nCEp1j
         Bh5HxY283rbXm/Dk6qCbyNK8aJBNumUVzgSfZq3kqe8bw89TgxrF6SBfK9dW4zvUh/6a
         tyo3qlJQDYX/52Ony3VDsKcwOX4Plm73LQQ+n6YK8Sdo0Q39Vzs3GEFgmHynStqzpm9C
         XTPBuhrBjM3xgN/2Wh2m0mY+JtVVtCqIe3BJ8MomWNHuiwYgA/jNUsetMu8W0lRG+Ztv
         yWHAWhKEd3+nbTJrxehLsW9FtqVj0/ZLu0uBZdyyNIJTnTEQQvfegLyoZseQOxgKPwyL
         4c/g==
X-Gm-Message-State: AOJu0Yxr4A7WfAw/X0mWZQ8jOOCUezP5WuJTO3lmX5I4ZdzJnz1cQzaO
	HxT4MqNVi0nprrX2E98dYHchhSTusl9FMt5EjGekMztmVbU8iWhWgatVl2AgXQ==
X-Google-Smtp-Source: AGHT+IGa7QYmleSdFsTW5C+a91nnPRG/C6YW1b9LaZ0jkaqBeSwOCKJvClUvdFhfZD8z9anjUIummg==
X-Received: by 2002:a05:6a21:3283:b0:1c3:b1f9:44e1 with SMTP id adf61e73a8af0-1c3b1f9463amr8303771637.46.1720806819852;
        Fri, 12 Jul 2024 10:53:39 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d61c00772sm6141419a12.43.2024.07.12.10.53.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2024 10:53:39 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	leitao@debian.org
Subject: [PATCH net] bnxt_en: Fix crash in bnxt_get_max_rss_ctx_ring()
Date: Fri, 12 Jul 2024 10:53:18 -0700
Message-ID: <20240712175318.166811-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000407407061d108fb2"

--000000000000407407061d108fb2
Content-Transfer-Encoding: 8bit

On older chips not supporting multiple RSS contexts, reducing
ethtool channels will crash:

BUG: kernel NULL pointer dereference, address: 00000000000000b8
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 1 PID: 7032 Comm: ethtool Tainted: G S                 6.10.0-rc4 #1
Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/17/2017
RIP: 0010:bnxt_get_max_rss_ctx_ring+0x4c/0x90 [bnxt_en]
Code: c3 d3 eb 4c 8b 83 38 01 00 00 48 8d bb 38 01 00 00 4c 39 c7 74 42 41 8d 54 24 ff 31 c0 0f b7 d2 4c 8d 4c 12 02 66 85 ed 74 1d <49> 8b 90 b8 00 00 00 49 8d 34 11 0f b7 0a 66 39 c8 0f 42 c1 48 83
RSP: 0018:ffffaaa501d23ba8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff8efdf600c940 RCX: 0000000000000000
RDX: 000000000000007f RSI: ffffffffacf429c4 RDI: ffff8efdf600ca78
RBP: 0000000000000080 R08: 0000000000000000 R09: 0000000000000100
R10: 0000000000000001 R11: ffffaaa501d238c0 R12: 0000000000000080
R13: 0000000000000000 R14: ffff8efdf600c000 R15: 0000000000000006
FS:  00007f977a7d2740(0000) GS:ffff8f041f840000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000b8 CR3: 00000002320aa004 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
? __die_body+0x15/0x60
? page_fault_oops+0x157/0x440
? do_user_addr_fault+0x60/0x770
? _raw_spin_lock_irqsave+0x12/0x40
? exc_page_fault+0x61/0x120
? asm_exc_page_fault+0x22/0x30
? bnxt_get_max_rss_ctx_ring+0x4c/0x90 [bnxt_en]
? bnxt_get_max_rss_ctx_ring+0x25/0x90 [bnxt_en]
bnxt_set_channels+0x9d/0x340 [bnxt_en]
ethtool_set_channels+0x14b/0x210
__dev_ethtool+0xdf8/0x2890
? preempt_count_add+0x6a/0xa0
? percpu_counter_add_batch+0x23/0x90
? filemap_map_pages+0x417/0x4a0
? avc_has_extended_perms+0x185/0x420
? __pfx_udp_ioctl+0x10/0x10
? sk_ioctl+0x55/0xf0
? kmalloc_trace_noprof+0xe0/0x210
? dev_ethtool+0x54/0x170
dev_ethtool+0xa2/0x170
dev_ioctl+0xbe/0x530
sock_do_ioctl+0xa3/0xf0
sock_ioctl+0x20d/0x2e0

bp->rss_ctx_list is not initialized if the chip or firmware does not
support multiple RSS contexts.  Fix it by adding a check in
bnxt_get_max_rss_ctx_ring() before proceeding to reference
bp->rss_ctx_list.

Fixes: 0d1b7d6c9274 ("bnxt: fix crashes when reducing ring count with active RSS contexts")
Reported-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/netdev/ZpFEJeNpwxW1aW9k@gmail.com/
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 64b61a8d426d..43952689bfb0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6151,6 +6151,9 @@ u16 bnxt_get_max_rss_ctx_ring(struct bnxt *bp)
 	u16 i, tbl_size, max_ring = 0;
 	struct bnxt_rss_ctx *rss_ctx;
 
+	if (!BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
+		return 0;
+
 	tbl_size = bnxt_get_rxfh_indir_size(bp->dev);
 
 	list_for_each_entry(rss_ctx, &bp->rss_ctx_list, list) {
-- 
2.30.1


--000000000000407407061d108fb2
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBzT8x3DCVRJlVUk2SSOhkvTBLm37o4g
70I+JTcPvfdPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcx
MjE3NTM0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQATwWC+LrV4vawFn/4/sUAAPgUM1ozDo4PntoF8RS84Esaovo8Q
dVfiqgUPBKXbufkrGgiwThYmTAK2aJ6wxfZhthcmf276ZBT7mSiEK1Y62pXHYmmKqW0FMowTxQqu
kK0vc0JGDPwTVlUPn3vnPlAkMdNXtQ7u8Zc+K9AmpS7anrXYmJmiJxw4ltyK5NPxtl1dQeAzhwdU
JRae8C/ivsvPkKbD3faYSV7bF2cl48mFgIe0M/FcjmVITxEPDWyNYaYPkDmP6/HwMU8F9kNeqVX5
2ZbjXipqXKzwdc0SsbIyWPv/bTofh9Ds9sm4NSrvtr5tFImBJ4qPNj++mmGUpLcv
--000000000000407407061d108fb2--

