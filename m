Return-Path: <netdev+bounces-151939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7889B9F1BFE
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 02:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC15188E854
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 01:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D7DDA8;
	Sat, 14 Dec 2024 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdkE1B4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58323946C
	for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140827; cv=none; b=ROZjIvlP4XYxiLGr+TVz36EMLXvwavERPyJ9pWFPjR0B7eDFKLmuHsQzPasWC4BgAqNsFIHHOQuDBHETHdvl3a8S9wr/3/+ZeUQdWJGSFFHbXsTbrMEDE1m2RVEHktrj0s89A00cdMC+eauk91e+F1jhO+FTp2XZCWBigrhPkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140827; c=relaxed/simple;
	bh=FX98AqQSksO5JLUN0ogWd2Cs6/C6gRv5biD3nndfbqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTSh5SEIsfnFXG1U/XhZPnhTTjchWnKiwh8Y2rOAy68B06NcxGXikHFl8JV+mbmhjpcugfVbSHVbWnYmG/SZf9A7qoAtz+5ZrlW03Qg/1QbGNKdsrT9yiRN4ZB79Ozaz8xA7fQ5ga95c3Ub27eWulptwzQ6HEmWB+EeJ6vuO/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdkE1B4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA8FC4CED0;
	Sat, 14 Dec 2024 01:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734140826;
	bh=FX98AqQSksO5JLUN0ogWd2Cs6/C6gRv5biD3nndfbqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CdkE1B4Esr+pK+Mz3jQ2vNDCwJIWYTGD173OBio6pyb0XPwugcn3jnUE2G8E35oa2
	 n0DHvA+ushTwzC0CrCNNEHWJ5AF2xB6cKhXa69TLUtqtgnWdXmAOhKFWW4YPpXTY+S
	 T4/6s3rv1dyuQnSPUPUZp22PS8YicJjhzq6esiK6ehVriLXNvqqnw/tLrjUlJlLRNe
	 Q9ObV4BoFymYtEYHfgUeD4dOr/RsdJvZlJJ3Y+x0OWMcY2rw9pL6Ngv1F+VuERqD5H
	 TnCubivIHFRA7FgooZxk9teh1PH1n/yg1gNIvYnNPVd/ulOY49Bbqg1DKqR7BlbrZV
	 IoRC8ShWs9gMQ==
Date: Fri, 13 Dec 2024 17:47:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1] tools/net/ynl: fix sub-message key lookup
 for nested attributes
Message-ID: <20241213174705.39a24574@kernel.org>
In-Reply-To: <20241213130711.40267-1-donald.hunter@gmail.com>
References: <20241213130711.40267-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 13:07:11 +0000 Donald Hunter wrote:
> Use the correct attribute space for sub-message key lookup in nested
> attributes when adding attributes. This fixes rt_link where the "kind"
> key and "data" sub-message are nested attributes in "linkinfo".
> 
> For example:
> 
> ./tools/net/ynl/cli.py \
>     --create \
>     --spec Documentation/netlink/specs/rt_link.yaml \
>     --do newlink \
>     --json '{"link": 99,
>              "linkinfo": { "kind": "vlan", "data": {"id": 4 } }
>              }'

Let's take it as a fix into net (no need to repost):

Fixes: ab463c4342d1 ("tools/net/ynl: Add support for encoding sub-messages")
Reviewed-by: Jakub Kicinski <kuba@kernel.org>

