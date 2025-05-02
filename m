Return-Path: <netdev+bounces-187347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D610CAA67CF
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 02:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7623ACC78
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2806C8DC;
	Fri,  2 May 2025 00:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UnaUB+r6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DCD3234;
	Fri,  2 May 2025 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746145594; cv=none; b=DWFXayWYIn5904Xn8F19ahL0ZJWmFehNd9KvmqjvvzNI3ft+aCA10YTF4twT71Y+x79VPfJHTPhgjWetzVMpFXy27+xLS5q0vA+rmKVeBlqYaogOlo+Tz4gM9Hbw9Zw1JqzB40xl6XEMxTaXpDQyJ591XEs3w8RyfIl5Bm8oIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746145594; c=relaxed/simple;
	bh=TCDeZjMheRYTsppH8objBlDjgCg50vN3dPjN2O0EXGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMk+jw7zGOwciRZIWkyIzOVacJQHhFBfkGbgdo9DnR71FN/5D6MJUGL+IAigLXDdqu53G3S+sAyNwc2eRBw80a7jhk1KSvFDaZF5i2XjcOi5rmRuAubZ18rRNh/CXoVzcgao1n4sSzfGjbs+s1NHVOXPe0LC6A3aGFZ7kczAmwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UnaUB+r6; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746145593; x=1777681593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l1i1oewbri2/ugzIY/kolfwtyid+RzFLCLAK4mB+wtw=;
  b=UnaUB+r6Gz7BtO5dLuP5JueT44KkeFeGKZUSG4E2lj+6b9+c785gd7xa
   tI4MZTstH7bZkYD4Z/8YACt+l20feRRt3S/Trlyyf37z7cK52JB3OyWS4
   rxzlowa8RjmQlGnKct77KvK2djWV2QSQ0qWjAVcCAGG13eM9Vp+DOFnWu
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,255,1739836800"; 
   d="scan'208";a="488247422"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 00:26:29 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:1914]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.92:2525] with esmtp (Farcaster)
 id 2ada3ecd-7626-419b-8924-6bea48a58736; Fri, 2 May 2025 00:26:28 +0000 (UTC)
X-Farcaster-Flow-ID: 2ada3ecd-7626-419b-8924-6bea48a58736
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 00:26:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 2 May 2025 00:26:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+e4eec4b8584ac3f936e5@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] UBSAN: array-index-out-of-bounds in ipv6_addr_prefix
Date: Thu, 1 May 2025 17:25:22 -0700
Message-ID: <20250502002616.60759-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <681357d6.050a0220.14dd7d.000c.GAE@google.com>
References: <681357d6.050a0220.14dd7d.000c.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+e4eec4b8584ac3f936e5@syzkaller.appspotmail.com>
Date: Thu, 01 May 2025 04:15:34 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5565acd1e6c4 Merge git://git.kernel.org/pub/scm/linux/kern..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12f19574580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2e3745cb659ef5d9
> dashboard link: https://syzkaller.appspot.com/bug?extid=e4eec4b8584ac3f936e5
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10207fcf980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f19574580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/80798769614c/disk-5565acd1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/435ecb0f1371/vmlinux-5565acd1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7790d5f923b6/bzImage-5565acd1.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e4eec4b8584ac3f936e5@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in ./include/net/ipv6.h:616:21
> index 16 is out of range for type 'const __u8[16]' (aka 'const unsigned char[16]')
> CPU: 0 UID: 0 PID: 5837 Comm: syz-executor401 Not tainted 6.15.0-rc3-syzkaller-00557-g5565acd1e6c4 #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  ubsan_epilogue+0xa/0x40 lib/ubsan.c:231
>  __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:453
>  ipv6_addr_prefix+0x145/0x1d0 include/net/ipv6.h:616
>  ip6_route_info_create+0x629/0xa70 net/ipv6/route.c:3814
>  ip6_route_mpath_info_create net/ipv6/route.c:5393 [inline]
>  ip6_route_multipath_add net/ipv6/route.c:5519 [inline]

I missed err is reset by rtm_to_fib6_multipath_config()
and lwtunnel_valid_encap_type() ... I like setting
err just before goto...

so the diff below fixes,

---8<---
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index aa6b45bd3515..fee80b08bc46 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5275,6 +5275,8 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	if (newroute) {
+		err = -EINVAL;
+
 		/* RTF_PCPU is an internal flag; can not be set by userspace */
 		if (cfg->fc_flags & RTF_PCPU) {
 			NL_SET_ERR_MSG(extack, "Userspace can not set RTF_PCPU");
---8<---

but this patch also fixes it,

https://lore.kernel.org/netdev/20250501005335.53683-1-kuniyu@amazon.com/

so,

#syz dup: [syzbot] [net?] WARNING in ipv6_addr_prefix

