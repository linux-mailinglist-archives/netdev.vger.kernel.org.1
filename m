Return-Path: <netdev+bounces-174293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4EBA5E2E9
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE5E1899AAA
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C521D9A54;
	Wed, 12 Mar 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b="dl1EuTAf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B640E70809
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801361; cv=none; b=YB0KjvRQD33JFR7db1QEULzsMx77l4+lBievCvUo+BZX7JUQ1hKNZsv64fMVliWEPrZpuwAlxrh2wT9CdxVT7Y76nNzCx8HedulVpdi+ivjlyys5nYlA+XlZ5pOiFz2ykDdmZQGv/RV59V/9JoPO3WZM97d4HweNQDZD+jLjG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801361; c=relaxed/simple;
	bh=kPaQaEpbEQjCQ0VCtOKHKrfgLMinLkdrKF6ur3KaGnk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PWWq9f2sUn9UVjjw72UaX2pzPhR71dwU8GfLTSK3CNQjK0E7dbfFkkRT1WmuHOI7PuL2xJ+q7tvaFhDYFx3rU9FkQD6Z7PM0ilT9ByTLHg6sSvQ6qou2vJlHAgvPJA0k50MPHOChBz9OFx2N3XzBbjg+XPoxax/mAP9vj/F13gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com; spf=pass smtp.mailfrom=8x8.com; dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b=dl1EuTAf; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8x8.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so10896466d6.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8x8.com; s=googlemail; t=1741801358; x=1742406158; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBro14nhnMSGpUAO9zUrq116vsgsjRP5H5HVdDijs84=;
        b=dl1EuTAfjq2VEdhvFapNMiMtIL67VNsCJf59wS7wyHDpQlFUqUF+0DaxpGWZr5ZpnF
         gETXhlQt+TtUs3Rxde6kODMCF/NH1gi1axFYtkTGKFGNB9hc62BlQEqpiMzHpMeSbF5Y
         0nj07pc3iy37dENn/Ac4p6jbEe4yCI1fcePfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741801358; x=1742406158;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBro14nhnMSGpUAO9zUrq116vsgsjRP5H5HVdDijs84=;
        b=p08kWFK7LGwiC08vLTOUNMzRA++D22PU505uxDKRT6OG96gN5wsX3y0MA221KDdcBV
         /T9kcfINjUC3kBomu1SSINIrACwWhZ9ed24IF9zJrFb4Jm2PCn4ISDdjj8K7gyj5p/GH
         mMhilzl0rwarzpiJhx2ZixrRnjFix3ce94kcMXyBeudGL9/uny0ebYHBKN/O6OgMvPCV
         EBFWn9C4vX9OaSA4NvFEGK5rN1R8IVy3LRbEw7Wqwf5qZSIdgNeXx85kWMaIgbttj2bW
         D/O8uVpSK8cw/5/Xfk8ZmL1ykcm0O4qb9RJx0o6LckA460RDxgKK64FrZwujS+lfbXtF
         stnw==
X-Forwarded-Encrypted: i=1; AJvYcCXkzCz0uHiPzO9mUU3Z4tWM0FWWL8QibZIDt6qPGDvFMIyFgEdlEX+50EKIUbcu7XA/fHDQj/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WZIpM3BeeuNQY9DHOxCre3r5ivuEZJ3HRn6rctpuFhy5CyWR
	iOzADXXM10PHCFLOwdnOsxFGimKa19BX25anW5JUeDcUWgSr4nZi//6iKGz5KQ==
X-Gm-Gg: ASbGncujmAx+75xd8BDsAcyj56soDA2aDIyiCdTwSuRsPm64licMdAKfAL8NCHVGkGO
	HeTQaKNWFtsLhYGmk4AS1zcFB4dKrF1V0iZt0khGh3OMS1qMOwuUuFOVjQFIZ1JdgG/a0BN/iIp
	Psnu4w3v+tSww8JruUgecekebRR0wqaxHdghWJvVdyq6VgCTdFuYSruKlKEC+A+r+aPjclQ182R
	/WmJeAdrxldQBjODRo6krgD6h3hqOTf9qLbDpmvkr6kBDRhWP43DTOXcvIDQWND+BZyPMmJx+Eq
	CaWDRlav01zemow79LzR5IRGhvyQm6WftOHkbDzyib0DRwurZkb1AH7BfFcbjn+U6dIjHpJyHlw
	MlNmUG0OiJViYF+Czx9PCTdQ=
X-Google-Smtp-Source: AGHT+IGAqZoqI5KygCuxBd2eayhAbiC1ARdxxZkPYNgim2821MrpefAdU2rhXUxgwxERWl17SAMybQ==
X-Received: by 2002:a05:6214:2269:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6eadb85cb6bmr6899846d6.15.1741801358537;
        Wed, 12 Mar 2025 10:42:38 -0700 (PDT)
Received: from smtpclient.apple (collider.cs.columbia.edu. [128.59.13.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7185133sm87367736d6.125.2025.03.12.10.42.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Mar 2025 10:42:37 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH net-next] tc-tests: Update tc police action tests for tc
 buffer size rounding fixes.
From: Jonathan Lennox <jonathan.lennox@8x8.com>
In-Reply-To: <CAM0EoMnmWXRWWEwanzTOZ_dLBoeCr7UM4DYwFkDmLfS93ijM2g@mail.gmail.com>
Date: Wed, 12 Mar 2025 13:42:26 -0400
Cc: Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lennox <jonathan.lennox42@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Pedro Tammela <pctammela@mojatatu.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A7F44CD-DE17-4CC1-9270-7AAB5555B9E6@8x8.com>
References: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
 <20250304193813.3225343-1-jonathan.lennox@8x8.com>
 <952d6b81-6ca9-428c-8d43-1eb28dc04d59@redhat.com>
 <20250311104948.7481a995@kernel.org>
 <CAM0EoMnmWXRWWEwanzTOZ_dLBoeCr7UM4DYwFkDmLfS93ijM2g@mail.gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

I've submitted an updated version of the patch with the regex accepting =
both the old and new versions.

> On Mar 11, 2025, at 7:15=E2=80=AFAM, Jamal Hadi Salim =
<jhs@mojatatu.com> wrote:
>=20
> On Tue, Mar 11, 2025 at 5:49=E2=80=AFAM Jakub Kicinski =
<kuba@kernel.org> wrote:
>>=20
>> On Tue, 11 Mar 2025 10:16:14 +0100 Paolo Abeni wrote:
>>> AFAICS this fix will break the tests when running all version of
>>> iproute2 except the upcoming one. I think this is not good enough; =
you
>>> should detect the tc tool version and update expected output =
accordingly.
>>>=20
>>> If that is not possible, I think it would be better to simply revert =
the
>>> TC commit.
>>=20
>> Alternatively since it's a regex match, maybe we could accept both?
>>=20
>> -        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst 1024Kb mtu 2Kb action reclassify",
>> +        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst (1Mb|1024Kb) mtu 2Kb action reclassify",
>>=20
>> ? Not sure which option is most "correct" from TDC's perspective..
>=20
> It should work. Paolo's suggestion is also reasonable.
>=20
> cheers,
> jamal


