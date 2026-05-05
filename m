Return-Path: <netdev+bounces-284239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKvlHhWb+WkS+QIAu9opvQ
	(envelope-from <netdev+bounces-284239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:24:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB8C4C7D5D
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D87530580B8
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 07:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92D93D6CAA;
	Tue,  5 May 2026 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/V46l9W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A30A2DCC1C
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965623; cv=none; b=DStCFjwZj+8Yhl/bCWXqpgpfRyG4+Xi9Nms0IXG52vfRVrjRqjTsKPmqPzAUFWPK2Ur6yjHTbdYGdPyodvd6mqCLL8qx3DuaKp5ySv+m8AfspvN51BDU6YnqmfWt3U5j85DJr5IbxrWxpfRss5QHvPSixZppmcqP0yGj6sZ2p2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965623; c=relaxed/simple;
	bh=z4+eW0mQ+yC1v90F/v5PDtz5WkVGIG6MzvBABs37gNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u0/8RtRgg/ahIolv6IzSDvtSLwNXyV7YJzW3c52ibf1DIH0r/TjaUw0ymJWdCDpsPiQwwRLb1nmZb9DgtxBNz/0skagH9rwYRDR+HPOXgkRjEXWdEyvolKn7D4DcwClgmglCDNI34Va1jTeZSjQPwBWNnAuuRITS2HBHSttc9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/V46l9W; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-836ebdeb969so799459b3a.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965621; x=1778570421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuFfjsO/bZxdiI4c964U/c9Cqd75USB3mn6RrlPw2fs=;
        b=j/V46l9W7k/IOzQjVQ513dBy1xrsLiVVUCuJeL+i69jtHindnOUTKcz3O2Kd2Mfbg1
         Pb74DwVlKDFB3PycMJjCiX1S5Iwnd8qeRvojlVZ8KqK3z0wHy6vUWvjzqwWe3Byw3B1i
         RvNSffLHkPymOFZKp1/cjoBKJyHr2FVTSyoH31pb8DnoM2mqqazQzs7ypgduZwxRCB/5
         K7jKlh7qz9RnKp65UQEQuY9GFtjcD6RnUBnUXbPQmqfR0NP4F26kB4elA0B2yORj0FAr
         oY44BZJcKlPjAwdY5dyn4y6uuNxAhE12KT5dG9kwkAsfYPOJVQT9GTQUEixcKBCzJpRX
         SY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965621; x=1778570421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuFfjsO/bZxdiI4c964U/c9Cqd75USB3mn6RrlPw2fs=;
        b=QQZF+Su9gTSXDZPMJni0AbwlwatoVD6RPrOk7UU40k0zYVXUII2o+D7pRyEzvCRjnL
         Qs16ggzH544O5pO1j+l76qZNcSkbZ0JFFfPYvPPRbZkwb/FsTFz4tIZJzZ3wUyZfZ/Ti
         ZHbEh1z8mPixI08srirtFcZPLouHEzkDfSnyHiVEOCb0fQihfTYjK2YYVpbnXVYeCruK
         25LGDdYgef0+g7NbTpJe7OksLwKOKlenx1aymrlPkl5YoFmfvhZor6QQ/TUHlgOoijPO
         OQZclbR3vefH3ts3nO+U05VqlWvMSAn5TzXnP7rInVuUoaccgrsjGZZPG8/XX+AVpjY6
         uEKg==
X-Forwarded-Encrypted: i=1; AFNElJ/ihd5TsSEjKRZ+LxMKGBXNuLt/bWOY0OjyyZs/XJoUid39V5TyWhSGb+4OImD28Zwv4aQ/GQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4+bT/0polQ2i7Omae3AzKQh5L34BobUq8DT37EZb6oh/SHgFz
	JAWoJJ3A4Dy72xF/QGoLX+2IwU7GOTD5ZO+eQGm3HQ8UrWKow1b0RW9l
X-Gm-Gg: AeBDievaZcTOQ5rYYh6FoeFlVluWXRHS2kD2ax1L2j6g57P/oFP8bHmCBJd6UOe9Qsz
	S0em1TURr2u9BC+3R7yz3meQa9CLgwRSuTVdO+GDf3ELq8Y1+OE7TvG9KtNBJiDkRka8ihzoG/g
	GR2rJiAmVUo1RLAKhO3wgjMbDvTeEiVRUyPzu7O5YglKHhxVseisXyKvlMJPUgXbPA8G+Hiit5H
	XCBTUboH41duQdKY7y3076uYbnEtP7aulByrOHjxnT3qmT/zU0KcK7siQwVQWvxpzXTD63zy/ND
	Yk3ZhWkjJqbKYUwG9mjDKAJHwoyPdIV6ovxfEeNl84PpxwjIDhe4jLv+mrxVsLXfYgxPiDXKTHT
	1yffbZSQ3RvvFI23uSV4Ct8DpwHbh2PiTp5fl6zLPM7Wb7eITLFZ01r2PbIegLH1fPd3Dk3EMMU
	pIMmP4VQG9fizuhtvSS6bWMv4JzcbruekQug+wpMQDfJWvuKgXoK24YGs3RFI=
X-Received: by 2002:a05:6a00:188e:b0:838:127d:a168 with SMTP id d2e1a72fcca58-838127da456mr5959734b3a.17.1777965620677;
        Tue, 05 May 2026 00:20:20 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a4bffsm1036227b3a.56.2026.05.05.00.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:20:20 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Willem de Bruijn <willemb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v7 0/2] ipv6: flowlabel: per-netns budget for unprivileged callers
Date: Tue,  5 May 2026 15:20:13 +0800
Message-Id: <20260505072015.1672730-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1DB8C4C7D5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284239-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,ms2.inr.ac.ru,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:mid]

This series fixes the cross-tenant DoS in net/ipv6/ip6_flowlabel.c.
v1 through v6 were single-patch postings, each in its own thread.
v6 review pointed out that the existing fl_size read in
mem_check() and the corresponding write in fl_intern() are not in
the same critical section. v7 splits the work into 2 patches.

Patch 1/2 is a prerequisite. It moves spin_lock_bh(&ip6_fl_lock)
and the matching unlock from fl_intern() into its only caller
ipv6_flowlabel_get(), so the mem_check() call runs under the same
critical section as the fl_intern() insert. With all writers and
the read of fl_size under the lock, fl_size is converted from
atomic_t to plain int. This is independent of the per-netns
budget. It also makes 2/2 backportable without conflicts.

Patch 2/2 is the v6 patch, rebased on 1/2.

  - flowlabel_count is plain int rather than atomic_t, since the
    previous patch put all writers and readers under ip6_fl_lock.
  - In ip6_fl_gc(), fl_free() is now placed below the fl_size
    and flowlabel_count decrements, removing the v6 cache of
    fl->fl_net.
  - In ip6_fl_purge(), fl_free() stays in its original position.
    The function argument net is used for flowlabel_count.
  - mem_check() uses spaces around the / operator on all four
    expressions, addressing the checkpatch note in v6 review.

Numeric budget (preserved from v6):

  pre-patch:
    global non-CAP_NET_ADMIN budget = FL_MAX_SIZE - FL_MAX_SIZE/4
                                    = 4096 - 1024 = 3072
    per-actor reach                 = 3072

  post-patch:
    FL_MAX_SIZE doubled to 8192
    global non-CAP_NET_ADMIN budget = 8192 - 2048 = 6144
    per-netns ceiling               = 6144 / 2 = 3072
    per-actor reach                 = 3072 (preserved)

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

Reproducer (KASAN VM, 4 cores, qemu): unprivileged netns A holds
3072 flowlabels via 100 procs. Fresh unprivileged netns B then
allocates 32 flowlabels (the FL_MAX_PER_SOCK ceiling for one
socket), the same as a clean baseline. Without the per-netns
ceiling, netns A could push fl_size past FL_MAX_SIZE - FL_MAX_SIZE
/ 4 and netns B would see allocations denied.

v7:
  - 2-patch series: 1/2 (lock prep) and 2/2 (v6 rebased on 1/2).
  - 2/2: flowlabel_count int, fl_free() reorder removed in
    ip6_fl_purge(), checkpatch / spacing in mem_check() fixed.
v6: rebased onto current net (resolves the conflict on
    include/net/netns/ipv6.h that v5 hit). fl_free() restored
    to its pre-series position, with fl->fl_net cached locally
    in ip6_fl_gc().
v5: replaced the per-netns ceiling FL_MAX_SIZE/8 with the
    computed unpriv_user_limit = (FL_MAX_SIZE - FL_MAX_SIZE/4)/2,
    which evaluates to 3072.
v4: addressed Willem's v3 review on netdev. Dropped the
    flowlabel_has_excl cacheline argument in favour of "fills
    the existing 4-byte hole after ipmr_seq".
v3: addressed Willem's review on the private security@ thread.
    Merged FL_MAX_SIZE doubling, dropped test data, moved
    flowlabel_count near ipmr_seq, inlined fl->fl_net in
    ip6_fl_gc().
v2: per-netns counter + cap, sent to security@ as a 2-patch
    series.
v1: fix-shape sketch in original disclosure.

Maoyi Xie (2):
  ipv6: flowlabel: take ip6_fl_lock across mem_check and fl_intern
  ipv6: flowlabel: enforce per-netns limit for unprivileged callers

 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 45 ++++++++++++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 15 deletions(-)


base-commit: ebb639024ebd47a13a511cce6ae630c15e4b3126
-- 
2.34.1


