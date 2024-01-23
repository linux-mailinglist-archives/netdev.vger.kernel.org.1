Return-Path: <netdev+bounces-65052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41585838FC5
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 14:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A012D287568
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262AF5F574;
	Tue, 23 Jan 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeG/bYAW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6455F570
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015872; cv=none; b=kDu/8sT+PsRk22yKXYAtHqmLc/WrTtA7oNq/IIGyu4Uid2opvpPnv5V3p81duoS6awiYL111DGJnBwHvsPrfNAHN+Rky4jY/7RvscnI5RJhBQI8BeDwmLiQZ1JvQ/jrTWmAaSWPYF1bMz4Hz3TKBQQJ6tVe6wm6rGCM9ZsXwQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015872; c=relaxed/simple;
	bh=jnct+Lzin4gh/Le8F45er7/TXL58Sl7/KC3E0pdohAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXfYyXUtQhE+Dvb0usgTefDdZLZ3BV6pObnI9dm1HuVnMNca2rQZDjsdJDr8cTPy/EJ1zIx5YbXvSriCrEn+xDpfHhF4Dqu0pWycRsegODcYCgEXjK+Jjn83aDxjLP2mCw7CQKRoRW3lVto32rP9s+hCh6riqOBqPEpdeR3/QDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeG/bYAW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706015869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBJWnNPWK6FEDvgCqnbrqrUFcx4g4CvzlBj7l9Q5CZo=;
	b=UeG/bYAWgURJf7Z9wjnwRJ5BQ/yBMSAVZcuZsmj38CdE2E9/LvTjH7WFV0UKiAGUfP2hyF
	aEhibpVkF1aMvlWy29B5zqY6NSX8BHkBnYs4ciTVVWuiLg0x9oSUXuo0d1Wvw7+MeWg6uq
	Qu/UC2G9V3Wu2w6BCWRrum1BeWenHcs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-SV9q50kwMruaSTLr9S9y7A-1; Tue, 23 Jan 2024 08:17:48 -0500
X-MC-Unique: SV9q50kwMruaSTLr9S9y7A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5100a0f0c55so398346e87.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 05:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706015866; x=1706620666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBJWnNPWK6FEDvgCqnbrqrUFcx4g4CvzlBj7l9Q5CZo=;
        b=P8jQO5wGo46xtu62CLdG5pKkERgRdSiFC/81FkdrGg+NaSulzglB6TJ6TL4o+KbLmd
         VvDMQKUO6HakP9MTZYveDNzwRJY9hVe+BDYaIp5b9E9jBMHaCCJ24eQ60vlgN3eJEg8M
         BKXecN/o3ds5UJGow59wuTcg7MU/3IyJP4N6GCyW8d82RE0Qxco4HvAZXwL06MaT3nGn
         QuHbnL5f2h7Q1sc9STTXuyQXK/fwqQNL8YWa6MffP//ztl+aLjR4S70lWha8iPILofX6
         V8SbmoBoEamCUjcpQ431S/QD22IvO28c1nmY+36k2W1ixrnAotMyIlOjhED+cYsXR5LF
         YfVQ==
X-Gm-Message-State: AOJu0Ywupv5iJ+yGWmaRUM+aQPTxNXZ9BoZZeQxzZ3m6pSBT26w869so
	+FRoWdsQI3Smu4zTyN4mTDFjBd+TJHfXiscf9tk02tX+Mk5N1EpKgWij0ft+L5/eAHILDFV6ERr
	boZaMNGHX56n2ToyarajqFIu8Nop9Vx+3TrgnSpV4z9rLCGIEEsNzMYPHDpBaZEL9xw8yvEGFVN
	rvsQtRNhnHD5/ArZFU+1zJ76qLfwBj
X-Received: by 2002:a05:6512:3b84:b0:50e:6168:c99d with SMTP id g4-20020a0565123b8400b0050e6168c99dmr2912632lfv.27.1706015866519;
        Tue, 23 Jan 2024 05:17:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7bPWvAk9q+1bk1V2Hwy2Rx2s8Ht69Kfn6jl0Hd/iIWEVFa6+7r5fF4lK4xsfj0+ptN1K/qJVhi/WY/v9H5+I=
X-Received: by 2002:a05:6512:3b84:b0:50e:6168:c99d with SMTP id
 g4-20020a0565123b8400b0050e6168c99dmr2912627lfv.27.1706015866249; Tue, 23 Jan
 2024 05:17:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123122736.9915-1-pctammela@mojatatu.com> <20240123122736.9915-3-pctammela@mojatatu.com>
In-Reply-To: <20240123122736.9915-3-pctammela@mojatatu.com>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 23 Jan 2024 14:17:34 +0100
Message-ID: <CAKa-r6s_DO1tfcZdsQNBCwjbE0ytJKnZWnvcKqTR+5epdNq4YQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] selftests: tc-testing: check if 'jq' is
 available in taprio script
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, shuah@kernel.org, kuba@kernel.org, vladimir.oltean@nxp.com, 
	edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi Pedro,

On Tue, Jan 23, 2024 at 1:28=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> If 'jq' is not available the taprio tests that use this script will
> run forever. Check if it exists before entering the while loop.
>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  .../selftests/tc-testing/scripts/taprio_wait_for_admin.sh    | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_a=
dmin.sh b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.=
sh
> index f5335e8ad6b4..68f2c6eaa802 100755
> --- a/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
> +++ b/tools/testing/selftests/tc-testing/scripts/taprio_wait_for_admin.sh
> @@ -3,6 +3,11 @@
>  TC=3D"$1"; shift
>  ETH=3D"$1"; shift
>
> +if ! command -v jq &> /dev/null; then
> +    echo "Please install jq"
> +    exit 1
> +fi
> +

nit: what about returning $KSFT_SKIP (that is 4) if jq is not there?
so the test does not fail.
thanks!
--=20
davide


