Return-Path: <netdev+bounces-166130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88CCA34B53
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AA318813F9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791F819AD93;
	Thu, 13 Feb 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opA1onax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A32153828
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466085; cv=none; b=giwBwMcZvTNUf5TkL26M+KEglCpm1OkxIR15qI89X3sKX+rIpo3yc5Meiiwzr3S5LmSWpBHm9+KtfoM1empCCgA0fkcnaorDNHEtnMSb2ulTMNPlpkMsMPUEsNzMPiIi2M2oKbkyyZWVGPVuYKJ2hUwN4vnwcxNsC4UHEiWY97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466085; c=relaxed/simple;
	bh=7yOP9o/hePJlrJSW3zXV0+3UPTEu7pqguLe5lgjM2+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fm7QH7L0+rGREoGzSiw0p+6AnI+Dn4IyKx2UERzXrhAn1+HohPmEJsn82Y6r+kWdnkoKsu17AL6BmNFpjCvs9OCsJ4HSAPRqbCIq9E2tVyzmuhB/NmeFzvZPMTv/1Z6pKfBNBjQ3T/88BGFZ5VbtMyqrT6Z8RLzGUAG4zD/4SKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opA1onax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5236EC4CEE8;
	Thu, 13 Feb 2025 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739466084;
	bh=7yOP9o/hePJlrJSW3zXV0+3UPTEu7pqguLe5lgjM2+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=opA1onaxDSYjzy4orSZGuw+RJ6VHlWwiRicWrdpa4jy8/6GuZHyBz/h5Fw0fkHR74
	 +CfpJfW0qv6vwxx3vbgFziBVAFEQlcJZL5AnIEAJVOEd3Vy//21fYfQE38TPjsDFBj
	 i0t4N5DQ0YIgHC8s5EX2pNUObQvGA7U3mnEhymtQGvtXtdkvZek8eG+tXsdpgig8JG
	 e/Md6mWDPCJSVBo+Hxt6+d6/sXcsKdK7e3iiKXoKRBkyvimjUn1jDZ4PfV2FDndbHH
	 UQnEs1ybYJgs5CxCxAeAxnzbXt0rGzzW1XQdirW5V1xpOlw5XmQ5PwVYS3BKo27mOW
	 y6srK2jKukDug==
Date: Thu, 13 Feb 2025 09:01:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, willemb@google.com,
 shuah@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next 3/3] selftests: drv-net: add a simple TSO test
Message-ID: <20250213090123.0ca3220f@kernel.org>
In-Reply-To: <67ae17abc8d98_24be452942f@willemb.c.googlers.com.notmuch>
References: <20250213003454.1333711-1-kuba@kernel.org>
	<20250213003454.1333711-4-kuba@kernel.org>
	<Z61dwqIp7PD_-m0B@mini-arch>
	<67ae17abc8d98_24be452942f@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 11:02:51 -0500 Willem de Bruijn wrote:
> > > +        # Check that at least 90% of the data was sent as LSO packets.
> > > +        # System noise may cause false negatives, it is what it is.
> > > +        total_lso_wire  = len(buf) * 0.90 // cfg.dev["mtu"]
> > > +        total_lso_super = len(buf) * 0.90 // cfg.dev["tso_max_size"]  
> 
> Besides noise this also includes the payload to wire length with headers
> fudge factor, right?

Ah, fair point, up to 5% of header overhead here. I'll add that 
to the comment.

