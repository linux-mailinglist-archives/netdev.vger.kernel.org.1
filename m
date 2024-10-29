Return-Path: <netdev+bounces-139986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A1F9B4EC3
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F422B1F23B48
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748D197543;
	Tue, 29 Oct 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiBLLumO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21692194AD1
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217627; cv=none; b=EZF7/ptNE2qVce51mnp2nmb1HSadHYIYpiqlAlMx1h75xFWJMlOGgXLN3dG7l4Y+H5Z3EiSPQIH7mC9/6GPAf2yBRORBaWQMXu4Y+xKBVxnN8HiXS08wcSuBu5KwtnXIJLE5MStndDiI6zsczOm4To6BdmJmkbbDyK3oEAgMC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217627; c=relaxed/simple;
	bh=HqmVBONzN4pwpqdORteiw0+IgmG+lHAK/6cuoVpqQOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNttXsM1Q7TSfDK+Lq4cEN2z23Pw6uGM2gr7Di2z16tYt4orG5Dn5N2bGcIFikYJHUhmko6RfuVVwGDH1wydoVvirnM4NyPy2ge1c2i9zwxOxPQXnINAISPgBjMw53wb/+c4w5Iz4psl4A56j4+ffZsO1WD9c/P19cFeaC6xBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiBLLumO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2EEC4CECD;
	Tue, 29 Oct 2024 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730217626;
	bh=HqmVBONzN4pwpqdORteiw0+IgmG+lHAK/6cuoVpqQOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BiBLLumOM+EYzsgE+sGj3ZEGIgg1RFjW+LHFcSHFFtXzNjAHCzQMMshLs+yhRqmE3
	 OWS0IqSf5MpgUq4b5K1dPvmK5+exc4w9/iXfab1mqH0cW2EWC0kod4voscYzJpSeLw
	 anT69RW9QvPtKdt1lwxz1qIC16tLGwynlbiTGPGLSbZ6KjN5c8cZFM32P2jw18hdDf
	 kes33twrQuqJjqf7ueY91XCUpGQCsYXbHyM7PhjkzH3/wYowSijOJ+LQ6evzQhdqqb
	 6c10P1X6Hyxf54wN9e+jHVcEsR3L/lHqcoMFMYy8Igc9vw/Pvmf6Ecoa5n1hKNQCBw
	 FCoCnvaOHnU5A==
Date: Tue, 29 Oct 2024 09:00:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, netdev@vger.kernel.org, markovicbudimir@gmail.com,
 victor@mojatatu.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us
Subject: Re: [PATCH net-n] net/sched: stop qdisc_tree_reduce_backlog on
 TC_H_ROOT
Message-ID: <20241029090025.766765d3@kernel.org>
In-Reply-To: <9ce50453-c78a-4883-a888-51e31f673f40@mojatatu.com>
References: <20241024165547.418570-1-jhs@mojatatu.com>
	<Zx0dHmOtsI6FmOeN@pop-os.localdomain>
	<9ce50453-c78a-4883-a888-51e31f673f40@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 11:36:00 -0300 Pedro Tammela wrote:
> > Can we also add a selftest since it is reproducible?  
> 
> Yep, we are just waiting for it to be in net-next so we don't crash 
> downstream CIs

Can you say more? It's more common to include the test in the same
series as the fix. Which CI would break?

