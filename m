Return-Path: <netdev+bounces-250008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A26D2252A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 04:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67E4E3004284
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 03:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CB127A92D;
	Thu, 15 Jan 2026 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjXzblx2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61119005E
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768448447; cv=none; b=bfB/4cOU/SAS0f/VoSXzQCWXrg9P5MSqzICJQTmB/ZxbiLr8e96tlNxmO3g5ZHG7hjb1CtPuU/r/Bne50mAE3qp5us3ezfzdtW0NIbYIanxrI2bjQJcJt1FXi7hxugo4cxyHAhPvb7o+3wMBLPCK743p1+NLnPfTFaL+M2MeJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768448447; c=relaxed/simple;
	bh=hDBGVTyt4F8UY7TLWnOaX0uq6tkYegGp+x5a8VYBpqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcUh5VNctgCwcmTU+/K2CsXxmw83GoXXBLhDTF+akE3Ob/0GFKXDH+7jUzlMTcux2ZkuFGlQDc4lfVvh/iJ7Ewa77Hfxocm1MrjYl/DbVVmEgTEcDEUIgcKAg6ULSMU0ftT99lGbNXleutiNlXvGMEAKBnY7ix/6XS85GTF/mLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjXzblx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A225C4CEF7;
	Thu, 15 Jan 2026 03:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768448446;
	bh=hDBGVTyt4F8UY7TLWnOaX0uq6tkYegGp+x5a8VYBpqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fjXzblx2fpekphJSXRFO3b18HOOp9wcWsPfaYI02f3faqGKWwvvfCwzsmvs+AhZxs
	 NOv1LnFsXZHhvMnZjCNpxrAFV5ItuiaAkGdbdAtbyszlraW82MvMJGKClv0l8sL2/v
	 5z08RTZQ3OpJZi9ybjLsHfwhX1xMyYA/azZvjw/wE9YGgGegk4Fdx4NTsvqNhP6AO2
	 s4VkzM6vZ9ZVRJXXOU/dtP8lkSj4AI5HmqJ+4wBhb3FPU8qUOb5yi0Gf0AC5+tma54
	 zhwwS2B6VP8fUI0kAF2YV20lsbJz31bWSaeLChRiJikmpl7qhOubOamn+gxDHdGHMK
	 imtofVjjzu5tA==
Date: Wed, 14 Jan 2026 19:40:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Tom Herbert
 <therbert@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 net 2/2] fou: Don't allow 0 for FOU_ATTR_IPPROTO.
Message-ID: <20260114194045.2916ef4e@kernel.org>
In-Reply-To: <CAAVpQUD9um80LD36osX4SuFk0BmkViHsPbKnFFXy=KtYoT_Z6g@mail.gmail.com>
References: <20260112200736.1884171-1-kuniyu@google.com>
	<20260112200736.1884171-3-kuniyu@google.com>
	<20260113191122.1d0f3ec4@kernel.org>
	<CAAVpQUD9um80LD36osX4SuFk0BmkViHsPbKnFFXy=KtYoT_Z6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 23:15:42 -0800 Kuniyuki Iwashima wrote:
> Btw I needed the change below to generate the diff above
> by "./tools/net/ynl/ynl-regen.sh -f".  Maybe depending on
> 
> 
> diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
> index 81b4ecd891006..fda5fe24cfd47 100755
> --- a/tools/net/ynl/ynl-regen.sh
> +++ b/tools/net/ynl/ynl-regen.sh
> @@ -29,9 +29,9 @@ for f in $files; do
>   continue
>      fi
> 
> -    echo -e "\tGEN ${params[2]}\t$f"
> -    $TOOL --cmp-out --mode ${params[2]} --${params[3]} \
> -   --spec $KDIR/${params[0]} $args -o $f
> +    echo -e "\tGEN ${params[5]}\t$f"
> +    $TOOL --cmp-out --mode ${params[4]} --${params[5]} \
> +   --spec $KDIR/${params[1]} $args -o $f
>  done
> 
>  popd >>/dev/null
> 
> 
> fwiw, $params were like
> 
> 3- Documentation/netlink/specs/fou.yaml
> 4: YNL-GEN kernel source
> --
> 3- Documentation/netlink/specs/fou.yaml
> 4: YNL-GEN kernel header

Hm, I guess you have grep.lineNumber enabled in your git config?
Could you see if tossing --no-line-number into the git grep
in this script fixes it for you and if yes send a patch?

