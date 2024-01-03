Return-Path: <netdev+bounces-61292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610E982317B
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 17:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CDC1F2183D
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170101BDE3;
	Wed,  3 Jan 2024 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gi37A/ul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609331BDD7
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so15298a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 08:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704300532; x=1704905332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwG9HX193zcul4Wmtz8zp7AV7BBeX0A+AyCgZzYpGkw=;
        b=gi37A/uleuL71m/DCPAFNDkmliC0/j5O+1DZUoOltpdnBuenaRJ65yjFB6JoMMwOdc
         Cl3jCe1VzWeybbAT+CYJrfHvfpk4eumwqBCjCE1DyQAgJVewWt0y3dBieOvPF05pHtgp
         RXr7EAFwBlDCWxlfMT0LlCfn1UhV4jigcsijk+SznXyg4kEH0X2aOn3zpwTy8ZHOHG8U
         +sMW7FZ5PTFeVc1orNXiRrA6/6oXaxGPrLi02D+Go07GxF030lHE2OE4oFNThcRoH5cO
         Y6KY4kZ9rgpCnFaskOZUiussR2/IWOAkcSanw+WIAiArHuz3NHgAA4ZNbnjcem/vZt9b
         fqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300532; x=1704905332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwG9HX193zcul4Wmtz8zp7AV7BBeX0A+AyCgZzYpGkw=;
        b=XTZRbEISbzlKIAdrmiiy8hJFM6bNCxCdv7ViJgO7G+7emaA64HNCi4fY6kL1ayuew1
         9BHYfzKPmUPwiKev6UZ7VZt1VfHWeTpO+afxq+jjmPSRO/yvwpUg27pVtCP93Ge+cHoW
         wDtQ3A/n96J4CjkvP5tvIRmKU7F/zKFGpmubiHOJBX2rDu9Jl5Cuy55BE4WMlrVWif+Q
         AqvzWtjax7DL6ef81ekh6jvl55OY06PPxyvqsRw0r87GcCD1Pzp9dxHljJBWWbhSUXu/
         BjJoxN1WoC1/YgR1Mhfj24BVm8VroAx6A/Lt858M31H/k4d7eMqnqOU163JcZ/+cmGNj
         bKTw==
X-Gm-Message-State: AOJu0Yy2I74xzrVZUmY7wUf5CsXsGjdZO1F2n6ESKyuc96DzAvcLOQO3
	WiObU9lDCDDlypUstdYGpRGe5ZKuhMpg2Sgy9me2bpRFzLyf
X-Google-Smtp-Source: AGHT+IEhlLK5GHC7JOo9W8X8/ahFA76QG9n497fip3r2qItyokhbPItXFx1gVI+XHckyQpjlApHO9fl/VLE3A5RsmDc=
X-Received: by 2002:a50:9f49:0:b0:553:a452:864 with SMTP id
 b67-20020a509f49000000b00553a4520864mr139218edf.3.1704300532412; Wed, 03 Jan
 2024 08:48:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214192939.1962891-1-edumazet@google.com> <87sf3e8ppa.fsf@cloudflare.com>
In-Reply-To: <87sf3e8ppa.fsf@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jan 2024 17:48:41 +0100
Message-ID: <CANn89i+jYSfpeZGT94DDc5vcuHouyfaq+ZWu6eE3dJGykpgZVw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp/dccp: refine source port selection
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 3:19=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> On Thu, Dec 14, 2023 at 07:29 PM GMT, Eric Dumazet wrote:
> > This patch series leverages IP_LOCAL_PORT_RANGE option
> > to no longer favor even source port selection at connect() time.
> >
> > This should lower time taken by connect() for hosts having
> > many active connections to the same destination.
> >
> > Eric Dumazet (2):
> >   inet: returns a bool from inet_sk_get_local_port_range()
> >   tcp/dccp: change source port selection at connect() time
> >
> >  include/net/ip.h                |  2 +-
> >  net/ipv4/inet_connection_sock.c | 21 ++++++++++++++++-----
> >  net/ipv4/inet_hashtables.c      | 27 ++++++++++++++++-----------
> >  3 files changed, 33 insertions(+), 17 deletions(-)
>
> This is great. Thank you.
>
> # sysctl net.ipv4.ip_local_port_range
> net.ipv4.ip_local_port_range =3D 32768    60999
> # { sleep 3; stress-ng --sockmany 1 --sockmany-ops 20000; } & \
> > /usr/share/bcc/tools/funclatency inet_hash_connect
> [1] 240
> Tracing 1 functions for "inet_hash_connect"... Hit Ctrl-C to end.
> stress-ng: info:  [243] defaulting to a 1 day, 0 secs run per stressor
> stress-ng: info:  [243] dispatching hogs: 1 sockmany
> stress-ng: info:  [243] skipped: 0
> stress-ng: info:  [243] passed: 1: sockmany (1)
> stress-ng: info:  [243] failed: 0
> stress-ng: info:  [243] metrics untrustworthy: 0
> stress-ng: info:  [243] successful run completed in 27.60 secs
> ^C
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                    =
    |
>          2 -> 3          : 0        |                                    =
    |
>          4 -> 7          : 0        |                                    =
    |
>          8 -> 15         : 0        |                                    =
    |
>         16 -> 31         : 0        |                                    =
    |
>         32 -> 63         : 0        |                                    =
    |
>         64 -> 127        : 0        |                                    =
    |
>        128 -> 255        : 0        |                                    =
    |
>        256 -> 511        : 0        |                                    =
    |
>        512 -> 1023       : 511      |**                                  =
    |
>       1024 -> 2047       : 8698     |************************************=
****|
>       2048 -> 4095       : 2870     |*************                       =
    |
>       4096 -> 8191       : 1471     |******                              =
    |
>       8192 -> 16383      : 389      |*                                   =
    |
>      16384 -> 32767      : 114      |                                    =
    |
>      32768 -> 65535      : 43       |                                    =
    |
>      65536 -> 131071     : 15       |                                    =
    |
>     131072 -> 262143     : 0        |                                    =
    |
>     262144 -> 524287     : 1        |                                    =
    |
>     524288 -> 1048575    : 1        |                                    =
    |
>    1048576 -> 2097151    : 3        |                                    =
    |
>    2097152 -> 4194303    : 1609     |*******                             =
    |
>    4194304 -> 8388607    : 4272     |*******************                 =
    |
>    8388608 -> 16777215   : 4        |                                    =
    |
>
> avg =3D 1314821 nsecs, total: 26297744706 nsecs, count: 20001
>
> Detaching...
> [1]+  Done                    { sleep 3; stress-ng --sockmany 1 --sockman=
y-ops 20000; }
> # { sleep 3; LD_PRELOAD=3D./setsockopt_ip_local_port_range.so stress-ng -=
-sockmany 1 --sockmany-ops 20000; } & \
> > /usr/share/bcc/tools/funclatency inet_hash_connect
> [1] 246
> Tracing 1 functions for "inet_hash_connect"... Hit Ctrl-C to end.
> stress-ng: info:  [249] defaulting to a 1 day, 0 secs run per stressor
> stress-ng: info:  [249] dispatching hogs: 1 sockmany
> stress-ng: info:  [249] skipped: 0
> stress-ng: info:  [249] passed: 1: sockmany (1)
> stress-ng: info:  [249] failed: 0
> stress-ng: info:  [249] metrics untrustworthy: 0
> stress-ng: info:  [249] successful run completed in 1.01 secs
> ^C
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                    =
    |
>          2 -> 3          : 0        |                                    =
    |
>          4 -> 7          : 0        |                                    =
    |
>          8 -> 15         : 0        |                                    =
    |
>         16 -> 31         : 0        |                                    =
    |
>         32 -> 63         : 0        |                                    =
    |
>         64 -> 127        : 0        |                                    =
    |
>        128 -> 255        : 0        |                                    =
    |
>        256 -> 511        : 0        |                                    =
    |
>        512 -> 1023       : 2085     |******                              =
    |
>       1024 -> 2047       : 13401    |************************************=
****|
>       2048 -> 4095       : 3877     |***********                         =
    |
>       4096 -> 8191       : 561      |*                                   =
    |
>       8192 -> 16383      : 60       |                                    =
    |
>      16384 -> 32767      : 16       |                                    =
    |
>      32768 -> 65535      : 2        |                                    =
    |
>
> avg =3D 1768 nsecs, total: 35376609 nsecs, count: 20002
>
> Detaching...
> [1]+  Done                    { sleep 3; LD_PRELOAD=3D./setsockopt_ip_loc=
al_port_range.so stress-ng --sockmany 1 --sockmany-ops 20000; }
> # cat ./setsockopt_ip_local_port_range.c
> #include <dlfcn.h>
> #include <linux/in.h>
> #include <sys/socket.h>
>
> int socket(int domain, int type, int protocol)
> {
>         int (*socket_fn)(int, int, int) =3D dlsym(RTLD_NEXT, "socket");
>         int fd;
>
>         fd =3D socket_fn(domain, type, protocol);
>         if (fd < 0)
>                 return -1;
>
>         if (domain =3D=3D AF_INET || domain =3D=3D AF_INET6) {
>                 setsockopt(fd, IPPROTO_IP, IP_LOCAL_PORT_RANGE,
>                            &(__u32){ 0xffffU << 16 }, sizeof(__u32));
>         }
>
>         return fd;
> }
> #

Nice tests, thanks for them !

