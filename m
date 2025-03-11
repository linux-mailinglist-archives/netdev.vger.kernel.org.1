Return-Path: <netdev+bounces-173833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16C5A5BEA9
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E06716D83B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E3125485D;
	Tue, 11 Mar 2025 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="H9I8GJlY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B5254845
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691739; cv=none; b=Id3Ga+LE1m7cQQgyDuR9GffsS5mtgGOAhPVwB2DCgy37kcGHZhcxYIIVx8PKKrKP6UYbJcLpVu2nMQ1lgnmoJ073227vRYAakTEGUSfoTvkOYaFVT4siVeymFM2CdcfOj7dD5y182e561NmAHWKIe4nFTY9mYtKCq0uQoo7fvug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691739; c=relaxed/simple;
	bh=1pQbKMvE7/Ym11EKgbPtHh/WuEZ0L/jI200+BewULTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAtg8/Buax+PKhmP2U/WcFulb4DL8ZEzDUP2K3Kk9GPvbt0l0jSwLwBNYwvhcOSj6BuHxmG07/SQf52VZWTzQSOfKzXfn1kw69tDMZW4eqoEdAu3F8X8+Rjm2caaduu4rOeawKqRzWFwx/FqAUv0H1s+NWrFDLpNX7KNnpvsDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=H9I8GJlY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so8466985a91.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 04:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1741691737; x=1742296537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/l28AgEnrLfdAJHbDgSCi5RlMOZnirPzN89AYZrdVE=;
        b=H9I8GJlY3PNWbieFPZnL0p/kisobD5QwJozTY9qHaLcTa1w7bDOgdYZTCCyiE6QFCa
         ruwdg0Xt9mq4sKmmOST1ITXPvjcn35A374nAvekv+VcZ9CkHmlxLLQ/+IBBzoAfK3Z3q
         fqOOeY7xkGRZO6f9RORXYJ3pjsCHuuA4Hyw2BUHgxiEM40bNdy/oxiIcdMbmpgYbnlfi
         ZWenVT1hbgZliTJTircPSPlwmRrdAzJ4rS9J9/NfDMzwgarE7B2PXmkAY4CgnQii20Ff
         zHNEhggFjz1dC/TO6KC1RejPV4J7S6Ou1tyOgPB/iBpmbG5jtXSyWYZ5zB78ytHVYPR1
         3jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741691737; x=1742296537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/l28AgEnrLfdAJHbDgSCi5RlMOZnirPzN89AYZrdVE=;
        b=MzfcOWRwRINe/dKFOyCiZcgH+U1rW7aE8MdwDApkMldTKrIloxhBm+lQwgiTB2yEvu
         dFsr+jPF0ZeHrQMkgJRr/hsFFtuHDEeYgwgHSeOj1ayvnSSP/NjNyN+lPXw2l81hLrOs
         iKRS+26WD3DmrYBftI7l6j+YDhMh10jh7aFcEmi4ZJ8zeXkVOCcSw0MfRoHDBqDynqF4
         oHVyORzPF4r8gr05ZBXTtji7XE0EyoO4ewRFP/O8fbmawPhLfJZHq64M0LWeiMq+y485
         zmelamDDGcV7ipdt+Q8mE9lEaXyesyqhoCogN/+FVwP8G5EaLCXkHWI7Ny6ODxpPYXKG
         ND5g==
X-Forwarded-Encrypted: i=1; AJvYcCUqoopJevEUecoA/WhwcC87mmV+3HfZOfOMXIFZyHGfx3O+e3xMCI9CLynwOOTVmlgx974O/fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBCOPuZqgjJT4bRkNLKxKDAVU+bKg7yrzDnKtsd89v6yxYx9zW
	3rcGaFlRV9kDj9CN3HYY7AgNY2rxSt9Pav7WnqnT++3EHW5sRuLSN+D7fuZGWy9XMGSGFW8sNZQ
	Hd+k5tihapLuOZ8eRg4zqHDXg9Gm5Wxwh3NK1
X-Gm-Gg: ASbGncvxinL5WnqlC4ETca/fV82wLOchtVs5DiscGJIrkLmVlqu1cjybqnVX/rvW8bv
	LwGcKMY2xgmiBRC3+FWcgBHBw4tfKl+jOpUVjULnBUqxrHBLTMcq3MD0eatCtH17Jd08fHk4scF
	OlvIYvu18PBmn/OJlBTWV4lLFYDw==
X-Google-Smtp-Source: AGHT+IF9YjmXWCY1KcbiuD2d718ZMx3sZu/PpUpVyjAvhNqDrrmMdy79MLDUjXYMWIpwEi7kUKo2xUYMS+5JAQaQMGY=
X-Received: by 2002:a17:90a:d2c6:b0:2ff:6608:78e2 with SMTP id
 98e67ed59e1d1-2ff7cea99b3mr29977736a91.16.1741691737626; Tue, 11 Mar 2025
 04:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
 <20250304193813.3225343-1-jonathan.lennox@8x8.com> <952d6b81-6ca9-428c-8d43-1eb28dc04d59@redhat.com>
 <20250311104948.7481a995@kernel.org>
In-Reply-To: <20250311104948.7481a995@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 11 Mar 2025 07:15:26 -0400
X-Gm-Features: AQ5f1JrrAvf3ZhbbJTKQpTCZn4QFvoKwqsDLT57DwPNUAT_Luq1r7XmdJA5ONa8
Message-ID: <CAM0EoMnmWXRWWEwanzTOZ_dLBoeCr7UM4DYwFkDmLfS93ijM2g@mail.gmail.com>
Subject: Re: [PATCH net-next] tc-tests: Update tc police action tests for tc
 buffer size rounding fixes.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Lennox <jonathan.lennox42@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Lennox <jonathan.lennox@8x8.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Stephen Hemminger <stephen@networkplumber.org>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 11 Mar 2025 10:16:14 +0100 Paolo Abeni wrote:
> > AFAICS this fix will break the tests when running all version of
> > iproute2 except the upcoming one. I think this is not good enough; you
> > should detect the tc tool version and update expected output accordingl=
y.
> >
> > If that is not possible, I think it would be better to simply revert th=
e
> > TC commit.
>
> Alternatively since it's a regex match, maybe we could accept both?
>
> -        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit bur=
st 1024Kb mtu 2Kb action reclassify",
> +        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit bur=
st (1Mb|1024Kb) mtu 2Kb action reclassify",
>
> ? Not sure which option is most "correct" from TDC's perspective..

It should work. Paolo's suggestion is also reasonable.

cheers,
jamal

