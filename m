Return-Path: <netdev+bounces-93220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D1A8BAA97
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 12:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68DE2844DC
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDCC14F9EC;
	Fri,  3 May 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlGL3H5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4BC14F9F8
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731513; cv=none; b=T862I0I+ZAon5o4KlyuNacFG31MCd1o4cMy1yfMbgjLQ9tkwiLIVKpUils9TQtuBjgc1U2qbySt32XKJik9FNZPkh7qDKZzHHVMISRSr6O26MRR9yu/FxCrjJS1L/y9ngS2rHtbp6AdS0NT4sVj4S9jJ00hb6OpHmK4nLKipbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731513; c=relaxed/simple;
	bh=z1RM2AZucoVbpGD+yIbTGTAe9/SCauSVk5ykbcLAGSA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ChKXR4aa0ggk/7S5BcB/5PQ8cn0GihKcUjU9yHjichkkbX+GGMRxSJA0MYOqokFIQDWhUO6CAL5ZW+SnsB7oPdpljpboJwVzc68K13WuKhhAn/2Xlb2Yah5u26NLgYwj0QPl8NOQImmWGmOy4uVC3WpQOCZUox5sFq/HlPECWtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlGL3H5i; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso63935915e9.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714731509; x=1715336309; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfDHb85z1DkjQut1/Jkb3/MNWNmze9D3fbDna+xKi0U=;
        b=GlGL3H5iqErnGL8RIrJfskkJB/r5OFhJ2pgfzpEQaZggMfnwQxi1OAA4FGF8diSjlw
         gUTtV0nAoLPIUs273I8M7D/VmAl1vgfTzPRZYGa5TxL+57ThP9brh2+4Y3IT9TzrvBl5
         NiNd4I3b6+CLj3Ddnv5h1zsRmOW8KLmG1lWarjzztkKyn9WoYEbDFo6eb+vy4UVASyIk
         Ie1S5RSHoD6pmf8OJ8G/lITW9HSb+ZZ7+0ckYYjbKI93CWjC7ECk+KoxMZiogDDPFEfn
         HAoOtGY6mir2mdEsQQEAmL087/4cjjMlaMiVr23jvN4oFv3gsC5E9iP2GsuQX+IUKdU6
         c/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714731509; x=1715336309;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfDHb85z1DkjQut1/Jkb3/MNWNmze9D3fbDna+xKi0U=;
        b=oHU0NGo4dZPKxBe2XmRJpJD5SlpoGE5RwhpwC/+Z6lsOBz4FQWHv/5ehPrTDHyv3ZL
         d7J4+tOcR2PyzMOu01tnkWRL12ZgaonHda3yYlwmiPziYg5SEU5vfS+ZlNRs7eCoFYJM
         Iw5GLllBMNH7df6uTxE8yfecG1qZtfZ3Q5aSk5tP2cklt5n7X5obldQ4x5m8LnXmxfja
         goIPxl0jUlP9XSBz7oVq8vD0GplydpMC8upaHn63GbXTZ/gK5qoCEHFbQEnsaKlMuUEm
         jCSR2qdK+2HYIjVlVyWzfkhQZ/myANTgDg1BxxK6eSCo+7iom2WNIVdOLCxoT0F5oxVp
         LJTw==
X-Forwarded-Encrypted: i=1; AJvYcCUO6Jr402+6utgs7BDtjNXQjOzjLMIzrRHDiIukKuB/KS2f1rl1xgF97D9faiZAKau35SMFe3eh8uaEBf2FwrWDjJNWsW0W
X-Gm-Message-State: AOJu0YycFLg5jzuQEZN2XlZE0NxjCP685MAygHe+zyAxrgybKU917l+1
	tqyBgtICPpD7dcfMyJZS31/vLdOqT6lMxbYLisRLVJjWNmv8OjGn
X-Google-Smtp-Source: AGHT+IFn/a+JbV+fmYeO4uz5kTvn0QJoj8eNQrHf6DtE9kSJvghDTmF/ocsCkcTBsPaAqruu7Y4kVw==
X-Received: by 2002:a05:600c:1912:b0:41b:fbec:a53a with SMTP id j18-20020a05600c191200b0041bfbeca53amr1801986wmq.16.1714731509441;
        Fri, 03 May 2024 03:18:29 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:fd6b:a058:1d70:6e1a])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b0041c5151dc1csm8875588wms.29.2024.05.03.03.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:18:28 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us,  alessandromarcolini99@gmail.com
Subject: Re: [PATCH net-next] tools: ynl: add --list-ops and --list-msgs to CLI
In-Reply-To: <20240502164043.2130184-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 2 May 2024 09:40:43 -0700")
Date: Fri, 03 May 2024 11:17:37 +0100
Message-ID: <m2fruzfbcu.fsf@gmail.com>
References: <20240502164043.2130184-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> I often forget the exact naming of ops and have to look at
> the spec to find it. Add support for listing the operations:
>
>   $ ./cli.py --spec .../netdev.yaml --list-ops
>   dev-get  [ do, dump ]
>   page-pool-get  [ do, dump ]
>   page-pool-stats-get  [ do, dump ]
>   queue-get  [ do, dump ]
>   napi-get  [ do, dump ]
>   qstats-get  [ dump ]
>
> For completeness also support listing all ops (including
> notifications:
>
>   # ./cli.py --spec .../netdev.yaml --list-msgs
>   dev-get  [ dump, do ]
>   dev-add-ntf  [ notify ]
>   dev-del-ntf  [ notify ]
>   dev-change-ntf  [ notify ]
>   page-pool-get  [ dump, do ]
>   page-pool-add-ntf  [ notify ]
>   page-pool-del-ntf  [ notify ]
>   page-pool-change-ntf  [ notify ]
>   page-pool-stats-get  [ dump, do ]
>   queue-get  [ dump, do ]
>   napi-get  [ dump, do ]
>   qstats-get  [ dump ]
>
> Use double space after the name for slightly easier to read
> output.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

