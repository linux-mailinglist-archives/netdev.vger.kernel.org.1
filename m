Return-Path: <netdev+bounces-181416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56F0A84DE2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CCD9A3618
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4432900B5;
	Thu, 10 Apr 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma8aQVEs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FAB2900A6;
	Thu, 10 Apr 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315564; cv=none; b=fs+lShmII0RSrc9rjR7IohGex5AKO1hqJ0LNhFdKve21pqzYCrENQLVSUEbd5Vnm5pwALeFMwScqvBltD7yYsPSvNm6IHtjDzllYVuEng1m8vUDHi8Vn4iNmswktWtP/JRBoCXPGu71MgS8C8RAr1R/+azjTuWNlWdgJyjSoBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315564; c=relaxed/simple;
	bh=BgK7fIJnk4AnRNaBbtmdJBytPMMCJgQxju8Id4E66OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSOarWgO0aIDpSibgunXXFjpXP3w9TSBJwVf2hNrBT+sIrdT/MZxGs/DJ4cYiH0eo+J/3WxdeOJHNPkgLmwGdVv0KsuBqS68v8AO1arvz2XTx6FEVdiEQCryw7nPX4DxhjAmA9gziyEV61YwwLFyNEm3zN/nQNbf4KLrzpWSLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma8aQVEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BFBC4CEE7;
	Thu, 10 Apr 2025 20:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744315564;
	bh=BgK7fIJnk4AnRNaBbtmdJBytPMMCJgQxju8Id4E66OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ma8aQVEs4IEn4dHXZRse95AfcBx/oA9NVW+FH2zIAGbj2OYjSSlOJtN5rA1fxpKo5
	 h/sXdR4lyTnew51sMEi1g7vxgsTq4PBIkNO88s7UCCe+Kve4+2AHJ1dSfg+EbFvWpW
	 iauGBircvRhoDK9si67OJDLSfGs7K3vhDKPZ0XS0wKPjqymLymy78qxBh9UtsTA90L
	 /2/K/5XuwQ3nj5jQ3etXoR6i5Ohm/AxID+aZ31srbrRyfR/IfJbsP6K/ZPgFhOIC8T
	 EiTgY7KdWUlFatImjzK0Uo6235y+VVzrXEm0Ajvk7mFb/4Lbhd9OzI2JKmaFteUNAb
	 qNA+GuoKKLdGQ==
Date: Thu, 10 Apr 2025 21:05:59 +0100
From: Simon Horman <horms@kernel.org>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, skhan@linuxfoundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] net: ipconfig: replace strncpy with strscpy_pad
Message-ID: <20250410200559.GW395307@horms.kernel.org>
References: <20250408185759.5088-1-pranav.tyagi03@gmail.com>
 <1168af15-14dd-4eef-b1d7-c04de4781ea7@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168af15-14dd-4eef-b1d7-c04de4781ea7@amd.com>

On Tue, Apr 08, 2025 at 02:44:42PM -0700, Nelson, Shannon wrote:
> On 4/8/2025 11:57 AM, Pranav Tyagi wrote:
> > 
> > Replace the deprecated strncpy() function with strscpy_pad() as the
> > destination buffer is NUL-terminated and requires
> > trailing NUL-padding
> > 
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> 
> There should be a Fixes tag here, and usually we put the 'net' tree
> indicator inside the tag, like this: [PATCH net]

FWIIW, this feels more line net-next material to me:
I'm not seeing a bug that is being fixed.

> 
> 
> > ---
> >   net/ipv4/ipconfig.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> > index c56b6fe6f0d7..7c238d19328f 100644
> > --- a/net/ipv4/ipconfig.c
> > +++ b/net/ipv4/ipconfig.c
> > @@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
> >                          *v = 0;
> >                          if (kstrtou8(client_id, 0, dhcp_client_identifier))
> >                                  pr_debug("DHCP: Invalid client identifier type\n");
> > -                       strncpy(dhcp_client_identifier + 1, v + 1, 251);
> > +                       strscpy_pad(dhcp_client_identifier + 1, v + 1, 251);
> 
> The strncpy() action, as well as the memcpy() into dhcp_client_identifier
> elsewhere, are not padding to the end, so I think this only needs to be
> null-terminated, not fully padded.  If full padding is needed, please let
> us know why.
> 
> sln
> 
> >                          *v = ',';
> >                  }
> >                  return 1;
> > --
> > 2.49.0
> > 
> > 
> 

