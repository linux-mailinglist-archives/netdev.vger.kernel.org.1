Return-Path: <netdev+bounces-231362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1302EBF7E9F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14E95507492
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B843134C80D;
	Tue, 21 Oct 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7LGBQ3E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E634B68A
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067939; cv=none; b=LTD4nLSDkXthvZFkOLnWiH6pBzO0OczzkBhbphExCr4wLOxGgvsVhcp5zrp4C0oM2v3r93hwZoAlisdLttItrgP88rViKIHHWyyiUjHHmlrRuYRrTKc4a40MfYgU2vJakJhbbVQsb4RixaOaBjZtUY4RhU2C2x+rnWnF2HZQWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067939; c=relaxed/simple;
	bh=LWmEWjRyeCjLG1cMy0JCFnlQjX+UfVSwvPnfh+zdDvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmBK/+EAbcWZdsCIrdN6mvP6yn8DMoggoNVXfjy3YtoQuu4MkiICN/WNfHzIjgl8LgLSol1fGPEd9hJMJ+lZZsx4rh2EyY8hY5Jhrx0683C9ThO6CyBdwRAHE3gPjveNjJHlSHE7WoLWASP3CL+ahLdDaRdL/8dL+uwuDj9Dlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7LGBQ3E; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f67ba775aso7636554b3a.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067937; x=1761672737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W32bDqvyR7vujxfMeW9XwQgpRLc26l7oP7qKEtb01No=;
        b=Y7LGBQ3Eu306T0aGNRBFKPOr4ENkYud1JYkAp3ik7YU6dlFxfLIkDAM0a2y5bMLSBo
         Zu6MLlzerY683jwzk35LECn+2TaRwld2EsiyyzQYWwBzEdV3BwsQjVTOCVB+ZJjmFvI5
         T8d8jReqZy2cjlUAAUXHWjg4aj8aXH3ZOnenyS9tzrYpXtFhVl/mQ7Mvym1ZaUpKI4hh
         zXzYibJ/hCCSVdUI/PG9XZ0WmrG7arnMljArqad6w5/wvgGJKiEQmJZPsUqmwRgpROQv
         WKZeBkhWvFZOHXyd+elu00bk/qjD5aGn+kVIz8Dcp1ATnvSLVspE2hsRsGjS5QfyFlNK
         GAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067937; x=1761672737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W32bDqvyR7vujxfMeW9XwQgpRLc26l7oP7qKEtb01No=;
        b=ekq/0OIbNfAnOJ+mKyN0R5Uj4Gv+Wa4eiJvmbUDNmG9KFRAJ6iBGq6dwFwYofj8DQQ
         vKSN+RJT5s7zs3v6gtIA4t9irzDfCWHtkKgKaP5Njm9NHtptapVyJU2DRxK4XKknbuCQ
         b2JiN/IjJeoZ+hgAD08/wZdDk4zcHXv7ifGT6O6QN38kuJvp2Ts5d9/f3FtzDk2Txc2y
         GxNv9tyont+DO+A8Cy4D4tWl6vjYdzNTGoFoaBCIFGeiO700ICFn7h6VWdJ0fQ/Gbs+3
         8kJ43NwkzEuQSiTiUTmMU+/y6bYUAmVu54NZFOwxMB6HDLwIavkR0CY/4egeKJW5v5Ro
         V4TQ==
X-Gm-Message-State: AOJu0YwCCo/sXXQDJ/73hk3mtoX33rN82LtlIJ5kCXbK6XkMFCh/4Qt6
	Iep4QPBXVeOSa0yLuJuislQEdZNdi1zJaKnQvgW87v1ymOK460QgSXP8t/KfBqvZKCo=
X-Gm-Gg: ASbGncsJlllFuGKOg8TCGOwvCJpycyeV5hI1pXBcIQ5jjESvAwatsO/2LrNbtg/IQmA
	67Ho1Mb/NJLUbUil4vwClRkeV9D2hUJ9ZbyAjvAjMn522sSZHziL1nywp5DoAdb/+ICG0abaP+B
	/0FapokS/9y0CYVtAhvr0ukt5NfHgNwwGE4xXKdGN37LAeylqMh+ItK4ri3w5CIwoaDN1rTzS6J
	K9+DDOoAk9IH0oEUaFGY9taVVDNTdASNQCIcs7GfNaNk4l/gL1i8P5bZD/c6alGGliNSyYoflse
	f8B3fXg+sutP/14/s5CPRtPRYMQJhneJTWytrV12LzZUUgfiH/I1vZhVSlk43ZY6Oc2NVBYiZMv
	wspyV8GNkgMRzal/BzJNl/6KNVqbf6nbYPwE2VpOFnwhEnPUYwwcljGEFvNuy3xtBD9JqKdjGH4
	cQGTyW71SiaFehqw==
X-Google-Smtp-Source: AGHT+IGJnLDF4X5uEtsa2xDyV0cUHKx8VFYNG1No6zJf1JQmgFUvBau7xsPVnXixxXlAbB/zCJrVMg==
X-Received: by 2002:a05:6a21:9986:b0:320:3da8:34d7 with SMTP id adf61e73a8af0-334a85661b7mr22334007637.22.1761067936853;
        Tue, 21 Oct 2025 10:32:16 -0700 (PDT)
Received: from 192.168.1.4 ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b346aasm10941006a12.20.2025.10.21.10.32.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Oct 2025 10:32:16 -0700 (PDT)
From: Alessandro Decina <alessandro.d@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Alessandro Decina <alessandro.d@gmail.com>
Subject: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status descriptors
Date: Wed, 22 Oct 2025 00:32:00 +0700
Message-Id: <20251021173200.7908-2-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251021173200.7908-1-alessandro.d@gmail.com>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever a status descriptor is received, i40e processes and skips over
it, correctly updating next_to_process but forgetting to update
next_to_clean. In the next iteration this accidentally causes the
creation of an invalid multi-buffer xdp_buff where the first fragment
is the status descriptor.

If then a skb is constructed from such an invalid buffer - because the
eBPF program returns XDP_PASS - a panic occurs:

[ 5866.367317] BUG: unable to handle page fault for address: ffd31c37eab1c980
[ 5866.375050] #PF: supervisor read access in kernel mode
[ 5866.380825] #PF: error_code(0x0000) - not-present page
[ 5866.386602] PGD 0
[ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI
[ 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted 6.17.0-custom #1 PREEMPT(voluntary)
[ 5866.403740] Hardware name: Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3.2 03/20/2025
[ 5866.412339] RIP: 0010:memcpy+0x8/0x10
[ 5866.416454] Code: cc cc 90 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <f3> a4 e9 fc 26 c0 fe 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[ 5866.437538] RSP: 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286
[ 5866.443415] RAX: ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 00000000000004e1
[ 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI: ff2dd26dbd8f0000
[ 5866.459454] RBP: ff428d9ec0bb0d40 R08: 0000000000000000 R09: 0000000000000000
[ 5866.467470] R10: 0000000000000000 R11: 0000000000000000 R12: ff428d9eec726ef8
[ 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15: ff2dd26548548b80
[ 5866.483509] FS:  0000000000000000(0000) GS:ff2dd2c363592000(0000) knlGS:0000000000000000
[ 5866.492600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5866.499060] CR2: ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 0000000000f71ef0
[ 5866.507079] PKRU: 55555554
[ 5866.510125] Call Trace:
[ 5866.512867]  <IRQ>
[ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e]
[ 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e]
[ 5866.526022]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.531408]  ? raise_softirq+0x24/0x70
[ 5866.535623]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800
[ 5866.551493]  __napi_poll+0x30/0x230
[ 5866.555423]  net_rx_action+0x20b/0x3f0
[ 5866.559643]  handle_softirqs+0xe4/0x340
[ 5866.563962]  __irq_exit_rcu+0x10e/0x130
[ 5866.568283]  irq_exit_rcu+0xe/0x20
[ 5866.572110]  common_interrupt+0xb6/0xe0
[ 5866.576425]  </IRQ>
[ 5866.578791]  <TASK>

Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..dbc19083bbb7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -441,13 +441,18 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		dma_rmb();
 
 		if (i40e_rx_is_programming_status(qword)) {
+			u16 ntp;
+
 			i40e_clean_programming_status(rx_ring,
 						      rx_desc->raw.qword[0],
 						      qword);
 			bi = *i40e_rx_bi(rx_ring, next_to_process);
 			xsk_buff_free(bi);
-			if (++next_to_process == count)
+			ntp = next_to_process++;
+			if (next_to_process == count)
 				next_to_process = 0;
+			if (next_to_clean == ntp)
+				next_to_clean = next_to_process;
 			continue;
 		}
 
-- 
2.43.0


