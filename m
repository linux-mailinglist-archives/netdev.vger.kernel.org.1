Return-Path: <netdev+bounces-167508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B6FA3A86A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9169716CBB6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1A1BC9F0;
	Tue, 18 Feb 2025 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b="dAeHWKJu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2381AF0AE
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739909444; cv=none; b=mlaEE8wJgWoP8AHkGU+hnIe+nBD2Dr47+fuUfpsF4tJNMowshf6W6brHcpcn4T2RAPGZ7s+I7HGwXQfvbH1eB3x7UrT4d4VEBzrtw0ObIBxkM1C1JQzqd2oO+x36xktcUxhaXJ8o4CyhlKFnJV/GV41Q/NUbMCW7bjYYouZtbVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739909444; c=relaxed/simple;
	bh=UF9pMRXMNQz4e0nLr/iU7XYRD6QbAPKiK4lTCx17A98=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UPsENHq4bMmc5isBYUlevLRg/kmIiPtfThT7DSADuUlVb+ZlFu6KjNfNuqevyHSvA9JqGlcGUDa9+bjFBrwF7AwN+u6nq56Iq3B8z7cGldcvK/X6wzIi6y4fOGaB1FvJzxS4VbAnYmyWPDfNZExWYJSBso2AnwocQtw9VanyLyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com; spf=pass smtp.mailfrom=8x8.com; dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b=dAeHWKJu; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8x8.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46fd4bf03cbso88486411cf.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8x8.com; s=googlemail; t=1739909439; x=1740514239; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF9pMRXMNQz4e0nLr/iU7XYRD6QbAPKiK4lTCx17A98=;
        b=dAeHWKJu4taa6MnRulrxN3DX8vFsAb3Te6sJen/PMSS54kMuql3zObwBCgs1HSMeRw
         ZsOY3SgCEau6mGkZNKqBtDNUOZ1C4t6FWXCkUSYxbRies5Gmc5e3dCmEqoJirBHWDIY+
         RJUiYNsnm4oo/ov01d1MIcvFX+9XufAhL5H5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739909439; x=1740514239;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UF9pMRXMNQz4e0nLr/iU7XYRD6QbAPKiK4lTCx17A98=;
        b=bmhY4oQlhZZFIEVeyWSARyhA4Guw8BgyKkZI4CeXn9cbKVEdd/vQUILtgFF4TU548a
         yW71oVEJxo2nreAa5/nLq3XQdm35L3aRRLqc23cgg42FM0ippUl25mqBPqfENFbFeCx0
         n6KHm1nT/n4CAajABp1D84NHqWIF6vMbINmIRkh9Vsv4JYn/SCKS+0SPM3OJJurfZt7H
         9PxxngsHimqC6nBbf7l0eeIk44JGlwPmgxDMWcjz8T/iSgODPybrHci1ulrECcfDWcW/
         aVDKunBr2uKM9Z4lPyqbJcPkkIAyfxv8Tw2+MBD1sKgLHhnI2tja/v+ij8b0H2eL53gW
         6ScQ==
X-Gm-Message-State: AOJu0YxtteDVu3Ekd+w4jguunjjTjwUnZCqczNjmEckczoJu90pjUlV9
	ezgTwGIvPX1IsKO0hlkgxdiJvmniqzNVOW31xeJysO7dLxWfUNl1tMUrVXeTIa02rG/rwCfujwI
	=
X-Gm-Gg: ASbGncsnRlL4pZr4m4L42vSo4idQXqGDq7tcGteQGRNuLzrSCh9GZxCB0gxzD/peNGW
	NaU0nMuUz2uN/GZ3EcMVgrWjldIgLE1mmcoOF3cE3/0t9E4WEyzdKWbnwAYmUkLgB/YW0aQL8hR
	1FtIq5Gxd00LOzJOHUHyUjPV1FVb/kIWq8WpaKylQAhSh5LKVpMktk536pbmffrlP6fsBlnGmD+
	TXGg5jIPSHXXn4LeK5dtE3FAg3satl1KY6zzC2Hw5gP/svB7DMB9x8U9nsgLRnY/yYsHPKWIUVH
	Dzv65byMTvLyuXxpHqt8STpiVrndBbvEBd24kdqO0Y1XmYEktCYSDqXG
X-Google-Smtp-Source: AGHT+IHpUyiIpGxtpOAJAbWaYCwL7OhRWwr9xnees+hi0j+VvQWa20y7hVvnLeTV0P1Z/hEEeFRcfA==
X-Received: by 2002:a05:622a:1353:b0:471:f272:985f with SMTP id d75a77b69052e-471f27299b3mr122889821cf.34.1739909439153;
        Tue, 18 Feb 2025 12:10:39 -0800 (PST)
Received: from smtpclient.apple (hotpot.cs.columbia.edu. [128.59.13.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f506f819sm21484761cf.62.2025.02.18.12.10.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2025 12:10:38 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH iproute2] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
From: Jonathan Lennox <jonathan.lennox@8x8.com>
In-Reply-To: <20250216221444.6a94a0fe@hermes.local>
Date: Tue, 18 Feb 2025 15:10:26 -0500
Cc: netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE75595B-3281-404F-A208-1664D5B004D6@8x8.com>
References: <85371219-A098-4873-B3B9-0E881E812F2A@8x8.com>
 <20250216221444.6a94a0fe@hermes.local>
To: Stephen Hemminger <stephen@networkplumber.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)


> On Feb 17, 2025, at 1:14=E2=80=AFAM, Stephen Hemminger =
<stephen@networkplumber.org> wrote:
>=20
> On Wed, 5 Feb 2025 16:16:21 -0500
> Jonathan Lennox <jonathan.lennox@8x8.com> wrote:
>=20
>> The logic in tc that converts between sizes and times for a given =
rate (the
>> functions tc_calc_xmittime and tc_calc_xmitsize) suffers from double =
rounding,
>> with intermediate values getting cast to unsigned int.
>=20
> The concept makes sense, but is missing a valid Signed-Off-by: and =
therefore
> needs to be resent.

Thanks, will fix in v2.

> Also, you don't need to rename the functions, why not always use =
floating point


There was another function using tc_calc_xmittime (tbv_print_opt) so I =
was worried
about breaking it, but on inspection I realize it=E2=80=99s also doing a =
calculation in double
and it=E2=80=99s just printing data, so it should be fine (and hopefully =
an improvement).

I=E2=80=99ve fixed this in v2 as well.


