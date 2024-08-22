Return-Path: <netdev+bounces-121189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF9D95C17C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8E01C2106F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 23:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1D31CC17A;
	Thu, 22 Aug 2024 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7Ya7Wjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728717E006
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724368787; cv=none; b=HMT2UsU0ET23jItXc+6DyfWoWDkY3vZzN80QIzcNjGM2C4QLrgzcILKpSmTF28d38ZCVKEPcxdHlPIO4KhNWpHhUYHIbW+oGLqAoyXm+LfCxFc2HFIIjP1VD6oeCfnVRL5Ttktga1gKjJS1NPuKql+Tx+gITxNdM87UnE/Qz1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724368787; c=relaxed/simple;
	bh=0WEOgq1nPruOSSbIlWM+Zwp25QCdjGSmnDCeBksOl6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+BXp3OMlEiRx2Jqajyf6R0owk5QKRIJ4NkUKUQcGi1+uG99VxWSQXc6fATTcQBZfPOLKQE/wZQqmOLkgmoJYuVwiNkDtMrc1WV3B5FINNNOTCviSFf0RbTa9Udd5DXOEUt6qUIwXnPfctLcFzN7lhh25/7uhsEde6FbXqY3Ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7Ya7Wjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA96C32782;
	Thu, 22 Aug 2024 23:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724368787;
	bh=0WEOgq1nPruOSSbIlWM+Zwp25QCdjGSmnDCeBksOl6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M7Ya7WjoFFtbqMJprpveP1iNKvaco3uo2PjASy+tPKvGuIIecf/04mNNSI8/Sj/aB
	 BmLwUTgXN06SVTDFMCGoWPwKhRPaHceHtvEKlQyApLvoAfs9ol5MJnKA03SR064VXy
	 ZcZPX6zcFQsrSA6d4qEaV5nV89OjePAdGtsD2BT0wvxjekBjCn4ygX6/DAZyz51rzE
	 1MdToLyYHdYbWU+AnaAM3OYU4wX9wDoFG2Unh48YYa3omi/M8gEdqL8otZhYx3Q5GI
	 GmaPKS1NkKY5U0HR1e8+0tmVtiQed1XSAy5C9GcccPEm4jsvdbtUn6M35LhjWG+jK8
	 r89sFAfp8Lorg==
Date: Thu, 22 Aug 2024 16:19:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, "liuhangbin@gmail.com"
 <liuhangbin@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, Leon
 Romanovsky <leonro@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 "andy@greyhouse.net" <andy@greyhouse.net>, Tariq Toukan
 <tariqt@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH net V5 3/3] bonding: change ipsec_lock from spin lock to
 mutex
Message-ID: <20240822161945.7b237a5d@kernel.org>
In-Reply-To: <02d8277b-e6fc-44d4-8c88-2eb42813cd22@nvidia.com>
References: <20240821090458.10813-1-jianbol@nvidia.com>
	<20240821090458.10813-4-jianbol@nvidia.com>
	<120654.1724256030@famine>
	<2fb7d110fd9d210e12a61ebb28af6faf330d6421.camel@nvidia.com>
	<139066.1724306729@famine>
	<02d8277b-e6fc-44d4-8c88-2eb42813cd22@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 19:15:24 +0800 Jianbo Liu wrote:
> +       dev_hold(real_dev);

netdev_hold(), please, so that we can find the location of the
reference leak if a bug sneaks in.

