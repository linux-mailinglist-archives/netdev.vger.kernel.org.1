Return-Path: <netdev+bounces-28129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A6D77E522
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E512A281AF7
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C25E156EE;
	Wed, 16 Aug 2023 15:29:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357210957
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9068EC433C8;
	Wed, 16 Aug 2023 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692199750;
	bh=K3pspvi+mNztq0zUKx2QOh+ZhXb8RA04MXtTRCHzTlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L4jvAo9Le55BA3M8kyRi3pLpFgETZBGFwqYsjeJJy95vCY7nZz4V9MEGhcTQLe9QC
	 U6IcqoiOj5syiLeJtst1wJMMAhvh6KLZwXc3Ta6goTfXMUxTsh5ua/zsTgyTnNB5eG
	 B8+FK5cdEUqx/3okhEbc+y1wnXJLPBE++iT74ErxWjTkbVV8AOrRNs5Q4AH4eN2pIe
	 F/gzVXunyKORmmi8M0Dv/od19L0+ZdkHAfqZhsk3cncAZSZjhLV4ZYJ+syKf089gLR
	 yArITDJlAHC4kmfhhqb6i5jJHfVJQTw30II8cRyg+lP5DG7PQwWO/xkhgc7MOLTQMl
	 3muPgzzpFALMg==
Date: Wed, 16 Aug 2023 08:29:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Stanislav Fomichev
 <sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 06/10] tools/net/ynl: Add support for
 netlink-raw families
Message-ID: <20230816082908.1365f287@kernel.org>
In-Reply-To: <20230815194254.89570-7-donald.hunter@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-7-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 20:42:50 +0100 Donald Hunter wrote:
> Refactor the ynl code to encapsulate protocol specifics into
> NetlinkProtocol and GenlProtocol.

Looks good, but do we also need some extra plumbing to decode extack
for classic netlink correctly?  Basically shouldn't _decode_extack()
also move to proto? Or we can parameterize it? All we really need there
is to teach it how much of fixed headers parser needs to skip to get to
attributes, really (which, BTW is already kinda buggy for genl families
with fixed headers).

