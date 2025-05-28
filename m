Return-Path: <netdev+bounces-193969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A62AC6ACA
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113913AC3B6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EAE2882A1;
	Wed, 28 May 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvDTI76j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5972874E4
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748439721; cv=none; b=PYkf2IennGRQzuEfawPjHp2Xcz/DJp2GBY5wwvWZACmNojyY/JXiLldL+AziEXtikEPADhTvhJZKJ/MEYXrf76CAyxeP3N5bMmcejXIqF48UoW0mRUo4UwpRzIQsLrmS0igQDhDqB/A9AR6Zbk/N8l/dF599tRzomqJmGwTXJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748439721; c=relaxed/simple;
	bh=q6+NUbSkDfbULFIkQSRxG3LqAFTgY8fsGbQ0EjJoDmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkvRW26mpC1PB1FFQXFhhyDi/WUv2q+Z8itqAcpsRgG7Qfvab1apM5Sn4r6xr+q547gLQMr3akX086bu/W6Bs9SSS0a115msXFNrxZQ64j9yFaDjJVf0WKbuVU2QcjJzOIkK+/71ndQz8yE2YGMkOnIOHj+mX6nD2amaM3XuZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvDTI76j; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476ac73c76fso57912811cf.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748439719; x=1749044519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6+NUbSkDfbULFIkQSRxG3LqAFTgY8fsGbQ0EjJoDmg=;
        b=dvDTI76jZZGKZmTUy8Wff5m8yyne23JCwucBRkoFbQLgPKmcWzyLZ2j6RrrAgnWDlA
         Db5GSXJPcEIp1gJIjJmCCAnswBjT7gBApuO25JjYe/9SkA5BSUfPS02mZUwesFAVHmL+
         mrvM509kQpcIPbIWZPVIWspkkPPA3rxuHJKyloF4yoyc0wrHf8oA325hyPgtI6+n0Uo0
         qUPjyuJAKbzSwr10pvyQU8OKlKxenOXH7rvszJf1DqxBrBU2ZdhzifhdezlkvRgijtFs
         CLqEaXxVmkLzvJya9w2F3JcjClKiCSTiyXAgdCTx/qnSD394/bmpLZdVjJPwcdOpAOJK
         EANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748439719; x=1749044519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6+NUbSkDfbULFIkQSRxG3LqAFTgY8fsGbQ0EjJoDmg=;
        b=tuf31bvn2uU4yD4rYVQMejYuMzVMwefhqa+xbnxtdgwjk3XyBSEF1xXvSHHgpbJZZV
         ZnyzSxdVR/W4hFP2CA/gA2Yt3TRhGzPCyrUQR6WsQvYqNHRI89xqy7bB8oMQ3KLehi0F
         t80ZwXBLDc3FxQPM2bODBzv+rcv4C7mYONFWv+D2OjNS8ySVpKZDicOHlzMDkhfp/dTI
         +lGPSrYpLDfgcFAbaEZuewKIDvYUqTCO5/8KsZJVc0XEhOWMg8jnXf8LZGLH/ERo+Uyx
         DZIJ5Ysum2WkpdPd9HhtruzQbKp3zYjejBjb59ZW2P99bhtEEImv4xrTDSAlvlhexwNJ
         aEXw==
X-Forwarded-Encrypted: i=1; AJvYcCWsEp92/LPpxtuN3mN2ablOAldclTIu7PCb8J9pItJJplhZguGJENIle3JW/cSXviI/+xNq/rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZEbu6a2bc/GumtZYi8KswTMNreTqfSLqTR6wvFQZJPoMk3Fmk
	Fu3vQMIGasEhcvU7zmUfTuQQiB+LPzY/VUB2mRPQYU3iKYKlvAS0mj6YQTdWFW5sBbmtT2gLRfi
	Gw2BdF80JLV0saGeoGJ/UXf+oRlxfN8NpgpCYsKBb
X-Gm-Gg: ASbGncsW1QQAYpOphbBXaQ/cRmAuyca6Ftu2QEmx52XLJPy5azrYI0EMGOE2Ppnsoy6
	SKbFIu6k2DyUOBbCz/lzVvdb9YMNUYW6W9TCB6wU3Gv2Zbm3n4IykwJ3jhuJuZgdmMUxduK6lQM
	wonLo+tKUvnJfWF2bSWnAiWUH49cdZj8+sniE3CM73IOOsyiffp8ttxg==
X-Google-Smtp-Source: AGHT+IFXUSUWOaRqlGgnQsk3Ddxf9ikBISkt0/KlPz6xvIxI0l0YyOvrvNO9ok6mnWdgT9562252wxJ87xj+prWb40Q=
X-Received: by 2002:a05:622a:5c15:b0:476:add4:d2a9 with SMTP id
 d75a77b69052e-49f46c33b2dmr291076841cf.30.1748439717984; Wed, 28 May 2025
 06:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hxscai7JuC0fPE8DZ3QOPzO_KsE_AMCuyeTYRQQW_mA2w@mail.gmail.com>
 <aDcLIh2lPkAWOVCI@strlen.de> <CAN2Y7hzKd+VxWy56q9ad8xwCcHPy5qoEaswZapnF87YkyYMcsA@mail.gmail.com>
In-Reply-To: <CAN2Y7hzKd+VxWy56q9ad8xwCcHPy5qoEaswZapnF87YkyYMcsA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 May 2025 06:41:45 -0700
X-Gm-Features: AX0GCFtlj7sv-EQdf2aW5VpoDTLIYK53zi24E4KIItVmjWV2JQld-StOJ3wEEoo
Message-ID: <CANn89iLG4mgzHteS7ARwafw-5KscNv7vBD3zM9J6yZwDq+RbcQ@mail.gmail.com>
Subject: Re: [bug report, linux 6.15-rc4] A large number of connections in the
 SYN_SENT state caused the nf_conntrack table to be full.
To: ying chen <yc1082463@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, pablo@netfilter.org, kadlec@netfilter.org, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 6:26=E2=80=AFAM ying chen <yc1082463@gmail.com> wro=
te:
>
> On Wed, May 28, 2025 at 9:10=E2=80=AFPM Florian Westphal <fw@strlen.de> w=
rote:
> >
> > ying chen <yc1082463@gmail.com> wrote:
> > > Hello all,
> > >
> > > I encountered an "nf_conntrack: table full" warning on Linux 6.15-rc4=
.
> > > Running cat /proc/net/nf_conntrack showed a large number of
> > > connections in the SYN_SENT state.
> > > As is well known, if we attempt to connect to a non-existent port, th=
e
> > > system will respond with an RST and then delete the conntrack entry.
> > > However, when we frequently connect to non-existent ports, the
> > > conntrack entries are not deleted, eventually causing the nf_conntrac=
k
> > > table to fill up.
> >
> > Yes, what do you expect to happen?
> I understand that the conntrack entry should be deleted immediately
> after receiving the RST reply.

Then it probably hints that you do not receive RST for all your SYN packets=
.

