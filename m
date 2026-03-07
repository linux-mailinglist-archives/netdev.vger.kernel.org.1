Return-Path: <netdev+bounces-265177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEZDBb2PrGlEqwEAu9opvQ
	(envelope-from <netdev+bounces-265177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 21:51:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6B622D905
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 21:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B41453019820
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333DC2E9730;
	Sat,  7 Mar 2026 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J45mcSAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC12773DE
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916666; cv=none; b=QCkoqbYgbZJAHDHwBak06hzz00OS4MUpS4DADs9r+jjYUVfHCWy+/bP7cilwzgpgzxFfdqo8GJ2wAWg3K5aYHsqLKxBFDhXdqYopPH1IaY7V1r/YjCsDW9FSo1HI/X26iMk6pVebcWKOpzVcgT0zJzQgNOwdtnm/MzXuEegyoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916666; c=relaxed/simple;
	bh=6haq1LWJ2rMn7CiJy1QtMn8Y0nk+PfGJ1NB51Njj8RA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O7bJKpllpLXkEb4kkZlSwjd8hrr0G1QYypXnM7z3s4PCn4jVrikT04eWmV5KjYiZJ93/3YclR9MYevrLzBtZH8KcZffUptK3vTWdyFS44ESjbRWVtpaleA0ZbN6bFlal6X8T6+3TK16qRWGhqVbL9ycGmhFzbQKjr69/0OsSo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J45mcSAG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso12035665e9.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772916663; x=1773521463; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPwZwL7GcnfzeMamXMXXY3ZrtK1m1z2a4hvbEHv5oJ0=;
        b=J45mcSAGuZ95PpPbAN4d+u02Z4TS46ldcq73TKkNP6XTBeFRvEewGaUqRKctWfmFOW
         THsf9w+A3+Lc6y1EQYmaXHjorqct+z7WJsW2aB4GDEMRa0mODYH9M1LC4rZ1e7jA6/0H
         hu/9Km3yL+G/7bUySh4anVw1QzfuQtvFSeOatdH7vnIsa9B7Lg33kkOg4fQs1BzCtPQQ
         QXy8tclelv/cBeAMQrBEvqcXWPGh408ntegTe8FvLN4444iXspU57af6nyn+Olp0wSWL
         yBb2os0l7gvlzux4+UWBn/M7P36rBFLhpAoHZ+LhxW6U3KvFSsaEoFtKgxCrnO6Lc5Lj
         DIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772916663; x=1773521463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPwZwL7GcnfzeMamXMXXY3ZrtK1m1z2a4hvbEHv5oJ0=;
        b=wjdohRgFqUSuqkP2Q2Fo8nDBPBvgoIkmFBEuOi8VDtLBgUQPpTXhAE35LvEFlyF/yn
         IzSN1JLWFjqFTSdfNk69UidMBUcNQvPTSt4w7fdj8swdoliW1xzpWwCV3Q1ZW5sfaq4l
         yFct6wzDuA+EjwA8dMmiTwFBaVFTIS8yNHPUtdWMZbbW+ecute/H3GLMkS9xIJmcrQak
         bbH1Mz6AHixtKd+T+TkP6VO6HXoxkFsanI3hy33HC/zMvgxMdWH3y3D2kG4IH90x168g
         /zXLNchas/dYHiTklQ3sWG/+C1ltMe5RbSk4GKXoodB1A5gu+AGxpm2a2rdv0Urd9YyN
         AkiA==
X-Forwarded-Encrypted: i=1; AJvYcCW4obA/2ygaIWZT4qEiikXDjHA4fgKpg9R+1hmv64gStJ5iUdF/H/nASp99kTwd7RNtcQA4Xik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8p9PcqoiUHmLnHsYOF6Cm8Ff+Pye+elDxcOmWRc711pZ9uQCl
	SPeK0vJfRkNyxXUv1OzoGCRPKHL8eJ3OvuW5OFDFv7tVLgRY8X6nRKpjNP3n/gqicgc=
X-Gm-Gg: ATEYQzytLqaNeQ9k+Wo2Q0lhIpjRKphIzOiJrE7Sqc9DCfEmVyPzQ7tNJrg54iCBBOJ
	LGiR6+X+Gu+Gwe3NWDFhu/gQw6Nonj6XppQ3NEm5oDalhFmb8P2qdm7j5WLalz7MV/yTemFlQgQ
	VJ9HG3h2PMIBfobClYev188CB1XQ/bJzxKDsVqbOD6/GOBm26ftDvM4CeEB8re9+qv9/g1IMavQ
	gXABHr8UY7G7hTTFXhiBW+oCnYYlso6jmHhZCbaNlLungblUyYRP/4Tr8wQeIs8KuFPLZLM5e5c
	PLeyxKQx6fyvUFLC0B9NfTdJrnqAUKlPzdooYEiAA9xX7q/n9F9kRqvBySuQDcXzDFQugSbYib6
	cHdGkz35bP36inVUAbHcZ/mcBT0kXLjRaDt82Pdo6Fw6VfxLMGdS1YKdLEwcd3hPNXyKzmL+/kS
	fR5gt43UQetwWci39QujFC
X-Received: by 2002:a05:600c:19cb:b0:480:6c75:ddce with SMTP id 5b1f17b1804b1-485269791a9mr100153655e9.33.1772916662911;
        Sat, 07 Mar 2026 12:51:02 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b09a2614fsm6038280e0c.7.2026.03.07.12.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 12:51:01 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH net v4 0/4] {net,bpf}: nd_tbl fixes for when ipv6.disable=1
Date: Sat, 07 Mar 2026 17:50:52 -0300
Message-Id: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKyPrGkC/4XOwW7CMAwG4FdBORNInLIUTrzHNKE4cWgkSFFSq
 k2o747pBYQ27ejf/mzfRKWSqIrd4iYKjammPnPRLBfCdy4fSabAtQAFHwqglZkGmcNhwNMhpm+
 q0lOrvdOkMIJgdik0N1h9Cp4WXxyiqySxuOy7xzaO12eX8mO+S3Xoy8/8wahn9fexUUslAcGBb
 ULcIu7rtdLK9+f5zAhPb9TmFw/s0WprA2q3jebNm/+8YR8DQYtGOds0L36apjvNlP65TwEAAA=
 =
X-Change-ID: 20260228-net-nd_tbl_fixes-ce81ca1e0bf2
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1772916658; l=1847;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=6haq1LWJ2rMn7CiJy1QtMn8Y0nk+PfGJ1NB51Njj8RA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB5/qXUWK/NVELUIPP/zT+sFffR8F4SCUOdH+0tDnm9TxNZJ2GXSV7qA4OQUWERJEgdBNLxu1a9
 GXK8EFF6QKQM=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Queue-Id: 6D6B622D905
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265177-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

Hi,

Please consider merging these four patches to fix three crashes that were
found after this report:

https://lore.kernel.org/all/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com

The first patch from Jakub Kicinski is a preparation in order to enable
the use ipv6_mod_enabled() even when CONFIG_IPV6=n.

Thank you,
-	Ricardo.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Changes in v4:
- Use preparatory patch from Jakub (thx!)
- Use ipv6_mod_enabled() helper in all three patches
- bonding: Move check to an earlier point - bond_rcv_validate() instead of bond_na_rcv()
- Link to v3: https://lore.kernel.org/r/20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com

Changes in v3:
- Don't use ipv6_mod_enabled() in net/core/filter.c.
- Link to v2: https://lore.kernel.org/r/20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com

Changes in v2:
- Used ipv6_mod_enabled() helper, guarded by unlikely().
- Link to v1: https://lore.kernel.org/r/20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com

---
Jakub Kicinski (1):
      ipv6: move the disable_ipv6_mod knob to core code

Ricardo B. Marlière (3):
      net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled
      bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is disabled
      bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is disabled

 drivers/net/bonding/bond_main.c | 2 +-
 include/linux/ipv6.h            | 7 ++++++-
 net/core/filter.c               | 7 +++++++
 net/ipv4/af_inet.c              | 6 ++++++
 net/ipv6/af_inet6.c             | 8 --------
 5 files changed, 20 insertions(+), 10 deletions(-)
---
base-commit: b824c3e16c1904bf80df489e293d1e3cbf98896d
change-id: 20260228-net-nd_tbl_fixes-ce81ca1e0bf2

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


