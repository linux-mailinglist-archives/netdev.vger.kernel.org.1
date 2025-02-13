Return-Path: <netdev+bounces-165771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBFFA33566
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0773A79A6
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85261411DE;
	Thu, 13 Feb 2025 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9k8Q0/q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EE1EB39
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413066; cv=none; b=sQbX66feQtuAWJjTJwyPVTt8/FUceDfOheo3A3b0Gf363LevE5Alktv8yWn7CYd2A2xtKl6oPvFI6oMBVb1zxo2gCVf69OfeKYiwMzn+YU/F541Zo94JWUgXdCDAv6SNMufXZw70iNuR2e0cHAuz25MLwgG/6u6RxHSkeKu/vRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413066; c=relaxed/simple;
	bh=rmcLOaNbAzLeZaSKjicmpAn0djEm00Tbl+831XOIW+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtVWMDgJ5VWUNYsvjEERgO02yZsqKwwainpl8mR0+v1lNgNlgH2dZ2ucse4EptrWt7tyvr3uWZqY7Tj/4AfMPMlZcTLxDzeFbVJG3C331Rlzji7u38yviN2dGBm8CXgQnOlkjvwrEBOzdI4mlF3jl5/fw9D4MjuxJHw20qDIsl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9k8Q0/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9298C4CEDF;
	Thu, 13 Feb 2025 02:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739413066;
	bh=rmcLOaNbAzLeZaSKjicmpAn0djEm00Tbl+831XOIW+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E9k8Q0/qQtxnswVP1GkUXV8HnbMUwpyAryk6b449KucN1VmO+iRnzFRsMVp+jEncp
	 kJmXvreuUq4KuAocVNebokuvEW4RSpLXiw6TocMSlDWPmszWSfZezIWZNp/Zx2BTDm
	 zRevI30dRJiBJZ7suu/zLCu1oMqmeJT0PejWDA2AR810R8xpORoq+IaUzzCJvBMevK
	 Ij41L5T5/05yEbFHFvWrEMnNlCJOiBUSU1r2/vFEC4z7xfv5kCqLChlQfBpHBELWc2
	 RjoHkhJFcJeQfandoKArw1T5HRM1MRYxBq2NZYArSnX7jb/rC8w3Gogh5Yr1W78CpU
	 Ok69zayFWHjjQ==
Date: Wed, 12 Feb 2025 18:17:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <richardcochran@gmail.com>, <linux@armlinux.org.uk>,
 <horms@kernel.org>, <jacob.e.keller@intel.com>, <netdev@vger.kernel.org>,
 <vadim.fedorenko@linux.dev>, <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v6 1/4] net: wangxun: Add support for PTP clock
Message-ID: <20250212181744.606e5193@kernel.org>
In-Reply-To: <03a901db7d22$24628cc0$6d27a640$@trustnetic.com>
References: <20250208031348.4368-1-jiawenwu@trustnetic.com>
	<20250208031348.4368-2-jiawenwu@trustnetic.com>
	<20250211160706.15eb0d2a@kernel.org>
	<03a901db7d22$24628cc0$6d27a640$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 15:45:52 +0800 Jiawen Wu wrote:
> > Why not use the aux_work for this?
> > IIUC aux_work often has lower latency since it's a dedicated thread.  
> 
> I think this task for checking TX timestamp is immediate and continuous
> after the skbuff is sent, and can be stopped after polling a valid timestamp.
> But aux_work for detecting overflow and error cases is a periodic task that
> is always carried out. It looks a little bit clearer if they were separated, but
> I could also try to merge it into aux_work if I need to.

Give it a go, I think it will work better when machine is heavily
loaded and workqueues get blasted with other work items. But not
a hard requirement if it's difficult to get right.

