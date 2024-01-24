Return-Path: <netdev+bounces-65683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEF383B578
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 00:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA912870E9
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 23:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E80136644;
	Wed, 24 Jan 2024 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cTbN8dia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6177A136648
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706138054; cv=none; b=K8yXkxed0L4Ra+TK0aArt7Nz/ZpyOygBK1lVD5v3Px+BCzn4I71bLBVipLvnKbo6w0w8AjOk9olcamjbRen8EKhxkwB+UUfAIR7Z7MlVrYRPkKTc8JG/vZNcSd0WlDRRZo9Nmpuu2r39XN4oB5GdHz2vbMXxPWOqEg9PdJ5bMx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706138054; c=relaxed/simple;
	bh=RL1FPGFx97vdxv8Lfa1KUrrT8VXdTufY9VgzHnoZztk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoHS0OGkT8WBT7cCY0sTMmnorvm/GwLqxKAb7pk822qWPKZDj1b13np1A7eJB9D2ZZItM+iOiRnWatOXktAX9WAwsBb9TLZZeyRkHnDyhFJA4KR4TU4L4hjsYEDAT4n8dSHakoM0oUCZBkzzhMmsyL1+34t5dquBfAFSLyS3L5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=cTbN8dia; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bf2a5cf9cbso301608239f.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 15:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706138052; x=1706742852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzq4IXd4HXuOrpuiNgMIMKbhN5u0gdDI1Cp6D3KRaEc=;
        b=cTbN8diaKTeW025xYlqgK50yqpP7jh7Or+AGa+p1B5XbsUE4CNHnSlFYh4adYm7l5q
         CYKE/v9qXVIkPqcbWuJ4oSNGx/RFDD8MKPge+kIagbXDkRvty744ed5/0ZjJnez50Y9f
         LjNsobYYthT0p3vFQaIyBiVk4Blw9iGAXX9CsY0ozq3tqYcuK1XKyZ9HgpLa6zJRhK9X
         qvVsstF7dolpGQX9RkeawFqkZ5G4WciDDrd6nQ0cYkurbQkZmOmYO+kA4gtZbbtixPyJ
         j7JjzcdTkGlKbM7uDNkvTp/ZR48E1gI6/qDQ43inF+BAL2ChGFPjjCzgzdEF7HZIhBhO
         4TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706138052; x=1706742852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rzq4IXd4HXuOrpuiNgMIMKbhN5u0gdDI1Cp6D3KRaEc=;
        b=NIuFP3k8VcxAYODtaX9QMwHVB6U8x1MkSxbQ/IaMTVu6kjsqA1RgpSill+wS8dvQYe
         6X4zGkrAz9nsAWSWuBTJA6M/oNEe3W25cXJBVos0io00xvDRqM8GchRHv/OpJhxgAsXi
         T9KKciDg9TrBMEUFahJRgqlJT91Tz/Nkrcs3Ocy9akMT/Flb8flTeg/P4sdCcqXvMm6Z
         56VSJgQl48wuF7XV/perIz53YGM3748QSNVoSS3yYODp69tdchlnSeZfaYvs1bBWpLYp
         5qKiaucxNcrl3wds1prddtZcf5vUUaKjfcDpOXapKq5coxb/RWMliONdXUbICkiQkVGo
         CQDQ==
X-Gm-Message-State: AOJu0YxAQleEOp9bMJo80j2agXL/LwW52MmFTkR5mGqeQtArsRX/E8gy
	u6/9NapQsJC0Zz/31eFSLPZdHxKZZMhi9NYzVaspASzCS0IutVDj/bPZJ3XOePAvSPA9qheHDHM
	cNUNMjR8ixHsnfqDHA+eZhY/rHaH8p6Ev/E/R
X-Google-Smtp-Source: AGHT+IEXXopI18+SvzNJ4aBmsQG4SsHXjOJ3gep0MqsEIFoyePoRbQekeBjAEitxSJ5J2kCUMHZC+cOdpFHQ835LP5Q=
X-Received: by 2002:a05:6e02:923:b0:361:989e:b09 with SMTP id
 o3-20020a056e02092300b00361989e0b09mr163478ilt.83.1706138052517; Wed, 24 Jan
 2024 15:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124181933.75724-1-pctammela@mojatatu.com>
In-Reply-To: <20240124181933.75724-1-pctammela@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 24 Jan 2024 18:14:01 -0500
Message-ID: <CAM0EoMkocaasvDNZNim-mDjtEY72BJ-MP=db92oUTP+9PU=4DA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/5] selftests: tc-testing: misc changes for tdc
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	shuah@kernel.org, kuba@kernel.org, vladimir.oltean@nxp.com, 
	dcaratti@redhat.com, edumazet@google.com, pabeni@redhat.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 1:19=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> Patches 1 and 3 are fixes for tdc that were discovered when running it
> using defconfig + tc-testing config and against the latest iproute2.
>
> Patch 2 improves the taprio tests.
>
> Patch 4 enables all tdc tests.
>
> Patch 5 fixes the return code of tdc for when a test fails
> setup/teardown.
>
> v1->v2: Suggestions by Davide
>

For the patchset
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> Pedro Tammela (5):
>   selftests: tc-testing: add missing netfilter config
>   selftests: tc-testing: check if 'jq' is available in taprio tests
>   selftests: tc-testing: adjust fq test to latest iproute2
>   selftests: tc-testing: enable all tdc tests
>   selftests: tc-testing: return fail if a test fails in setup/teardown
>
>  tools/testing/selftests/tc-testing/config                      | 1 +
>  tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq.json     | 2 +-
>  tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json | 2 ++
>  tools/testing/selftests/tc-testing/tdc.py                      | 2 +-
>  tools/testing/selftests/tc-testing/tdc.sh                      | 3 +--
>  5 files changed, 6 insertions(+), 4 deletions(-)
>
> --
> 2.40.1
>

