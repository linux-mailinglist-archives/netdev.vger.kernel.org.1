Return-Path: <netdev+bounces-219739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0588B42D63
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3E45657FB
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB532EBDE9;
	Wed,  3 Sep 2025 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+bEaBck"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54CD1459F7;
	Wed,  3 Sep 2025 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942080; cv=none; b=jn8NvgaJZOPt+xPTUPjXL7pokfUxyw3HCX3gcrlxnY/aXsEK46Sn+dH9DwPFbk37H9bBz7bQO1WLNn/VO0hZUpoQKN0pi/tErjms/TqG2UAXAOcQNKQJOD8b2j6F26UPdxP0RqfX3ZndtnPRy0vhMAM2MkvFiU8jvLc/A6Waw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942080; c=relaxed/simple;
	bh=p+harcOTFJovdHFPimNMQQBr+Mv2a9XRYB6XrcqpCCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9yCxLl465wo9o/kasamnhrNXzHXW+1V2nC7m2wQEPfyqyEAWO8TaP/BAmcZ3Zr42UdFXLUup4IE3onIPp9HYm2WUFIpR69scWowh8Td2fP0zThX28WmoXB25sFXbrB+xqRw5npClZuBCNX6tQzHXS++T5y1WSO0NvWRgfc6pmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+bEaBck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA2BC4CEE7;
	Wed,  3 Sep 2025 23:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756942079;
	bh=p+harcOTFJovdHFPimNMQQBr+Mv2a9XRYB6XrcqpCCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L+bEaBckVXeKOv1fQdaf8L66LaCbzq2bhuFYDEXEKYfkvXypnujZyUtSJvcTqAGln
	 ONtWbuJWRUIC4KXDlJzX6cJ63cORQ1i1R+NINU6Ka8D88mmlGoLNSElCY3VFyMRjtL
	 OIN8kQ4I2n3hMZlYpcHaOAq4JVFQwulEyuywdQ1H5fSZXY83KdIFNGvhiSn1+82yqw
	 hZo60yigVqmVkR8k9ai2pXXQD1ViC7any8qWvO+qbMWP9a6pnXDHhxSBfp8Ni6/rwQ
	 KqlQoBaHvvQQ/NIMUSr1EwV1iJUINk4BRMGd1dkKnAJef6fuSlNVRLk3Jq77ER3RN+
	 fRARZJUFe+0UA==
Date: Wed, 3 Sep 2025 16:27:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bob Gilligan
 <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, Dmitry
 Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
Message-ID: <20250903162758.2bae802c@kernel.org>
In-Reply-To: <CAGrbwDTT-T=v672DR4wJU0qw_yO2QCMQ4OyuLjw+6Y=zSu5xfw@mail.gmail.com>
References: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com>
	<20250830-b4-tcp-ao-md5-rst-finwait2-v3-2-9002fec37444@arista.com>
	<20250902160858.0b237301@kernel.org>
	<CAGrbwDRHOaiBcMecGrE=bdRG6m0aHyk_VBtpN6-g-B92NF=hTA@mail.gmail.com>
	<20250903152331.2e31b3cf@kernel.org>
	<CAGrbwDTT-T=v672DR4wJU0qw_yO2QCMQ4OyuLjw+6Y=zSu5xfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 00:17:34 +0100 Dmitry Safonov wrote:
> > > Right. I'll remove tcp_ao_info::rcu in v4.
> > > For tcp_ao_key it's needed for the regular key rotation, as well as
> > > for tcp_md5sig_key.  
> >
> > Hm, maybe I missed something. I did a test allmodconfig build yesterday
> > and while the md5sig_key rcu was still needed, removing the ao_key
> > didn't cause issues. But it was just a quick test I didn't even config
> > kconfig is sane.  
> 
> Hmm, probably CONFIG_TCP_AO was off?
> tcp_ao_delete_key() does call_rcu(&key->rcu, tcp_ao_key_free_rcu).
> 
> Looking at the code now, I guess what I could have done even more is
> migrating tcp_sock::ao_info (and tcp_timewait_sock::ao_info) from
> rcu_*() helpers to acquire/release ones. Somewhat feeling uneasy about
> going that far just yet. Should I do it with another cleanup on the
> top, what do you think?

No preference :)

