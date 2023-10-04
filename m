Return-Path: <netdev+bounces-37968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7204A7B812C
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2A03C2815DC
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 13:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8F914F70;
	Wed,  4 Oct 2023 13:41:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2A14AB0
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 13:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97929C433C7;
	Wed,  4 Oct 2023 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696426908;
	bh=sFibZASjob9Bb2M5+ckUcHwc5IVahwWhX0asbrrAf64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AO1ZkqGrwUv4Xb6jCIhJnUj452UbJxo5Tgqcxfg7/d+67439SrRMdLcVl+mG8gCQm
	 aB1dlFFbgEWfTae60hpdBpkUfjEoBINWdRSHsE7PdkhqVf7koNCpI3EpaCDYlnJwUx
	 T6MyKb3WPBk0c/uFMlSGRH0gNlU3YEfOTGeiqzMvGw7kepNUe/oidtM9LHcjBOG6ou
	 B9sI4Bpv1aFRDfZbt+iBAPd1JZRYLR7QSCeMzpCSA9g9xU15x5pbFW3KWTtM/cf4dn
	 zu/EOwqRMXx/21Wr3LUUGxACIt4dtiUUCWyrGweAnuxuP1pjb8IME8cEcp7lx/qgfT
	 pbfIjv/EFUOJQ==
Date: Wed, 4 Oct 2023 06:41:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coco Li <lixiaoyan@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Chao Wu
 <wwchao@google.com>, Wei Wang <weiwan@google.com>
Subject: Re: [PATCH v1 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
Message-ID: <20231004064146.18857c9a@kernel.org>
In-Reply-To: <20230916010625.2771731-2-lixiaoyan@google.com>
References: <20230916010625.2771731-1-lixiaoyan@google.com>
	<20230916010625.2771731-2-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Sep 2023 01:06:21 +0000 Coco Li wrote:
> Analyzed a few structs in the networking stack by looking at variables
> within them that are used in the TCP/IP fast path.
> 
> Fast path is defined as TCP path where data is transferred from sender to
> receiver unidirectionaly. It doesn't include phases other than
> TCP_ESTABLISHED, nor does it look at error paths.
> 
> We hope to re-organizing variables that span many cachelines whose fast
> path variables are also spread out, and this document can help future
> developers keep networking fast path cachelines small.
> 
> Optimized_cacheline field is computed as
> (Fastpath_Bytes/L3_cacheline_size_x86), and not the actual organized
> results (see patches to come for these).

Great work! I wonder if it's not better to drop the Documentation/
files and just add the info from the "comments" inline in the struct?
Is there precedent for such out-of-line documentation?
The grouping in structures makes it clear what the category of the
field is (and we can add comments where it isn't).

Right now the "documentation" does not seem to be mentioned anywhere 
in the source code. Chances that anyone will know to look for it are
close to zero :(

The guidance on how the optimizations were performed OTOH would be
quite useful to document.

