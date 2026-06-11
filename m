Return-Path: <netdev+bounces-297976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nbd/FEFfKmpToQMAu9opvQ
	(envelope-from <netdev+bounces-297976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:09:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C7466F42D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:09:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PNC45Vph;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297976-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297976-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76B973009895
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2459369981;
	Thu, 11 Jun 2026 07:09:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508203B4407
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:09:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161790; cv=none; b=JscFysbV3BboudIYU8XDDshFSDoCyaT73/jppAhAXxyTvO9i3MgsmwBzsZWsnwKlzcL/OzD5kqHqdRCPjWovB9A0obQR3/uBfJZkbblEY0HKVTVOuT2fipS2IDSUOPj1QV/yGh1T/icL5GkLwu9Op89KjhI37QD57q7IGQnXgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161790; c=relaxed/simple;
	bh=IKO12KcgDP0OMKzs9zbTXFZ45kmsBccLGC6hECGVoes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR0p1U5zhMDE0POfuwuxKnF4aSXP2eLdsDBSdps2w1wbyMk5EM8XAKE9mSVI2O4u67KNer5qZi39OmIZslb8W5m8r27a6+s5R6gbsyhs51jYxvGRlFcmYK6r+m9RyRtnAF/UAcmwg4nQRROg/wNQp3SfOYpz76dPWt8p4RD+bV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNC45Vph; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c2a68d01so51083535ad.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161789; x=1781766589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4R2Iy9HQQbE66UKxWqI1tK/Xn2Y0sSn/4Eic9bhbjQ=;
        b=PNC45VphnfWkCR6nhgP6lgd0BorRwf18qcxyv6x0taKfQmPdsoySHNyFTqBqEHJ7EN
         KAIjjT60OqeK7gUb9nSabRmpzx1Nq/SsHZk6C7TOSzl51+273Cay7sqeVtuLO/nQjY00
         ugUhHhWA/c72gFqY/YiaiiXbfFe2MX95Mcz5jfA9YQEdZDLrrHYGyIKg/DMh8XxuuVv3
         XyAL7m6rvkMlzoDiSYwbyBtkhlA6BmWAtfJtsz28b9cqCOnmurw7U8y+KaeicmMQhoOm
         iX+3SEZy2v4mziCUffANKiTk7iYSnJQL2JJhp6eraALEdPv5KT7acwocEquzlRxLfA8h
         7OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161789; x=1781766589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n4R2Iy9HQQbE66UKxWqI1tK/Xn2Y0sSn/4Eic9bhbjQ=;
        b=g9dtE9jYVqkKo/Vqppqcbp6KpNI8H660QLYRjkvuLAX6uChuNNhsd4T7xRR83ywW4k
         z9vht11VN1VUSVIm9GLtUiIbA9SDehU9On1mutjW7nUCMVtd8pr/c+0dVX/twlo8qs70
         MyHWdvK425wQeVleCx/gjCJAbeAiWMoIpw+Srwvy2BDZ3zddfdljXtZxBJvctT//vjqO
         uVHVQFTT+BW7JEL4TJISrwAaFJkNgsj91YzrXuruKyvdqzDmeihDFdPtFNYhFI8YSL0w
         9FiJSxciEH+u6mGgNgOlzCVKs0BZmHzi5EXQgh3aIT8v649bR7p+D7+eAYv2YZedEDJH
         MdxA==
X-Gm-Message-State: AOJu0YxLodm2sIfB+aNxUKe7qGowQomzk5tP0NviGAkRXKMnrBn2s4Jq
	j3UdTdoC5k02HmLlLZ1bvhMNy458SqAMp3SW0c5LrgLfr5DqWcU23fmSWzb0pO62
X-Gm-Gg: Acq92OG50OzkbEPdg/bUSRBfkev5PqgxdR1eNl4AGHUN5BrirfzwMWoTi18xrzBAUJU
	G6CE29WJ2P4DtmtFnhrzJXG51gjI7WeiYMB04kx/UdA3A/Gq+c82IuugBYvlfDeX7Zp22pvvdrU
	XEfImlrthmiRzbdEMEpQ+5wHYu43t4zvGv4N/U2gdZ4TdTlgJltnRQASmLOm7XLQb5OCgG2/pOr
	4rlrH7i7DKRsKw0MKkOwY3EXDnagH9g+rpvUE5X4DpuhX7Xm+urw0iBl33SEKnYy8QgAOPXsppk
	uxYEsvszQklJOZVYil6/HZyy0m9NT+8DyPgRPlNZfqj6+OEGbpYMn2eoZrafA8ZzMAo/y99FCH4
	Qmk+CKtROLCLu6bGTwSpKM2thkmXhEeoyFXUWaEwSLpmtFZ3CgSosIGUbE0Zro6gzPxfInvuOaq
	z6UFlrbjlUZ1yGi6V6/YByxKROsC7ZdeNDGSfMdj7jwRUdSlEoaUsRTPSB1pNs
X-Received: by 2002:a17:903:22c9:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2c2f0731f7emr19720455ad.5.1781161788709;
        Thu, 11 Jun 2026 00:09:48 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3046::4cf:39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2d9bb2199sm18818975ad.77.2026.06.11.00.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:09:48 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/5] devlink: Warn on resource ID collision with PARENT_TOP
Date: Thu, 11 Jun 2026 15:08:51 +0800
Message-ID: <20260611070856.889700-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611070856.889700-1-mmyangfl@gmail.com>
References: <20260611070856.889700-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297976-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,resnulli.us,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kurt@linutronix.de,m:jiri@resnulli.us,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08C7466F42D

ID 0 serves as the sentinel DEVLINK_RESOURCE_ID_PARENT_TOP to mark
top-level resources. While it is technically possible to use 0 as a real
resource ID, a user might be tempted to write:

enum {
    MY_RESOURCE_ID_A,  /* == DEVLINK_RESOURCE_ID_PARENT_TOP ! */
    MY_RESOURCE_ID_B,
    MY_RESOURCE_ID_C,
    MY_RESOURCE_ID_D,
    ...
};

register(..., MY_RESOURCE_ID_C, DEVLINK_RESOURCE_ID_PARENT_TOP, ...);
register(..., MY_RESOURCE_ID_D, MY_RESOURCE_ID_C, ...);
/* D is a child of C */

register(..., MY_RESOURCE_ID_A, DEVLINK_RESOURCE_ID_PARENT_TOP, ...);
register(..., MY_RESOURCE_ID_B, MY_RESOURCE_ID_A, ...);
/* Is B intentionally top-level, or is it actually a child of A? */

Add a WARN_ON() to catch this and prevent confusion.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/devlink/resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 3d2f42bc2fb5..574108ccfe5d 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -486,6 +486,8 @@ __devl_resource_register(struct devlink *devlink,
 	struct list_head *resource_list;
 	bool top_hierarchy;
 
+	WARN_ON(resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP);
+
 	lockdep_assert_held(&devlink->lock);
 
 	top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
-- 
2.53.0


