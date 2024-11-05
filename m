Return-Path: <netdev+bounces-141761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57759BC30E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13930B20E49
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B31D6AA;
	Tue,  5 Nov 2024 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kvyje6D9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3CEAD2
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773044; cv=none; b=a+SbL+S2nsNkfRleGotZkHj4OIWMy58VmLFBv+SaxbeSU2rmnzezx4HhyoGIxVMia3rCgAweojanxHZb9y6GLScxp9GMDhpcpJkUQ/3liyPVeJkJp87HyedDYOK7LJYHsuS2ikhVCbG92WrZnCWVMsZ1SMNN8TYQprim6iive7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773044; c=relaxed/simple;
	bh=KymAh+cHgs/PbrcaeFQVFFXM/UkhrTfnTl2sHiRq6ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGZKm1gGwXvzjqaH50XTvGc9sqwaWqXQQkzPPZVC7TuUXInmEvp5iJpd0rnGykESY7Lecr+SkUUbMFnN673UeBkV0v3r/tZXja2wdqYCF0F1mjnqTeHwxf8NSpNZWYRcHXFICXnACtrzEHYv5bwzLE+mXptJkVgWe0nOqiHguy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kvyje6D9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25941C4CECE;
	Tue,  5 Nov 2024 02:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730773044;
	bh=KymAh+cHgs/PbrcaeFQVFFXM/UkhrTfnTl2sHiRq6ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kvyje6D9r1YkgLW4NvmdSay9kd8UhD611l778Tu1lp/8JKmkbjjfneZUtDAIzfHvY
	 1dVVpDq9zxf26ksCSTlBSP3RL06MGro0+pYQGX026HPLo3qNEZ0coV3cs52z81kt39
	 O0DNapydtns6nmvEAv/l9lUPrHp7i+hFePuTtTcfiQ+JA6jHH1DRFU/skw0yDkIoKd
	 Vl3P26C9XoMHK3StZ6ILd+kcg0g5eSq8M/sNxDQD/Qv8bRozhr1r4AmZ+9IK6cyjnq
	 7/uafQg5+eRkVfko/dXaHKpmQUW4P9Dic4Ip8Gi4egvwVn+bKqkosP9vfwFnInTZ+A
	 n7ncqyZA3rivQ==
Date: Mon, 4 Nov 2024 18:17:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
 "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
 <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
 <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
 "Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
 <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
 <amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud,
 Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>
Subject: Re: [PATCH v3 net-next 3/3] net: ena: Add PHC documentation
Message-ID: <20241104181722.4ee86665@kernel.org>
In-Reply-To: <20241103113140.275-4-darinzon@amazon.com>
References: <20241103113140.275-1-darinzon@amazon.com>
	<20241103113140.275-4-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Nov 2024 13:31:39 +0200 David Arinzon wrote:
> +=================   ======================================================
> +**phc_cnt**         Number of successful retrieved timestamps (below expire timeout).
> +**phc_exp**         Number of expired retrieved timestamps (above expire timeout).
> +**phc_skp**         Number of skipped get time attempts (during block period).
> +**phc_err**         Number of failed get time attempts (entering into block state).
> +=================   ======================================================

I seem to recall we had an unpleasant conversation about using standard
stats recently. Please tell me where you looked to check if Linux has
standard stats for packet timestamping. We need to add the right info
there.
-- 
pw-bot: cr

