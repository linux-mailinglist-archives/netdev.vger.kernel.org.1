Return-Path: <netdev+bounces-119923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75983957842
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A8F287799
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC88D1DD3B4;
	Mon, 19 Aug 2024 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AphsxEeS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D43C482;
	Mon, 19 Aug 2024 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108214; cv=none; b=N0jN7EqVUhYirHH9lpswUPpfGqponJOXBz/alGW7EnjTwFeFTBlLN9BSPr0WDBh2wQxMBr3GS6c4iFMO4cbRsicaUOGUVbfNqQAeCiDmsEjGEUheo2RNnMmc6hTqQbs2iuNEee9pC0KXsP6mpsIsjqABkqj9KKFoBR4F+/SR624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108214; c=relaxed/simple;
	bh=4d6P2dfyvJCUi1/JrP4JrsqIsuBFY/h/5+CLQBL5L58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0RuBUTWGf6mhTz+JbejwM+mlWENYf7bPtirVXwAWPb1TLn9rBGu84BGDcaXZ6ipIwkffcJa0t1dX1Tel1iT43CDpIVcCkMiw97O3sJafkI8jgdIj+vW9bEeCLD1gpjLZVNgKcJdpBH4f/8evg2CUU7hLflVemBEi4ygt9G+o7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AphsxEeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF98C32782;
	Mon, 19 Aug 2024 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724108214;
	bh=4d6P2dfyvJCUi1/JrP4JrsqIsuBFY/h/5+CLQBL5L58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AphsxEeSRia+ktm5GTvtLA/Fe9WMZj2FD4ta3UJc/UnNmqU3qkxKSiN6yqF1yJHt9
	 G23BB4Z4k/9oiOcYd89dFDX8jtA8G+q2Hjo6lrd2rmuGa9iCJIAkJ/Y6bmwI1Yk5bI
	 wDhdBYPbc1W0bNyMWVjTWZQHHNo/+HajwDVA85JCIKNFaFuLxIlMhTG3nRIaH8Y755
	 niaHW1h25NcTn9Z70jhzB6fFf6hr0X/hSoYLrExuci3UpBdG6jeh2ijn6SfBaah5Ya
	 zMGxw6bcs/+aJYU6Tz5uBfplfMiiCFLaaOGElxL2f+qPJrJOal1Yvqp7ZWUD9fVvmn
	 r23HbS6isj6Rg==
Date: Mon, 19 Aug 2024 15:56:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: pshelar@ovn.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, amorenoz@redhat.com, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org, Menglong Dong
 <dongml2@chinatelecom.cn>
Subject: Re: [PATCH net-next] net: ovs: fix ovs_drop_reasons error
Message-ID: <20240819155652.72c2bfe0@kernel.org>
In-Reply-To: <CADxym3aUZ5ng0K+kT3CBsKVG8-jSWe3fjVrSWQJLSXrm8oMHrQ@mail.gmail.com>
References: <20240815122245.975440-1-dongml2@chinatelecom.cn>
	<20240816180104.3b843e93@kernel.org>
	<CADxym3aUZ5ng0K+kT3CBsKVG8-jSWe3fjVrSWQJLSXrm8oMHrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Aug 2024 11:35:48 +0800 Menglong Dong wrote:
> > I think it should go to net rather than net-next.  
> 
> Should I resend this patch to the net branch?

Yes please! And with the results of your experiment added to the commit
message.

