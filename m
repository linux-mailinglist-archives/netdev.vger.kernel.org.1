Return-Path: <netdev+bounces-37650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F667B6761
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9E5351C20897
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA42111C;
	Tue,  3 Oct 2023 11:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0D1A286
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0E2C433C9;
	Tue,  3 Oct 2023 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696331586;
	bh=CoomkraAX2naxLdTJimxBFRMspUWykUSXyPCNJZ1BW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGhsXxpp6iTY5muDKClN5DvXwbzLFsDICH666+I5DWaSc2LPwmDlJ56VTN8J+R0Pd
	 CMLRxJRZkx8K2EMHipevd3J+UnMXaPcXVqBALh5OqSW844JvhHL9LQzgxhXadc+hQX
	 bcjDQ80VjWbsWqzpJ3ZsaPW6v8nWvoLZE71+HoIm91FnbIlj4a0dAdRZjB+YblVHaN
	 hbxkOJbik7QGdXRZd0ZjTKydpC8cvN3J/k6CuIY6PRiaYXNK9KILYRtD+DxDAFs91X
	 AUXDv6Og33U9AMLDlg3tdQGurcGauZFHRJ8vhYHQDoaiZ+asTG4NpUHFIJuPEqwdsx
	 GE7bHM1JfUEaw==
Date: Tue, 3 Oct 2023 13:13:02 +0200
From: Simon Horman <horms@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xufeng Zhang <xufeng.zhang@windriver.com>
Subject: Re: [PATCH net] sctp: update hb timer immediately after users change
 hb_interval
Message-ID: <ZRv3PgGCa5v0woGh@kernel.org>
References: <75465785f8ee5df2fb3acdca9b8fafdc18984098.1696172660.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75465785f8ee5df2fb3acdca9b8fafdc18984098.1696172660.git.lucien.xin@gmail.com>

On Sun, Oct 01, 2023 at 11:04:20AM -0400, Xin Long wrote:
> Currently, when hb_interval is changed by users, it won't take effect
> until the next expiry of hb timer. As the default value is 30s, users
> have to wait up to 30s to wait its hb_interval update to work.
> 
> This becomes pretty bad in containers where a much smaller value is
> usually set on hb_interval. This patch improves it by resetting the
> hb timer immediately once the value of hb_interval is updated by users.
> 
> Note that we don't address the already existing 'problem' when sending
> a heartbeat 'on demand' if one hb has just been sent(from the timer)
> mentioned in:
> 
>   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg590224.html

Hi Xin Long,

I wonder if this warrants a fixes tag, and if so, perhaps:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

