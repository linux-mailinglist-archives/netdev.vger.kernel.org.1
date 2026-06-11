Return-Path: <netdev+bounces-297991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UUVjDHBtKmrKpAMAu9opvQ
	(envelope-from <netdev+bounces-297991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:10:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6654866FBA0
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:10:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ByieKP5v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297991-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297991-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 923F2300A13F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA29B3644BC;
	Thu, 11 Jun 2026 08:09:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777641C84D7
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:09:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165347; cv=none; b=sN033YyPDHgEGye9SO17A+BdlnHRbRMS9ERRMHZLG9rXfI3vbv955EZrWARVUHaKn76cgZob+Zkl7Btp0yI4brsdihxDHIR8s/yu1o+suHUvfYW1Klls2eZV0Yh8tFyB2la+hpBcYLcRZHMhRemc7578jZSqszgPybF1W9blSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165347; c=relaxed/simple;
	bh=43aTg0uqeeQ1d2jMcSX4cwzeXgZpgGmCmaoUiCwIYpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bk6Y5ivodk0kNautdjrmZH3iMyvTPewrTlQmt8ZWnIyoXgJFgRcOl40PK2Fo0wx5hcKPdEFaHruPtk0CrJ/ttK0gApuDrmxazxNMqL1dPNo/BqeXuEow3HwwCKyiTNnvX+QKukTg7ZmWoDZipu3jYR96xvuldS5mg3yZiZipKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByieKP5v; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso4654207a91.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781165346; x=1781770146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez/7YuAJr4Y+RG8kQa8JolzS7h4/ienZb2p4vynCkX0=;
        b=ByieKP5vYX53ZzYn26b8aIuF4w2nt9RdK9oz9i3Pjkcaq6FstjjKqymiWu6abi8/6u
         yN7DVZyQfN04v+PutYDUoEDYakHbmHuVkCabjR0m/gvxbWIDRkROG+xzpqoRMEn4g/EI
         p82Mgd14OMGuthhDvxrz1nPM2XHdkgXE0XYHiXzbvbBS/Lk8WE2P0p1fqiGM6V/sLzft
         Oi1I8NgKVN2ZRPf2JGbRLyANRUy8AssFq6CHQep3eLk/dVAzc/q6hXmfhyslMU+/oLKv
         9lvZJOdYtdtz1nFH/MTmokqrSuAYxUjSSjx0HrW9WwrIhJCMuR/n5u9cCMivJjsPrHBH
         l9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781165346; x=1781770146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ez/7YuAJr4Y+RG8kQa8JolzS7h4/ienZb2p4vynCkX0=;
        b=J987PReyakMqP4tboTXlfj5fqrh4suyiUh/WKuZMKODP7B+CjgF0P1KLtKSzpVtAd6
         VuEylxHM/5TZKU8JUSqx+1V+zsU0VZa/tkwtCaFFenkUZKQNA3oWKJRkd1ODx7gxpkwE
         7zD2DPQCYPveF/sXN90XoLCTj+zK9CR25zw5oUL7LmwT3ktY3UXidM4JxoK8UpnuJ0RC
         o8Tq0gsH54ldYK01mUX1CTcZlgVyGJTaHNr8f9Sc5I7eGaYlzgAzR3lCOmMKRUgPRwss
         ayNK+MXp83QpdGJo6XM3+h0aWBSZx6lNnMVe3tDUT4+88mMEzBOSyWhZNP/bsRlWhOZj
         KibA==
X-Gm-Message-State: AOJu0YzhL4P6KM4RaA4Y2S9WNvuNNYyN4T+FXooVx/p3D9iDtBo6rGZb
	2rAMxn9b/qhGHXa6yOtplb2/ErMi2MlPyoCzMkWeWN/JhXnlp/BYZGDh
X-Gm-Gg: Acq92OFN0deNUFYHJrHzg/QnHNTOyj4KONxsfZTJ+tIemP+Ez4SigP0Lkmuv72DlNf3
	kJv7+vUFxlAMmoIypq/XLOqI12JVXWXmuXy6B9X3ih8oPNnNZl6+LeEnTFXjAfuTvSaP57OXh9A
	nfrfZHE74Mb4BqZtgls5k3rQtukj63UdKpiw39yWzBJOeGo/BFDLHiqnnEa44gkQpY9V7unTx5Z
	8IXw7UoeXm4JWKh64Mr89YAaP6BXJDePB6STrkRMOAmCfr5FtIzra5db1UklU1nLUXFWAtq8maL
	C7oPb/iO+XGJrzOVwR+tMoO0foCWQXSX7zt9EoGYGDMrjahlgB7my3Iz1/kkzYplhPXFSEQw78F
	QKiU2+VJBUStH1eZQ1DnFIfV43S68OcI4cSxBzrjOARv7pj8VrIm81IenaZF+nNNeMpOrp+v1T7
	H3YoNQmWW9FCk4kZbSsiiqN0bTXumvMD6cI+D1Cj6jsi/aXTvokxr3osZKk83NgGkoRqJ/bnVlF
	exafK9WmditJ5w8QP/NgMycMGTWBodPjCCPJnE=
X-Received: by 2002:a17:903:f8c:b0:2c1:a19:8396 with SMTP id d9443c01a7336-2c2f2a780bamr19562055ad.31.1781165345756;
        Thu, 11 Jun 2026 01:09:05 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([2a12:a304:100::109f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad138sm277591035ad.82.2026.06.11.01.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:09:05 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	toke@redhat.com,
	menglong.dong@linux.dev,
	emil@etsalapatis.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v4 0/2] bpf: Fix generic devmap egress skb sharing
Date: Thu, 11 Jun 2026 16:08:47 +0800
Message-ID: <20260611080850.536996-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297991-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:toke@redhat.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:sun.jian.kdev@gmail.com,m:johnfastabend@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me,redhat.com,etsalapatis.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6654866FBA0

Generic XDP devmap multi redirect can leave cloned skbs sharing packet
data. When a devmap egress program mutates packet data, another
destination sharing the same data may observe that mutation.

Fix this by making cloned skbs private before running the generic devmap
egress program. Add selftest coverage for the last-destination case,
where the final destination runs on the original skb while earlier
destinations use cloned skbs.

---

v4:

* Preserve mac_len after skb_copy().
* Separate errno return from XDP action output in
  dev_map_bpf_prog_run_skb().
* Zero-initialize net_config in the new selftest.

v3: https://lore.kernel.org/bpf/20260611043317.512843-1-sun.jian.kdev@gmail.com/T/#m77fde65437b0398cb470649d4f1feeb85bc134bc

* Split the kernel fix and selftest into separate patches.
* Move the private-copy logic into dev_map_bpf_prog_run_skb().
* Use deterministic DEVMAP_HASH keys in the last-destination selftest.
* Fix the Fixes tag.

v2: https://lore.kernel.org/bpf/08c35c70-a59e-4e0e-91db-22b5ec30b611@linux.dev/T/#m613671b243e8651c47f84bb329f0ea668974c549

* Move the private-copy step into dev_map_generic_redirect() so the
  last-destination path is covered as well.
* Use skb_copy() instead of skb_unshare() to keep caller ownership
  unchanged on allocation failure.
* Add a generic XDP last-destination selftest case.

v1: https://lore.kernel.org/bpf/CABFUUZFimdrZdq=NWi+N-0sJZWvMwY=f4iF6-3TVMS8=m07Zmw@mail.gmail.com/


Sun Jian (2):
  bpf: Run generic devmap egress prog on private skb
  selftests/bpf: Cover generic devmap egress last-dst rewrite

 kernel/bpf/devmap.c                           |  41 +++--
 .../selftests/bpf/prog_tests/test_xdp_veth.c  | 152 +++++++++++++++++-
 2 files changed, 180 insertions(+), 13 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.43.0


