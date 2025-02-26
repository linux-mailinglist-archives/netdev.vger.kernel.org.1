Return-Path: <netdev+bounces-169963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB61BA46A44
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DDCA16D39F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73344236A99;
	Wed, 26 Feb 2025 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b="EdwlVzix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD73236A74
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596130; cv=none; b=qGP77gWWH77TZhACmsV8PVv7DIye/BZwGmsX1mFrgly1lxyKtwquk3mQuQ2wxLslKHpF5wQY/EWpprQoTotPVOdLooJNaXs+BxDsUFYVvC4FzYeEdH4WCKRYFKkxC+aAx8lRip4LStNHymRGQdIP6vKXusG6jrvyLJblNVon3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596130; c=relaxed/simple;
	bh=+5aKcX4BAT/Ww8EQkZi6p/Zbb4zOiuaunIBIytZJd0A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LTyqOXF88omLTflin/UcVyf/IIAUDfUuG8fCgbZiH0eoWEfRlpJ9QfEnb4O4lrR5GQAoCz854K7v2EaMXxV7MeDApCIIobE0EOnOXxVPjyiTj17tRiZzM91fGtfZsYfgDol/12U5dhHdvxfgkYsIZydAt7MlCqVXh5zZTfyHW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com; spf=pass smtp.mailfrom=8x8.com; dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b=EdwlVzix; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8x8.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0bb7328fbso11518685a.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8x8.com; s=googlemail; t=1740596127; x=1741200927; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5aKcX4BAT/Ww8EQkZi6p/Zbb4zOiuaunIBIytZJd0A=;
        b=EdwlVzixeDOUZEV77X4KvAZbPdtCF0mHN7VHrYBkovX9iGR655wjJGDCaFURmDyrTy
         dRu26PJOgh/RjF1hDexKWl/Rh89t15oc8DcFoiDJ2oFzoddfvLoDTUGA0jq1S5soIFSC
         0oQ8SPdbLdtCuj7ewkbwCY+NqhzokaXlPGkyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596127; x=1741200927;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5aKcX4BAT/Ww8EQkZi6p/Zbb4zOiuaunIBIytZJd0A=;
        b=ZtmyVlH9no/TcYo2NhY+9nxDiXroQEz31z8ZssD++15qRXLEbyQXc4m5lf1ZXSH5e/
         il6p53Fg+QkgB7f1PVlOPO4PbpKMNaQ5KipZiNSVhMyoltTCRbgwf+UEQAWmtpIJ+RBC
         ooBBYmT+16b1CTuHB3Z+COouZq0jUzvYiysymERLGMKikyxh3Fr3LoIFuyca47ia6xEl
         YZiNV+AVNVVqSrrAOdDHgDBi3ZYOpn5R1+iiTaRMHDcSzekwevKtbp1bIXmabazDj3Uj
         QpL/osNvD9ImhcQ59DX3+KGzj/NrL6/wfdvjHU8Fd1QY+qkrdOk88VvS+id6pA8zuH2+
         ybeA==
X-Gm-Message-State: AOJu0YxieG6+mnq2OZFrfuzLqIu2kD/HOMYwYGAo+JZnaEyx2CV7qgRR
	C/g127pNSIVq9lB/fpX7cjkk4lviEbrgMCvlN/buyizSkXspaCuft/Nv+kSeUVNF2MK7xUQ2Vfw
	=
X-Gm-Gg: ASbGncs2tGwhsw/bjO/alrSFFhsv0VxUEAzP3+s4KRY6r+tlwYZEc6qATCJ9QW79z/S
	gg15SJMBrNg73ewvy9FJnHtP44bdhEdUGRAG4kPXavcE8J6GV4uT1ZOtw91kvuxEPvAayTXaDJx
	njLtMnJHCTO6+LpYYapwF1X2iVdSB/BKnMCmBpVDxznFbqNNr/EqCLESSc2cxe/ACLhZiPnOrUi
	mG4BqEbboH9MOmEp7LmKWa14WTvGUAq3jbFA0exXgtGrjnNsF6LlH6IiRrss20f6bpza/DBWQYV
	xPcqTH2tSREWMBIgPjRCMfzIbrZ4Z33jeq5UUue967Leo1FZC4hFmKyM
X-Google-Smtp-Source: AGHT+IGoTuR0xhxywmOPz7F7e1Iu+Av/zA2LRkDRuQCAahQ7KN9lUct5sev14Zf8GlBhr8rNpO3QGQ==
X-Received: by 2002:a05:620a:2910:b0:7c0:abe0:ce5c with SMTP id af79cd13be357-7c23be146b7mr1064884385a.15.1740596127340;
        Wed, 26 Feb 2025 10:55:27 -0800 (PST)
Received: from smtpclient.apple ([2601:8c:4e80:49b0:28e8:71a0:ab4f:631c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c327205sm280251385a.85.2025.02.26.10.55.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2025 10:55:26 -0800 (PST)
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
In-Reply-To: <a9473fc0-d721-466e-b70c-8e9010c5c541@kernel.org>
Date: Wed, 26 Feb 2025 13:55:15 -0500
Cc: netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5CADB93-32D0-4816-969E-488D3271D909@8x8.com>
References: <5b9f16c1-450c-4a39-be2c-634b4f1864b5@kernel.org>
 <952BE2E8-CE07-4D82-A47D-D181C229720A@8x8.com>
 <a9473fc0-d721-466e-b70c-8e9010c5c541@kernel.org>
To: David Ahern <dsahern@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)



> On Feb 26, 2025, at 11:06=E2=80=AFAM, David Ahern <dsahern@kernel.org> =
wrote:
>=20
> git am (and patch for that matter) is not liking your patch. Please =
make
> sure the patch is against iproute2-next and top of tree.
>=20
> You should also try sending the patch to yourself, saving to a file =
and
> applying using `git am`.

Sorry, my mailer was mangling the patch (adding quoted-printable) and I =
couldn=E2=80=99t get
git send-email to work with my corporate e-mail. I=E2=80=99ve resent it =
from my personal gmail account.=

