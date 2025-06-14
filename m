Return-Path: <netdev+bounces-197788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8BCAD9E4D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866013B493A
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82201C7005;
	Sat, 14 Jun 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsRqy0Uj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C419AD5C
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749918003; cv=none; b=KIBOyJgXmVGUmPYscR3DZPhbexDtFJ+1k7UM8HZbiRNGJUM+CTEpU51uqVD2MshJf/exnfb8SdiJOfQuGjtSWnKPYtyPBMoeBZ/HN+TWg4hcQD9f3rB8BY7xLIRLqhxzsU4lh3D0RaNsQkEFW7bsk+m9xBuwTlKYeVycAjfIzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749918003; c=relaxed/simple;
	bh=0GegDJxko1h+/vJI60hpKtJ1MlCxN3V5Z3MP1dBr/8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXJ7/PyoQ7JNgo3nF0slxYDK8EUtJab27pcnfhL6LR++Pl4X6LRIhWct2VAcd3WmOtNNPE3USGTA6bjO1fRofqPkEW0orEGaxiYqD9m3xZPDLJIXl8deehXDswPy5WhaLISIqDo28QMFSG8NJIhBbcSi3asZ9CwP4AknpJUkiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsRqy0Uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33753C4CEEB;
	Sat, 14 Jun 2025 16:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749918003;
	bh=0GegDJxko1h+/vJI60hpKtJ1MlCxN3V5Z3MP1dBr/8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsRqy0UjHSXyo1DIwBsP3PNzUaFBMZPD+U3J/nU4h1aVLecpZsmB5F55jz5jPBGXg
	 emcW3MtcuG71YwRdxnU/vpYFhwhhQlVzYFFJfOikMVoWmjyCtfjwhPFjK+iXVfUPVa
	 cmYvZkS93IdmDvztVBOnpA7DEH/f1gC53eQ+hEcqbfJ4LnipS3kZihzIEp4FXD5Byz
	 uNK+Pg5zvbtO8zOCziCbOm3PQwICP8KpKwZxSm+QCiPSfHTX4+NG2ahon1jNow2r35
	 wkeQw3BLgJzLDnlUsx4ONwuZt3hAPap9LVGD4nx+mmLXdlj4vL6xW81QKd+HnodDn3
	 qZQts8HEgXByg==
Date: Sat, 14 Jun 2025 17:19:59 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net-next] atm: atmtcp: Free invalid length skb in
 atmtcp_c_send().
Message-ID: <20250614161959.GR414686@horms.kernel.org>
References: <20250613055700.415596-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613055700.415596-1-kuni1840@gmail.com>

On Thu, Jun 12, 2025 at 10:56:55PM -0700, Kuniyuki Iwashima wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> syzbot reported the splat below. [0]
> 
> vcc_sendmsg() copies data passed from userspace to skb and passes
> it to vcc->dev->ops->send().
> 
> atmtcp_c_send() accesses skb->data as struct atmtcp_hdr after
> checking if skb->len is 0, but it's not enough.
> 
> Also, when skb->len == 0, skb and sk (vcc) were leaked because
> dev_kfree_skb() is not called and atm_return() is missing to
> revert atm_account_tx() in vcc_sendmsg().

Hi Iwashima-san,

I agree with the above and your patch.
But I am wondering if atm_return() also needs to be called when:

* atmtcp_c_send returns -ENOBUFS because atm_alloc_charge() fails.
* copy_from_iter_full returns false in vcc_sendmsg.

I ask because both occur after the call to atm_account_tx() in vcc_sendmsg().

> 
> Let's properly free skb with an invalid length in atmtcp_c_send().

...

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1d3c235276f62963e93a
> Tested-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

My question above not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

