Return-Path: <netdev+bounces-208294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EDCB0AD22
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 02:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB345A4DAE
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62C872636;
	Sat, 19 Jul 2025 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVKn+vmg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8223CE
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752886729; cv=none; b=fB6QhHRaRqpY8HZS7eMV68uOGhQfallsXzvvPo6+7Zbfp/GD2DImxYCIZ7t6h0uSdQfRsOjvZKqfp7/0e2BjRArgKrz81FkJhgWUm+HsN8isajy0ATa8TUmoVPT8J6VLkiKfyXIntAVPvzj9H6OqF9Ah97lGV7d18msePDrulaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752886729; c=relaxed/simple;
	bh=ntw4F2jkkQKqfmGIv8jLLyRo/gPrMRB23tbFe+dEn0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFKlGVQp2FYA0XmL5oLqTsb8V8MDnulTdq+pW3F64RRORFzOHW9reTJCZuPwNxdROqK/5Ux6wdoIGEYeZErUqDFviMqhssuXcXpuSlij0Dq6rdn6bPM7p5zfL0kbsjjvof+r7M1m5dmu/U5I+E01LdK7wzaj026HOwGUVegyUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVKn+vmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A9BC4CEEB;
	Sat, 19 Jul 2025 00:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752886729;
	bh=ntw4F2jkkQKqfmGIv8jLLyRo/gPrMRB23tbFe+dEn0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eVKn+vmgC55QLJzE2ozK5suYcr/K3Od30KeE0h6pdnWrqP0/2TRvDFWJgqybA5Czz
	 QNIUFqJDXUmR15RlwLTVGBigi/5xW/TSpc5Th0v2w70CzytFybF+47sMeZT9XfLNQk
	 xDgRKl3PmlKOuKHGuDZGzrNi+Zuwpuk6mttaHz85YPiSHrgqUnEtO9P6AiWteiwkm0
	 4+S+3qWsgfEeezp/TFKnl7jRu6PVtkPBId6t2qEqWiFzNBsQzfdzcfMn47H+RDT3gI
	 ZxGbXP6UDCmVw5YaQKf38mzgVy/XLpm8NLvGLStXsR7NP6kb/W62pnpZz6uBFxCf5B
	 c70vafs/qJ+/w==
Date: Fri, 18 Jul 2025 17:58:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krishna Kumar <krikku@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 tom@herbertland.com, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 atenart@kernel.org, jdamato@fastly.com, krishna.ku@flipkart.com
Subject: Re: [PATCH v3 net-next 1/2] net: Prevent RPS table overwrite for
 active flows
Message-ID: <20250718175847.4f4a834c@kernel.org>
In-Reply-To: <20250717075659.2725245-2-krikku@gmail.com>
References: <20250715112431.2178100-1-krikku@gmail.com>
	<20250717075659.2725245-1-krikku@gmail.com>
	<20250717075659.2725245-2-krikku@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 13:26:57 +0530 Krishna Kumar wrote:
> + * Return values:
> + *	True:  Flow has recent activity.
> + *	False: Flow does not have recent activity.

This is not recognized as valid kdoc formatting:

Warning: net/core/dev.c:4856 No description found for return value of 'rps_flow_is_active'

I don't think we need to enumerate this trivial set of possibilities,
how about:

 * Return: true if flow was recently active.
-- 
pw-bot: cr

