Return-Path: <netdev+bounces-55483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0AD80B057
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1EB20A3D
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E1A5AB84;
	Fri,  8 Dec 2023 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh50vvmS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EA810D2
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 15:01:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c236624edso27208645e9.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 15:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702076476; x=1702681276; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=od2ApstYQJZccWNtkSJt62s+ojm3R/X5pGCZkNeuf6M=;
        b=eh50vvmSRgZaRYTWLibU+TdI8h+MRJhH9ROl+6S+Lgd2gNZBrbx/NWRmPAEU/N5wmJ
         5gSqpXgL75l2pGfqKRfX0BPwszubk+3l9dPz8sPxsOeKIFVI397uSOcrnXLDeUISRxFc
         t9RP1jK8mFXeU1aoDS1us/283f0IIysjLJk9+yI67KsVb/tejNiyURZh5zSGywX4Pp09
         vQ9+FpzzT1xEgDL3rf/G4jPppuku1G61C5rV9FCheIU2KvG94mbDk2qhVVniMVmnlKtE
         0ogs8AQ+NwWPUH5MpN/9xbNVX1m7Sg1A+vdOKMaw+r/FU4mhXNKI0PYGd7HEfSAWvRi1
         2jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702076476; x=1702681276;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=od2ApstYQJZccWNtkSJt62s+ojm3R/X5pGCZkNeuf6M=;
        b=R+rce/R2+zYigLP86iIEpgK4F4lMZTb0DCk+ks8KgLNZ6hTgMFQvOukO1vukZw7aGh
         OMciWYB+u7pxV7RNesw1mxvm2lTLJAmKO/OGQ1O/IKZJQA93mFlQ7lRgvBDYEdDt9LVV
         1lQyUz+HiS9CALZH2F6XlRXl3MFzRYbz1vFn7xmLtLS9ed2yJokARuNzUUQcWygIjFWn
         Pn3GMzXy6eV7EriIRUqMl+2uqQbnpAiroQ2l1ZLNVVvUl22KLsM3llgfg9hJ/mNTTE0c
         3Uj09gTDIYOZS0H7lxqImHpjzmV/y4nJx5mCAesPMpGhCOT7BN6+R/W1TrDYRgQHAVPT
         w1oA==
X-Gm-Message-State: AOJu0YxLHHCLlz2qbLM1XI/qK6NApzolL+02LasMwYbj5p+aAGj+lRAB
	q9eew62WNV2hxUjymF8W8tQ=
X-Google-Smtp-Source: AGHT+IFCk962n+/NHp2aC9QcmNypY6ATu/gFtG9EKbO5RiKzOyElODpjnAEriWcJVS9hAa48MnQ/AQ==
X-Received: by 2002:a05:600c:181c:b0:40c:286e:d30e with SMTP id n28-20020a05600c181c00b0040c286ed30emr350270wmp.160.1702076476229;
        Fri, 08 Dec 2023 15:01:16 -0800 (PST)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c500a00b004094e565e71sm4183060wmr.23.2023.12.08.15.01.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2023 15:01:15 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <87lea4qqun.ffs@tglx>
Date: Sat, 9 Dec 2023 01:01:04 +0200
Cc: peterz@infradead.org,
 netdev <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com,
 Eric Dumazet <edumazet@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B5C19AE-C125-45A3-8C6F-CA6BBC01A6D9@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
 <D773F198-BCE3-4D43-9C27-2C2CA34062AC@gmail.com>
 <8E92BAA8-0FC6-4D29-BB4D-B6B60047A1D2@gmail.com>
 <5E63894D-913B-416C-B901-F628BB6C00E0@gmail.com> <87lea4qqun.ffs@tglx>
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Thomas,



> On 9 Dec 2023, at 0:20, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> On Thu, Dec 07 2023 at 00:38, Martin Zaharinov wrote:
>>> On 7 Dec 2023, at 0:26, Martin Zaharinov <micron10@gmail.com> wrote:
>>>=20
>>> in this line is :=20
>>>=20
>>>=20
>>>       /*
>>>        * If the reference count was already in the dead zone, then =
this
>>>        * put() operation is imbalanced. Warn, put the reference =
count back to
>>>        * DEAD and tell the caller to not deconstruct the object.
>>>        */
>>>       if (WARN_ONCE(cnt >=3D RCUREF_RELEASED, "rcuref - imbalanced =
put()")) {
>>>               atomic_set(&ref->refcnt, RCUREF_DEAD);
>>>               return false;
>>>       }
>=20
> So a rcuref_put() operation triggers the warning because the reference
> count is already dead, which means the rcuref_put() operation is
> imbalanced.
>=20
>>> [529520.875413] CPU: 13 PID: 0 Comm: swapper/13 Tainted: G           =
O       6.6.3 #1
>=20
> Can you reproduce this without the Out of Tree module?
Same error without Out of Tree modules. i try many time from kernel =
6.5.x to now.

>=20
>>> [529520.875653] RIP: 0010:rcuref_put_slowpath+0x5f/0x70
>>> [529520.878136]  dst_release+0x1c/0x40
>>> [529520.878229]  __dev_queue_xmit+0x594/0xcd0
>>> [529520.878324]  ? eth_header+0x25/0xc0
>>> [529520.878417]  ip_finish_output2+0x1a0/0x530
>>> [529520.878514]  process_backlog+0x107/0x210
>>> [529520.878610]  __napi_poll+0x20/0x180
>>> [529520.878702]  net_rx_action+0x29f/0x380
>>> [529520.878935]  __do_softirq+0xd0/0x202
>>> [529520.879033]  do_softirq+0x3a/0x50
>=20
> So this is one call chain triggering the issue...
>=20
>>>> report same problem with kernel 6.6.1 - i think problem is in rcu
>>>> but =E2=80=A6 if have options to add people from RCU here.
>=20
> That's definitely not a RCU problem. It's a simple refcount fail.
>=20
> Thanks,
>=20
>        tglx
>=20

Is this a problem or only simple fail , and is it possible to catch what =
is a problem and fix this fail.

m.=

