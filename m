Return-Path: <netdev+bounces-231783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C730FBFD6C2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1C15584A98
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F12D1907;
	Wed, 22 Oct 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCgRrlOn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE6255240
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151383; cv=none; b=GyM9eL3egrGMeBL5amguLkSdEV0k7YNX73bYko0LaKoWbvjvjoqLNs9TPtEmwHCC82WxkpO57afIZ4FUzpvlRUYIFRCnSIUBCZzxfMTQ623ow+lijuncI5PWnQdZg6cL7Ym12p53vGp9ewD2kY8J9/wWPRDvPHGHU55vWu2svsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151383; c=relaxed/simple;
	bh=WdlrB3q2QZ33xOe+SYTWXpKBwIrqF8HtmsZYMedGrb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk2YVNPOQCcqyz7LzUBeO7z0meP/3NHkWbIYnT3TzIwKxBbzODzCBQTei52MRTUDU7kBX8NOVP9epi4o0cPyuNEZvK+OVZ5j0HLy7DBzhqFFh8g1FmiyRcVwnl5X8rFP8BNMbl63NtvFR8ljvmiAkp0bpKw1iTWBUYQmYF2PK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCgRrlOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B292C4CEE7;
	Wed, 22 Oct 2025 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761151382;
	bh=WdlrB3q2QZ33xOe+SYTWXpKBwIrqF8HtmsZYMedGrb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCgRrlOnrDJMGn4fTtRxFEDD/h1IgCunNltO3TZJUjD+aRRrurh8S5WvRrxria7Be
	 tEr+vGYbNUJ3yTlEtgIwpO1+Zu6wkrDFrXawlLoCKeF4R3SL5baELZ2t9/NzPcJWAj
	 +JwPwS7lHlsTUgiKQOmPsMocYV95XTbHtEbm6pptWKg1hdKnnUAw8gPFu8WVFcAy4+
	 Bw/zuROYCsSD2k0TCW6vzSQH3JmlY7pEJMfBxfWl46Un64ZVmRQ6YR55TifKlDSPUT
	 62u50Z+EsvAL60SZgYsfzEK6FdRF8+0NaEjDWzcxesEdyzieWlNhrFFbHIfKIxRnVU
	 3XBooe0EGc9CA==
Date: Wed, 22 Oct 2025 16:43:00 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: netdev@vger.kernel.org
Subject: Re: [bug report] tcp: Convert tcp-md5 to use MD5 library instead of
 crypto_ahash
Message-ID: <20251022164300.GA245108@google.com>
References: <aPi4b6aWBbBR52P1@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPi4b6aWBbBR52P1@stanley.mountain>

On Wed, Oct 22, 2025 at 01:56:47PM +0300, Dan Carpenter wrote:
> Hello Eric Biggers,
> 
> Commit 37a183d3b7cd ("tcp: Convert tcp-md5 to use MD5 library instead
> of crypto_ahash") from Oct 14, 2025 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	net/ipv4/tcp.c:4911 tcp_inbound_md5_hash()
> 	error: we previously assumed 'key' could be null (see line 4900)
> 
> net/ipv4/tcp.c
>   4884  tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
>   4885                       const void *saddr, const void *daddr,
>   4886                       int family, int l3index, const __u8 *hash_location)
>   4887  {
>   4888          /* This gets called for each TCP segment that has TCP-MD5 option.
>   4889           * We have 3 drop cases:
>   4890           * o No MD5 hash and one expected.
>   4891           * o MD5 hash and we're not expecting one.
>   4892           * o MD5 hash and its wrong.
>   4893           */
>   4894          const struct tcp_sock *tp = tcp_sk(sk);
>   4895          struct tcp_md5sig_key *key;
>   4896          u8 newhash[16];
>   4897  
>   4898          key = tcp_md5_do_lookup(sk, l3index, saddr, family);
>   4899  
>   4900          if (!key && hash_location) {
> 
> If key is NULL and hash_location is zero
> 
>   4901                  NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
>   4902                  trace_tcp_hash_md5_unexpected(sk, skb);
>   4903                  return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
>   4904          }
>   4905  
>   4906          /* Check the signature.
>   4907           * To support dual stack listeners, we need to handle
>   4908           * IPv4-mapped case.
>   4909           */
>   4910          if (family == AF_INET)
>   4911                  tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
>   4912          else
>   4913                  tp->af_specific->calc_md5_hash(newhash, key, NULL, skb);
> 
> then we are toasted one way or the other.
> 
>   4914          if (memcmp(hash_location, newhash, 16) != 0) {
>   4915                  NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
>   4916                  trace_tcp_hash_md5_mismatch(sk, skb);
>   4917                  return SKB_DROP_REASON_TCP_MD5FAILURE;
>   4918          }
>   4919          return SKB_NOT_DROPPED_YET;
>   4920  }

Thanks.  I don't think there's a problem with this patch: it just
simplified the code, which happened to make this warning visible.  If
both key and hash_location are NULL, then 'key' gets dereferenced in
tcp_md5_hash_key(), both before and after this patch.  If only
'hash_location' is NULL, then it gets dereferenced when comparing the
hash values.  Before this patch it was conditional on
tcp_v4_md5_hash_skb() succeeding, whereas after it's unconditional.  But
tcp_v4_md5_hash_skb() should never have failed anyway, and even if it
did, its failure or success was unrelated to hash_location.

Looking at the calling code in tcp_inbound_hash(), it actually
guarantees hash_location != NULL.  So, that's why it works.

So, the misleading null check of hash_location in tcp_inbound_md5_hash()
should just be deleted.

- Eric

