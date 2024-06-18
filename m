Return-Path: <netdev+bounces-104586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4B90D7DE
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4290B25A1D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15523208DA;
	Tue, 18 Jun 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8vNBP5h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F51F951
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723834; cv=none; b=KVpRNQV4eMbBpms6PdBQ40zVDouY1zoe+SDCwijiqoB4t1VtB7RjVXV0+9b9z5W6RKX0ElP7SaRXRhOxizSUrTfkfFlv+Cte7U4ndouSfd8bkZw+ThusgN9B1HkAXUtMJNOZSO2A4ixzj8TtayMH96ytLtTTzPlDN8yvlgCrU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723834; c=relaxed/simple;
	bh=3R+CgZlh7igYHvuWxfLaqR7fVi3TL8IbmJBlGi5MrW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8zxwz3nOOSsgzshNWIhaXc28zlk1AgvjLCIK8Gi37kT33XAft5FIz1HcL1cFA9LGlXR691kTt0QRYlIcZutz0ZScnbILiRuUZ0cHwHb8pLtgHezk61CjY6ZCMa5cLoAbq0n1oD7XN4tLQhaiRJE0u4ig/gLxXIxLCByKlS0tyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8vNBP5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A10C4AF1D;
	Tue, 18 Jun 2024 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718723833;
	bh=3R+CgZlh7igYHvuWxfLaqR7fVi3TL8IbmJBlGi5MrW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M8vNBP5hkULQ8yMxy6WBfDO3yq/30LI8afPAI9zOXCouXyphuOmEb6/Aw1qG4T7yM
	 nuBn6sWv772/5gNLbn9Cg9rv1adWXPPX40WilRxvNwpe/vMP68ka7jpsxSJtX32RKI
	 Tt+snMt/Fy8xkN5eUGLrd3vKMd6KrP20P7vZ6qcnoNjXEjxhbo9Fy8NPYGbN67WfFj
	 oOCNh09NtelbaDWs1Fwn1FUg9jQQA4zuZTh5jWo+iIU6uV9agjx0eVEqqIAkMkVool
	 IrfsguGaxudfRjVtUaHEqI1RaTLxq/GeqpLFTvID+RgyUoRrxhAeYRyu7GSlzycOpQ
	 GVZ3IwkRLbD7g==
Date: Tue, 18 Jun 2024 08:17:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: pablo@netfilter.org
Cc: wujianguo106@163.com, netdev@vger.kernel.org, edumazet@google.com,
 contact@proelbtn.com, dsahern@kernel.org, pabeni@redhat.com, Jianguo Wu
 <wujianguo@chinatelecom.cn>
Subject: Re: [PATCH net v3 0/4] fix NULL dereference trigger by SRv6 with
 netfilter
Message-ID: <20240618081711.45be1471@kernel.org>
In-Reply-To: <20240613094249.32658-1-wujianguo106@163.com>
References: <20240613094249.32658-1-wujianguo106@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 17:42:45 +0800 wujianguo106@163.com wrote:
> v3:
>  - move the sysctl nf_hooks_lwtunnel into the netfilter core.
>  - add CONFIG_IP_NF_MATCH_RPFILTER/CONFIG_IP6_NF_MATCH_RPFILTER
>    into selftest net/config.
>  - set selftrest scripts file mode to 755.
> 
> v2:
>  - fix commit log.
>  - add two selftests.
> 
> Jianguo Wu (4):
>   seg6: fix parameter passing when calling NF_HOOK() in End.DX4 and
>     End.DX6 behaviors
>   netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core
>   selftests: add selftest for the SRv6 End.DX4 behavior with netfilter
>   selftests: add selftest for the SRv6 End.DX6 behavior with netfilter

Hi Pablo!

FWIW this gained a "Not Applicable" designation in our patchwork,
I presume from DaveM. So we're expecting you to take it via netfilter.

