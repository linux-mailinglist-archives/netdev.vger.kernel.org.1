Return-Path: <netdev+bounces-18697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB7C758534
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36A528168B
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A37154AE;
	Tue, 18 Jul 2023 18:56:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE346A1
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACADC433C8;
	Tue, 18 Jul 2023 18:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689706594;
	bh=bhwIBy2XJmrRGvw+UAV1eCb/VobOIZb9vdtGEjkUtgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=djeBSKRzlIs8iQXUL6gcxUjyucesLA2o4CsDuSmVWNjegfzCW3aqr7rIoVJOHXt/D
	 gKGIqnTjzx2dNMMMJsQv7nHYVh5nY3brjd0qJVwCByLb4RO6n2XReWVDwhHxtADiIM
	 a5UqndZwyF4+RWHLY+QxHbv5C2BtHJ6AtDg4HbXTJlnjIA6HKwaMN6K9m4wJqAtG1r
	 tge28cpvS59C3vddS4lgKTdJlEIH5secAJgDoKXbClPD5XyvZ8dxLEWIoBN32AHfs8
	 iVXX8Uiwx9DuelhYL8fff38hDZ7Ee3l/cnuprIT78rOMBGvTavCrnjftatm8ayuYKS
	 M8VoKKlt17VVA==
Date: Tue, 18 Jul 2023 11:56:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netfilter-devel@vger.kernel.org>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH nf-next 1/2] netlink: allow be16 and be32 types in all
 uint policy checks
Message-ID: <20230718115633.3a15062d@kernel.org>
In-Reply-To: <20230718075234.3863-2-fw@strlen.de>
References: <20230718075234.3863-1-fw@strlen.de>
	<20230718075234.3863-2-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 09:52:29 +0200 Florian Westphal wrote:
> __NLA_IS_BEINT_TYPE(tp) isn't useful.  NLA_BE16/32 are identical to
> NLA_U16/32, the only difference is that it tells the netlink validation
> functions that byteorder conversion might be needed before comparing
> the value to the policy min/max ones.
> 
> After this change all policy macros that can be used with UINT types,
> such as NLA_POLICY_MASK() can also be used with NLA_BE16/32.
> 
> This will be used to validate nf_tables flag attributes which
> are in bigendian byte order.

Semi-related, how well do we do with NLA_F_NET_BYTEORDER?
On a quick grep we were using it in the kernel -> user
direction but not validating on input. Is that right?
-- 
pw-bot: au

