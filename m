Return-Path: <netdev+bounces-49517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A33E17F2446
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA822821E8
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CE14F9F;
	Tue, 21 Nov 2023 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2X54+UR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DB1427E
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E3BC433CA;
	Tue, 21 Nov 2023 02:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700535024;
	bh=MDnJEopnYs7BhygIYmjoyl9gRgjQ5J/vqeFrJg0Z/vg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X2X54+URDGbhe9twOw4zaYTH53NFxxd8zAgV0yAVhkykrSaxsuJ92Uxp4aFKojtHs
	 1AYsrffcW2CGAY5vvJBvzoVXyIqdqOjVtoxnYTJeU/KyDIXZTd8kalhiSLHIzE7x0P
	 WyNUx1sSHTftJD+Tyu5KU5MAUbqrUUeCmnol0MLvKzkD1ivC9qMTxLlLB03nsOoef+
	 IdYkW8HpJgpr1BuZQOiZLDSk1HY0Iumz1OPe9fiaeNk06W26uZD1Uw1V0NUGiSZNLy
	 0zdZB1DgDLNhZriJELiRRwidF6mZ6DgBJ0XHmnvDZ9fIjzC3+Wk0rqr3+Uz7/Y3Dfo
	 owT+yd07fRWVg==
Date: Mon, 20 Nov 2023 18:50:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <20231120185022.78f10188@kernel.org>
In-Reply-To: <20231120084657.458076-6-jiri@resnulli.us>
References: <20231120084657.458076-1-jiri@resnulli.us>
	<20231120084657.458076-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 09:46:53 +0100 Jiri Pirko wrote:
> If any generic netlink family would like to allocate data store the
> pointer to sk_user_data, there is no way to do cleanup in the family
> code.

How is this supposed to work?

genetlink sockets are not bound to a family. User can use a single
socket to subscribe to notifications from all families and presumably
each one of the would interpret sk->sk_user_data as their own state?

You need to store the state locally in the family, keyed
on pid, and free it using the NETLINK_URELEASE notifier...

