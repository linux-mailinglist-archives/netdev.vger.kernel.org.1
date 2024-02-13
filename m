Return-Path: <netdev+bounces-71144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552DB852713
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861511C259ED
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9A31385;
	Tue, 13 Feb 2024 01:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/UTkcyu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324E6119
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707788925; cv=none; b=IuCp0t8kUIVJRFwjHBjLxtBei60GN+6i/Ngv8oeF95zJBhdufggudBdUGTtFAhf6Fxl4YB7IFC1xrQgrRQ4CJQ6TDDBI92QOQ8S2cc+4ZcboxQ4EPylD2uTI+hV84XXaTqoio7gyatoo0xTm815u60SJ0+5Ekuo5PfG9pnBK/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707788925; c=relaxed/simple;
	bh=QVpI12HTBp5QUCjcQhMCjL70oQCzOgfUDHwB0fgzgQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYZCyfDK+JSXKCzra4P7TlYn9wfQXmmGpfXPxoga/OzQY4qdl7k91i2KxmRCt3jXuqqzkpEcN1S4xNd9XfIK7PGrikAhro4KJKQ0/3rXnkykm1+n1vne4xwbYFxJFEvxEaP7nYbH6065c1lnj8DkQBS2spSm0Hrfg2+1S6LVFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/UTkcyu; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0d799b55cso47873861fa.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 17:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707788922; x=1708393722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbWpiqFqIx/nFjBlwNiX0sfcb4vOzLEsNe4f/TUzjpQ=;
        b=f/UTkcyuL14VUOkRaVCtK8nT7EkvDNEqQQkIn2c2kC2EkVBZuVJE5DtCuCa3AwoHQT
         KbIXQnRRiBWaTUJPNeM7Kk9kJT32xTsQpzej+VGvhNZZSfr2kQ0iqqNV0s7sF18HyWes
         44zOFx+iqyi+LGR0u/zsjj9HjaAvvexgzG1+gjzcNB2MYO33s/vvO9XxeZgpFVTyhkrV
         bEG3KjX8/jAC3p8SaDc8z0W/9aSwjOAevNx6AMpPBQSTtoBxhGmO/pL0EoxN32QjEBmR
         sK92RpqKpjhfC8T2MOwNiOj/i/elqpJWMVfmbpxxIHP6GEN/YjmnQ1rmO2EArnS7xrCr
         v7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707788922; x=1708393722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbWpiqFqIx/nFjBlwNiX0sfcb4vOzLEsNe4f/TUzjpQ=;
        b=b4Yq+YNIEQwV+VCI2xsFX7UN3Hic11QcuARJ6W5Ja0I56qt+atN2txDBMVUKRpYK0e
         gG7TLXQU0zxPIiZ60ZZ770U9VbHSnheG/xG/LW77U++CC7itSvI1EaqTVsjAcCgi5B5e
         fQ7Xm8vu87dQ45Cv2WFCZQes7DHFqozYD3YDxobX8Kj79KSAlSG3ZimwpKZdwSfVbUGQ
         nXXHHqzwk7PJrYfKhTHtPdHVhAlA53ptLAkwdKv97kbJT07ZqTuWSXaf8p3SuD1/KdEM
         rCMV9WAJvGhHyJ6qTQhxKw1ugVE73lI94EbHr5AwN2tpnhllxcVhObDyBVJ6JiF1+h6S
         BU8Q==
X-Gm-Message-State: AOJu0YxZ3bc7UsEnKkYluB6YQ+Mf1cOPpZ8RiwIEV20fjXD9Lpl8gGBu
	I/2u2wIuDh9q0tRMMkcekDOoqFsOYTa1hNNzOwT+mmN4xinnS0Ziy5qY45VrXeH+pvICY76qgnI
	y2MHwPIWIv8ivcfE8TePEaJMOwjY=
X-Google-Smtp-Source: AGHT+IFpaK/KGgtri0u55Qw0kMiDjVJZYzHWWerehDByajKi/g3X3i7ib4uq/ogu/K2LWkS28XQf4BBuFlzXbW9FkDs=
X-Received: by 2002:a2e:9ad0:0:b0:2d0:b3c4:5113 with SMTP id
 p16-20020a2e9ad0000000b002d0b3c45113mr6377143ljj.11.1707788921583; Mon, 12
 Feb 2024 17:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
 <20240212092827.75378-4-kerneljasonxing@gmail.com> <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
In-Reply-To: <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Feb 2024 09:48:04 +0800
Message-ID: <CAL+tcoAWURoNQEq-WckGs6eVQX6VFpHtw4CC9u4Nc7ab0aD+oA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:33=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Feb 12, 2024 at 10:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
>
>
> >                         if (!acceptable)
> > -                               return 1;
> > +                               /* This reason isn't clear. We can refi=
ne it in the future */
> > +                               return SKB_DROP_REASON_TCP_CONNREQNOTAC=
CEPTABLE;
>
> tcp_conn_request() might return 0 when a syncookie has been generated.
>
> Technically speaking, the incoming SYN was not dropped :)

Hi Eric, Kuniyuki

Sorry, I should have checked tcp_conn_request() carefully last night.
Today, I checked tcp_conn_request() over and over again.

I didn't find there is any chance to return a negative/positive value,
only 0. It means @acceptable is always true and it should never return
TCP_CONNREQNOTACCEPTABLE for TCP ipv4/6 protocol and never trigger a
reset in this way.

For DCCP, there are chances to return -1 in dccp_v4_conn_request().
But I don't think we've already added drop reasons in DCCP before.

If I understand correctly, there is no need to do any refinement or
even introduce TCP_CONNREQNOTACCEPTABLE new dropreason about the
.conn_request() for TCP.

Should I add a NEW kfree_skb_reason() in tcp_conn_request() for those
labels, like drop_and_release, drop_and_free, drop, and not return a
drop reason to its caller tcp_rcv_state_process()?

Please correct me if I'm wrong...

Thanks,
Jason

>
> I think you need to have a patch to change tcp_conn_request() and its
> friends to return a 'refined' drop_reason
> to avoid future questions / patches.

