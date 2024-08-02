Return-Path: <netdev+bounces-115249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77D194599D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0071C22807
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5D1C3F39;
	Fri,  2 Aug 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ZdHzez0o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1531C3787
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586089; cv=none; b=LWqxC8IRWwC2upTU+OAVXSQuyGKVZ0ta3Tgv9caxmVAjnItd/dq4Q6LEtd/cvvkoEQ7y9GAbEGroppTd5ysNq9xsyeOVOHT+TURlonenXl6U2ZkJx0TDZCxkKpFM2IhxrTmhaFGzGQcMUu0lDWiuYtH43rgsX70j1rKfFzb7H+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586089; c=relaxed/simple;
	bh=gHVyyvEhrZejUDUsXHFskf1BDflUwJv1wmiTyCoQDrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apNSgp/pQGxVCe1y3tyfo/N3Sx7z9tcG1pK3P5l5J7fATVwNlHO8+e7UVo8xTNVo4EV/jSuQxVDZzMWuVGhZLXLzdsjCxXBEJTOGEH1JOLszz+zsHos/f3xUm6S1mJ35lCWc49B1YgLw0jOxhFjY0exU7fIZsuAVy3PRsGoruMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ZdHzez0o; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so12211856a12.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 01:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1722586085; x=1723190885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ5i7ZZsbb8/qv+GVwtLQNKmkvQ+k/9eNI6fKizaQ6g=;
        b=ZdHzez0oHHB1sYYkkw/Cf5yiaKykMxfHa7oF4Zfu5CTFV6/4WGWog+Cr+O4CbqQd+k
         hB45QEu5Gj91saDKFe0euijyM26+dckPwPW+epaxulQwgaHneuG6PFPOkiI8irLjaESy
         jyOojgZVDV5HQ1L/i0i1Pb9/VYsHul7aF1g+XHjIA8cxY1lgYhlZCURzEAMdPFGbvehl
         i9goPOfVxiq1GqjMfn5iHprJ0I85+mbGU2gY5u0GPIL8gzBkqkOBIVN73wLxOiBS/MaB
         SzLa+Yj83eIKtNWi3F8zdNeRnyy3bWe2iZD7GlV0vax9OMLbtdAjlAFuHoiu55z1FAzb
         z23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722586085; x=1723190885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJ5i7ZZsbb8/qv+GVwtLQNKmkvQ+k/9eNI6fKizaQ6g=;
        b=OtPiCtIp0OJvHn7JF30iDJSt1maNZLwzID/vR7w1UP5DfjgT7gawBVvXS6L+nZeNU2
         GTUtscmvJAXvPO18AmgAe/C8gk1dM//eN2klzO59bs8DnqqBGoeysBUdgJX7QSKstypT
         Ks0uMSOGWaGx9Z8pZy+ruAygs9QD8/rCLOyFCElfSPugSZ88+c+tbtUjY2cTTh0LCwZ5
         LRvu3d2Rw3s1ww3YEhzTsAzWf6pq1g1KqMkaW6PcmHv4knUy7wlbOUCd1wE94nX2Jadv
         qknQePslhiuBiG3TQnLCfAnR2sE5tdyo6qOrilT9vKk9p3SQ8LAHMUssJ61+ahXKGBWk
         pmcA==
X-Gm-Message-State: AOJu0YzfrJx2/tI27Vb4C9cm7Ep2Gu1USO1HQoSvfC0Sl9GHGC0RelmK
	gMbfZOmBw9swykmGXoqT8x64rFqkEnGpV+ZyyjwI+BFTT+9DzTpF7xgd6CVDbsTtiEgcMQTLfGK
	p
X-Google-Smtp-Source: AGHT+IG0i663YS5+4jvwwDGdS+W3psa+6dXTTsklOkkbw5bII+qM8QZd/U9dSYFjdtS/CEGuBCyy7A==
X-Received: by 2002:a05:6402:517b:b0:5a2:eab0:4a with SMTP id 4fb4d7f45d1cf-5b7f5414590mr1809000a12.24.1722586084434;
        Fri, 02 Aug 2024 01:08:04 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839719fdesm778001a12.8.2024.08.02.01.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:08:03 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+263426984509be19c9a0@syzkaller.appspotmail.com
Subject: [PATCH net] net: bridge: mcast: wait for previous gc cycles when removing port
Date: Fri,  2 Aug 2024 11:07:30 +0300
Message-ID: <20240802080730.3206303-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot hit a use-after-free[1] which is caused because the bridge doesn't
make sure that all previous garbage has been collected when removing a
port. What happens is:
      CPU 1                   CPU 2
 start gc cycle           remove port
                         acquire gc lock first
 wait for lock
                         call br_multicasg_gc() directly
 acquire lock now but    free port
 the port can be freed
 while grp timers still
 running

Make sure all previous gc cycles have finished by using flush_work before
freeing the port.

[1]
  BUG: KASAN: slab-use-after-free in br_multicast_port_group_expired+0x4c0/0x550 net/bridge/br_multicast.c:861
  Read of size 8 at addr ffff888071d6d000 by task syz.5.1232/9699

  CPU: 1 PID: 9699 Comm: syz.5.1232 Not tainted 6.10.0-rc5-syzkaller-00021-g24ca36a562d6 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
  Call Trace:
   <IRQ>
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
   print_address_description mm/kasan/report.c:377 [inline]
   print_report+0xc3/0x620 mm/kasan/report.c:488
   kasan_report+0xd9/0x110 mm/kasan/report.c:601
   br_multicast_port_group_expired+0x4c0/0x550 net/bridge/br_multicast.c:861
   call_timer_fn+0x1a3/0x610 kernel/time/timer.c:1792
   expire_timers kernel/time/timer.c:1843 [inline]
   __run_timers+0x74b/0xaf0 kernel/time/timer.c:2417
   __run_timer_base kernel/time/timer.c:2428 [inline]
   __run_timer_base kernel/time/timer.c:2421 [inline]
   run_timer_base+0x111/0x190 kernel/time/timer.c:2437

Reported-by: syzbot+263426984509be19c9a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=263426984509be19c9a0
Fixes: e12cec65b554 ("net: bridge: mcast: destroy all entries via gc")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
note: tested with KASAN and kmemleak on.

 net/bridge/br_multicast.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 9a1cb5079a7a..b2ae0d2434d2 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2045,16 +2045,14 @@ void br_multicast_del_port(struct net_bridge_port *port)
 {
 	struct net_bridge *br = port->br;
 	struct net_bridge_port_group *pg;
-	HLIST_HEAD(deleted_head);
 	struct hlist_node *n;
 
 	/* Take care of the remaining groups, only perm ones should be left */
 	spin_lock_bh(&br->multicast_lock);
 	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
 		br_multicast_find_del_pg(br, pg);
-	hlist_move_list(&br->mcast_gc_list, &deleted_head);
 	spin_unlock_bh(&br->multicast_lock);
-	br_multicast_gc(&deleted_head);
+	flush_work(&br->mcast_gc_work);
 	br_multicast_port_ctx_deinit(&port->multicast_ctx);
 	free_percpu(port->mcast_stats);
 }
-- 
2.44.0


