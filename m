Return-Path: <netdev+bounces-176571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0CAA6AE19
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 20:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DCD18962E7
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E422B8D2;
	Thu, 20 Mar 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yfqavo+n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6022B8C2
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497244; cv=none; b=MPidKkXu5XiifpLYQkn923ZLEuu+TmKnXQpiTtX1WkWy/XaZhkD+3yVOZlL9P8EnRr+Aa976EMGz1HvkprT7FLtV0p2F/XDJRU9NUy1eESC+HOpdydWO05APhb0fn79IGIcD7gIBbT18bnJ7sjdIHFuhQXDGuwCP7OIK1Wi7GhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497244; c=relaxed/simple;
	bh=hT3Bl23mdQKBJmo6ugYoK0o8TKoJnd2PEfAaxSgJBNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwhuDhdwzHlVKmmxWESGGyl7qqzMo7DfGGhU9VYWdTTPTVYFnKkAy6ZobeLVwLFrqz3NKrAzttUcDp2g+tRbaUmDDYEwAFHWvucrv6rIqDcoDsWFs6Ov75S3mMKcWrhjF8qrnQ3gdqtgPu5h5bJiAaQrEGKRdt+ByiFzfy0Z3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yfqavo+n; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47664364628so12517541cf.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742497242; x=1743102042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT3Bl23mdQKBJmo6ugYoK0o8TKoJnd2PEfAaxSgJBNY=;
        b=Yfqavo+nKDA5Dmeqeh6Q82YhLS1suoEtPjvNyP40bcb65Zg408W1D1C+6i++dLjj7O
         l+l4++QPRnjAsShBnbaexcyX3urkPI6wznEPouQuJqgfjWCCDsfyc6p1ORPD1xyOxzGH
         jTl/vThX12ibcX8oF/wP9HEwUtNklmAO81ylEcaIHr775QvRZkmjnsm4lVl7Yc/y7hkG
         e1OZiGtrFiQHrEY2gwi+1o9hkbvmttuvHyM53itSe2Qg9LfQzkzdmCNKLCguSpFuXSO/
         iOEPzTejUhDW2FoqfLuGDGaqBj41MKswwdnaHfuHsTRUAUMSDf9FtNlXYHfyH1+BxeIW
         JaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742497242; x=1743102042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hT3Bl23mdQKBJmo6ugYoK0o8TKoJnd2PEfAaxSgJBNY=;
        b=PWaQl3hBacgFs4rObh/TX4FOfxBrdf0jMYjLjMJuAiDeAQgJxuF/SRDUkiwQqKf/qz
         BdaEWY9UuD4uZfxD1FPslEWFwM8iEbfLTGu9Sz7rsxi6ts1iyZBsMlzhxEhUWxcGS08q
         c33jo/ItLu0pTGncggd8OmcUA3ixfc784lDh5lg8ciFTBSMHqq3ITBjff9CeaHHpCmgE
         nylJeZkVT0hgjaca/zw4N0C0HY1yWXVgZVJafMb/hItFYeFgel/xL/c8kVCtuEkrCdGb
         qMSLSVzFNcRuQ1W/4CLuXaOdGTzWTOfo7M8au8b3RG2JRI9Y98CT/WG3k9x3ZC2pBPMV
         6dYw==
X-Forwarded-Encrypted: i=1; AJvYcCUGVY1pdoUDYMVvKcscnhwa2iOfQKYkCLeeVmP65s4Ost+yPs4CPhhRwLMIscSMy4gqmelH0Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvcSl7dTWUVuD4aUdgDMWk2T126+AtlCEix0g9GwF5DNkNoZ2/
	7vSHQTvlL0EblePJ99P2sxyK7dMDxuk7/vdW8oGk0fi/X6jSS0CAJ6YUM8sbjo3k9jtqXM30Q96
	PCibLfhVc0d+NfqPAzsSiMZ4VHokbnRIn1JSx
X-Gm-Gg: ASbGncs0nMj3lQSVyO63tTg00mjOQJ+x3f/3d+qkkQy/ggai2krQINQWO6SdyauhNj9
	biseC91qhC1/fEEKros5cEXwJyCo3AdMv1MZoWt0L+PFAs4Hla4YWYY4NjVWHZxIPtNlQ63Ou0Y
	K4iBFx3ruL6KtLxmfpw8bqEMpk
X-Google-Smtp-Source: AGHT+IGgCO1ZOkc/CwISgAGSmcEz462ZGKfmhMYjsuYWwiSFF7AUVnREbQJUdX4WwKM4HyRzSiEozRuu5SFqrV6ry0M=
X-Received: by 2002:a05:622a:4d0a:b0:474:f5fb:b11a with SMTP id
 d75a77b69052e-4771d90b6cemr9343511cf.3.1742497241663; Thu, 20 Mar 2025
 12:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318154359.778438-1-edumazet@google.com> <20250318154359.778438-3-edumazet@google.com>
 <20250320183858.GJ892515@horms.kernel.org>
In-Reply-To: <20250320183858.GJ892515@horms.kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Mar 2025 20:00:29 +0100
X-Gm-Features: AQ5f1Jqj_QtN6gDStGhQX4tA_dX88wFI04l2ZA-JN-hR9gDfap0Dhn5q8Vzaj_4
Message-ID: <CANn89iLD2jEm5wVhCVEmr=dMp8mr6PVTrzZDmH30qL=GfBmVHA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] tcp/dccp: remove icsk->icsk_ack.timeout
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 7:39=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Mar 18, 2025 at 03:43:59PM +0000, Eric Dumazet wrote:
> > icsk->icsk_ack.timeout can be replaced by icsk->csk_delack_timer.expire=
s
> >
> > This saves 8 bytes in TCP/DCCP sockets and helps for better cache local=
ity.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> > v2: rebase after "tcp: cache RTAX_QUICKACK metric in a hot cache line"
>
> Hi Eric,
>
> I hate to be a bore, but patch 2/2 does seem to apply to net-next.

Hmm, what is the message you have ?

It applies fine here.

