Return-Path: <netdev+bounces-224627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C45B87413
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D151C27F11
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D22FE56F;
	Thu, 18 Sep 2025 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYehT4OA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717182F2910
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758235150; cv=none; b=MdMjiAos7SkpDXb6NVLcLACseEHgSFRr3PiIYNH5OyqbZdeOelrw1Kg+WM3kSenEeCqZBSbRrQwuyassCQnK3jTPnHx8lQuCASaal1uIfAxdtmWLNKS1ZzjCwTJpwe3O5V3KW0iltIenvfNzl+LHKDuvmuoq8vR0QuP9UtrHC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758235150; c=relaxed/simple;
	bh=AXo1SVGHBK9qT4qVLa9ToApVKadhJSI2IuUi88Evw0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyW1uNQkf9do/LAMaZGs0ciRS6sxpXno1Rysp7Z7a3TpvTHcyQuNRxQbUI2B8YnCziOF/S/sU/iwOqapITH4Cax+Y14lhwuLJodDWfTGvliwZjonmtAq3LciEzGHgobqMy3RUWnYwUrMj8Y2x7yKH/DswN2A1ZFLww1AETA/HBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYehT4OA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-80e33b9e2d3so143905685a.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758235147; x=1758839947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JTNUO8XZtm3BiSnNgj+nAIXLdP3RxRAv6TMRPMgtSY=;
        b=QYehT4OApJ9JC/CBgIU8WN3v/0pwOMGQqkvDBtCIpOhSR9aL+1Zt7AtRPTsZ1mNxED
         TCoduxl0XnSS3adykRmcjqtcluXmAvMnuAnDYsRPZPOEqfgrqv3QC19IcD8hV4DJJD7+
         ZcE0eCM1BjTLQd1YLbO452GQPJI5F1iwclmUv9saCaCi5gVbiSVNQn6C4+6Z7XHvgszr
         uo2XIfdC8IBjkkEE8fni/XkLzVqDlLq6NWUpPkYP8x6mKZijxuDvhSzXjzXm5btIbh8y
         95KudzRQ75l4TKfxkkDHEVh5D778dUPsxMq1LN/Ut10kG/Ggk2D4ksZBylhdMP8NfdsO
         6Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758235147; x=1758839947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JTNUO8XZtm3BiSnNgj+nAIXLdP3RxRAv6TMRPMgtSY=;
        b=YPmz/buwiJdG7nJyvoo3bNZU0zifVE3Dg+pFk6/rusGAJvtXyX1O7ygfgewgN3d8Ne
         1T+mOstjAJPNgH1V2UJd2CjxHQxZfjTy21Q07tloQ6ahyKA5pjs3+HoLlb/65dsdsU+K
         2Uj+fFhxS6Y9cJ+6CHeSkaJAY+SMwJBSmk5iMZiRr4Xq1TuDL/AXjaeYZi8FyLV0LfeY
         JwnhoyiFYzF3+xzes0JVBaTeaptewpCrh0+tHTi08HA4P+Tk/LS33I7HH7cDwLjKLLXN
         b+KObU3GWZ2c6sb7Ir7IL+5RYNVLKIub8PSq+SdMyIVar1elrgjjj7+jXsEWnVv0rORS
         4i6g==
X-Gm-Message-State: AOJu0YwBes6kqy79ZSNIkCxfl/7yZW1CgF0Pv7fJsDxoIcsFIUvMyUKQ
	eUApiZEJoSfim7P9sKDbQkDOxgMlaL1Ldrm7/ar+6pcoijTQogfJJjDOeGYB3Oy+xGU=
X-Gm-Gg: ASbGncul4mONBlgu/7+gCnneY5IIrxFPaAQfT1iTBfXmu3U7vEiuWglylo6BvjgKFxB
	L8zg0e1rWp5eNS8zysuttaEM4DrqW7KGki/fGy9bmYlJcvwG19R5INin18pEgDpmtk5e0I6rX5k
	jxTK2usNRbOOgc/mZTO5DVlclhv+/J5YluN/zSyKrou8DSV8v3OS/glZDVzctWEcy7NF8NLaGwx
	ack6PfyFR7m998EFPHJdKz8JHp73FIvL1IAY+hV1zy4gRT0Ng34WJJ4p34qWrkUFpOK2F+OfY8c
	yCYYO2K9YhsIuRcfV9sa9QwztqgE4TYBlGIxhlxhpmBxzyhYzHO+7ydfZNQ3M9Zoj+tXdVaRwnU
	UyFWlrKbYuDTcPSXUCuLfm75f/ir1afyWrGbkgb5syD/sYAQCTKNjvmBtFAfVnH+cfhT8QmpzuU
	UYLuBOdXbzCN3tnAnc
X-Google-Smtp-Source: AGHT+IFLJPjYJgjIWzKGX74WDXjUp+q+FL8y/nBxd9QzDqyc1Qs/QJy+mr82Z3oWVcS1BUjOQ4TI0w==
X-Received: by 2002:a05:620a:8907:b0:824:ed61:3d84 with SMTP id af79cd13be357-83ba5f4b8ccmr138253485a.37.1758235146805;
        Thu, 18 Sep 2025 15:39:06 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630481fc7sm244631185a.43.2025.09.18.15.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:39:06 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	quic@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	Moritz Buhl <mbuhl@openbsd.org>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>,
	linux-cifs@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Steve Dickson <steved@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Alexander Aring <aahringo@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	John Ericson <mail@johnericson.me>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Jason Baron <jbaron@akamai.com>,
	illiliti <illiliti@protonmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next v3 01/15] net: define IPPROTO_QUIC and SOL_QUIC constants
Date: Thu, 18 Sep 2025 18:34:50 -0400
Message-ID: <0ac39290eb8089b08482c94870acb928ebedb878.1758234904.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1758234904.git.lucien.xin@gmail.com>
References: <cover.1758234904.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds IPPROTO_QUIC and SOL_QUIC constants to the networking
subsystem. These definitions are essential for applications to set
socket options and protocol identifiers related to the QUIC protocol.

QUIC does not possess a protocol number allocated from IANA, and like
IPPROTO_MPTCP, IPPROTO_QUIC is merely a value used when opening a QUIC
socket with:

  socket(AF_INET, SOCK_STREAM, IPPROTO_QUIC);

Note we did not opt for UDP ULP for QUIC implementation due to several
considerations:

- QUIC's connection Migration requires at least 2 UDP sockets for one
  QUIC connection at the same time, not to mention the multipath
  feature in one of its draft RFCs.

- In-Kernel QUIC, as a Transport Protocol, wants to provide users with
  the TCP or SCTP like Socket APIs, like connect()/listen()/accept()...
  Note that a single UDP socket might even be used for multiple QUIC
  connections.

The use of IPPROTO_QUIC type sockets over UDP tunnel will effectively
address these challenges and provides a more flexible and scalable
solution.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 include/linux/socket.h  | 1 +
 include/uapi/linux/in.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 3b262487ec06..a7c05b064583 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -386,6 +386,7 @@ struct ucred {
 #define SOL_MCTP	285
 #define SOL_SMC		286
 #define SOL_VSOCK	287
+#define SOL_QUIC	288
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index ced0fc3c3aa5..34becd90d3a6 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -85,6 +85,8 @@ enum {
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_SMC = 256,		/* Shared Memory Communications		*/
 #define IPPROTO_SMC		IPPROTO_SMC
+  IPPROTO_QUIC = 261,		/* A UDP-Based Multiplexed and Secure Transport	*/
+#define IPPROTO_QUIC		IPPROTO_QUIC
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_MAX
-- 
2.47.1


