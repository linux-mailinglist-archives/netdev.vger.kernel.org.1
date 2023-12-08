Return-Path: <netdev+bounces-55470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE32380AF9A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4851C20B19
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB28B59166;
	Fri,  8 Dec 2023 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uY4bAFKU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAVGDvtK"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A24310E0
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:20:03 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702074001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8jAcS2ppZ4k0tv8oAH166jXKDLK9pGQL2llNGvqKfA=;
	b=uY4bAFKUZFLWakieW/PAgNVjXvz3Uk23vueYEl5e8dxYVgJDdRYFPWENXeixdZ4Yh9aC3s
	9lKPhMlpQ5HhU4X+47KMnzTKqNzlSmNDRVerVKuVSa6ty6RZAhbSEzhFPFeq3/+S5MXZm+
	3mphO7JLeLP9YqZBXhPj0pO8F5cRsNm+YtAkuvuYqRDWcf38AuHuuPmQJztsxKJuTtziXP
	4/vGKp8Ao8x6+Biozw8jIdlS4UGnFIKhtvKpRPYELz4CCp4+TWCBKQQcZh+lhXWfPK9XGl
	2OoGY/CEaK6iHGAqw3F8Hrvb9WHCOePZHJtOV39cdMGT+EnzBojV3GtShBShTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702074001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8jAcS2ppZ4k0tv8oAH166jXKDLK9pGQL2llNGvqKfA=;
	b=RAVGDvtKiDiQr3HjNvacJRMMFY10zcWnfPQLkW/QPVR46ZPD57aQP/i0dljlMF+lyCnTj2
	RtVvrPWuSAmc+uCw==
To: Martin Zaharinov <micron10@gmail.com>, peterz@infradead.org
Cc: netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, kuba+netdrv@kernel.org,
 dsahern@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
In-Reply-To: <5E63894D-913B-416C-B901-F628BB6C00E0@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
 <D773F198-BCE3-4D43-9C27-2C2CA34062AC@gmail.com>
 <8E92BAA8-0FC6-4D29-BB4D-B6B60047A1D2@gmail.com>
 <5E63894D-913B-416C-B901-F628BB6C00E0@gmail.com>
Date: Fri, 08 Dec 2023 23:20:00 +0100
Message-ID: <87lea4qqun.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07 2023 at 00:38, Martin Zaharinov wrote:
>> On 7 Dec 2023, at 0:26, Martin Zaharinov <micron10@gmail.com> wrote:
>>=20
>> in this line is :=20
>>=20
>>=20
>>        /*
>>         * If the reference count was already in the dead zone, then this
>>         * put() operation is imbalanced. Warn, put the reference count b=
ack to
>>         * DEAD and tell the caller to not deconstruct the object.
>>         */
>>        if (WARN_ONCE(cnt >=3D RCUREF_RELEASED, "rcuref - imbalanced put(=
)")) {
>>                atomic_set(&ref->refcnt, RCUREF_DEAD);
>>                return false;
>>        }

So a rcuref_put() operation triggers the warning because the reference
count is already dead, which means the rcuref_put() operation is
imbalanced.

>> [529520.875413] CPU: 13 PID: 0 Comm: swapper/13 Tainted: G           O  =
     6.6.3 #1

Can you reproduce this without the Out of Tree module?

>> [529520.875653] RIP: 0010:rcuref_put_slowpath+0x5f/0x70
>> [529520.878136]  dst_release+0x1c/0x40
>> [529520.878229]  __dev_queue_xmit+0x594/0xcd0
>> [529520.878324]  ? eth_header+0x25/0xc0
>> [529520.878417]  ip_finish_output2+0x1a0/0x530
>> [529520.878514]  process_backlog+0x107/0x210
>> [529520.878610]  __napi_poll+0x20/0x180
>> [529520.878702]  net_rx_action+0x29f/0x380
>> [529520.878935]  __do_softirq+0xd0/0x202
>> [529520.879033]  do_softirq+0x3a/0x50

So this is one call chain triggering the issue...

>>> report same problem with kernel 6.6.1 - i think problem is in rcu
>>> but =E2=80=A6 if have options to add people from RCU here.

That's definitely not a RCU problem. It's a simple refcount fail.

Thanks,

        tglx


