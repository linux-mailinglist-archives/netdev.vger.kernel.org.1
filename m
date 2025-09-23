Return-Path: <netdev+bounces-225711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728DDB976E8
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B19F1B223CB
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1485F30B515;
	Tue, 23 Sep 2025 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOKr9NwM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91530B52F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657652; cv=none; b=S+X2cernK0CdroUPSPilPU5aJZTAf5R9PsZycSphvKuqLu/Q8F25faaHOENbzQdCA7N7uvFud1bJs05oq8PnK7ozzgVyrg9NdvrFEp76Ovtq8Ky91wUSpt6WkP2XXLuE6EUFH/byXkHziK3ddiW7W46/tC9B79rEnNkb5Era0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657652; c=relaxed/simple;
	bh=0fk/n7B9mEiC2MeLQRlJTessoCBaV440mO7d/PjdBWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kvrun7AmiXeU3gieY8202utaNmle/LlyOylRBt8GwUmvIXbam8RlvdLKATZSx/XkOo3QOtbI2lQOqzcBGdHc41gpzi+NW1k3aWNt6fCvcBjZqz13W0m7FNI2xkucpATkxdKBX9IGSIw8OQYRhJdM2cuUnrNo8Av73XWSL004+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOKr9NwM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b2d6e91bb66so40027866b.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657648; x=1759262448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxvGwdECme9sva+F1ujIW8jaKUJIsBLHPhmAsgPJYCQ=;
        b=QOKr9NwM/6or7EQebm5FE7VP3tOWQMPUKsh/107AMXeUNWsDB0R3F1KuSvB8poPTrg
         iTTGpClFIY2RCEirkfwu2C31vOBHY8+jNKt+xVTKqBWvAVTzHHD+o8kEu4lIRe8yeKiP
         G4uWeXFNfybb+cu11YBcb4Jfh6yyMcXxWPei60w+ezC6AYBKW/QWErcTYqm1tlaC+QcG
         2fzvNDOChGNsDZx7Qj5RxJTG/xD4duO6hkNaGcopWW+TVx9GUMRmOKgBZe8+aTfHDkM2
         aNKDu7x6Wx0GL4YpmdtpwyYQtp4j7rJyhr85qtPgkTiulzNcHdyTIgWXpPg0ow1Kkr+5
         Hk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657648; x=1759262448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxvGwdECme9sva+F1ujIW8jaKUJIsBLHPhmAsgPJYCQ=;
        b=e39Izkd+ZKuLwT2AxmtUfw6KT+mFq/EdQSdlJd14xHhhkbMuorrfVyEMHfRL39R1zT
         ikUKBn24y5BIx+jA2Dy020clB9H6Jni3Pffu852+zOT/PQVRN6WOJ6oaJkOCHs5FPtzf
         iffB1RKpR2xownsSB6d9WR6GjQQMT9rpz1dCTCXDAqBGlg8Eg/ymq2Tr8QztIl6bN5L8
         jLiBIEka3Ht9jZWuPxa/docY0ZE7i7CBbhP4W0qUX7eieHO1PrgGYzevrlHy1L6dXDN8
         uwm5rCjbrgUVYGQ3y7+RdYapaGtpDnQ1+juDIYRKyGvh9NMtiCiyR8cw4GAoO7s2O4Rq
         AyXA==
X-Forwarded-Encrypted: i=1; AJvYcCU6k9I0BxcX4L3P02LOhmrh64azr9t+s76Rbw2EPc6F1XWVuHZI7Sbc8QDNXvtH3OmlzhlkHUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRL0jryEqAQuTnF4LgReKlVGjCdT+gKUY6bLd/tyA+UXeCijuA
	trwaAIqG7lujP8Vr0pxJ52IE9+pfT7FOCF/adWQ9AdK3iyD4eJwaDBrH
X-Gm-Gg: ASbGnct7vBfEUkDHgf3jJy7HBNgx2gUlFZ2M5WEf8ih7fDJ2zNAZ0oGN95a/pMR7F8x
	P89pkcJOn4PwATrzeAHs1LdLc3wfXOxUEIVZXT/iF96lDPxKnDr7thWxi8cVifmdRId7ZTHCIYC
	N/cJMgDUd9nFd2GLO934uD2Aqme9iGx4A5WSvwUW88xVHzFRo9q34eY9eZgYm/n++f+JRMOcynw
	YSb/3w4W6RIFukWO19iHdoRUsV5TEy8cf/hNYRQ2oBZZ8hQKRB6kwr6KefzfcIQCGrIaA6vPYrT
	42sBZmBBlNTyBFEbEqf7PRaUJSrS4rGpWw7nlUYy0wST2AkLItX5EazuL6hLzCwIGPIYKrMwJMQ
	lt4Z4sCnfqCEcHYbmssLBsazzrWQ5TEsEIl0=
X-Google-Smtp-Source: AGHT+IE9jKk/zzdKDwXkO7sxSkoqe/jjpTEgScJwrOwZYkbO90+nHVble2JF4n49Nmv6GbSPvrhTqg==
X-Received: by 2002:a17:907:940f:b0:af9:6580:c34f with SMTP id a640c23a62f3a-b302ae307b6mr174461766b.9.1758657648256;
        Tue, 23 Sep 2025 13:00:48 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:48 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 2/4] net: xdp: Add xmo_rx_queue_index callback
Date: Tue, 23 Sep 2025 22:00:13 +0100
Message-ID: <20250923210026.3870-3-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce xmo_rx_queue_index netdev callback in order allow the eBPF
program bounded to the device to retrieve the RX queue index from the
hw NIC.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 include/net/xdp.h |  5 +++++
 net/core/xdp.c    | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index b40f1f96cb11..edbf66c31f83 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -547,6 +547,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
 			   bpf_xdp_metadata_rx_vlan_tag, \
 			   xmo_rx_vlan_tag) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_QUEUE_INDEX, \
+			   NETDEV_XDP_RX_METADATA_QUEUE_INDEX, \
+			   bpf_xdp_metadata_rx_queue_index, \
+			   xmo_rx_queue_index) \
 
 enum xdp_rx_metadata {
 #define XDP_METADATA_KFUNC(name, _, __, ___) name,
@@ -610,6 +614,7 @@ struct xdp_metadata_ops {
 			       enum xdp_rss_hash_type *rss_type);
 	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
 				   u16 *vlan_tci);
+	int	(*xmo_rx_queue_index)(const struct xdp_md *ctx, u32 *queue_index);
 };
 
 #ifdef CONFIG_NET
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 491334b9b8be..78c0c63e343c 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -962,6 +962,21 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_queue_index - Read XDP frame RX queue index.
+ * @ctx: XDP context pointer.
+ * @queue_index: Return value pointer.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
+ * * ``-ENODATA``    : means no RX queue index available for this frame
+ */
+__bpf_kfunc int bpf_xdp_metadata_rx_queue_index(const struct xdp_md *ctx, u32 *queue_index)
+{
+	return -EOPNOTSUPP;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
-- 
2.51.0


