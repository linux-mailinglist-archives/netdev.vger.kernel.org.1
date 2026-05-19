Return-Path: <netdev+bounces-289445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOlHLyVaDGpxgAUAu9opvQ
	(envelope-from <netdev+bounces-289445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:40:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4591857EDCD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 688F23059900
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDBE4DB541;
	Tue, 19 May 2026 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5Sk5Txk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A934DCCD
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194154; cv=none; b=SDMktkRPmld5J0kL3kNWl/T86JxxDIMfjoRcU4gpLf0n8W82bXs9aJXGh/MANPArqAU8lmbcFU1w7k09x9FcK3CqcDk9RAF/t7iJCcQ3pQDa64GrQkGECreqR73+fjR+G2PjEF62y5SL3ltW8T0q4qMxlUkPPuyPNQj0JylB0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194154; c=relaxed/simple;
	bh=D+2/EVKq9/7Xf+adkdI9jDdt1duhUByqR11WILXVobQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X7L7rpMW4wTRO569xcmlIojSTSHVhegVKxB8OPhhfBWD01mo/3fX0/zAVSTudIxNplqPKO/pgyPF///uwhl4oRgEaThkC6aL8n7LkkrGqk+tqQqeNhXbRYUokoBnHSI/F0VSjMJlyoeGR3gGrZmWin1KSOf7B9wgsYYB6Uh102w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5Sk5Txk; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7980c060cfso1522105a12.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194153; x=1779798953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+JHu2ds3R5KJ942QPjAKwmGWLPsVM/h7r8Q8dtsEwI=;
        b=H5Sk5TxkNt3iBrGJDbRHj56viezKoGWEt1Eh5WrodqRniAJ5U+8b5A3notzqQ3tJm/
         JeJLtRlL4xRIZjA3qzll++5BmtiDC5quE2V1ew7cg+dsynXOA42i76oaGUjyPMDjV2qs
         9r9iCROw+4ZAh5uMZZsjRJyZSpS4d44Z9xHiLgv80M7RDVUr0p53i5NOJm0AjAexVgc5
         Dpx+0RYfRy9b0lGbpB329S8wZFMGmWsdoA6u2EVbPTRoKqorEBvP2kiCuuO00PYwki6R
         2GohMRbkuWD6qPD/OWsPk4v0tOxqMahE4VplH/Pv08qZO3vzApi691Z58YB1AhzF7Ecp
         GQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194153; x=1779798953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+JHu2ds3R5KJ942QPjAKwmGWLPsVM/h7r8Q8dtsEwI=;
        b=QIp2DcyGTiLd5WJpHc6bSdib4mbxvdC2fFWJ6dx/UxTv9QVUS8Z9VgpOjLTPwpNStE
         mPq3a8BqLSyW+vbn6nPbHawIQiZDLOjcR9eW+YIAcnRfOv+IBd4CqdZ+5sX9NVFQPqwL
         gbIM+4Vm0P45tgc2vDkWJlHBFs/DDkCHL0Gt8EP8loPFbocwqVdJWEcHzUmotiudSlEJ
         BplKlza3Pea/TGrcVE4Juq+D7TxVt0cI5Al3OiBQeHlY+Nh9nbq70o4j5S4LKhA21JOH
         b4JubC5t2mVsqmJNNfNiQUCFZpb0WkNwHfiA8jW60A6aCe6ED+lGOIFfw9HaMvEnhrbQ
         nAGA==
X-Forwarded-Encrypted: i=1; AFNElJ+Hr18uvHYozb/PtB/7+EMUwB3RBA40pxqokttcyOxi/LTzDirvMTaYNxyWYJv5/kfS4tOxJxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyswA91ZIlNMctudDcYuVE45Koulu/U+ZN2/t+4Q0AwyxnXE+jK
	3i2jqZ6fzOOlBJQja6s+yzgPiy8ckFLcFPYkJ/f2GLtU7lhRZH3+mhc8
X-Gm-Gg: Acq92OFouiGTzrOOY3RRm6RJh26OPdPMZ2kMfzDU5AAUcBaoP26VqK3MoizCFrJ/mXl
	yqDZqiBXNHZ1QYv0DDp45wLSZ3qwvLhmMtI6mzKaB0YfudLeg3ZZbypH+VD765UKJwpL+J873F+
	BpypVUsoBQdurN6kfL67DtNFmRwM58c8Q5iBt/kDpfEk+S3XJ7azebWv5x7xuH8d4ST/jYrzV10
	BpVbmrUyabyX8kACtwBZc8C1rP6R2VC/J5ZyiFuY5sQ0xkpQAw567o6g6NZAFasEtWXAtVwVlxW
	RMLS22o1gkCqfk98kQsIIl+01h2K0DhkF2J+u7zIfHmKvd6K5QP/cceg72yttMzhm98OKLnyDzS
	vvYpGTWVFKp1RzBH8hUlIxnWNtCO2saZf7xLHO/Vd2pDmHv0p+x007XhYARAYfYyB0OfZg37Vjh
	7OCg/4MwYU7ZaQQLN3X84Rw9JRHGyQX6TR7uejoc4RMr43A9Fa
X-Received: by 2002:a17:902:db08:b0:2b9:ec37:2977 with SMTP id d9443c01a7336-2bd7e98f43dmr211656335ad.38.1779194152825;
        Tue, 19 May 2026 05:35:52 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc60sm193216245ad.9.2026.05.19.05.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:35:52 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Shaw Leon <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 0/2] ip6_vti: vti6_changelink and vti6_siocdevprivate netns fixes
Date: Tue, 19 May 2026 20:35:45 +0800
Message-Id: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289445-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,secunet.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ip6_tnl.net:url]
X-Rspamd-Queue-Id: 4591857EDCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v2 -> v3:
 - 1/2 unchanged (Reviewed-by: Eric Dumazet, carried).
 - 2/2 (vti6_siocdevprivate hijack fix) is new. It closes the
   regression Jakub flagged in the v2 1/2 review. PoC details
   posted in the v2 thread on 2026-05-04.
 - v2's 2/2 (ip6_gre: Use cached t->net in
   ip6erspan_changelink()) was applied independently as commit
   1d324c2f43f. It is not part of v3.

Kuniyuki Iwashima (1):
  ip6: vti: Use ip6_tnl.net in vti6_changelink().

Maoyi Xie (1):
  ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().

 net/ipv6/ip6_vti.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--
2.34.1

