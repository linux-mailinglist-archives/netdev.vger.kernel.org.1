Return-Path: <netdev+bounces-128130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9279782CF
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF7728BDEA
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8493111187;
	Fri, 13 Sep 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKz59ovc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614628F47
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238568; cv=none; b=UcLE3K6zT6w/GjwCWQSJoyOO8gN/3JazvTEnybBRv9ZRbk6AUs606jO9GICENA+KwgAVDc42SzdDLj20FEImpspKkRqdwuWqcvCsi7edOwhJ6ZaCmSDv7ciTNT4ESABztjQmfY5QOEEbdnNGX6jnXPtR/TGwq0nZMH4YAVB6mp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238568; c=relaxed/simple;
	bh=nev9DihsAC8ocjNS3pSrj/VrEo50v0lYj9jPXLzN3dI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDLIFuVQ15MKxZ8B96+iN6jloFrgad6mfrbYDotUI0wzq4DwJrKXl8BufZSrjlhbY68+MFLUsubclKUknLKuSUIxGzUtb2ZjEwIbjzivU5BgBIx3WBZ+fbd+lkQyAikm5Hco+UDY1iARe6DVj+1Ztrytcip96IRyGF95dGK42E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKz59ovc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C3BC4CEC0;
	Fri, 13 Sep 2024 14:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726238568;
	bh=nev9DihsAC8ocjNS3pSrj/VrEo50v0lYj9jPXLzN3dI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UKz59ovcSBej7OtWtbRe0tbX50QcQpMQMs2wES6kA2DP7CSvFeUerkT7o3OT9x1vJ
	 mMu7jell5l9ZFPriGIp4/s80uMUHagZ3ln4kJkDHF/fH5mhaBAWb1Ll7g824zptES+
	 nk8OxjGdT2XwxbGHDrgXL1nf87FzgH60sHI6IT4vzYjRjfagYnXVO4AjrJnjnQUlyH
	 wd//uPyqSZE2a40aU9ZSeTACWbJCxFszdQXMeX9FF415Z9asESAvjISjot0cq9BhPz
	 oCAje0bmYCHIUq81hx5xVh79RcFaj/B+ktWr2RqPr2dpnPf8IlpiQA6XDzns9FWnOF
	 PpOPppV6G3d3g==
Date: Fri, 13 Sep 2024 07:42:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [PATCH net-next] net: sched: cls_api: improve the error message
 for ID allocation failure
Message-ID: <20240913074247.4279a51d@kernel.org>
In-Reply-To: <20240912215306.2060709-1-kuba@kernel.org>
References: <20240912215306.2060709-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 14:53:06 -0700 Jakub Kicinski wrote:
>  	} else {
>  		chain_info->next = NULL;
> +		NL_SET_ERR_MSG(extack, "Filter with specified priority/protocol not found");
>  	}

I messed up here, the cases which handle NULL as success now print a
warning.
-- 
pw-bot: cr

