Return-Path: <netdev+bounces-281521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB72EITm72lPHgEAu9opvQ
	(envelope-from <netdev+bounces-281521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:43:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C69D47B931
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E1383004CB7
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E613A1A3C;
	Mon, 27 Apr 2026 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MflZwKi/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B523221FBB
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329789; cv=none; b=MSkzthp/7GKongDOhbfp4dMUZ3ICxaNtfjOiQJQ6LNRJ4QifKkr0T3ZCXcAj+HxTUETLshc07rMSGysUam9tz+5czblQ0Di8OTWWIMgW8ba4uEJXb41jo0QUPu9ISN9F09id/dZ90W39MB1aiyumZVpMlERtNagyPZSp2pFQHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329789; c=relaxed/simple;
	bh=PbcoGJ83hfaOZ6laTOR0uL8GbaAzSabp+C4TwUKxS8w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fdDRP2hhIVTdN/z54M6TOg6YBduwlCr1pfGvKHIm0D1/E531NA/WyLdH2Hf3Qxigyg6620raHXeiSoitcs1SMyUNkBd9Tt7+Tr+9/a19YTes14N4ZSdPw0g5Jii09ZpOXkdNYcyDInUB4WHrmMuoohCzHN5GLsKPP6hqTv5WUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sharmasagarika.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MflZwKi/; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sharmasagarika.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-6583252c117so3835637d50.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 15:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777329787; x=1777934587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SpSbFarD004TIRxjjXURunEN1itNuJvj7VUYTMGDc0I=;
        b=MflZwKi/qGbCvI/KBaDsMCCcKSso2/gl8ZtaIbsC8RQx+z3ORi/YzQNU2Uh0PeQ7l7
         DBU37m7mbTO6+ec2+9hP56Old69tc5NsJWm44MzcKdz5Ir38xoEUXSYuqfW/a1POuBJz
         K3OCKMPFpMpfzX3hYEK2OAXaAzksN+HzXfCecAB2snxd2nQELL9H1vQztHdkYaULGMwa
         SidSNClx7mkfE6XHHB9MiuRn8x+9MOEB1iSFEZ/Q3Wdkh/vmaPQZ2giGHoIXM/KMDasy
         WrR8nQXGLWq9PupYdKWVX7Z+TEgl8D2ev4r6PovJ+PCaUyXakVdJKVo6a/OcXCEtFfQo
         xrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777329787; x=1777934587;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpSbFarD004TIRxjjXURunEN1itNuJvj7VUYTMGDc0I=;
        b=p11+hKqAx7igp/jtT36O25h9Q/VEfY8pDhmGZ7v5s+tqdaoh0vkqamLC9033mpB7Qq
         /TxNH7Sx+Z8Up3Lj7gMmdpev5O4RS2iz3rA7tGYaPsz3F53w5Hc50W+RVlDwyrH+ecWT
         EpJrWmJ/h3+8GJeGGOwPpuJhgr34l4rWms1PeW3g6dmnJ7YLKkea46kYRppRlVsEBiwh
         AGUm+WH6qwfEE+Bb/BbBzbNS10DGpVh08N8tehRTclz3gT4WuxpkooUwcSAcd4GpgW1J
         Ec7neSx9ORi9htNq1FjwgwJ8EDlYpw/QdiQjC1/ICIrEGz8CkA5KShjw3G6UhKEgiVlj
         XgrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ZJZbx9mn6LeI7/VaDoAwcQOLkzA7QeSYDMYVDRrBXaAB6UTmLvxPLw5Pj3IpTK9h5uB2sUzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCVAuV/lmlnyFBC39XjvJSOaDLnTGHNHQulRDoOplKvwqLIUA
	3OJyTyrUoWH6f9LanMNhxI23Ul/brzdUFZZ2al26QeDz3VRQ+JVXQ2tzIIJsfF7UUpxvmMI6OI4
	65KHPxl2FpYadRfrirsZfdSrv1H6ReZ+k/HIvxQ==
X-Received: from yxaa9.prod.google.com ([2002:a05:690e:23c9:b0:654:1934:377f])
 (user=sharmasagarika job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:130d:b0:657:a0f4:ac1d with SMTP id 956f58d0204a3-65beed1d82bmr470283d50.12.1777329787001;
 Mon, 27 Apr 2026 15:43:07 -0700 (PDT)
Date: Mon, 27 Apr 2026 22:42:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427224243.3499162-1-sharmasagarika@google.com>
Subject: [PATCH net v1 0/2] ipv6: fix ECMP route failover on carrier loss
From: Sagarika Sharma <sharmasagarika@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sagarika Sharma <sharmasagarika@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3C69D47B931
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281521-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sharmasagarika@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This patchset resolves an issue where established IPv6 connections are
unable to transition to alternative ECMP nexthops upon carrier loss.

Unlike IPv4, the IPv6 routing subsystem does not actively invalidate
cached destinations during a NETDEV_CHANGE event. Sockets persist
with dead routes, leading to stalled traffic or connection drops.

This series introduces a fix to trigger route invalidation by
updating the route serial number on link carrier loss and provides
a corresponding selftest to validate the failover behavior for IPv4
and IPv6.

Kuniyuki Iwashima (1):
  selftest: net: Add test for TCP flow failover with ECMP routes.

Sagarika Sharma (1):
  ipv6: update route serial number on NETDEV_CHANGE

 net/ipv6/route.c                              |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/tcp_ecmp_failover.sh        | 209 ++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100755 tools/testing/selftests/net/tcp_ecmp_failover.sh

-- 
2.54.0.545.g6539524ca2-goog


