Return-Path: <netdev+bounces-134224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC3A998730
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9570C280F6D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F9B1C9B8A;
	Thu, 10 Oct 2024 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMBhOVln"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F381C9B75
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565721; cv=none; b=sisTjDkEQmn/4mhJoUSKUfyHv8qEeFXAWHaYT1V0xGoG03eTb0IPsqcutZZejNSd0TpDGk+Fxm5Q0kcJWEi+KiX7xtf33XHE7j09eKmJSkKSsmCDy/I/GrhmFVHu1wLIerzG1ZAnb4lBZnTQ3RoUqDdqthIjxJb6ZkAOGhtIpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565721; c=relaxed/simple;
	bh=Fz2sg5FaCo6F6CVqN3Yow6+vx0LcPlpDk3BnV8C+OFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvbpuB7Iut+fJy9qQP6/Dbexo37x1AqALhNDETsw5U7/eTLeCTTdKiw74oQ1EiYHQVOWZtsyjUiAG1FAHSV166zSLHhzVVKgn0m30vHQrFvPA4XFAVV8SYozqL2RnRj8+HKjshZzfFZe+7fy5yKgWXs6guhQpMOq6GkTcSjLPB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMBhOVln; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso1185384a12.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728565718; x=1729170518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz2sg5FaCo6F6CVqN3Yow6+vx0LcPlpDk3BnV8C+OFU=;
        b=CMBhOVlnkc/GsfNLxWAM3sNQ3NA7x7bBlGQ4f+jYxZPGUQ18wfTZ5TZ/V/cQ1pQRgt
         5knSC+7YeqKeJ8xKsM2bfKuCHPv9wR36nrt2ajNOyd9OJ2h6VAX5FPyhiv+bYWvA86JM
         EW6RbQBGzjipFomTkbqIiBCCm9f3ctzxT/DCyHRrYIYasRCrEIWcsq2Gp9ZRKbuwVnGR
         21w4v3Yf5ByFawrr/ToBjuGuuTnIAdJ02PZlB7QxMD88iNcpmYOOYMPhuKyYoYRFUN4R
         YkoGcQwefeFy650F7ef+rqSWaqkdh6VoEWoIj4ijdcZvUI24QWCSdDO6rvf/NtB6D94W
         KbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565718; x=1729170518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz2sg5FaCo6F6CVqN3Yow6+vx0LcPlpDk3BnV8C+OFU=;
        b=gDrD+/aoFF3cqzSPclkTdopCnVzQHw+II/jfS1SRLjWu6892OLZX+fJwiJWcof8krg
         3WuKE9uGwYXRmgTKsRJ4/8edB6xD4XQ+GNQYEfjL1rcjtucpIglS+60uzg94obhFpe6N
         GWNFzt6+/oTkzipxczdSdebdoAMFwKQH07xc9VmryOH4ulLaRWJYvrUMACdSr2gQLwe2
         enUTy6+esOL7H5RGZ1shkjj5l+XYeSG+ecNKA5b1Aea19frXTZ/EjZE3zJPBiCz+TfGF
         9zWaS0hjf8OLSbfSxF5dT6Ku64P+pBEUPwJiYyMzYYgcrdqSEDnkj8m7Y/cDbh/nFWGf
         3hwA==
X-Forwarded-Encrypted: i=1; AJvYcCXwCjrNzrvsowfqaXJ2OOKI8knrwk0Q0aNKDhqKq0icc4uIzu2AVOP3N1SCJUv1qVwNZdcxIMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpfh97l4W1jJgIErUiwlqnEx2OMnKYfGlIoXJh+rhgaES3p2pR
	4vRkU8Fk5krLMzFF3ejhuIlHbkPIuD4rIi4L2z52nKvlStVyagZSFCYMAtFkfix9NYKmFGQSH52
	ebOmujcamnUvEfmM92UyxwHpRRGIVW51zgrl4
X-Google-Smtp-Source: AGHT+IHpiSq5bZom+TOnN0dNZje/WcvFdWxJSZxOhLgqkc8oLEXp82aDl5+2FOW8vJnSJAgnikUPKaomeBT8dvmF2YM=
X-Received: by 2002:a05:6402:51ca:b0:5c8:9f3c:ea01 with SMTP id
 4fb4d7f45d1cf-5c91d54d157mr4185357a12.2.1728565717539; Thu, 10 Oct 2024
 06:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-9-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-9-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 15:08:26 +0200
Message-ID: <CANn89iK=Zq+33yeMPA=x9EMmoLg0MvLbDksAw7TVHL=u=Lg0PA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 08/13] rtnetlink: Call rtnl_link_get_net_capable()
 in rtnl_newlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:19=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> As a prerequisite of per-netns RTNL, we must fetch netns before
> looking up dev or moving it to another netns.
>
> rtnl_link_get_net_capable() is called in rtnl_newlink_create() and
> do_setlink(), but both of them need to be moved to the RTNL-independent
> region, which will be rtnl_newlink().
>
> Let's call rtnl_link_get_net_capable() in rtnl_newlink() and pass the
> netns down to where needed.
>
> Note that the latter two have not passed the nets to do_setlink() yet
> but will do so after the remaining rtnl_link_get_net_capable() is moved
> to rtnl_setlink() later.
>
> While at it, dest_net is renamed to tgt_net in rtnl_newlink_create() to
> align with rtnl_{del,set}link().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

