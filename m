Return-Path: <netdev+bounces-270688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFjDDdaYwWlNUAQAu9opvQ
	(envelope-from <netdev+bounces-270688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:47:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A76A52FC94A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C40A7313C9CE
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786FF358369;
	Mon, 23 Mar 2026 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGvdCM66";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r0hqNaOF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E0359A9A
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293424; cv=none; b=l61gaoXcn+aQ0nJeRJ58evtCzhjJ9oF1cUdiBt6geF/a3NGnJklzgAHOFRmeEBSkTVK/AgI3C7m4MeOQlZ3c7NJOZQ9pABmV2aKnzg2qcgr5gSqCYdN0WYztrmkO0y6oAPpPsUakyao8dCz8e1dL579R7soPYenpAsy/v3glvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293424; c=relaxed/simple;
	bh=qQev2XBpx128JB2baYrWRQwKp2W3DfU2kqeu3eVQv6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYnlIY9gBjYbsqGJQS2PUtTqLuI2/n2P3o3+0PBpp6Ez7hVdOhvxykyndduEpU/RucAoWfJdVLdbCTlezSL/GyT8gWG9t8X7/DvnlHwjmf7RdHFQhELpDELz1+9rebEGCLq+PZPJdDCT7Cojt31BJAtKAdE+dUhZLrCucrmGdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGvdCM66; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r0hqNaOF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774293417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mBZWWUdfht7nMBVcp3a2zUtI728JluSH2fIN88lMnfU=;
	b=KGvdCM66QxnJ07SqaMEJoM3/kTrgz7uPWBmSZgQJhwCXL9KU9yWGXT22wUg52Df0Ruk4Vt
	exC13jH0812wzJTn9Pjx67r3HXH4Yfyo737eXNITJnQYtY16kTUqfYBw7SNVoAvagaTU6K
	AbqBiStCssJw52YSyw3Z2H1pZRzHTMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-pJIKfw8LNp2wnwpcYlycAA-1; Mon, 23 Mar 2026 15:16:56 -0400
X-MC-Unique: pJIKfw8LNp2wnwpcYlycAA-1
X-Mimecast-MFC-AGG-ID: pJIKfw8LNp2wnwpcYlycAA_1774293415
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836abfc742so21439325e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774293414; x=1774898214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mBZWWUdfht7nMBVcp3a2zUtI728JluSH2fIN88lMnfU=;
        b=r0hqNaOFdwvMy/cmkJt36Hv4LP9+x76Z971WD/vPqP/Ric4vsxAT99ge4oXZsrnI3n
         V0w1eMsMQKk6vFKqGqgNC2MTDi5hsau/o1aVJsjgbThRNZ64k0fSVnGdJWVwZaI/2qvH
         llNIiTdMEki3daWAeZSmt+Jckg+pHShtyzUlQdzz+Hmn8uOigHVjBAzX4ICjd8ug/8t9
         6H+X4+Nsjx95U1x4YAt9od0vx2W4uI5dx9prNyZxO0u2zrBO1UN94ZZ12k1feOeNiwyJ
         eddSua0wUFa+Vo++1PWTMDeKxU7laE7ltowS0w/oH+2hXLGXKZm2qms4JZnAKVEZlnhd
         +8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774293414; x=1774898214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBZWWUdfht7nMBVcp3a2zUtI728JluSH2fIN88lMnfU=;
        b=P7ciq9yBLmaM9sHuIvq22AQUYF0otcIi86dlIvWxLZhw3KGtP1Js4dDgUPEsAjAAmI
         UCvxAxGfJgTUrLuyGcXJJGxJq52vlva53dJNMZHwGBAn2oRulcIoaTBEtM12vf4yqVI4
         nEwG0Z3lnTLEuieIjIsJi/kq/QXHtnU6lmQIJV42hf5ANy5lEcpFi9sQzDHxgb3PPZ67
         7kainhilXe4Q3XSPXow1IT+hw2036Pn7JL5s9AMBUMaa7A3r8Wr4U+3vzoOby7ObcZZ5
         DUGGTLei8SyOavciv1WoMD5qdqeVsYY93BFzH1pGce94Ca8/38CVUnMd/VvjHzBMiRyc
         MfAw==
X-Gm-Message-State: AOJu0YzvmkMnW+Yf1AN90oIO+Gz2yv8rDVmi12Xqlex1PJdJoRveZd7C
	YHmL4bQyA4/LQZoUCX6aEckPcKXI0c/V0bUitcw6lhfS3fXhxMSTUtbgw8PQa9zX0+1QEb93R1G
	MYb+uuq09VKKne6IhBU03YIg+xhq+MfL3RlBxxkZnuEghqqTn3kmQjdB3W7kHQkYcEGErvmxwgR
	dYUVD65E9vci6VuEkUKpmqExKJl9qoclOQ8fsuXYhhfQ==
X-Gm-Gg: ATEYQzyJBtVE3oi8cTHoo68jrIYMl1M4aC9UsugfQIGjj4VFiHBmF5rp6KWkniOJW6f
	oo4xYScloSUCWTa/56GzodNaRCbIoL4XOT1a04+frYVkIbqpkibQY6H0jcXDMZPrer6TkmhZgwd
	Ni2JitsTHLvqvYqUUOwyOEhWkbBOiv9f+KZzza9Cd89i9l62V7FbZ4gTxCu+liMDuJSYnzuIYiL
	PDpiwffX8KXW/autC0fdnNcpMVen+A74OHTXdHUCg/qV6Usz3gM1P1Q+Wyh+ncuuoM1W59vzebK
	c0BJex4oBblQoUPYfGR6Y8Kt0h5DT56JlHVaHbLRsiiH+HtP4cx9a3RVlhHBsqezQVYkTkQV9kt
	tH9ADs4LsyxyAtfGPtrGPZEmwm+gQil/2zIYuJk9jfcVLRDQavas=
X-Received: by 2002:a05:600c:3b07:b0:486:af22:4a2a with SMTP id 5b1f17b1804b1-486febbc445mr186609925e9.7.1774293414207;
        Mon, 23 Mar 2026 12:16:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3b07:b0:486:af22:4a2a with SMTP id 5b1f17b1804b1-486febbc445mr186609445e9.7.1774293413520;
        Mon, 23 Mar 2026 12:16:53 -0700 (PDT)
Received: from localhost (net-2-44-37-38.cust.vodafonedsl.it. [2.44.37.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470c239sm31655643f8f.27.2026.03.23.12.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:16:53 -0700 (PDT)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net] net: macb: use the current queue number for stats
Date: Mon, 23 Mar 2026 20:16:34 +0100
Message-ID: <20260323191634.2185840-1-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270688-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A76A52FC94A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There's a potential mismatch between the memory reserved for statistics
and the amount of memory written.

gem_get_sset_count() correctly computes the number of stats based on the
active queues, whereas gem_get_ethtool_stats() indiscriminately copies
data using the maximum number of queues, and in the case the number of
active queues is less than MACB_MAX_QUEUES, this results in a OOB write
as observed in the KASAN splat.

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in gem_get_ethtool_stats+0x54/0x78
  [macb]
Write of size 760 at addr ffff80008080b000 by task ethtool/1027

CPU: [...]
Tainted: [E]=UNSIGNED_MODULE
Hardware name: raspberrypi rpi/rpi, BIOS 2025.10 10/01/2025
Call trace:
 show_stack+0x20/0x38 (C)
 dump_stack_lvl+0x80/0xf8
 print_report+0x384/0x5e0
 kasan_report+0xa0/0xf0
 kasan_check_range+0xe8/0x190
 __asan_memcpy+0x54/0x98
 gem_get_ethtool_stats+0x54/0x78 [macb
   926c13f3af83b0c6fe64badb21ec87d5e93fcf65]
 dev_ethtool+0x1220/0x38c0
 dev_ioctl+0x4ac/0xca8
 sock_do_ioctl+0x170/0x1d8
 sock_ioctl+0x484/0x5d8
 __arm64_sys_ioctl+0x12c/0x1b8
 invoke_syscall+0xd4/0x258
 el0_svc_common.constprop.0+0xb4/0x240
 do_el0_svc+0x48/0x68
 el0_svc+0x40/0xf8
 el0t_64_sync_handler+0xa0/0xe8
 el0t_64_sync+0x1b0/0x1b8

The buggy address belongs to a 1-page vmalloc region starting at
  0xffff80008080b000 allocated at dev_ethtool+0x11f0/0x38c0
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000
  index:0xffff00000a333000 pfn:0xa333
flags: 0x7fffc000000000(node=0|zone=0|lastcpupid=0x1ffff)
raw: 007fffc000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff00000a333000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff80008080b080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff80008080b100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff80008080b180: 00 00 00 00 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                  ^
 ffff80008080b200: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffff80008080b280: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================

Fix it by making sure the copied size only considers the active number of
queues.

Fixes: 512286bbd4b7 ("net: macb: Added some queue statistics")
Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
This was previously part of:
https://lore.kernel.org/all/20260313201433.2346119-5-pvalerio@redhat.com/
Split as suggested by Nicolai.
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1cb49252abf5..28a03dd51c50 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3369,7 +3369,7 @@ static void gem_get_ethtool_stats(struct net_device *dev,
 	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
-			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+			* (GEM_STATS_LEN + QUEUE_STATS_LEN * bp->num_queues));
 	spin_unlock_irq(&bp->stats_lock);
 }
 
-- 
2.53.0


