Return-Path: <netdev+bounces-28534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD0277FC4E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364252820D5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4C1168A9;
	Thu, 17 Aug 2023 16:45:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6B1154AD
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 16:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08104C433C7;
	Thu, 17 Aug 2023 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692290730;
	bh=T7CaczE4fx99yNyJb7K4H+68w6ueE9VHwt80AuJDPqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NiEcBN6cBpuPy14fX1WNxXOlf9NtLUERSPibnl4UqT0xxV86a2YxuX5GdnxyDaG0b
	 nD5h26huuie9ahpT6IFsMnIa5pl1lvLY4E2KyIFtk6ncopIoLyTRGTGUTb2LN7qIQD
	 bMAMII4fpJaqUXFxzg8co3GmT0DuCf2gdqcpd/HlatFePrRBp0JMmqRyPxdfU7iN0r
	 Y+/EMRi4mtMVUEtWDGTISY1hkQmib2PvAhCeeEvMLaRPrlPcx7u/9rS4343IR1Khe1
	 NTJKBCbOUgIz/ol/aymtqgu/kbw8PQeGiFdBjX2J7SbaiCn0Wkg237RFG3ZBfvuxcR
	 3S9KaRQFXtYMQ==
Date: Thu, 17 Aug 2023 09:45:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] can: netlink: support setting hardware filters
Message-ID: <20230817094529.68ae1083@kernel.org>
In-Reply-To: <20230817101014.3484715-2-martin@geanix.com>
References: <20230817101014.3484715-1-martin@geanix.com>
	<20230817101014.3484715-2-martin@geanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Aug 2023 12:10:13 +0200 Martin Hundeb=C3=B8ll wrote:
> +		int len =3D nla_len(data[IFLA_CAN_HW_FILTER]);
> +		int num_filter =3D len / sizeof(struct can_filter);
> +		struct can_filter *filter =3D nla_data(data[IFLA_CAN_HW_FILTER]);

This will prevent you from ever extending struct can_filter in=20
a backward-compatible fashion, right? I obviously know very little
about CAN but are you confident a more bespoke API to manipulate
filters individually and allow extensibility is not warranted?

