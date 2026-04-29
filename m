Return-Path: <netdev+bounces-282455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDM2DU5G8mmApQEAu9opvQ
	(envelope-from <netdev+bounces-282455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:56:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE234985FA
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A605E300789D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1473D41B34C;
	Wed, 29 Apr 2026 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUoc0w6z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680138C2C0
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485379; cv=none; b=RyXA3E39ptULt8voltF7LzUKRRAvSQV2FO/49tBKCEY8OQfdi3svwr4r0uvmWVqiHmLMPCnn5R3cJHyFFhdZYLixMhqqexogOdFkO12YBLdiBYBbOOdrBHPnClNDlZnSoN7k4Q1XdA2UxIxkStCy+J3SWOCGn8+9SJECstmXnxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485379; c=relaxed/simple;
	bh=3OxTu4QNmh4FcfaWOckhLbkPnokTjOz1m2MKBETIPtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HLlStu/g0wKfOWnQ0sDworq/D974hiNsJJ8GUDmbmr6pagYcclXt/XVO6F5WFs6cX5EevucTV2sd6rwGP5A5g6zO5Y0YX230XDI2CIA8eIUTS3hugo7W15SyGLA56GO8L3IE4MP6PEXKXPPfRI2fmKrVQD3qLfeDDcKxk7hvPDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUoc0w6z; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43fe608cb92so48064f8f.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485375; x=1778090175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4NsrOL1q9Am89S8Z+OaW8+HqXPWLvbAymgwFLwuQBI=;
        b=TUoc0w6z/793eup5Y2+Wx9TN1zDZbPFz7ps9hUwk1FFnuKRsVcFPeL+2Gq8TFj89xb
         7Skqkqp11WXWfyvxwc5pt52RHGC0dZLWcwch9vNGyG4875Z+B/wyt9li1PAtEMgabhX2
         NAZURJLcsimuTEDpkjqf4u+CE231mnvJGzJBVSK6Lg9KcJck9Il4jsOXaFuZ9LInqSCe
         zJWqpPTf6ZIbfuCglXtkTCD2xaLMo3D+gOFzvPhMhx6XwGIJjDlNbJDFyu4yG1fGYpm1
         /AUJxiXGWdnk2TS1xCTzSN9l5Lk0i9gSlOZbQHCgZzLJ6292xcU5CEItS1RBXWvh3iwc
         HJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485375; x=1778090175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4NsrOL1q9Am89S8Z+OaW8+HqXPWLvbAymgwFLwuQBI=;
        b=QvWXwLGX5NwZpgoWo+kEOSamsyZtgzLCyNWjb/16yz7cmSt7MB2mgxbKiJhdcyyEty
         Vg4OIczzcyK9T6rs25kmzHqceOXWHGDOBcZKMRqV2tWfSy/kSnEJU5OzwzFeWDpzJSXS
         mp+PGgRoyG/CxaIKVvE4LIEPmtiIxw1c+o0XQyFqzvSOj+Z7SAMrL0Mne5jlOjB16fB8
         IGVpaWB51i/GA12h81a1Baci+Hwa3cBvLo4cXOnclYYvxxcscn+wh/kDNOrVESnvHGa/
         2GbGgU196PAwWl74pOIbpXn0Ox7qDRqxAfc6HekzcRF5Tn5IH3EXD7VvFqMp8hp+s9Da
         7tkA==
X-Forwarded-Encrypted: i=1; AFNElJ88oZwZ/sRt6EOuclusy9f5anB9vKFVVriqG2Sh/H2R/2EMn7CChCkOpIynwjQXWkMt1t04H5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWPHvFEzRAHXIqGu8YHyRRwUv+j5BO9Z6ZBw8zU3B/zDnLmbv
	ggkp76/8ztcxe9DrFyABiZiV8EWX+QpjVl7cM0zCzURBEJbzHjmdV5Q=
X-Gm-Gg: AeBDiesW9g3m7B+spVHnTGJ5Ga+szHiAD+gjj2/piLywWsHjbwWwTWMW4FtcbAZPlvM
	XfKztFMrW12vFBn0V5okNokLLpDwpKDDR9eL+miJx6mC54AzpQDcvuFHdmGmoHlKhRUdWRJGDUM
	iUNj7o+HM5OquCuSggrpLJc7Ptr66IOI0VtSPuSbJI5pqY2VINmEt5kVJ6tucZQis350B6O8CTF
	F+Lc2LRF2AD2i4gmwT5KTfOnIX2ZGVV1GFb0NxNFDnk9WM6SMiI3F2xVo5yZAcyeWqEWmYUOWsc
	fMofQiSdR2FRvaiOB0gc78Odm2wxFvE8kyHwJN16U+nizNFQE9fU7ssVSFe/KQdbFxNl/by0kt1
	rL3IrJ/E0cci1jP3y+zTufHMxc8tOdCmsWaZyD34i/FeZrjIHNjtRPEGbFNX4XmfD2l7zo+ECBV
	qh8H4=
X-Received: by 2002:a05:6000:2305:b0:441:3144:efc5 with SMTP id ffacd0b85a97d-4464a1682b5mr16117702f8f.42.1777485374554;
        Wed, 29 Apr 2026 10:56:14 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm6183750f8f.5.2026.04.29.10.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:56:13 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 0/2] netfilter: fix NULL ops race in iptable lazy init
Date: Wed, 29 Apr 2026 17:56:10 +0000
Message-ID: <20260429175613.1459342-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BBE234985FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282455-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Tristan Madani <tristan@talencesecurity.com>

ipt_register_table() and ip6t_register_table() call xt_register_table()
which adds the new table to the per-netns list, making it visible to
other code paths.  Only afterwards do they allocate the per-net copy of
hook ops via kmemdup_array().  This leaves a window where the table is
findable via xt_find_table() but has ops=NULL.

If cleanup_net runs during this window (racing namespace teardown against
lazy table init), ipt_unregister_table_pre_exit() /
ip6t_unregister_table_pre_exit() finds the table and passes the NULL ops
pointer to nf_unregister_net_hooks(), causing a general protection fault.

Fix both ip_tables.c and ip6_tables.c by moving the ops allocation
before xt_register_table(), so the table is never in the list with a
NULL ops pointer.

Tristan Madani (2):
  netfilter: ip_tables: allocate hook ops before making table visible
  netfilter: ip6_tables: allocate hook ops before making table visible

 net/ipv4/netfilter/ip_tables.c  | 31 ++++++++++++++++---------------
 net/ipv6/netfilter/ip6_tables.c | 28 ++++++++++++++++------------
 2 files changed, 32 insertions(+), 27 deletions(-)

-- 
2.47.3

