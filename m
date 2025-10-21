Return-Path: <netdev+bounces-231056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45837BF4406
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87B4E4EE77C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F32224B04;
	Tue, 21 Oct 2025 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txgQDdE8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0591F8908
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 01:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010134; cv=none; b=VGJQYHBuMv1LQFOKTkDQAOMjpOUKRlpBHFE3RWFxQcnF8rxFObwnt8w49Jh5XmOauIHeeDM7isPH3ev74xOvZZJipgrJA9VJz0pecV/Fwa/0ufu4qx3wZaG79w/DIL5eppYa9Q3ED1Lcc3EOPq/e5v6e+kd446ZebIUrmR5RkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010134; c=relaxed/simple;
	bh=0egN+D/w2mjUdolc1V/yBquNG7txfsfesXy2/wI8gNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0nawe5Zo5oLf8tzomAnOjVYNkWLLinbHK5zeQhPXe2i7uBzTEO8U1oZmlY/3FjOdbrI+wa9pjpp3L4Et86AGznHhMkSoW09LXkeUNVoqFbhqGRaiIKyvkR+s2F8gEn3gQA1mpeeW5L/nTgLrG86iqhsOh5lID43YM1BW0bWlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=txgQDdE8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-290a3a4c7ecso53548065ad.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 18:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761010131; x=1761614931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVTxr075ZebchmR8Hbg8/omgKc6ezmPEcjQkG9HdO6o=;
        b=txgQDdE8V+qSXuwr/gH3tyDDHJResktycGgty0EU9uxgsAGnbIhXGnE2y92MIbr/Xi
         zhv+wlwq/KJ2euYYDy8TJHyZZlNy1fSKk0c5Nj8oc3WPmuSVfo1j8MdW6XTzJHZMbNtx
         j7IyzscIV32OLSzjegiXdLLuelw+EdY9hDKpdQBl59HVDTx3B6qnCveGMEhZPbwYDEze
         vsxV1Y1nUYNP40pgFAvQPMF7LhGarEMapGoJQDKcEJNproix4atpSuY/oicpslo+7Sj9
         Ukpeq24k8xP4EN9O4Lpnp4nwhWO/HT0euUz2MbnhtY2QyDam7Nz7+6jsz5QF4+K1TMQc
         PcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761010131; x=1761614931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVTxr075ZebchmR8Hbg8/omgKc6ezmPEcjQkG9HdO6o=;
        b=nReBq7YGBYxvDTmot5f2gqAG5ZXBJRTU5OTRl5t4Y/7xa1k1Vy8X71TaQyhxsLunjC
         03I64M+kCOzP6Oen5ARKf3TMxbk+nMB3cFSxL+BXSstLGoRWixGh91BBghMSqRsJM/8H
         5aNnex0GUsHb/cu9kQeFTUR2bIsvEWu2nb+bcoU60+xwI3nRtfmpjbBliN6UR83C36lj
         QhM2dESYKVCkfKWrH1VQ6r21JoIHT4ajUEnDypWBVX8ZkrAX4mbWfT6165eieqSPp63o
         azh4toU+0dkP9bk6VblKAwztbYMLdGfmkPzfpw2MokRNbvdAQL71PWtef9Lc3OvAaJjj
         vlhA==
X-Forwarded-Encrypted: i=1; AJvYcCXwWXIoXuLGL5nKqNMODczPS4S6rbv6sMlxUwVDKg/VRwlUyBtHTvr0yB/ts4jizoZ8Qlomr84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlOqPu4mGnClQGw7gY3i8AqOAWGBM/76/QEbfW34Zyl6apSShT
	xPE6vtkaAi4fuJPcevgUxeDw3LvECFNFaZRuP0s9PCfpE9L78eXsWmeNeogjNxBPhguDqXofyJl
	TH+nMSHLNqxtYEVWANjVIwsX7quY1kJM6T6dmPO4q
X-Gm-Gg: ASbGncvRn4nuaSJDNq0iEvWZgigdawPpRV9tSEcnZ1PSjBpx/NkN3rx+bhNbiGVF1bD
	HP4ioI+XoU7SCNfH3jv7Npj2PcAPEU870TtGUqiz/B+RiFaoqstQgdXLe3mSVESAjUmYnxCd2qE
	21TKVIvo7UoWPectU3ovn5RkPv4BBkkgUaDFYH06Rl8lMVXZ+RGqvZ4iR0Ty1yq4lL6cL4T449C
	2Wj5jThr0Co1cn0anx85KpT518lxfPMkTI0tozs//pCJKADkyhxjbwwZuAotrF8qyjPwVRw5+Za
	r+BRx+sotc9vcuiwkQ==
X-Google-Smtp-Source: AGHT+IGXvumjl+B/gPzZquS57wgeFU+c2+y2aiSmvr2y31bglhhqwff6jB3GSkVxXrE1tFRR1Z2xmdhX5M9NFhJDI4Q=
X-Received: by 2002:a17:903:1209:b0:26c:4085:e3f5 with SMTP id
 d9443c01a7336-290cb65cd46mr183408305ad.50.1761010130389; Mon, 20 Oct 2025
 18:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016040159.3534435-1-kuniyu@google.com> <20251016040159.3534435-2-kuniyu@google.com>
 <CANn89iJnQErC8OLoTgnNxU8MURKANbiqXBYaUHsNaTO3m+P54Q@mail.gmail.com>
 <f93076da-4df7-4e02-9d57-30e9b19b3608@wizmail.org> <CAAVpQUBD5nozg1azwi9tBHXVWgcXBSV+BXSgpt455Y+CweevYw@mail.gmail.com>
 <80bb29a8-290c-449e-a38d-7d4e47ce882e@wizmail.org> <CAK6E8=d1GjRLVuB0zmydAepvnZs3M1w+2tCVwdhAzL6rtseJ1g@mail.gmail.com>
In-Reply-To: <CAK6E8=d1GjRLVuB0zmydAepvnZs3M1w+2tCVwdhAzL6rtseJ1g@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 20 Oct 2025 18:28:37 -0700
X-Gm-Features: AS18NWAVPXuwG53NH27O6fBlnrO0MgkJcZnyw79d6t1rPBwxNBjUXrt9OalPybQ
Message-ID: <CAAVpQUC489+RpEcyaHqrR0HpTG-SO9_ty-n7R1e_HnjGzD-2PA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/4] tcp: Make TFO client fallback behaviour consistent.
To: Yuchung Cheng <ycheng@google.com>
Cc: Jeremy Harris <jgh@wizmail.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 9:31=E2=80=AFAM Yuchung Cheng <ycheng@google.com> w=
rote:
>
> On Sat, Oct 18, 2025 at 2:17=E2=80=AFPM Jeremy Harris <jgh@wizmail.org> w=
rote:
> >
> > On 2025/10/18 9:56 PM, Kuniyuki Iwashima wrote:
> > >> In addition, a client doing this (SYN with cookie but no data) is gr=
anting
> > >> permission for the server to respond with data on the SYN,ACK (befor=
e
> > >> 3rd-ACK).
> > >
> > > As I quoted in patch 2, the server should not respond as such
> > > for SYN without payload.
> > >
> > > https://datatracker.ietf.org/doc/html/rfc7413#section-3
> > > ---8<---
> > >     Performing TCP Fast Open:
> > >
> > >     1. The client sends a SYN with data and the cookie in the Fast Op=
en
> > >        option.
> > >
> > >     2. The server validates the cookie:
> > > ...
> > >     3. If the server accepts the data in the SYN packet, it may send =
the
> > >        response data before the handshake finishes.
> > > ---8<---
> >
> > In language lawyer terms, that (item 3 above) is a permission.  It does
> > not restrict from doing other things.  In particular, there are no RFC =
2119
> > key words (MUST NOT, SHOULD etc).
> >
> >
> > I argue that once the server has validated a TFO cookie from the client=
,
> > it is safe to send data to the client; the connection is effectively op=
en.
>
> Thanks for the patch. But indeed this was the intentional design (i.e.
> empty MSG_FASTOPEN call triggers server immediate accept and send
> before final ACK in 3WHS). It's allowing more application scenarios
> for TFO. Now some applications may have taken advantage of this design
> so this patch set may break them.

I see.  I'll leave the 0-byte send as is and make the error path of
tcp_wmem_schedule() align with others.

What do you think about the edge case in patch 2 description ?
Actually, this patch was a prep to detect the case easily.

The script could be valid if the server set the no cookie option,
but it cannot be detected on the client side. (and no cookie feature
is not an official feature in RFC)


>
> But the RFC could be more specific about this edge case so revising
> the RFC as an errata?

Sure, I can post an errata like

3. If the server accepts the SYN packet with a valid TFO cookie,
   it may send the response data before the handshake finishes.

>
> >
> > For traditional, non-TFO, connections the wait for the 3rd-ACK is requi=
red
> > to be certain that the IP of the alleged client, given in the SYN packe=
t,
> > was not spoofed by a 3rd-party.  For TFO that certainty is given by the
> > cookie; the server can conclude that it has previously conversed with
> > the source IP of the SYN.
> >
> >
> > Alternately, one could read "the data" in that item 3 as including "zer=
o length data";
> > the important part being accepting it.
> > --
> > Cheers,
> >    Jeremy

