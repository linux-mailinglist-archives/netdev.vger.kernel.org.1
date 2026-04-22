Return-Path: <netdev+bounces-280489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GcgD7/36GkgSQIAu9opvQ
	(envelope-from <netdev+bounces-280489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:30:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF26448AD2
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09035315C04F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB6273D8D;
	Wed, 22 Apr 2026 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbP39Br/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C293803F7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874835; cv=none; b=HiTjCZ0Br9BOoS8qA2yk1Db8765ntUSgOUs2jmZS2ntvMEi2qsjSTz6w72LfYHAVjAymzL4AaA2CFEC50ZaLkynIYUj01oL/EVkL2xFjSd+lzy8ry2uSDljZAIYvf4CZbJ29P0H9rdMOF2oALEybJZTmi9jLScgC53lrzDujphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874835; c=relaxed/simple;
	bh=n/S7vPnvJmNtAFJIqx5WllUTObHXM/ewm6P1txHuil4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNgReWcuvalIAGO3uqFunHeIW3KYru7m7EdGRf2khH1NaUujCDahN5X6Rz0jt6+5yvb4Xgqs9WU+w2JULH9i1piH3iCxgGvVLhODdTV+0DPVOpz28QZmjoO+8Tp3xtMhK8puoRW26u4PyX+fpOWo/foylQ42YIodT9kCf1gIW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbP39Br/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso26481345ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776874832; x=1777479632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uDUW6WhwrCJ7taB0c1YRxQrTIsJfdmbhxi5mlzhuoqQ=;
        b=cbP39Br/cDQ8FofZ4leFFhMYLNqjZdM0uykI6a+qswMzaUdObYjY2+l/vvahUki3Vm
         Cn73du18QJgLtaae89lXWkKbMkvSpFtjDv9ImuqO5Qb3IDbnq0Eg8qAJWCfhh7VitZPf
         ZObmJd8LrVICvy0sSbRfKqkT2ulvpNOyKvDUQPWkSQ6OaaLDrXt3z7MfKm68mVGuuRa/
         Jb7hiTGBgIcVYeEWvKlnfeFgrZNj8bO7a/RXA7nUI+UURIKILO5olfSfyeIZHayeIXFA
         VMisY8NETnWojl7ccGMwMIf6jeIC0DtILkQun3DqLjcyONCfJL7TED4vEn+eyxItqAJL
         u7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776874832; x=1777479632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDUW6WhwrCJ7taB0c1YRxQrTIsJfdmbhxi5mlzhuoqQ=;
        b=jxrOSRMjTbYrR9d6dkQ9sQVctOUg1KDdONngrvAAqVj2xfIh0cvHOVDhAck4f1rVpk
         6RXIjFiljbIjDenFYDqmuqioFsHlVDQOIzRQ2DPrJZPtbxnhUgnz6Tqxw2W5dxxEFQqv
         r+hrBcppts4DNnRS1Yq5QTQpawv8ULDd+NP4T3NnY3oblrCPr/gV7VGYrKN1X03OsQmt
         rr6YJG2g4Qmz1BENhV16irZvwvcibhH1ksBm/id4/GBaxCpeuSYXefUZJ3I2UoyYiW1u
         KZHG/Yv+Epd5V7RSjsSB8TtyBtnEbIVo0oztJ8BteVHyrTHGjXF4udcep74W5H5pTew5
         RKdg==
X-Forwarded-Encrypted: i=1; AFNElJ85l80/r3xQ8qIextn7IGQYiGXDq3d0EUgnri98RzFq9WYoz659ila+8YiIm0ueQDxMUhrEEUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAuRw48tLnaR60u1JZk7fkNylmzQ2/yFxBzWz7olKdtHYAAuZ
	emX0FEdRT9vKauYCf4B1x0ibqFjxWrk/Eck+3LDA2DebJaiFzqh6sG6W
X-Gm-Gg: AeBDievA/cDi+V2dCD1A2GWNhWvWBWBBM4Lh8gnrNobbqTlS2QdgaZtPX6daQul1E4e
	s3ohSSjzSqEGIUbDoGuWnOadc0wN2VZxE9QW8ELkrD3AwPM/8s5fQByVOvTjObaPrrUmmFfByQb
	QK9ERLL0w42dcgbuWd1YeWQ6ngxCQrsioa8B0OO4kFq9vjfTmicGYYQd04zRrr+C5nkv6z6dCpB
	bQS2Tin+rBbK0JcoJSjCh471ME7BvGepy5aAaEFa7VxHKKPlFiwoDu/sktLZX6rNFgxsokGX1RR
	Q2U9N1F5HT0x/R+vKUZUncXNSrLeXkA9QOAJHXZX3stUdQjkhK2yKc4Jcao4BD6CA/kUU8lW/IH
	EBI24xVzghJJoo3uXcoxuFXCqHxX6NG3mFP7hyGTSUxsRZhWvYHSBR935Ugtqzjqyi/eZ0gTje0
	Si5OgEH6P6Nbrhm74kcrKLJ1FnAYtcmor8318Yraif8iPaslZ21rO13rgP9s7Hsp71acL1Dv8zq
	dXqgTUdqnyVbQMxTIgQuvA=
X-Received: by 2002:a17:902:e546:b0:2b2:490c:410e with SMTP id d9443c01a7336-2b5f9e5db09mr233759325ad.7.1776874832224;
        Wed, 22 Apr 2026 09:20:32 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cdd1sm170335445ad.38.2026.04.22.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:20:31 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vladimir.oltean@nxp.com,
	shuah@kernel.org,
	xmei5@asu.edu,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v5 0/2] net/sched: taprio: fix NULL pointer dereference in class dump
Date: Thu, 23 Apr 2026 00:19:57 +0800
Message-ID: <20260422161958.2517539-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nxp.com,asu.edu,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-280489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBF26448AD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a NULL pointer dereference in taprio_dump_class() reachable by an
unprivileged local user on kernels with unprivileged user namespaces
enabled and CONFIG_NET_SCH_TAPRIO=y. The bug allows a local DoS via a
crafted sequence of taprio child-qdisc graft, delete, and class dump.

Patch 1/2 is the fix: replace NULL entries in q->qdiscs[] with the
global &noop_qdisc singleton so that control-plane dump paths, as well
as the existing NULL guards in the data-plane enqueue/dequeue paths,
cannot deref a NULL child qdisc.

Patch 2/2 is a tdc regression test that drives the graft + delete +
class-dump sequence on a multi-queue netdevsim device. It panics the
vulnerable kernel and passes on the fixed one.

v5: only call qdisc_put(*old) when *old is non-NULL and not
    &noop_qdisc (Paolo).
v4: https://lore.kernel.org/netdev/20260416185501.647884-3-bestswngs@gmail.com/
    add selftests/tc-testing regression test (patch 2/2) (Jamal).
    add Assisted-by tag.
v3: https://lore.kernel.org/netdev/20260414104311.74115-2-bestswngs@gmail.com/
    fix broken patch
v2: https://lore.kernel.org/netdev/20260410153902.955227-2-bestswngs@gmail.com/
    also update NULL guards in taprio_enqueue() and
    taprio_dequeue_from_txq() to avoid qlen/backlog inflation (Paolo).
v1: https://lore.kernel.org/netdev/20260330102904.2677818-5-bestswngs@gmail.com/

Weiming Shi (2):
  net/sched: taprio: fix NULL pointer dereference in class dump
  selftests/tc-testing: add taprio test for class dump after child
    delete

 net/sched/sch_taprio.c                        | 13 ++++++----
 .../tc-testing/tc-tests/qdiscs/taprio.json    | 26 +++++++++++++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.43.0


