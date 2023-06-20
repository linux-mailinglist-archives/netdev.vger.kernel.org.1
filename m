Return-Path: <netdev+bounces-12391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C88A7374CD
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 21:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5BE28135A
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134EF17736;
	Tue, 20 Jun 2023 19:00:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82843257D;
	Tue, 20 Jun 2023 19:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8BBC433C0;
	Tue, 20 Jun 2023 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687287639;
	bh=aeob/U1QWvlw2SLSBaYJ+uRLt9KuAyJq7oSNJ2cwddk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ElH8Oxja4qtbyt7Y5e4T8sKg6wiw4UyeydMRK2pcxDXdFAe7VZNpTGkhOCTlop5bP
	 D6+/BKVpcaqMmwaUrAxR/NhYyTezgnBQXUY/eqODABRCiS/APmqh7799iKRQYu9MIq
	 Ok9/RUzzp+UTjdKzYBmp5T8zjWhp9Izet01Wj6wI5DwKDPGUZOBV6t4+cXnzpcqqK1
	 PAKj/sKkU/VryPEmFM49rhmvLxhzn5LaQ6uOMuu+46LIyVeAiK9OH+YyMncCxeIB8m
	 ThGQdlSyB+Wg4+NtxrxBXqXF1qm5I+FEt38jCYK/BU1Lhtr0Aun4tpA+tOMXiJMeIM
	 rwzi1NCSAaE8Q==
Date: Tue, 20 Jun 2023 12:00:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <simon.horman@corigine.com>, Igor Russkikh
 <irusskikh@marvell.com>
Cc: Arnd Bergmann <arnd@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix
 <trix@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] net: atlantic: fix ring buffer alignment
Message-ID: <20230620120038.0d9a261c@kernel.org>
In-Reply-To: <ZIxfK1MVRL+1wDvq@corigine.com>
References: <20230616092645.3384103-1-arnd@kernel.org>
	<ZIxfK1MVRL+1wDvq@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jun 2023 15:10:03 +0200 Simon Horman wrote:
> Perhaps it just me.  But I do have trouble reconciling the description
> above with the structure below. As such, my suggest would be to simply
> delete it.

Agreed that the comment is confusing seems to be incorrect post-change.
Flags for instance are overlapped with len, is_gso etc. so they can't be
a separate 8B at the end.

Igor, please advise how you want to proceed.

