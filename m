Return-Path: <netdev+bounces-193957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5306AC69E9
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA0F7A2770
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684E62857E9;
	Wed, 28 May 2025 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2hOF5uy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3099246774
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437191; cv=none; b=uE33N7VVJTgktLrnKucy5Ek+pkpdmrS2bYI7zBwkZ18zI+Ze2Y5tTRmgTkC9cXvtAvmuaNpiBdrqK4obireKf1/kRsZrbsgtMuZuXRx0QmV7yIYL7smRumamarD7P760P1QwnFp2iNssWt2xDDSHwUtAR3T4Uuqw7TS40v73A8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437191; c=relaxed/simple;
	bh=C0NmBaW0ATR+BjEQEZWGSFa+sfjvBIIHXFfmCizBQV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUqLop4wD75a1pCaIIsBrKPwaSeWoXs07XSdI0p8H7Qf5XtP816DktMzQRy5ogdttSaCBh+jYycJaRlvrntclVSeI9HLrIBTi2AeJRvyxHwePKd9vC0dy8ombE7WUlcDvJNP8YL9QgaarTrUlzwqNtD1AOqswRu2qF6KPEa6tSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2hOF5uy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47691d82bfbso86046791cf.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748437188; x=1749041988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh3KYFguc08WUp3HQG/e3NOwLqhhclGw8CBRTTOw3xk=;
        b=E2hOF5uyCYaFXLK3QY9yHNIuPk9SUOYJMKyVoeum8fZWf28pRvz+yGCaCAh0uTmMP1
         XazinLmHV98caDDOhInckm9MLVURIyaxdQrGOtS71bmbeZ/TovcclOODD6hY0XeprTrl
         hn0jKnv9mLhw0fuYbKWlSyJ45qlThQJEYEX4yan3lbhf8VcGNZiCvstgvJH5HvjH9hSi
         LLVXqo1OC9vprxNx40wGa3rHrXEYfJH+U+WAoATWbD/g1PN6YmoglWNmPCnni5CIrIDY
         DyET9POZX0Kismg6eNLFhFWGtl5LWZlqOIp1fde3Hf2XHrmbpaChA9Ej9iP+xbLRLTJM
         Pxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748437188; x=1749041988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh3KYFguc08WUp3HQG/e3NOwLqhhclGw8CBRTTOw3xk=;
        b=QkvVpYY57CCCj8Hc9Vh9KRqr6S0wLp9yeNzZ3bVpYOxstvbrRLgQw8TBYsT+vM/puF
         aqBvNbtK5ZJPVpJLDe1Xb12uqKpKc9Cnw66tB2MqUEHy2Q0n8KT3tR1AoqykbRS6DxwH
         kyy9E7XEq+aAvXS8uAW2mUP9kXbNNC5NBH5V97/xfY/RRSmNWaSo6NzD1OaVEuip1rz2
         WJ/hS1uZdYv69o7wwQ7hCIaWmlIU/UDqtLgQNuxOzTukHbTrtnZySd7fbIdskPy050uR
         A68eGlSk0gF1SVhIQJSAZC9A9ZCb8oxrlA4hoMMIynJefKCM+DhIJ5i6utzWOxkMJ5u8
         +oHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0MHNoiBisupCII4CRy22JUAylp1MKKm51JlnKLkeihH3Gub0U+yJAreg9Dmzej1+UKgo6+fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+V3etmNFjHrab7/+3NHZFEAwXMeQKyv+jTOAc3bqZqhU4DRrN
	yNmVdS06DldWPElfec+ODL7S6VB1X/1z+zW4TJ24KOSvkSHo461dBPCdhzNO/U+WoitpIil+h5U
	6rj2W2vbsmshXHTMPU1wTR9SxPs8wEDtWGKhzhq0K
X-Gm-Gg: ASbGncvnooEN0WRPLvPlcoWkU2VFM8R2BLcxMA2bamwel1Uoq3izB3vTL4ATAkVW8WE
	XMudgesWSzEXbvnB5JJA5iACeak+QDSINw0yS8ila2Im/GUhKXIe05ZJg9g5BIML8jEbLiRwHFZ
	HcNhgRv7s6X3rq3nMYTTIX483N30UJte9TAIvwYRY3Ql8=
X-Google-Smtp-Source: AGHT+IFAJntWLEM+jLIr7N9mWP3wVZkrJg6XEkO/SEN/9+02OAMFuE/XmC+xS/0WBbR3yG/snqITFeF03Is/SbZOa1Q=
X-Received: by 2002:a05:622a:540c:b0:477:1edc:baaa with SMTP id
 d75a77b69052e-49f46154670mr281543701cf.6.1748437188237; Wed, 28 May 2025
 05:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hxscai7JuC0fPE8DZ3QOPzO_KsE_AMCuyeTYRQQW_mA2w@mail.gmail.com>
In-Reply-To: <CAN2Y7hxscai7JuC0fPE8DZ3QOPzO_KsE_AMCuyeTYRQQW_mA2w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 May 2025 05:59:36 -0700
X-Gm-Features: AX0GCFv6GDabW9ltrrqADmuYBvRnrtFJ8jrQAKBbibiNhMSdO8QJCQSrZAN03og
Message-ID: <CANn89iLB39WjshWbDesxK_-oY1xaJ-bR4p+tRC1pPU=W+9L=sw@mail.gmail.com>
Subject: Re: [bug report, linux 6.15-rc4] A large number of connections in the
 SYN_SENT state caused the nf_conntrack table to be full.
To: ying chen <yc1082463@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 5:52=E2=80=AFAM ying chen <yc1082463@gmail.com> wro=
te:
>
> Hello all,
>
> I encountered an "nf_conntrack: table full" warning on Linux 6.15-rc4.
> Running cat /proc/net/nf_conntrack showed a large number of
> connections in the SYN_SENT state.
> As is well known, if we attempt to connect to a non-existent port, the
> system will respond with an RST and then delete the conntrack entry.
> However, when we frequently connect to non-existent ports, the
> conntrack entries are not deleted, eventually causing the nf_conntrack
> table to fill up.
>
> The problem can be reproduced using the following command:
> hping3 -S -V -p 9007 --flood xx.x.xxx.xxx
>
> ~$ cat /proc/net/nf_conntrack
> ipv4     2 tcp      6 112 SYN_SENT src=3Dxx.x.xxx.xxx dst=3Dxx.xx.xx.xx
> sport=3D2642 dport=3D9007 src=3Dxx.xx.xx.xx dst=3Dxx.x.xxx.xxx sport=3D90=
07
> dport=3D2642 mark=3D0 zone=3D0 use=3D2
> ipv4     2 tcp      6 111 SYN_SENT src=3Dxx.x.xxx.xxx dst=3Dxx.xx.xx.xx
> sport=3D11510 dport=3D9007 src=3Dxx.xx.xx.xx dst=3Dxx.x.xxx.xxx sport=3D9=
007
> dport=3D11510 mark=3D0 zone=3D0 use=3D2
> ipv4     2 tcp      6 111 SYN_SENT src=3Dxx.x.xxx.xxx dst=3Dxx.xx.xx.xx
> sport=3D28611 dport=3D9007 src=3Dxx.xx.xx.xx dst=3Dxx.x.xxx.xxx sport=3D9=
007
> dport=3D28611 mark=3D0 zone=3D0 use=3D2
> ipv4     2 tcp      6 112 SYN_SENT src=3Dxx.x.xxx.xxx dst=3Dxx.xx.xx.xx
> sport=3D62849 dport=3D9007 src=3Dxx.xx.xx.xx dst=3Dxx.x.xxx.xxx sport=3D9=
007
> dport=3D62849 mark=3D0 zone=3D0 use=3D2
> ipv4     2 tcp      6 111 SYN_SENT src=3Dxx.x.xxx.xxx dst=3Dxx.xx.xx.xx
> sport=3D3410 dport=3D9007 src=3Dxx.xx.xx.xx dst=3Dxx.x.xxx.xxx sport=3D90=
07
> dport=3D3410 mark=3D0 zone=3D0 use=3D2
> ipv4     2 tcp      6 111 SYN_SENT src=3Dxx.x.xxx.xxx dst=3Dxx.xx.xx.xx
> sport=3D44185 dport=3D9007 [UNREPLIED] src=3Dxx.xx.xx.xx dst=3Dxx.x.xxx.x=
xx
> sport=3D9007 dport=3D44185 mark=3D0 zone=3D0 use=3D2
> ipv4     2 tcp      6 111 SYN_SENT src=3Dxx.x.xxx.xxx dst=3Dxx.xx.xx.xx
> sport=3D51099 dport=3D9007 src=3Dxx.xx.xx.xx dst=3Dxx.x.xxx.xxx sport=3D9=
007
> dport=3D51099 mark=3D0 zone=3D0 use=3D2
> ipv4     2 tcp      6 112 SYN_SENT src=3Dxx.x.xxx.xxx dst=3Dxx.xx.xx.xx
> sport=3D23609 dport=3D9007 src=3Dxx.xx.xx.xx dst=3Dxx.x.xxx.xxx sport=3D9=
007
> dport=3D23609 mark=3D0 zone=3D0 use=3D2

The default timeout is 120 seconds.

/proc/sys/net/netfilter/nf_conntrack_tcp_timeout_syn_sent

