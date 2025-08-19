Return-Path: <netdev+bounces-214988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD17B2C79E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20BE7A9910
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040927C875;
	Tue, 19 Aug 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8zW6+pZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1320DD52;
	Tue, 19 Aug 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615226; cv=none; b=Po0DIV7YwsTosjA57HqcgKGhTvvE7hpQ2dN18d9EemJiA3eQVnjWqvZHu37AdeNiNKpIWU8+HhgsVcOOuI5USfNmYlQ7RNVnoAnUiKf06EFHgF3jnZz+OeV8FnPybmDoU1NgAuJfI79P074MbmKizNzwRZKbD3zRpNodD79gK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615226; c=relaxed/simple;
	bh=MM80ZxaqQsiGXQatvpSXHvICnwnjA2SwzAXBSeWGhak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWDn6MFVMCYObMAyEmLwGvrZR7tNcl8ScMnAI4G3EGwyVDMXaNpiY30urelEfGRzZ14a+u1jx5oplXvw5G+cOeT5eGfAHUY3+hd8VzVv+KyktFtvQKt+fvdnaGe61MBGMLPYwO4FcvzHEHv2oGbKJGB/m+w86GJB3wL0qdYDOA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8zW6+pZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332ECC4CEF1;
	Tue, 19 Aug 2025 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755615226;
	bh=MM80ZxaqQsiGXQatvpSXHvICnwnjA2SwzAXBSeWGhak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U8zW6+pZz/YYcNUOGcvQMif5sUSRe2Em1pFZbDCOg8aZZZul8tSIq58+co2hHiTk6
	 sC1gYAdF3RnXZ+6jjXyMxwSjTRutswjuLaLJA/IH96c6d5q2G2yiokN4IenFDiMCdT
	 c8dqua2XHR6Qif9wRpj+kYQ8+82lfYGHAQvjkBY30TYCBFr52dcr0JS1Mewf/e0WXn
	 a2E/VuhBtg8hf0w1Wunh2/eHpRCubzSqPWSJcP5/I0urSTddVJ/1tlti0XCUQCpjui
	 axo3Rxsf965I+qggK4lBnjKyYtePX8GtCmMbAduj2QyiLvaHPShS2KSEYBCTj5qZmK
	 n835AIg6v+bXQ==
Date: Tue, 19 Aug 2025 07:53:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, shawnguo@kernel.org, s.hauer@pengutronix.de,
 festevam@gmail.com, fushi.peng@nxp.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 kernel@pengutronix.de
Subject: Re: [PATCH v4 net-next 03/15] ptp: add helpers to get the phc_index
 by of_node or dev
Message-ID: <20250819075344.05600b36@kernel.org>
In-Reply-To: <aKSOCbuKcwRkBe82@lizhi-Precision-Tower-5810>
References: <20250819123620.916637-1-wei.fang@nxp.com>
	<20250819123620.916637-4-wei.fang@nxp.com>
	<aKSOCbuKcwRkBe82@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 10:45:29 -0400 Frank Li wrote:
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

reminder: please trim your replies

