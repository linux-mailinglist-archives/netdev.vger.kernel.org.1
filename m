Return-Path: <netdev+bounces-257895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPajMe5wiWnl9AQAu9opvQ
	(envelope-from <netdev+bounces-257895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 06:30:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F29710BC2A
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 06:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E346A30048F7
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 05:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043A42FE575;
	Mon,  9 Feb 2026 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="CYllLlqH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6FE1ACEDF
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 05:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770615018; cv=none; b=Iksr7YRFWoCtHSQCQYUe5FwN8zZVvZlGyytS7rTAPxpF5NRjmY7VZjp+XkkJRyRMmSWk09jAJ7Zj2guHZ+o/CnEKCOUy1KZttQJuEPnuqqI+hhxXtv+1y/WrNaCa7Kica3Ro+GCozVGibe2qO1iaPr9gpQQSV/cEDZFhYZ+TiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770615018; c=relaxed/simple;
	bh=90MB2j4CgmVye0Z+2xbcqnupOoDkQTzlkenxahCSWw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dXLoL5SybZ/4yVebTFZFCamkcn9BaEmft3AKR5boiNM5p+wrph6gv33BWmB2eVMSp58usyMQauMFiq9aAVM6FsCMS/LGjQ3TG/SC5S9s03yVw83MYEHO5OjxcmSJGSK9De/UCxhFpJGhw6Bbx7DNUsPPvrwgJD8ChhX0gWoRbqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=CYllLlqH; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-505e2e4c35fso40969471cf.3
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 21:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770615017; x=1771219817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N61Q8cV41adr4A+NhJ034xStLnkhNVlJ60mnC0rmS0I=;
        b=CYllLlqHU0F76Bp5u1HsU9g65VdG0IkzCFGqJ2P9eEFBEiFnC2V0qf7g0R1r0QPEkv
         9gfDWiEyNhHSLRFgReVkFE2v6smHaqcGRlOv+bsxlGf0IRl49G7gE+cHgZA3iolSBS+3
         PEgfl4yJNvbrOtlUmWkfm1Vxv9TsGyKtgwktTFU6/gVfMAnZ+QiinbyPEBNC94ohIHve
         0HCwCHJcRIalShPO3GAB/lBvQxw4HkA0s7YjX+/hyaeH+b72PfH7+C/ySncFF6GR0cJV
         xxo5FiC60bcfbyVKE3KOZqo4QWM6FjRtz6if317ERdPelFhJZTjBUqLYIcVqzd/C3xHL
         sDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770615017; x=1771219817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N61Q8cV41adr4A+NhJ034xStLnkhNVlJ60mnC0rmS0I=;
        b=ilEo5qJYF7Neao70uJvMDA58Pf6pXcOoeQQGpjSgkdXUc/knMuQ6rKopk96mOxSnlR
         RvLNPNmSWCx3dNZmT5wTq/nUfDdGcckgIsmy49Z4ErPV/iXR7r7DCywQLIgzr7CeWXH8
         xV+2IbtIrSOj+z5KMdwa/tPpY1dq09f76Jn+2qRgTb9s9b8HG80xPEo0qUV9H3aWbaiZ
         cE76u1kAeX9mhi/lAou2wjEFZbWkiNrhvgDtwt7M6J6ZLyW3bZfutuKTH0VNvfr+MAJI
         CIRcGVcUJzmEzbvxJdy9XiYm48Wm24CFzgDi3YY9RF2h4Qo1F6goFm/aYQaOIAV5Q1jS
         ITgw==
X-Forwarded-Encrypted: i=1; AJvYcCUuvmrCSDpUfSeLXTZC1PMeKhfSPktOYfhWD0StnR+XDGle5iyYoLbNXzsz6tb6KlOIF8YfcsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXMBcxcm+Pho1VC5CIgefme1qO2z54nt+a6DahgAY/E38fL5r
	i7orHXol3o0IDfm68p1HUA5LviG7ByOjFSHZYh1fivUlFqbQMK4kOzepBUuvVoTPwoY=
X-Gm-Gg: AZuq6aL1ZhINXtwCzymj0f/0ODlp+EE6VJAhhMFef+i5hzOecIr1WtxbzUWKjQq8Yyq
	bguBsrQF37w84kAbZDdKFhiJ8+dFKSi3ewMXAweoTzTV7QX/7YJ0nCHUKv9ElWs/KcaMHqTE/pI
	0t3m3VUrBTWD0B5P9s6iGsooxq6oXqtV8/3xudu2smh10EMWJJk6+TgCgWl+TXsypT2+4WQGf5d
	qnpgi8Jxt96D5FrkkwGgCBijYh45Q4i151USwLGgXZSVCK5MpEPZKe3gV6JzAI5pWAUi+sgTGZw
	0A8ergHsIcKW6Tqj6Mao+vK6mZHeiN7E2G4cPF7S3IhEcGjp6n68Yl1YWSbD156vh4piFPdShrw
	qSrnLJnIwbTxuQmcxmM/AYpHRiE5rBdpSdS/BiNNsyC+TtWob99kQEn7QaPvXpOuUFAPK2qNH7c
	+Q4yAB+koy/wGIM2N+R+PEyOaLMJ762nbgmnBU/3m1xmmZVTIzQk46CkwxLxJ87zYdlQIfQLbbU
	tlbsKFydbjBtY/WePMeCqcz6QuJfvo=
X-Received: by 2002:a05:622a:13d0:b0:501:498e:5c29 with SMTP id d75a77b69052e-506399f5ed5mr134423481cf.59.1770615017536;
        Sun, 08 Feb 2026 21:30:17 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50639171cd0sm69343471cf.13.2026.02.08.21.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 21:30:17 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] net: usb: kaweth: remove TX queue manipulation in kaweth_set_rx_mode
Date: Mon,  9 Feb 2026 05:30:13 +0000
Message-Id: <20260209053013.1701134-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257895-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.990];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F29710BC2A
X-Rspamd-Action: no action

kaweth_set_rx_mode(), the ndo_set_rx_mode callback, calls
netif_stop_queue() and netif_wake_queue(). These are TX queue flow
control functions unrelated to RX multicast configuration.

The premature netif_wake_queue() can re-enable TX while tx_urb is still
in-flight, leading to a double usb_submit_urb() on the same URB:

kaweth_start_xmit() {
    netif_stop_queue();
    usb_submit_urb(kaweth->tx_urb);
}

kaweth_set_rx_mode() {
    netif_stop_queue();
    netif_wake_queue();             // wakes TX queue before URB is done
}

kaweth_start_xmit() {
    netif_stop_queue();
    usb_submit_urb(kaweth->tx_urb); // URB submitted while active
}

This triggers the WARN in usb_submit_urb():

  "URB submitted while active"

This is a similar class of bug fixed in rtl8150 by 
commit 958baf5eaee3 ("net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast")

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 drivers/net/usb/kaweth.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/usb/kaweth.c b/drivers/net/usb/kaweth.c
index c9efb7df892e..406d1bd070fa 100644
--- a/drivers/net/usb/kaweth.c
+++ b/drivers/net/usb/kaweth.c
@@ -765,8 +765,6 @@ static void kaweth_set_rx_mode(struct net_device *net)
 
 	netdev_dbg(net, "Setting Rx mode to %d\n", packet_filter_bitmap);
 
-	netif_stop_queue(net);
-
 	if (net->flags & IFF_PROMISC) {
 		packet_filter_bitmap |= KAWETH_PACKET_FILTER_PROMISCUOUS;
 	}
@@ -775,7 +773,6 @@ static void kaweth_set_rx_mode(struct net_device *net)
 	}
 
 	kaweth->packet_filter_bitmap = packet_filter_bitmap;
-	netif_wake_queue(net);
 }
 
 /****************************************************************
-- 
2.34.1


