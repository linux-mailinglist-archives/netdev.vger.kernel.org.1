Return-Path: <netdev+bounces-174297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D36A5E31C
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAA03A87A6
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67C253B73;
	Wed, 12 Mar 2025 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b="qyrnPPt0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C31D514C
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801753; cv=none; b=dWfdTn//XjvDE5o15Q7MUhc7xi798J+xTHdhWiB3WiaSKZqYr8XxfbMwTVpQDnefIwQxVg9rZ3V5dOiZvQ6AVFbNo+yeWWrVIbFl5eZ/dkPeI52BgP0f2R6yENj0J4YiNrHkPCLASqNPhC9eIsGh73f4EycEJ3Kb0j508a27wlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801753; c=relaxed/simple;
	bh=UhFOofXeUy9Kfh+z6JPukMyclmx/WAfLOWtEeW1DqPc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=q34GKmgIInt9VUvIoO/8GCigZXVi7eFeUFuqQnTnvwRlP46+pvTYF8nddtAFhNCI0fpEEeFCtaSeASQ1wck7fjLJLauVuXKE/MBJvDzKsL5p+ybkWLez2HcSMo0nIsuocl5Z3ge+hZj8VLUgMv4upezR3+NA8Mr8GAQXuEU0SQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com; spf=pass smtp.mailfrom=8x8.com; dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b=qyrnPPt0; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8x8.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8fc176825so1598196d6.0
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8x8.com; s=googlemail; t=1741801749; x=1742406549; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXkT4o9+wLEJ6SgF7SPpca0L9wAUuklrDlLJu/Eq1Mk=;
        b=qyrnPPt0fLZ6IsVCLPgMvcFZcQv2ZcL9zH+D7cSqME2ygHwJS69rzb6gRuOH+UR9iJ
         qfI8DZqYBwPLgNoT9JOBaRkJ9eMKOotUB5YEPCGAI4OuNeJEvU/Y1Ex9BUWeLOKIlSlu
         dp4hsr6rtVMwQ6OlBq68RqsNRpx9M48f84Hz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741801749; x=1742406549;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXkT4o9+wLEJ6SgF7SPpca0L9wAUuklrDlLJu/Eq1Mk=;
        b=B/S93WV6/cNSe36UAF/2StZ5KOmxA5/2nIlqLW07GdU+vHQByv3WwF7Hq+cGaxGrhH
         a9SXukIczv4LEhZl401k63aYmPIMeSk7vNGh77fuSlUdqb/HwuOSLNpjino5Rz/OAqox
         pIqOZ2QIAkG9FH6FnJKETaLprNHFiwIhPpqu66Y1A1bSMGTFpBCDPJGvM6BGazpQKcjR
         FIs3H1phjcTIiWhF5fmCCL5vZ9LpQNu0wC/KtEFKytxhMUKcyARNNlX7bAzlJpTFZVmh
         312h3vwB4n3pwolc54f5X17ZSacetCC6nAbm8nYjRve9ZUMExzHco/9hWhzlJMCAgQN0
         RZog==
X-Forwarded-Encrypted: i=1; AJvYcCX6NRecejX6OJ0hHh4wd3/TaP9ZaWkFiwHxfnuFtooqB/yZch8/6/1YUPcYFbwzk1pFuWPJMlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6f6MH4rvubzXFcTPG8GnTiY3FHuYG0prB1L/eWG+lIJv4u2A
	cIruy/U7hjX3ZaeeFi06nAS3XiIiS+TDCmWCmPbZnDHFRnydQIjMwV3/YbPY0w==
X-Gm-Gg: ASbGnctBJoW1HQvKjWPpgQwiD7yOC+TN4aNFn065OtHgkq5dF9xjfZmLen+IoDOzy2I
	No5x8ACIXgI/l14Lw3PKYuUDIveHXgyuEhJzQTTPByLBSFLTudJXSDpXkxUN9Cbqi/PDMn/t8++
	+ta38ikz1u464bTrwz6sJHqr6VXDYtiRXNlaV5I+rVL+9sb9C0DlH19K4u29+zXAlHsHqPw2FAm
	F1L9LRab5sc4qWqEStkRYhuPdzjKQmguZ8C5X6e4m8LDefRhAzJ/ZhKkxyRZPheHeDj5nrTDOFD
	hDuN4hKnt9jpRECeBf67xjno+S/5m+PpRr5cMcN3g8baVAXTcawNtdXUM8JVO7V4t687GAq+Q+w
	=
X-Google-Smtp-Source: AGHT+IHdQYREOFSsD5DOLsyU7+c+xxXymejKOmIIcXubnW3H0nmWxcy+UQZXFwDREuFKVVuiLiZDBA==
X-Received: by 2002:ad4:5f85:0:b0:6e8:e8dd:3088 with SMTP id 6a1803df08f44-6ea3a6a6537mr135283936d6.37.1741801748676;
        Wed, 12 Mar 2025 10:49:08 -0700 (PDT)
Received: from smtpclient.apple ([2601:8c:4e80:49b0:cd5d:802f:3347:fe6d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b814sm86957596d6.93.2025.03.12.10.49.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Mar 2025 10:49:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH net-next v3] tc-tests: Update tc police action tests for
 tc buffer size rounding fixes.
From: Jonathan Lennox <jonathan.lennox@8x8.com>
In-Reply-To: <20250312174804.313107-1-jonathan.lennox@8x8.com>
Date: Wed, 12 Mar 2025 13:48:56 -0400
Cc: Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Pedro Tammela <pctammela@mojatatu.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <94A40403-ADBB-4126-8E9E-FC067E12A214@8x8.com>
References: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
 <20250312174804.313107-1-jonathan.lennox@8x8.com>
To: Jonathan Lennox <jonathan.lennox42@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

And with this I=E2=80=99ve resent it not as a MIME attachment, sorry =
about that.

> On Mar 12, 2025, at 1:48=E2=80=AFPM, Jonathan Lennox =
<jonathan.lennox42@gmail.com> wrote:
>=20
> Before tc's recent change to fix rounding errors, several tests which
> specified a burst size of "1m" would translate back to being 1048574
> bytes (2b less than 1Mb).  sprint_size prints this as "1024Kb".
>=20
> With the tc fix, the burst size is instead correctly reported as
> 1048576 bytes (precisely 1Mb), which sprint_size prints as "1Mb".
>=20
> This updates the expected output in the tests' matchPattern values
> to accept either the old or the new output.
>=20
> Signed-off-by: Jonathan Lennox <jonathan.lennox@8x8.com>
> ---
> .../selftests/tc-testing/tc-tests/actions/police.json  | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git =
a/tools/testing/selftests/tc-testing/tc-tests/actions/police.json =
b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
> index dd8109768f8f..5596f4df0e9f 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
> @@ -689,7 +689,7 @@
>         "cmdUnderTest": "$TC actions add action police rate 7mbit =
burst 1m continue index 1",
>         "expExitCode": "0",
>         "verifyCmd": "$TC actions get action police index 1",
> -        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst 1024Kb mtu 2Kb action continue",
> +        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst (1024Kb|1Mb) mtu 2Kb action continue",
>         "matchCount": "1",
>         "teardown": [
>             "$TC actions flush action police"
> @@ -716,7 +716,7 @@
>         "cmdUnderTest": "$TC actions add action police rate 7mbit =
burst 1m drop index 1",
>         "expExitCode": "0",
>         "verifyCmd": "$TC actions ls action police",
> -        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst 1024Kb mtu 2Kb action drop",
> +        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst (1024Kb|1Mb) mtu 2Kb action drop",
>         "matchCount": "1",
>         "teardown": [
>             "$TC actions flush action police"
> @@ -743,7 +743,7 @@
>         "cmdUnderTest": "$TC actions add action police rate 7mbit =
burst 1m ok index 1",
>         "expExitCode": "0",
>         "verifyCmd": "$TC actions ls action police",
> -        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst 1024Kb mtu 2Kb action pass",
> +        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst (1024Kb|1Mb) mtu 2Kb action pass",
>         "matchCount": "1",
>         "teardown": [
>             "$TC actions flush action police"
> @@ -770,7 +770,7 @@
>         "cmdUnderTest": "$TC actions add action police rate 7mbit =
burst 1m reclassify index 1",
>         "expExitCode": "0",
>         "verifyCmd": "$TC actions get action police index 1",
> -        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst 1024Kb mtu 2Kb action reclassify",
> +        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst (1024Kb|1Mb) mtu 2Kb action reclassify",
>         "matchCount": "1",
>         "teardown": [
>             "$TC actions flush action police"
> @@ -797,7 +797,7 @@
>         "cmdUnderTest": "$TC actions add action police rate 7mbit =
burst 1m pipe index 1",
>         "expExitCode": "0",
>         "verifyCmd": "$TC actions ls action police",
> -        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst 1024Kb mtu 2Kb action pipe",
> +        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit =
burst (1024Kb|1Mb) mtu 2Kb action pipe",
>         "matchCount": "1",
>         "teardown": [
>             "$TC actions flush action police"
> --=20
> 2.34.1
>=20


