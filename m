Return-Path: <netdev+bounces-294508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4S8sJdGGH2pemwAAu9opvQ
	(envelope-from <netdev+bounces-294508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 03:43:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED69F6337FD
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 03:43:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Yh2xw/Ap";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294508-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294508-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D9D930D65BE
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 01:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE337C928;
	Wed,  3 Jun 2026 01:37:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732F37BE88
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 01:37:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450676; cv=none; b=rCWYylrqt70faYvXPbkWppDZ/qhdTN/1LA6ZBobjRSl3FmkbQ8aeg4Wy0dbgzbkbeB4GO9gmG8qvr8BaLeWdvu2HgjSK2H1y/jYa1+pOx/Lb7U/KyJyim7fgIp6vZ8bGuT7fky16fkAlg5vdWhoymP4SnP/rWvdes3TyPQANHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450676; c=relaxed/simple;
	bh=rkHcjsPkRR9nNSHxR46h2y9fTpo1dvARrrbdvhIHj/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujmbC7SGRZFFu45Wav8VGuE2zozlb6JnGdm64A+6w6RZ6D03OTIH069JKO1DnQJdiLpsT4ySgVabNPCP9NcP/CJFPodLx3rJViA0/iX7paJr06YKqrPuWOxE2bdXOZboUDU1aeXA1TZdhzjSVnPq+IrZxJKO5NKIH51rp1wDcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh2xw/Ap; arc=none smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85893bce34so1439413a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 18:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780450674; x=1781055474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8Jk1ivLmwr3VP3ike29F6VRWUYvoG1CiSF1zOqSE6U=;
        b=Yh2xw/ApLaK4resB94WFblQ/eikImAqAuEOp587sPYEjBTK4UnO2fyTABGxs9vVMVa
         YlO5fNbOjoOzB8HVXiXp4i9oJy6lJGQC0TALrfM6YF7pdsM51eVafuBoJ99u5ftiDUSo
         dMumZFMS/lxO1XQym3Fqp0C4JXTOWB2/4FUHaOLEnZTJBURSYp2UurXGdiHVwS7l9l2n
         MEmwJNMR4wKEHDIZdv1h6+EYcDH+X9rcw85hfW/4M8h+j19JZDDWoKE5VvTVlfpvv6kE
         NSIqD3ndYoGxbaYRDTXz9iiXTiRW/JruO9A3QE6Vo+48QhAVmIYEvLjxM2jd7f1SCRxA
         MpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780450674; x=1781055474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p8Jk1ivLmwr3VP3ike29F6VRWUYvoG1CiSF1zOqSE6U=;
        b=oeGUHWvex3nXp8jFqIkmHu/yEDwv6JcaeFNw5hk5jNKhUIoO1GTrrX066EnchhMx9i
         7c7PjWv9c1tLZQtvcGgH8iWwEsseq8xOMQEZw/Zdp9fJ7lrDUcn2MNOkq2bxXi+srxCy
         zm8iRtQnADmQ0RUDX0LR1tiGR7idDn7gXEKwWs+Ex+Vimdqi1labwkCTtaLy+IR9MSHt
         Xd2HFOzf9OvFCJtkHsnEIlirqvRaQ+P8ZERY2h75mXv9j1UhA0hDV18V2KxK+SDcCjVI
         AgpIzVmKHrisOjQqvawTjxwDtZkPrlT00LOnzlJj1VgmpzqYcx/wVaXdUHPcgBOzKJA+
         EEsA==
X-Gm-Message-State: AOJu0YxGiTKQBAYlmM4uTDuC2ioDpteK8dvweRJiKesgqJlqUEVRbLJ2
	cxrjRSJcF8V0h3n8MOcpzege584zfU3EGQhwWe2LfQZnV7k0CJ/rmavy
X-Gm-Gg: Acq92OFDcIbnGyCGVPmz8L5u1fpK8tKWnWXffxxiNU05s4mw4YQi1GEDngj5AHgVBBq
	0Va4IG8lIK9DRu5NvBJPZnHFGcubhwvI1gxJUlsRt0URfk1uluzhB+PDG5jOG5KFOccuiQ9yBBj
	gj2tTVXj/IWb+B0cdvyiQ2xsQzAL5QlbsTXoGC2eaIDEO8ndh4nUefxmdhm2fguua5DX6OfhXaT
	WWCPaQnLksECpEp7X6WNTTmnL1Y9hrpKkhtEnp8PTUHXoQDy4ylNZ8NXItjFjjRcURp7Pgxs6ab
	Karp2pYP5Jn2eNqH60zhK2eRWhACx8e4Zg3KoLTbxOKG3iqmPjea31ekr7C4IDc508hXbMOaELk
	KB/I+gmWiPhNPYi+IjIQsCPjlxHEdnOLxuQA5AId76wsXITFZDsWHCFh0Gbbw75nTUZktSty7tD
	2x2Tlf+XKUksqWY9QlexKZN2j2D8t0qhUuCkVZQjH2
X-Received: by 2002:a05:6a20:c79a:b0:38d:fad1:cf2a with SMTP id adf61e73a8af0-3b4973af276mr1426953637.13.1780450673809;
        Tue, 02 Jun 2026 18:37:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df043216sm525522a12.10.2026.06.02.18.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:37:53 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 02 Jun 2026 18:37:31 -0700
Subject: [PATCH net-next v2 1/2] net: devmem: allow bind-rx from non-init
 user namespaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-nl-prov-v2-1-ad721142c641@meta.com>
References: <20260602-nl-prov-v2-0-ad721142c641@meta.com>
In-Reply-To: <20260602-nl-prov-v2-0-ad721142c641@meta.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, daniel@iogearbox.net, 
 matttbe@kernel.org, petrm@nvidia.com, dw@davidwei.uk, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294508-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:almasrymina@google.com,m:daniel@iogearbox.net,m:matttbe@kernel.org,m:petrm@nvidia.com,m:dw@davidwei.uk,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED69F6337FD

From: Bobby Eshleman <bobbyeshleman@meta.com>

NETDEV_CMD_BIND_RX is currently GENL_ADMIN_PERM, which checks
CAP_NET_ADMIN against init userns. With recent container/netkit/ns
support for devmem, other userns/netns use cases come online and require
bind-rx to allow CAP_NET_ADMIN in non-init user ns as well.

Switch the flag to GENL_UNS_ADMIN_PERM to allow bind-rx for
CAP_NET_ADMIN in the netns's owning userns as well.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 Documentation/netlink/specs/netdev.yaml | 2 +-
 net/core/netdev-genl-gen.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index a1f4c5a561e9..49862b666d7d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -798,7 +798,7 @@ operations:
       name: bind-rx
       doc: Bind dmabuf to netdev
       attribute-set: dmabuf
-      flags: [admin-perm]
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index c7e138bfe345..d18c89b5a6c7 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -220,7 +220,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.doit		= netdev_nl_bind_rx_doit,
 		.policy		= netdev_bind_rx_nl_policy,
 		.maxattr	= NETDEV_A_DMABUF_FD,
-		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= NETDEV_CMD_NAPI_SET,

-- 
2.53.0-Meta


