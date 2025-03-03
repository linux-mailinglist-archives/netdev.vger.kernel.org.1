Return-Path: <netdev+bounces-171405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB063A4CDF0
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 23:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EAC172A2F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 22:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756B22ACD2;
	Mon,  3 Mar 2025 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b="IsTnPVcm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E51EE00D
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040009; cv=none; b=hADO+wmvMouTLqK0B3+ZifdPRSDVHwU+GOTHqo6ybR25qCKLyiJdlojN+Q6FrucKNOvASAqmv4op+DWlATKvPtdKLhlk8OikexRuO5CFJCMDIyNXIXmCUmdudMeBU+UFyZZUAOB0t4k27WWep5oDoifgQokPcFG4cLVC4rAPE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040009; c=relaxed/simple;
	bh=ze+Oci40CtWca35dX5wDJUB+NYa04P2ZNNBlBhcw4Go=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KUAmvkx8S1gVwzkXnkvRQBIFD3VmSexjCTK4VnQE1TIpEw0l1Dz8iiGLCknHmdjBSBvNzM2xx7WU5kVBd1OKga95+hizwAs2ECypEX5aIAQrDVXDgIgjg7Ue3lRPawekguyo3aPd6AaSd3bhbTfzBS1pcjoQ6amA475n/eyl2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com; spf=pass smtp.mailfrom=8x8.com; dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b=IsTnPVcm; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8x8.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-474eca99f9bso20638361cf.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 14:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8x8.com; s=googlemail; t=1741040006; x=1741644806; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lfi83kUkwFlAQKEfz8bUQ4/a269PFs+NoG1qMs5DLig=;
        b=IsTnPVcmfWi4Ue+iJUXL6W2Mgy6O3+IUjzeZSRIVNLW4fdqJTNMeBR/QLBC2Ub7LnV
         oymTepaYkQgfV4eYtrJ8N+wdnPtutgKU2VCR3b5GOkHYsqc4ICtM+PdNcZDMm7b+JisC
         TYVwlUGsx7i5z/6ngzXxN1hVww+zXFmKabsVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741040006; x=1741644806;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lfi83kUkwFlAQKEfz8bUQ4/a269PFs+NoG1qMs5DLig=;
        b=S9A6SRczah/AS5fBZjhgwOyZGeGsBDQ6+K47PvzPVruIyNP3OGOBNSL5EpWhmeFWOf
         865AtP74+lUnc7rB2EBi4Pz6tgnfetUQEpPFV8p+ob26PNUTYjOsdFeucaRghmY+OeQl
         GbyUoW1x4zpaQ/YI4CA7OriGdwd/16IUTNclQa9tMJtzM4DQeUCQyVYK0l9EPEGTYFXh
         JriB8oaj5QDeeZ4/db+ncJz9vJ2zNAeCniAbGjvaoaCU8uIimdKAKhDC2x9nSjRAnbQM
         +vWyNsVJR0mRcHNDqaeqd828SWXHTLIjOvg3VzN9p8HLyLDzqjBI9QFeuKSbRqSiqUpd
         RhQg==
X-Forwarded-Encrypted: i=1; AJvYcCVmmYKTEdUqVLfltz42/bvU3fmXyfbuX19utlVRnQl9QIvXAAO85B/JN1SQTId9tLbKvyrVfg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXpwdn8VUvjori22fGEBw5N0a7X1ifWEKKQasaMDxdCr979OzO
	MpRxPpdEv/M/7L9/JNhzENAhGSsxH3w2NEBBLJ5LWw+IZZ9fqweYgMcRCPpx7kAbTpVFBxedS0M
	=
X-Gm-Gg: ASbGnctmQcWoHyDRZfJHqWuT1RRnKxdbz5s1fTRNZihVqIcTzMgI14fPyt8yiDv4ZNL
	aiaAi+H21rvh3mW02NmAipr8fjnkVsz64Kg8nTu/Qt3CmZ4oGieCZMikM2frP+hN0KpYM/Pv00b
	zfHCvVH4Qm9RcV6v/sPA0VgwcNsXmo+KMe5TJi/Q2pvQAEUrGQvA0bBvX3bq9D2GVeq9wRRQ+Qo
	sPdbBFnUciptlD2RAwG6BJLORC7ZXeVQCGIR61lj6YPe5xhx+zbyKdmVWD00XTAJeEKEWLV5lZy
	68XEPvJ7KL1Ake44gok2X04ly0u44SEBqJ1Q1Zzmsw6mVRIUMfDYTGiyDY47ay7UsD5uG8RXwxM
	=
X-Google-Smtp-Source: AGHT+IHsrqMHT5ujojKURf+hLqejnNmyEJw/qDeEpTrjJ8Url4faKX1ObgFAujTjp7zgLvdyJfnnSA==
X-Received: by 2002:a05:622a:130d:b0:474:f8d9:f3e8 with SMTP id d75a77b69052e-474f8da1a08mr33347881cf.27.1741040005590;
        Mon, 03 Mar 2025 14:13:25 -0800 (PST)
Received: from smtpclient.apple ([2601:8c:4e80:49b0:689a:bbca:27b3:47d8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4746b5ee0f4sm63602171cf.30.2025.03.03.14.13.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2025 14:13:24 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH iproute2 v3] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
From: Jonathan Lennox <jonathan.lennox@8x8.com>
In-Reply-To: <baa346ae-fa3f-4164-9ca9-61c840f4cad6@mojatatu.com>
Date: Mon, 3 Mar 2025 17:13:13 -0500
Cc: Jonathan Lennox <jonathan.lennox42@gmail.com>,
 David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B352E1E-7720-4A80-ACE8-90D6519EE9DF@8x8.com>
References: <20250226185321.3243593-1-jonathan.lennox@8x8.com>
 <174075783051.2186059.10891118669888852628.git-patchwork-notify@kernel.org>
 <a377cac9-7b86-4e13-95ff-eab470c07c8d@mojatatu.com>
 <DA44CD64-A3CA-4442-BB14-FBFEA9FD6332@8x8.com>
 <baa346ae-fa3f-4164-9ca9-61c840f4cad6@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

> On Mar 3, 2025, at 3:35=E2=80=AFPM, Pedro Tammela =
<pctammela@mojatatu.com> wrote:
>=20
> On 03/03/2025 16:43, Jonathan Lennox wrote:
>>> On Mar 3, 2025, at 1:39=E2=80=AFPM, Pedro Tammela =
<pctammela@mojatatu.com> wrote:
>>>=20
>>> On 28/02/2025 12:50, patchwork-bot+netdevbpf@kernel.org wrote:
>>>> Hello:
>>>> This patch was applied to iproute2/iproute2-next.git (main)
>>>> by David Ahern <dsahern@kernel.org>:
>>>> On Wed, 26 Feb 2025 18:53:21 +0000 you wrote:
>>>>> Currently, tc_calc_xmittime and tc_calc_xmitsize round from double =
to
>>>>> int three times =E2=80=94 once when they call tc_core_time2tick /
>>>>> tc_core_tick2time (whose argument is int), once when those =
functions
>>>>> return (their return value is int), and then finally when the =
tc_calc_*
>>>>> functions return.  This leads to extremely granular and inaccurate
>>>>> conversions.
>>>>>=20
>>>>> [...]
>>>> Here is the summary with links:
>>>>   - [iproute2,v3] tc: Fix rounding in tc_calc_xmittime and =
tc_calc_xmitsize.
>>>>     =
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?=
id=3Dd947f365602b
>>>> You are awesome, thank you!
>>>=20
>>> Hi,
>>>=20
>>> This patch broke tdc:
>>> =
https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/17084/1-tdc=
-sh/stdout#L2323
>>>=20
>> I=E2=80=99m afraid I=E2=80=99m not familiar with this test suite =E2=80=
=94 can you point me at where it lives, what it=E2=80=99s doing,
>> and what the expected output is?
>=20
> tdc lives here:
> =
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tr=
ee/tools/testing/selftests/tc-testing
>=20
> The broken tests are here:
> =
https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tr=
ee/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
>=20
> Unrelated but useful is to use tools like vng to test your changes to =
tdc very quickly:
> https://github.com/arighi/virtme-ng

What=E2=80=99s happening is that when the tests are verifying the test =
result, with
"$TC actions get action police index 1=E2=80=9D

and the like after the command
"$TC actions add action police rate 7mbit burst 1m pipe index 1=E2=80=9D

and the like, the burst size is now being printed as =E2=80=9C1Mb=E2=80=9D=
 rather than as
=E2=80=9C1024Kb=E2=80=9D.  (And the same for the subsequent tests.)

This is because, due to the rounding errors the patch fixed, the precise
value being printed for the burst was previously 1048574 (2b less than
1Mb) which sprint_size prints as =E2=80=9C1024Kb=E2=80=9D.  The value =
being printed is now
1048576 (exactly 1Mb).

I would argue that the new output is more correct, given the input =
=E2=80=9C1m=E2=80=9D, and
the test cases should be updated.

What is the proper procedure for submitting a patch for the tests?  Does =
it
also go to this mailing list?


