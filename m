Return-Path: <netdev+bounces-215313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53357B2E114
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2D1A2467D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B0E33473A;
	Wed, 20 Aug 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3+1C9It"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FDF33472E;
	Wed, 20 Aug 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702278; cv=none; b=B5UX8CjcVGIAROUsyrsNyRlZWaMUSwB4ybnExRLdTisuUztb0meuNwICKr6/K7uSKKb21KVWuGQCFLHDfFzFVMfel5O+mNQdRxLLggz0P9H56lWB/kSxnv/3OL0tQWpm6BVhXdBn+us90Xab4xmq8c/VskqMmsVTEk+kxuNYm8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702278; c=relaxed/simple;
	bh=8swLeMoDrj6X1zOeo0D/bAz3d4lgOnxpRrdZBtyJerU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsyzVmUH71yuYCw6pChXjwYIDv9kfTHNvXl4P8S59h9KaVVNJKiBpT7aDZpDHrzCxx/itqGniQiTyco7brjBGdcDUrWQeHzv0AZQ08kCuPcVCJgwpc9SEYu/vDKDmnNKy3QNLMekXgMZr3lTnd8wHTHzX/Z3WuyEsxMt46QWp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3+1C9It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE02C4CEE7;
	Wed, 20 Aug 2025 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755702277;
	bh=8swLeMoDrj6X1zOeo0D/bAz3d4lgOnxpRrdZBtyJerU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l3+1C9ItykQgKVLcWvupyDfY6ahYfzf05P7risXn+Y8CaRC+sceSR/wqSxkhT/Iyw
	 F1TqA/ILHIYW/L1/LO1PW7HkbL7sbh11uE3oaT7ZlJLaCHG3TXTnQQhXZy0YXwPGYo
	 fP+qc/beFG/UXW/jLJFIiBsckH4n+4kwgOh+fkyy6F+y7eXHNwja+kCa5mkNaazcUr
	 a12GWdWoQn375HIDmTV4fCtpI0Q6EIje3ol4296SKs5iX7szxcoLxU1VRiaablICvW
	 wG2OpY8qNWksPSIrBA5Z31chvql8gtc33ME+YYqHTcYIuqFZN98JSikujH7u/dzafe
	 Tk/eAz/pYH3qg==
Date: Wed, 20 Aug 2025 08:04:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com
Subject: Re: [PATCH net-next v2 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
Message-ID: <20250820080436.36bed70a@kernel.org>
In-Reply-To: <bb28ffa4-d91d-479a-9293-fa3aa52c57e5@gmail.com>
References: <20250819063223.5239-1-richardbgobert@gmail.com>
	<20250819063223.5239-3-richardbgobert@gmail.com>
	<willemdebruijn.kernel.a8507becb441@gmail.com>
	<20250819173005.6b560779@kernel.org>
	<bb28ffa4-d91d-479a-9293-fa3aa52c57e5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 14:27:12 +0200 Richard Gobert wrote:
> Jakub Kicinski wrote:
> > On Tue, 19 Aug 2025 10:46:01 -0400 Willem de Bruijn wrote:  
> >> It's a bit unclear what the meaning of inner and outer are in the
> >> unencapsulated (i.e., normal) case. In my intuition outer only exists
> >> if encapsulated, but it seems you reason the other way around: inner
> >> is absent unless encapsulated.   
> > 
> > +1, whether the header in unencapsulted packet is inner or outer
> > is always a source of unnecessary confusion. I would have also
> > preferred your suggestion on v1 to use _ENCAP in the name.  
> 
> Yeah, I guess that was the source of confusion. IMO, it makes more sense that
> INNER is absent unless encapsulated since that seems to be the convention in
> the rest of the network stack. (e.g. inner_network_header for both skb and
> napi_gro_cb is only relevant for encapsulation)
> 
> I could rename the OUTER variant to simply SKB_GSO_TCP_FIXEDID so that it's
> clearer that it's the default (resembling network_header). WDYT?

Yup! That'd match the skb fields so SGTM!

