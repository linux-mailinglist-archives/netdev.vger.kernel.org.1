Return-Path: <netdev+bounces-114357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F317942452
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E5A1F22F51
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 01:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD00C8FE;
	Wed, 31 Jul 2024 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWRaSgV3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98000C2FD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390854; cv=none; b=Mt7AE+9xvHozrWqOypHn5HaYD3MKoccQvQtRZo/wlPye60T4UqeHfXHBHeY4WquXaPiI7G9/EjwThq+maStABe6Aluv/1EwRuAA1DEchpL95h1iKNdsLk9xSh52XBeaIZwitG/W3kN4PvhwBfBsPaNdt/bTgjromL/OLT9a9ChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390854; c=relaxed/simple;
	bh=LwJQJ8u/Qxj1WEpBejFg+5/I+32BruMD0NAcFlEe/+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efPa7oAZT31h/nyrjJsv/nT/LJPkqi5GHsKcmC7HbxNiV4+3hKlCarPXz0Gi8QCNKUKS0JNZ/uf5mucSTO27aDCvUMVPOWZBdQdQvwsr+UoPJ0WpRIUGUJec6LfzY+D+6byAB0w32F3xLHReXTKkVffXZMQ/VVHSUYNGIp9xo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWRaSgV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB29CC32782;
	Wed, 31 Jul 2024 01:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722390854;
	bh=LwJQJ8u/Qxj1WEpBejFg+5/I+32BruMD0NAcFlEe/+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWRaSgV3ob2OBJm5Czli9yM2sRc12/ewsiQ9zEM49IIP4CV75Q1G9Rq+uSe5Cs2lh
	 +xQEaYzHMBTXs0G3iQVT7GhEkvg425I3RE4C6r+Vrkz4RbN+Xe8+P81jlanD0C1Zww
	 VC6ks9xNFd/OPBzEuLtN3nDjvLyqLkr22kyXdx0nhqhW98TtwHEi+7naBxCypztmcp
	 QLY5Vwr6MDvN5Am6Zd7z8BY9FAUxp3TXF/Xbs2f/TV6a/u0m/u/jIKgeaslfbpFIUM
	 CUFKwwFMrV5yex+CBIUPWj09AmOtgIgKn18vi03vu496JelBYlhtaBH25QG+33eM+h
	 BRCS2hWd0O6lg==
Date: Tue, 30 Jul 2024 18:54:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 2/6] net: Don't register pernet_operations
 if only one of id or size is specified.
Message-ID: <20240730185412.2a18262c@kernel.org>
In-Reply-To: <20240729210801.16196-3-kuniyu@amazon.com>
References: <20240729210801.16196-1-kuniyu@amazon.com>
	<20240729210801.16196-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 14:07:57 -0700 Kuniyuki Iwashima wrote:
> +	if (WARN_ON((ops->id && !ops->size) || (!ops->id && ops->size)))

I'd write as:

	if (WARN_ON(!!ops->id != !!ops->size))

or

	if (WARN_ON(!!ops->id ^ !!ops->size))

but not 100% sure if it's idiomatic or just my preference..

