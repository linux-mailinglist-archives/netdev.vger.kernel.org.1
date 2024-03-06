Return-Path: <netdev+bounces-78028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8923873C80
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E15281781
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9E5137901;
	Wed,  6 Mar 2024 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPRwUwnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895D132C3D
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743447; cv=none; b=e8g49jPivDriVa5v9zL0RB1kkWOFWTVWa1cC06idOe6VRTy25J5qdFWoaIlTRq9SnOR+rAb0M9tMmYNtzvAedZDeMi2gl5gXMy50MtSaELqg61bEMo5V4E9Y7rIwfVIhRqjNLxMurqp2iS8r8YOIL8KX7UV/fgZsrMiKXDuIsKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743447; c=relaxed/simple;
	bh=ehdsWdsWSsQt/+kq1ugcbCsjXquvAeMO2E9wHeeWbrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fY73h5GvI/AQO5cq2htjAGLdlOcAYq+i5GXOS1aGqcFDfG/nT5+n2tyfEzObch8zhpmbsXVOKitMMtdUov73WZM8SxxflnJ0olxaI7gKlewFdRSnLLQqlgmk48Ye7MuwayQGJqOFEmvp+fxDtwJJ6qHIZ4IANhsW9qztsYp6n2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPRwUwnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951B7C433C7;
	Wed,  6 Mar 2024 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709743446;
	bh=ehdsWdsWSsQt/+kq1ugcbCsjXquvAeMO2E9wHeeWbrQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HPRwUwnNCncvTSkxdtSFrUJ3CHY7TaM3VJEsM/1mZO7NojdCm3RzqizMsDk0LJLnA
	 Gw+o+MpSn/kZyuQoagvJZz3PDd5VEFnRt0nJeh7wbKEuBpBh+NC+sS9bbSHWVqTj1d
	 P/ihBsnJxmHEDygLYD3BmQvTXlZDUFqjTkZJIZhV7I4JXg64ELAXk2wRGN5dp9CL3I
	 PSrQxp+84RFP0BGEXatdTP1LRa0eQLNjjZdBmHaatKAFAGca7FqRJRT5V8fQLnZCVb
	 A0H3hE1ZVDSAcqDNyKwNyXc8UWQUw1AMa/3zbmV9saBNKxwRNWyCmm4a9IfdX8W9yZ
	 OmsvlypTbbWiA==
Message-ID: <939c7e01-38e4-42f1-aa28-aaf83aae4c39@kernel.org>
Date: Wed, 6 Mar 2024 09:44:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ifstat: support 64 interface stats
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20240229043813.197892-1-stephen@networkplumber.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240229043813.197892-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/24 9:37 PM, Stephen Hemminger wrote:
> The 32 bit statistics are problematic since 32 bit value can
> easily wraparound at high speed. Use 64 bit stats if available.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  misc/ifstat.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 

applied to iproute2-next

