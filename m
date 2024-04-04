Return-Path: <netdev+bounces-84672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23979897D80
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 03:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B481F263AD
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 01:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB3217BBA;
	Thu,  4 Apr 2024 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGS7RhhX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80214F62;
	Thu,  4 Apr 2024 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712195435; cv=none; b=LEKIPvdylR9n3jl4tTjqR25Mc9ywaPEcNiMWOieRNGSN3o7Rp1BIcXFa5A0NiK/rcEMq4X016HP4JWhr7PjWrVCRVKFcL/rOLXhzEDBCtF2l91LTG+ZbuCEsIgSPexkctB/R5jABB4DlYGmhd4Lfu0loJYHCRrAJLmZd03o4HMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712195435; c=relaxed/simple;
	bh=ZOLpFyWMUibdLrrIJRH3L/KcxtL06Sr4BA7j+sJrjxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2Fe8pqy1353ec+bMFnMJP8HE74bh9FQLmJkxNg/S6XXAfZZjV+gacV3hvPtvXoAMOkvyD81n5uHwUUWH9ADkaESK9qiCaQHEZnfKWOElIMq/PFVY9AlAtzEC40MuPeQ8E+zvTcOUZFIdyAmQ/XxWmvFh3Qu2ziyWvN9vXOd0WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGS7RhhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FE1C433C7;
	Thu,  4 Apr 2024 01:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712195434;
	bh=ZOLpFyWMUibdLrrIJRH3L/KcxtL06Sr4BA7j+sJrjxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EGS7RhhXZrSA7nDxaqZDAq3VcXI/GTcHr8IXYNNSbzhTETkqDFEk0DbHXfZFefes5
	 F8TG//XiNj7B2KfGWiHQvy+b1+Wmi53Gi9NUt9xvWo7ygoGVumsRuj4MxXRoHgeI3b
	 kIPUUEmYchsG6hrmuvIp62wJ9zr/MPORFpFc8FxHW1Amj8u200BfhJdOAY7dtIdQ/S
	 E2jAKi8+eGQERhTNe17B0lnVLWw2J+Z+j6VKr0xXzfbkxnteDw1mxbC7Oi7rxFFvYl
	 HwFVDoy9bUx0Sty1cQiJA+fHFks/mdF6N3zPc7wOCAVU0vM9VoUzFDShB9MId6s6Nx
	 aMjWi5AetUJeQ==
Date: Wed, 3 Apr 2024 18:50:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, rostedt@goodmis.org, pabeni@redhat.com,
 davem@davemloft.net, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 0/6]  Implement reset reason mechanism to
 detect
Message-ID: <20240403185033.47ebc6a9@kernel.org>
In-Reply-To: <20240403073144.35036-1-kerneljasonxing@gmail.com>
References: <20240403073144.35036-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 15:31:38 +0800 Jason Xing wrote:
> It's based on top of https://patchwork.kernel.org/project/netdevbpf/list/?series=840182

Please post as RFC if there's a dependency.
We don't maintain patch queues for people.
-- 
pw-bot: cr

