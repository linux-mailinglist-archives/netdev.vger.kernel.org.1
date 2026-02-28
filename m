Return-Path: <netdev+bounces-262182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC5MORZZo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:07:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED60A1C8C83
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 693FF3028067
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD442F566;
	Sat, 28 Feb 2026 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D+gZfHnI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCBA42E6E1
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300812; cv=none; b=FJfjxWmrk+DN4V6vpoJvpMFt2YG+nbjSj1fJmRZ7qkpJnUpQPO+J5zt++/E9t3BELNcAQY8LCkgowU4FDrWijjYyK4WX2dPNsBEJM5083yxmaR0/jMUC1AIkavUPW/klYdI2yH9/RwC/nljH9Lny46/Sf8d6eNjOqgfF7jbPZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300812; c=relaxed/simple;
	bh=dlKdIuS6xnavxo8NXhJsDvvrNxnPlWn/ak3wdXheDj4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H+CF+iot++DIIW86waQOLOKWJqmvZ8OZyTBpIWPqt21ZeyDsRGs8UNKnCFwkDDptU49uEnTvW/Fyr048uKE/Ntakf+dLolB6/7Ha4Kx2an+tXMW7fGKq8Pf9/KacATMnuaGalnOxEXX9gGiUdje56Y2h+cfw1n0fBYecx1F74eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D+gZfHnI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483770e0b25so27054625e9.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772300808; x=1772905608; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iT473GaNSiBNvy704xGRv3NDVuBZ8HLXblvauGdhRo=;
        b=D+gZfHnITIYzVpBJmg3Fcx+mXA97FUb3sTTpKHeK8ZbIrHtY/YnhS+udvwIr+S0Y3w
         2UTBSczWl1twoRZYMPgI5q9FA+kDYuSGDFgyL23BWZziQ5nB6bFnKkFR1jjMBKg9dTy3
         Z5Qlhj7rghVggjO/pTkVmujWAmKw2jLt/VMKIERG5qT1vvTmNp0Zqm6OfYntwghzB8mv
         Qa0QxhaEdwzahPMvOqdblOZTl/bNEj32kOq0F+eI5R79ndgFIeqkJv6d7cw3nhdPvn5Z
         rEaS6sc6I1qcBpG6HDfzN95cCyXSaZE57Tlha22h9urjAaNnZDPeTQ+SSru+Oesh2J4w
         YmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300808; x=1772905608;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iT473GaNSiBNvy704xGRv3NDVuBZ8HLXblvauGdhRo=;
        b=AYxN6PTEQyCsDOFApRjGzFaNwwASA8s4Jfs94DffrdmXfqTfNckyzg+O350vy7ol0i
         Avs8vJfNPaIsTlIodTbxGAJKXZgcszBqosW4omN1G+uXwtdEP4ty8tmYiMn7xC9yAPzQ
         Qy886Iqp5mpmbC5taFDVPuwxVtC1PrbZG+k8V7fs/adH5CLPSalc9yt9JZtMfSxo68Fw
         uvk9aXbE8IF7IXAdJ6u24qkVfoNdFjFIeiaE7lexqIv/d3b1qgh9HSTOIujBQ4THhR+w
         Mm0zjR+CCNE0rU9kjVlT6VSiAxuw1s2RsI2wz9aBB/41X0zZ+8PSAHaxfsr+9AjIFjvd
         EFyA==
X-Forwarded-Encrypted: i=1; AJvYcCVji5BPJt3lH9z1fQXn4Pmm84jFciI+mBx9vFEZ+hkaTD9bkNTU4mwGHMFbL+verY+GltKjVpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx245T0ecI21suvPXLBF1Rl/BQ3CEwZlM9Dm8KmivXVfKNCksFv
	zGE5nVpMx0L0vPZjjag17zrKJ3O7e7HlzxZ96srZd/trOsNEz8+/9E0vt4MROc3NqlA=
X-Gm-Gg: ATEYQzw3wHoD4woNVOAMd6oCJgm7w6eEQUAcv0KB1Lr3fxWtrIHAMcC+uXT/XuU85hz
	2cYlllgr0+9wfvUL2J7uuQvN8eb79G4I4efXTJHCB90JGTTbKzZF1+RCxHn3NrXhEUTE4MRJD+7
	aZxmkqFEZdnKtGXnQNE+PY1NrkvQCW0SoTVsXUbxSXp4C0l7+pUHMnEHJwkHDTfTXOMzgZnXgjU
	CpBu2VP8jvNnkypEvMysBdXP8kErVXWYwgNurc5/fbGZyYy/SKD6+dGc7aJXYgY1L7LdL6JAV5w
	+1EokEd3Rw4cTgSbdg4erwbuGCi1FroPpH6ZuIp2gQOj/HVkjjm6jg1mYqvo4JZNZJrFeVaWAXP
	9odYwp3NXdBBdZjR3rfap828zDDIL0bjcvlmdr2VtkuanHJ9DrUdblirOwd16oZA/5SeJWKDspy
	HQj0Pne+Yg
X-Received: by 2002:a05:600c:8106:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-483c9c1d4bamr114327185e9.22.1772300807882;
        Sat, 28 Feb 2026 09:46:47 -0800 (PST)
Received: from localhost ([189.99.238.12])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91bbd85csm10470908e0c.7.2026.02.28.09.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:46:45 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH net 0/3] {net,bpf}: nd_tbl fixes for when ipv6.disable=1
Date: Sat, 28 Feb 2026 14:46:25 -0300
Message-Id: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPEpo2kC/x2MwQrCQAxEf6XkbHA3h1L8FZGS3aY2oFE2RYTSf
 zf2OG/mzQYuTcXh0m3Q5KOuL4uQTx3Uhe0uqFNkoER9IhrQZEWbxrU8xlm/4lhlyJWzpDIThPZ
 uchRhXSHWcAtY2AVLY6vL/y3w+clqsO8/UCMlM4IAAAA=
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772300803; l=871;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=dlKdIuS6xnavxo8NXhJsDvvrNxnPlWn/ak3wdXheDj4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB5t23466LDdlWe6GOU3Ku7w2y7zVm4BReIL50g45VmBStweYPysdCxLRqjdUXULpUemO9qKrNW
 llnNqSeZvsQQ=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262182-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: ED60A1C8C83
X-Rspamd-Action: no action

Hi,

In line with [1] [2], I'm sending these small fixes for similar crashes.

Thanks,
-	Ricardo.

[1] https://lore.kernel.org/netdev/20260227112701.3990-1-fmancera@suse.de
[2] https://lore.kernel.org/netdev/20260226234059.19402-1-fmancera@suse.de

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Ricardo B. Marlière (3):
      bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is disabled
      bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is disabled
      net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled

 drivers/net/bonding/bond_main.c | 4 ++++
 net/core/filter.c               | 7 +++++++
 2 files changed, 11 insertions(+)
---
base-commit: dabffd08545ffa1d7183bc45e387860984025291
change-id: 20260228-net-nd_tbl_fixes-ce81ca1e0bf2

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


