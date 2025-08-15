Return-Path: <netdev+bounces-214192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CB0B2871D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6281CE93A8
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8230329C35F;
	Fri, 15 Aug 2025 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaJwiLeK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3DB242D69;
	Fri, 15 Aug 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289102; cv=none; b=uXjszETW43Nxqy48NUue3opEO7PP2oLFkDS6iuv1B5NEczBLHY4XS0UdAd4fJLuGyL5vcbJP22D9TmCAy86eEcadMD8RvIOfvdIxQf2QYuii5Vb4+eJVnmI1Wh9UOZRXYhvg5ZmXnoow2fa4HQO2sgZco4Lqv6JrkI2pC3SQ/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289102; c=relaxed/simple;
	bh=tgoezjGAf0KZKsRwrMyeRLHrhVcj3sGuLIfQb+BbpGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3ocrpr4+YlZUKiswL0kdG7laSmX+s6MNqW8vjrmZYSn4jZsR3144c4Dw9JIza5X4rAWhn5UxOhAHuowH50BMIMAb5UINVJmF48DGxvbTkVlZLKC/BpGDs6RwCw+0CdFcSTQ/sl7r0katlxX0mNGnZuTvFJvCCYjsfs7ZqaLMXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaJwiLeK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb78e70c5so375323866b.1;
        Fri, 15 Aug 2025 13:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755289099; x=1755893899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hKGGbUWZPDeDZmUppFCrYR0EPPBsR1LFkPo87D006Pg=;
        b=VaJwiLeK/e2lCNT1fIKtVIzGgYRlQOWA8iDr3KtY/tuf1fwwFLgkMMGVmeYfsG8Sl0
         /gEzGIIndk2EdtJDbBDm1QrlXXkClt5HBmA7coy4a8XmyFDz14QcXJzDCmXL+qJKhMpD
         yo0EUbjrT0/6eIvgAGiw7q+o+OOjqxMw7DiIIrVAht3M0qdvYGJy3HIYS55MjJHPvwwH
         mg0pequjj717trH4YArhE1qHiu721gewBxhVuxShMNk/GwfcietOBzFL71UpY8Ooccmr
         rSx+60ovTPfbvIgYugp2hxHq6dp261BPHC1Lgd6umYtyHlyZJZw/Z4OJ5Ks1Rc6BSBlY
         ioQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289099; x=1755893899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKGGbUWZPDeDZmUppFCrYR0EPPBsR1LFkPo87D006Pg=;
        b=shDBrduM583bpMISSbJ/nrLRoVcS6PXdAMsAyGNVk7cxanrWmCXWrH6ZtWiCVj4hhN
         kNvdHyaw7CMl5KSlrLwU/+IRS5+NW5V9zbk9oIne1RhipJMjKeqnqnf8tQId5LtL4exc
         sEv1V3GjtnBGSnfrhUNRW9k715HUGQxh7UsDVyxKK1YjhVIhEDooe538VX36Q0WamnWX
         5wj8/fY7hsivcVy+W+DqCMma9xMNWSHazoOmDIySdL6Q5Pgsxe1RUzWgLXBGF3RPYaYo
         VO3dscp344XKNvOmAijiHLNZyo3xyL+HZpo/KHuzeYYW2fhqNpgIzO269c7P+B01rP43
         2xCg==
X-Forwarded-Encrypted: i=1; AJvYcCUirRCW709e7Ldp6FbB3iCxrd32fM0T6PpkVlrxm2GMXXkEFRFC4N6S81wZuZf+UXXu0Kesvzgb@vger.kernel.org, AJvYcCUsq4FXTR1Ou2D5YPrOVxqlqihGIu5NUQAgJ9q10LKjQioYNZcQvtABeYcKoHAQBzkH8xvth1xvrJMjOAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYlYTujoWkKIU4FhlH6llC+caECGmbHRsk1t4ZrK2Eg8g51Pic
	WCino6o441p+99t7APFlcWnWbY9noLhawzIPKsFP9y83ZAIINKWOKqLW
X-Gm-Gg: ASbGnctcuAAh6H+9Q+A3jdFfY6WSe4qqSnXjNh8si/ELBAeRxs/1FPwPbuAVBCfPEtw
	6QfcVWxy5uuTbSrCQobF32FMNzq2W3VcIXW2exyr+SWQoLCzAnEUxW1IcKF0CeyBVgEWtbCB+VJ
	BI2iP0w7QhRnfKxmtGhGdY5DoZ/DcNFj7idbyZtPYguSTdGdheOfkpMcxiRC3PK0lm9SD16PT/2
	zzLVOEBdTmRtmedP6YOTJahTRSdHCFnvQtqVyJw8QpkoCRrHVyzDL9HT1b7X3AC5E7JZshoiEho
	S9e8MbUaUSMnGR7v79AgC1Qe/YpDYxjObp9VT0ub9FGHsCqGpduj6UbqbWM31YrpgidUVjR8s5l
	ipl+EJIUvQaXvWS6ng9FeHh/Zi7MEKXlvTrZjVRUBMXxxIKYjIpflPG3Nj/l5wl38vaYNr56HOC
	7TnQ==
X-Google-Smtp-Source: AGHT+IFQhhGaiqpe3/JclgwEIpYgWq9j7cjfNKlyBQwKqEWW0ouy2g/89dPHO7o523yxF6WPyOWmhg==
X-Received: by 2002:a17:906:a0c:b0:af9:237c:bb1c with SMTP id a640c23a62f3a-afceae15b27mr15675866b.43.1755289098723;
        Fri, 15 Aug 2025 13:18:18 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfce4e3sm217608266b.69.2025.08.15.13.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 13:18:18 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: b53: fix reserved register access in b53_fdb_dump()
Date: Fri, 15 Aug 2025 22:18:09 +0200
Message-ID: <20250815201809.549195-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When BCM5325 support was added in c45655386e53 ("net: dsa: b53: add
support for FDB operations on 5325/5365"), the register used for ARL access
was made conditional on the chip.

But in b53_fdb_dump(), instead of the register argument the page
argument was replaced, causing it to write to a reserved page 0x50 on
!BCM5325*. Writing to this page seems to completely lock the switch up:

[   89.680000] b53-switch spi0.1 lan2: Link is Down
[   89.680000] WARNING: CPU: 1 PID: 26 at drivers/net/phy/phy.c:1350 _phy_state_machine+0x1bc/0x454
[   89.720000] phy_check_link_status+0x0/0x114: returned: -5
[   89.730000] Modules linked in: nft_fib_inet nf_flow_table_inet nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_quota nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 cls_flower sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_route cls_matchall cls_fw cls_flow cls_basic act_skbedit act_mirred act_gact vrf md5 crc32c_cryptoapi
[   89.780000] CPU: 1 UID: 0 PID: 26 Comm: kworker/u10:0 Tainted: G        W           6.16.0-rc1+ #0 NONE
[   89.780000] Tainted: [W]=WARN
[   89.780000] Hardware name: Netgear DGND3700 v1
[   89.780000] Workqueue: events_power_efficient phy_state_machine
[   89.780000] Stack : 809c762c 8006b050 00000001 820a9ce3 0000114c 000affff 805d22d0 8200ba00
[   89.780000]         82005000 6576656e 74735f70 6f776572 5f656666 10008b00 820a9cb8 82088700
[   89.780000]         00000000 00000000 809c762c 820a9a98 00000000 00000000 ffffefff 80a7a76c
[   89.780000]         80a70000 820a9af8 80a70000 80a70000 80a70000 00000000 809c762c 820a9dd4
[   89.780000]         00000000 805d1494 80a029e4 80a70000 00000003 00000000 00000004 81a60004
[   89.780000]         ...
[   89.780000] Call Trace:
[   89.780000] [<800228b8>] show_stack+0x38/0x118
[   89.780000] [<8001afc4>] dump_stack_lvl+0x6c/0xac
[   89.780000] [<80046b90>] __warn+0x9c/0x114
[   89.780000] [<80046da8>] warn_slowpath_fmt+0x1a0/0x1b0
[   89.780000] [<805d1494>] _phy_state_machine+0x1bc/0x454
[   89.780000] [<805d22fc>] phy_state_machine+0x2c/0x70
[   89.780000] [<80066b08>] process_one_work+0x1e8/0x3e0
[   89.780000] [<80067a1c>] worker_thread+0x354/0x4e4
[   89.780000] [<800706cc>] kthread+0x130/0x274
[   89.780000] [<8001d808>] ret_from_kernel_thread+0x14/0x1c

And any further accesses fail:

[  120.790000] b53-switch spi0.1: timeout waiting for ARL to finish: 0x81
[  120.800000] b53-switch spi0.1: port 2 failed to add 2c:b0:5d:27:9a:bd vid 3 to fdb: -145
[  121.010000] b53-switch spi0.1: timeout waiting for ARL to finish: 0xbf
[  121.020000] b53-switch spi0.1: port 3 failed to add 2c:b0:5d:27:9a:bd vid 3 to fdb: -145

Restore the correct page B53_ARLIO_PAGE again, and move the offset
argument to the correct place.

*On BCM5325, this became a write to the MIB page of Port 1. Still
a reserved offset, but likely less brokenness from that write.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 9942fb6f7f4b..829b1f087e9e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2078,7 +2078,7 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
 
 	/* Start search operation */
 	reg = ARL_SRCH_STDN;
-	b53_write8(priv, offset, B53_ARL_SRCH_CTL, reg);
+	b53_write8(priv, B53_ARLIO_PAGE, offset, reg);
 
 	do {
 		ret = b53_arl_search_wait(priv);
-- 
2.43.0


