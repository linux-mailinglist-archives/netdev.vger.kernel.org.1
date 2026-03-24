Return-Path: <netdev+bounces-271246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJRJDUzdwmkqnAQAu9opvQ
	(envelope-from <netdev+bounces-271246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:51:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD431B176
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A32BF302DF4C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24AA40F8C6;
	Tue, 24 Mar 2026 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3bAiTbn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD040B6F0
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378287; cv=none; b=GxGB/FZguD1ngWnjfzzc+ShbYHzccekULsYS6a5AhAuhqEFHVhhuNwybfbt9y6nm9oIFg5LbAUQODEtkf8ejqoJUs1yS3evOYFt4xN55lElnGZKWyOxajP+8spIss7Tqiw64UW63neeyDTzuQHrV8XvhkW3mgwaF6aQ34dJ+Klg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378287; c=relaxed/simple;
	bh=JBmYqYj+ly1oO/Lbkh369Gp9ml6cCcDXXpGPuv/yl8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbidD/DnFt/fVzX1m3CDJUqKcdRNGWrvJFRlsxkJLLWORtO0Y73YV28PDUI0lQcDnc0+LcigDzmYhZAQGlX/mAKWmnJjuPYumAx62RxnF+NMLl+FxBz06b/ZgHoanse9PgiiimdpC0+6GHKS6lyDwoKzYz2USbnh7OOhU4ZIuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3bAiTbn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso38685875e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 11:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774378282; x=1774983082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JBmYqYj+ly1oO/Lbkh369Gp9ml6cCcDXXpGPuv/yl8s=;
        b=g3bAiTbn7Lp2p/Kme0nAWbH1GSV16HVsqyepLkbgGaoFBE7OOfZCUoEfZUcgEAtI6d
         msY22XW8662KOSyt3Sfv/QOWCTQs/D20bQMV61n346RWfg581BZYfYqLkMKLn2PirCCU
         xn896ur3rka2GmZNcCcNNlWyzTxCUOXeloFp9G0i1Z0lGg52yEiX+AE7JFavhnZjn/ES
         9770vxjmCSoHKuIZkfjaXWElRfXp0/TK+y6JW57V9A2jP0vdOHaumIM9gHuokB0EIUdy
         d5vmibaYR3iV6Xov0fwWQOcA5nAAhaFaIEYiUoV2USZdvxs+3xSje/EIrnBPinpnGNeN
         B3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774378282; x=1774983082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBmYqYj+ly1oO/Lbkh369Gp9ml6cCcDXXpGPuv/yl8s=;
        b=jamxUMS+K7iJu7WEhxXRmIaLLHd+CPktk/eQJQ4gIq3+EJcufbuvYkUCUmFSatBMOH
         J8mGG2DC7k9PnRzdIl9iModQS+Obu/jRglLX3GA+1aaLdFJ2JZBibt7xeexzLSQ6ldrM
         niCVYivAv04Mc3Oq8JfTfsa4jC9Q4iqwjB22bj7EEck4UlkbB+7tphL0BaAoidOzyugC
         hQhEZUcjAzvm0mPC/Gm3yEd37vdsDBh26N069cFvujRoHs/CNLoLNfL0oEr8mnKm/aRh
         AU4Iq4dNIT4M660Y1BCmw7m+/d132j66enhUcdaC+aB72Civ/3a56JTM0IyRM9EyzFVW
         zNnw==
X-Forwarded-Encrypted: i=1; AJvYcCV/lYxDBGVLIubbVffWmwIwfnen0heL9WUMx0xCq3GcExO7UQQcYk2Yqg1+kqJErKIdD5iXbiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgoE9Sk7QTQPpQnXJlFGYeF1R4Iz/xLCc4V/+vReKCLAugpQ6J
	59QeB474azspeCbgf3RcL/4xnfjnhsbk5RyI1BQhwRGlZbMFnf5vfmCs
X-Gm-Gg: ATEYQzwOeuL2dDwUgU9hIZqermfXpJE9yPkPp68FfycHI8ZqiAU1Gx7jq8RXcUuDTz2
	mIcJ8aaswVAXMcwFCYxJQFZ0WDsye9ea+rDPRI6OOv0RU+Z73c2iF5l4sW/t6WNWRqrZ65tLiiB
	T7WfzxV09weSC7X6pHAmtRvH1DnXYL5I0Nq7IDDRg11rqHIAMgDaH3Fw/WBGJhfVVPognDhcIw+
	IuCnZT8LbHl3PzPw2jTeOk+5/kQGYWA7LJprbBHcTRMBzSg2toWAQRHBQo6cP1D3IeIxgF/X1lt
	3/dIMPIK/DWfePacNr/kYSeB7FPl8A5RViWw0FkqwT3jcbBDPEz0uHTIYK4L7R6jPS/qVjCChgb
	63VpT275GZxU4RHZoWuJT+ArxCOrhS9fUpvzIZ08slqCnZNMc+0G/6bw5yNxvxivLuj6LFmudQg
	y8U9Ne7kbt7OQnGOwc98g3HNwK/5QaJjo6KHTNxtI=
X-Received: by 2002:a05:600c:3b16:b0:485:45fb:3472 with SMTP id 5b1f17b1804b1-48715fc3a88mr12954475e9.7.1774378282409;
        Tue, 24 Mar 2026 11:51:22 -0700 (PDT)
Received: from localhost.localdomain ([102.164.100.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487165bea11sm6528345e9.1.2026.03.24.11.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:51:21 -0700 (PDT)
From: David Dull <monderasdor@gmail.com>
To: longman@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	linux-sched@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	David Dull <monderasdor@gmail.com>
Subject: Re: [PATCH net] netfilter: nfnetlink_queue: fix entry leak in bridge verdict error path
Date: Tue, 24 Mar 2026 20:51:09 +0200
Message-ID: <20260324185110.1651-1-monderasdor@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	FAKE_REPLY(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271246-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[monderasdor@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDDD431B176
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Hyunwoo,=0D
=0D
I reviewed the change and the reasoning looks correct to me.=0D
=0D
nfqnl_recv_verdict() dequeues the entry using find_dequeue_entry(), which t=
ransfers ownership of the nf_queue_entry to this function. After that point=
 the function becomes responsible for either reinjecting or freeing the ent=
ry.=0D
=0D
In the PF_BRIDGE path the code calls nfqa_parse_bridge() to parse the VLAN =
attributes coming from userspace. If the attribute set is malformed (for ex=
ample NFQA_VLAN present but NFQA_VLAN_TCI missing), nfqa_parse_bridge() ret=
urns an error. Before this patch, the function would return immediately in =
that situation.=0D
=0D
Because the entry had already been dequeued, returning directly means the n=
f_queue_entry object and its associated sk_buff are never released. That al=
so leaves any held references such as net_device and struct net references =
alive. If a userspace program repeatedly sends malformed verdict messages, =
this path could leak queue entries and eventually exhaust kernel memory.=0D
=0D
Your change fixes this by calling nfqnl_reinject(entry, NF_DROP) before ret=
urning. This matches the error handling pattern used elsewhere in the file:=
 once the entry is owned by the verdict handler, it must be reinjected or d=
ropped so the resources are released correctly.=0D
=0D
So the logic now becomes:=0D
=0D
1. dequeue the entry=0D
2. attempt bridge attribute parsing=0D
3. if parsing fails, explicitly drop the packet via nfqnl_reinject()=0D
4. return the error to the caller=0D
=0D
That ensures the queue entry and skb are properly handled even in the malfo=
rmed attribute case.=0D
=0D
The Fixes tag also makes sense since the leak path was introduced when brid=
ge verdict handling started using NFQA_VLAN/NFQA_L2HDR.=0D
=0D
Overall the change is small, consistent with the existing reinjection model=
, and addresses a clear ownership leak in the error path.=0D
=0D
Reviewed by : David Dull=

