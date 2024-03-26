Return-Path: <netdev+bounces-82248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634388CF0B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115F3340F06
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EEB13D50C;
	Tue, 26 Mar 2024 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkyaG14O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81FFC0E
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485253; cv=none; b=AwoLbryJFERRQfNkgYyECDW0I4KxtwLffbSMRwB4Hm/WGNW1JIHFtjySLBv9htiuC2yJvZcF0VV2R4mYdHZmkoYNYoso5DTqAkJMRTV1eTiV/+Y9ZBYKRlEzZk9ipoWOvNIrmUpVn3CZBJmfHjcvsB4dEb/8BemgRULIfABk9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485253; c=relaxed/simple;
	bh=j/PabFDcdJUI94WQyYVL4fvKV5TUXCn640jFOd3+HaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ESdx3x5abU8scowtwNFgSRdYBEoHNWKFGH7KdHW3PKg5TxNbvrvuGmOzDXhvBgB1k83ftOhw5wgQVWrQ9uCxHrAasCHIKd82A6weDeFA7OVtfAeK4TmddSFEPlEOcU8AgO6YJD76NFN44Id2+pWC+jkRniB/4x8HADAH1IMHnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkyaG14O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A83AC433C7;
	Tue, 26 Mar 2024 20:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711485253;
	bh=j/PabFDcdJUI94WQyYVL4fvKV5TUXCn640jFOd3+HaU=;
	h=Date:From:To:Cc:Subject:From;
	b=HkyaG14ONzSFSeujBOL3rFISQQbhQI4OpRBAdmYstIvpt/5jQaOUVprWBvoX4yQEP
	 AIdSOJBmzv0ZzvFE0l8F2hkzJ/yM3xrOve923RHiHPkgZ6n/4fqov9Gd3+YMrjaOfO
	 RjRM9DJIBN2W8yaDBrL7M6iO9WvYmbYkQaae84HYXdszVQP5nkU9EWgyYUbVA3PQtU
	 LNQhyr6RuYHMSWyZoGB+mItnezypU4uWwuOevG0PnJvyy6vkX3Qq5zJ7AYJp1Vcetv
	 T+JbtGCE57HGkLFOOKY7ux/1eTQGmXAMq2KP7YWgkW+5KSlap+Mkq398Si3YE2eZQl
	 tPUSyRcGaYmiw==
Date: Tue, 26 Mar 2024 13:34:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 ncardwell@google.com
Cc: netdev@vger.kernel.org
Subject: ICMP_PARAMETERPROB and ICMP_TIME_EXCEEDED during connect
Message-ID: <20240326133412.47cf6d99@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

I got a report from a user surprised/displeased that ICMP_TIME_EXCEEDED
breaks connect(), while TCP RFCs say it shouldn't. Even pointing a
finger at Linux, RFC5461:

   A number of TCP implementations have modified their reaction to all
   ICMP soft errors and treat them as hard errors when they are received
   for connections in the SYN-SENT or SYN-RECEIVED states.  For example,
   this workaround has been implemented in the Linux kernel since
   version 2.0.0 (released in 1996) [Linux].  However, it should be
   noted that this change violates section 4.2.3.9 of [RFC1122], which
   states that these ICMP error messages indicate soft error conditions
   and that, therefore, TCP MUST NOT abort the corresponding connection.

Is there any reason we continue with this behavior or is it just that
nobody ever sent a patch?

Somewhat related in tcp_v4_err() we do:

	switch (sk->sk_state) {
	case TCP_SYN_SENT:
	case TCP_SYN_RECV:
		[...]

		if (!sock_owned_by_user(sk)) {
			WRITE_ONCE(sk->sk_err, err);

			sk_error_report(sk);

			tcp_done(sk);
		} else {
			WRITE_ONCE(sk->sk_err_soft, err);
		}
		goto out;
	}

So the error is soft if socket is locked, and I can't find anything
in backlog processing which would pay attention. So it seems that 
under certain conditions we already ignore it.

Can we ignore it always, or perhaps conditionally based on IP_RECVERR?

