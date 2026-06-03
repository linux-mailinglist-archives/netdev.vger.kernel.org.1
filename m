Return-Path: <netdev+bounces-294507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1kq/AaqGH2pSmwAAu9opvQ
	(envelope-from <netdev+bounces-294507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 03:43:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8D06337EE
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 03:43:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VsSKFUes;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294507-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294507-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBA0030CAEED
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 01:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103237B416;
	Wed,  3 Jun 2026 01:37:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63E3793CD
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 01:37:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450674; cv=none; b=ZChZ0CQDIoRlSqiMEQ2YxigOpW82C6hgxDTCmVE8niDaKU++TmanOdOUTvli/xuvof9BkOqbgQ/J/MgPW9s89XHBphUjapOOkaW9baH0lWOZX8NF4PVA4LLnxx05xR4v/u0LZG1kQ6kWTZE/K7CnexSDIL9eicnxCuix9lUVCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450674; c=relaxed/simple;
	bh=ES1WKSCz5Ml4lDjJOECrth35UgnTc42Rx9qt8CeRlDg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JlqyaH1w0TIAYs5LWN6EOFjRCyHqJsaTLQpDiqAYXt5NiIUz9Pot7RpOWXo3Xxi8oLn8Szz7cI+tRVLPtoxLl3EkYA3roOMMzDyn3cF8Lje9a63DFsnZpcp7JcRnnUx30gHjrLotyEFsV8o3nOjIlw9BObIAXJDe7k6yQpSEvkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsSKFUes; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf1cda2b17so984995ad.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 18:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780450672; x=1781055472; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=snamOO5LcthcZOncECWMujwY0sGVCI9tyFlslmu3fvU=;
        b=VsSKFUes+Bb4sngu5DPpsyMS/5v+k0Gma8I1jRMVox+r6CgdwbYp51KQ+ATagAitXv
         kdCb8PX6gLYeVUcqTqIb7V5sIf3FydxCmQ/vP44wT/B/97C9Oihkv8BDOY7ajf2kFmdx
         2mNmb5qoGLCydQcI2TckJJpISQeMAGbOSotxDG7tnYmY1hWptY8fYKWP+Lg44c47tCyh
         qYI3kLBwpbh2kruNgnAlTVMiwY782I3rvRf8VWZwlOOXNZWsClSQez/ZZ7JsWeBPh363
         O7u7K793Gz3+OmNaey+zl7GUCGxkFV7uni6gVms06hNYqYgwNOdVC0c9qBi/EzGVyLcw
         y9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780450672; x=1781055472;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snamOO5LcthcZOncECWMujwY0sGVCI9tyFlslmu3fvU=;
        b=Bjpke3rEeZWtIvduNjqYo3v8uQWafcO3/WmFNzdtdRCSojIR+Mmb5Jcj/5amVC1wou
         mkcO9t7HCYTyw6M46yLIvsUJ/JIwb1lu9K9IKEwrrJ0MJwIDlsVZbA/Q2kZ0bqq4qnx0
         KFSPn75jiBx5hGxJx4zXHsIM6II0S6irEr23UkiON6qqNMDoeqrks7lkLgQKdUod+HOn
         FuA+A6zHEZUSuzhMlM/JWKw3SQcou6uLzRIIfvfUaJ4FB9v2z5mMZKlEkL/AuqoHL1jP
         Me4G97HY9yziZ3HUAtbQ9Y95+EGBHpMEv+N0V6DDqtwGI7SRqj6+AvQwHbfJbQwPkOnS
         o1mA==
X-Gm-Message-State: AOJu0YwIlXot8xYwuVLaIqCOMV66yb+Xr53gOah8GSwAqo/7s5wsg132
	iuv+HcI1l5joG0RjhwONt8NqPMpTXbmtvld3KBzvdiskwqlRlf1nfFcf
X-Gm-Gg: Acq92OGNsUXi2fqoABAXrcdJxb2XrTPj3MvCBmoUsrXUB0D5B59ZYCXmkxf+dC/mNF9
	U7pR+PMQVnlj26rzu3QlTkzCMZp0XI4QfpeR63d6jbw2BLsOrDazfHgzGTLvIoNFBEBrCJhiwZw
	F6KVn0VN0If8U2NdYUo+e4HFfWB7h4suRfwN01sEPQkuhnzE83fLT2WLi5UBnd/kYFlEtQBkLCY
	VDm1LgS51Rgh0ZK4dC/W+w1EuLn5FvgBmogtJ6UN6R3tUzZSQSss8enX72U17CYhYM583BqmGTG
	C7+l48k7v3ck+rkohEo4Ay0CU/qRTFp6ZfotJ81MIIFi001KLyz9WD1rSfdcZZa1eFBjuIx50Z5
	7EEtLSVId1E9tny9vgS3yFAbIWtJ8A+KfQT462CF2J9ETlVFyIGwCIRHEE1Ry31VWhHyHM1upwm
	c5OfOPLJtvnS2B2nYFX0qUe/r0naEQMF7wQyKloosZ
X-Received: by 2002:a17:903:37cf:b0:2bf:361e:3edc with SMTP id d9443c01a7336-2c1644d6b20mr9705345ad.2.1780450672261;
        Tue, 02 Jun 2026 18:37:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1663981basm5174305ad.67.2026.06.02.18.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:37:51 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 0/2] net: devmem: allow bind-rx from non-init
 user namespaces
Date: Tue, 02 Jun 2026 18:37:30 -0700
Message-Id: <20260602-nl-prov-v2-0-ad721142c641@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2FH2oC/x3MQQqDQAwF0KuEvzYQQy06VyldWI01IFFmRATx7
 oW+A7wLxbJbQaIL2Q4vvgYSaUUY5j6+xj4iEVT0KY12HAtveT340dV92wyi8hFUhC3b5Od/eiF
 s57Bzx/u+f4ik9ItjAAAA
X-Change-ID: 20260529-nl-prov-491a85c020b0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294507-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 8F8D06337EE

NETDEV_CMD_BIND_RX is GENL_ADMIN_PERM, which checks CAP_NET_ADMIN
against init_user_ns. With netkit and netns support for devmem, it is
now useful to let workloads holding CAP_NET_ADMIN only in their own
user_ns issue bind-rx for a netns owned by that user_ns.

The first patch switches the flag to GENL_UNS_ADMIN_PERM so the check
uses the target netns's owning user_ns. Init remains permitted.

The second patch just adds test cases. They are identical to
nk_devmem.py tests, but using a non-init userns.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- some pylint fixes
- fixed import issue
- Link to v1: https://lore.kernel.org/all/20260601-nl-prov-v1-0-9bc57d6ca3f3@meta.com/

---
Bobby Eshleman (2):
      net: devmem: allow bind-rx from non-init user namespaces
      selftests: drv-net: add userns devmem RX test

 Documentation/netlink/specs/netdev.yaml            |  2 +-
 net/core/netdev-genl-gen.c                         |  2 +-
 tools/testing/selftests/drivers/net/hw/Makefile    |  1 +
 tools/testing/selftests/drivers/net/hw/config      |  1 +
 .../selftests/drivers/net/hw/lib/py/__init__.py    |  4 +-
 .../selftests/drivers/net/hw/userns_devmem.py      | 49 ++++++++++++++
 .../selftests/drivers/net/lib/py/__init__.py       |  4 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  |  8 ++-
 tools/testing/selftests/net/lib/py/__init__.py     |  4 +-
 tools/testing/selftests/net/lib/py/netns.py        | 75 +++++++++++++++++++++-
 tools/testing/selftests/net/lib/py/utils.py        |  7 +-
 11 files changed, 144 insertions(+), 13 deletions(-)
---
base-commit: 0906c117f81c2ae6e6dbfa82719f79c75e1c9325
change-id: 20260529-nl-prov-491a85c020b0

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


