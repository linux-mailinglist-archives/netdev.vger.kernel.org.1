Return-Path: <netdev+bounces-144430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F29C735B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E3A2810C3
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3004206B;
	Wed, 13 Nov 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bLGS2ikW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC8044C7C
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507534; cv=none; b=kjs7LU7mzq5eS0QO1cTh55YVtSmfToDbZHXvXJfcDFaCZjFGAEcCKDfFa4Tvp7uv5ErgyVmSGJAyvvpFedI/k2q78dGKA+BxF+XfoF3MAkcrndSYE7B7otD9eXBLLT5qM4HcWvQVm3Smoboj3OnJSYI+Dz0fvfovvr1HG5T1gGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507534; c=relaxed/simple;
	bh=j49UUxEThZYMsvh0KjxoXCvCrW1V332fJRfSbAupBA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etfKO/2/sBQCJ0AxQN8UIhukXKFNURubiBUM3yBalvr7Ey11PqtPaNuHwuOGYfizDF+XdoABdBB6FHajp63XhG1rO0uFd4wMnB+s61T25VQYpcIQtAF5sXuElubPDCJ3trBYSduFwT88gFKAOIAaunEn35LjY7Fuu9SWY24OvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=bLGS2ikW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f43259d220so3861153a12.3
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 06:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1731507532; x=1732112332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoUGrfEhT5MRt7zJdBopKPBmKkYcf3AUf5s3dBmlzhg=;
        b=bLGS2ikWzaj74knFS3973FXNKBMzMGZsDM2/yMhnHPWyy8N7yzyP/T68folNot8J/Z
         2Z4FUQgwhVkSUwACKVEteTRpTHf3JMObQ5gNCoyzJcp/rtqe0GpiOdiiqA5s2q8qAq8i
         UIV4+5ytOObGiKzkxmOhe6s8MnguEq09OCSQlVGR7vjBmaceHNWZ0GmnOty322Xl/GoG
         PYeuQxSYtc49QhjncYvTtEwYBIN9BIk5mswY5+z7jL1lGokVaK2CWwrR7csQDDT9z4RA
         angbgSKJmZc05X/PuD70L5tPSi37Cp0O41xtRUujtIbI8UV4iqUW/gwULZMk4Q1HhKL3
         wG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507532; x=1732112332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoUGrfEhT5MRt7zJdBopKPBmKkYcf3AUf5s3dBmlzhg=;
        b=B1XyFAQcN8p4NGs2Oz+wWn4nocpVvPe33z/LxssnaHUkERL+OA3Sd2VSmEUO6hHO8q
         D0RgzhD58DJZ3WadJJ0rs13P7qn8E2T/FzsrVlERrRJbAAbr2gJl8zj3vcaaie06EZAI
         lkC3ljhGbbo0oSfEdQ2X9wuTNiJ4ht1czZlGuBQmibegLPE/xopn7jOgeTzJGVj8yI/Z
         +3N66X1V7JtCC3lZ5IlhE6UvXdlmISiBPoP5ycRh0Tj1ZHWcVzaM0SVaB22shxRS9DN/
         9PMVCUrzG7h1545fQknFtStCNc/nwLA/26IfuZ6RjdTe+kGt69Yu3/6HURQM3oq1yXVU
         YB2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTgjDX9k4IOlzIXihaXZF1x+8vJIwO32/F3kQwMCw+YoAIBIC6WfoVA3PPpwYxdbH+DXeS2H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSKCq0blZLT+mzNow9DkomJ859mWjMyRzio1rJ6X023zeRC0So
	4v6UIgmG+yMZ+CMBGCJ/iVwd56LrhH8MBwWgD6wnUiwkFUScB9jY0zRyheF2g9TklWQ65lHMQEZ
	R0GRIS6R0gFUh/phQhs8o4Hl0GBjkwn1STXmH
X-Google-Smtp-Source: AGHT+IFdIEmDODHTP80UzqJ0qb5/wLj3ULU0wXsBiTVKYG4soKWVR2vobDAXoMUPL69RCCwzzPpi+zw3NND9f8G7P9s=
X-Received: by 2002:a17:902:f688:b0:20b:3f70:2e05 with SMTP id
 d9443c01a7336-21183e1218amr279042565ad.41.1731507531963; Wed, 13 Nov 2024
 06:18:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113100428.360460-1-alexandre.ferrieux@orange.com>
In-Reply-To: <20241113100428.360460-1-alexandre.ferrieux@orange.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 13 Nov 2024 09:18:41 -0500
Message-ID: <CAM0EoMkiA0hMRcHhS=LCFFrFu5+ameW=3nvvg8_2n_Krvog5vw@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: u32: Add test case for systematic hnode
 IDR leaks
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	horms@kernel.org, alexandre.ferrieux@orange.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:04=E2=80=AFAM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> Add a tdc test case to exercise the just-fixed systematic leak of
> IDR entries in u32 hnode disposal. Given the IDR in question is
> confined to the range [1..0x7FF], it is sufficient to create/delete
> the same filter 2048 times to fill it up and get a nonzero exit
> status from "tc filter add".
>
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  .../tc-testing/tc-tests/filters/u32.json      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json=
 b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> index 24bd0c2a3014..b2ca9d4e991b 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
> @@ -329,5 +329,29 @@
>          "teardown": [
>              "$TC qdisc del dev $DEV1 parent root drr"
>          ]
> +    },
> +    {
> +        "id": "1234",
> +        "name": "Exercise IDR leaks by creating/deleting a filter many (=
2048) times",
> +        "category": [
> +            "filter",
> +            "u32"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
> +            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 2 u32=
 match ip src 0.0.0.2/32 action drop",
> +            "$TC filter add dev $DEV1 parent 10:0 protocol ip prio 3 u32=
 match ip src 0.0.0.3/32 action drop"
> +        ],
> +        "cmdUnderTest": "bash -c 'for i in {1..2048} ;do echo filter del=
ete dev $DEV1 pref 3;echo filter add dev $DEV1 parent 10:0 protocol ip prio=
 3 u32 match ip src 0.0.0.3/32 action drop;done | $TC -b -'",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC filter show dev $DEV1",
> +        "matchPattern": "protocol ip pref 3 u32",
> +        "matchCount": "3",
> +        "teardown": [
> +            "$TC qdisc del dev $DEV1 parent root drr"
> +        ]
>      }
>  ]
> --
> 2.30.2
>

