Return-Path: <netdev+bounces-74497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA99B861800
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606EE28C64C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF6A5B1E0;
	Fri, 23 Feb 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdnYGpbg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D951E4A2
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706082; cv=none; b=CPS0t7nUov447c4xz3TVpYbGFP4PsVVLJs0PlgroJxyC+GuSCf6gGHfvFcZgbP6TMRd8JmtKEwU6IxNEyDT0ZYjykfl3RxbhWRP4BM71+4V07f1AQMk8SK3HPLWlV0/0nObO4JPEYlLYkSwEkgI28Rh/leX/L7S89RDx80P1/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706082; c=relaxed/simple;
	bh=T7LK5Kk6Der4sTK37Bk6ROEseoncNKipeYGi6ismZTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnBW8zqt9iQbOtHwdRJEyxf9I1jt6Kg8TuUUMj7xcN0Mgo6eBnAb99sH7eXn/syfbACoycA45MgN+5LPu7yYE7jLAXH5WAz7wPC+2TxX+Ph3R7qe32rvN+c9auOMlHSibPLRnC0MxmCHK0cP7M9qNtdhHNyy/XsFiYRrqbEkTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdnYGpbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1581DC433F1;
	Fri, 23 Feb 2024 16:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708706081;
	bh=T7LK5Kk6Der4sTK37Bk6ROEseoncNKipeYGi6ismZTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QdnYGpbgMpmFpH4T1grjtTwHI6TnqDFyLJBVdVmzQxHqGUjLkphoNU86Ys7qMI5Yu
	 MiHiZkdOCZF9J6dWG4M9sfFx4R3i5l9oh462UxPlvYdsmm7hS4J0vBrFhKtW0+J6pb
	 hoIR6henwHmZnelKiChI8wMi7vvtwIgeMiBrntqB786e8lVDP3kkJjmG61+3/MQsiL
	 tnCWN9smkLa+EqdiQ9tSBN56q9DwoygYc5lu8tSmrYMm+69P2P4rqvPR9J4e7Y0rUe
	 /qcg+esviH7llLqIPXq68+1JsUHhxsBPukxYFML0VwfxgrHT9Lvl23rLkcw5/DXLvD
	 WujGHUzQ+DbKg==
Date: Fri, 23 Feb 2024 08:34:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, sdf@google.com,
 nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 00/15] tools: ynl: stop using libmnl
Message-ID: <20240223083440.0793cd46@kernel.org>
In-Reply-To: <CAD4GDZzF55bkoZ_o0S784PmfW4+L_QrG2ofWg6CeQk4FCWTUiw@mail.gmail.com>
References: <20240222235614.180876-1-kuba@kernel.org>
	<CAD4GDZzF55bkoZ_o0S784PmfW4+L_QrG2ofWg6CeQk4FCWTUiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 16:26:33 +0000 Donald Hunter wrote:
> Is the absence of buffer bounds checking intentional, i.e. relying on libasan?

In ynl.c or the generated code?

