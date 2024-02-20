Return-Path: <netdev+bounces-73455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559EC85CABB
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 23:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AAC1C215F7
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDFE152E19;
	Tue, 20 Feb 2024 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJwFPGgc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C414F9CE;
	Tue, 20 Feb 2024 22:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468071; cv=none; b=llPYd2RXVskp8peJtg0bmdBg3bOPZeGyez2HFnF8FisahbKd+RKpO62+R3fpxOwyQkrhR7+TP62y8vLk+uF/17gacwmxwNrwO4mNtwxuSKkrIenLQBLC9yLzlvnw6eIoeHCvwwH2kydkHx+sRMiVuHSQWFHMSledJENpR/sMkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468071; c=relaxed/simple;
	bh=bq4xGo8TbQn2XGfX30aj57X4XFF9C7kBpD3L2Qy8HVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYGg2unzt9z4thSZLITw5zNPH4J3iLVZoCD5j31Np6ptZlI+JW32QlyQfrfVUbWWI+kToMrhL4Gopboq5KUCJ9HEnizL8snMmWL7ncRINGnH1Af07nendcIjdj3bMAVUph3B5W+w9IhDEh8i+QKYAQc4dbaFUnf/4laRHocwqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJwFPGgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6CAC433C7;
	Tue, 20 Feb 2024 22:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708468070;
	bh=bq4xGo8TbQn2XGfX30aj57X4XFF9C7kBpD3L2Qy8HVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jJwFPGgc8VWQ2Wq/B6ok9kukaeZ+jPmtUYa5Q8Flb6IKqEzxDSv32mw4FPj1kda7e
	 un0ZCy4UxV/LUtQDdVX3M0n2aDejCegWgzOH2QxTHdvmz+oqG3ZbP23RY9f1+3sZfc
	 LkVhicNF3VwIJM8Ubq3ec/7vtVCp4XfPz/v1qyjMByWE0BSqDh7n1kRnXuFZfWeWdV
	 q0SLl5cHsAiVHtlw78jAy2Ne04wFL8e7xT3CxfA1MNTI0qC8ppa0dKArTCMAjuiowZ
	 hbUur05D9v636MtD2iE/CNgpcSTK0A6TxYXTp33JBxWSIVB2AftiQJN9HarXvHpoh8
	 xZ4JirlQUNXLg==
Date: Tue, 20 Feb 2024 14:27:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dan Jurgens <danielj@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 Jason Xing <kerneljasonxing@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "xuanzhuo@linux.alibaba.com"
 <xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240220142749.42cabbac@kernel.org>
In-Reply-To: <20240220130528-mutt-send-email-mst@kernel.org>
References: <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
	<20240201202106.25d6dc93@kernel.org>
	<CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
	<20240202080126.72598eef@kernel.org>
	<CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>
	<20240204070920-mutt-send-email-mst@kernel.org>
	<CH0PR12MB8580F1E450D06925BEB45D72C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240207151748-mutt-send-email-mst@kernel.org>
	<CH0PR12MB8580846303702F68388E9713C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
	<CH0PR12MB85807A30B1F42A4E354516A1C9502@CH0PR12MB8580.namprd12.prod.outlook.com>
	<20240220130528-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 13:05:46 -0500 Michael S. Tsirkin wrote:
> > Michael, are you a NACK on this? Jakub seemed OK with it, Jason
> > also thinks it's useful, and it's low risk.   
> 
> Not too bad ... Jakub can you confirm though?

Ughhm. Let me implement the generic API myself. I should have a few
hours tomorrow, knock wood. I guess the initial set of stats requires
some "know what you're doing", and it will be smooth sailing from
there..

