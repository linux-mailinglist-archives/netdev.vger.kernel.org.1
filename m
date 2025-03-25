Return-Path: <netdev+bounces-177496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CA8A7055D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7456188E398
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C6D1F463F;
	Tue, 25 Mar 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p941HNKo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2AC1A316E;
	Tue, 25 Mar 2025 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917440; cv=none; b=lz1I2c/GNFhUXlQ6l1+VfI3CPQ8qIvAucqKnDRx9s0xW/YoiAjQEpwtYAgvPOeIKUP5DGuL8j0hLdGzjbVMGbGGtpBaYTCIU+hgB1ffoxhOxfLKo9FH0t1cytvNm+3w+XqzNJ8y2PNs0fjFvUDfE+g12QWzX60gpbJHKge2eVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917440; c=relaxed/simple;
	bh=2Kacga04dBHGco8QEdQAQSvNonp1iW/ic86apGneVnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ii9xG51bBxpRtPk2GX2iRRd8UC/HpDi39CycFu/WhVqjLhN+ZQU5kOcoyMU4J7Fd1TX0ESQmDmKQAWAHlmv+1YQHU0aUuM6KOxZXe4ugfLGUsWO4SmEu7tIBNGj9VzzOb757lEjvftMcVES/WRdBmeN3c3Jy2x4pMel+DCahW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p941HNKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7331EC4CEE4;
	Tue, 25 Mar 2025 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742917439;
	bh=2Kacga04dBHGco8QEdQAQSvNonp1iW/ic86apGneVnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p941HNKo5UaIUGToheCHPE5SCrtq7ilCd0suwcEbq3N68qkX94lF77SCHEZZdlA9b
	 A+VlKAYU9siLdOcAm8ud0S8m58tQSQAI7iHc3pPeqBsPi0rcc4TBkvRdZprqWt8Nzc
	 dlYf22HjXVGQvwgwtSqbuhuwEmN43ZFEPe4DwXWea2Ej/5KPDZyRBbxUjFqt/4XTqL
	 pEEzcjH7rdProT9X4h/pKBjOCppLuoYWcuqDYockFULDFf7pyK1/akkOSp1N8kGVya
	 /aeWn6Tt0YvM/LzqDkMwc7zjQs980jpk+mnDD87V82WzvuSHxMKJNGLMQOWuu1OS88
	 0vnRVUpgoEpcA==
Date: Tue, 25 Mar 2025 08:43:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: "Eric Dumazet" <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuniyu@amazon.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, mrpre@163.com
Subject: Re: [PATCH net-next v2] tcp: Support skb PAWS drop reason when
 TIME-WAIT
Message-ID: <20250325084351.6e027849@kernel.org>
In-Reply-To: <5cdc1bdd9caee92a6ae932638a862fd5c67630e8@linux.dev>
References: <20250325110325.51958-1-jiayuan.chen@linux.dev>
	<CANn89iKxTHZ1JoQ9g9ekWq9=29LjRmhbxsnwkQ2RgPT-yCYMig@mail.gmail.com>
	<5cdc1bdd9caee92a6ae932638a862fd5c67630e8@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 12:20:18 +0000 Jiayuan Chen wrote:
> pw-bot: cr

Interesting, so you know about pw-bot commands but neither about 
the 24h reposting cool down time, nor about the fact that net-next 
is closed..

Please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

