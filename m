Return-Path: <netdev+bounces-102427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C646E902E75
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0A31F23602
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A394516F851;
	Tue, 11 Jun 2024 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/fylYEa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C314F9FA;
	Tue, 11 Jun 2024 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073337; cv=none; b=PqV4NBhQYUvQ9MoPj4VQDcoau4NX0ozD5irXTGdnGp7qzVgmxbPPLQQ6XJ5sBmXFFAAXzwIaCVdLSL/UkDngjj0iS57NUQhzIUzVd1kVccCiq6mQ1+KQ6QL5LtGl/V9mc0wpkFVLTi/8+60PU5icgl/slxwacyHnJe13uziFNGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073337; c=relaxed/simple;
	bh=UEyJAU3xAHorFHFJPY+I2aNVPhcLs0v3TggMBQJLdbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdqQkk5fNc7bG1OjhxAsAQET/b5/AYoQqkiha6h8cQcJG96Yma6uR5DOx3vOdYtl30PdrdYUjN7V/G5pMwknU+1VFKTiJDFoZnaGEJ9SR42+mQTbKrFOfXaazHgsXbxw8Jf+Yjp71rUkd8+IIUxC7EzWHG2EwYgxqffRY3skC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/fylYEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFCBC2BBFC;
	Tue, 11 Jun 2024 02:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718073337;
	bh=UEyJAU3xAHorFHFJPY+I2aNVPhcLs0v3TggMBQJLdbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D/fylYEaA+X7RmWFqb1Q0J/YL7XZ/EN5IFNe1FqaQ2h21xLBBfXKfq5DItML8sNNE
	 X898cpi0V9eBbKlo3Rd4XzHgGHxKIk2LJfp0Ixr1mZNmN5nWjFC9OosjZ53Zf5/qk+
	 ffRfEOKJr6bS3f0IhaJiNK1H8RSfc74cunEF7hKmxRWmAMa9BloiloF2Zx0lEI5+rJ
	 mFnEUlzr2IkVvDjlQPYxIoUvZxNqUHtoRIxVX6FD/AbEXmIgukjdm4BrqT1btrUmf+
	 Xdm2E31z/D02oY/xt7grwGpI3ebcO4Rx5XpCXt+E/mwztzD5sRC324ITW7FgJ9xYKJ
	 yYL9/cb3M65eA==
Date: Mon, 10 Jun 2024 19:35:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, stable@kernel.org, Praveen
 Kaligineedi <pkaligineedi@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrei Vagin <avagin@gmail.com>, Jeroen de
 Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rushil Gupta <rushilg@google.com>, Catherine
 Sullivan <csully@google.com>, Bailey Forrest <bcf@google.com>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] gve: ignore nonrelevant GSO type bits when
 processing TSO headers
Message-ID: <20240610193535.31fcef71@kernel.org>
In-Reply-To: <CALuQH+UtX2xqDCghHqPBckzC4k-GGi58NmOd4FNfeqOr+C4jWw@mail.gmail.com>
References: <20240607060958.2789886-1-joshwash@google.com>
	<20240610225729.2985343-1-joshwash@google.com>
	<20240610172720.073d5912@kernel.org>
	<CALuQH+UtX2xqDCghHqPBckzC4k-GGi58NmOd4FNfeqOr+C4jWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 19:26:32 -0700 Joshua Washington wrote:
> My apologies. I'll send an updated patch tomorrow without --in-reply-to.

No need, it's still in patchwork, it was just a note for the future.
I should have made that more clear, I realized that after hitting send.

