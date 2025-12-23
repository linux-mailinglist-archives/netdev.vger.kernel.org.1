Return-Path: <netdev+bounces-245873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E0CD9B75
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 15:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AD7E300E17E
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5ED1EBA19;
	Tue, 23 Dec 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAzK0Eg1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C74A02
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766501278; cv=none; b=l7D9lPk8j0gVIOWaxVQFB8YC9HQc7xyLQKmWALYAdS8bPbHxqgk4hojQc2IKMPDuuJJ9ITJF0Mu7e4KNDT7/asWhoYg9NUkrHcEbbq4Iuha30GXRIKzV4ZwxcLuqp6tc7HQvb6kr0vJYgnFc+FH9TmIO+4+qy90S1E+de8diR1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766501278; c=relaxed/simple;
	bh=TJAb3LSEswLx6+Xq5HMafxcqRqMeL+50z2ZbDFhOoXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGNeIB2ihPKabQ9pL1WmV/wJh4dz4EBiGXs6Ey+WyKaPBCdCFc2wUZRPs2sNTwgnnld0idSkSfKEQ/EW7slP8M6/32F7yYGPbQjzrw0aDIZ+eZcUV+V8jmrpPYBUPMEkxlTyKc2gXHfV9QfdOjmurll5yoyTmXpiKpdiwQLyX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAzK0Eg1; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4f34c5f2f98so56901181cf.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 06:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766501276; x=1767106076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAzJy0lgB1c+UVH+AtIu+Y5rJu4WuxyR3+U/AZMozPQ=;
        b=eAzK0Eg1vFLYB03Z/HLW5pyRcSIiLbR0p2oOkDTP+CqHO2k8TMUkiLXAcdu5q5LYtW
         gOlFA7RUOcUoWCzJPVtpXcrGinlXn0F2uSNiM2V3lq6qMQMLxWv20himMnlHq3wcccyJ
         LkaHfM9Ah4O4XlK5DrZU2IlEy3poY5ccAMOpXholqAyIm4th3fP0GlOifxd6FpzI4P8k
         FnMZ+v59qZfkJMaEPYqhnqWXhsfs8uJq7uopO4CF2D6y2LESbQ3pknaDMDfklg9yoeT9
         F6WSTAJMeEbiUmqca/y45Sq24bR9o8gOplmu5a2xyonfyxTZV+b/+aGb/+sYA9OePkcG
         Mawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766501276; x=1767106076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mAzJy0lgB1c+UVH+AtIu+Y5rJu4WuxyR3+U/AZMozPQ=;
        b=T5/Bx2vQ8MPPeFbqHyqZUJ3t0ARIeNJD1Myrs2RkLmG/FdlAdXk9qBcoVghIOTXk5h
         qqmVW1NoZLvkMImQi+FUTOMmMxEc0MSethTWv9U89Lk6PD5DDTaFO4qO0diybli6j4Oe
         SizIbe2VHWepBtxtdwxVeGIopYRMjiEXYP7TJnWBYlDO3qkAJAn5VQtV7bg1DvY/HD/9
         mHZlezIAMqS/5WSypwVmi1jHtr60QCqkX709X7iIZZTi8emrDZd1nTLPWId2Rn83D9eH
         1rCwMvETyvkOkaDbctwUAMwgpxh5pKLPk7ATHfOeNYsTcxQDGta+T76+VywaLReEdqJe
         KXzg==
X-Forwarded-Encrypted: i=1; AJvYcCXhtYSZnv+ceR6W/pux/ZMPnahylSSGX8AN4Iw0KKXBsFx78+lEJsQ4TFIHpDWy5THa8EX1efY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2BPCDI3k6hSPV/lixGHPskkcMlVUCeUVH4wkYFUhf0btc4ejL
	hs/eVRqVMKeMzOP+LuQ0mBGryA/+A8vMlBMPcgCXC51rKyI/wX+S882WLB6RTMSkDVXGLAFLMWs
	AEDiGeOpp5Q2j+/BI9JstO3+Zhu4zNT2EcigcJIRM
X-Gm-Gg: AY/fxX7gkrRgIWjqcerWv/IGyBqGbnCtBwdAzEx459JQtqNh5G5zCd6eHUi8Lf+xaEe
	q7EF1UBvUESTWehVylEJPFTi6a91F6mk9uIFPPy1F0MN4xuqtObaIBdACqC4g0joVcwGfvATeys
	v/APBR/czu7XLf/nl/mqGLLsMlcb60srxMOvowu7RhazSiZrDZj6+gll+Qw0pypXVi9VEQFAHTL
	wJUKcl6OJSUHNF0742PCV5VXu2BB4p9vSnFVZ/LL3p1SvF3m9HwcEFEwRFmfdCzGYVo+Uk=
X-Google-Smtp-Source: AGHT+IG+bK0INBRB5f1BYJgGla5CI09WKL3nTen8lH07NVd0pbImimo6mTlkqVPu86EmBKTzVShh6iPeviZGJ4+R7p8=
X-Received: by 2002:ac8:584c:0:b0:4ec:b599:2879 with SMTP id
 d75a77b69052e-4f4abdbf154mr206820651cf.66.1766501275316; Tue, 23 Dec 2025
 06:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216085210.132387-1-zhud@hygon.cn> <eae60389-27a5-4e8f-af49-7f75d4c116d8@redhat.com>
 <fe236a552f594780a4b2ead63b4bc329@hygon.cn>
In-Reply-To: <fe236a552f594780a4b2ead63b4bc329@hygon.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Dec 2025 15:47:43 +0100
X-Gm-Features: AQt7F2rshnGdOxahnZaE5tMJbC9XMqC4q4O5M5phiwBsbfn29XGQNc0m4AoCmNI
Message-ID: <CANn89i+p0UX1VW9Pm6_B5tJ-_b_iwJP5Dkk_Agnf+46FD2jY-g@mail.gmail.com>
Subject: Re: [PATCH net] netdev: increment TSO only if TSO is not enabled on
 any slave device
To: Zhud <zhud@hygon.cn>
Cc: Paolo Abeni <pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Jing Li <lijing@hygon.cn>, Zhiwei Ying <yingzhiwei@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 1:20=E2=80=AFPM Zhud <zhud@hygon.cn> wrote:
>
>
> > On 12/16/25 9:52 AM, Di Zhu wrote:
> > > Unconditionally increment the TSO flag has a side effect: it will als=
o
> >
> > This changelog is IMHO quite confusing. The code does not 'increment TS=
O'. Instead
> > it increments the features set to include ALL_TSO.
> >
> > Please reword the changelog accordingly.
> >
> > > directly clear the flags in NETIF_F_ALL_FOR_ALL on the master device,
> > > which can cause issues such as the inability to enable the nocache
> > > copy feature on the bonding network card.
> >
> > bonding network card -> bonding driver.
> >
> > > So, when at least one slave device's TSO is enabled, there is no need
> > > to explicitly increment the TSO flag to the master device.
> > >
> > > Fixes: b0ce3508b25e ("bonding: allow TSO being set on bonding master"=
)
> > > Signed-off-by: Di Zhu <zhud@hygon.cn>
> > > ---
> > >  include/linux/netdevice.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index bf99fe8622da..2aca39f7f9e1 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -5322,7 +5322,8 @@ netdev_features_t
> > > netdev_increment_features(netdev_features_t all,  static inline
> > netdev_features_t netdev_add_tso_features(netdev_features_t features,
> > >                                                     netdev_features_t=
 mask)
> > >  {
> > > -   return netdev_increment_features(features, NETIF_F_ALL_TSO, mask)=
;
> > > +   return (features & NETIF_F_ALL_TSO) ? features :
> > > +           netdev_increment_features(features, NETIF_F_ALL_TSO, mask=
);
> >
> > NETIF_F_ALL_TSO is not a single bit, but a (later large) bit mask; the =
above will yield
> > incorrect result when:
> >
> >       features & NETIF_F_ALL_TSO !=3D NETIF_F_ALL_TSO
>
> Yes, it is indeed necessary to set all tso flags to avoid GSO at the bond=
ing layer.
> I will revise the code and its related changlong, thanks.

What about this instead ?

 static inline netdev_features_t
netdev_add_tso_features(netdev_features_t features,
                                                        netdev_features_t m=
ask)
 {
-       return netdev_increment_features(features, NETIF_F_ALL_TSO, mask);
+       return netdev_increment_features(features, NETIF_F_ALL_TSO |
+                                        NETIF_F_ALL_FOR_ALL, mask);
 }

