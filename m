Return-Path: <netdev+bounces-58139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4452C8153FF
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 23:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E0F2864B7
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C03C18EAF;
	Fri, 15 Dec 2023 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQLUim/H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909B18EAC;
	Fri, 15 Dec 2023 22:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C32C433C7;
	Fri, 15 Dec 2023 22:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702680661;
	bh=RXdK6WE2rb/NaaADk0qbTl/pqAk6badogzNJAS0K9TA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OQLUim/H00s3zz/bpvwscuI7uUfp/5lz5E/vH7B+3pYZr7X29HTWIO7lN74KA0lSe
	 97BwWHiXBf3fGk7ieRatgGCQdsNJSamyEfcuVney0nhX6xRHCcmIe3jE5vZogpZ3qp
	 uA1vye+1FmCTwV/LB5lg9gu6JVUDHEBHEPdBkxwXH6Yu+dCboBmMNvlchhyP5Bk5/0
	 8XSQVbE6IYxFwLO/hDIGzsqASXyzlzZt1cAqqHjkOILxheHYFHg9NP+7nC0shbmMPY
	 O6dMDUxM1V4pigHnX9gkmPb/WD+pgYYQqbsOlgGnlr3B8rdZW0wdQ0T1ZXcM+OOvOE
	 +wwZAqPbYveiQ==
Date: Fri, 15 Dec 2023 14:50:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>
Subject: Re: [PATCH net-next 00/24] locking: Introduce nested-BH locking.
Message-ID: <20231215145059.3b42ee35@kernel.org>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 18:07:19 +0100 Sebastian Andrzej Siewior wrote:
> The proposed way out is to introduce explicit per-CPU locks for
> resources which are protected by local_bh_disable() and use those only
> on PREEMPT_RT so there is no additional overhead for !PREEMPT_RT builds.

As I said at LPC, complicating drivers with odd locking constructs
is a no go for me.

