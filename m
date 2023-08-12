Return-Path: <netdev+bounces-26989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351B779C48
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 03:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735C8281D97
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 01:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC6EA2;
	Sat, 12 Aug 2023 01:37:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D910EE
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 01:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451E3C433C7;
	Sat, 12 Aug 2023 01:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691804274;
	bh=Y3jlMG7U38Uvwq9s8XM0hS54dhwwvJi9rI3hlZA/GwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VdN+8WRIQQxtvmjwzfT7j1VOMGnph7TNmRcEOh4aQLRZCCkVy3IAZpsz+LWNMGCfg
	 JbrSTIuEDEhfRG3NzmXqZg6hPXzstIu/bYrKC59z5Z9pb2SlSrvCpoG5dCDpn23dw4
	 X0iySDDTK3MYwAOQIAA4/upzUGDOouZIulxQnkzOrGgmeA3Fxvr06Wg7e2nRm8UVWx
	 xldYuIePbx+G3NN86+HPaeNpzq/6/JG1GVhzhNaCkPVjoGUxJ8nS+o9AYGRMlnrw8D
	 x6kdbi6MCRP8i7cmKcYZZHfftrQHtG/kc8MUK3yU/jWNVn6+ukfAhz4Fnx+FCpVuj9
	 P/ZnfDEvYyOPQ==
Date: Fri, 11 Aug 2023 18:37:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>, Frantisek
 Krenzelok <fkrenzel@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Apoorv Kothari <apoorvko@amazon.com>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Marcel
 Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 2/6] tls: block decryption when a rekey is
 pending
Message-ID: <20230811183753.3a18a09a@kernel.org>
In-Reply-To: <eae51cdb1d15c914577a88fb5cd9d1c4b1121642.1691584074.git.sd@queasysnail.net>
References: <cover.1691584074.git.sd@queasysnail.net>
	<eae51cdb1d15c914577a88fb5cd9d1c4b1121642.1691584074.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Aug 2023 14:58:51 +0200 Sabrina Dubroca wrote:
> +static int tls_check_pending_rekey(struct sock *sk, struct sk_buff *skb)
> +{
> +	const struct tls_msg *tlm = tls_msg(skb);
> +	const struct strp_msg *rxm = strp_msg(skb);
> +
> +	if (tlm->control == TLS_RECORD_TYPE_HANDSHAKE) {

unlikely()

does the nachine code look worse if we flip the condition and return
early instead of indenting the entire function?

> +		char hs_type;
> +		int err;

I'd probably err on the side of declaring those on the outside, but if
we don't we should move rxm in here, it's not needed outside. Either,
or.

> +		if (rxm->full_len < 1)
> +			return -EINVAL;
> +
> +		err = skb_copy_bits(skb, rxm->offset, &hs_type, 1);
> +		if (err < 0)
> +			return err;
> +
> +		if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
> +			struct tls_context *ctx = tls_get_ctx(sk);

feels a bit like we should just pass ctx rather than sk?

> +			struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
> +
> +			rx_ctx->key_update_pending = true;
> +		}
> +	}
> +
> +	return 0;
> +}

