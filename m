Return-Path: <netdev+bounces-257594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHJrEA4MhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:43:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56681FFD96
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09B92300B8FE
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904692D3ECA;
	Fri,  6 Feb 2026 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqUHIvzP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931F2D1F40
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392570; cv=none; b=E4wvE6ENHfcM2d23HHcEWFHq1ExqQ6HNVesHrrPZb63RGQvMKSb4Zxf961OGmT4KcPcbv4eLMX7z/QlHms/NSLuEBfNCy3VY0JvQ04d6ui3jneHKIeAglGQjCKF3I3MyNh+/Gtx/DZSGDD8bDH0JjaBndDuxpmyf6d279U5n5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392570; c=relaxed/simple;
	bh=RgNHkO1t0LY/JdKK9DJjaXVvcw9gEDHDg22uEBqQJJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUdH0jUq+Rb+AhrtN7UiMykzNDgctYsiAF76UmHpC460eQ2xSxoG9NgUy1KpvmOBxWVSpVhNYP0X/+r7/osJW80lVK7uYYl9uhK95VkcGj8bzfVeFtbnSshh4X80+r4mah0+TlIp1aIyvL+atP/Ovk/L/qsGny0QGm1G5xfLZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqUHIvzP; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6d76b9145so236605885a.2
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392569; x=1770997369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctrVGJ4rkCHHyx+/hoFia9xDzknoZ2CE0M4UFFU9GRI=;
        b=QqUHIvzP/z+N7ZhXInxPdJXipxXjOAdX/FeimemPwkQ9BdHlnILytIazSerEmGQR9E
         ErQ572BpjyHwOcOs6KGqTG9HiuNhhYMdlkht+Itz6MSmPXcrNPeJQnl3w/NL8ZqoIJiX
         yDCoEtvZ1K2T+UVejrJmrkRin6JajJua+MYD2JpKmlWQ/9WNMvuAjW4JMb7eda7WMwky
         u0Ukv469cQA7yOPICQFuv/WV0le2Z5PE1LrbhSvPdLF0uOJ5vXJXulxKYmOz8s4Rw0UP
         vQDbgve8ANfj5QfaBa9WI7xTeWETFM4YaAk5wOpWWBRF2By3UaMIH/XJ5S0h6lXyHAE+
         VWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392569; x=1770997369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ctrVGJ4rkCHHyx+/hoFia9xDzknoZ2CE0M4UFFU9GRI=;
        b=HW35x2/+h/aZxw4l2T+PscrwMEaiifihp5klATglTfDilBVw/MuwnpeFuw+8dR2cU9
         JEqPc0TNCZgPOF9Gd9pmy2sl6D5s7H64MXKplBRFKVLQ2VRLfDKm6+Xkx98e7glpt/c3
         TBgIH6uciZkYqx/ThUHJtE0LcLhkEfihTKYbIZ7yO4XjBfR9bIgpgsB/nCt+jq8QK7gl
         Vrk5SVnUiaR6M8wDnY7U12HkCMIvA20d64s9VDTq4gIsd1SXVsieVx9QwMsHyUHouRK4
         7ZF7JhqHz90ifqi+vpg/D0cqRIy4gaRgg6AxUaRkxo0+QCRN1I9d4c/4vEtjp6jmSgDR
         nS+g==
X-Gm-Message-State: AOJu0YyTFiXlaQqs108SRzvOyu6p77YaFkttB8IYLAbdAsaB6yv4/VaY
	J5VLOwfhdY4/ju6QQ6DnnPpLfNXer5mJRJS2goUL9F3m+ErlRePP4zjM
X-Gm-Gg: AZuq6aJ3XSYr19AHQ4qig8ddKeqKdntQ042zPHTVAERnesKen1QbpraYRDKcpnfzEKO
	mivFmdv2Zx8zxyEFW7LHKn0/7mvfVrH8Sz821aNzoa322+GFujirb0fCE+lvNnzV1wx0oOdEfSt
	cSETfP7US+cAVtVo21B3gGl2K4TmXqPoDM9ZGzoK0gCCv55WpINT6AjTwr2poXiwoqahqiqxaZN
	U6sQvnL1Wf/YB8NeuVvlmOm2LSfx+adiw9DjOoPUy3zGCycxiaP/euQR5uRUQsLPJTGVlNQ/79M
	1tAi/O4Hi6bB+54RwJ1vpP8oLfK6syKE7xT+qVGCfAWUvs+/rkvQ2QXHrhiO0iA9Id/trOd/P4J
	vVGQt/Zck8mIXERGZQ7Q/BK8ASf3/WqZObbqX/MdAWXgg8mrygSghpYiy/Qtd7xdOH62mjFnN9h
	F28E1CVGOkW845e71AqUopmPTmHuw0kxFe3xKE2IcrQSSC
X-Received: by 2002:a05:620a:1a8c:b0:8ca:4288:b163 with SMTP id af79cd13be357-8caeef2f874mr390689285a.17.1770392569116;
        Fri, 06 Feb 2026 07:42:49 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9eea0c0sm181499185a.42.2026.02.06.07.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:42:48 -0800 (PST)
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
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Lee Trager <lee@trager.us>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v12 1/5] net: export netif_open for self_test usage
Date: Fri,  6 Feb 2026 10:42:41 -0500
Message-ID: <20260206154246.814-2-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206154246.814-1-mike.marciniszyn@gmail.com>
References: <20260206154246.814-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257594-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56681FFD96
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This export is required for the following fbnic self tests to
avoid calling ndo_stop() and ndo_open() in favor of the
more appropriate netif_open() and netif_close() that notifies
any listeners that the interface went down to test and is now
coming back up.

dev_open() already is exported, but drivers which use the netdev
instance lock need to use netif_open() instead. netif_close() is
also already exported [1] so this completes the pairing.

Link: https://patch.msgid.link/20250309215851.2003708-1-sdf@fomichev.me [1]
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
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


