Return-Path: <netdev+bounces-75143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9628685AF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 02:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE8EB2117D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 01:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D446BA;
	Tue, 27 Feb 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR5v1WpU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B34431
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996954; cv=none; b=KJL7Nak6KZFzkvkF0lallmBex+GEPxgjEmVW5jDukMQnhNlMzkdJzKJX+i6ZVgwUIXQSegcG34zLS0tIsm4YqgDQ/Yo1elyVrxW/kss4XOQVlta2AXbtg0qWjCQyXNCQP0KqDq1Msu0To6FjLk+io2+jAzySWRO+L0LGyQ96F/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996954; c=relaxed/simple;
	bh=HKMh/RERsX5QSyVfjfxLJurweHBeLZzWNKIUzGflEEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjBbRpRu/MwkQUHqYbHulA/nbE6fxfG8Ta85IIOCG+y+PM8xsuK9akoPtcfBt7r3zwUvciA400jS++qE/DI5YSk8S64Wyis2Z1MmrMXqVFgA68/mfy/F0UaTkaEJTvbIhjC3bqW0swBrzYPyxtiGdJiI1RvaaRGWpVToDhzQzgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR5v1WpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32C5C433F1;
	Tue, 27 Feb 2024 01:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708996954;
	bh=HKMh/RERsX5QSyVfjfxLJurweHBeLZzWNKIUzGflEEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MR5v1WpU1KxFjkKVG6HGb5tlJKttShhPu3qsGW6CVsY1a3Z5FuoJp1iLyv+EGGBkG
	 AhFqARTqpjhZrW+ImG9TB6I5PPb9Y3EOjMFr2d0FGKNl4RB+O1CrD7oSoN1t+xGX7d
	 ks3mEGveqDUhshcDO1ng4JvDK6IXNf1O5nFednC/WqJDxjrKwhmz+RxBGNOIB7IYQd
	 7CUbeqyWO6/0eBETfdpAFYRG2M7f0T0AHbgd+3/6zA8b+n05ExIvi9kfZ+olWFxFi5
	 vPtrUU+6qCOjCkgpWvqNYvYnAA+KmVjJoTu0WLj+7XScFI1PO+1v7wVgBwb7OmQTCo
	 iqth/w4+lnthQ==
Date: Mon, 26 Feb 2024 17:22:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Wander Lairson Costa <wander@redhat.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH v2 net-next 3/3] net: Use backlog-NAPI to clean up the
 defer_list.
Message-ID: <20240226172233.161c6e7e@kernel.org>
In-Reply-To: <20240226115922.3ghr5wuD@linutronix.de>
References: <20240221172032.78737-1-bigeasy@linutronix.de>
	<20240221172032.78737-4-bigeasy@linutronix.de>
	<20240223180257.5d828020@kernel.org>
	<20240226115922.3ghr5wuD@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 12:59:22 +0100 Sebastian Andrzej Siewior wrote:
> They protect the list in input_pkt_queue and the NAPI state. It is just
> in the !RPS case it is always CPU-local and the lock is avoided (while
> interrupts are still disabled/ enabled).
> 
> What about
> 	input_queue_lock_irq_save()
> 	input_queue_lock_irq_disable()
> 	input_queue_lock_irq_restore()
> 	input_queue_lock_irq_enable()

SGTM. Maybe I'd risk calling it backlog_lock_* but not sure others
would agree.

