Return-Path: <netdev+bounces-279370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGoFANtj4mk+5gAAu9opvQ
	(envelope-from <netdev+bounces-279370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:46:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5025241D52B
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD16F301C5BD
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFF63537F1;
	Fri, 17 Apr 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAOH2MOq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DE2FFFA5
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444002; cv=none; b=Wen86EMlJn/G8Tl0Xc0AqIOWlnzSlig2UE3DTV5Yy1ORMcXTu1nbo6IbDqtWEMi0SvUPkeHK1xiJqdOIG3DBqgfyeyZ7RjvROfiKfi47gzFHg2bCbqiR6uAGQPQu4EE1+eunl0uKyb2OmoCV7CBlFqKBth2lbWYZnd1ozDorqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444002; c=relaxed/simple;
	bh=KY11bjZPevOR4T7c4eutcQnimCvcv3BRtRMZteo366Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+yhU8qDtJLvSlS7JhiReqD02QoyXBm3Uwm4XKGdRDHHQx5s0O7Ua4ThTf/+izL3uaia29/gOIK5NMt33eJpXC7tDQ+i1Mcz5ppjOhMwGZF3jGuPoRCz624VRcpWMCwIGHp1sf4Zzswx8AkjyMS+GG8C2IiWIutgQGBRuqnROAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAOH2MOq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso17764825e9.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776443993; x=1777048793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8YRzMFZREsb0af4wE6lxlU4lB/UrrNAdoAuSDGNDsg=;
        b=hAOH2MOqLgNQLEItE8oc9BRnWQ+hhJiJpelE8niVtduXsD5ny/JaZGcqw5haMA1Qfi
         ffeTRGRY1l7A8MvuOpC7K5/ajk9weyoKUz+kxK8sPxa5WYGd2IdVpZVbKlVupue+UuDY
         xWKqsB5zBia3ZaSEFVuSh8hNxVsBQNWb45qQvBv/wb66ZnBDFBSmQoHGkQCdxVdbZjbq
         KypQgo/aL6GnHof7wsAhTXq+Z1FY8WtlQmhTabBksc02miQd6BExvkY3/xUv4skGDDw5
         RsCUv5OVsIl54C0brLqkg+8G6wErba35sf+XRkRMQHCvMQaeB6PAIYnZtR8fRRwrq8aa
         L94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776443993; x=1777048793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8YRzMFZREsb0af4wE6lxlU4lB/UrrNAdoAuSDGNDsg=;
        b=AWGpG2JFqNK/BaAcLyUhATpwqd8uZLwY6aV5FI4xJLROEu//gLnVLCNP8B3+vyzXvB
         cQUc3Kv0w2kf9yPWYpOyzChW2MDIUFDmD+EUcMOGRmCEIDqg8FXK4R1DzCUFMMWljHwk
         o6st8Zl95DBdVDmoVNLZI98asZrLcds4Ah/u9FLYDMQgei9l8az+gXic6cJw6vLF2t5W
         xHkTI4BpoHA1med/Ev5eKr9SaMpfUiu7WRjUQ5Q/cCx+KzKM3Civ08tLNEba8menJeND
         J0ZoEM9ok7pEpPji5gBSlv7DFic3bfmMOOXlbF7JXjKeTHS26vOwRaQG9spQUTOWlRRq
         riIg==
X-Gm-Message-State: AOJu0YwHQXPfzNM/YY9QS2dDEJDDSQ4p1wQ/9nz7k28wfGM6wWUwLDpS
	ceAkqnBtGYY85vI6JChKswcTf/RqKxz0V8zuIeC7EiEyyt2DVnpmOyiY9IaGpLmgX/Y=
X-Gm-Gg: AeBDievCq4JLCqbwI0fTBcS3wfnsdJl9qf0nLPkrn8954hIqAlaHia46rGCWQLLTnuE
	qLg+yDBYFoGS0kyqikzeX3BCa+mV9j5a5wVVnBR/SR0fd92m4yjLt1bxhksL5Z5sWO1lOP575tG
	Gacju0W4H6CP3D+eABmN9/Hngt23eQZEvndFGvj1jWmYvFc4NkMvc79iS2rTwE+f41lzGFIgDaF
	OgflBVYUAFSQcyChTi0WpOYD4HKnQSbj7F6wiRnoMisapkC5cub1L7bUNneWY2QYgrGwtxjarWj
	EkXlK1IkiSOOcT7tzuX45sS39NR+UnwoX/aJbTAojPMhps2wyAH4iU+H9pvIS/irL/f73e304Ss
	QfO1W0IvIvSFs7AICudQdnfVbw/sjTuY//q2O0sYNFOvHik95yfDvKeo4Oyts3arWW9KmBG8Ddd
	8XR9H+etxWU4yjsPYGYu8N2weOKH81SHmvIBVA7Wt9yHOTSUdaLY+I93OQoly2QpNmlGg7opqRC
	4ylt29HEQskihaVzWf4i1CQq4VkE9WvIvE=
X-Received: by 2002:a05:600c:628b:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-488fb8afffcmr48860005e9.9.1776443992555;
        Fri, 17 Apr 2026 09:39:52 -0700 (PDT)
Received: from fidelio-Precision-7670 (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10019bsm61358655e9.4.2026.04.17.09.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:39:52 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Woojung Huh <woojung.huh@microchip.com>,
	Fidelio Lawson <fidelio.lawson@exotec.com>
Subject: [PATCH] fixup! net: dsa: microchip: implement KSZ87xx Module 3 low-loss cable errata
Date: Fri, 17 Apr 2026 18:39:36 +0200
Message-ID: <20260417163936.540873-1-fidelio.lawson@exotec.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417-ksz87xx_errata_low_loss_connections-v4-1-6c7044ec4363@exotec.com>
References: <20260417-ksz87xx_errata_low_loss_connections-v4-1-6c7044ec4363@exotec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279370-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,exotec.com:mid]
X-Rspamd-Queue-Id: 5025241D52B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fixes: e66f840c08a2 ("net: dsa: ksz: Add Microchip KSZ8795 DSA driver")
---
 drivers/net/dsa/microchip/ksz8.c     | 6 ++++++
 drivers/net/dsa/microchip/ksz8_reg.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 0f2b8acee80f..62fc59c3da7e 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1297,6 +1297,9 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	case PHY_REG_KSZ87XX_LPF_BW:
 		if (!ksz_is_ksz87xx(dev))
 			return -EOPNOTSUPP;
+		/* Only accept LPF bandwidth bits [7:6] */
+		if (val & ~KSZ87XX_LPF_VALID_MASK)
+			return -EINVAL;
 		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_PHY_LPF, (u8)val);
 		if (ret)
 			return ret;
@@ -1305,6 +1308,9 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	case PHY_REG_KSZ87XX_EQ_INIT:
 		if (!ksz_is_ksz87xx(dev))
 			return -EOPNOTSUPP;
+		/* Only accept DSP EQ initial value bits [5:0] */
+		if (val & ~KSZ87XX_DSP_EQ_VALID_MASK)
+			return -EINVAL;
 		ret = ksz8_ind_write8(dev, TABLE_LINK_MD, KSZ87XX_REG_DSP_EQ, (u8)val);
 		if (ret)
 			return ret;
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 5df17c463f7c..cd41214f874e 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -206,6 +206,9 @@
 #define KSZ87XX_REG_DSP_EQ			0x08   /* DSP EQ initial value */
 #define KSZ87XX_REG_PHY_LPF			0x4C   /* RX LPF bandwidth */
 
+#define KSZ87XX_DSP_EQ_VALID_MASK	GENMASK(5, 0)
+#define KSZ87XX_LPF_VALID_MASK		GENMASK(7, 6)
+
 /* For KSZ8765. */
 #define PORT_REMOTE_ASYM_PAUSE		BIT(5)
 #define PORT_REMOTE_SYM_PAUSE		BIT(4)
-- 
2.53.0


