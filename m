Return-Path: <netdev+bounces-264453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDHzM3GeqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:17:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56888214501
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6737330D924A
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2FD3BE152;
	Thu,  5 Mar 2026 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgLoptcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C33BD65D
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723400; cv=none; b=muRrb5bp3t+q3d9mZN/sM4VoT3in6XwKLVqsmdCcIFRE2hwNPynDITxM98nH/AhOsl6u0ou9XjhrecCqNM4RHbj17obMzP7rEy2OukoecIGP6uXUnQy+BXYgiAxwVVL7pUDw4LO3G2ZeCoffDJAXMuVd9HettVo0ielJT6eIgbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723400; c=relaxed/simple;
	bh=5JIVRcYl1y12S5/sz2fI5bGqsHsFXiIj4xW4ZbCUe/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXscPPsbYd1QS9fXQn8TPDpvO6XbJDoHHSJFxVoZxy4OJxW2ZCFKHkrhlabekp8O5dmzrGkJXn/Sq33/7y0r3uOtz7EJPX8oieR1+owcI1/Wc/1WqGDQlxNgYWqqLnw/0ugyIq0sH+S19SmPQUptUHXSZeQ8IBDGpTybA2Q8joA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgLoptcz; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899e85736e2so52168146d6.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772723398; x=1773328198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjZWJhe0+52/LCoiWbs/Dsrs71ktVY7uZ4rO2FBsX4k=;
        b=ZgLoptcz/43S5tArg158/8cTvqRCPZ8UcsGIOTUHzfXwRQUw+v7lb1FH8otjexAti4
         4/jMbuod+g+eHnaN1+runomgpj/DDYuJxjsxDNDZOnAqQGjsylauZkmaC5NX47FpVTOS
         jsqfx/PozQzg14wJTMncHjn/QDhZTW3u3xOABgFTMOG0Q1ooVxmbaBFkP12a7mypqbAN
         UX1RFKMnUCPsfscpomiXvjkJ7Kx013HYhNREl/1fNzXqqd62YndDm7F1llfqRt1gBG30
         jdjJn0XrUat9ngQrCaongB8dNVNQsrDU3i86i5GbbGN1757TtOda0cUiJErn+3lMXXm5
         mKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772723398; x=1773328198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bjZWJhe0+52/LCoiWbs/Dsrs71ktVY7uZ4rO2FBsX4k=;
        b=L5+Jh7xD47XdWotS4TWatUKolLu3M7OM7fPLDtzTeCF6hn9H2TbSMSDWwThR2JvzIM
         a+vP7CSrzpMhO3BMNRujkFeHUg3ANJmMbto3ZrjhBuK04+u824h/1FqWju1ClODOYzfP
         kEaul+wHuRkdtvH+WiR8CdPI92XHNwxX6HIVbxpiNT3s0fXozGK4Q59viVvMlpjxPd0D
         eKyt3Uc6dOWzl3bRnY5e6exh9IOROqW5kk/MYhecyob6eHC8cDcoKIGwfNBVQOtS4IRP
         zYZvee9+R4nGQ2OiFRagGBTbnqeohp1QtU6pU60C/WlEgBuvVUe5P+vPsLkJzADLc0co
         AQlg==
X-Forwarded-Encrypted: i=1; AJvYcCXJHwscx0LowVDqw8gR231z0cvRXA/fQMv7aMibgQE4TVfZ8sNPCuZVV9HwVnacq3msGxLVpFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaggEJqjBkiJRspFMFWsJGJBXkaylQtWQ6PctS26/ttSYCa7/S
	KobWdpItqD65FoA0VWjaIx3DP/luVXrNOvUw078iiZKPuGYJUgDzI5pY
X-Gm-Gg: ATEYQzzeNLWk/xk/nznBMMSGXXEr1k28XTfLZP9geaMqJYpQiP7o3XReF13UN6kCPSQ
	+dFC2tVpIuzNSEGCVzJeT40IxIpvmkz682t2fh3AJTVonu6sKwWd+2VEB4qjvZ70hbZCRtFbmiA
	zzstGJLiuFnxJPrT81dkWVbzd26m82+H7v7TJTibsjRKvKDPJ5qgxXYxl0ZGa7Kzpf5elttx/65
	ACZPVNGEJ9VS47iF3EL6sewlmcNN0AMFd5r7VmI4XlvZQpv/24lp5SCcy3gbfrrHHKrZ1QDPR5j
	K+FCvYB8pKg8w3e/nyZkN+RnSExB2/OMssXA+356cjSpO6ML4MKuVU1SCqAAlFKISmcWQOm4gPK
	xUHZ0FjMRI0w56TuONnvKuTt990nS10R/JCd4K/tFoShhz8By4zL4WNZLtO5jgXcgrtJtcSknzr
	/3GgejxXBXmuCbUqmhTR+IqEHavBi2ls9FQzOosGyIEdtg9oqZDocsY5SlPMyXGVM2RJFJTtQZ6
	WFUr8hQSO++LSe/
X-Received: by 2002:a05:6214:300d:b0:894:7716:48dd with SMTP id 6a1803df08f44-89a2490a28fmr33947626d6.29.1772723397679;
        Thu, 05 Mar 2026 07:09:57 -0800 (PST)
Received: from PF5YBGDS.localdomain (70.15.25.19.res-cmts.sm3.ptd.net. [70.15.25.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0bb6e27asm64183176d6.2.2026.03.05.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 07:09:57 -0800 (PST)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/5] net: export netif_open for self_test usage
Date: Thu,  5 Mar 2026 10:09:43 -0500
Message-ID: <20260305150947.16893-2-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
References: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 56888214501
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264453-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

dev_open() already is exported, but drivers which use the netdev
instance lock need to use netif_open() instead. netif_close() is
also already exported [1] so this completes the pairing.

This export is required for the following fbnic self tests to
avoid calling ndo_stop() and ndo_open() in favor of the
more appropriate netif_open() and netif_close() that notifies
any listeners that the interface went down to test and is now
coming back up.

Link: https://patch.msgid.link/20250309215851.2003708-1-sdf@fomichev.me [1]
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2 - no changes
v3 - no changes

 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 43de5af0d6ec..d1d5694d1ff0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1724,6 +1724,7 @@ int netif_open(struct net_device *dev, struct netlink_ext_ack *extack)
 
 	return ret;
 }
+EXPORT_SYMBOL(netif_open);
 
 static void __dev_close_many(struct list_head *head)
 {
-- 
2.43.0


