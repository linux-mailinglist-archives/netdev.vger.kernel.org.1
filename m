Return-Path: <netdev+bounces-44488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7926F7D8459
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8BF1C20D27
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79D52E62C;
	Thu, 26 Oct 2023 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpgXqdsj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4B848A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B1FC433C7;
	Thu, 26 Oct 2023 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698329823;
	bh=qEqAx2OHWkAeXIfN4NMymQXug57tvWuYcXlPXd0GYrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CpgXqdsjugd/hlhafWxPxdh/ypt85SFjnaRmf5JA/CG25tyKY1n5LvyURQ3lxbFWD
	 ivkheVldloX4sqkyQvl/+E2Zi+xA9rASNOn+MrR8ymwUXcSM0aX2obgQy/kT+Dff3q
	 hEzS+8+XQxD5Gi98gfbkq5sT4x6A4uzmDC5fxPwG1/c6l40gK9LlQjrhkxb2RpSvdB
	 Nz7pdpIheMnIl7EO4/BTuAzIrVnj4z/5JQX/S3k+RL30CEoYFutePGwCMNaruammR9
	 G3LAzZG16bPLPIWM+ELJXz5zcnS8lY2Y1y8oGwiAoUmSXE4sYemnrNDOgBGterBZUp
	 L+iJj0BZ9bqRA==
Date: Thu, 26 Oct 2023 07:17:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Coco Li <lixiaoyan@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan
 Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu
 <wwchao@google.com>, Wei Wang <weiwan@google.com>, Pradeep Nemavat
 <pnemavat@google.com>
Subject: Re: [PATCH v4 net-next 2/6] cache: enforce cache groups
Message-ID: <20231026071701.62237118@kernel.org>
In-Reply-To: <20231026081959.3477034-3-lixiaoyan@google.com>
References: <20231026081959.3477034-1-lixiaoyan@google.com>
	<20231026081959.3477034-3-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 08:19:55 +0000 Coco Li wrote:
> Set up build time warnings to safegaurd against future header changes
> of organized structs.

TBH I had some doubts about the value of these asserts, I thought
it was just me but I was talking to Vadim F and he brought up 
the same question.

IIUC these markings will protect us from people moving the members
out of the cache lines. Does that actually happen?

It'd be less typing to assert the _size_ of each group, which protects
from both moving out, and adding stuff haphazardly, which I'd guess is
more common. Perhaps we should do that in addition?

