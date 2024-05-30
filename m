Return-Path: <netdev+bounces-99238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89728D42F8
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB31283F13
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54629134DE;
	Thu, 30 May 2024 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4Y9AxLy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1033FD;
	Thu, 30 May 2024 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717032851; cv=none; b=MOB9qYUXf6cAl4ynDBNtB2X612QCHE5cIyI8dPmpH2IUp75iiM4xiLAeZgcb89QXksfk+BYA9Xpm22h4tYSL98lxApHSKYF5B9a7EzleAU6kzYcyEphLd0eoSRDHoLY2OnXDo+xIoTLGFU6pWBdOgQiwGiosprZ18S7CgTY3Uhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717032851; c=relaxed/simple;
	bh=KyrREIinnHGspd2GO6w7tcxvikzFHN7sskNsxhF0axQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqOsdAtEiewoLUHSOrqYAskfYjNoAlrXXd1iSeLgx8lafMCjCLFw5u2lskYOFvqQ3ySCJ7kvYo+ARZiy7dnnE/Sp/cPPvzYR3yd2K7Gl3/mwJIp5I09Jez1zjPvCUSGP1BymYTdFLl4vDZpxFt6rQjI6EHtjj+7yqgJfOsEsRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4Y9AxLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAB7C113CC;
	Thu, 30 May 2024 01:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717032850;
	bh=KyrREIinnHGspd2GO6w7tcxvikzFHN7sskNsxhF0axQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4Y9AxLytN8XEXvwFHoPdyYKFMJsQmhT7n9yvOt0VPfv54o+52u5v+dlViEl5jgkc
	 69eVnHAIj/0G0eJHDStXhNrRcfpDVqQ9UJCRARg/IPxwl4sPtYnYBg9U/ou/cYQml/
	 bS7YOX5X8rXOpwMuquxOzrEm2JY2kvlOkxGUrdQsfPQA5Fi50Q0yLqtEUoHf5entl3
	 m8JL6gX0Z8IV4zOGAboXj1mwVwhQZsz0tlZxu2bQPcrX7AM/9qwAUV6sjH/MjMag3c
	 oCZYaAwndTMgFx18KcwvRaFcZ65kI7IeWJfRpe5zYZ1dZ4CFmYzeUv8Qr0enk9/GzP
	 l/rkRhSikAYOg==
Date: Wed, 29 May 2024 18:34:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Mina
 Almasry <almasrymina@google.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next 01/12] libeth: add cacheline / struct alignment
 helpers
Message-ID: <20240529183409.29a914c2@kernel.org>
In-Reply-To: <20240528134846.148890-2-aleksander.lobakin@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
	<20240528134846.148890-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 15:48:35 +0200 Alexander Lobakin wrote:
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 95a59ac78f82..d0cf9a2d82de 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1155,6 +1155,7 @@ sub dump_struct($$) {
>          $members =~ s/\bstruct_group_attr\s*\(([^,]*,){2}/STRUCT_GROUP(/gos;
>          $members =~ s/\bstruct_group_tagged\s*\(([^,]*),([^,]*),/struct $1 $2; STRUCT_GROUP(/gos;
>          $members =~ s/\b__struct_group\s*\(([^,]*,){3}/STRUCT_GROUP(/gos;
> +        $members =~ s/\blibeth_cacheline_group\s*\(([^,]*,)/struct { } $1; STRUCT_GROUP(/gos;
>          $members =~ s/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/$2/gos;
>  
>          my $args = qr{([^,)]+)};

Having per-driver grouping defines is a no-go.
Do you need the defines in the first place?
Are you sure the assert you're adding are not going to explode
on some weird arch? Honestly, patch 5 feels like a little too
much for a driver..

