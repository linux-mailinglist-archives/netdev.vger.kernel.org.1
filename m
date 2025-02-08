Return-Path: <netdev+bounces-164256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C57DA2D266
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE0B3A4D06
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 00:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675B68C1F;
	Sat,  8 Feb 2025 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOK+tsxg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347D6FBF
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738976119; cv=none; b=D+IXZ0eCMl/t+U2MwdRyVBn7Zy18DwBsFflEYYNngvSATF03NsIevRYW8CYs3c+8/cg9a+n+R5rFDmzh2j9GUAKpXs0sMfQ/Hir6l9y1hKVXUE2ISRL6s5TLtHz3maael345kzsTgf7DzP5jisWacK8vTdM1xPp7yjkIk+mZ13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738976119; c=relaxed/simple;
	bh=jlYaB25Q8hqAbNoXFzJd6Qi4tevOG0OqHIb8UhdfbmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aebvk4jWGx6yI1v0QbwnZ1WHgWcVxfOLZtFv7Yng8pCsVyS135ZROQSSpniVJ/qj+pI0/Cc6BmBA9iyM4tTu0xNidjbnlofDhfqjij/MbiZPiGcyp0GY0BTMOx7Agnb1Jv8lTbrSq2X2VLFb8yjVH83Vy7qXgVD66vJ84VL3wi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOK+tsxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE61C4CED1;
	Sat,  8 Feb 2025 00:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738976117;
	bh=jlYaB25Q8hqAbNoXFzJd6Qi4tevOG0OqHIb8UhdfbmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lOK+tsxgeM4uOq1E2VyaTdepFtHBF+1zE5U1Oi+r5lMQjk65A+kMVePCnSezAT+up
	 hF1JeRPDbK7a0JVdE4s7CR2wUu2eIzw7VbdZXsVMR61pWUIAvGfWg6/0nKNsTAzWHG
	 fAs4Q/l8k51bFVw5rJdk/6m3LNqINu1wrLNgrsZ/phhIbTNlioowUcnEdo+LQ538tW
	 0FC67DLH7ubGb60bx8JT+LW1pmQO497c9XW7/qe0ssi7se421awalI8YF7T2zrISys
	 vrvsz+me+klXA8xI5uwnDiy1Drr9sL54DDk0aHwFVv2hiryACGYr16Dx4zSCLwrcEM
	 eSqDySMidMAng==
Date: Fri, 7 Feb 2025 16:55:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Richard Cochran" <richardcochran@gmail.com>,
 "Woodhouse, David" <dwmw@amazon.com>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed
 Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel"
 <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt,
 Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>,
 "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>,
 "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
 <osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek"
 <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal
 Pressman <gal@nvidia.com>
Subject: Re: [PATCH v6 net-next 3/4] net: ena: Add PHC documentation
Message-ID: <20250207165516.2f237586@kernel.org>
In-Reply-To: <20250206141538.549-4-darinzon@amazon.com>
References: <20250206141538.549-1-darinzon@amazon.com>
	<20250206141538.549-4-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 16:15:37 +0200 David Arinzon wrote:
> +PHC can be monitored using :code:`ethtool -S` counters:
> +
> +=================   ======================================================
> +**phc_cnt**         Number of successful retrieved timestamps (below expire timeout).
> +**phc_exp**         Number of expired retrieved timestamps (above expire timeout).
> +**phc_skp**         Number of skipped get time attempts (during block period).
> +**phc_err**         Number of failed get time attempts (entering into block state).
> +=================   ======================================================

ethtool -S is for networking counters.
-- 
pw-bot: cr

