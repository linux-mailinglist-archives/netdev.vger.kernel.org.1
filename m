Return-Path: <netdev+bounces-307538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +RBTOih1Vmrp5wAAu9opvQ
	(envelope-from <netdev+bounces-307538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:43:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6B757923
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:43:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pzgvaeY5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307538-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307538-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DA3D314CED9
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF534156FF;
	Tue, 14 Jul 2026 17:41:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293A412C0E
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:41:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050885; cv=none; b=DEzBlg+in7IBy04/eGu0WA+NEUzinnuFs0yu6DSXaWG9L5HODBUr7LsGhHjjjUnG5TFKhzk/wHa3NJHFklNdgXYNYf5c/WsC9c01cmV5IHBciH2yy+zletnHd8P9KOZSl2xpfv0gVutfo4HRepnhqideZe3OxZ8NP2rE6aKkHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050885; c=relaxed/simple;
	bh=/8kwpS51oEAHEw6EL4bUzPsL8La9wbzGzhSRkOOzhFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkv0BBZTSGeBeyIi1BSZFsKqc4RbWktwPkYVQ2TbZaNVBt5LoMlM7Z2UOJ/hyGPU191fLP7pfDtBCcDIozIQp4sSo+GaWYffrDJBdi1Yd5yihbreyC+z4HAHMKSJHBE8TxDlPp8Mupr9HY93+QgSgpU55iKd7fPH919dCSIGsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pzgvaeY5; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so77254545ad.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784050880; x=1784655680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=11t9d++r0bmMhzQdiTZcpMyL88ikh+EriVNoFZhMUAE=;
        b=pzgvaeY5hJUBe35j86/xzRYNAapiLHnWP2fsSZCPw53h8g4lU2+gR46zSP/WPsZAaJ
         GT4c3j8hYxdDU2YZPwXL5s3yu41s2YNICen+3urnMH8ifE5iqVwFX7uVshD6Sze1bv2O
         2ELclrhnUgew7Mp/6WESn2MtUDJkZ46VC2zWqConFPQP7Ihj7JAPGvSUSGXGjG0XFKd1
         5L39HaSyCO6hoGlr2WwWd7oXybc6FYbwqKxucpYtB8fZRPT8VeXzzpXTBylUKw1qrekd
         KFNtp5MWvv7u9ePJYETRkKR74WPEy2pZyejUozJWj9b52rURHZFR52GKYhDq+9AY8iF4
         jK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784050880; x=1784655680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=11t9d++r0bmMhzQdiTZcpMyL88ikh+EriVNoFZhMUAE=;
        b=KJs2ozVNRTfCLLV9K4wlugK7cW9/oMIJry5Zy/zkYXZydLhFXu4cI+EOQZ3XLkiGBr
         YBfwIMRCSqX9dMjmiaE/0ruq2EigJWk9mUO/gAIqoafcw1D6Jr3zrlnxKdK3pR0AsSTX
         JFtUS8PsTpa5L2LKXw9MOioAblSU229qCCRgeiwV+hDIw4r2cNWQM1TJTwwQMSo8QiTS
         xv4ei2ro2gKorXxEZf+8UU4F3+16I9YrvD7Kzzt4/Q9elOdSlxyksVkhvDl+vOvrhkKM
         U0PCYSrCmh28CJYq6gG/gXH0en/E64JlGC/xlypgGuM5WqZQtwx3V+BxR95FjAbQgBFM
         /KDA==
X-Forwarded-Encrypted: i=1; AHgh+Rrnj5vcrlWqcFN+zS2Mni94geOxaLLi2m6Ncbda/l4m3oxwvsiCOjMkK1u7arCNb6I0jw5/W0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+DkJ+PXJuCZBiA2MBqZuupGPsirQcVx5WKav/mnB9clJpw09
	836DNqWwq71NLIRStY4DcuxuS8XTJyqI332eKjGhv6u5sPBbBruITy7d
X-Gm-Gg: AfdE7ckqRqBLb0lJjMl9dNj4A7iEC38hXjlwZz1eAmpJy1Eq8YbgCCqt/D0kwsA6KJ8
	fRRyOuFdhTvtMAdzmOCNYJBPsnNL+wnbT/lJ/DDsBO3T0vV8hcwwWfwzlDEFtEVjsGq35LQmdef
	uNo1++l7eMe149qd1UOX6PYa0lkatE0GsfmBYoxsnQTeq8h1X9osAJujSh/+uYy56byqtM1VSsB
	Nnpzo+NSFGAUNn5pUfQm4W0BHoHXTMlRHo4bTEF3nfCj2y0ErG+1oRbjaOSEHLEAw2qi4knOVu1
	eJP3C0M02D+J1roX+s3+H2rmsqNcu7ajlPN8WkgkgVg6uflKchLLTCe7ciJA2CW3GQXeHoZ9EAc
	1U9uc7WFnrXCi69n79V8n9Y1ZVBka0Zs9UBrZS7+IX9pDSRegJPIHnVii2OR0B+BzJIKHtGQO57
	dweuXQOLiivQwqP4HgrYIQzVSYuFgEycQUFw7v780zddwioxawR1t/z/BSAd/uEWwfKj01
X-Received: by 2002:a05:6a21:3282:b0:3bf:6c08:4ec6 with SMTP id adf61e73a8af0-3c357263c10mr3492675637.59.1784050879544;
        Tue, 14 Jul 2026 10:41:19 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b87b92b27sm38055954c88.6.2026.07.14.10.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:41:18 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hoang Huu Le <hoang.h.le@dektech.com.au>,
	Xiang Mei <xmei5@asu.edu>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v3 0/2] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Tue, 14 Jul 2026 10:41:08 -0700
Message-ID: <20260714174110.1571033-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,dektech.com.au,asu.edu,est.tech,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-307538-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:hoang.h.le@dektech.com.au,m:xmei5@asu.edu,m:tung.quang.nguyen@est.tech,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DC6B757923

named_distribute() stamps the last_bulk flag on the tail skb of the
publication list. When the list is empty no skb is enqueued and the tail
access dereferences NULL. tipc_named_node_up() hits this on an empty
cluster_scope, which happens with a node-id configuration where
cluster_scope is populated only later by tipc_net_finalize(). It is
reachable by an unprivileged user over a UDP bearer in a user+net
namespace.

Patch 1 guards tipc_node_xmit() against an empty list, so the allocation-
failure path in named_distribute() cannot pass an empty list down to
tipc_lxc_xmit(), which has the same tail-of-empty-list deref.

Patch 2 emits an item-less bulk when the publication list is empty, so the
peer still receives the last_bulk flag and does not stall this node's later
name updates.

Changes in v3:
 - Split into two patches; add patch 1 to guard tipc_node_xmit() against
   the tipc_lxc_xmit() deref reachable via the allocation-failure path.
 - Break out of the build loop on allocation failure instead of returning,
   so the last_bulk flag is still applied to the last queued skb.

Changes in v2:
 - Instead of returning early on an empty cluster_scope (which would stall
   the peer, since it waits for a bulk with the last_bulk flag before
   accepting later name updates), emit an item-less bulk so the peer opens
   normally.

Thanks to Tung Quang Nguyen for the review of v1.

Weiming Shi (2):
  tipc: guard against empty list in tipc_node_xmit()
  tipc: fix NULL deref in tipc_named_node_up() on empty publication list

 net/tipc/name_distr.c | 16 +++++++++++++++-
 net/tipc/node.c       |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)


base-commit: 4595d2c77ea4bfe4ae0efa38770a59ee5d2f06d3
-- 
2.43.0


