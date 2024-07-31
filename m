Return-Path: <netdev+bounces-114355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8943E942450
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3F3285A99
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 01:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA248C13D;
	Wed, 31 Jul 2024 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzFZy4tK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8533B10940
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390741; cv=none; b=ngdtNuS3H/TFQjK/2Ml2+Fq0SQfYi4FTUcoyoWjbGvPd4kIej7e1Y6KHrXi7kcNlbRJkE1JBvSIAMPScdFjLQa6gjB3XsN2ECSv7s9gE485zApQMZ8z+sDBCZcYpNLIUm1bRJSxrKz8HqSyyv/8twndX6hA5tJUQNU/E9KHlKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390741; c=relaxed/simple;
	bh=o1gfpFMom648uDPcRiFXobTdo0k4lAa2OHQSqab3xhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGy4xJVgHGNdcsYtt33jS9hMsCF0P8W6FOBpqO7f/8AmaaSa4c0IbmXoRWjYyleyB0GuIMqIOSOv96d5QdvmPMymF4C1VLLHM1eElORb9avvVu1Qo4JFd0ZjyxoZYTboy/SgYd6SWPclouY0hEoKaxUwOVMOG9ZEDL/LUF89lKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzFZy4tK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B290AC32782;
	Wed, 31 Jul 2024 01:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722390741;
	bh=o1gfpFMom648uDPcRiFXobTdo0k4lAa2OHQSqab3xhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tzFZy4tKcqhe2T43W9+nVnFG/HlnSJ3jiYFYiFUWQh9FMVKW7OT9yM9mGJDUZo1ES
	 hEE5tnGA42p5lOFKldR0MH+xCWdAqRZRPwFoivQWKQcws6hTVPi7q3XmPSh5Z142cb
	 bMVGjejfHfj5NA9q7YNe73Lxcu0bkYIHtd32d3oSGTbRU8TYDp2GJQJxBfe/SwTmtV
	 GnbBtfkFXA1W50mtmXexaubV+QcwW9X2PkLlpVjVHCnjmiQL4u/psgXYQ0sUgrc/ek
	 SdF0mIWjDSa9k59BpClm0ZLaQYjLVoAArzh+x0YazqFO97opH7UkHd9tUACSqvkekC
	 zeKOkQ4vZ5O7w==
Date: Tue, 30 Jul 2024 18:52:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH v1 net-next 1/6] l2tp: Don't assign net->gen->ptr[] for
 pppol2tp_net_ops.
Message-ID: <20240730185219.5df78a5b@kernel.org>
In-Reply-To: <20240729210801.16196-2-kuniyu@amazon.com>
References: <20240729210801.16196-1-kuniyu@amazon.com>
	<20240729210801.16196-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 14:07:56 -0700 Kuniyuki Iwashima wrote:
> Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")

pourquoi the Fixes tag? 

