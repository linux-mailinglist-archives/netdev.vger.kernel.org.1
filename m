Return-Path: <netdev+bounces-284012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEaQJEbr+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CE74C2C9A
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E80F0301EB70
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0143E6DF2;
	Mon,  4 May 2026 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="LCdZNF2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283037D10D
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920784; cv=none; b=HdXPNEcYlw0szgqXBdNqUkWFh4H+4mh2fMPyfF7TDPb3wTM+sRqqcKFTN9l8QR1z2kJjkDBo293rEIIGtdZ/SStpfebOGvfsgZURFIm9BoRlsmNqkyb0sPof5fD6saqMMc49uxD1GXd93UreoMv+rp3tz33ybhCOjJUZJfhnVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920784; c=relaxed/simple;
	bh=9sY4H9u6LcobI4W15EVh9X3d3kjQHvm5jzUNF38NpvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8juqZm66Ll5fG3DfmtDA88KyO9KNTVOpHJ78YiRhle4QQR0fVFwuvGiWeht6jK6Un7xIdZAkggIp3TDyqvkYyUEypcH7IcwXCo7FC1w7BGiX6GC/MC4Uo2jmKpUBsmJ7BkCUfljYLIOFxeSWUuPBcPB1OZhfo2kCx40UFZAyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=LCdZNF2Z; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f3c623322bso579519eec.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1777920782; x=1778525582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ0kDs+2qp+y1R4eH3atVmdLXkkfGfohpUrfjQOKePg=;
        b=LCdZNF2ZRJV2KQ7yHle2z47qpLhxU2lqEJ4ymHZYVcuWFYawZX8u41+a6y5+s4uv3O
         ObK/ardTKT+MQQEO2icmQ47lWcKZTltcr2rQpvbtk492UbVpVrKNNrcUmd0aC+bGZY+Q
         A5OgZRBMBCNgXoPUMP8ljR0t5c07HN5oC4vSkI+dCvNUY6qaDFhZrFxZPzbCQhEnjMhm
         2zSmEOduJ0r4an4KM7k9FDh2IhneBqpH2ul052xK5sp/+UQ94hTZdmPreAStwsW19qfY
         RZ1qcqbEjpYbemQDlFnckTomsfK2jpVmrQzP1zlUkgehzoJMWLoZK4eIwXOcvpEFuz+t
         ttUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920782; x=1778525582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WZ0kDs+2qp+y1R4eH3atVmdLXkkfGfohpUrfjQOKePg=;
        b=sFZHwdtMx0NlZkR+OC9wHWaHetRhF6mRgttgIptnjAMbzyjk72wuf163MC2qQEu+Vq
         azerO/YvEFVWEiSb/M8Yfo2MomP9QkXSsQY9ZJq0UwsghgkwDBI8/pIFykJSmGkaYUr7
         bgVJFKs2uxtwrSEDb5qFnlhje0g9VyPkpdJxit13InL9/209sXk3mmgfgUYgvG8v1FQb
         mtEUWWvulKFY/3LYRwDk12QDGxrbc1bOs7EyFq8t9U/Fa7tf1f1E76KIKTu/A22yEWAd
         tiTZL3HMnB4FiNhkMHqEgdJLYvPZk4Ze9e6igsHamvaVkbntJnPgnkS1+H4fhvYVD792
         RWnA==
X-Forwarded-Encrypted: i=1; AFNElJ+xjta124xbqJUz6oW91LDHLPMsZVMTSK1gW/S+TFaU/4f2loKW4XGCL7rgy3GvZFa38DZbua4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHzzruNqiFHFSs4naD4qA/ZfdMzmlzWlYvdduvVBoXks30aaFL
	dtQQJ0SYYWCmfUf8L+jFhpypQjAS1+uU/wOajipWRYp+07hYd1rZ9sM1YAtdJZlBsQ==
X-Gm-Gg: AeBDies5ykxfZV+V01IqM9HNSEkwGBj07YbVIx334iwZ7QKbgbQcG9B7lrWwsAupLir
	Belq7/GT4M1kiskRAghlHxPI9pPXwoEhsh50iUmVsPLr9/1ehOeXb4LCUqJe4sFEst7ggO5VGPd
	HlTVH1s9xQSjS+DHg5L3aHBS+TgHNlG9r5dtr5bQCUedTghaMly0/aHH7Rnz+v3dqCiGZbliBpu
	hHL3DvkVP7kwTqDa7HteSGI4G7cAIbVmDZJper+XFffEsRhbb5563bbKrZIjN/LOWsN3f02JRAy
	dqBtz8F2KowUtJt9mbah3O/5D4WO/8sHkbFrAbKZvhSbDkL7NJCGSkH54eTvpeb7dgbA4GLrhq1
	b2iL6MpPpXzDnwrsmAGam2CoVMNBZAlhkGkCUvbWSorbG1J07qpHfFkCDK4UFtoipqugildITxb
	co0b7CNKrhLjrT9Yl5SoUvYPnRcL/V4/eJ9gaMvZUzg9yYotFwGbwUiWw3hiiHl0fXm1K+6YuF
X-Received: by 2002:a05:7300:570b:b0:2ce:f3d7:221 with SMTP id 5a478bee46e88-2efb99a1503mr5097242eec.17.1777920782173;
        Mon, 04 May 2026 11:53:02 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:8e62:719f:fc3d:b6ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm17186262eec.4.2026.05.04.11.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:53:01 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
X-Google-Original-From: Tom Herbert <tom@xdpnet.ai>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v10 07/10] ipv6: Document enforce_ext_hdr_order sysctl
Date: Mon,  4 May 2026 11:51:19 -0700
Message-ID: <20260504185122.50642-8-tom@xdpnet.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504185122.50642-1-tom@xdpnet.ai>
References: <20260504185122.50642-1-tom@xdpnet.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12CE74C2C9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284012-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[herbertland.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xdpnet.ai:mid,herbertland.com:dkim,herbertland.com:email]

From: Tom Herbert <tom@herbertland.com>

Document the enforce_ext_hdr_order sysctl that controls whether
Extension Header order is enforced on receive.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 453643c70c8d..fa0ed1936f59 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2617,6 +2617,36 @@ ioam6_id_wide - LONG INTEGER
 
         Default: 0xFFFFFFFFFFFFFF
 
+enforce_ext_hdr_order - BOOLEAN
+	Enforce recommended Extension Header ordering in RFC8200.
+	If the sysctl is set to 1 then the ordering is enforced in
+	received packets and each Extension Header may be present
+	at most once per packet (except for Destination Options that
+	may occur twice). If the sysctl is set to 0 then ordering is
+	not enforced and Extension Headers may be present in any
+	order and have any number of occurrences per packet (except
+	for Hop-by-Hop Options that must always be the first Extension
+	Header and occur at most once in a packet)).
+
+	The Extension Header order is:
+
+	    IPv6 header
+	    Hop-by-Hop Options header
+	    Destination Options before the Routing header
+	    Routing header
+	    Fragment header
+	    Authentication header
+	    Encapsulating Security Payload header
+	    Destination Options header
+	    Upper-Layer header
+
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
+
 IPv6 Fragmentation:
 
 ip6frag_high_thresh - INTEGER
-- 
2.43.0


