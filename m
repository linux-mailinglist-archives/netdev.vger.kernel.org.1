Return-Path: <netdev+bounces-110417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4669392C41F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 21:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F0EB21096
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ACD182A63;
	Tue,  9 Jul 2024 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpFk7dmg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDFC18004F
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554731; cv=none; b=Gl6q0o11XFDRk8AR02rDQtr729+RR4yRyp/L6gWfbAv8Nyj7xx27/0uLjXJUPEV0Nn4qEhul84c65z9iKnwmCOwbEKyAkJqbKfK2YJ4EntAByUNTjZlw9iq98YBMsWhuQxVl4O6kfKFLJUVIjq46dE8JFcYIHt1BVE8Phr2qIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554731; c=relaxed/simple;
	bh=enf2LeG4xmLk31h5FTf7Vg8lw+Hu8LXx4fZwD8f6gL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWMvaUwQieyW3klmvZFdZbP2w3q1UVitntoquVHqYmEocGKX0h92mUGJXB1YgaYe/peJPUurEzNA9CsKtyrZ2exC4L4VkY2L+IvecRAR/SOB3zOthxiWyY2wMBS8bxbfGu0ti0ABYide+HbL6hC/5D0LxE3p8Fx8piHIijRZqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpFk7dmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606E7C3277B;
	Tue,  9 Jul 2024 19:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720554730;
	bh=enf2LeG4xmLk31h5FTf7Vg8lw+Hu8LXx4fZwD8f6gL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NpFk7dmg+sXWvW9LhVqhNWiiip1158VHTBtbe07Nk7oOlYGoJejUYyawyuzDcBiAU
	 vCVB4iNSEgqry7GURceADuI67C6oHJnpXk9V4lujNRtxC3mjOnz8xougLFqQgNa6io
	 iYthhBf67k4fVFUC19VQgvFs1jcrxLD2n3Cn3ZpnjO4CvPgRKtNiFp+LUEKpCt0cvy
	 Cy9ScpnloSkXgPW3ro/J0uCXIByX8GTDbpVYOgRAfdOSmeIb46cY85sRw9a4BiSeZM
	 o1SlJgA0p8FY1VY6MyK6vbWimEDM7GFReJq4ZeehAwV4HnOlsBSCruN7BpRmod8H45
	 nZvfrODoTlBqQ==
Date: Tue, 9 Jul 2024 12:52:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, Dmitry
 Safonov <dima@arista.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 0/2] tcp: Make simultaneous connect()
 RFC-compliant.
Message-ID: <20240709125209.71d02207@kernel.org>
In-Reply-To: <20240708180852.92919-1-kuniyu@amazon.com>
References: <20240708180852.92919-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jul 2024 11:08:50 -0700 Kuniyuki Iwashima wrote:
>   * Add patch 2

Hi Kuniyuki!

Looks like it also makes BPF CI fail. All of these:
https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-07-09--15-00&executor=gh-bpf-ci&pw-n=0
But it builds down to the reuseport test on various platforms.
-- 
pw-bot: cr

