Return-Path: <netdev+bounces-64298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 892368322C1
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 01:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E015B20E6A
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 00:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0C8A23;
	Fri, 19 Jan 2024 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWt3/R6h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898CB81F
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625361; cv=none; b=HZ0RTlmjZ/GHn6naf0bs4MRkITrEF5qTfTYgjZB30O80/A2TZO6fEU1wW1pDhk4VhLv+pG3edTNAiV1dyWg57KGiBVnBpv1Iob8fRzhKgdnTZ5uydfN4vaL6gqHI9aXioy6Vs8EN516H/dYhyy4uF/aBvxq9VwD2jZF11KeO29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625361; c=relaxed/simple;
	bh=4jMP71DTMxKYeWKwu9VRy2fS8lipQd4zHb38F/WvMgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XafvGaJvwmrUJZfuDkU0SZBpiRpnlDjN2lrcSuvyv3moT7NLBix6p76w+7rVUuYdVGHCHrOgzsDMoPXoPyiTdUwVAwRyubxqtaqy4fj7u3aO9AqzUR7qr4NnCLqnKF228b4Z8ZxsUG02BdGuP4sC/xbjNUDlT1m3uPZBSVzdIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWt3/R6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA804C433C7;
	Fri, 19 Jan 2024 00:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705625361;
	bh=4jMP71DTMxKYeWKwu9VRy2fS8lipQd4zHb38F/WvMgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IWt3/R6h9ZjwJ77KgXLqGRL2If+NjiKHhUq4EwT/YZCSDJQnotGHp5jAyt6C2e8RI
	 CxTFF8mUDKjr1crGSAPYIeNmL4rBA3OymXVsOMhe4iOtxMycryW8sYg4uUyAXbC+42
	 Jf1+c0Uvbh40TMfzoquKWwkdKPLyVFdeWJkXNPELyfSQtEHBHu8DFjXTEPDMsT7K/5
	 2yBL1mkPrNFYBi8w3GAYYs+96f0SjVyhZmJM05Xs6xXyQLPHg6kBSsf8Ym9TxcgsPd
	 cMfpqZMyMzjdEiahrCLN2rW8ZkLqpUzOrc1YhKi7BekAVdq92NyKBEyQHyNmxdKqX/
	 05ZinbDxbE3kw==
Date: Thu, 18 Jan 2024 16:49:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Kernel BUG on network namespace deletion
Message-ID: <20240118164919.7d775217@kernel.org>
In-Reply-To: <CAEmTpZFZ4Sv3KwqFOY2WKDHeZYdi0O7N5H1nTvcGp=SAEavtDg@mail.gmail.com>
References: <CAEmTpZFZ4Sv3KwqFOY2WKDHeZYdi0O7N5H1nTvcGp=SAEavtDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jan 2024 18:59:54 +0500 =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=
=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 wrote:
> Kernel 6.6.9-200.fc39.x86_64
>=20
> The following bash script demonstrates the problem (run under root):

Hi thank you for the report and analysis, fix will be coming shortly..

