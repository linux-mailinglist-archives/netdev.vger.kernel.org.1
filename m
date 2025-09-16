Return-Path: <netdev+bounces-223299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0208B58AFA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA477B23E9
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE61C84B8;
	Tue, 16 Sep 2025 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="murGcq0I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07A27707;
	Tue, 16 Sep 2025 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985757; cv=none; b=Zjs6Mo0KFNAn1vUd16rKnObvJ1PsJU+bgPH7edxU6RHdGtZGNh9CcirC42mfO6kRGgd3ZN8Nr5cDVVtUGQMo/0BKoU+qhS+h6CdqZbWGK55YqIG3uzc+Xgqvs8T3cyKmtlzvmcoj36jyNDypAx/d0s/37NGMST7zDMgshWWWDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985757; c=relaxed/simple;
	bh=eyioPMYjM7Js5Z4579HK7Un1nYwROg8WTUONfABacPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fvx2xMxB1hrjKj+mb438anmxe3jdJVp6WFWx9oYFzF+PEDY6kLe4gcZ+PsBUYirSq6bctbVm9w0dZfN0CEznTKPxRrdb+0v26LMX7tg6VqUcDD0I9vpaQXdSYPvMGpys4Hrgt40Ngaq+jIJ/vdSW+WO+ojzDCsfiFLFglg0TXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=murGcq0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30565C4CEF5;
	Tue, 16 Sep 2025 01:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757985756;
	bh=eyioPMYjM7Js5Z4579HK7Un1nYwROg8WTUONfABacPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=murGcq0IJz6lOUXB6LXaK4UK6+WRiurYLP+H4Zn7uTHsGAfqBYftIRJ6oTfEsp7RB
	 JalhCkRbo9S1kcHMdyjjfNugtqy3RLFWypxGZy/GXi3EcnNTzE4ljrTCeBO5eay4Ty
	 FZ09GZqnaAXp8u3B/f5fqPi9d+omqDTynEirrmipZs7uABT2yiYuk9fIiyodgmTkdA
	 1M2kK7d2twEzwuFlULodKwOoDCR3uZjNSj4Os3x6vqcD0GF8hqwqI1tjfXi66Q0U+1
	 Kd9tOgKzotJ1IE0UfTVXwf/wQiGF5McnaVxm2TloYkosPVH2J2/khnT1yiWvP9rUc0
	 4CXXR05WEo6oQ==
Date: Mon, 15 Sep 2025 18:22:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
Subject: Re: [PATCH net] cnic: Fix use-after-free bugs in cnic_delete_task
Message-ID: <20250915182235.77a556c4@kernel.org>
In-Reply-To: <20250914034335.35643-1-duoming@zju.edu.cn>
References: <20250914034335.35643-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Sep 2025 11:43:35 +0800 Duoming Zhou wrote:
> The original code uses cancel_delayed_work() in cnic_cm_stop_bnx2x_hw(),
> which does not guarantee that the delayed work item 'delete_task' has
> fully completed if it was already running. Additionally, the delayed work
> item is cyclic, flush_workqueue() in cnic_cm_stop_bnx2x_hw() could not
> prevent the new incoming ones. This leads to use-after-free scenarios
> where the cnic_dev is deallocated by cnic_free_dev(), while delete_task
> remains active and attempt to dereference cnic_dev in cnic_delete_task().

[snip]

> Replace cancel_delayed_work() with cancel_delayed_work_sync() to ensure
> that the delayed work item is properly canceled and any executing delayed
> work has finished before the cnic_dev is deallocated.

Have you tested this on real HW? Please always include information on
how you discovered the problem and whether you managed to test the fix.

> Fixes: fdf24086f475 ("cnic: Defer iscsi connection cleanup")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

>  	cnic_bnx2x_delete_wait(dev, 0);
>  
> -	cancel_delayed_work(&cp->delete_task);
> +	cancel_delayed_work_sync(&cp->delete_task);
>  	flush_workqueue(cnic_wq);

AFAICT your patch is a nop, doubt this if fixing anything

>  	if (atomic_read(&cp->iscsi_conn) != 0)
-- 
pw-bot: cr
pv-bot: s

