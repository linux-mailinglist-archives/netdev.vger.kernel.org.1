Return-Path: <netdev+bounces-148774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3A39E31A5
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C5DB21B0C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7442052;
	Wed,  4 Dec 2024 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+rQIz8B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61430A35;
	Wed,  4 Dec 2024 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280767; cv=none; b=g/Ynbtnb5vhx46FqfsxD2mV51DBz005i28ohuPdzZf+PtK/FpQztFud+kO7d3esG8bCGUoW6VNxwTzvTmf2XWIdjIjwH0iMpe3lNEvFY9P8alq+S42xhqHtV+b4hUhXSPJIv4JSJcJphhBZR/JxgqBopErxQbYQ8P/3AirITIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280767; c=relaxed/simple;
	bh=XI9tUZZ+oBrW6M4VqxCZK9NTslH/Cwh6oq2xDMo3u+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOE52idDEcgTLmerrQosVy5MVmDZydza22yVLtg+mhtgWkJ11QGprk9YK/URCLQPlWKcXeAgeEQGsRgfquTdYEQGtdQhtOY4J85dMaxt/wA+xdUwSDMM5ggJgRaXtj0E9udG4JUAk5EDjMup5ESRFcf8JA822vMGe2QqshdKLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+rQIz8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FBEC4CEDC;
	Wed,  4 Dec 2024 02:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733280766;
	bh=XI9tUZZ+oBrW6M4VqxCZK9NTslH/Cwh6oq2xDMo3u+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+rQIz8Bw3VEMAwgfQmwu0j45p1JGG88MLmXnASl0iRdQWEtuqPHjmMGnPKpl6azQ
	 BlWN6DoTcbRI04PwHC0tXgZoKOHt6dOkpcB78PakEObBQ43P8s+S1FW0m8+ZoUmQJE
	 2FnEJ2JmanXkbnUFDIx15eyrB1EGhIP6qZX1OdhGODRoAIcIuznxe5788w6TpT7Xvo
	 7UKIymSmswAqx/QVcANBo+T8aUNXCRkGd3kJMiKReHWz7GUg0WbTlB88eKSkPmT4df
	 f/DupYgTDr7xE874oy3pF0g4KqeB+d/giFN2UOdrafqhEM8OLfaQwNrigW9OI1V3Vy
	 UodO761yERfOg==
Date: Tue, 3 Dec 2024 18:52:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <Parthiban.Veerasooran@microchip.com>
Cc: <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
 <jacob.e.keller@intel.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>
Subject: Re: [PATCH net v2 2/2] net: ethernet: oa_tc6: fix tx skb race
 condition between reference pointers
Message-ID: <20241203185245.7b1fb10b@kernel.org>
In-Reply-To: <ba984578-318c-4bf3-8ffb-875ab851ee0e@microchip.com>
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
	<20241122102135.428272-3-parthiban.veerasooran@microchip.com>
	<1d7f6fbc-bc3c-4a21-b55e-80fcd575e618@redhat.com>
	<8f06872b-1c6f-47fb-a82f-7d66a6b1c49b@microchip.com>
	<7f5fd10d-aaf9-4259-9505-3fbabc3ba102@redhat.com>
	<b3e23d57-3b3b-474c-ae45-cbbf4eaaef3a@microchip.com>
	<ba984578-318c-4bf3-8ffb-875ab851ee0e@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 03:37:01 +0000 Parthiban.Veerasooran@microchip.com
wrote:
> Does the below reply clarifies your question and shall I proceed to 
> prepare the next version? OR still do you have any comments on that?

In case you're still waiting for a response - yes, please proceed with
v2, add the diagram requested by Paolo to the commit message.. and we
will see if there are more questions then :)

