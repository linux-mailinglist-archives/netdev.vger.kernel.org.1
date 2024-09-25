Return-Path: <netdev+bounces-129637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA498509E
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 03:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E288C1F24249
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 01:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E69D13C683;
	Wed, 25 Sep 2024 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A1pbXXIJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8DEEA5
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727227536; cv=none; b=HKL7iIKRHUV5WOpB5UxOulQ0vnQBH+ER+kNl0N4NeZ7TPLYLpvc5qgv0bIk7HHfIOTnMMZC1qjUCAWwIaM9WCqckI0iwE9OQwmYdPiYDbAE3APPyRR+V1jnp/aq94ixxf4VbJ9tSvMeYXkkp1xqyt7tOb2j0WWDOKM+l8RdMgIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727227536; c=relaxed/simple;
	bh=5RFdYXGZPb9BAGONrDdo57RoFUNOl6Rh98KBkBw7mKI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Dacw+pp7qHC40k2A4nTUTzBE8mvBzomijHarcp6a6kH0tJqtzwNGbtfJnFmiRfzifpH6HDE7ehkddMwI0qUHsoJmnNR/VQgkKcvwGO2NbDNCH/Mm9pEbarF1Ce3g9SmFiSBhfDiIF2IFZ781EUfKQUBTwZbGk65xUT6Y5R6XWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A1pbXXIJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2dbde420d15so487580a91.3
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 18:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727227533; x=1727832333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zum8SJmpXCJIldCzRTiLASKwdzI+py8oAVKrt4rg+X4=;
        b=A1pbXXIJh5ooEuLT5YqYANYR7+PsdFgw4M6JWo4LeCacIrlLUjB/rdCfzS269i3z/T
         isRSKsbl5ih6CaZ8msuYjD9JXGme4XoGS+kTziWeCI1MOilglPnvm5kXYkheO6Eisc9L
         RMTh+mkAEjBKWWNbe5ty+3IjrDNHFVbgHFVu1CDudxe7fYCoPQXTcJNUq+OkJUwt2fu8
         uLevSfGvOsDvPeBmYLdiaOaZtP8CCnHhJcXo/7VMF7Yxsh+oPr2MDUuzOX7VRmTO5H89
         MzRmnc2+H0QxiTNX83TA/2FVKWd17K7ksIAPZMC+M3gjXqDApnsBZYAALlpxo272Hvy+
         Iyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727227533; x=1727832333;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zum8SJmpXCJIldCzRTiLASKwdzI+py8oAVKrt4rg+X4=;
        b=mr+dAsPFdSbO9ShPryg2D6aBhWGRj9j4etDXB1IS0+SJY1rGp4kv7I8YD9czk9YDHn
         n9sn9fcKtvGe7m+pFWHDUA75BIZ3H4srbSZbltNIxDhlSAk0iVZIf9BUX5njeldijABR
         BweBX9DhahXP5zbjH/BYWAfUbTiwPFOgj4aSSsMry/y5sWDRjchGutvJ/CCHxN38y63L
         3rYJZTQMYjWG+FX+/SIRWCjUe79hjff5FUCmClRnDZBo62vq59qj9lc0PqfJTLjRUaxy
         P3J/lAVY/rgAWI6L4SIoEOMe885YYc8fI39uz7GbpGadwhG5EUkNuHbeL96wrpAFFb7B
         uOdA==
X-Gm-Message-State: AOJu0Yy/Xb9AORMWUk4fvjYd8HOmCCfbf+8iXNsmXuvJZ4eQrcO27Dbh
	2Ru7UkJSfYXmhrx7eecHUUqYONwIN5o/ETmZ2Wn4JShCzraKi8LxG1JGJmcem7CVQKw7noVPF9q
	z3dE7reRfn8qSweSXtfriSHF4o54WPzz282kL7ouiyMJbrz8JWes=
X-Google-Smtp-Source: AGHT+IEclPIyYeZPH+LMKnfB8xdP/FNKownuSsVu3kYhm73FSJsYoE2+sBXpltNPpqGyW1DxF6fmTBB+XnevQH57FjA=
X-Received: by 2002:a17:90a:b113:b0:2db:60b:366a with SMTP id
 98e67ed59e1d1-2e06affcc7amr500541a91.9.1727227533107; Tue, 24 Sep 2024
 18:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Casey Chen <cachen@purestorage.com>
Date: Tue, 24 Sep 2024 18:25:22 -0700
Message-ID: <CALCePG3AqRKd7uNmVhUaCb5X8ouCtpyJVZO-2V0DPUAn2ywZUw@mail.gmail.com>
Subject: Page fault in MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
To: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, Yuanyuan Zhong <yzhong@purestorage.com>
Content-Type: text/plain; charset="UTF-8"

Hello Maintainers,

Our kernel is based on v6.6.9 with some of our own patches. Recent we
found a page fault bug in
MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels) with below call trace:

[10047.422568,023] BUG: unable to handle page fault for address:
ffffc90189cb6001
[10047.428781,023] #PF: supervisor write access in kernel mode
[10047.431902,023] #PF: error_code(0x0002) - not-present page
[10047.434983,023] PGD 100000067 P4D 100000067 PUD 79b0ff067 PMD
14ae1b3067 PTE 0
[10047.440991,023] Oops: 0002 [#1] SMP
[10047.443961,023] CPU: 23 PID: 140817 Comm: ethtool Tainted: G
   O       6.6.9+
[10047.449881,023] Hardware name: xxx (masked off)
[10047.455737,023] RIP: 0010:memcpy_orig+0x104/0x110
[10047.458649,023] Code: 16 fc 89 0f 44 89 44 17 fc c3 66 66 2e 0f 1f
84 00 00 00 00 00 90 83 ea 01 72 19 0f b6 0e 74 12 4c 0f b6 46 01 4c
0f b6 0c 16 <44> 88 47 01 44 88 0c 17 88 0f c3 cc 48 89 f8 48 39 fe 7d
0f 49 89
[10047.467394,023] RSP: 0018:ffffc901888abb88 EFLAGS: 00010202
[10047.470313,023] RAX: ffffc90189cb6000 RBX: ffffc901888abbe8 RCX:
0000000000000074
[10047.476003,023] RDX: 0000000000000001 RSI: ffffffffa0514f00 RDI:
ffffc90189cb6000
[10047.481713,023] RBP: ffffffffa0514f00 R08: 0000000000000078 R09:
0000000000000078
[10047.487427,023] R10: 6e616c765f646564 R11: ffffc90189cb5fe4 R12:
ffffc90209cb5fff
[10047.493153,023] R13: ffffffffa0514f02 R14: 000000007fffffff R15:
ffffc90189cb6000
[10047.498898,023] FS:  00007fae90a49b80(0000)
GS:ffff88afdfac0000(0000) knlGS:0000000000000000
[10047.504660,023] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10047.507579,023] CR2: ffffc90189cb6001 CR3: 0000002a7c242004 CR4:
00000000007706e0
[10047.513273,023] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[10047.519027,023] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[10047.524881,023] PKRU: 55555554
[10047.527792,023] MSR 198h IA32 perf status 0x0000197c00001800
[10047.530747,023] MSR 19Ch IA32 thermal status 0x0000000088320000
[10047.533668,023] MSR 1B1h IA32 package thermal status 0x0000000088310000
[10047.539297,023] Call Trace:
[10047.542083,023]  <TASK>
[10047.544822,023]  ? __die+0x20/0x60
[10047.547493,023]  ? page_fault_oops+0x169/0x4d0
[10047.550140,023]  ? search_bpf_extables+0xf/0x50
[10047.552738,023]  ? fixup_exception+0x22/0x280
[10047.555310,023]  ? exc_page_fault+0xbd/0x140
[10047.557820,023]  ? asm_exc_page_fault+0x22/0x30
[10047.560271,023]  ? memcpy_orig+0x104/0x110
[10047.562663,023]  vsnprintf+0x24e/0x4f0
[10047.564985,023]  sprintf+0x56/0x70
[10047.567287,023]  ? mlx5e_query_global_pause_combined+0x5b/0x80 [mlx5_core]
[10047.571742,023]  mlx5e_stats_grp_channels_fill_strings+0x292/0x2e0
[mlx5_core]
[10047.576215,023]  mlx5e_stats_fill_strings+0x47/0x60 [mlx5_core]
[10047.578493,023]  dev_ethtool+0xe6f/0x2ad0
[10047.580700,023]  ? trace_hardirqs_on+0x19/0x60
[10047.582859,023]  ? try_charge_memcg+0x3b1/0x820
[10047.584984,023]  ? __alloc_pages+0x189/0x310
[10047.587049,023]  dev_ioctl+0x2c9/0x450
[10047.589046,023]  sock_do_ioctl+0xa1/0xf0
[10047.590979,023]  sock_ioctl+0x162/0x2b0
[10047.592842,023]  ? trace_hardirqs_on+0x19/0x60
[10047.594662,023]  ? count_memcg_events.constprop.0+0x44/0x50
[10047.596505,023]  ? handle_mm_fault+0x167/0x2c0
[10047.598327,023]  __x64_sys_ioctl+0x85/0xa0
[10047.600140,023]  do_syscall_64+0x35/0x80
[10047.601939,023]  entry_SYSCALL_64_after_hwframe+0x46/0xb0

From GDB, 'mlx5e_stats_grp_channels_fill_strings+0x292' is at line
2448 in MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
2413 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
2414 {
2415         bool is_xsk = priv->xsk.ever_used;
2416         int max_nch = priv->stats_nch;
2417         int i, j, tc;
2418
2419         for (i = 0; i < max_nch; i++)
2420                 for (j = 0; j < NUM_CH_STATS; j++)
2421                         sprintf(data + (idx++) * ETH_GSTRING_LEN,
2422                                 ch_stats_desc[j].format, i);
2423
2424         for (i = 0; i < max_nch; i++) {
2425                 for (j = 0; j < NUM_RQ_STATS; j++)
2426                         sprintf(data + (idx++) * ETH_GSTRING_LEN,
2427                                 rq_stats_desc[j].format, i);
2428                 for (j = 0; j < NUM_XSKRQ_STATS * is_xsk; j++)
2429                         sprintf(data + (idx++) * ETH_GSTRING_LEN,
2430                                 xskrq_stats_desc[j].format, i);
2431                 for (j = 0; j < NUM_RQ_XDPSQ_STATS; j++)
2432                         sprintf(data + (idx++) * ETH_GSTRING_LEN,
2433                                 rq_xdpsq_stats_desc[j].format, i);
2434         }
2435
2436         for (tc = 0; tc < priv->max_opened_tc; tc++)
2437                 for (i = 0; i < max_nch; i++)
2438                         for (j = 0; j < NUM_SQ_STATS; j++)
2439                                 sprintf(data + (idx++) * ETH_GSTRING_LEN,
2440                                         sq_stats_desc[j].format,
2441                                         i + tc * max_nch);
2442
2443         for (i = 0; i < max_nch; i++) {
2444                 for (j = 0; j < NUM_XSKSQ_STATS * is_xsk; j++)
2445                         sprintf(data + (idx++) * ETH_GSTRING_LEN,
2446                                 xsksq_stats_desc[j].format, i);
2447                 for (j = 0; j < NUM_XDPSQ_STATS; j++)
2448                         sprintf(data + (idx++) * ETH_GSTRING_LEN,
2449                                 xdpsq_stats_desc[j].format, i);
2450         }
2451
2452         return idx;
2453 }

'sprintf+0x56/0x70' is at line 3027 in sprintf()
3021 int sprintf(char *buf, const char *fmt, ...)
3022 {
3023         va_list args;
3024         int i;
3025
3026         va_start(args, fmt);
3027         i = vsnprintf(buf, INT_MAX, fmt, args);
3028         va_end(args);
3029
3030         return i;
3031 }
3032 EXPORT_SYMBOL(sprintf);


'vsnprintf+0x24e' is at line 2785 in vsnprintf()
2753 int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
2754 {
2755         unsigned long long num;
2756         char *str, *end;
2757         struct printf_spec spec = {0};
2758
2759         /* Reject out-of-range values early.  Large positive sizes are
2760            used for unknown buffer sizes. */
2761         if (WARN_ON_ONCE(size > INT_MAX))
2762                 return 0;
2763
2764         str = buf;
2765         end = buf + size;
2766
2767         /* Make sure end is always >= buf */
2768         if (end < buf) {
2769                 end = ((void *)-1);
2770                 size = end - buf;
2771         }
2772
2773         while (*fmt) {
2774                 const char *old_fmt = fmt;
2775                 int read = format_decode(fmt, &spec);
2776
2777                 fmt += read;
2778
2779                 switch (spec.type) {
2780                 case FORMAT_TYPE_NONE: {
2781                         int copy = read;
2782                         if (str < end) {
2783                                 if (copy > end - str)
2784                                         copy = end - str;
2785                                 memcpy(str, old_fmt, copy);
2786                         }
2787                         str += read;
2788                         break;
2789                 }

'RIP: 0010:memcpy_orig+0x104/0x110' is at line 164 in memcpy_orig() in
arch/x86/lib/memcpy_64.S
154 .Lless_3bytes:
155         subl $1, %edx
156         jb .Lend
157         /*
158          * Move data from 1 bytes to 3 bytes.
159          */
160         movzbl (%rsi), %ecx
161         jz .Lstore_1byte
162         movzbq 1(%rsi), %r8
163         movzbq (%rsi, %rdx), %r9
164         movb %r8b, 1(%rdi)
165         movb %r9b, (%rdi, %rdx)
166 .Lstore_1byte:
167         movb %cl, (%rdi)
168
169 .Lend:
170         RET
171 SYM_FUNC_END(memcpy_orig)

From assembly instructions and register values, it crashed at copying
the second byte from source. The first source byte is in %cl (it is
char 0x74 't') and the second source byte is in %r8b and %r9b (it is
char 0x78 'x'). It crashed accessing the second destination byte at
address ffffc90189cb6001. The source string is from
'xdpsq_stats_desc[j].format, i' with 'i' to fill the %d in string
format. Each string format is defined as:

2123 static const struct counter_desc xdpsq_stats_desc[] = {
2124         { MLX5E_DECLARE_XDPSQ_STAT(struct mlx5e_xdpsq_stats, xmit) },
2125         { MLX5E_DECLARE_XDPSQ_STAT(struct mlx5e_xdpsq_stats, mpwqe) },
2126         { MLX5E_DECLARE_XDPSQ_STAT(struct mlx5e_xdpsq_stats, inlnw) },
2127         { MLX5E_DECLARE_XDPSQ_STAT(struct mlx5e_xdpsq_stats, nops) },
2128         { MLX5E_DECLARE_XDPSQ_STAT(struct mlx5e_xdpsq_stats, full) },
2129         { MLX5E_DECLARE_XDPSQ_STAT(struct mlx5e_xdpsq_stats, err) },
2130         { MLX5E_DECLARE_XDPSQ_STAT(struct mlx5e_xdpsq_stats, cqes) },
2131 };

48 #define MLX5E_DECLARE_XDPSQ_STAT(type, fld) "tx%d_xdp_"#fld,
offsetof(type, fld)

So the source string is something like 'tx%d_xdp_"#fld, all possible
strings should be within 32 bytes.
In this panic, it looks like the source string is fine. We don't
understand how the destination buffer could get corrupted ? The
destination buffer size is calculated in
MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(channels)
2400 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(channels)
2401 {
2402         int max_nch = priv->stats_nch;
2403
2404         return (NUM_RQ_STATS * max_nch) +
2405                (NUM_CH_STATS * max_nch) +
2406                (NUM_SQ_STATS * max_nch * priv->max_opened_tc) +
2407                (NUM_RQ_XDPSQ_STATS * max_nch) +
2408                (NUM_XDPSQ_STATS * max_nch) +
2409                (NUM_XSKRQ_STATS * max_nch * priv->xsk.ever_used) +
2410                (NUM_XSKSQ_STATS * max_nch * priv->xsk.ever_used);
2411 }

Could either 'priv->stats_nch', 'priv->max_opened_tc' or
'priv->xsk.ever_used' change after buffer size calculation ? We're not
very familiar with the Mellanox driver code and wish to get some ideas
from you. Thanks!

