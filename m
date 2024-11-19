Return-Path: <netdev+bounces-146068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C29D1E62
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD56283D79
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCB033998;
	Tue, 19 Nov 2024 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StYTIh2b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5E27735
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984123; cv=none; b=JPZKdyGyLNdz2tdRBk7w3MxtIwR/KcckzaHxzjdGuKtaCCX9WXgm1VoSaBNcWRS7posfl7TFNkLb0Q7qJucCnGJtgmwX2+QAV5jE+WUoYGEBHHSvSsWodKeZEgV5kq2Khzzdmc6Xxc0kRGUQSTlpcykmCAJWQClkggRGySpJTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984123; c=relaxed/simple;
	bh=S4181DyckoR7ZcsWOjTDLNP/xwyTPRsZ0B0rjQDwiEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3oVcLoCkshRYf4y7wLfCtTJKcRXto1YMgg3CyAphxGmYSC6RqYrC27r1ErxZ4KDOw5Nqg15A89NenmMpr1DNKf6sDyhgd/HYohG6Xwdp6sBDuoZsN29qKvnb5HaYK77MWr6teegm8PcxitBqScCzgh3DNYpExNnGxUlYx+NAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StYTIh2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71B5C4CECC;
	Tue, 19 Nov 2024 02:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731984123;
	bh=S4181DyckoR7ZcsWOjTDLNP/xwyTPRsZ0B0rjQDwiEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=StYTIh2bVp8o4UHP06O8GvLf/9kvYnSjvz5IOLG4oRhe1qcQdkiDtc/cM9+sHVPk0
	 yfl+nRC7w9Js4kXNlqRvjHhlNkjnolNLQAprCMnQ5cpgG8ZtRPzB6NLp6JnJy9GLIn
	 HuuUCsJIMn226uVjnJRtH+gz/G+WkqSxuY0uCQDmYHFqLwRjHCUf5Nsu2tdkFKRtOC
	 oD9MwsuiIjtn/+faNIka3uj1vXr8MSpRPIYuqMTd3PU922kjGw9a+w0jlx1MnMIMXV
	 EanefSYKzfVuLsw47tA5SwZ82rDc2XNnMFK3trUtbQ2PfTWwNg4TLOEw9OGqDBBq8B
	 krzr1zrm48bSA==
Date: Mon, 18 Nov 2024 18:42:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Ido Schimmel <idosch@idosch.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH] rocker: fix link status detection in
 rocker_carrier_init()
Message-ID: <20241118184201.3d1e7a13@kernel.org>
In-Reply-To: <20241114151946.519047-1-dmantipov@yandex.ru>
References: <20241114151946.519047-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 18:19:46 +0300 Dmitry Antipov wrote:
> Since '1 << rocker_port->pport' may be undefined for port >= 32,
> cast the left operand to 'unsigned long long' like it's done in
> 'rocker_port_set_enable()' above. Compile tested only.

Jiri, random thought - any sense if anyone still uses rocker?
IIUC the goal was similar to netdevsim - SW testing / modeling
but we don't really have any upstream tests against it..

Unrelated to the patch, so dropping the author from CC.

