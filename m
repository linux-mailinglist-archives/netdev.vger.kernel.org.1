Return-Path: <netdev+bounces-252652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHDnAkwec2ngsQAAu9opvQ
	(envelope-from <netdev+bounces-252652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:07:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11B716E2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EB7A3001398
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F43624D1;
	Fri, 23 Jan 2026 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIu7WVb8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505C35CBA2
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152016; cv=none; b=IgOTq8vxTE9UItnqRs3lrFYcEds9qeNkmZmwpXIX6svk7uoW5BXMNB1Gna45DkgMgUIP59htgGHwStDWQRMcbJiiRE5IdYzBJMXAYSPsocBj8IbSNIAwYj9WC1zp2OgxdtAUHlPsMsxIp3u3wIV1p1LkVIr6F8/xHcyEj2IDOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152016; c=relaxed/simple;
	bh=nRuwA/HjFmC1QvODakZXV6SP7R5eka53nrtg+1WYZOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozmKh+TYmV0xjS3ErmMGWpaprErKMr4BmtnqKTJvFY9ElhOMscB1vEZO1UWRUbDa0V7BzEYaZrJXcBwoPPsbmjOo5xz3B+MnBhUsJRPle+3JzZLOtQkmBgYvUcNUkdFVuDHtm6JlKw13q6Gm24Piuy1ITS3O4NVk9NtD6/wC+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIu7WVb8; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b72e49776eso2918098eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769152009; x=1769756809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lr7fGbT79MwqhEN9UzJDCx6G/YlhqboOFm4Kaoo4cBE=;
        b=BIu7WVb8GosVYoKDDPmZMBSdIc0DyAvG42YgeU0DqZYF7p4smfXgHQ25iTrs001CHF
         686KtfP6AAcWi7oRq7oIxW5VhPkDziOFJiatoTZK9VVYLVRAUucaSsuhhyuIUDnFVYVj
         MwRgaRgykfHZiHhmTRarkA7U9K/2INEB2uEjcF3gekbqeCF6rIY2bcZQUCI6BElNqnd2
         vmVeyKbBjcGvDSn0iks2EzpF+6sPRfWo6cj/vW/G+5F6eeZZZ/nGQ4r8S3yiKLVqadPV
         dGhH7k1a9hHmTZ9RHUPywsrL6nnvsBcs8NvgG7b8ZQcbojEzvWsLD89okkntI153JVTN
         lLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769152009; x=1769756809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr7fGbT79MwqhEN9UzJDCx6G/YlhqboOFm4Kaoo4cBE=;
        b=KMibpj+C9z3Hrerb/PqqZS5zgp/Bk6oXtpCV0TgOkA2sRBittLPX3Ux73/+v0071zg
         BwOdslOZSa7L/BCumnq3eIJrAeK04hfiEubTTIPK1q3USe7kzss9TJ2KnLlZQKdjBKmJ
         dWkamOLL74l7hziP1xOFwKKiO3kU2VGwKsXVzPxoYOE/EhOtYPtuJIolmr8PRLTKVzON
         mOefl0QmeR+X8oqaK7UKAHWSTNDcsmdUAYX4ST9EEV68vcK/SvXipN5QJdPh9a8tzba6
         8n4P4WAnrlVaa7djztyX2dm+PNmUwsq/9fscMqnoGLHPp2mbIQnN77HLLWg6dYTvIZrt
         rLfw==
X-Gm-Message-State: AOJu0Yy+GoHuUSECGhKd54IrIM22GyTfUHjGMxGYMv+Ygu/kdGUQHtCh
	J9PnVHkHuWLSR5dseXwFLTDMMQsOcbLR6FHOn2gyC9pH2OXPVjK1J/bSeUDHSTCc
X-Gm-Gg: AZuq6aIo1+pjVmcbX9GoDJU7MnnbRjLKlrNglbT5dTlSd//X9PQaJovxhgmkyUVk01e
	9PNQ3HC0ynFzIXI6ua6oMNPJZ3nZz1zc253z83DXawnFfLyJAuscq2Xrw2d0EJ1PwLJQN5yOtC4
	369yBiAL85An6WH9VlwZ3+bP5xjaQ+YzwCp7U4qVigIaLexT+k0iT7AzpAtotKJm5NZiZI31Msq
	cJ9c4pGQDRnXRMZUK8Lj+Ozvvh/fIccq0q1U/9kDZgQhAeAGSRJFzmQ2uMveyq8VBK9vlA9P855
	mAQcbtaSJtsuG85Gz/Up32suKcIBjyOTW7zWaeb3jXYPodg1C0CgRqo4xPEi9n0Y9VWRfuPWSKp
	gKb70VK3FjO5W4XTZu8NMgqbxSmMD2BdZiBDtwGi05rau+EBVClbdLmd+ChADZOPKZ8c3LXlYNb
	zSc/yo3cAGl4iJUY/aqKNPOTuMFRFHy+xb1cyzJWrhP1JAZvnTf6ZRiqyRZZRyYB4lmEaNT6p9Z
	z5MUdc0IpfX0t37LCMi1eowYNxGO3es6ELt93SCPhT3o9VLF1xrYPX97Y02n0mRChOj92+wNRIf
	z3hB
X-Received: by 2002:a05:693c:2b0f:b0:2b7:1abc:a6d2 with SMTP id 5a478bee46e88-2b739b8d7b9mr939700eec.20.1769152009408;
        Thu, 22 Jan 2026 23:06:49 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6b6227sm1992802eec.8.2026.01.22.23.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:06:49 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] net: usb: sr9700: use ETH_ALEN instead of magic number
Date: Thu, 22 Jan 2026 23:06:39 -0800
Message-ID: <20260123070645.56434-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,korsgaard.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252652-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E11B716E2
X-Rspamd-Action: no action

The driver hardcodes the number 6 as the number of bytes to write to
the SR_PAR register, which stores the MAC address. Use ETH_ALEN instead
to make the code clearer.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/sr9700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 9c7cd0db1768..446857de8e15 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -271,7 +271,7 @@ static int sr9700_set_mac_address(struct net_device *netdev, void *p)
 	}
 
 	eth_hw_addr_set(netdev, addr->sa_data);
-	sr_write_async(dev, SR_PAR, 6, netdev->dev_addr);
+	sr_write_async(dev, SR_PAR, ETH_ALEN, netdev->dev_addr);
 
 	return 0;
 }
-- 
2.43.0


