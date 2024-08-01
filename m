Return-Path: <netdev+bounces-115070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5DA94505E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EDD2842F4
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C567C1B3F23;
	Thu,  1 Aug 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyvucrFO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE9D1B372C
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528994; cv=none; b=nonc+J7mXBrs60hiYMWHUtZLcCxWzDuHFlNgwrKKvKvjDTWnd2PWRzgiEHoC4LJ72p2rSvBlWbiQhXVkf5BPO9Q07VTbmQJNarwdto3DqJZ6NnRBoLxqa/RXnyGhKYXdWRhujt0K8ZmW+jlw/Pbq0ql7fgE7d/TQvgRMM76hS8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528994; c=relaxed/simple;
	bh=87ILm2FZcphyEx4S5OHlMu4aBk4+5CFRXqyA6Q8/vxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwIG2ooaNCs/fOAg+MYCM6f6hQeTcjjb19KKIqNOkUGzHD1y/DdN04MsqKhWQFPXJWuQ5N875+nGayVWoBC140pA1+9SlAADBG3oeYr70tBAWBtE8JbWe8LzXm+D8qGPCqThVhmmUFa/R33zdl3Mn3dQX6AgDU+FXwS5bx+1FUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyvucrFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B160C32786;
	Thu,  1 Aug 2024 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722528994;
	bh=87ILm2FZcphyEx4S5OHlMu4aBk4+5CFRXqyA6Q8/vxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KyvucrFOs+M0uWEr15MW5cuJO9e4D1WIDKHYSezsr97glWiHXVidaackJEoqtdfWw
	 WibTC4EPkTXAIHDUotEwlwX6wemUoZb8Q3Wn4vCO3N0sPA+kPfP1OzGpPHN7THH8JL
	 62NnJZ0I6lFcPXkZswt0W0TM+TDXaXxAXvmMbY1aeflSSAj3ZiqGqBJtgP82FTxoYU
	 wlUAavmpeIaMAnbKHTeVERzBG0RG4kaYDu0S0RgfhcJg3BFRRR2nrGj8e3s3HGk4Fa
	 N2HmS58yvL1KYNhtUcJdqarnUdzqPECaxSrnW7DorFinJ4kvG+hFwDxRCx3HoqXA+U
	 7PrLlvVCyWq0A==
Date: Thu, 1 Aug 2024 09:16:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 felipe@sipanda.io
Subject: Re: [PATCH 00/12] flow_dissector: Dissect UDP encapsulation
 protocols
Message-ID: <20240801091633.55b2ae5f@kernel.org>
In-Reply-To: <20240731172332.683815-1-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 10:23:20 -0700 Tom Herbert wrote:
> Add support in flow_dissector for dissecting into UDP
> encapsulations like VXLAN. __skb_flow_dissect_udp is called for
> IPPROTO_UDP. The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing
> of UDP encapsulations. If the flag is set when parsing a UDP packet then
> a socket lookup is performed. The offset of the base network header,
> either an IPv4 or IPv6 header, is tracked and passed to
> __skb_flow_dissect_udp so that it can perform the socket lookup.
> If a socket is found and it's for a UDP encapsulation (encap_type is
> set in the UDP socket) then a switch is performed on the encap_type
> value (cases are UDP_ENCAP_* values)

Appears to break build for allmodconfig
-- 
pw-bot: cr

