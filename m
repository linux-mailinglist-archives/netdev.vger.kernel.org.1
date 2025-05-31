Return-Path: <netdev+bounces-194457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255C1AC98CC
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 03:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C433B3764
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 01:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA2C2AD18;
	Sat, 31 May 2025 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A508ET1a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F21F92A;
	Sat, 31 May 2025 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748655207; cv=none; b=bja2O+WKmTbhykL4j46UsBh/HqDbUglXQkKjCXltzkt+6xjdkbpgne3CBCPT/WGWt1c7fwutgkHFEbQkPH+dlAl0nMj3CtnZY4iVqsREcncRpZKOtd5blMqS2UZnIuywL+b5OZt+UJK0AqsF6wBiL+j8GQcg9ofcfMC2dd0E0bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748655207; c=relaxed/simple;
	bh=5o/T0QXedZeMQpctyyPt24kRRa8dDPgMCh5EneDN+og=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApFlgrx5ZjLs82uXOej4XzY2hP1qXaZ1t3/o5AmadQ6bAGPu0KCzpuHQvYDNMJ3/VgJu6RqIIipHeND6YmzQ6LsRUUM7agjfQRrOENk0kEdXs9ewPQTC2BSfyjxP4hnYaHx5DX+4kBQ9SLYZ93ykIF84DbKQ1BH619yzKJEZiro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A508ET1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB2DC4CEEB;
	Sat, 31 May 2025 01:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748655206;
	bh=5o/T0QXedZeMQpctyyPt24kRRa8dDPgMCh5EneDN+og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A508ET1aB9rruJGs8TTVln1+k42u+c8WS3BOZTYrxxKPk5vJmcYAARqXaJNq3OisO
	 lFr1qjVAWSDxI10ha6iWUiW/XPf4MCV2kYu3YRYyBk8T2GonnfovWuzePD38T6Aulp
	 mkc6m+itbTcpmgWKyCwHI1Sk+q/h2q5rL1tcdII9lfuh729emNkAXRJZG3EnmTd9i8
	 v86pozobjD/xX07OxQSaokbnMcaeCioPvnXdsAjjxnuYMETAFV1/kte9e0ViVeitri
	 tdzdfdSdtP30M1X2B1Evn7zTE7ZcjsEWt/8pQ0YU6KlKBO79zTMFUEdQPg8dsFmWYq
	 Wd8UrWGEmWRvA==
Date: Fri, 30 May 2025 18:33:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc: jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dgcbueu@gmail.com
Subject: Re: [PATCH] net: dsa: brcm: add legacy FCS tag
Message-ID: <20250530183325.4666342a@kernel.org>
In-Reply-To: <CAKR-sGdu7D6StqwEahdGbM8oxL8J8amwEPiS8scVphfuPLMLhA@mail.gmail.com>
References: <20250530155618.273567-1-noltari@gmail.com>
	<CAKR-sGdu7D6StqwEahdGbM8oxL8J8amwEPiS8scVphfuPLMLhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 May 2025 17:58:36 +0200 =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> Sorry, but I've just realized that I generated the patches with "-N"...

FWIW networking tree is closed during the merge window (for another
week), so we can't process this anyway.. If you wanna repost please=20
do so as an RFC.

