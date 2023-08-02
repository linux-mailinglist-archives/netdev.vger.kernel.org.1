Return-Path: <netdev+bounces-23479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198276C1A0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 02:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8A81C210D7
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA2637;
	Wed,  2 Aug 2023 00:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743467E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E75C433C7;
	Wed,  2 Aug 2023 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690937424;
	bh=Nf6D7M2JP3L64dvYAmuuDauHNFli1OiiK/HYv1NiMK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LItWlg7nWUsfJK+UGBH1LD92k1qVtxKveiAAYGB1qovAcCvO3MQVEQmxw5dHfppJ1
	 6cxC7P92achF+TR/3tYCWuN0aQOWNgz9vShnQWOijUJqfBn4vFqHj2qTzCs2OeCndt
	 tk1djbY30O5fFyT5MJV8iQNpeGA7pUursXtTRsO9bATG4qqwvGBjOk6RX7C7jdYjf5
	 5QK4fuxSgGFRYb0qmTW/HczcZf2EcwccjpsoNWnPW4YChVCXpKABcfJ1EJKpnolBYt
	 RaqlDJxkkfZLAFo0pnhIWUkLnxmXoM6nzMYlYwW4IxA8tVy3o6gD0NyhUdL10ud90u
	 86x6/A/ZN6HrA==
Date: Tue, 1 Aug 2023 17:50:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: "Nambiar, Amritha" <amritha.nambiar@intel.com>, netdev@vger.kernel.org,
 davem@davemloft.net, sridhar.samudrala@intel.com
Subject: Re: [net-next/RFC PATCH v1 1/4] net: Introduce new napi fields for
 rx/tx queues
Message-ID: <20230801175023.3eba3a6f@kernel.org>
In-Reply-To: <802d3a2f-c2fb-2e11-b678-e8716ef93f12@kernel.org>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
	<168564134580.7284.16867711571036004706.stgit@anambiarhost.jf.intel.com>
	<20230602230635.773b8f87@kernel.org>
	<717fbdd6-9ef7-3ad6-0c29-d0f3798ced8e@intel.com>
	<20230712141442.44989fa7@kernel.org>
	<4c659729-32dc-491e-d712-2aa1bb99d26f@intel.com>
	<20230712165326.71c3a8ad@kernel.org>
	<20230728145908.2d94c01f@kernel.org>
	<44c5024a-d533-0ae4-355a-c568b67b1964@intel.com>
	<20230728160925.3a080631@kernel.org>
	<802d3a2f-c2fb-2e11-b678-e8716ef93f12@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 18:26:26 -0600 David Ahern wrote:
> I take it you have this path in mind as a means of creating
> "specialized" queues (e.g., io_uring and Rx ZC).

TBH I've been thinking more about the huge page stuff and RSS context
handling. Rx ZC should be a subset of what's needed for those cases.

> Any slides or notes on the bigger picture?

I don't have it well figured out, yet. The user space API is pretty
easy, but shaping it in a way that makes driver's life manageable is
more challenging.

