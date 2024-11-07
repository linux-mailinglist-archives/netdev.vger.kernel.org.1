Return-Path: <netdev+bounces-143104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2869C12C6
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E793D282F24
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3B1E5718;
	Thu,  7 Nov 2024 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5ovEakH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479F198E99
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023601; cv=none; b=hLVRSQVBNlMt0ybxPPtPBP7A03Ex3nM/uxCjQlXOv7AEhbHTaIWjgocc/l4t3zO6834jPo7Q1YXRztijljH8oQEEUotlL6vxM7rPTFJSRfy/xDohichzk+KjghP4ux4pS12g6Uqhk14DL/jjMe1ctDf59KZtddeLwYD1IOoy6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023601; c=relaxed/simple;
	bh=CAwYmz1Gd232OJetYMrL5BAdpVO0prjDewtB1VYezWs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7K+4abm7gmXe4NeiRLTzQC19+yHkIpCQhG1OBQxt4vzulj7w9BnhgG046HACzKhYE33BpQ8NZFDeTmbLZDsr2EdzFYNLwbW7QWqPqNZ33lX+flHJYyG3hfJErdmbPOlsucRpzWTkZbQZYSiTpJki/7LSlV9GV/nXF4tCe8Omhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5ovEakH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3148C4CECC;
	Thu,  7 Nov 2024 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731023600;
	bh=CAwYmz1Gd232OJetYMrL5BAdpVO0prjDewtB1VYezWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n5ovEakHpMF4fgUtS+qnX+I97IR4jb2vTGA3Hbd4+4bJ5ybznH98Bsyn0PoETD+Ix
	 tW1X3Ma8uzVkvMrr9BM3YaWBITV0SoJ3GC7ZiQuT/CFy6QBkFzUtyNF2HnedubwgDs
	 eIMoxGEAtTZR/75T6RyGqV/Q3RxiDyMsmiL7IBDb0yNugnWKLrfWfVVa1Fw/3Q+Rly
	 yhi6L+zq/dBnghlSBcN37uYpkSvTA9GFe0qeVHQIiz5nobo7oI0m7PlWxRZxGbh1vj
	 6Z37+qeYTE9Vyhb/0vkjHiaqz4TG6xmFsNZhP3FJGaPtB2I0DvZtAkH1Z4QL+HCXl7
	 ordqHyHuJSBxQ==
Date: Thu, 7 Nov 2024 15:53:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov
 <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 00/10] rtnetlink: Convert rtnl_newlink() to
 per-netns RTNL.
Message-ID: <20241107155319.50f36bd2@kernel.org>
In-Reply-To: <20241107022900.70287-1-kuniyu@amazon.com>
References: <20241107022900.70287-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 18:28:50 -0800 Kuniyuki Iwashima wrote:
> Patch 5 - 8 are to prefetch the peer device's netns in rtnl_newlink().

Patch 5 did not make it to the list :(
-- 
pw-bot: cr

