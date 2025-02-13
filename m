Return-Path: <netdev+bounces-166211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68457A34F88
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321DB7A2F5C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C712661A8;
	Thu, 13 Feb 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuVQg2y1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F66200132;
	Thu, 13 Feb 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479194; cv=none; b=lGfp6MwCBOBEoUdCNNrnwB1UDWcdc0907fHTnYEdltGJbAMPIQZyplGAK34gkprvh6HeQp+dwvTwXOhU3+0SEYnF7iamP4wnpCyY5TjlomLbOO1JR9/ZVT76WIui3urS6EWZp2J8O1We4ypmPODpbyC+XPYPHQAkx4nFqmt+21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479194; c=relaxed/simple;
	bh=I43WipJFZGiEGhg2qWPVWpV42+FmXX+eV9wMks3pbKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fInTWFDwpbkuvPrGo3YOvmCosD943bMpzab8/279/1XyC0Ud3Qt2MxhWluKAjkRGcMiiEiZ2dgGYI0JBi1nJKfp+MMhjtPTfZsp34sIazA78CVLWVyeSrRu5E/KjOWFT1dKwSnFYK0dDxR5KG9hHGmN66UJEH0kBEjM9091Bsas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuVQg2y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A993DC4CED1;
	Thu, 13 Feb 2025 20:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739479194;
	bh=I43WipJFZGiEGhg2qWPVWpV42+FmXX+eV9wMks3pbKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuVQg2y1I6bydNKpaS6YHlXTIHFK4w6nuYrzS15EMmrEWNzeDDnVAAH6qh4Hko4p+
	 J+1Cz1kkbQ0b8ABc3Rd44UHZp01nRZFQauzQ2BQhSqdKIDWAOxAbfTjkBFcgJpqRl5
	 ThFO6bvHQPzxWGQoux5d5+EppUrEAIJZjKV8PRXB9HaJApnERIpDLOGNRbpUuhER6y
	 W/MKstouOdwc8mhom0DfHfGG8S53n41LiWHLudjdw83L7T9v3F45Gypx65l3wW9TrM
	 IcLJYcLIEGYwV/FVk6hTQEeK9d9QdDioY4IssoauXHWOsvKv928R9Q7hDGQ6OW+dxJ
	 +YDw/mTBYJt5Q==
Date: Thu, 13 Feb 2025 21:39:51 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <Z65Yl2eeui05Cluy@pavilion.home>
References: <20250212174329.53793-1-frederic@kernel.org>
 <20250212174329.53793-2-frederic@kernel.org>
 <20250212194820.059dac6f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212194820.059dac6f@kernel.org>

Hi Jakub,

Le Wed, Feb 12, 2025 at 07:48:20PM -0800, Jakub Kicinski a écrit :
> On Wed, 12 Feb 2025 18:43:28 +0100 Frederic Weisbecker wrote:
> Please post the fixes for net, and then the warning in net-next.
> So that we have some time to fix the uncovered warnings before
> users are broadly exposed to them.

How do I define the patch target? Is it just about patch prefix?

Thanks.

> -- 
> pw-bot: cr

