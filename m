Return-Path: <netdev+bounces-243667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD02CA4F9B
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 19:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 021FD30505CA
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04192D73A3;
	Thu,  4 Dec 2025 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgTgtNYe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8727E040
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873818; cv=none; b=SQXnKJLClzFJzYVptWoyGjCdyPhZo8BepzK4oXNDZM1069zFqATSVQ52PggHRvZG/ssrErgpoYDxMySusWMD6HhACV6MeF29zk5MQYoW2nz/CSRhB+b2BIEAtYZUZiwFIgoZD2XCiIm7zF5+mrxunUN9gKlafqG3mV21rN0A2SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873818; c=relaxed/simple;
	bh=YTfHAUg2vkcuDyNn/uQIlabFyaBMJ4Ci4v0mkbm9sqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTqiN+TfzkFyzDYBPOWQrOMV32+9iOE4dOvg/Pz+WZ/26p+2Q+8VT0I0hUVEw18RNj6msFLZUoFk34wQ/shqs+82TAdQ4EFBg4umBYhAG+6uVFaO1oz59D52YJVTmCVOhUDYsDF8gxp0dKxo8pkbHufGPA44kNNIB42zZE33YkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgTgtNYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D82C4CEFB;
	Thu,  4 Dec 2025 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764873818;
	bh=YTfHAUg2vkcuDyNn/uQIlabFyaBMJ4Ci4v0mkbm9sqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CgTgtNYe/xPwWJumO0IUWBDfjki64JOLYG2k/Se5vSvFnoPwsSJSNYSpevipSieQW
	 O16yTH8qGOZv42ayo+xfGDsrc4U3ha/mVgCwZKU6Tvq+DxrWXsTqUepNmAU9opclIF
	 69AjGPP96U8qRsePV9Kbn9jVbym2r8tD/bRPM73saKqy0toYHVR7AGcbkl6ArpadFY
	 illjYF6L0YrmCmFWEfxZYbTqE0xKKOurtdXk/GzlWy3y85LXZy78QAaGv6yxVii5as
	 MUoBauayp50jXJV30IBMDJ307aTTiWQYUrSr9UmvYx7u+hEm9tUyQPtKVjttBoI36q
	 pczG5exGYPvsA==
Date: Thu, 4 Dec 2025 10:43:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <netdev@vger.kernel.org>
Subject: Re: [TEST] vxlan brige test flakiness
Message-ID: <20251204104337.7edf0a31@kernel.org>
In-Reply-To: <87bjkexhhr.fsf@nvidia.com>
References: <20251203095055.3718f079@kernel.org>
	<87bjkexhhr.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Dec 2025 18:46:30 +0100 Petr Machata wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > We're seeing a few more flakes on vxlan-bridge-1q-mc-ul-sh and
> > vxlan-bridge-1q-mc-ul-sh in the new setup than we used to (tho
> > the former was always relatively flaky).  
> 
> You listed the same test twice, so that's the one that I'm looking into now.

Ah, I thought one of them was 1d but indeed the CI was just reporting
it twice because of different machine running the test. It's just one
test case that's flaking on two setups.

