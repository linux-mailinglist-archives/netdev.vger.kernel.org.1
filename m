Return-Path: <netdev+bounces-120379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847F895912F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F23282DBC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AB51C8242;
	Tue, 20 Aug 2024 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pASM3Ig5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A314AD2B;
	Tue, 20 Aug 2024 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196447; cv=none; b=CDcRDStfdYlnNBQMDQShRfH3rxeDv3ZpYY4ofM7SU9kaasGe3n0AuXgbwghMLPFOnSr7BAv6Fdne8Rd4RBc5aN6OzvGUEpcI9NDFvP0rkoov4S4FGa3gIX0WRx++WIS5VGuK+gbOvb+pHQD3+bJkOznJ+TDdYRkUy7f7XIX6b4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196447; c=relaxed/simple;
	bh=x0v4ERGEYlAyUWLHx1A9b9X1koPq3l212e3kJhhs20w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7VsUCFfj4mKcS0Si60DfbY+Txe8PS9n4UlUMWQSjG7Jw+cAYHuuAHVBG3BHOS4dPimXiRfg4C3m7GoiFglaj8w4A/QaHnMIHEw/XRS2dsjeuZTeOF/1Jz70+Mh0o3PZAIp3ceWdIXAWUreWIB/irNSzwg+34n79eeD3cBuxzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pASM3Ig5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDCDC4AF0B;
	Tue, 20 Aug 2024 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724196446;
	bh=x0v4ERGEYlAyUWLHx1A9b9X1koPq3l212e3kJhhs20w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pASM3Ig5F4XLlPRKZlk1psXzeS7UkVIRaitnUYfa0sSsRHHX/z3+xCrj4RNAOW9N+
	 BHbvWvCZA1Mv5W333pLWLYX7XAu4mDnirE5pYzv/p1JcvkDcQigQUeJfVsQE3Pc7Ff
	 C+ofyJUy8mv7iq3zEMdDTDCdLH1rfWSW8Cb5HJdBwRmoo+Xn57ZZQohqS+GtHcblPE
	 /5R8ySZn5KGwxBQZvaTG4+uy7b8f99bb2TmQkCKpXGZ4ztY0Ka+j5a/3zJV2ru6E8c
	 VQj4CTgZ0Y71S652TWP7gQBOJMDoS+40I3rKbymDEJpLFUSizQBaOG66TAdeF4xyHh
	 NAMGNy279KsKA==
Date: Tue, 20 Aug 2024 16:27:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Aijay Adams
 <aijay@meta.com>
Subject: Re: [PATCH net-next v2 3/3] netconsole: Populate dynamic entry even
 if netpoll fails
Message-ID: <20240820162725.6b9064f8@kernel.org>
In-Reply-To: <20240819103616.2260006-4-leitao@debian.org>
References: <20240819103616.2260006-1-leitao@debian.org>
	<20240819103616.2260006-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 03:36:13 -0700 Breno Leitao wrote:
> -	if (err)
> -		goto fail;
> +	if (!err) {
> +		nt->enabled = true;
> +	} else {
> +		pr_err("Not enabling netconsole. Netpoll setup failed\n");
> +		if (!IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
> +			/* only fail if dynamic reconfiguration is set,
> +			 * otherwise, keep the target in the list, but disabled.
> +			 */
> +			goto fail;
> +	}

This will be better written as:

	if (err) {
		/* handle err */
	}

	nt->enabled = true;

As for the message would it be more helpful to indicate target will be
disabled? Move the print after the check for dynamic and say "Netpoll
setup failed, netconsole target will be disabled" ?

