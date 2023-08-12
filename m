Return-Path: <netdev+bounces-26990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A05779C58
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 03:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A5E1C20C98
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145EF10EE;
	Sat, 12 Aug 2023 01:43:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08375EDD
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 01:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8BAC433C9;
	Sat, 12 Aug 2023 01:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691804628;
	bh=MM59sm1574YJX/wQxrOJddi3KcUVRF4hQEW0KTlr9a8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bqt0gCmHLsG/lnNH+tzAQK1w5R7G1V8F6FOUqBsMJPdSRbMHA05LO/+ZyQfyORkWb
	 iWGgt8+1hJ1EMszWDxHV0x/a+MJ+7eMdxUlJ6c3RqbfNLSp19Na+LJkDjewiUfkuyt
	 2cJvLS9usR9UxH2zus0Ec9I7wldoNVICAKFb26pqpIRuV6pC9nvd0WJg8MqpT8aRMZ
	 Kph8QEkBDbUOk0S0eLNSDCtZdNNQp6Fab/y96Z/cInC2pak+HwuFAIyW9SPZEHg4Ft
	 7clYTbGLBKuKfrST3805kIRO5mFx2EfNNv3h6wA90Ezi7tBj2A0TZor7OITDO4j2sr
	 1eFduiqqPUZMA==
Date: Fri, 11 Aug 2023 18:43:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>, Frantisek
 Krenzelok <fkrenzel@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Apoorv Kothari <apoorvko@amazon.com>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Marcel
 Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 3/6] tls: implement rekey for TLS1.3
Message-ID: <20230811184347.1f7077a9@kernel.org>
In-Reply-To: <c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
References: <cover.1691584074.git.sd@queasysnail.net>
	<c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Aug 2023 14:58:52 +0200 Sabrina Dubroca wrote:
>  			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
>  			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
>  			conf = TLS_SW;

Should we add a statistic for rekeying?

> +int tls_set_sw_offload(struct sock *sk, int tx,
> +		       struct tls_crypto_info *new_crypto_info)
>  {

This function is already 300 LoC and we're making longer with 
a not-so-pretty goto skip;

Any way we can refactor it first? I think someone had a plan
to at least make the per-algo stuff less verbose?

