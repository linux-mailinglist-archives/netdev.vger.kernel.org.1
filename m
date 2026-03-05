Return-Path: <netdev+bounces-264600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAPOAw4lqmkPMAEAu9opvQ
	(envelope-from <netdev+bounces-264600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:51:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 906F421A039
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67323300A4C4
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 00:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95A62EF660;
	Fri,  6 Mar 2026 00:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BxRq4x+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A582D5923
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758278; cv=none; b=u0oESrlZHDvRjEa16/M+JgvcRE0dUtqHbWfoMHXWb8jQPwpDlG1FG8eepYh7qSaOrajP4B1Wn3cOdxEZKAleAB7kBg1WPDfw0RwgFLuMAf3LYyDxjfxOONQPS6LrfXYUXOyn/IKTEkF5HhkSROhmltV7TOmqVWcp9NzmeHKY41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758278; c=relaxed/simple;
	bh=3dlLQAlasBGbadIvHX9k8flSJPAsD29x0afq21FmLvg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ch17OJbTzwb40y4EMmjdIhim5OS2PyGiaHaNvarMV1fVx+lMJBj7fKpTlk4M7N4UxWlzQl/xV+HoLtKyXMSSn66g/eIHFRe/WEDh6dklGjW+xAlbHhI/NliQDq/C6v5t+tLB0hATXbB7Y93Rx7vfKyZC635HJ8AKjFOJs85oCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BxRq4x+7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so104639635e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 16:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772758275; x=1773363075; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfzwmS6sVtR8qdJxrV1EFi7Ums5fv3yYhTk59aaWPfk=;
        b=BxRq4x+7iY5HrEz5E1oYjZAXM5BCZB3+BqNSZPC5Uc4QBoOfh0ZLaJi7j3nVI9U69J
         TzJkFQlr1fkdKZtRW+QECw/tIBCkDnhaYM1wvZ6tH7qnfsdRDXoCtGS5BvoHM3VoiR1g
         VPtkZ4M+T8myVSIgKsjDJQDnNK1OC9Xbza0LNwQbJZHwwpTQNfjdjpjrr4r3bYlw+2Rj
         Yb07aA7TtvJbKNl2FqORAPLU+ernZ1/21V2103QEhKl75xG3kmiPOmoSa+3UcyO6lqGU
         0AOvZTuQFEuEbGxwjegqea44kH8hiyolb6WidlJVyLLRRl+nnRHvDRqnPgiHhKCEoyCT
         gK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758275; x=1773363075;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfzwmS6sVtR8qdJxrV1EFi7Ums5fv3yYhTk59aaWPfk=;
        b=OIh9IQYe9ZeIgc1KGMX13JILMM13sHuNP1Zbs17fPR9KJWwUoBpYwWRMbARe60XPJg
         Yxi6qR/Cdklv7tpf3aEGwxUCl86W7uYxu6qO70yTDJTVaWcTz0gkfdfkgSJgjty55poC
         jjd26vYB7pPj6zcnZF1S/U8ahse5/SPwr23AQjZyXmkX9DkTM37Ve0uB69j50PMNsQfl
         qlSHreiNqvOOPT1Zoh25RkzP3t674QPUdzsn8NgvyOz8H4E23wzlFxOLUNhocOLhAPfk
         8ddQsHE+9Le8PaEuzqHFAklSplEvcYNc/UtzqtIBg6gr20Px0HT1ip0l9VBAY0N7kZ5b
         lo3g==
X-Forwarded-Encrypted: i=1; AJvYcCX6mNq/njWa2HU+C2DJE0AkC9yaY9Lob+cwD2VKArMs4XMI2t36/MnzVhRIB3jAFyJIjxeHn+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ts16bDb/wLpMw4LqIaMORHY1BCOoYros0ci5imyWW5pYwjpN
	MqG/FsTTP7tEE0fmiTn1qLLhq2YdC9DpFdTpeXaFzwZ5ctNrhpGrH203JrM6ar1oAI4=
X-Gm-Gg: ATEYQzy5bcLLyKRSRDmrzwbAOGTHmDSb/9abMvv4jQL8+Ez+HrCXqIQWfN+o1y2nzNc
	BMzgJSk9f3Eclsshqz1dAj7DjMcMAVcwlghO9H35gYPrdNe5McEoVFt44xIm1ho3I/xsgdhcrOe
	zrv/ttpTytom3TD5ZBCH2r7U+M68uxDY+2ilX+SBohyfW1pEGANppRPe9v4hnwOinQgeQhs3GWL
	hHWywjXN+p4DpJaeIE11hzvkpMJNnWautx9j85T4QzDSD/Lq+FxULnToD+PifTMF5hWP9pJGJLO
	aBVfJ1dX/0DlI99pGjkNBFlqldP21w8gcsScRfMzvwP8rvMLjM9GUd5bGL2qEU00pHN3fGXV1zt
	2VBNWA6y52D9HnzsJmWFyupUvnMZWMp+lewHWT35qM9b3Fd7Vt5xpFodqq6UGD7nCr+gzge670C
	XJQk/+cMLM1QW7YZPJPqpp
X-Received: by 2002:a05:600c:c8f:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-4852695aec4mr2898715e9.18.1772758275517;
        Thu, 05 Mar 2026 16:51:15 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffe82e4dc5sm6259137.0.2026.03.05.16.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:51:15 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH net v3 0/3] {net,bpf}: nd_tbl fixes for when ipv6.disable=1
Date: Thu, 05 Mar 2026 18:29:54 -0300
Message-Id: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANL1qWkC/3WOwQ7CIBBEf6XhLApbtdaT/2FMw8JiSSw1UImm6
 b9Le9GDHmd23s6MLFJwFNmxGFmg5KLrfRblqmC6Vf5K3JmsGQjYC4AD9zRwb5oBb411T4pc00F
 qJUmgBZaxe6DlkKkzy2l2ySaqSByD8rqdv2V70ynn53zr4tCH17IgyYX6X5YkFxwQFFRbY2vEU
 3xEWuu+W2oSfPhS7H7wkHmsZFUZlKq25Rc/TdMbMpF1Nw8BAAA=
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772758271; l=952;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=3dlLQAlasBGbadIvHX9k8flSJPAsD29x0afq21FmLvg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM1TgpuypqguctN+xKfI46/kRMYE9SzBsWbPhuzyij0XFje/ujCBxrTCHF6tCJnA1lxc1tc3gCY
 jK7IWjxASLgQ=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Queue-Id: 906F421A039
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
	TAGGED_FROM(0.00)[bounces-264600-lists,netdev=lfdr.de];
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
Changes in v3:
- Don't use ipv6_mod_enabled() in net/core/filter.c.
- Link to v2: https://lore.kernel.org/r/20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com

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


