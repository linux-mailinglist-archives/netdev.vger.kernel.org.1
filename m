Return-Path: <netdev+bounces-166103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D577AA34857
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3002D18834CC
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819FF198E76;
	Thu, 13 Feb 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V47g1rZ4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C678194AD5
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461240; cv=none; b=MNBChg/60oEderOIcOP6ATSa6PuVwns15EP0RQs1jzXQqiJV6Rxa20njU9SId0YVWXn1UnXh2MAqI5ZwIhC66KL029csNoRdUAH2pdL6d7o/MBPcmLSHcddQ0yF1aahHIX5YxEZvQxNAgyxjZtyNKKcCOPDfV7kuMBp1ND+zxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461240; c=relaxed/simple;
	bh=YCRkLrPUnwi+OvbrB7V1Y1COd7ayIFeNhVFP/q4ZQ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTIxz9PJvoNo0RmMvOHd3MFGTzU/aRTywa+oLEnMtUYvBhbZAFMV/Kin+MIWNC7gZ2PqYTx0ROgJ3LCIKRv/LryLb+h8zfDdkBcBU6zshMuiDdk0AwvJUZAwaJEDJiwyqX649EnnDtRz7NRuycoKb1qUiPqM8RStHRShHwuVWwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V47g1rZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFC1C4CED1;
	Thu, 13 Feb 2025 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739461240;
	bh=YCRkLrPUnwi+OvbrB7V1Y1COd7ayIFeNhVFP/q4ZQ+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V47g1rZ4l0HLxv3tGDKteGv0w1GOmbrJNkyjbBRQoUpn6mCWX+vEWGA9vT0pfSKyH
	 8qYYpEjZKIMRyqTFRQ8RuYYBqG+I5uKXbuU/Zwzj1LxM45s8Hp6NYfXSqUOowKSYnE
	 ryGhtz1Lb8qwGswenxokM/skyYqVNu/bgfPy6O2alVP8UAziGMXyrNx56lQCCuIart
	 reRfqe0vMV9zGpnvdTMd6LrZpfachTrH7ulI7H7B3rU0vPCgqeooQfCGdDxvu5TIIc
	 nmlk9uBqaYCjmBifBxiAcsqYuVolFNG16AM8z2LhnQSbZqdU0NIQ+ckLK+tLwxC8dk
	 Gomdll1YqSIkQ==
Date: Thu, 13 Feb 2025 07:40:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] rtnetlink: Allow setting IFLA_PERM_ADDRESS at
 device creation time
Message-ID: <20250213074039.23200080@kernel.org>
In-Reply-To: <20250213-virt-dev-permaddr-v1-1-9a616b3de44b@redhat.com>
References: <20250213-virt-dev-permaddr-v1-1-9a616b3de44b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Feb 2025 14:45:22 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Eric suggested[0] allowing user-settable values for dev->perm_addr at
> device creation time, instead of mucking about with netdevsim to get a
> virtual device with a permanent address set.

I vote no. Complicating the core so that its easier for someone=20
to write a unit test is the wrong engineering trade off.
Use a VM or netdevsim, that's what they are for.

