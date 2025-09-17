Return-Path: <netdev+bounces-224101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C02B80B69
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17723A2F9A
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ABF34135E;
	Wed, 17 Sep 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgICtyYv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0543234135A
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123943; cv=none; b=M/8fxF6YG38N7lSj1CzhwL9CAbuyDn7fn94uToz8C+yN32ETGCgt/l5mfxA+xgggkrJz5jK4a5K5MR8trpa3f19UU6aMMGlFBqtFBM1Rul/LPQIqMq5qW+Q8Dt4DxlBd/gMpCSfM17HeAdHMKi3y7NClkR1FhR1RmSoH70xs7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123943; c=relaxed/simple;
	bh=1qczXYlSVA6ZJVogWDH8+hG/vmJbPair/YnmZvS4uho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiA2jRd74zivl4NunZR7MrC5fVg2Xm/D3ILhC71LPj/sbnj4u7athiFvhKXGZH3mJzLMON09EzqvvxkD1zxMoAqUCQJrdozgrbKjcRAGE/3uwU8k6DIU2/SRJrVWWzD4iojsWZpkYbmEy+sy0vIxQA/Iv0YJO1YHX+phHYDYnVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgICtyYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C17C4CEE7;
	Wed, 17 Sep 2025 15:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758123942;
	bh=1qczXYlSVA6ZJVogWDH8+hG/vmJbPair/YnmZvS4uho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qgICtyYvgXlnX6Zo/8YJ2S96+tL8jP91ZAFRDitacM/bs6E5xv3prTztenMAOgqC/
	 amKKeThUWT6KmlAUtbikb3LkPGW6Ce28xYhS1na4VOWwnU/j1TBa9H6oUDHSa0zGCk
	 4legrtWrOSFG3s4qY3VPy+V9+TIy8UMxCYGM2IqpLogRTYDkCk3hUNlQKWqskem/Mp
	 iRtGouB9sEA7ddguGs405C4y/QNKOLBp5nL8u2Bh2YroNBtlCOtwOJYizcWWsWXOQx
	 FqKmAxey5RWnEiDpj+I4Xp6ahOv1GhtHNQOW8+imjug8JtK4F9xDFFFbag8h/6MMrW
	 vQxUdt7pzvjvA==
Message-ID: <e9695618-74c3-4189-8e2f-6b5a311c487c@kernel.org>
Date: Wed, 17 Sep 2025 09:45:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/10] net: group sk_backlog and sk_receive_queue
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-8-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250916160951.541279-8-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 10:09 AM, Eric Dumazet wrote:
> UDP receivers suffer from sk_rmem_alloc updates,
> currently sharing a cache line with fields that
> need to be read-mostly (sock_read_rx group):
> 
> 1) RFS enabled hosts read sk_napi_id
> from __udpv6_queue_rcv_skb().
> 
> 2) sk->sk_rcvbuf is read from __udp_enqueue_schedule_skb()
> 
> /* --- cacheline 3 boundary (192 bytes) --- */
> struct {
>     atomic_t           rmem_alloc;           /*  0xc0   0x4 */   // Oops
>     int                len;                  /*  0xc4   0x4 */
>     struct sk_buff *   head;                 /*  0xc8   0x8 */
>     struct sk_buff *   tail;                 /*  0xd0   0x8 */
> } sk_backlog;                                /*  0xc0  0x18 */
> __u8                       __cacheline_group_end__sock_write_rx[0]; /*  0xd8     0 */
> __u8                       __cacheline_group_begin__sock_read_rx[0]; /*  0xd8     0 */
> struct dst_entry *         sk_rx_dst;        /*  0xd8   0x8 */
> int                        sk_rx_dst_ifindex;/*  0xe0   0x4 */
> u32                        sk_rx_dst_cookie; /*  0xe4   0x4 */
> unsigned int               sk_ll_usec;       /*  0xe8   0x4 */
> unsigned int               sk_napi_id;       /*  0xec   0x4 */
> u16                        sk_busy_poll_budget;/*  0xf0   0x2 */
> u8                         sk_prefer_busy_poll;/*  0xf2   0x1 */
> u8                         sk_userlocks;     /*  0xf3   0x1 */
> int                        sk_rcvbuf;        /*  0xf4   0x4 */
> struct sk_filter *         sk_filter;        /*  0xf8   0x8 */
> 
> Move sk_error (which is less often dirtied) there.
> 
> Alternative would be to cache align sock_read_rx but
> this has more implications/risks.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/sock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



