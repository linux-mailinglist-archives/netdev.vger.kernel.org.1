Return-Path: <netdev+bounces-210715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3177B14737
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 06:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E4C16BAC5
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 04:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB5224892;
	Tue, 29 Jul 2025 04:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgW9KdAg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA62E3708
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753763139; cv=none; b=qS8Z+ERp2Z+/dZwnv0yFG2pWE7DNPk+Y2KnVPdELk2AYDfZ+o93/RQL92eiRPGTROGOvAU4soBKWkRGWlfSiC/p3M+gpAiXtKqLZS3AelhFXQEojnpfIlIWJJiR9ZxCF5UcEHJuRunqbr5tu3peWhVXr8pJcC6PK0uxcZoXukkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753763139; c=relaxed/simple;
	bh=BODnPCvUTZGjiXzYW+aJ8034PM9Q7bkl1hBuUxiMro4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNbTHA/1IU6UpyOG61c4dqiOg1B+Hw0/BKUYxiqtlY1g2SVWSXsrW+4RVYzfkOK3LDCnmUOf2oJEA8sDc7VHRDyy0vlQ2qZokK74eKbfTQuztdZf3W0m4vnM3eGljRc93o9RY3eBVl+2FyWksP0TXLzMBh2746F6MyErg2R0984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgW9KdAg; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7494999de5cso3542948b3a.3
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 21:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753763137; x=1754367937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1sjO4+Qyzrg1nD5b7u884Dy9sHAmr0qq7YW+VDQr/Q=;
        b=TgW9KdAgq4BbNehNeIDUEgXqZlOtK8RQ5ggALk7fNWnhIJJDsoPKHKrjaqSDoixBMY
         N2rNbwjXT2TWlT8jiyO2+klz6bmtpSZ7lRKCgXDF59E88GNdW6H9mR+3avCsjck1abPw
         9fIHmVSearzVTv3jyfmXpFjhLElg3tGS17B7bgHtlNChk7fzdS5+4U7DyjDiTUKHMTZE
         20KqnGyubqkwICVI4zRW2yU7/BX4RyLr34zkJye3sSFAklI1hCvTv/IK5xxYuUpoeWno
         SOGiQklQKG1lnJi1YC39yDNop3XP6YHjTx7S7dSErbtkvc5joyAiu8skwFMaLrTUGCQK
         wuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753763137; x=1754367937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1sjO4+Qyzrg1nD5b7u884Dy9sHAmr0qq7YW+VDQr/Q=;
        b=mCMuPq6PB6CDluuzXRZXlNNyrvKfVAiRF/9XDCSobZ4p4m3RCAT77Hjm/6zYrsIhGZ
         zt80aacFp6StMHgJQBuOBtDs7g4y870x4XXj8hcweTrInIAkPg4C0AHpJ3qhZLBUXlDO
         /mi/NzhHkk6SDeWnVx2RmyCGMDLd0ZeoTojh6CxJ6ThErofyASprhCkdLkRtue8iay0V
         sZlBIiLjyPQpuQJEO116vueqgpirpGSI0n3lyGvRHETE01rzGCMomeLK5I4u0b/wCtSj
         by8X1NBXJOF/zW5/gT+VPcV4nxysUO5+BLjdAf4pmr9t8Xk4WwDqv0cltKYX69rVojEH
         xYkg==
X-Gm-Message-State: AOJu0Yy7HONzGmSakzZbrKjXtAHVGGGg0muG/dQl2OwWQI9w/Jqx/b9T
	3WJ+gtVOOjdlkD9tz5LPSXNHjeN2+ykcoBp68+pMpTW8wVqOGOdPdo+3HaM0RlqXbjE1USal+CW
	HpRvLceN/uBDqASh1ict8OuDeuTYVAg3ncOzX
X-Gm-Gg: ASbGncsIOgNR8zwwLSjC4vTH7xZ5/p8Um/8cmbCb+DkWG7VB1erChZbTEd2ZjHGs4rE
	UWPbtH43LuTUPT4u9UXNMb55ctOCR+s4B1+sAb0A4M+GlWyqEZOQ2zDWeWHmSTqmp9mNXqmp0o/
	gUOSvzFQAngM67oNC/con8pZkyiK0TSAehacBuaAPWaR174Nk6AP5e/CDEQmRcrFb+UVpO6rRxo
	qK27cc=
X-Google-Smtp-Source: AGHT+IHje4r+XT7I/tfABnCnHe3Z8f74KUq+bypoHHZok2dP/nkJLw5/jDuKO4vQuT2OZfZ7bbaAZ8jwZONFrmpvKW8=
X-Received: by 2002:a05:6a20:3d26:b0:235:b6de:447e with SMTP id
 adf61e73a8af0-23d6ffeb19dmr22248946637.2.1753763137258; Mon, 28 Jul 2025
 21:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723061604.526972-1-krikku@gmail.com> <20250723061604.526972-2-krikku@gmail.com>
 <20250725154515.0bff0c4d@kernel.org> <CACLgkEY4cRWsRQW=-PSxnE=V6AvRuKuvYzXSuofmB8NMJ=9ZqQ@mail.gmail.com>
 <20250728090155.384b2b14@kernel.org>
In-Reply-To: <20250728090155.384b2b14@kernel.org>
From: Krishna Kumar <krikku@gmail.com>
Date: Tue, 29 Jul 2025 09:55:00 +0530
X-Gm-Features: Ac12FXxJQkM-4SWsSskJJSpG9naneryCX7SZCIZxZnAIm19zu0TXHg7E96D_5PM
Message-ID: <CACLgkEYKCt6mohhqFat+xaJOYd0Rrgz-ZK8FKQkZ2dzSwXhXQw@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 1/2] net: Prevent RPS table overwrite for
 active flows
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	tom@herbertland.com, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com, 
	atenart@kernel.org, krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ack. Thanks for your feedback.

Regards,
- Krishna

On Mon, Jul 28, 2025 at 9:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 28 Jul 2025 07:43:25 +0530 Krishna Kumar wrote:
> > > > +                             if (hash !=3D READ_ONCE(tmp_rflow->ha=
sh) ||
> > > > +                                 next_cpu =3D=3D tmp_cpu) {
> > > > +                                     /*
> > > > +                                      * Don't unnecessarily reprog=
ram if:
> > > > +                                      * 1. This slot has an active=
 different
> > > > +                                      *    flow.
> > > > +                                      * 2. This slot has the same =
flow (very
> > > > +                                      *    likely but not guarante=
ed) and
> > > > +                                      *    the rx-queue# did not c=
hange.
> > > > +                                      */
> >
> > I took some time to figure out the different paths here as it was a
> > new area for me, hence I put this comment. Shall I keep it as the
> > condition is not very intuitive?
>
> To me it just restates the condition, so not worth keeping the comment.
> You could add the explanation of the logic with more justifications to
> the commit message if you'd like? (perhaps you have it there already..)

