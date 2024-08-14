Return-Path: <netdev+bounces-118520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F160D951D78
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA881F217A7
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E81B373B;
	Wed, 14 Aug 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1d0ABNc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11301B3F2F
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646392; cv=none; b=EJJj8j76gFoUVYz6Aqsc0hD0qKDLddJ1Avwp6USpYikaFtkXoKhaa9LSHIe/4PB/aVHwsJq0R8CYBAppJ/OWUeRs16VHpUwPu/v0jQt2+eQ2L6EB/FcPtRdd17QKUK8510Zvkc1+l/5JQ3rJ0MJsMXPRTKz5/Gjlv2uUnF+aoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646392; c=relaxed/simple;
	bh=AEeOThIwFa51UGt6SiUgtkROhfQZ3sMkKkOGsK5BeSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyKFqimDCFTne6bIMBu1+cIFpRLvrsSB29inmo/sDe4NtveXjUeWoQ8KMBl6XFKLGnaADWxrcvo9iphxjacT74twHjf6t4NO9esBCB8214RkNi03UXeq6b2D3nNwmp5eWLBmc1vkS9szFvoepg9aUNxfUIG1Od3O2WG+3xnKZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1d0ABNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47D1C116B1;
	Wed, 14 Aug 2024 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723646392;
	bh=AEeOThIwFa51UGt6SiUgtkROhfQZ3sMkKkOGsK5BeSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B1d0ABNceHc9Jy9zTP58mAyUfswJemXChY6Z9m+wrq4e5GIRog+wGSx3/uI8vww8D
	 CtTWzNHFNqiAc/oybXhdBiOPgFApMCh0YzR9D+DBfrWzDtmSX+lwDNWMoP7zIVaQQ1
	 F5ZD35rx3ecuR555VHeSDk8G9f7SL4kD4iBFrZIfEGhkPBbo5Vml8JLsAalg4fiVb9
	 2vLnCMiPJ/OEajqeh1P5/lM36pZfWEIVeNfbL1v8Lm8ScEp7HdqAL88E0y1rrE1VFb
	 0l6uS6Jl1XcqRISzwHv6tSK18SLFwzV/Bk/kz2qDvtV92md7FIa8/O28gY3zB4jYbP
	 /V3BO5GwlXhxg==
Date: Wed, 14 Aug 2024 07:39:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Mina Almasry <almasrymina@google.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, David Howells <dhowells@redhat.com>,
 Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: Re: [PATCH net-next 0/5] tc: adjust network header after second
 vlan push
Message-ID: <20240814073950.53c6d4d7@kernel.org>
In-Reply-To: <ZrysAhVp8AaxPz4b@noodle>
References: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
	<20240812174047.592e1139@kernel.org>
	<ZrysAhVp8AaxPz4b@noodle>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 16:07:14 +0300 Boris Sukholitko wrote:
> > The series is structured quite nicely for review, so kudos for that.
> > But I'm not seeing the motivation for changing how TC pushes VLANs
> > and not changing OvS (or BPF?), IOW the other callers of
> > skb_vlan_push().
> > 
> > Why would pushing a tag from TC actions behave differently?  
> 
> IMHO, the difference between TC and OvS and BPF is that in the TC case
> the dissector is invoked on the wrong position in the packet (IP vs L2
> header). We can regard reading garbage from there as a bug.
> 
> I am not sure that this is the case in OvS or BPF. E.g. in the BPF
> case there may some script expecting the skb to point to an IP header
> after second vlan push. My change will break it.

The packet either has correct format or it doesn't. You could easily
construct a TC ruleset which pushes the VLAN using act_bpf, instead of
act_vlan.

Let's not be too conservative, worrying about very unlikely
regressions, IMHO. Such divergence makes the code base much harder 
to maintainer.

> > Please also add your test case to
> > tools/testing/selftests/net/forwarding/tc_actions.sh
> > if you can.  
> 
> Done in v2.

Please do not respond to a discussion and immediate send the next
version.

