Return-Path: <netdev+bounces-171378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5ECA4CC26
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 20:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9113AD17F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2055231CB9;
	Mon,  3 Mar 2025 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b="d7vLegqo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F8A1C9EB1
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031049; cv=none; b=G4nbVq82gNk8CwZ0PEhPFQhgjZhLeHS1Wo1FG+ixT44OMFpFpeyrekpEw9dayXqJ7LJaeAX/8ft/4WjoE8m0tpsqSnY9VpR8U+yex5T/EPHAi03E1dkMjwCpCkxmxK6jBFHtkVf40K/zazzMBCHDjZT+0vVEOXz570rG8fDG0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031049; c=relaxed/simple;
	bh=5SoUbLYdh4x2xnlpV7lWtQDEZR3JKnswmS5JI4mtUO0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tsjLboUVkZxpV4GYvQpbveyfrPcucrGXKRvHd6ATeeAk7xR3ryJUF43TPEh1UdK2Xp8n/b1vtiXycmLG8UuSO8jipU4CGXBQNpgaInXly/nYr2mYZiJKuSuSA5SSvWUnAHCVtdVbrOXeGfpgapishDLAmV6+ZbF6KWMal44SxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com; spf=pass smtp.mailfrom=8x8.com; dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b=d7vLegqo; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8x8.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3cb761402so52590885a.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 11:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8x8.com; s=googlemail; t=1741031046; x=1741635846; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9/MXwEmrhonYRIJ69EpIHAGQvUuHEwv60rzERmQdsc=;
        b=d7vLegqoFQjabsVJorJsKG9JN3qGlBzzYtQd9Id41cS9URT1SDDQ666dLcDR4M7ik6
         ofS0HESinjqhnX9IaOhSCArBzRYalbq81vX4A+Lz8kUl3KK0TeF+HdEQoer8J9wmBfrk
         oNVzWz+KHFyJRv69werWGnDz/OnTi1rBIfIro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031046; x=1741635846;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9/MXwEmrhonYRIJ69EpIHAGQvUuHEwv60rzERmQdsc=;
        b=gDlKbPbogvNGgW/5DX3b+TD3kv03TEv/zIt37c9NjJ/5lOXGwLiDP1zPE1P66TzOxR
         6Mc4ugm5AvaI8jw5vx+X8sa+jT/EMnJjFmxHKn77YcJZAM0+fjPiYBvb87sedWWnp9OF
         7sYcr+XTBYD6PYepDDCDpmw+bUkd2e6KqtxzZ087n3YG4miCPIXTsiCb9Y35YK2z0abE
         CzanGDEF3FigliAUeVAo/+WcYf55wJgZ48+sO1qSpE08U2KdGIkXL6YPn+fdwCn6SAsF
         H8pllYSC8wJ945EVXG7482/dXefza9KE6aEyhvXTYPBsqkfJ+ZoI0NwAacNkak66tU2U
         eH6w==
X-Forwarded-Encrypted: i=1; AJvYcCW6QeYprfbFxZ0LivHuZ7LvcNCYCTYEjZNVYttPKXQujdfRX9FOoQO19j6gcMgW573hZS0uEH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxrLy09TRbaX48h2pbPxkyf5uIcfP3cQbu7H/LbD/9GxNASV9V
	NTRMWHPtb7ePZj78Wj2FhywUtCItkewoummVBqWqbT/xCcaX/JPujLzu5mTPyKQSY4+AC0wQYxM
	=
X-Gm-Gg: ASbGnctZV++b0Zi2ipvXE2cG3dc5exGMptNg5ltNBgvixz6MGLuNVbLPV/JEwL2UPtD
	FywtPZiGJobWI+c6uKUCFy1srTl7AQh61Vh1RLyu8/n9YZOgvQaexcbHYQ40ZDDFr95q8Ke+vDF
	ixbEDYO3/ecyFJB1VsnvFM5ngLUtk2qZbvITenNFa+/YSRoB7abMtOUSggEVtIRhMcZUfi6y9cs
	hxVetLOJFN/bRj8O/pF4+eThctHWLoRSOWQzgBZ1I85e+dzK3c50qRUEe3Q+cBMab7wsISig5uE
	TaVbudLV8TfeKSzu2P4Dpd4858HFzhtAsdbHx+MyOoVggE0qIKJNXXOZwKMDxkYwfBv/sbsb/DU
	=
X-Google-Smtp-Source: AGHT+IEpKEl/mwoPLSCln3H2fkKFCnIzUSLWX5sPfS4l1d1eQhtSoXKAnkBIQEa+bYPdhhzwugzcUA==
X-Received: by 2002:a05:620a:600c:b0:7c3:c0dc:b600 with SMTP id af79cd13be357-7c3c0dcb925mr444948085a.39.1741031046375;
        Mon, 03 Mar 2025 11:44:06 -0800 (PST)
Received: from smtpclient.apple ([2601:8c:4e80:49b0:689a:bbca:27b3:47d8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976da260sm56244496d6.106.2025.03.03.11.44.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2025 11:44:05 -0800 (PST)
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
In-Reply-To: <a377cac9-7b86-4e13-95ff-eab470c07c8d@mojatatu.com>
Date: Mon, 3 Mar 2025 14:43:54 -0500
Cc: Jonathan Lennox <jonathan.lennox42@gmail.com>,
 David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA44CD64-A3CA-4442-BB14-FBFEA9FD6332@8x8.com>
References: <20250226185321.3243593-1-jonathan.lennox@8x8.com>
 <174075783051.2186059.10891118669888852628.git-patchwork-notify@kernel.org>
 <a377cac9-7b86-4e13-95ff-eab470c07c8d@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)



> On Mar 3, 2025, at 1:39=E2=80=AFPM, Pedro Tammela =
<pctammela@mojatatu.com> wrote:
>=20
> On 28/02/2025 12:50, patchwork-bot+netdevbpf@kernel.org wrote:
>> Hello:
>> This patch was applied to iproute2/iproute2-next.git (main)
>> by David Ahern <dsahern@kernel.org>:
>> On Wed, 26 Feb 2025 18:53:21 +0000 you wrote:
>>> Currently, tc_calc_xmittime and tc_calc_xmitsize round from double =
to
>>> int three times =E2=80=94 once when they call tc_core_time2tick /
>>> tc_core_tick2time (whose argument is int), once when those functions
>>> return (their return value is int), and then finally when the =
tc_calc_*
>>> functions return.  This leads to extremely granular and inaccurate
>>> conversions.
>>>=20
>>> [...]
>> Here is the summary with links:
>>   - [iproute2,v3] tc: Fix rounding in tc_calc_xmittime and =
tc_calc_xmitsize.
>>     =
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?=
id=3Dd947f365602b
>> You are awesome, thank you!
>=20
> Hi,
>=20
> This patch broke tdc:
> =
https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/17084/1-tdc=
-sh/stdout#L2323
>=20

I=E2=80=99m afraid I=E2=80=99m not familiar with this test suite =E2=80=94=
 can you point me at where it lives, what it=E2=80=99s doing,
and what the expected output is?=

