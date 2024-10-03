Return-Path: <netdev+bounces-131486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F39798EA0A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E33A283A91
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AF11DFFC;
	Thu,  3 Oct 2024 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQZuAnpD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0AF80C1C
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938973; cv=none; b=t/OtAzliyiv0IZSvUOCkyhefC/aJ4d7sRIgKGPY/fMmQDHPcMGFjhFn8TY/SXQsAOzeOdV1yvZtQOhhBsLM84Xp1wvW/Te2uEhLVHuv0LaP/aRrQfCRad+jnuFydqYa+AhbIsSJ7nPWlircf/q4prEmNhh1l6lHWCKaeS07aTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938973; c=relaxed/simple;
	bh=R80m6FLhuYwBYmhQ9yA6xouo8L6MgDnVELyzJ+9XgvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9GRuedGg7YWSAA6zRbqqC9Dqa3YFnceqPDldHQp6Gmv/0kR++XIMjP5rsZjnRP1rHKwRMoVelZza8CPDZptbdVUdhP9hV0hJgnMpW96NrBn8BcnAKtuWZOPYv6Pl6ih22NVzXS4h6K/MhkEvf/JbEeTFP1CHD517mAWJuUHoD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQZuAnpD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4582fa01090so185571cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727938971; x=1728543771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx0AfnRiM+WZN516cXx+TjqRJEo1BlPabKf+kkqEj8I=;
        b=eQZuAnpDF0ObHax2NPhScYVpTW+VtBzFvxPy4qAMC7OKHmLKa7WnF65Tk1/vrSwx6u
         v67MZgmEWemxAGKZhugiMBUfXDMQdHmZCPnTvV0eavzZISJhJfqa3l8ApTMbNTxl6CHQ
         uDDR4UhqTbfS409iODmRfyfNihY1IeAWFBVg7r0Bxol447T9/HiBh5pac8AbZ3YRyOnC
         avcN5dfFrQwiUozRjtdsyPFS01oRn33IDn0HwtsuvBC9Gax5rkobBKM9VxzqPu3e1PiZ
         g1CZdXtFPgvVatp5VJ7eOfc9etUoccC98nEAujDcj8K3hK2WsN6Czp0gwXG3fj6+Pcd0
         3d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938971; x=1728543771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kx0AfnRiM+WZN516cXx+TjqRJEo1BlPabKf+kkqEj8I=;
        b=KUoZxZVpipQKRv8YHOQ+1tAgbouTfoGrUgGSli+1w5UWqAuSn34qOhu/IqB3GxDWiH
         2y8R48qOd3MSXSQuWw/6dZklC9pNjIU+zEHjsVuabfUxdlcM+YiCC4GxgXvA3nDn4nDW
         /K9EfcdDPJXuWrEKHWjs334jsiKyJzKwX89/zMe3eDUBNwrV0DdHXTcVwCLNfdXX+Xn2
         FRWw56jjCeTB8LJ9RfHMLlXzrgsz09Or7BWXPE0+rSRPHmxWtQ0JyQKBnPY3J23FijKp
         tx8AZrQX0xFS4f2Mnf8j6ncEC3gz9jikxTHOKlli9i+D5aBxZsEPDvRgFRrhIVr5lxtE
         DrZA==
X-Gm-Message-State: AOJu0YwcKU54GbbA7tyIfoSx+5LwHOuQbHnC1hSTJ0G/16fVoAMVhI38
	NEd/hQh4Gy9a+3JMTaroQB27kzXp2qDvL4W2vVRIFBZFEgOxP5BGWwJiZn4SooRprmQWE2d11qZ
	2ZkB6rQjMxSQUJodKWmmsiEeRrAtpwIvD74LqtNsVOjOsBMdX0qCG
X-Google-Smtp-Source: AGHT+IETuXfhZJ76Q2zowfpoH63cVumcWI5SScC8VOwkBXRypNIRtB7C09iIb442KbAZvXaIHdso9cNoxmyOlXGugI8=
X-Received: by 2002:a05:622a:7ac7:b0:456:7f71:ca78 with SMTP id
 d75a77b69052e-45d8e1d1eb1mr2530891cf.4.1727938971016; Thu, 03 Oct 2024
 00:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-8-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-8-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 00:02:38 -0700
Message-ID: <CAHS8izO0Z6soYWLeU0c-8EKP5monscFqpnw6gn5OkxoqwTxKbg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 07/12] selftests: ncdevmem: Properly reset
 flow steering
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> ntuple off/on might be not enough to do it on all NICs.
> Add a bunch of shell crap to explicitly remove the rules.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index 47458a13eff5..48cbf057fde7 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -207,13 +207,12 @@ void validate_buffer(void *line, size_t size)
>
>  static int reset_flow_steering(void)
>  {
> -       int ret =3D 0;
> -
> -       ret =3D run_command("sudo ethtool -K %s ntuple off >&2", ifname);
> -       if (ret)
> -               return ret;
> -
> -       return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
> +       run_command("sudo ethtool -K %s ntuple off >&2", ifname);
> +       run_command("sudo ethtool -K %s ntuple on >&2", ifname);
> +       run_command(
> +               "sudo ethtool -n %s | grep 'Filter:' | awk '{print $2}' |=
 xargs -n1 ethtool -N %s delete >&2",
> +               ifname, ifname);
> +       return 0;

Any reason to remove the checking of the return codes? Silent failures
can waste time if the test fails and someone has to spend time finding
out its the flow steering reset that failed (it may not be very
obvious without the checking of the return code.

--=20
Thanks,
Mina

