Return-Path: <netdev+bounces-84441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78133896F03
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABCF28DD71
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4237313A279;
	Wed,  3 Apr 2024 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7KsVR+v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E04913AA2E
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148014; cv=none; b=YANlCeHjbwvbCCciSElUdspV/+fdeVYgCB/Pc90JFHGZ+1WvEc9vohFmKSf6RDW8YHkWLlcHuFh4vEEhaGG79HuNtk43PeZ+IlxwE058W2MP2pUIolMcjjRWKEHMDzSEgVd+81taK1Zl958XBYZDhjj85eEzCP31tCMUScutW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148014; c=relaxed/simple;
	bh=hzc9o0bmctcupcNHYShXcWBGyDogvzt8Z5PI3CNB6wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW3fYNCIO6ef8dNxhLUVsiIhh83R5vjnECrY5A0nQYTaG7mxMceAD8LVeI8KZYt8BOAwo67+aAYqTh8lbgvuCv+6/24jvkfyT7uWhrmtbtLVu2pFC3DTRbrrPpjZVVsERg80P6rJgAE1fIOGFHD870uypT71NoINThFIODe6Awc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7KsVR+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B319C433C7;
	Wed,  3 Apr 2024 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712148014;
	bh=hzc9o0bmctcupcNHYShXcWBGyDogvzt8Z5PI3CNB6wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7KsVR+vJy70uUzMLkymPKkgUcvWrjYqfViPYk2PgLmG5/f0B1KCZnC2e9rT80BhY
	 I9EUXauajQxWB487fTQXBQCXzlDrNdjNMS3pcfD63GNcoW4Ho9n5TnFhqb13pPa5NF
	 l0ASsXMR0eLj7Pm+wWvFqZ2ppzZfaN9FGLdSssTezy8RdIURsz0u1Wyqmkw1MPb6Kw
	 mGkB2GJEXwOWs1/BWCsQXgVVW4/mwchy/c3XUeuFV/pEDZD27AKS057P2Qb/7rF4R8
	 zkiz8IAEfej7VMRkEVwNfAuf+AM9Dv+VgYBHHJu+rf+hXgSbkXxryaKlioi9ar7efJ
	 cG2Tw8/8Dd3nA==
Date: Wed, 3 Apr 2024 13:40:10 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 12/15] mlxsw: pci: Break mlxsw_pci_cq_tasklet()
 into tasklets per queue type
Message-ID: <20240403124010.GH26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <50fbc366f8de54cb5dc72a7c4f394333ef71f1d0.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50fbc366f8de54cb5dc72a7c4f394333ef71f1d0.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:25PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Completion queues are used for completions of RDQ or SDQ. Each
> completion queue is used for one DQ. The first CQs are used for SDQs and
> the rest are used for RDQs.
> 
> Currently, for each CQE (completion queue element), we check 'sr' value
> (send/receive) to know if it is completion of RDQ or SDQ. Actually, we
> do not really have to check it, as according to the queue number we know
> if it handles completions of Rx or Tx.
> 
> Break the tasklet into two - one for Rx (RDQ) and one for Tx (SDQ). Then,
> setup the appropriate tasklet for each queue as part of queue
> initialization. Use 'sr' value for unlikely case that we get completion
> with type that we do not expect. Call WARN_ON_ONCE() only after checking
> the value, to avoid calling this method for each completion.
> 
> A next patch set will use NAPI to handle events, then we will have a
> separate poll method for Rx and Tx. This change is a preparation for
> NAPI usage.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


