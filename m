Return-Path: <netdev+bounces-134208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80786998694
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C23B21D71
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375A1C2DC0;
	Thu, 10 Oct 2024 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ap1prMXe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB441C5798
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564541; cv=none; b=LF7UpFRqokQTvPSk8q60KZWEKiiUdwZK7nfMHeSVTf5pXZl4+TTDsLYoaQMvlgOkCy0b1LciJQ85DhHz4Y/Umkc4F8KXzIbV5O8V+U7UZuX2w44YwB4iEzsohu+MeczgNc6VAyuNq8yzdEZBpW0MzwwWCNSqmMtVDbe9gc8FjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564541; c=relaxed/simple;
	bh=GJHBYBTeCXQeuR4x95MO6onZRhdh9HB3S/KeFoBipb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jG5gu7bnxKIKQ77EGgFO7N53EWSR7B+WX83y/NAViiLH3KH34gKjyrcToRK0HViOJqbIHBdSeTVYNG7SwnsfORaEAP1VQAeCIngXhJ8P1c+VI8k5u/9Q9iKbHvaVwE/obfqkZWz0R9Lt8YJ17VHAjH2oPL8E3gCJAYrup/8zNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ap1prMXe; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so1127997a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728564538; x=1729169338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJHBYBTeCXQeuR4x95MO6onZRhdh9HB3S/KeFoBipb8=;
        b=ap1prMXeTcOWVo7IA3e72HQOTddfSDvqKae1kQSQUHwsn08cNKARVgc1gPMkN1EA90
         MHaTjIxfN09l1LiOlob9gKfZTzzmEKPnTvsz3iK3dy/5RKihZQOfj3Ekn5Fl3uPhCTuy
         1hDpGN193frfIjYfJ8lFEm242CeqRMK8Qji98LiIMoNI4d53JupRX67Rl3SYOdZGKEVk
         5PFUXOg78E6Ji0L2S/bL05+hNzdcVow/u8SSIT/LZeZUSD8w3EX284oO9K4qcFrq2Dp5
         7f/Y2y8ClVfqP2e8ugR/9NkiMPgoF/W2hEj2+l6g/nnUZxjQWThcv9rErLh7vSZ7jNsA
         GOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564538; x=1729169338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJHBYBTeCXQeuR4x95MO6onZRhdh9HB3S/KeFoBipb8=;
        b=STbHIIWxPJQSvef3iwDD6tb+VgbLZLn47bg0kAfQGVQ+EaK7K3MLQQpPNgOzE4p3ue
         RRCkIDixkxvuZ9o3S4hJwUtHwxrKTEFH/AZWw3KmgfuCi1lnQo6M78xdoLVej5ObSEIn
         nEjWcefBs/KVxxj+1wdcjjnr2Yq/VMr4TNSe2TbmNFhGyXADsOCzKeCVUWGOr32j9LCQ
         Hv5EHGc3o0rQuPqdzAqmuyuBFG70rORPV3jyagzyOBuRwrHdUhQ+dbTxpPdRIhhUaF2M
         08jDF4rkUdj1G16hVpbseAjMFFbfepfbDXpMwWKH4jaANvoaZ8nJlsepyWfumD9LYpjh
         ndzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcienyhjCxJAyn+1F0636EV+dGHlbC8sLHEApNKLY3FV29jPJYWdGV6b0bFbhekyeDRDloxUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxixz5lvyPZHW2B5tQJ5TWS+nExgQzBhL1Irp7kRIEgowxp3nPL
	oaxCiTUj0hYJnFt9ZM9vLBDTeoPdTUS9hWLjdIWyVcz47yCT/Fz1hPIUb4UX4dicCVAdhE/5D3y
	TT5vgWcSrpNfKTNqX/k6YZqtdTWlEvKOvfVw/cAMoM1U6wT07V9J5
X-Google-Smtp-Source: AGHT+IFUemCxhLlvJYU8kcvlJAd4UbcTr0IieumwhFoAMYxHLclHMiZ40Xdl3RFzoA59SLOLSM/mSNxGh4Mqpr0nyXA=
X-Received: by 2002:a05:6402:40d4:b0:5c8:9696:bae8 with SMTP id
 4fb4d7f45d1cf-5c91d667872mr5524389a12.32.1728564538212; Thu, 10 Oct 2024
 05:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-7-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 14:48:47 +0200
Message-ID: <CANn89i+QLe5HT0rc7U8qL8ZxYXGap0kX0b4cLj468dm6h+jxKg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 06/13] rtnetlink: Move ops->validate to rtnl_newlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:19=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> ops->validate() does not require RTNL.
>
> Let's move it to rtnl_newlink().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

