Return-Path: <netdev+bounces-151135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CC29ECF22
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9869B284C7E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E891A0AF7;
	Wed, 11 Dec 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Z/L4HIgm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C51494CC
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928902; cv=none; b=jmsOMLwfupuX/MrVX5D6mHJ20VAKleD7EOL8IgN49Po8JqyFGARJube9yyApe3SB7F1bJlhV8J2vj+of3GimKFWrUGTDc4X2YkMbZPRjI+PeiQCgfx3PD1H3+EgsbjYVd4Ae0s47W41R2IFVYNIY5wVEmh7VsWNJugn+F2D4NrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928902; c=relaxed/simple;
	bh=K6irQrUR4/osH5woIT4ZVPYkShKru4GUg1JJ29W8tv8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Oup53cQPZ4HubFNN2ZivtkQQLFfUoUMm/UlFunZFc3763YeHkePD8CqJZUfEEeAbgG4CqjCAs7iiuumW1CjHemjTjr2wtFIVDnGGeFXClU0pOPi4slxtVfBshBkTXStjGgDmwFzfepXM4yjrregER7tZep5xz6m2JbXqeORJu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Z/L4HIgm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725e71a11f7so654971b3a.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 06:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1733928899; x=1734533699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7I3KlEto23VWfQzA/+OahaA/mW3s4zBUhSTnL+g+LxQ=;
        b=Z/L4HIgm1aQ0HOSpWCKw/kjN8PLJ4q0G2d2viTeT4oyExwb2dS9Em2/3MYMXsEzwg7
         QlUsr6mMeuvUV0zaQaaA8vAPHFs2x1KvMzYu/JwxT5ouWaHqDp2TQthOZaotOXINNb//
         +A31ntFpF/BHJPlfyTnPAVTPlgpT6+M/rzn7CMwqISIxEW0p5cDPoLZtaqEkE/AMwdhn
         T1T+04kfbCic9mTCMoYILdosooJW/R6GEOrKkOYwjjdppNW8YvLDayVeL+HlY3Yo1o+6
         T+NzRPBncXNzuzg6VR9hFI0ZdcXchOaHH2sDHiVWvIDY1/NXabvE5fiLx7BybvAJvZYe
         NMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733928899; x=1734533699;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7I3KlEto23VWfQzA/+OahaA/mW3s4zBUhSTnL+g+LxQ=;
        b=YnQmO+SXMz495SFrnA8XpVDCrUMFDnsklAS0pYPby/8rSAKWBIvDbKeL9FKZ/Xc02A
         qIKq6DIoM5ncOam+hAGKsaVc1ATINwvJMiPbJU9LsaSqXcv3RKYabtYp3fD9K0iPFXbp
         FnHruVfaler4myVqRtQF8PeU24aAd5a16Jnw9+kRKVnJrpcUJXZBcgLRJtcn4jB25mk4
         ZRJOw2en0jg2Ih3mAAmadW+/DOr4KfiZw0hyRoUs5nx8/8K3c6565kmPh+pnXimYabi3
         x68/6xdHywEa0y2LEMYXeBQMxn6uivGDCLHcI2JSI1uR8A/AGeJDRykay7Gwxy7ViKn0
         ILbw==
X-Gm-Message-State: AOJu0Yy9Aa+Rk5OMEOBOHKTzWejq8djHgo/5qu1p/jYHfsRVHZsDnSFn
	H26STjX+z+vvsiQ6U/ffopui552+CHxxYaCnRa58QpSSEH45UnKO6aBW0H7K2Gd1RgGo4lShBTE
	H
X-Gm-Gg: ASbGncsIdahVgN+n9FbE19pY+6qU5Q6YOSHlhNvF7KQoYP+WzX8SyN2cyBbPGTcfZeU
	P+qNj1KNvxwokQnCpA8FIssphGWjg456R1GWl0TeS5oNyD5lW1wBPzIjBVrQnZB4I7et8VTnEP5
	UeIbpzag0XZtCGEtH8Lvm4XYeHm4o0/6l6TtXhRFasp4PeUdDs23FDS61Otnot3zoG6NWGXwnNa
	3oyEJE1sSlp6fRf3s6dG802TYmDcZCXcFfbiMA2MOCaCumiXjxXQ5bgiunW6LjdAvSIZwRaxXl4
	87vlYpcctOZdaqdT55AxNoDIFLu+G1Q=
X-Google-Smtp-Source: AGHT+IFooUIJKsFhrGKgjPsr08BC45elZjJ9h46au8wCZXoTnTA7fmOaLz5mZ9VZAhZcQmOoUZ0/PA==
X-Received: by 2002:a05:6a20:3d86:b0:1d8:c646:f51 with SMTP id adf61e73a8af0-1e1c27582e0mr5260589637.20.1733928899346;
        Wed, 11 Dec 2024 06:54:59 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd3277dc38sm7935316a12.54.2024.12.11.06.54.58
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 06:54:59 -0800 (PST)
Date: Wed, 11 Dec 2024 06:54:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 219589] New: Warning at net/ipv4/ipmr.c:440
Message-ID: <20241211065456.128f6a00@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Wed, 11 Dec 2024 12:44:55 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 219589] New: Warning at net/ipv4/ipmr.c:440


https://bugzilla.kernel.org/show_bug.cgi?id=219589

            Bug ID: 219589
           Summary: Warning at net/ipv4/ipmr.c:440
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: 0599jiangyc@gmail.com
        Regression: No

PoC (might not be stably reproduced):
```
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <endian.h>
#include <fcntl.h>
#include <sched.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#include <linux/sched.h>

#ifndef __NR_clone3
#define __NR_clone3 435
#endif
#ifndef __NR_seccomp
#define __NR_seccomp 317
#endif

static long syz_open_dev(volatile long a0, volatile long a1, volatile long a2)
{
  if (a0 == 0xc || a0 == 0xb) {
    char buf[128];
    sprintf(buf, "/dev/%s/%d:%d", a0 == 0xc ? "char" : "block", (uint8_t)a1,
            (uint8_t)a2);
    return open(buf, O_RDWR, 0);
  } else {
    char buf[1024];
    char* hash;
    strncpy(buf, (char*)a0, sizeof(buf) - 1);
    buf[sizeof(buf) - 1] = 0;
    while ((hash = strchr(buf, '#'))) {
      *hash = '0' + (char)(a1 % 10);
      a1 /= 10;
    }
    return open(buf, a2, 0);
  }
}

#define USLEEP_FORKED_CHILD (3 * 50 * 1000)

static long handle_clone_ret(long ret)
{
  if (ret != 0) {
    return ret;
  }
  usleep(USLEEP_FORKED_CHILD);
  syscall(__NR_exit, 0);
  while (1) {
  }
}

#define MAX_CLONE_ARGS_BYTES 256
static long syz_clone3(volatile long a0, volatile long a1)
{
  unsigned long copy_size = a1;
  if (copy_size < sizeof(uint64_t) || copy_size > MAX_CLONE_ARGS_BYTES)
    return -1;
  char clone_args[MAX_CLONE_ARGS_BYTES];
  memcpy(&clone_args, (void*)a0, copy_size);
  uint64_t* flags = (uint64_t*)&clone_args;
  *flags &= ~CLONE_VM;
  return handle_clone_ret((long)syscall(__NR_clone3, &clone_args, copy_size));
}

uint64_t r[2] = {0xffffffffffffffff, 0xffffffffffffffff};

int main(void)
{
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
          /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
          /*offset=*/0ul);
  const char* reason;
  (void)reason;
  intptr_t res = 0;
  if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {
  }
  *(uint64_t*)0x20000a00 = 0x40b86000;
  *(uint64_t*)0x20000a08 = 0;
  *(uint64_t*)0x20000a10 = 0;
  *(uint64_t*)0x20000a18 = 0;
  *(uint32_t*)0x20000a20 = 0x1d;
  *(uint64_t*)0x20000a28 = 0;
  *(uint64_t*)0x20000a30 = 0;
  *(uint64_t*)0x20000a38 = 0;
  *(uint64_t*)0x20000a40 = 0;
  *(uint64_t*)0x20000a48 = 0;
  *(uint32_t*)0x20000a50 = -1;
  syz_clone3(/*args=*/0x20000a00, /*size=*/0x58);
  *(uint16_t*)0x20000040 = 1;
  *(uint64_t*)0x20000048 = 0x20000080;
  *(uint16_t*)0x20000080 = 6;
  *(uint8_t*)0x20000082 = 4;
  *(uint8_t*)0x20000083 = 0;
  *(uint32_t*)0x20000084 = 0x7fff0000;
  syscall(__NR_seccomp, /*op=*/1ul, /*flags=*/0ul, /*arg=*/0x20000040ul);
  syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/3ul, /*proto=*/0);
  syscall(__NR_prlimit64, /*pid=*/0, /*res=RLIMIT_RTPRIO*/ 0xeul, /*new=*/0ul,
          /*old=*/0ul);
  *(uint64_t*)0x20000a00 = 0x40b86000;
  *(uint64_t*)0x20000a08 = 0;
  *(uint64_t*)0x20000a10 = 0;
  *(uint64_t*)0x20000a18 = 0;
  *(uint32_t*)0x20000a20 = 0x1d;
  *(uint64_t*)0x20000a28 = 0;
  *(uint64_t*)0x20000a30 = 0;
  *(uint64_t*)0x20000a38 = 0;
  *(uint64_t*)0x20000a40 = 0;
  *(uint64_t*)0x20000a48 = 0;
  *(uint32_t*)0x20000a50 = -1;
  syz_clone3(/*args=*/0x20000a00, /*size=*/0x58);
  res = -1;
  res = syz_open_dev(/*dev=*/0xc, /*major=*/4, /*minor=*/0x14);
  if (res != -1)
    r[0] = res;
  syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0x5608, 0);
  res = -1;
  res = syz_open_dev(/*dev=*/0xc, /*major=*/4, /*minor=*/0x15);
  if (res != -1)
    r[1] = res;
  *(uint16_t*)0x20000080 = 0x3e7f;
  *(uint64_t*)0x20000088 = 0x20000040;
  syscall(__NR_ioctl, /*fd=*/r[1], /*cmd=*/0x4b67, /*arg=*/0x20000080ul);
  return 0;
}
```

[  201.617435] ------------[ cut here ]------------
[  201.617808] WARNING: CPU: 3 PID: 2712  ipmrat
net/ipv4/ipmr.c:440_rules_exit.isra.0+0x10c/0x1a0
[  201.618094] Modules linked in:
[  201.618200] CPU: 3 UID: 0 PID: 2712 Comm: fused3844 Not tainted 6.13.0-rc1
#1
[  201.618423] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[  201.618682] RIP: 0010:ipmr_rules_exit.isra.0+0x10c/0x1a0
[  201.618829] Code: 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 7d 48
c7 03 00 00 00 00 5b 5d 41 5c 41 5d c3 cc cc cc cc e8 55 32 b7 fd 90 <0f> 0b 90
eb 99 e8 4a 32 b7 fd 0f b6 2d a9 fa 30 02 40 80 fd 01 0f
[  201.619438] RSP: 0000:ffff88810f0ff910 EFLAGS: 00010293
[  201.619667] RAX: 0000000000000000 RBX: ffff8881161d3320 RCX:
ffffffff8594d6fb
[  201.619922] RDX: ffff888108342dc0 RSI: 0000000000000004 RDI:
ffff8881161d2e44
[  201.620162] RBP: ffff88810afea000 R08: 0000000000000000 R09:
ffffed1022c3a5c9
[  201.620439] R10: ffffed1022c3a5c8 R11: ffff8881161d2e47 R12:
ffff8881161d2e44
[  201.620750] R13: ffff8881161d2dc0 R14: dffffc0000000000 R15:
fffffbfff0f58434
[  201.621079] FS:  000000000fc74880(0000) GS:ffff8881f1180000(0000)
knlGS:0000000000000000
[  201.621429] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  201.621701] CR2: 000000000048b6b0 CR3: 0000000111808000 CR4:
00000000000006f0
[  201.621960] Call Trace:
[  201.622067]  <TASK>
[  201.622145]  ? __warn+0xea/0x2b0
[  201.622305]  ? ipmr_rules_exit.isra.0+0x10c/0x1a0
[  201.622502]  ? report_bug+0x2cb/0x430
[  201.622645]  ? ipmr_rules_exit.isra.0+0x10c/0x1a0
[  201.622819]  ? ipmr_rules_exit.isra.0+0x10d/0x1a0
[  201.623008]  ? handle_bug+0x9b/0x110
[  201.623137]  ? exc_invalid_op+0x25/0x70
[  201.623364]  ? asm_exc_invalid_op+0x1a/0x20
[  201.623556]  ? ipmr_rules_exit.isra.0+0x10b/0x1a0
[  201.623774]  ? ipmr_rules_exit.isra.0+0x10c/0x1a0
[  201.623969]  ipmr_net_exit_batch+0x54/0xa0
[  201.624129]  ? __pfx_ipmr_net_exit_batch+0x10/0x10
[  201.624318]  ? __pfx_ipmr_net_exit+0x10/0x10
[  201.624489]  ops_exit_list.isra.0+0x102/0x150
[  201.624631]  setup_net+0x432/0x740
[  201.624725]  ? __pfx_setup_net+0x10/0x10
[  201.624831]  ? __pfx_down_read_killable+0x10/0x10
[  201.624977]  ? __kmalloc_cache_noprof+0x120/0x320
[  201.625121]  copy_net_ns+0x247/0x3d0
[  201.625236]  create_new_namespaces+0x382/0xa20
[  201.625377]  copy_namespaces+0x1d5/0x2d0
[  201.625510]  copy_process+0x2715/0x67a0
[  201.625649]  ? alloc_file_pseudo+0x130/0x1e0
[  201.625835]  ? sock_alloc_file+0x53/0x1d0
[  201.626009]  ? __pfx_copy_process+0x10/0x10
[  201.626143]  ? _copy_from_user+0x5a/0xa0
[  201.626285]  ? copy_clone_args_from_user+0x3c5/0x680
[  201.626487]  kernel_clone+0xc6/0x7a0
[  201.626604]  ? __pfx_kernel_clone+0x10/0x10
[  201.626781]  ? percpu_counter_add_batch+0x106/0x250
[  201.626989]  __do_sys_clone3+0x181/0x1f0
[  201.627149]  ? __pfx___do_sys_clone3+0x10/0x10
[  201.627333]  ? __secure_computing+0x16c/0x2c0
[  201.627509]  do_syscall_64+0xaa/0x1b0
[  201.627640]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  201.627815] RIP: 0033:0x44df9d
[  201.627926] Code: c3 e8 37 29 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
[  201.628542] RSP: 002b:00007ffdcf96c988 EFLAGS: 00000206 ORIG_RAX:
00000000000001b3
[  201.628845] RAX: ffffffffffffffda RBX: 0000000000400530 RCX:
000000000044df9d
[  201.629125] RDX: 0000000020000a00 RSI: 0000000000000058 RDI:
00007ffdcf96c9b0
[  201.629396] RBP: 00007ffdcf96cac0 R08: 0000000000000000 R09:
0000000000000058
[  201.629676] R10: 0000000000000000 R11: 0000000000000206 R12:
0000000000403380
[  201.629912] R13: 0000000000000000 R14: 00000000004c5018 R15:
0000000000000000
[  201.630159]  </TASK>
[  201.630274] ---[ end trace 0000000000000000 ]---

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

