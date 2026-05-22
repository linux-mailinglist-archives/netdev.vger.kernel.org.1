Return-Path: <netdev+bounces-290867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBHzOQB2EGoZXgYAu9opvQ
	(envelope-from <netdev+bounces-290867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:28:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF35B6E14
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E0BB302F0DB
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B02BFC7B;
	Fri, 22 May 2026 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELKN+E8I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474D477981
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463529; cv=none; b=DLPLPmJUBaWMrIh4gRbvWxnwlLd1rmWfHpYtyOJMQ9h+Jl5asXL8wB6NaEq66iOPmusDHL9she+4cqKZki2ZWlwoNd+SIUFGzIxFUf/uah8OVxfZD4fa9huUTppKVAnoRJfVimFHD+dekwePyhMuGbwEPnraUpQFO+W0JrWtmRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463529; c=relaxed/simple;
	bh=mgZDZFd/kftyaRkGd7GJZ68U/IMXfGzVEju4yiqnrFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qt9eapPW44V4kWOO6/oiK413ZJoV1fTUCOSjMo9AuHG9Wecf42gdr+OIid98FWZ2JG0xuUAYa/jov0uTkCic9nGtAo5dMpitW8NZV+4JXYwK/9BIX7xQh8bXT4UFQH9ve0RM9D9caUXuwEWTCpLHoUc1ra6MZ8V3hAjLK/3+TxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELKN+E8I; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bcd730e090so59072215ad.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779463526; x=1780068326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sqJX3Syj5JCe19TOR61TPakqaL+M0rzoKj5PhYVwVRQ=;
        b=ELKN+E8IT1Upw8IemoPJqYzg74wqfdT9JZX9CV05vZ2e8/+axzlvAH1slEgFcgJE8T
         5VAuYACwnPZwNcOs6y3/b5L5GQOdhX8wSvQLxIqC7lMSYaFj553Cbdqk8Wa9d4Y5eOjP
         ScUZ31rTDPS/eXcEDVZesCpQgwFzQFcxE6aszAWeFQnSAe+qfSfEq2wmu4kmauyDceMQ
         6n/tAEutyHMWKWUaiknFZW31FPyqjj9vuKO5j8Z+Z4uPGsxI7yRAl27HOJCDjEvHBAHc
         Gr7DilvPB+rqq5zc8eoCflSNUyzEUrTfPV2pj3e5JYwwbA9pQ+IN3olKT5Co71B5g9zx
         MjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463526; x=1780068326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqJX3Syj5JCe19TOR61TPakqaL+M0rzoKj5PhYVwVRQ=;
        b=LAhcmwjqIjcCPpecPp//KsbBjLydu5VPn7hwN2JoXifyTYgka7h/rOmqsTbIVJnuW/
         D/Z0dZ3mq4Y7hZJnNH1NdSX0SbJ4gW4SlpDraon445iHHIrL0jbW8bQMoyf1n2QhrPql
         sy6hF1vd0mQhae6ow+giba5wxZVkr6PGl5fW/cbUVmzl4MllVayq0mqsF128zINMqmIJ
         4KfZ7YIFn469JY2rcTaOB6Z9RFsubQOxaNRLeEi1xQvQnmEK9yn3f8F6bktkBgsi4Ulo
         nokgD2BU1KmLApompPISKOanfG0yqRtvqxdY13LaYz9qem6cFcIwKgpB2XecS+i1s2th
         3Wzg==
X-Forwarded-Encrypted: i=1; AFNElJ/Z9yy1e2SNYYW6c+Cvpz4hzrLqrT3DwD2AjbNmhcH//BqrIHOE4Vsn2w91wnoNPItsf8+NacM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVttFtvX541np/MRtkU7nYz4W7DitJK3uSMK0a8l01R8YQMf5
	JCs1y83WH6xr0jY5P+nCUxCqENjPhQnCAxZlWnqa0csAVkpeegNzrM6K
X-Gm-Gg: Acq92OGmkPKvDRUg61k3JUHUDPKGWCB5jxrgf8JZTtHusu1mHTO1FOEMsop6BneJvVn
	03zotrCZUF/7nEu7d/EkccQipJSplRws87kVPCrWxsSRnRNny/cjbZLiLosed0tmAaA045o01/x
	BjGEeyg3hIeVPxLfeluSR3SzdF1pRL0RrE+oYKIA8VadVQDZGKiuJjNc/OsWvWAB9I6AmGsHbmG
	tYAA/zeBR4UPJdRSUcCQrs4hLUlqc6IiktWgR53NpAwKIAj18Taylq6MtTDwz1YJHg6YORyuAEH
	pkz/G3f3T4k+xIdPcAYBKCHbVXi+6fFRvdofqlhAtD8uZikATEg8Bdxg+pQKg8jTa88BwHb/+Bm
	tSAf7LnPXp6l4W2nL7uoxsDwhO4zzIP2q9oDT1c+8qbSWJ+kXOG+Q4o8JW2cuw8t3FL+6mnme4g
	A8ksK0c6wHS74XWONnvmTYwFOH48tNd9RR8aibLXu9r6M/ihsx
X-Received: by 2002:a17:903:1cd:b0:2b0:6f21:8289 with SMTP id d9443c01a7336-2beb067c5a6mr45393675ad.25.1779463526190;
        Fri, 22 May 2026 08:25:26 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58e4fcfsm20603405ad.71.2026.05.22.08.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 08:25:25 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: List iterator used after loop in sja1105_insert_gate_entry?
Date: Fri, 22 May 2026 23:25:22 +0800
Message-Id: <20260522152522.112510-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290867-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,maoyixie.com:url,usenix.org:url]
X-Rspamd-Queue-Id: 6FFF35B6E14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

I came across what looks like an iterator used after the loop
ends in drivers/net/dsa/sja1105/sja1105_vl.c (linux-7.1-rc1),
in sja1105_insert_gate_entry(). I would appreciate your input
on whether this is worth fixing or whether I am misreading the
pattern.

  list_for_each_entry(p, &gating_cfg->entries, list) {
      if (p->interval == e->interval) {
          NL_SET_ERR_MSG_MOD(extack, "Gate conflict");
          rc = -EBUSY;
          goto err;
      }
      if (e->interval < p->interval)
          break;
  }
  list_add(&e->list, p->list.prev);

When the loop walks the whole list without break (the new
interval is larger than every existing one), `p` walks past the
end of the list and `p->list` aliases the list head via
container_of() offset cancellation. `p->list.prev` then resolves
to head->prev, which is the real tail entry's list, and the
list_add() inserts the new entry at the tail. That is the
intended behaviour for the case where the loop falls through.
The dereference of the iterator after the loop ends is the part
I am unsure about. Same shape as the Koschel cleanups from 2022
(99d8ae4ec8a tracing, 2966a9918df clockevents, dc1acd5c946 dlm,
and others) and the "controlled container confusion" pattern
described in [1].

I drafted a candidate fix that initialises an explicit
`insert_after` pointer to gating_cfg->entries.prev (the list
tail) and overwrites it to p->list.prev only on early break,
then passes insert_after to list_add(). The iterator is no
longer dereferenced after the loop and the diff is 5+/2-.

I built sja1105_vl.o on x86_64 with NET_DSA_SJA1105 +
NET_DSA_SJA1105_TAS + NET_DSA_SJA1105_VL at W=1 and the object
compiles clean with no warnings. I also ran a small userspace
mock of the two versions across seven scenarios: single entry
above and below the new interval, single entry conflict,
multi-entry insert at head, middle, and tail (fall through),
and a multi-entry mid-list conflict. The final list ordering
and the return code match in every case.

Does this look like something worth a [PATCH]? Happy to send
one if so, or to drop it if the shape here is fine.

Thanks,
Maoyi
https://maoyixie.com/

[1] Jakob Koschel et al., "UNCONTAINED: Uncovering Container
    Confusion in the Linux Kernel", USENIX Security 2023.
    https://www.usenix.org/conference/usenixsecurity23/presentation/koschel

