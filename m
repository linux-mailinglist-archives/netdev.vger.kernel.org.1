Return-Path: <netdev+bounces-71662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D487854962
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 13:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062A0B2743D
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58508524C9;
	Wed, 14 Feb 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUGN1aqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3D54F89
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914379; cv=none; b=i8EjcKdJQmXugbKsZ3hMj1sFH+c31x/WvQKImb57Owv/Q8pssnDF53KfGymoHfho3YCU9DopjGT75+tem0Cpfdr+1sqllUPahvOHI34DZHRXZQ+l9zEXMrRJBO++z96gsVa3I/9vxp3bBaD8e8RvVBxLRXQ4yEf+WSB96yv2Y1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914379; c=relaxed/simple;
	bh=yuDNJZhXLtk8II/PjKRuFf7sAeJmfG/nxdSGciSjp80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJ/DUC+0wEZ6nuzM86H7CkSoZ04FMg88sxz/g9kc58e/FDOP2TViZ94jt49nceVAxdsQ6Oi178Odf8pZYCzqCt98ZqjslzIPZbgXxomg4FsyyXQlqakb08y/kDLZ/1UEQWVKBOFLBbEv8Sd3jUb3nKMrEHI9aOPKtxGIOBWGayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUGN1aqs; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d11d180652so5015141fa.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 04:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707914375; x=1708519175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuDNJZhXLtk8II/PjKRuFf7sAeJmfG/nxdSGciSjp80=;
        b=gUGN1aqsgk1cQFZ+EdvyW+mdKMWynNDhWwEemgt3Eb9ahPB6gL64EebNFLN9pnylJL
         p/UpSaqmmg3NqftjFHAyzf7XHSZWpQdSKljS8lulEG7SC3/slocZ8aUURCl5aGOmINJJ
         PgOTfhPGV7PbCmtDbQ57gONmBLIDDC8UFfx97CW7TWfmEFkAmKbDofWL9wfCwrII7FZo
         WgEYZv21tcMI2WMsVJlRiLupKeJE5uoEa0fgLTG2dYp4xXn/fQ4yT4h13csmrHG002EQ
         p7nCS4pthUNeHJvPBfObu/xDMw9GiOL8a37uEjNekcYSquYz0oUF7ExCC6dUvC8RddHc
         lhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914375; x=1708519175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuDNJZhXLtk8II/PjKRuFf7sAeJmfG/nxdSGciSjp80=;
        b=trgvhX7wpKcTztqyUsB4mixhCLIX6cVUFnvQ3Z4QhX27jmLV79esG8p7dG2ZrRTLXz
         hBFUU8dQGWKazuSdxYAxdKRHLQ80TrDBLN6aZRi/FrVKfqtqvM5ra0SMFbiY032/V41e
         MlCN0+5HLvlD/ba/yhqc9m8Tg0PC5iJwUggwvuclVv/NGs3TNFugK7ChbZ6Tie/9Vj3b
         PE/vVzHQ3Gw24ZCBrMXMntqqS4rAV19ma/H8plDWdV2c2rlsP4+K23KK2O9aAg1jlusK
         /El9eOyNItwNFG+OT1saiJq2BXwreqRz6fucwAJWfqQ7NFF2Cla8PEpL47a1zd6ljQf/
         qFVg==
X-Forwarded-Encrypted: i=1; AJvYcCW5NcVbLImqpa9aS5IqYNz/03tVQiQfRKlmPzjFsbrRy54ovYLx8hLPycqWE0MYJC3YQi5t6+q2xHlEPfLqfcz9wLfxVnlp
X-Gm-Message-State: AOJu0Yzm6rjnBcW0wc+wzau0CmKGfEW7NrrknIPK+m8pCTcGTy4tRv07
	VSwCazJbeb5CcdZxaTm9rMgZ9NACQ/FP2GSEp1RMIqApDH5WvVyGi2KthLaC+VEMgZOcCRHXeJ/
	t8jeGMvYo87of2q9jDDLlABtnrO4=
X-Google-Smtp-Source: AGHT+IFo0ZEiXsQbwRduD60IOC3hYmurZ1z4gIa+hy8ql//uBp9v66bCBrBiBATTH6K042ZNUXJRvF76xkdDHxk/B08=
X-Received: by 2002:ac2:596c:0:b0:511:45e4:8577 with SMTP id
 h12-20020ac2596c000000b0051145e48577mr1803999lfp.54.1707914375320; Wed, 14
 Feb 2024 04:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213140508.10878-1-kerneljasonxing@gmail.com> <20240213182338.397f6d29@kernel.org>
In-Reply-To: <20240213182338.397f6d29@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Feb 2024 20:38:58 +0800
Message-ID: <CAL+tcoCDBRVRJteao-pWup+qgKXm8kt4ukLP_FQVD7MZ8ApOrA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/6] introduce dropreasons in tcp receive path
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 13 Feb 2024 22:05:02 +0800 Jason Xing wrote:
> > As title said, we're going to refine the NOT_SPECIFIED reason in the
> > tcp v4/6 receive fast path.
> >
> > This serie is another one of the v2 patchset[1] which are here split
> > into six patches. Besides, this patch is made on top of the previous
> > serie[2] I submitted some time ago.
>
> Please do not post two similar sets at the same time.

Okay, I will merge them into one series.

Thanks,
Jason

