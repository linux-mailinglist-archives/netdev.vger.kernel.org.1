Return-Path: <netdev+bounces-276265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCwVGcbP1WkC+QcAu9opvQ
	(envelope-from <netdev+bounces-276265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:47:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB663B69FD
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80C5B3025735
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 03:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA30EBA21;
	Wed,  8 Apr 2026 03:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6weBStA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6D16132A
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 03:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775620012; cv=none; b=HiMKEOWMTkqjKekD4ijnm8P1QHK0qCBL626SZM9cM8UpkW+ay8XAk5IQMmmJK6OZxu+kEe8C8jV+fwBh92UkSbS9TA0cQs526u3MSF4Ewi8GF8pgZA0Fhurk5IXStdNY10n4d0V77RRc42F3QB9aHki+EglZ96WXkew9X19CtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775620012; c=relaxed/simple;
	bh=AWZaHMp5Y3kDfngrBhyXQ6IWzb5k19vWHsdSsBlE58Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGb0UXGyfrMYn7AKDqNUGXDtExJ52UGYf3t6sA7sEUw4cMRskpTO20VTtechghSbI/ZGGnYxc9jjHZPNlzdFVapiSh3CIwEk+HnBfqs+l4vXIbHhsDxXNxd8l+tBNnnqdDsUVWdaXrOInjmiVupKAt3Yx8vWSJS+mls7/wYcjHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6weBStA; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7982c3b7da9so52500467b3.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 20:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775620009; x=1776224809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao/tDqIOqPv5CEUbM/jNG3rVTQ2lzCd5+HVzODHN//0=;
        b=k6weBStAWwGU7e/4EaKujjAn4zkk7pPs6tVouJG8DhaMr8YeiQnt8463+Z3iaf+t9c
         nvTwmjy0Bl1YeTHRt14XR0/wKvNlAk2FbbACGt3/mJOzQ9HPhLEWxdF395HN7BJVEj1V
         KsT6szKkAhipKp66h0jykg7+bxippSC0PxzbouN8GAFXJXRu1EcfmG+jToKKwsmJgJpV
         sHvHGiGBO9PO3qSK/doxvx/3fYAaXpBzgUu/6oiF7bO+B6TiEV648e75bapWMmKiVEuU
         Yx4/fo+SoipGbvcjLnakEoiUUz8tlPIYoq6/bHFSOZSVmhOLhEyghhdVCDakqOixYRDS
         wNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775620009; x=1776224809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao/tDqIOqPv5CEUbM/jNG3rVTQ2lzCd5+HVzODHN//0=;
        b=n+8m0LLaRJ4EPhGZLbD5jTuhB99xzamfjo1aOnxiV0cDtL+6+WyyTErUdLIpgYEKAZ
         LAkQszhwaKGJovmiJpy3OsPMOx9o2lK9GoxnQfhETccBlOCdzX6dqIsbrmRL8nUe/CKa
         rk8hAufYvbin2l3uuNFAqFcd/AUygIr4P69Jn6m02zIjmC6fP/DHy0faWS+F3A/Ts9o/
         kHA331IAPkqwk4JGHEwzrWgx9ODc4oWP54+UHL0Of3fGXwZt7ICKxjJQFYRYA9qT4SUK
         SrAyirVgF/Xbh65Innbw4knnqYksECDuqr26iUL0tIYq6BOUm3krR4SWhcbpAV67JbjO
         6RAA==
X-Forwarded-Encrypted: i=1; AJvYcCURegNExlMZzCQ4qmPb4YRqw/64yd56x0zxOOuJ1mqiZ0LoljXM+oG7ti79uaNfCnDNHLcp/6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfpI7KNAdKwUDH4rjChRJPWAafKOO6q0B0mRiquGNhRyUJ+LIA
	TdUO6Nx8amI9k7DP5sh5UQdjcPxhv2h7sJCPlVOcQAYXVdakATsJjTge
X-Gm-Gg: AeBDievvhoK0VMTRhfcueIGOF4cbrEpdm/P9Pn0WfsMDH62+q3Wr1sZPNUz08tG7Ccx
	BvOB9zNJsdBL2pIeQdJStceuuflwIDg4gVIJlJ9xr+FicZrLcqO6TFb/aGHtCuxGUoEUdvK/616
	E5aBvab6slKicA9vuHEyWGpnv+4DoLErhW9tyvL9i7bS/tiDUcFVAwap5qOZCG/4xK6BbLGQ1PH
	TKuKNeKrM2fe/vTLWbY1fENBpZ4jh1Ln7n4zOw7eYRFHN9Ouhp/AANDzVL0Q4R/X2eHeM3KxRjb
	EeJtGiCyPTEOs7MWnb3gI6WlL4zSj4sDIGswHKEs6K8BM97AbFVpMbKudBcmT1BnSQv7SnQsBEN
	eiqVCd3yA0ABSYUmZj4rZPG3V0x7Qpfyvs4DC865rQM5G+QO06IHZK57NYXm7wumc4oOtwDiUnn
	mYK5pE4ncdyWIDniMknwPTC2/pfOGnn1L5Ar6HCTSaRk0+C+NL8FQ4bWwbSLhN78ChRK9lhMymE
	ai1/uqs/lSGUbOn3ex7WPyNfpCbhBr8SEIVT3pq9ZHeJSWU3fji0YO/wDpKMCB9T0I=
X-Received: by 2002:a05:690c:e4a9:b0:79f:eed5:ba44 with SMTP id 00721157ae682-7a4d2ff25f4mr153724247b3.2.1775620009216;
        Tue, 07 Apr 2026 20:46:49 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df155csm79129167b3.36.2026.04.07.20.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 20:46:48 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org,
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v4 0/2] bpf: fix short IPv4/IPv6 handling in test_run_skb
Date: Wed,  8 Apr 2026 11:46:21 +0800
Message-ID: <20260408034623.180320-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,syzkaller.appspotmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276265-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBB663B69FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bpf_prog_test_run_skb() may access IPv4/IPv6 network headers based on
skb->protocol even when the provided test input only contains an
Ethernet header.

Fix it by rejecting such short IPv4/IPv6 inputs before accessing the
L3 headers, and add a selftest that exercises the reported
bpf_skb_adjust_room() path on ETH_HLEN-sized IPv4/IPv6 EtherType
inputs.

Changes in v4:
- Split the selftests into a separate patch.
- Rework the selftest to actually execute a BPF program calling
  bpf_skb_adjust_room().
- Reuse a single struct ethhdr eth_hlen and initialize h_proto from
  the test case table.
- Add the Fixes tag to the test_run.c patch.

Link: https://lore.kernel.org/bpf/CABFUUZF_CWQZrRk=L9cNxO=8Z4iSgGfXi3J=hpzeyTKDbfE2-w@mail.gmail.com/T/#mfabfe7e86bb30c0141fbc9f751b8b1cb07767f01

Sun Jian (2):
  bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb
  selftests/bpf: cover short IPv4/IPv6 inputs with adjust_room

 net/bpf/test_run.c                            | 20 ++++++----
 .../selftests/bpf/prog_tests/empty_skb.c      | 40 +++++++++++++++++--
 tools/testing/selftests/bpf/progs/empty_skb.c |  7 ++++
 3 files changed, 56 insertions(+), 11 deletions(-)


base-commit: cbfffcca2bf0622b601b7eaf477aa29035169184
-- 
2.43.0


