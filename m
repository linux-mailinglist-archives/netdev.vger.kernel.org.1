Return-Path: <netdev+bounces-232731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C56C085E7
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0541C279AA
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 00:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6778011CA0;
	Sat, 25 Oct 2025 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGrJfMgN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43516610D
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761350629; cv=none; b=JKuPhi3S8vylSDkDZBG8pKCGdGZEyv+P/CXNXa0SftxTKsJeUc/IlRHgCNgWvcsUyzQs+uMjCsvWvd2o59h9hdN2dWkR23rU+hlOKg7ZrJ95ayjzJ/nvLA7n9RyyZKyjd5+GsZ2YMsyAutihHblNz80PDKvgDdVfxysZIprw+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761350629; c=relaxed/simple;
	bh=nUZRzMLfwpJFiXRu5036P1HzRIEZXvvEM35CHjxlW6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fc7kp0ykglOIC+r2rxC7+9ykV2V4bqjkHSiUVW8z79tWgB+zBQjlxMlDkBjC+wPqecSwIgS32gLZ7cNW3Nml9ehGsa+3eX1u1ZwGh9o2mSCJAcqFR0go4UEAkf70+TtOkmgdMoM1VV0WbW351g52xtFvu9Zcnvmh67gaps/RtnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGrJfMgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEC3C4CEF1;
	Sat, 25 Oct 2025 00:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761350628;
	bh=nUZRzMLfwpJFiXRu5036P1HzRIEZXvvEM35CHjxlW6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JGrJfMgNwkSaFlmGomzIg5fpHn1eRdZr0cuscW2yZxFURZUYDy1FQXnnt92DdQjZf
	 6gfZDBeCtsd8leTMHQWU54UEvx+FPFBKKHVwt4669lP4pK3TMDTGHvw30Bsj23uxKM
	 3Jh6W4KcQKkuKUck0e/cNTjUtpvFj9bh+2qgVzl3azyYSgg9i8Fq6fqVz2NVzuL1yh
	 8D3NyXHyy0JS4an+zXio/MPTFXoPurt3doplO1kIOSd9HR7CwgDBR/lbm59mR9cFfG
	 gZ75Qw8WsXwVuREDbtjVtLWU2VSlSJI+TKsBr6alK+MbUF5mGmlHHmMP9ueoikM/bF
	 L4ie0MBIwWk6A==
Date: Fri, 24 Oct 2025 17:03:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4?=
 =?UTF-8?B?bm5lc2Vu?= <ast@fiberby.net>, netdev@vger.kernel.org,
 ivecera@redhat.com, mschmidt@redhat.com, Zahari Doychev
 <zahari.doychev@linux.com>
Subject: Re: [PATCH net] tools: ynl: fix string attribute length to include
 null terminator
Message-ID: <20251024170347.2bd06bf0@kernel.org>
In-Reply-To: <20251024132438.351290-1-poros@redhat.com>
References: <20251024132438.351290-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 15:24:38 +0200 Petr Oros wrote:
> The ynl_attr_put_str() function was not including the null terminator
> in the attribute length calculation. This caused kernel to reject
> CTRL_CMD_GETFAMILY requests with EINVAL:
> "Attribute failed policy validation".
> 
> For a 4-character family name like "dpll":
> - Sent: nla_len=8 (4 byte header + 4 byte string without null)
> - Expected: nla_len=9 (4 byte header + 5 byte string with null)
> 
> The bug was introduced in commit 15d2540e0d62 ("tools: ynl: check for
> overflow of constructed messages") when refactoring from stpcpy() to
> strlen(). The original code correctly included the null terminator:
> 
>   end = stpcpy(ynl_attr_data(attr), str);
>   attr->nla_len = NLA_HDRLEN + NLA_ALIGN(end -
>                                 (char *)ynl_attr_data(attr));
> 
> Since stpcpy() returns a pointer past the null terminator, the length
> included it. The refactored version using strlen() omitted the +1.
> 
> The fix also removes NLA_ALIGN() from nla_len calculation, since
> nla_len should contain actual attribute length, not aligned length.
> Alignment is only for calculating next attribute position. This makes
> the code consistent with ynl_attr_put().
> 
> CTRL_ATTR_FAMILY_NAME uses NLA_NUL_STRING policy which requires
> null terminator. Kernel validates with memchr() and rejects if not
> found.
> 
> Fixes: 15d2540e0d62 ("tools: ynl: check for overflow of constructed messages")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  tools/net/ynl/lib/ynl-priv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
> index 29481989ea7662..ced7dce44efb43 100644
> --- a/tools/net/ynl/lib/ynl-priv.h
> +++ b/tools/net/ynl/lib/ynl-priv.h
> @@ -313,7 +313,7 @@ ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
>  	struct nlattr *attr;
>  	size_t len;
>  
> -	len = strlen(str);
> +	len = strlen(str) + 1;
>  	if (__ynl_attr_put_overflow(nlh, len))
>  		return;
>  
> @@ -321,7 +321,7 @@ ynl_attr_put_str(struct nlmsghdr *nlh, unsigned int attr_type, const char *str)
>  	attr->nla_type = attr_type;
>  
>  	strcpy((char *)ynl_attr_data(attr), str);
> -	attr->nla_len = NLA_HDRLEN + NLA_ALIGN(len);
> +	attr->nla_len = NLA_HDRLEN + len;
>  
>  	nlh->nlmsg_len += NLMSG_ALIGN(attr->nla_len);
>  }

looks familiar...

Link: https://lore.kernel.org/20251018151737.365485-3-zahari.doychev@linux.com

