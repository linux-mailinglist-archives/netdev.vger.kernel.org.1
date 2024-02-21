Return-Path: <netdev+bounces-73518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A9E85CDE1
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8146D1F2598C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D112B70;
	Wed, 21 Feb 2024 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAmlY7Sl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0F111BB
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482019; cv=none; b=LMEExtVWxKwqxT8NkfGojJU6zuOIj1KSYWchkNHgkO5gLbS7rVQi9DkI9vfiVbwvXTNwAFY9xUJS8Is8+B2vNr7bQ7GkPIZiKufWvpi5aPKf5fJP/93Gy7JmW9QqXXuJQPqLkUi+U5vobS5Mkz/aHwkwFVgDEZoxK8iVI7Chdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482019; c=relaxed/simple;
	bh=Y2kScnSdb7YCyLyZwxjBuk9rCe5wtUazdL7wADRvoFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NewTGxrINLe6WXZb94koyzsJQC5eTf0akgAnwHDzjKPP6hzGyizalM/oiU0nN94SwpNze2mSzPMhv0BMPHYgMqdGW0vnE6xRQFXJ9XKeq8I13CZvuNitmTiEGoaJA62FvgdJGwuKuPHoOCJGNhhOshNOp00kRXEG+rvd5Zv9hM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAmlY7Sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BD8C43399;
	Wed, 21 Feb 2024 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708482019;
	bh=Y2kScnSdb7YCyLyZwxjBuk9rCe5wtUazdL7wADRvoFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SAmlY7SlS8OxTj5sc+Xhre2c0qeGeKeJ0E8MlxxF4qFZwSpe6KUxBaBaVwAC6yboK
	 QeJARpGerdAHAQDkUdk8j0862/jd0eUqbhl+i2AZbhT+PkYJLMAzK7G2iqiboaGKWA
	 cJrApIXw4NWTz/lVOyU0vezsprzrVTNaYF8wBo2aE+gqN0LMeFOLcO1cZkVGKdpw7F
	 WyocgA0dTPpNsfBCArWhTzbY0ltun9XNw6qQcUOQe/zOXeJHwbyMDrBfi2wR0gSqeH
	 SaSBHnu9GIRC9nkpA6AkaCm/VlmhZOgO4dURCQvl5TCBztp50FsEYmZHeN7ZeYFIT2
	 Ss4vyplVoQ2cg==
Date: Tue, 20 Feb 2024 18:20:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v12 0/4] netdevsim: link and forward skbs
 between ports
Message-ID: <20240220182018.4577db1b@kernel.org>
In-Reply-To: <20240217050418.3125504-1-dw@davidwei.uk>
References: <20240217050418.3125504-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 21:04:14 -0800 David Wei wrote:
> This patchset adds the ability to link two netdevsim ports together and
> forward skbs between them, similar to veth. The goal is to use netdevsim
> for testing features e.g. zero copy Rx using io_uring.

I think this was posted before our conversation about waiting for 
the listener, so I'm assuming we'll wait for the lucky v13.
-- 
pw-bot: cr

