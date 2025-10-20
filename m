Return-Path: <netdev+bounces-230821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B531ABF01E2
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC2189ED4A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A357A2F28F5;
	Mon, 20 Oct 2025 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0JwfuXB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310CB2F2605
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951710; cv=none; b=GkqN+tU6X7yy1/YKrKQdgLIT4uo8B9MFqtTCDt9FCqL7NRVglIMe/lDCsBL703ra8yJabbpe28ncfi9DhDBL/EgD5wP41zp6ph5mO6lnarm9aJrL4MS1neIMkp31lhlk+0wC6coNdlO6BgWSPWdlLwepdMMeI5S3/AYWjZTuotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951710; c=relaxed/simple;
	bh=ps0iVOJFdlQRCVK5DlTroAQWjV2qcwege/a1LIiqSpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7seJy5HFdf0KMjVXoBLDXiU3b/6o9/P/cI1+ihdbG6uNTO+uaqFvIzDdgIh7WRyQvx8vRSMytSyTnxcv05KIeBjsvQx8L/QhaQeF4iVwnsYouk8gQRoBjmSAZWXejH/c62wFGZK4WSZvAF3T7Jd/R9NXMxaZw0jravNrrydgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0JwfuXB; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-430e182727dso2282325ab.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760951704; x=1761556504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps0iVOJFdlQRCVK5DlTroAQWjV2qcwege/a1LIiqSpI=;
        b=B0JwfuXBFAhwULvRByZKlx5CRauEGd23UOGFzDoDylT7r5UGmSBNP6Mmk2Dbl64LPy
         W3h7phKKSO3Ji2MaH+oUTUUckTG+VOMkiPBewyBzsyJ32Hv2lmv6fLfmL7R5jWFIMFtW
         yp2CqqhkZSXQGU+Ycq2HiN7J5lG7SRkinYTxb63kupZLxxPPu/j0TffmGYybSISzt/fT
         EGV1CW2OyePOVO9GG9XA+hOCRFjQC80oOultehbXikAqah4NZ5lJ0FBn1DfleYMKuS7P
         itZgAOi4QEHggkTpme2wq7JzSA05lpwY6t9Ovg8Jc+ItGGfshEjUWQKfJ3QpEk1/nHAD
         ppqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951704; x=1761556504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps0iVOJFdlQRCVK5DlTroAQWjV2qcwege/a1LIiqSpI=;
        b=aqTB92b/QAnVx2SkyI01tJDVgtljfoZy+4Lhhoz6kboQ0ME4CuYxI2YU5Nx5gyqpn1
         nBmKmK/bo5sqQe3FsEaCTaXt9zhTdBAOERo+jqL45MmkiPZo0QJasW6ehepom3I/tGte
         xmnN+54ROZqbsrZLeggF0ENnRK3mVMr5+ySSzvo45ibVk7n/nowQ6kT4tT/lVigIkXcH
         68GL34NqPLzQ8QZyF44A/KmLeN4rPxo6hFYBlZAT+njIGoV2wmitDO3++YVSGEKbCBq9
         m34Vvk8r6vF88f2tH6o798TA6Tbxa5HOultWTVogp2DEJ+3JnSeYnWf3Dp4qhMzh8ws2
         Ensg==
X-Forwarded-Encrypted: i=1; AJvYcCXBotjM17EIXSGr9blBuye5MTPgpRfLx+lmxuz97egqiPWza68Db6PqwvxCbJO0zlmyivOUnE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBOsvabJq+uigCw5kJU0C2xl6wZyuZK4DZSYYo/IpEVEw7e37
	vj/AwAoys3lGEB3tlMHs7SFG1dsae+DZAaHNRO1ph5k0xor+DptONsq3TiZUlTTsvaGykUR2/xp
	EKacR2fHEp8zrkF6grQATmEfK0iXeAN8=
X-Gm-Gg: ASbGnctjQa+PgA2HyP9UdTSwYrfG+cnMYzVo4s15PS2OYpXmCNcP8Hf7xfu7su8n1Fq
	5po4FormythrqqjGsn+jeIpLRc7G04Dyn6mLusbbitptOfvqtJJp+4ilUbINSQf+6WmMVwCeYtq
	q6cetlWIM4YxZ0AvYbvSOdpaeXBSgotb/bAPsb0VuIWZ+ixa5ioS9ProzshzqhBRrQ1BlqFFyoW
	MbRQoCzhHkXOUooBjXMMe0dG2UNwFeao3PTeZZhxhJamKVNPEwOoJ5ygMOziGdmFmyd/VI=
X-Google-Smtp-Source: AGHT+IF66Vm/M9vLCkXyTgm2oVlWZYH8D73GXk28gJk/iFKJxEyGswPoBm54d2NkYSIZn7MBf7jZGkFFT6XgKRA0YCw=
X-Received: by 2002:a05:6e02:1a46:b0:42d:86fb:d871 with SMTP id
 e9e14a558f8ab-430c52b59bdmr150840075ab.21.1760951704437; Mon, 20 Oct 2025
 02:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-3-edumazet@google.com>
 <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com> <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
 <f51acd3e-dc76-450d-a036-01852fab6aaf@intel.com> <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
 <CAL+tcoD6+0gSMS2rOiOOFpnJ=iyYYJuNMg8+mNXBqCOYyeo5uw@mail.gmail.com> <CANn89i+bLvG0-v9nPF4R53UvFZ7im0=nzC-=K1+QeUDNxYbtNw@mail.gmail.com>
In-Reply-To: <CANn89i+bLvG0-v9nPF4R53UvFZ7im0=nzC-=K1+QeUDNxYbtNw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 20 Oct 2025 17:14:28 +0800
X-Gm-Features: AS18NWBKqE558I2p00D5oc7Kci0kRQY7ogCizP9t6QJlRuOQGqv-FVWhFT1eWVk
Message-ID: <CAL+tcoDWU4tZZJmXzSbLjdTJEpabCaDkN2gr8Oo5MQU4QyVZfw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in skb_release_head_state()
To: Eric Dumazet <edumazet@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 3:41=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Oct 20, 2025 at 12:02=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
>
> >
> > Sorry, I've been away from the keyboard for a few days. I think it's
> > fair to let us (who are currently working on the xsk improvement) post
> > a simple patch based on the series.
> >
> > Regarding what you mentioned that 1% is a noisy number, I disagree.
> > The overall numbers are improved, rather than only one or small part
> > of them. I've done a few tests under different servers, so I believe
> > what I've seen. BTW, xdpsock is the test tool that gives a stable
> > number especially when running on the physical machine.
> >
> > @ Alexander I think I can post that patch with more test numbers and
> > your 'suggested-by' tag included if you have no objection:) Or if you
> > wish you could do it on your own, please feel free to send one then :)
>
> The series focus was on something bringing 100% improvement.
> The 1% figure _was_ noise.
>
> I think you are mistaken on what a "SIgned-off-by: Eric Dumazet
> <edumazet@google.com>" means.
>
> I am not opposed to a patch that you will support by yourself.
> I am opposed to you trying to let me take responsibility for something
> I have no time/desire to support.
>
> I added the indirect call wrapper mostly at the last moment, so that
> anyone wanting to test my series
> like I described (UDP workload) would not have to mention the sock_wfree =
cost.

Eric, I totally understand what you meant and thanks for bringing up
this idea :) Agree that one patch should do one thing at a time. It's
clean. If people smell something wrong in the future, they can easily
bisect and revert. So what I replied was that I decided to add a
follow-up patch to only support the xsk scenario.

Thanks,
Jason

