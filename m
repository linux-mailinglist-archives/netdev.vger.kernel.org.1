Return-Path: <netdev+bounces-196304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C42F9AD421B
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 20:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDE5189F2BE
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93497248F5D;
	Tue, 10 Jun 2025 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="dlLWMFSs"
X-Original-To: netdev@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17DC24633C
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580976; cv=none; b=Df6fCy1EXfxbS7rgLXL8ua/2AWH5h6/9sJu3ELO3IZ1DbNeKFVUPg/uBk7cp8/34qX++YIRuo5P6PGXIO4+0PLSnCxkPw4aJnF3//uFLpM1GG/+RAfZJBnfr34lfsFLH11lXTbDY1RfYtF9ivfDgNjOBJvWf/dfEPKvA5nzMp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580976; c=relaxed/simple;
	bh=dGxTGRnOY1xPdKB8cIj79Y8GfEHXDECv2UQgCzN1n9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ai6cdJSnye5z8IbAaf0fvyDcJncsbCKrtrk0AdSft9FQaFKkQgzZkCFqvnHA5MdghXQv9NbppIZ6FvJYYpBAqPK57eCncvuM7yJm9RyUZC5UMgbZjqbKXvdQsVK/Nl6+Z8YnoijsP+w3gYX+yBcI8+9Z8g5CNrY8+bgnNeft4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=dlLWMFSs; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id A5E2A240104
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 20:42:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net;
	s=1984.ea087b; t=1749580972;
	bh=dGxTGRnOY1xPdKB8cIj79Y8GfEHXDECv2UQgCzN1n9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=dlLWMFSsqfR8IkK79XWUgkZBzdY8nuHjkLrp29CeGhlXUKmB0FymlPgGASNgL4Gzm
	 ffPLGgLUUETqUx9BT/Nv8VgZ1K5/Ym9OS2xjySVqm8mGd8/b9tBekcgcozQFmNsRut
	 Q5P1GzOW+h9RrmUC4cGYx107OEI3WARDGLEcbeDAif3MrCngCIDUMHohVtk/6jn2MZ
	 j7BfVFCsBtX01MQ6WjYOaElo2J7Hl46o4+Vp7yi+EEfRhs7BDIMWZ4hkM5s0JsvvDN
	 MYbko9ulnD689jTmN9rfZZlilHNHzNHpvZa4ac8oPYiN/E+niiOAAysgHSgKYt+02H
	 RVssQHELTHQQo0dcN6nZyxdZJUMdel4/E5/h+dlOXQGmpJTpuQpWJtQW/pAsVMNP/h
	 yN6FN5Rkiy10nqeeWxFNqqjeVMsSn79ppNrXZWFgEVQZZrcte5Lyi/VhzgnjqdhgMq
	 OSqQaouSFUxQ6qY8Qhrf0PzENFqJEttxg+CLMII91T+XSeZw8Tg
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bGyMv16cjz6tvd;
	Tue, 10 Jun 2025 20:42:51 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: RubenKelevra <rubenkelevra@gmail.com>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  kuba@kernel.org,
  edumazet@google.com,  pabeni@redhat.com,  horms@kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] net: pfcp: fix typo in message_priority field name
In-Reply-To: <20250610160612.268612-1-rubenkelevra@gmail.com>
References: <20250610160612.268612-1-rubenkelevra@gmail.com>
Date: Tue, 10 Jun 2025 18:42:28 +0000
Message-ID: <87cybbzbe3.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

RubenKelevra <rubenkelevra@gmail.com> writes:

> Fix 'message_priprity' typo to 'message_priority' in big endian
> bitfield definition. This typo breaks compilation on big endian
> architectures.
>
> Fixes: 6dd514f48110 ("pfcp: always set pfcp metadata")
> Cc: stable@vger.kernel.org # commit 6dd514f48110 ("pfcp: always set pfcp metadata")
> Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>
> ---
>  include/net/pfcp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I had the same issue today, happy there's a patch for this.

Reviewed-by: Charalampos Mitrodimas <charmitro@posteo.net>

