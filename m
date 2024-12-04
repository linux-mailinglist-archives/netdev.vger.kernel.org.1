Return-Path: <netdev+bounces-148931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9319E3810
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60CECB33429
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDABF1B0F0A;
	Wed,  4 Dec 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RSaOtjdB"
X-Original-To: netdev@vger.kernel.org
Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [178.154.239.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7C1B140D
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309712; cv=none; b=eW4HyiAn4mGgyt4+/Ye+3xJKvTyd4/NMmJ/NyE8ja7ADuUvS8bs0u7HKa8OsFfAAl5Z7gAXjmA9XY7ReK3uBCMxv2P6k9bQDFJphbkAJ1KvXNu73Zjbu2IwHy0h8CHmtEW+Ux5oppa+fpTMMgnMi95lxRvicEctHBI8XnAhQT/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309712; c=relaxed/simple;
	bh=mGjmol7mtj75oQcPC+Gs7G/orwGpufLqFDaiyl/+OTs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QlH48qcZjDgv55vrs202XGqWPcGFhwD7wmI6nPrJs4olBjoMFDC/Z6nn2bIMjNKk89QkfRklqpIoVXlSfOHxTHp+vtChSlo2p2uXlNeXaddcSMHuTwvsgwftx81IhNv3ltkSseAj0owhycOvbE5Ur/XnEOBGl/IeqRgYOrsk6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=RSaOtjdB; arc=none smtp.client-ip=178.154.239.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward204a.mail.yandex.net (Yandex) with ESMTPS id 33F72693A5
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 13:47:21 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:2f03:0:640:5d54:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id E8A464737E;
	Wed,  4 Dec 2024 13:47:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 9ldGNK4OqOs0-G0Ag3KJd;
	Wed, 04 Dec 2024 13:47:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1733309231; bh=hXlp3UDedban6VzaEZLEg5Zqkta80zn1WVvsYI3JLHg=;
	h=Subject:To:From:Cc:Date:Message-ID;
	b=RSaOtjdBvQiEFk8TbyQX4qErVw6x04FP+mLb6KhHi3phBBqKD9bhv0dqskLEnNd6B
	 X5vuD8TQkkpJCuwklIEqg9qUQ9Tt4HKW+UDR8e0O3Qh9cDFkvGmtfVKBP5kUP74JUA
	 JDid9q7XYrLVaf7i+vObXaZeNrSRJ652iN1Q9/bc=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <99b9f7b6-0be5-445a-8bac-1d3f5d67a818@yandex.ru>
Date: Wed, 4 Dec 2024 13:47:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-MW
To: Yuqi Jin <jinyuqi@huawei.com>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
From: Dmitry Antipov <dmantipov@yandex.ru>
Subject: On a6211caa634d ("net: revert "net: get rid of an,signed integer
 overflow in ip_idents_reserve()")
Autocrypt: addr=dmantipov@yandex.ru; keydata=
 xsDNBGBYjL8BDAC1iFIjCNMSvYkyi04ln+5sTl5TCU9O5Ot/kaKKCstLq3TZ1zwsyeqF7S/q
 vBVSmkWHQaj80BlT/1m7BnFECMNV0M72+cTGfrX8edesMSzv/id+M+oe0adUeA07bBc2Rq2V
 YD88b1WgIkACQZVFCo+y7zXY64cZnf+NnI3jCPRfCKOFVwtj4OfkGZfcDAVAtxZCaksBpTHA
 tf24ay2PmV6q/QN+3IS9ZbHBs6maC1BQe6clFmpGMTvINJ032oN0Lm5ZkpNN+Xcp9393W34y
 v3aYT/OuT9eCbOxmjgMcXuERCMok72uqdhM8zkZlV85LRdW/Vy99u9gnu8Bm9UZrKTL94erm
 0A9LSI/6BLa1Qzvgwkyd2h1r6f2MVmy71/csplvaDTAqlF/4iA4TS0icC0iXDyD+Oh3EfvgP
 iEc0OAnNps/SrDWUdZbJpLtxDrSl/jXEvFW7KkW5nfYoXzjfrdb89/m7o1HozGr1ArnsMhQC
 Uo/HlX4pPHWqEAFKJ5HEa/0AEQEAAc0kRG1pdHJ5IEFudGlwb3YgPGRtYW50aXBvdkB5YW5k
 ZXgucnU+wsEJBBMBCAAzFiEEgi6CDXNWvLfa6d7RtgcLSrzur7cFAmYEXUsCGwMFCwkIBwIG
 FQgJCgsCBRYCAwEAAAoJELYHC0q87q+3ghQL/10U/CvLStTGIgjRmux9wiSmGtBa/dUHqsp1
 W+HhGrxkGvLheJ7KHiva3qBT++ROHZxpIlwIU4g1s6y3bqXqLFMMmfH1A+Ldqg1qCBj4zYPG
 lzgMp2Fjc+hD1oC7k7xqxemrMPstYQKPmA9VZo4w3+97vvnwDNO7iX3r0QFRc9u19MW36wq8
 6Yq/EPTWneEDaWFIVPDvrtIOwsLJ4Bu8v2l+ejPNsEslBQv8YFKnWZHaH3o+9ccAcgpkWFJg
 Ztj7u1NmXQF2HdTVvYd2SdzuJTh3Zwm/n6Sw1czxGepbuUbHdXTkMCpJzhYy18M9vvDtcx67
 10qEpJbe228ltWvaLYfHfiJQ5FlwqNU7uWYTKfaE+6Qs0fmHbX2Wlm6/Mp3YYL711v28b+lp
 9FzPDFqVPfVm78KyjW6PcdFsKu40GNFo8gFW9e8D9vwZPJsUniQhnsGF+zBKPeHi/Sb0DtBt
 enocJIyYt/eAY2hGOOvRLDZbGxtOKbARRwY4id6MO4EuSs7AzQRgWIzAAQwAyZj14kk+OmXz
 TpV9tkUqDGDseykicFMrEE9JTdSO7fiEE4Al86IPhITKRCrjsBdQ5QnmYXcnr3/9i2RFI0Q7
 Evp0gD242jAJYgnCMXQXvWdfC55HyppWazwybDiyufW/CV3gmiiiJtUj3d8r8q6laXMOGky3
 7sRlv1UvjGyjwOxY6hBpB2oXdbpssqFOAgEw66zL54pazMOQ6g1fWmvQhUh0TpKjJZRGF/si
 b/ifBFHA/RQfAlP/jCsgnX57EOP3ALNwQqdsd5Nm1vxPqDOtKgo7e0qx3sNyk05FFR+f9px6
 eDbjE3dYfsicZd+aUOpa35EuOPXS0MC4b8SnTB6OW+pmEu/wNzWJ0vvvxX8afgPglUQELheY
 +/bH25DnwBnWdlp45DZlz/LdancQdiRuCU77hC4fnntk2aClJh7L9Mh4J3QpBp3dh+vHyESF
 dWo5idUSNmWoPwLSYQ/evKynzeODU/afzOrDnUBEyyyPTknDxvBQZLv0q3vT0UiqcaL7ABEB
 AAHCwPYEGAEIACAWIQSCLoINc1a8t9rp3tG2BwtKvO6vtwUCZgRdSwIbDAAKCRC2BwtKvO6v
 t9sFC/9Ga7SI4CaIqfkye1EF7q3pe+DOr4NsdsDxnPiQuG39XmpmJdgNI139TqroU5VD7dyy
 24YjLTH6uo0+dcj0oeAk5HEY7LvzQ8re6q/omOi3V0NVhezdgJdiTgL0ednRxRRwNDpXc2Zg
 kg76mm52BoJXC7Kd/l5QrdV8Gq5WJbLA9Kf0pTr1QEf44bVR0bajW+0Lgyb7w4zmaIagrIdZ
 fwuYZWso3Ah/yl6v1//KP2ppnG0d9FGgO9iz576KQZjsMmQOM7KYAbkVPkZ3lyRJnukrW6jC
 bdrQgBsPubep/g9Ulhkn45krX5vMbP3wp1mJSuNrACQFbpJW3t0Da4DfAFyTttltVntr/ljX
 5TXWnMCmaYHDS/lP20obHMHW1MCItEYSIn0c5DaAIfD+IWAg8gn7n5NwrMj0iBrIVHBa5mRp
 KkzhwiUObL7NO2cnjzTQgAVUGt0MSN2YfJwmSWjKH6uppQ7bo4Z+ZEOToeBsl6waJnjCL38v
 A/UwwXBRuvydGV0=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Could you please (re)consider a6211caa634d ("net: revert "net: get rid of an
signed integer overflow in ip_idents_reserve()") one more time? With clang
19.1.4 as distributed by LLVM project:

clang version 19.1.4 (/home/runner/work/llvm-project/llvm-project/clang aadaa00de76ed0c4987b97450dd638f63a385bed)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/antipov/.local/LLVM-19.1.4-Linux-X64/bin

I've hit the following UBSAN warning on 6.13.0-rc1:

UBSAN: signed-integer-overflow in ./arch/x86/include/asm/atomic.h:85:11
1584476935 + 1988933977 cannot be represented in type 'int'
CPU: 2 UID: 0 PID: 169 Comm: kworker/u17:5 Not tainted 6.13.0-rc1-00026-gd7fa4bf3dc47-dirty #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
Call Trace:
  <TASK>
  dump_stack_lvl+0x1c2/0x2a0
  ? __pfx_dump_stack_lvl+0x10/0x10
  ? __pfx__printk+0x10/0x10
  ? __asan_memset+0x22/0x50
  handle_overflow+0x1d0/0x210
  __ip_select_ident+0x323/0x360
  iptunnel_xmit+0x55e/0xa00
  udp_tunnel_xmit_skb+0x264/0x3c0
  send4+0x7d2/0xbd0
  ? send4+0x1d8/0xbd0
  ? __pfx_send4+0x10/0x10
  ? wg_socket_send_buffer_to_peer+0x13b/0x1c0
  wg_socket_send_skb_to_peer+0xd1/0x1d0
  wg_packet_handshake_send_worker+0x1dc/0x320
  ? __pfx_wg_packet_handshake_send_worker+0x10/0x10
  ? _raw_spin_unlock_irq+0x23/0x50
  ? process_scheduled_works+0x976/0x1700
  ? process_scheduled_works+0x976/0x1700
  process_scheduled_works+0xa56/0x1700
  ? __pfx_process_scheduled_works+0x10/0x10
  ? assign_work+0x3d0/0x440
  worker_thread+0x8be/0xe30
  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
  ? _raw_spin_unlock_irqrestore+0xae/0x110
  ? __kthread_parkme+0x7b/0x1c0
  kthread+0x2c6/0x360
  ? __pfx_worker_thread+0x10/0x10
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x4e/0x80
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Command line is:

clang -E -D__GENKSYMS__ -Wp,-MMD,net/ipv4/.route.o.d -nostdinc -I./arch/x86/include -I./arch/x86/include/generated -I./include -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi 
-I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ 
--target=x86_64-linux-gnu -fintegrated-as -Werror=unknown-warning-option -Werror=ignored-optimization-argument -Werror=option-ignored -Werror=unused-command-line-argument -Wundef -DKBUILD_EXTRA_WARN1 
-std=gnu11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -fcf-protection=branch -fno-jump-tables -m64 -falign-loops=1 
-mno-80387 -mno-fp-ret-in-387 -mstack-alignment=8 -mskip-rax-setup -march=core2 -mno-red-zone -mcmodel=kernel -Wno-sign-compare -fno-asynchronous-unwind-tables -mretpoline-external-thunk 
-mindirect-branch-cs-prefix -mfunction-return=thunk-extern -fpatchable-function-entry=16,16 -fno-delete-null-pointer-checks -O2 -fstack-protector-strong -fomit-frame-pointer 
-ftrivial-auto-var-init=zero -fno-stack-clash-protection -falign-functions=16 -fstrict-flex-arrays=3 -fno-strict-overflow -fno-stack-check -Wall -Wundef -Werror=implicit-function-declaration 
-Werror=implicit-int -Werror=return-type -Werror=strict-prototypes -Wno-format-security -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wmissing-declarations -Wmissing-prototypes 
-Wframe-larger-than=2048 -Wno-gnu -Wvla -Wno-pointer-sign -Wcast-function-type -Wimplicit-fallthrough -Werror=date-time -Werror=incompatible-pointer-types -Wextra -Wunused -Wmissing-format-attribute 
-Wmissing-include-dirs -Wunused-const-variable -Wno-missing-field-initializers -Wno-type-limits -Wno-shift-negative-value -Wno-sign-compare -Wno-unused-parameter -g -gdwarf-4 
-fsanitize=kernel-address -mllvm -asan-mapping-offset=0xdffffc0000000000  -mllvm -asan-instrumentation-with-call-threshold=10000  -mllvm -asan-stack=1    -mllvm -asan-globals=1  -mllvm 
-asan-kernel-mem-intrinsic-prefix=1  -fsanitize=array-bounds -fsanitize=shift  -fsanitize=signed-integer-overflow  -fsanitize-coverage=trace-pc -fsanitize-coverage=trace-cmp 
-DKBUILD_MODFILE='"net/ipv4/route"' -DKBUILD_BASENAME='"route"' -DKBUILD_MODNAME='"route"' -D__KBUILD_MODNAME=kmod_route net/ipv4/route.c

Dmitry

