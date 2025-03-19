Return-Path: <netdev+bounces-176236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941DDA696D1
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C603169AD3
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4546A1E231F;
	Wed, 19 Mar 2025 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="sFwegVL/";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="oIzHYSI9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DA38F6D
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.6.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406458; cv=none; b=WBJ1l+8AsCedC31X38ssZ1CsKrOdRveTN2uev4D4iOqHAFn8EK68Bu0QgJ4oMH9RiCDZnee76B6xbAKBCLbsD5gdzEAamEBlFOMk/ZPuldSfjQISckERAmL5bAAEk8/+1bdcgBsz8cDMJw+ZLdQNsTsfRkEN8lnzb6sFU2LNo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406458; c=relaxed/simple;
	bh=5qp0x10PRJPjQbLZwN2HVzxZ5BW2TvwuRx2HFKKzqqE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Aq3XXCY2qQq+hBOBhGCPIIzXyf6n2JKxm3O7o9QXU4ikQWzwYAHSU8QdclKJrJXIINVr+PijRNVtD4Y5zIqCulQ/P+E3XAOp5vwS3tPMQPDvxD1P9X4ChUNOGkGXHajNg4wuaOa9v08AolrSGrA7Bc5gMbqSG16m0xmMfZb7sA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=sFwegVL/; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=oIzHYSI9; arc=none smtp.client-ip=160.80.6.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 52JGKVoI000622;
	Wed, 19 Mar 2025 17:20:36 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 074C91209AE;
	Wed, 19 Mar 2025 18:39:24 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1742405964; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLLRfAvp4L112vhRnGovRB2R9ng0gAiVpkTXLPMDc5c=;
	b=sFwegVL/5vaAlzHceWXTaaSgY0DVeY+b3qsB27+9NjRrcw+UwSv3EfDIEJ2uk81o1nB8VW
	bueQctNy8zl94IDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1742405964; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLLRfAvp4L112vhRnGovRB2R9ng0gAiVpkTXLPMDc5c=;
	b=oIzHYSI9wFOXYT77R7JXqIaBP1f3ZAztpFsZN00Gtg1jwLHgxBmLFtrver2qMuMatQaZUj
	G8JzpoTfQYw1etwkkmgDn/EYmJWT3ZI5eTc2fCcSwQOPui+ljdtb4REMXkpxAAj1mJqkQ/
	U/Y0wG0z9vA/R8jd2Gh8tkGzaF/QMmVQqeAhbc/jkheLfJT7QqJcCsSFT49CeSaToOs+Ec
	vHFOhDiqsZkx/i6rKY2vSjtvS2AgYQk9Ou5mByEB0XL+Dq4aMx7hrrmKcPLFg4ujZ29rhF
	kT1X9NJjiEmiGCwZ+2fpEIwtKycQPV9Ya81nSp9LOk24PlUJmlbVJXVpcq42/g==
Date: Wed, 19 Mar 2025 18:39:23 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: David Ahern <dsahern@kernel.org>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] MAINTAINERS: Add Andrea Mayer as a
 maintainer of SRv6
Message-Id: <20250319183923.309c3872c88b57137f0b4b63@uniroma2.it>
In-Reply-To: <20250312092212.46299-1-dsahern@kernel.org>
References: <20250312092212.46299-1-dsahern@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Wed, 12 Mar 2025 10:22:12 +0100
David Ahern <dsahern@kernel.org> wrote:

> Andrea has made significant contributions to SRv6 support in Linux.
> Acknowledge the work and on-going interest in Srv6 support with a
> maintainers entry for these files so hopefully he is included
> on patches going forward.
> 
> v2
> - add non-uapi header files
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffbcd072fb14..e512dab77f1f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16649,6 +16649,17 @@ F:	net/mptcp/
>  F:	tools/testing/selftests/bpf/*/*mptcp*.[ch]
>  F:	tools/testing/selftests/net/mptcp/
>  
> +NETWORKING [SRv6]
> +M:	Andrea Mayer <andrea.mayer@uniroma2.it>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
> +F:	include/linux/seg6*
> +F:	include/net/seg6*
> +F:	include/uapi/linux/seg6*
> +F:	net/ipv6/seg6*
> +F:	tools/testing/selftests/net/srv6*
> +
>  NETWORKING [TCP]
>  M:	Eric Dumazet <edumazet@google.com>
>  M:	Neal Cardwell <ncardwell@google.com>
> -- 
> 2.39.5 (Apple Git-154)
> 

Acked-by: Andrea Mayer <andrea.mayer@uniroma2.it>

