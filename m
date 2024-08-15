Return-Path: <netdev+bounces-118803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE759952D0C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1B01C233B5
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51581714CA;
	Thu, 15 Aug 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLBk3JDc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB11714C7;
	Thu, 15 Aug 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719351; cv=none; b=PQPII2jzRVlJqeiJuSHe3d0CxTZEuSOz6oQ05A1yhaM89eii4lWU4oj4onBLC54C9Lq3z3/KShlLLhg/GdUrofh6wx9nuab7XC7BLLIK1Evg5ty1Cl9BLCn1VWvWTRK98vIJJubQNpMN9oqlbSFk36q9J0jq/WDfrsKHN5wz9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719351; c=relaxed/simple;
	bh=/72rfX+YiMkMUgxytbPepgk+knvV4BhnjOyz3uMGzjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCcCQL51JYX1q52sCLm8uH3fkoQaZWw06CECZgPf7H8K0cFlfLHFFsf821jvjabdEdUJ2DbTV6spF415jWm8NdiDaQ/pDi5blAypHmHXpJE+qeM1Voqo+1b+sJFsn6ly0PYRGHnzB1gkk0aXvz0o7fQS1/HXXSQIK0LeQUQP8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLBk3JDc; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39b06af1974so3208315ab.2;
        Thu, 15 Aug 2024 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723719349; x=1724324149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq3e63JJfshSV/iURmoXTbaaXy+LAxhsVm5SlNG7wmg=;
        b=JLBk3JDcUTf1qUU7WjNKDsnr19rQJCBwHzPfDXvcJVu78e8b91WeU9w1lEjV2dvIYR
         i+ST3I4zs15Ud942dZeQH38DqzSdNUZHLnWHcAd2Q9KDFvnSdmsxeS75pu2cauoeCRT0
         GtTiofoc1TZSVjKLIej8znKKNtta8u2Vb7BDpnDYmmtLjBfVYbk/VRyKQitBvdEUwH98
         ch0ZHJxkVOdBvjXz00LrMkNj634fRWDKHK8JUl1uc3AtCyZ5eCaj4uEVUEHAbtK1m31m
         n+OLdlLTz5/i12hL+haTN5e/iO6Bq7jU4ouEGNoWUct/zeF8msEqVeDcaStVvBrwDnc/
         Yz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723719349; x=1724324149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fq3e63JJfshSV/iURmoXTbaaXy+LAxhsVm5SlNG7wmg=;
        b=kgnYm4Y7FQI9lhPm0h1xH01uDovPWiES3tJ7sWlq3bbFkuzLdgU4EhqHfaBBzAApZx
         /v+8GG4wsBPGx4cLfQ5zhS5cHVej4WXEB3td6H22KHnv1h3ykxUfiQoGqniG+fFU2Ej7
         JAHSzsmW3Lj6AbOUpBNRVPTplU1CIbsjKKzJhS0Zsa+xzgYeNCxCuKxvgchpDkSyvJ2x
         KsLxZQ0/RkTfLxdl9bCO8QeGrBuUp7oPk1NaVpcI3plnJxEkdY26JMXYEOnngzVjlLGs
         50EgcHBOWoGQJwXRFhCBvUYFtqlqjVcn7AI1vnazPlyAn0M8ExQY3BFzOgPuLeh4fc14
         ePfA==
X-Forwarded-Encrypted: i=1; AJvYcCX+TLF9zncUgTkDvXO26nXHOOEWS8p76UUDkUDVzyehSxWSd9aVM5p3AeBbyE+JBogSU1e1/1PgaDMUqzF9N7Vm/IlYJ3zaqtw0UW93QHUauIq3vIUrJpqAjjaYxU2BICijg5pf
X-Gm-Message-State: AOJu0YyMy3oWUxisSlqlbMZ5aO5CWa2AY2x1GxV/ELrJMzajQzWS76gV
	uiYwCTFf3bR0nSeJc0cmDAmylzY20Gb6/qQ7JF2R/fSZuUH5W9E8KB7z5KXdMsJlAYs3dge4I2s
	9NpXejXxaHaYrcmISan29ooxQb7c=
X-Google-Smtp-Source: AGHT+IH/mgNoYK9/PN2VRqMXh9yqT5NmsaG1yAJC9H72kqBcNujp/MK+w/6Eq5qiXGxt+8LsTMHdPf+UmQyiTklJTLQ=
X-Received: by 2002:a05:6e02:1564:b0:398:acbe:d798 with SMTP id
 e9e14a558f8ab-39d1244131emr73893065ab.4.1723719349221; Thu, 15 Aug 2024
 03:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815084330.166987-1-sunyiqixm@gmail.com> <66bdb158-7452-4f70-836f-bd4682c04297@redhat.com>
In-Reply-To: <66bdb158-7452-4f70-836f-bd4682c04297@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Aug 2024 18:55:13 +0800
Message-ID: <CAL+tcoAiOwWEsbkqSJ3kpwLxd8seBBUOAODeBideFdQYV7LfWg@mail.gmail.com>
Subject: Re: [PATCH] net: remove release/lock_sock in tcp_splice_read
To: Paolo Abeni <pabeni@redhat.com>
Cc: sunyiqi <sunyiqixm@gmail.com>, edumazet@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Paolo,

On Thu, Aug 15, 2024 at 6:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
[...]
> > -             release_sock(sk);
> > -             lock_sock(sk);
>
> This is needed to flush the sk backlog.
>
> Somewhat related, I think we could replace the pair with sk_flush_backlog=
().
>

Do you think we could do this like the following commit:

commit d41a69f1d390fa3f2546498103cdcd78b30676ff
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Apr 29 14:16:53 2016 -0700

    tcp: make tcp_sendmsg() aware of socket backlog

    Large sendmsg()/write() hold socket lock for the duration of the call,
    unless sk->sk_sndbuf limit is hit. This is bad because incoming packets
    are parked into socket backlog for a long time.

?

Then we can avoid taking the lock too long which results in too many
packets in the backlog.

Thanks,
Jason

