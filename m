Return-Path: <netdev+bounces-235744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68186C34790
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 09:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 686A54F508E
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 08:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E582D8783;
	Wed,  5 Nov 2025 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktn2wf6+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870952D47F6
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331347; cv=none; b=sU/noVFt8n4bJ+kUfooc4hBdAtc2nqyxRCM/0ilJEAsEolU/sp7Q2ub7rU0+A8T2BRYTIqFdY/YCKR9embVz3hQqPFAxjwr8MiXlX/OA9KZ+sTyK22eg3jSGKaNg+V5ZJSN2/2SaHm8q2E/JRYV0A9IaLAkMjSf/vq4iz9pkfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331347; c=relaxed/simple;
	bh=JCT0cIGFIb+7hJzJoDKFu6cIic9VjB5YZyyICThf6QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqPo+ZHUlax6uP35Fd9+kLSXv8CtZbqU2QZxdzB2hX7gWEncnJT9gZxW+aaPqqJZU55U1ASalRYfV3QdRTAE/e4Jz+JqKyrkUCxxRxK5uRlUJm8aUc/fbcg/q7MY4D6n8+wuPftdye1UNrMhE6PQCssLILz1GpKNMdhqYHrv6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktn2wf6+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-294fb21b068so73704175ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 00:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762331345; x=1762936145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkbrXOingW7aqSJg3omHMbYNNeZATOZwi1DuylKGH54=;
        b=Ktn2wf6+N6BLf67VoJRPYoCMNs0dnQvn5s1hO0/UexYf1Bv6gpEz3qGBP0JKoGM+ee
         B/SW2GOLM0zVWAK24L6iubyJwuGMTuY+XvFjVymLYf/6Lmq+UMPHcxEER6wwQ6GRdgnM
         pk1xqLMIFlmZ3rTNqEt/p5odcRT0Bj9SOPp6uJQDLJCeCpGw4R9lGr9kWWj1G6ohwD4I
         go0uc3JFTSSXmiahUBDwUtAjHddVByGKpqT90+7C/M4U/zTXzYZ1fYtNMGgRbg6WVu3N
         JuY2Cnw7H0mt3nDc7Og6mKvC4eccYmNB0vtKfxG1rb6K9M/xXSEM0JJ670O2tkf67Mw/
         sqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331345; x=1762936145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkbrXOingW7aqSJg3omHMbYNNeZATOZwi1DuylKGH54=;
        b=sRhu/U7Ec8UAsdY6YOet/mu/H9WrB/NerpbLY0F0r3zN8YHiQesYKUcPtc2WtbQKwb
         /T/CvcWc1df+EMdhMLozbiJZcCxtuwQJNfL3k+0ReeKxOvklESKCfyLGGaiYeWc0uNCx
         l4c2l1ytyMwVTk38Ir+mvdkjmbbGNg/B4mquIJZvCF2maoP/sbknrQojMfq/Hgk58VcA
         1QL5gQ9Eg7Xoc/mMXSG7OvpZJLFHdRMJs24eikZgWTqrI1qv1/xa6xVtTsUd08Y6cHP1
         7RcpD0Lj+v+DBSruJUs3aklH3txC7we0DtFVNqrw5U5Ghj4/3Iu3IPLfxAwBoB4/IBUX
         x5ww==
X-Gm-Message-State: AOJu0YySSMdwOK9mo4arK6gewUVk5Hd3FYNG8nPd7h0QKCjdxo+JchR2
	Irj58X3r8NCOmSd7+6zLOcD9WQOJsyk3IfftZZnTqL9FIVHsziTjwrwKsITO7/VyIrw=
X-Gm-Gg: ASbGncs0H9oulyLDKnSCCi0lWkZh3thhzvWCAY7RASDj0VHu69FcebKNiquf1oXZAgl
	FtpDQ/S81OjE5ip+VocSxrC7n/WlY8ngt5k6wAnnlSdvTVdblMUEGj48PgyNi5+SoyZcLpIl78F
	O4ODkVzI2YT7ohddwkYmBdZYlqSB5A4LXR/wZcNUR/Nd+tekxb0T42SJE4rDE7LW4/TBS9w/+aE
	nXHEpMKkT0E4LI8PC1ElX8axfHsXyNlYvSZqspaOeOJk03QCkkXfTfnEPDYD/icM01lycvjK/em
	bsMXeqnUU2IA0A7I+SFYv5pEx4RElONh+iLF/RMCaeztQp7rJpEe22OlU2QGRtqEwI9F5cnV1Us
	FMUj/FeUbW5H299bEOjRWznPq4k749wNz2LzV0wtQbonEsQdcIKyJgP7rF4hrFsuIkj/PGxBCDw
	s6Z0KUsJQZofNlIXE=
X-Google-Smtp-Source: AGHT+IGXfsqAGJe23VtBidhjZNWXDDso/VGagWRPfLHOCqYgrGlGqXApcn2/B1g+lr01sAfi2kGWzQ==
X-Received: by 2002:a17:902:e746:b0:269:b6c8:4a4b with SMTP id d9443c01a7336-2962ad8277cmr39532055ad.6.1762331344777;
        Wed, 05 Nov 2025 00:29:04 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a3a0c9sm52171705ad.55.2025.11.05.00.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:29:04 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 2/3] netlink: specs: update rt-rule src/dst attribute types to support IPv4 addresses
Date: Wed,  5 Nov 2025 08:28:40 +0000
Message-ID: <20251105082841.165212-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105082841.165212-1-liuhangbin@gmail.com>
References: <20251105082841.165212-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar with other rt-* family specs (rt-route, rt-addr, rt-neigh), change
src and dst attributes in rt-rule.yaml from type u32 to type binary with
display-hint ipv4 to properly support IPv4/IPv6 address operations.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/specs/rt-rule.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-rule.yaml b/Documentation/netlink/specs/rt-rule.yaml
index bebee452a950..7ebd95312ee4 100644
--- a/Documentation/netlink/specs/rt-rule.yaml
+++ b/Documentation/netlink/specs/rt-rule.yaml
@@ -96,10 +96,12 @@ attribute-sets:
     attributes:
       -
         name: dst
-        type: u32
+        type: binary
+        display-hint: ipv4
       -
         name: src
-        type: u32
+        type: binary
+        display-hint: ipv4
       -
         name: iifname
         type: string
-- 
2.50.1


