Return-Path: <netdev+bounces-116753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE3F94B996
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5711C2102D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4518146A62;
	Thu,  8 Aug 2024 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt17wLI5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8A81465BE
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109007; cv=none; b=cNLlv99zQ7b3RYUmjIFrRNrFfy9ozIwbvoCUqEZw0YwsRtZjaMWPavODf94bMj18fcRH7sWQ2yxmKgE9hTZoZVBNm3KOgP2bbQfrF8cOLWJqb906N4EPfoB8ZxvQAWOkM09ZZGB36T39cCrhoPKkSlXvnC9iXeEF/zvjaKdnb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109007; c=relaxed/simple;
	bh=iX1EZO3yB15rqCO9EMHQKda+8yUGAiCcnTG3M9Qyztc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqUZ1YLHHL9UnvMX/g4YERYFBRDgKU0sBM60JwXE6VjpCXY3I7xMST4F4x+eHjtaFnUeFttRwBFpUS6RQ+oyWoViFsFMzMkwMIR5eehH329di7sKT91kryQePm+CMfNRNQMJKtaVKugaf/6cIXLXz7M5WDzcoAwj8wYVd/K/2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt17wLI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9CCC32782;
	Thu,  8 Aug 2024 09:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723109006;
	bh=iX1EZO3yB15rqCO9EMHQKda+8yUGAiCcnTG3M9Qyztc=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=bt17wLI5ZTjvggrJW8j/SRhYSu7B2gtrSvaMInrouW025Wn7XladRSdmxvEob2OvS
	 T4tIJPbE5+0MA4GM2Ayr7/DnCpEgwipV8lpsFo9nQ9ilCHJO5aB0ubR7dC5Zzhr6N0
	 s4suCXQ2R/LrDBgLxYkGAL/OfZKnklM7iJnxbKDkJQjAyJkg2Owm69qoFm/jztCFwh
	 MZddzNyioWOOPGVRfKhZhGs9fXZOCgsFAb4ApyB0Jr2qlHHntDtt7+GA38IEg2cQZj
	 /V33K+puHZnth0eSXcARZdzDSv+Fiyp8k2KSzqq9xkMHFhBUocAu9z9+U5cwx+bIKc
	 PRRaRc93M/wYQ==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 863A514AD648; Thu, 08 Aug 2024 11:23:22 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Duan Jiong <djduanjiong@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3] veth: Drop MTU check when forwarding packets
In-Reply-To: <20240808070428.13643-1-djduanjiong@gmail.com>
References: <20240808070428.13643-1-djduanjiong@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 08 Aug 2024 11:23:22 +0200
Message-ID: <87v80bpdv9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Duan Jiong <djduanjiong@gmail.com> writes:

> When the mtu of the veth card is not the same at both ends, there
> is no need to check the mtu when forwarding packets, and it should
> be a permissible behavior to allow receiving packets with larger
> mtu than your own.

Erm, huh? The MTU check is against the receiving interface, so AFAICT
your patch just disables MTU checking entirely for veth devices, which
seems ill-advised.

What's the issue you are trying to fix, exactly?

-Toke

