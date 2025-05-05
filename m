Return-Path: <netdev+bounces-187802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F691AA9ACC
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7894A17DE7F
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CD526C3A5;
	Mon,  5 May 2025 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3NygG4S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2371626E17D
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466461; cv=none; b=ZcHtuwAZP0iCMFU4QzeZoD52gejIj7ueYGDVERe4btEEvq95WKmyedTtWtujq6/oFWe7ClaXQGB863GqXudhnXcQe8a/PMtGlf09YvtRcDD7WYn+RgV9Zyp6W9sNF7+G/VaqFtQO9TGgHUSyQNcLlPXCIiFPC/awQE/Ir4uToaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466461; c=relaxed/simple;
	bh=rRaGF3PZDuCgsH09qDoyu7C1sSQpVIgTTGQAZl4cI34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k65IsuNRPXNoMP/F7Ts8sNgoWCD/9AcS3W5nN5x9L5zn8uwY8zU8TyyqEKoeXcYr0w18xvFEY/puBoRaou8MxYZ2nYC1zDP8UxlFw3bnQlge7A5LCIuNeFZGIDxKl0U2aJCclXFoF5fc0eeKfmFh/4z10xRepq16Vx/+Rc+8zxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3NygG4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BD3C4CEE4;
	Mon,  5 May 2025 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746466461;
	bh=rRaGF3PZDuCgsH09qDoyu7C1sSQpVIgTTGQAZl4cI34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L3NygG4SHNLSiM1hV8bnwDnHcfPTGAnpI3WxCnW2raazR54+ADNMgM3M8G3/Jc4V/
	 OCQWPuvyYt1KHjjnCcQEXDhSqstF/19gaBjhcm8XDD1ebxQiVNpP8rBv8IRtp8cFyU
	 COPhvU4QrSQcLhAaiG6eAb0vvqacgDDBaEJI5MapCDlM3iBaXVbsP0C0TSH3CtjZEl
	 F+6xE21WW9pUE585G8x2UMNJ4WTuS5TBSBckxrIG8LHI7GpRAdmfRdElntzw53POrG
	 2dpBiy1X0HBI/18Of9A1GEPjZDkcjiMq6eC+pwpO65268+WI7dme0JIhH48vXzzT3N
	 fdAA3oaN4WtXg==
Date: Mon, 5 May 2025 10:34:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, Stanislav Fomichev
 <stfomichev@gmail.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 skhawaja@google.com, simona.vetter@ffwll.ch, kaiyuanz@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <20250505103419.1965365b@kernel.org>
In-Reply-To: <CAMArcTVog3pUQtXrytyRppkXvwBH6mHvcTsh9OsHZ3zPQYytiQ@mail.gmail.com>
References: <20250415092417.1437488-1-ap420073@gmail.com>
	<CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
	<Z_6snPXxWLmsNHL5@mini-arch>
	<20250415195926.1c3f8aff@kernel.org>
	<CAHS8izNUi1v3sjODWYm4jNEb6uOq44RD0d015G=7aXEYMvrinQ@mail.gmail.com>
	<20250416172711.0c6a1da8@kernel.org>
	<CAHS8izMV=0jVnn5KO1ZrDc2kUsF43Re=8e7otmEe=NKw7fMmJw@mail.gmail.com>
	<CAMArcTVog3pUQtXrytyRppkXvwBH6mHvcTsh9OsHZ3zPQYytiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Apr 2025 19:52:43 +0900 Taehee Yoo wrote:
> I=E2=80=99ll send the patch over shortly.

Hi Taehee!

Are you still working on this problem? I haven't seen any patches,
I think it's the last known instance locking problem we have.

