Return-Path: <netdev+bounces-205190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16BBAFDBF0
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3924417F9D5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8751EE03D;
	Tue,  8 Jul 2025 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fj8vKFXf"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB6235345
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752018312; cv=none; b=R756W4SS/YS10kY55R29cNGTHmeGpl2AFzCNKZFEiC4+4Ls0n/RFlx8tUV5nUtmEYZRuo4f96LBkxvSOLtSOM0fpZSyI4PkO7S9Db6byA5Dr2nhrl4s75sByBo+BVIJvvtiN6CxkfBCSjctHZgVf8xQmijc3xJe2m5zc7FgXJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752018312; c=relaxed/simple;
	bh=uswqeM6MBywlQQkdM97/wdipp2PWQ52lhx1ilYGysR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdAbnXJAJQQfKOKSRn2SG1+IyupvF8PWM3VJt/qtLhw4qzxF3fE0FzFpVmK6U8a3SrYK4/CxkXBEdDvx0uWRr2xCYWldxkwvpwhfowlWlKYsBFFmM1QECPF/lbkCEqxUuO9bLpjI77GScNohvsTCXkLGTvvv8VSwVGwo1/i+6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fj8vKFXf; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c3a1640-16b6-47a8-b1a3-a90a594885af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752018298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBcOdcpkOoWEGLUUTwps1tV4j7br1iXLa43k1bPzcZI=;
	b=Fj8vKFXf/y+NVi/0IzM1isJlQ4AjwSyVNT6iTlgGVL6H5zoRnfUSsv8VuoGChyLWL1jQH9
	jsk1p/CTpD++BLMle1nDsuRNMV3oI7cv7p+MNBhSk742wzNjQyBzBeUBkgaMzCDDWyVoYt
	cwCxYLy+N0hvccvLTpjFSHvshazsLdU=
Date: Tue, 8 Jul 2025 16:44:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 12/12] selftests/bpf: Add tests for bucket
 resume logic in established sockets
To: Jordan Rife <jordan@jrife.io>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250707155102.672692-1-jordan@jrife.io>
 <20250707155102.672692-13-jordan@jrife.io>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250707155102.672692-13-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/7/25 8:51 AM, Jordan Rife wrote:
> +static void remove_seen_established(int family, int sock_type, const char *addr,
> +				    __u16 port, int *listen_socks,
> +				    int listen_socks_len, int *established_socks,
> +				    int established_socks_len,
> +				    struct sock_count *counts, int counts_len,
> +				    struct bpf_link *link, int iter_fd)
> +{
> +	int close_idx;
> +
> +	/* Iterate through all listening sockets. */
> +	read_n(iter_fd, listen_socks_len, counts, counts_len);
> +
> +	/* Make sure we saw all listening sockets exactly once. */
> +	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
> +			       counts, counts_len);
> +
> +	/* Leave one established socket. */
> +	read_n(iter_fd, established_socks_len - 1, counts, counts_len);
> +
> +	/* Close a socket we've already seen to remove it from the bucket. */
> +	close_idx = get_nth_socket(established_socks, established_socks_len,
> +				   link, listen_socks_len + 1);
> +	if (!ASSERT_GE(close_idx, 0, "close_idx"))
> +		return;
> +	destroy(established_socks[close_idx]);
> +	established_socks[close_idx] = -1;

I may have missed where the fd is closed,
does it need to be close() first before assigning -1?

The set lgtm overall. Thanks for working on this.

