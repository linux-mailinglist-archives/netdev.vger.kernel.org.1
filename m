Return-Path: <netdev+bounces-32295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE38E793FD0
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 17:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433A1281196
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E96810795;
	Wed,  6 Sep 2023 15:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE61C36
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 15:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8D1C433C7;
	Wed,  6 Sep 2023 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694012552;
	bh=KrD1EntFi6jr7v0be9e4MFWTaCDZ8FeZGGyX157lBH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jzmtvy9767a/caBokxwPGd1A+VnqziMAOgtX+UNB7CTJ8bv8oHd6z1o9sBZ3wgcuk
	 SxPY3Mon3roOwbcPdEWinJSdZQ7fIj8JAaq9l0kCdecVYa0uMfU3S/17tHB0DoD8OT
	 ujjPasBppX0S/vS0cl5J3aaceFcqlt6OkWH9plMbMSjTZ28plt/6yw7kZG1o30/OLr
	 nYBZvYQ0CIPtI28sr+Ryae0zssB7Et7U+s8DO+3c4KYYQ3Aw6Od7YPiAdAX/yhyKDd
	 P2+jyw53quYbzwhhtJggsNejQCHGHZkhx0eSbcJ3r2a96fJoJ019nfpNKnVut2w4v/
	 VvjKcErh0CEug==
Date: Wed, 6 Sep 2023 08:02:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Liu Jian <liujian56@huawei.com>, borisp@nvidia.com,
 john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, vfedorenko@novek.ru, netdev@vger.kernel.org
Subject: Re: [PATCH net] tls: do not return error when the tls_bigint
 overflows in tls_advance_record_sn()
Message-ID: <20230906080231.18d99950@kernel.org>
In-Reply-To: <ZPhcTQ3mFQYmTHet@hog>
References: <20230906065237.2180187-1-liujian56@huawei.com>
	<ZPhcTQ3mFQYmTHet@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Sep 2023 13:02:37 +0200 Sabrina Dubroca wrote:
> I've been running the selftests with async crypto and have collected a
> few fixes that I was going to post this week (but not this one, since
> we don't have a selftest for wrapping rec_seq). One of the patches
> adds -EBUSY checks for all existing -EINPROGRESS, since the crypto API
> can return -EBUSY as well if we're going through the backlog queue.

BTW is it possible to fake async crypto for a test or does one need 
to have an actual accelerator?

