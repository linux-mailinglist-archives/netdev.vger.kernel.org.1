Return-Path: <netdev+bounces-206697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FB7B041E8
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE974A21DF
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA025C70C;
	Mon, 14 Jul 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="IX13G8BJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E55625A2D1;
	Mon, 14 Jul 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503839; cv=none; b=aQAOfIpz+KtP1uQS7WEsIQLUQ3DAD6Wi1joeyDghBJyEj5tqznPMIQKAI3FJruYUG/eMRGO1oHpAZTI4FUtapfgBbQk6zsXuR/zxHsKvrhnfzg21OKcPwRjlT7pt7whhNIevRMVyYJh2OX4P1HN4lhvNAA/eYycq99JXDs1hpvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503839; c=relaxed/simple;
	bh=ON5W1OOwsqtjKlSAI23AxoIarfROCOeFz96KIcbGA8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpwdIADHZEJu2ohQAtHwaUiPB/+IDgId/wFonNJZ1iNHCFGR8O9tMh1NBzvduCXRGtd8QGw9g4HntnD4YT9foSbMCDiHh4TgttYn732vr7/LT1MKWv9IQI3X6Le3fyH9wGBE0LGmrXkV1TQ6AZnUQWC0IceP8Nyywj9IzyEdGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=IX13G8BJ; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1752503828; x=1753108628; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=NTis1DRQ6YWvIefOVgBik3VycLjAWOLQXvC3R0BRRP4=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Transfer-Encoding;
   b=IX13G8BJ/CadbLQZSJoUtz8zeSdaXtwa67CZ0BspEDyNiJgMfnCmEqpRh4BA+Oo21JQRRdWHq0ENp8Sj+/si3wOktTM/+4pnrcIDnbeEG7Z5LiGJBKlG6wfBmLcUJRHHwAGEYDyt+yUclb7GU1RhxYTQDTuD4hIMB1Mm7CJPEwk=
Received: from osgiliath.superhosting.cz ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507141637061503;
        Mon, 14 Jul 2025 16:37:06 +0200
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2 net-next 0/2] account for TCP memory pressure signaled by cgroup
Date: Mon, 14 Jul 2025 16:36:11 +0200
Message-ID: <20250714143613.42184-1-daniel.sedlak@cdn77.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A006396.68751624.0053,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

Greetings kernel wizards,

To summarize from the commit messages, the attached patches are the
result of our recent debugging sessions, where we were hunting sudden
TCP network throughput drops, where the throughput dropped from tens of
Gbps to a few Mbps for an undeterministic amount of time.

The first patch adds a new counter for netstat, so users can notice that
the sockets are marked as under pressure. The second patch adds a new
tracepoint so it is easier to pinpoint which exact cgroup is having
difficulties.

Individual commit messages should contain more detailed reasoning.

Thanks!
Daniel

Changes:

v1 -> v2:
Add tracepoint
Link: https://lore.kernel.org/netdev/20250707105205.222558-1-daniel.sedlak@cdn77.com/

Daniel Sedlak (1):
  tcp: account for memory pressure signaled by cgroup

Matyas Hurtik (1):
  mm/vmpressure: add tracepoint for socket pressure detection

 .../networking/net_cachelines/snmp.rst        |  1 +
 include/net/tcp.h                             | 14 ++++++-----
 include/trace/events/memcg.h                  | 25 +++++++++++++++++++
 include/uapi/linux/snmp.h                     |  1 +
 mm/vmpressure.c                               |  3 +++
 net/ipv4/proc.c                               |  1 +
 6 files changed, 39 insertions(+), 6 deletions(-)

cc: linux-trace-kernel@vger.kernel.org
cc: linux-doc@vger.kernel.org
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Masami Hiramatsu <mhiramat@kernel.org>
cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
-- 
2.39.5


