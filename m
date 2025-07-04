Return-Path: <netdev+bounces-204189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135D7AF96C4
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67E73B6F0E
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489A62BF013;
	Fri,  4 Jul 2025 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ1Z+fth"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE012D63E8
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642774; cv=none; b=YCNukAIZzTxh0a2ffl9MPrBogVUlfylnHj21mL1THWgk9AzG1eJW7rNVQMbn7QldUYSq/7pYKMWiKRi+U7fopAmiZ7F0g0r31nuxo8dBVr5muos8xlg9vZframCEZZ4JKsW5sbLocKIJBaLzbbeFUPqzJRmpQlLRJx99PjNKgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642774; c=relaxed/simple;
	bh=Pm2g2fzUIz66do6OuYwBRYllgWhqSlydlxv9dAz2clY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGqcJ6fPlg73yVMdthO3kzmWRt+Hk7ghrFyASAqgdynZNb+f7FvgnOfRSulmuE7lOsYEI9fEGubKrzsYksJNj1W0YP7INqEgMMEfSFwCZnJIzgSPywD8EZF+t/OSsXPrZarMREpdIdUpafpf7m8a8eCbiNj6VkqzS2ww+VlAGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ1Z+fth; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d442192c67so12462685a.3
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751642771; x=1752247571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFcYw7gn3XvFR5dV9V5g5nEHPo2D1azMjHDmYLt7hrI=;
        b=MJ1Z+fthCpWwJ6mjQjqUnDhYEvBsAHP6DTsRh8FDhIx/8p5E3D5L+OsecN8Nps14qR
         otp6spXVaSiyAwfyrtazwJHLVeMkPtu1q+iQvwCd3A9slVb9hgejh4l00v4yw4AACiA1
         nIvdZhY1KwsBKixFrZuSUTMYH593/NM/f8oj3wS12MKrW2WyvGWUktX86hloOaNtFxWA
         fz+vvN6NTau4vG5sUyww+Caz6T+FUrbp01EkUksTLcEBNVqlS/g+LZAnMDuWcISsTgLw
         tCH64y1lrHHs1L9t90KsZhPW/Uk7OiOOgu2NsQJsIWwfhv0YRg9geUuwYHD1hJuQ3lk1
         SKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751642771; x=1752247571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFcYw7gn3XvFR5dV9V5g5nEHPo2D1azMjHDmYLt7hrI=;
        b=NUuAzCnKR9VYVvX9eItYnJKWyVILn7eEoqdRSe9AZkSf8gwzzcjRIxTSRSVrCF4h+h
         3x0C7QtfbRutvKyGcA8SflrzH32tCDT4VVJFjoQnX9nC+1ZSxoUQy44Jeje1UXRPASCE
         ObRhpFKYltdxz+43oYdnn7uy39SypXNqJq2P5cDOokGvrgVhB4vOPDXg3NiHGmvfPEL9
         3amfNkgBvLVBwV43O/r8YGNfdOGzSEvYxkZfTC+xiSPHoQ6KDLe1nRwFMBw++R1z/AEU
         2qtT6EaokKvTG1uLaCRL2oL7zd2Zp1RfJDvWVTcAAlVN9I62IIw9ljGL1msM8vV7rejE
         BiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOTsG2tkEOIPEbaATe75m4lhRSB/wucHj3TmpJo9VoZmB0jkSaUopE49XueciGiKHxTT0rNo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1lTpZYEoI2iTv63D4IrB/HlFrQtb0RNEn7s3VF4yZ7RXpmve/
	nk+6Hw3C5ZqLcgWOQJYiJFZw6uYl2Ci79VkAdJknx5uY2dXtunbTF35Q/sn5nT9/6dooy+35QV8
	J0+JR/0JkJAfadAxOtDLJ+Cyco43T4w==
X-Gm-Gg: ASbGncsordywU7XIwDz6lMoYLLY20ulDkkeeWHwNP12tZRppvAdOspar1QB/mN2+3Xv
	k8UoJC58ZdXoMZjyV0LsyqHvkGl9Kgy/Vna4QsK9oBJ3tC8n0gnBcqhwvgdgeftP1efgXk52or/
	65aFXjXC0eGYyMobUu2CV4RG2GJZzH/mtLREA8Fsc=
X-Google-Smtp-Source: AGHT+IFzSpZZJaE2lNNBNveIo7xz4ZGHPn+wQrjkxtgbKJNbQu1bAGmzuVB/xc3/lSQkP+AMHYM7bAAgP+CpZFCdVcY=
X-Received: by 2002:a05:6214:3c8c:b0:6fa:b83f:2f2a with SMTP id
 6a1803df08f44-702c6ddba1fmr15670006d6.9.1751642771366; Fri, 04 Jul 2025
 08:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704144830.246159-1-guoxin0309@gmail.com> <CADVnQymBGf3OW8oh8PBKXtNpxF5C=FZJTvaQe5TGy3uObZuCOw@mail.gmail.com>
In-Reply-To: <CADVnQymBGf3OW8oh8PBKXtNpxF5C=FZJTvaQe5TGy3uObZuCOw@mail.gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Fri, 4 Jul 2025 23:25:59 +0800
X-Gm-Features: Ac12FXxwqplqJXm1zK7ip8g5ZwYzKawrYMsHp9f5Gcdkk2Q9gc6AjA1H72OEpzQ
Message-ID: <CAMaK5_gQyf17MWgg_gV-YRNtVdA20aR3viNcsn-5_=bkW-G44w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: update the comment for tcp_process_tlp_ack()
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thanks neal, I will send v2 to include the other outdated references.

Regards
Guo Xin

On Fri, Jul 4, 2025 at 11:19=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Fri, Jul 4, 2025 at 10:49=E2=80=AFAM xin.guo <guoxin0309@gmail.com> wr=
ote:
> >
> > As ACK-TLP was published as a standards-track RFC8985,
>
> nit: typo: s/ACK-TLP/RACK-TLP/
>
> > so the comment for tcp_process_tlp_ack() is outdated.
> >
> > Signed-off-by: xin.guo <guoxin0309@gmail.com>
> > ---
> >  net/ipv4/tcp_input.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 79e3bfb0108f..e9e654f09180 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3714,7 +3714,7 @@ static int tcp_replace_ts_recent(struct tcp_sock =
*tp, u32 seq)
> >  }
> >
> >  /* This routine deals with acks during a TLP episode and ends an episo=
de by
> > - * resetting tlp_high_seq. Ref: TLP algorithm in draft-ietf-tcpm-rack
> > + * resetting tlp_high_seq. Ref: TLP algorithm in RFC8985
>
> Thanks for updating this! This looks good, but in net-next at
> 6b9fd8857b9fc I see two other outdated references to
> draft-ietf-tcpm-rack. Can you please fix the other two as well:
>
> git grep -n draft-ietf-tcpm-rack 6b9fd8857b9fc
>
> 6b9fd8857b9fc:Documentation/networking/ip-sysctl.rst:434:       losses
> into fast recovery (draft-ietf-tcpm-rack). Note that
>
> 6b9fd8857b9fc:net/ipv4/tcp_input.c:3717: * resetting tlp_high_seq.
> Ref: TLP algorithm in draft-ietf-tcpm-rack
>
> 6b9fd8857b9fc:net/ipv4/tcp_recovery.c:38:/* RACK loss detection (IETF
> draft draft-ietf-tcpm-rack-01):
>
> thanks,
> neal

