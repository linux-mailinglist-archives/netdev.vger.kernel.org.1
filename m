Return-Path: <netdev+bounces-139940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6859B4BD9
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D5E284E4E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A6206E93;
	Tue, 29 Oct 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHwHMPit"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED2206E8B;
	Tue, 29 Oct 2024 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211279; cv=none; b=tFU9ik5XK43jU27WZLKeVee6GsWIIO6CiknS8+9zxyo4Wtjyxjd0Zc1omebWa2UDNs2Ed8C1p2LzzVP82wlbXSNS2S2wPFnCCU4aTnqIVn5fqx89lz6MZk7+yjyB9QRae8z/pUVFIcHkEd3MeEEeulle5Y2l0p4OJorGZSc0guE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211279; c=relaxed/simple;
	bh=C9rPKReirZqEE6tK4eWfd9om5uA5nAukJuBcx5n2FLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZFgz89JFnzrtd/YvnYu/FKoVgImqPtmSkuc+WWZpq3C4Gs54GgG4pu64tqoQKqDNUKReDm6Tp+beAkyXW35cXQevq1N+m/mydheup6KpetZtH/Wd9X45EUDvijI461a/YCTk51yTypmQvbEtt1i346CUlsexR6xhr3D1rZzIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHwHMPit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0253FC4CECD;
	Tue, 29 Oct 2024 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730211279;
	bh=C9rPKReirZqEE6tK4eWfd9om5uA5nAukJuBcx5n2FLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHwHMPit1hXLDMidzDlppOTPxn+FAPqf7cxdv3Tsx/Bv8ovLXgNFf/ga7MSHCzNP2
	 5gUBZ9Tkq9tTUgIyhgW70/TA1tMqendHQpTJB6E0FJ9Ue1G2QgtRL7d2GFJzckplwQ
	 qP6tZw8cmmEdgax4DRRWZGl6ix7EtMEd6A4OsWtdC9kR6BjO6JfGHzPWvO6/DHKYsh
	 pY5FDEkQGTAJ3c7EzO7KgqCgMThyPYOS7qbKsWYzQUvqquvUaVuWiSRgmOU16jcpbn
	 hOyJb99oBM8ZG6stA/6HO7Duqtu5naAkeOLzntZ6Hr8qtkm0dbRnBBiNNQre+ZI1xV
	 Fy67Sj1qi/iow==
Date: Tue, 29 Oct 2024 07:14:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
 cmllamas@google.com, surenb@google.com, arnd@arndb.de,
 masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
 kernel-team@android.com
Subject: Re: [PATCH net-next v6 1/1] binder: report txn errors via generic
 netlink
Message-ID: <20241029071437.2381adea@kernel.org>
In-Reply-To: <20241028101952.775731-2-dualli@chromium.org>
References: <20241028101952.775731-1-dualli@chromium.org>
	<20241028101952.775731-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 03:19:51 -0700 Li Li wrote:
> +			report.err = BR_ONEWAY_SPAM_SUSPECT;
> +			report.from_pid = proc->pid;
> +			report.from_tid = thread->pid;
> +			report.to_pid = target_proc ? target_proc->pid : 0;
> +			report.to_tid = target_thread ? target_thread->pid : 0;
> +			report.reply = reply;
> +			report.flags = tr->flags;
> +			report.code = tr->code;
> +			report.data_size = tr->data_size;
> +			binder_genl_send_report(context, &report, sizeof(report));

Could you break this struct apart into individual attributes?
Carrying binary structs in netlink has been done historically 
but we moved away from it. It undermines the ability to extend
the output and do automatic error checking.

BTW if you would like to keep using the uapi/linux/android directory
feel free to add this as the first patch of the series:
https://github.com/kuba-moo/linux/commit/73fde49060cd89714029ccee5d37dcc37b8291f6

