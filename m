Return-Path: <netdev+bounces-123983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 853BF96724C
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 17:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1010D1F220BE
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66BC111A8;
	Sat, 31 Aug 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgQ8SZJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180DFA932
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725116466; cv=none; b=r/wXD24+4RINtHw0lvAi886wC95w6GujyeQ3cB0+1XXO4KKrHfVq/Cf7s4uF5BIswScBZPb/eub1p3Dk/6xqH2mRejWq7DHgqqLFWCDktHrRwfjEe/CjLrp+6hpczFA75UgqEjtOTI2ukV3cMh9HpvztjKyYuocgP2lzXVZpzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725116466; c=relaxed/simple;
	bh=3c2alasJWTHKjcO5Bclam6pAJcKezorX+rP0ZbsGNlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ger3Uvo4TmSy9rpwaQKq9C4krODg5ziZZOMCRkoDpgafoh0BUf3uTuGX0ku23yd1dxoQWRSat2pCuST/G98kzydKRxUQOK2OThguS916aDJlcppGIFVRBHlqpy4byry2L05bZdFJKIQqeZs42XBcqN2xjVTNM1D/bA4xTtu5pXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgQ8SZJG; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39f376eacfaso10979775ab.2
        for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 08:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725116464; x=1725721264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8035Cu7gqofEr9nB9b7hKYigwVwejfvE8zaGtib7E28=;
        b=PgQ8SZJG5xDTbjXglg3WKrUgEhwMVKOH1Cppamgfu1Nw/B9A+TKJpWtYDbhn5JoEoI
         YY29nl9Ky3UZZzVnNMmCUwdiehV/m6IqR8SK9wDSo87C7dL5aDNUxvnybw4p3TyLrT5O
         c+UBSt72l6hu22kKTjtCyQzskB5I4KoQ0vZGBUXl1mocWfT0dvu3kb4gUa/GRJflsLxo
         qPj9Aq3bnvpswMsQ14aF2Vk3riw8KAIHgcCZfLRh3E8D9/v4yYrFpgqlwiiNs3tF/4H/
         m56ZGOXSCXN1SseQKdz/1582dFxC1jfss0plkaLxd3Ci8RTGv0WnhFiW6rbFihuada8k
         TQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725116464; x=1725721264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8035Cu7gqofEr9nB9b7hKYigwVwejfvE8zaGtib7E28=;
        b=ZtSr6yuySNNPUPDHP7jvVK/iXcLdxgH7/bI0hRf+HXQC9iYpJ3OydHRiqRu6TsMjy7
         An2kJr/C+eszm93GF8H3lO7C7WW4OsZW25h/rZ43q6aTHbf8I9dVgcK5wQ6/JdA4gdTD
         vNc79uXypJi8bjzgNyEsQoou0fGsESXA3rr2GiHH3Pi9jWfIfkqjuBQJMD5YYpS7GMVe
         +wOZNarW0tvJctCx67GRbgaHm5IzTenXeAKWtvbIU6xcdJ5qqwPnLUs+oY2SViUEkKU0
         bPI7xAsgDQStQYV9hi7yc7AMjWjxVoRTuoCaJD2xwOolPaaSUfqmOq7UX6Iby5GtcvGA
         Ehzg==
X-Forwarded-Encrypted: i=1; AJvYcCXrpnX3MylinawRSiQVmrMAFwtHD/SPAEiigEfkNEbw/inrvENM5zJCdWnU8EK0wQf6dz4/5a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQLAhGpZSeo0sacr9I2kEhkMuFBLk98jz525LqGCEQ5d0Qz/3Z
	w2BXCCGvQuaYhFRoGwcavU1EDQxqzm2kNZmkLrPg251g+wJ4G+BVMwwxa/rMGDn8YFfvbbn/P4D
	G+rpJv/jDfx6UgVSL5yaXzmmFfJtg3Ox8Gss=
X-Google-Smtp-Source: AGHT+IE+1B+XIoQIikH2XXuIk+21t1mIhIguzAr/pN5tW2k5L60lldCumBzGTNmoQ4JTESMS3CXqvACh/X2fJnoCEDk=
X-Received: by 2002:a05:6e02:1fc5:b0:39e:6e47:814d with SMTP id
 e9e14a558f8ab-39f378ed22emr102923125ab.2.1725116463670; Sat, 31 Aug 2024
 08:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830153751.86895-1-kerneljasonxing@gmail.com>
 <20240830153751.86895-2-kerneljasonxing@gmail.com> <66d32d9766371_3fa17629413@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d32d9766371_3fa17629413@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 31 Aug 2024 23:00:27 +0800
Message-ID: <CAL+tcoAxVG7xpjXG+gyqoJjspn16F3Nfq5-8BoyVqO13qFm5xg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net-timestamp: filter out report when
 setting SOF_TIMESTAMPING_SOFTWARE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 10:50=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > introduce a new flag SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER in the
> > receive path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> > out rx timestamp report, especially after a process turns on
> > netstamp_needed_key which can time stamp every incoming skb.
> >
> > Previously, We found out if an application starts first which turns on
> > netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOF=
TWARE
> > could also get rx timestamp. Now we handle this case by introducing thi=
s
> > new flag without breaking users.
> >
> > In this way, we have two kinds of combination:
> > 1. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_RX_SOFTWARE, it
> > will surely allow users to get the rx timestamp report.
> > 2. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_OPT_RX_SOFTWARE_F=
ILTER
> > while the skb is timestamped, it will stop reporting the rx timestamp.
>
> The one point this commit does not explain is why a process would want
> to request software timestamp reporting, but not receive software
> timestamp generation. The only use I see is when the application does
> request SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE.

Yes, you're right.

>
> > Another thing about errqueue in this patch I have a few words to say:
> > In this case, we need to handle the egress path carefully, or else
> > reporting the tx timestamp will fail. Egress path and ingress path will
> > finally call sock_recv_timestamp(). We have to distinguish them.
> > Errqueue is a good indicator to reflect the flow direction.
>
> Good find on skb_is_err_queue rather than open-coding PACKET_OUTGOING.
>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for your review:)

>
> > ---
> > 1. Willem suggested this alternative way to solve the issue, so I
> > added his Suggested-by tag here. Thanks!
> > ---
> >  Documentation/networking/timestamping.rst | 12 ++++++++++++
> >  include/uapi/linux/net_tstamp.h           |  3 ++-
> >  net/core/sock.c                           |  4 ++++
> >  net/ethtool/common.c                      |  1 +
> >  net/ipv4/tcp.c                            |  7 +++++--
> >  net/socket.c                              |  5 ++++-
> >  6 files changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/networking/timestamping.rst b/Documentation/=
networking/timestamping.rst
> > index 5e93cd71f99f..ef2a334d373e 100644
> > --- a/Documentation/networking/timestamping.rst
> > +++ b/Documentation/networking/timestamping.rst
> > @@ -266,6 +266,18 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
> >    two separate messages will be looped to the socket's error queue,
> >    each containing just one timestamp.
> >
> > +SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER:
> > +  Used in the receive software timestamp. Enabling the flag along with
> > +  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp to the
> > +  userspace so that it can filter out the case where one process start=
s
> > +  first which turns on netstamp_needed_key through setting generation
> > +  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one only passi=
ng
> > +  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx timestam=
p.
> > +
> > +  SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER prevents the application fro=
m
> > +  being influenced by others and let the application finally choose
> > +  whether to report the timestamp in the receive path or not.
> > +
>
> nit, so no need to revise, but for next time:
>
> Documentation should describe the current state, not a history of
> changes (log), so wording like "finally" does not belong.

I learned it, and will bear it in my mind:)

Thanks,
Jason

