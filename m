Return-Path: <netdev+bounces-264537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LrcD9bpqWmLHwEAu9opvQ
	(envelope-from <netdev+bounces-264537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:38:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9946D2183AF
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56E6D3068ED9
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756B34251F;
	Thu,  5 Mar 2026 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bucZWolx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA7341660
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772743069; cv=none; b=eUBt4qEyvwP9KXPyHSwItSEyvrwW0+yBlwjKQ/CMAMjMYkbHzcuIaUvuWQHaSYZkbG8FdJVx4TGOQiue3Jg0kh75mgRwRafsT6sh1qlsfRicDhN5wmdm7FH6Z/z3f3xI5xgJz4dtiYhnrBMne+SLDf2sYT+HXJsa0RQChOxHaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772743069; c=relaxed/simple;
	bh=/IwkILeodrC7NqQRZGEPw4de+F6+xh13MTvPYfB4lc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OXFmaaJhpSF5BgPrT2pOZy0AcaSHtAToGqJsdW67OvLBzctqtxsotPs2l3cIsMUFn+oaFMt68Z6xNbBeOTX0nraXNy7zMOlzSOMOXAH1rWuEHMuoKDki0OHaC/Ud8BpiZcq54GtTodiL/VdnItNxbXEOAzEiaxHVHv6HVsuhoVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bucZWolx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso87352955e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772743066; x=1773347866; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DLvaD3bMLmlM8cbx20j2adun/7v1LedrEMbUl53cJ0=;
        b=bucZWolxiauuKmwF35x8H3UlhMBVPxKFLU4jU9lsoOkKo1abWnNXG9AE+lLJMtfLDW
         cF1VE6fzoM3MzicPu4f7zaHfajlZxpChLWN8GTNDN5qSykciC8aBNlhvQ16cBc64fuDh
         fRZD9PFZ0lYaMbqY21XwmolcCrwnCQkHZGAencBw9ngpocsSSaCrxibP5uXJ+W6PDjNS
         6vma9/qZlW/pYJ+odesP8QwAmKy74XZ6ze3K6GF4GcprY4xDKkXc4UnKc8H9ja+Xshr1
         3M40xPfwFMZ8Vx0z55Pkixg03MrNddmkBZB3Ti2hGg1de2N/cUVnRfWtDVXMiuLO9cs3
         tHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772743066; x=1773347866;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DLvaD3bMLmlM8cbx20j2adun/7v1LedrEMbUl53cJ0=;
        b=qxyjnyYEQH7BBRF+vu6VOyQltl0UDb16MmUzvOcvWDiypOUZGh0TGsKxYJMiqTP6y+
         IN50v/XnSuxpKqls08YaKG0Wiw2KiokYFQlbiKaiKoBrABcoeBLJO5z+Ahm2bzLKkbTS
         tS/QC97nZ9u5XmGMTRVgbWMyrHYR1WhTAYmnTq2JP+oAw7eeJNmITSN2muyLM6BMDAWi
         X7R0UyatZuhdD/rcGG00Mbjlz5KCRo7IHtRYYLJ/qXLAt51v2Oc6sOBT3KiA/miCmWvG
         eXI5mnp4G2X7sDit2eczY7Izqnmq8+tQu1plg2xi/j8jn713hhEia2V4eQ87OZbz4yOP
         2bTg==
X-Forwarded-Encrypted: i=1; AJvYcCUBjgl7+83z2m4sefTj/AEFGic6xEWavop/Pzm+SsIOoPmUVOxuX6wtIzfl98HP6g8InhkORv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGMmsX5bOUiHJQeIZmGq5AQX+6FgCZMcIshCyszLcdKdbpGyS
	PDiWr3kD8H5gVv0544WxnsHVM9aGWlBp3vIj2OlaxrLdLZziWmVil1PDqhjKcGVbK8s=
X-Gm-Gg: ATEYQzwTfRzFow3beezi0FK2FIXtDOXygOwzVelReFdVhjvFbp7GQj9ySiKxgAQ6Zk8
	+SJ7cpqJFfPGgiYt6NteXrff6uyFWmRUJnxPs09dAHED3hNHXjagv/AsLQ7Kv74BRwc9aI0hjNs
	cMLHcaZana1x+QhTYWJgOjwxF1epWcWDWB43ZbswYoO66wdRM7w3n6YxwNgFa+afuCxE7nj4dQD
	2dK1GBgW0Oax4jA3s4t50z1SKOLJdvSO4haTIypiZNhMrMRkkgbOIWgy58o7swyxqGfviWYnzc6
	vvCxHofzM1IECA/X+ov0FBCkI8kic5rqpCgj5E7eVgrTsWHMxRovnRNfJm+JmB3/aHtwNiFqE2x
	FZ+zNt6mF7GanQOOTA9ChjBIbthM/Y8rMTeNER3lzpcTdknXlxaYx4vGzKNwoNjbq3KT+K95PXJ
	y4pbmQVjnXpCwCp2f21AeS
X-Received: by 2002:a05:600c:c0c2:b0:477:a53c:8ca1 with SMTP id 5b1f17b1804b1-4851eea2243mr63708215e9.14.1772743065569;
        Thu, 05 Mar 2026 12:37:45 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df63d6695sm22209647241.1.2026.03.05.12.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:37:44 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH net v2 0/3] {net,bpf}: nd_tbl fixes for when ipv6.disable=1
Date: Thu, 05 Mar 2026 17:37:38 -0300
Message-Id: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJLpqWkC/3WO3Q6CMAyFX4X02urWGEWvfA9DyDaKLJFhViQaw
 rtbuPfy/Hw9nUE4Rxa4FjNknqLEIamgXQGhc+nBGBvVQIZOhqjExCOmph79s27jhwUDlzY4y8a
 3BIq9Mm+BUnfQNlRqeieMPrsUuvWa2ofexbT2uyjjkL/bB5PdqP9jk0WD5MnR+di0F+9v8hbeh
 6GHalmWHzNHunnPAAAA
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772743062; l=786;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=/IwkILeodrC7NqQRZGEPw4de+F6+xh13MTvPYfB4lc4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QC1kJhNcsubZdQMCXSAkTlfiuEIhWDdOuspkzh75jnCLWRWp9DC6ZFiGNyqhldy7B5M2aEPrMuS
 XAiBCfdnedgw=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Queue-Id: 9946D2183AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264537-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Changes in v2:
- Used ipv6_mod_enabled() helper, guarded by unlikely().
- Link to v1: https://lore.kernel.org/r/20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com

---
Ricardo B. Marlière (3):
      bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is disabled
      bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is disabled
      net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled

 drivers/net/bonding/bond_main.c | 3 +++
 net/core/filter.c               | 7 +++++++
 2 files changed, 10 insertions(+)
---
base-commit: b824c3e16c1904bf80df489e293d1e3cbf98896d
change-id: 20260228-net-nd_tbl_fixes-ce81ca1e0bf2

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


