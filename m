Return-Path: <netdev+bounces-26100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF19F776CA7
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 01:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6861C2142F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921561DDFA;
	Wed,  9 Aug 2023 23:09:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAAB1D2F0
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 23:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4473FC433C7;
	Wed,  9 Aug 2023 23:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691622586;
	bh=5jZwuy1kKrsXYVoB1aKTo+x+H4fo5KwB3TxAuEdt45s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kox8NaSK981W81WvUp/v5vUFStHdZ2ft/6Umndved8ZLzRixG9G2r1i20iJdDOglX
	 ucbOOA3aVLXqQ+PllMSdgDsKoyDA7PvhaVX5KeCbZUcwfa7d30RJzdyi8KFk0hUZZw
	 K6VmuvDR3Z+TL9UPiwFlaHCJoYOvhdENGefnX4hV0/dHjozU8c7FQUvycPDU6gh2+j
	 Q8q9kEehvIDMcEKaXVECKzP1R/x7CD4/OZ6hrtHIfYaZhEP795xIdmJt3cRgceJi8X
	 LsxzkrFmXpQv1AwZpRxkAWZ0AnVwNaTPLXgv7qm6o7/BqxhD+3x6tGXGZU/SjsH7oK
	 Wx+TtfPChsVuQ==
Date: Wed, 9 Aug 2023 16:09:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, linux-rdma@vger.kernel.org, Maor Gottlieb
 <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH mlx5-next v1 00/14] mlx5 MACsec RoCEv2 support
Message-ID: <20230809160945.386168f9@kernel.org>
In-Reply-To: <cover.1691569414.git.leon@kernel.org>
References: <cover.1691569414.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Aug 2023 11:29:12 +0300 Leon Romanovsky wrote:
> This series extends previously added MACsec offload support
> to cover RoCE traffic either.
> 
> In order to achieve that, we need configure MACsec with offload between
> the two endpoints, like below:
> 
> REMOTE_MAC=10:70:fd:43:71:c0
> 
> * ip addr add 1.1.1.1/16 dev eth2
> * ip link set dev eth2 up
> * ip link add link eth2 macsec0 type macsec encrypt on
> * ip macsec offload macsec0 mac
> * ip macsec add macsec0 tx sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
> * ip macsec add macsec0 rx port 1 address $REMOTE_MAC
> * ip macsec add macsec0 rx port 1 address $REMOTE_MAC sa 0 pn 1 on key 01 ead3664f508eb06c40ac7104cdae4ce5
> * ip addr add 10.1.0.1/16 dev macsec0
> * ip link set dev macsec0 up
> 
> And in a similar manner on the other machine, while noting the keys order
> would be reversed and the MAC address of the other machine.
> 
> RDMA traffic is separated through relevant GID entries and in case of IP ambiguity
> issue - meaning we have a physical GIDs and a MACsec GIDs with the same IP/GID, we
> disable our physical GID in order to force the user to only use the MACsec GID.

Can you explain why you need special code to handle this?
MACsec is L2, RDMA is L4.

