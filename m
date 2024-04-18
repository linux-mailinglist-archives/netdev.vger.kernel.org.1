Return-Path: <netdev+bounces-88963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023A68A918B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 05:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D597B2119D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD2750263;
	Thu, 18 Apr 2024 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXKChITZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADCA4F5EC;
	Thu, 18 Apr 2024 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411045; cv=none; b=Egjc+dZEpdeG0wzlMQEtCJZo8X3prkfTT2TZifRcW6KVICK4dw0PcdYETbmhA6hDTu6xNcpUli42P47vshjMPdNcAkss0MT8z6p5qNSYfmUGPSIjG3/oQ5W+9QKbSLsfENPbGj330iduQ8ssngXGGIuhVfCLCa8WN+1uzd7hS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411045; c=relaxed/simple;
	bh=DCA4ZXGfA6CF2fRmBG48aqBKpyuyrXsqeWgyw2L4DBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBzOCFngbdT3+VKdmRx9ZyoEsA1QVR17mNpv+6g/OBFLtyGsdlVdaSegOr11+gWb1EIB8Ao4ut6twJYEFgp0lzYQr8vcLu7xFmq9Qh3CJ555DURXoEV41V7lI8fUM+9xzn1+TODTBPUae3g89vOPGMdbgfRn9sYm5JrDG64GuVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXKChITZ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a526d381d2fso264752466b.0;
        Wed, 17 Apr 2024 20:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713411040; x=1714015840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxhTyKTIE0qzJxTrsheENDHgXb5i9dLfwKH5M/LulNs=;
        b=JXKChITZq54ScND8V1QSFSO6GAlMTI2GK0F7Q6en48PQH6INBGFDcQadaAJmc4yYJQ
         SK1wd7sWtO7cuYIxG8/QiDKXOEC3FVS0uSFhS9lKf8zVroyawGKFQ0zOMxjytBctBNF4
         UFpXlFpx8t+fRaNN2MBzy+Yaiu1gQHuFg6QOhUsAvMoU5APP5E8NDK44KN7tj1qsXCpB
         IIdPhFpnIvthTQsT/A3A0tqWh+ZUQyEDiVcBWAn3TpFU50mXVPK/udLYP0cprHFkIHcz
         zGqWOJi1Va7AcmAYDbI/aMoIhf+k7phUWRtA2CHvcuARpNVaw9AUPRto1IctfkdGVyVM
         /TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713411040; x=1714015840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxhTyKTIE0qzJxTrsheENDHgXb5i9dLfwKH5M/LulNs=;
        b=tuInIPHS2MiEK1VLBz4JFnOKMFY2HXnN2wBg/hQx7U+PzgdyXQjn1LZfGsfXil+5t5
         OmxYWsx1Pv7rA1Tl0knk0iBxGniRk49Pm6GJqZ1NzMtRifZOV6gYtnYPM7oIMhx+4r3M
         oscCJZBN8j7563/8VeTLMkuFV7RsWiG1rRjGqOtEckKF188GTDW32A5UWF5+3qpvlLnt
         U9c4g2ZzAToh1jh67UHVce6vo3/z1YDhSUdXWMO40RUI9Nh7s6J4wrRP93BlQWBJ8Gep
         WCZu+9PljZTtEkIN91X+49OzfWjXtX6kPSz9qiehr7H5Hw9ditYGbarlcxpstJ+xWD5Y
         J7JA==
X-Forwarded-Encrypted: i=1; AJvYcCWavmhrtx+SaSEKllkJSlF7OpG+rClhDzJ5I6jUbn8WY1Xn9+zRaXUv9Z07VBU2DuPn65R0kChmBBPyjCx1HpLq3vk+2Usv5AaJ9McLjMD2bfa2sROq1nXqqGghA92Bz3IvrL9sXHyfKMAU
X-Gm-Message-State: AOJu0Yxo4lQjJt4B9m9vBvlEC8IbRonIsLkkSyuX+hfkMLIeL3NjZjLh
	O8BJrdtvYapJR8ilD2O3yZ1RDW+Ty3dbTzYV1y6lJFUrhdU7ByEEKqglKzJOPCOW4HAJERuAd89
	TPUBKknAQmvKpHxpnzF52VG9T0ABadvWhqv8=
X-Google-Smtp-Source: AGHT+IHIXEmxxBrJTy9464N8x83VfqQQwELj66FQKhLRL51cqDV42VJTFPlEdcZJ6x4RQa4TVQPrGaadlUpan2ko3zc=
X-Received: by 2002:a17:906:161a:b0:a52:3984:148f with SMTP id
 m26-20020a170906161a00b00a523984148fmr686853ejd.36.1713411040348; Wed, 17 Apr
 2024 20:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240417085143.69578-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 18 Apr 2024 11:30:02 +0800
Message-ID: <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 4:51=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In production, there are so many cases about why the RST skb is sent but
> we don't have a very convenient/fast method to detect the exact underlyin=
g
> reasons.
>
> RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
> and active kind (like tcp_send_active_reset()). The former can be traced
> carefully 1) in TCP, with the help of drop reasons, which is based on
> Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
> RFC 8684. The latter is relatively independent, which should be
> implemented on our own.
>
> In this series, I focus on the fundamental implement mostly about how
> the rstreason mechnism works and give the detailed passive part as an
> example, not including the active reset part. In future, we can go
> further and refine those NOT_SPECIFIED reasons.
>
> Here are some examples when tracing:
> <idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
>         skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNOT_SPECIFIED
> <idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
>         skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNO_SOCKET
>
> [1]
> Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10Q=
N2WBdr+X4k=3Dw@mail.gmail.com/
>
> v6
> 1. add back casts, or else they are treated as error.
>
> v5
> Link: https://lore.kernel.org/all/20240411115630.38420-1-kerneljasonxing@=
gmail.com/
> 1. address format issue (like reverse xmas tree) (Eric, Paolo)
> 2. remove unnecessary casts. (Eric)
> 3. introduce a helper used in mptcp active reset. See patch 6. (Paolo)
>
> v4
> Link: https://lore.kernel.org/all/20240409100934.37725-1-kerneljasonxing@=
gmail.com/
> 1. passing 'enum sk_rst_reason' for readability when tracing (Antoine)
>
> v3
> Link: https://lore.kernel.org/all/20240404072047.11490-1-kerneljasonxing@=
gmail.com/
> 1. rebase (mptcp part) and address what Mat suggested.
>
> v2
> Link: https://lore.kernel.org/all/20240403185033.47ebc6a9@kernel.org/
> 1. rebase against the latest net-next tree
>
>
>
> Jason Xing (7):
>   net: introduce rstreason to detect why the RST is sent
>   rstreason: prepare for passive reset
>   rstreason: prepare for active reset
>   tcp: support rstreason for passive reset
>   mptcp: support rstreason for passive reset
>   mptcp: introducing a helper into active reset logic
>   rstreason: make it work in trace world
>
>  include/net/request_sock.h |  4 +-
>  include/net/rstreason.h    | 93 ++++++++++++++++++++++++++++++++++++++
>  include/net/tcp.h          |  3 +-
>  include/trace/events/tcp.h | 37 +++++++++++++--
>  net/dccp/ipv4.c            | 10 ++--
>  net/dccp/ipv6.c            | 10 ++--
>  net/dccp/minisocks.c       |  3 +-
>  net/ipv4/tcp.c             | 15 ++++--
>  net/ipv4/tcp_ipv4.c        | 14 +++---
>  net/ipv4/tcp_minisocks.c   |  3 +-
>  net/ipv4/tcp_output.c      |  5 +-
>  net/ipv4/tcp_timer.c       |  9 ++--
>  net/ipv6/tcp_ipv6.c        | 17 ++++---
>  net/mptcp/protocol.c       |  2 +-
>  net/mptcp/protocol.h       | 11 +++++
>  net/mptcp/subflow.c        | 27 ++++++++---
>  16 files changed, 216 insertions(+), 47 deletions(-)
>  create mode 100644 include/net/rstreason.h
>
> --
> 2.37.3
>

Hello maintainers,

I'm not sure why the patch series has been changed to 'Changes
Requested', until now I don't think I need to change something.

Should I repost this series (keeping the v6 tag) and then wait for
more comments?

Thanks,
Jason

