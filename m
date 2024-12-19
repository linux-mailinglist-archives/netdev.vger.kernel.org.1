Return-Path: <netdev+bounces-153415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B4D9F7E14
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 726FA188A037
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB0822619C;
	Thu, 19 Dec 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5tl5D6p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55BA226198;
	Thu, 19 Dec 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622141; cv=none; b=g2rc8KeVNkI8TIrdme/HQklRt2omazRBu5lzQ7ZMBc2lk/J4cOoQzJP0EH11l2UUdtpNUIifVNuEiVa3XLznrOyBdWNwyZnWiNOuMXxXFdyU+oHrJZ1l2f0epMtNbaVL9HGxOsLf8h5m/WtccsSpjPluLIgJ/tnOokHAVzJyVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622141; c=relaxed/simple;
	bh=/plqvgdtrQeQosqWgzBBAw0UgMR8wBO4LgwCKIzfngk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=My9N3RwCN77i1redElj8ZFHDUJgJ6bPiG195rdgtUmdw8vT36eU6/W0Mxexu/sFrkSG0UfZ0tUoIkLchEkv5XVBJXQCppWS3DzuBK/Dp8JNDbIBzvH3VXGNjJpdBBFYVRL7u6mBn3wU+6AjGGdL2PTA5gLWLZDI2nP294vn4gqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5tl5D6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16E1C4CED0;
	Thu, 19 Dec 2024 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734622141;
	bh=/plqvgdtrQeQosqWgzBBAw0UgMR8wBO4LgwCKIzfngk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D5tl5D6pYVEGVvywX3NYn/WzMyOE1eXrEwlvxKpKp/DHFrS+mqSQcF2ABjQBoc9xT
	 9xG+/ySFslAQ23agUuxfEHn0AaYD7xQxIimjQ6GlVkjarXvQXgQKUGfQnp/xPG3KxQ
	 sCq7TF9SryZjUp6ngvs/9pQXyedczI868gSeMq9sfh41QcW5es0RyZ01PwPwb+rEwo
	 EtpIlXbKWUs30KPib+sE36a0T72t/mrDSmBNG0OsHnpr0v9QkZrZmNWStmU4nTDlyl
	 D5FruKs2E7K5IbhjffROaCfEDcdth5Ky0VPhjQeR0PEcFUkK3+7yX2zDaNkdJtLKjB
	 57P+ICup5lPlw==
Date: Thu, 19 Dec 2024 07:28:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v6 9/9] netdevsim: add HDS feature
Message-ID: <20241219072858.3e704135@kernel.org>
In-Reply-To: <CAMArcTW-wDThHLnNVUNGQRrTOT1Vbzc3F5R=U4PiFjvifeeQPQ@mail.gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-10-ap420073@gmail.com>
	<20241218184917.288f0b29@kernel.org>
	<CAMArcTWH=xuExBBxGjOL2OUCdkQiFm8PK4mBbyWcdrK282nS9w@mail.gmail.com>
	<20241219064532.36dc07b6@kernel.org>
	<CAMArcTW-wDThHLnNVUNGQRrTOT1Vbzc3F5R=U4PiFjvifeeQPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 00:19:38 +0900 Taehee Yoo wrote:
> > On Thu, 19 Dec 2024 23:37:45 +0900 Taehee Yoo wrote:  
> > > The example would be very helpful to me.  
> >
> > Just to make sure nothing gets lost in translation, are you saying that:
> >  - the examples of tests I listed are useful; or
> >  - you'd appreciate examples of how to code up HDS in netdevsim; or
> >  - you'd appreciate more suitable examples of the tests?
> >
> > :)  
> 
> Ah, I appreciate example of tests you listed are useful, Thanks!

Okay :) 

FWIW I don't expect that you'd do anything too complicated to support
HDS in netdevsim. The packets generated by the networking stack are
"split", already. What I was thinking is basically check if HDS is
enabled, compare skb->len to threshold, and if we shouldn't HDS call
skb_linearize().

