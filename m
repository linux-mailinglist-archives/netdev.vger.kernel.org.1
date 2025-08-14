Return-Path: <netdev+bounces-213799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1EB26B95
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162C41CE4AB2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1AF24502D;
	Thu, 14 Aug 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L+p+sqRm"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42BD23ABBD
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186520; cv=none; b=qVRWQWeUdjeCgRgSzJEJ2pbj/IdOYYgYkpHFlvn6GfputfQQxP8Lp4OOjhByBpv2r9N2Z1tuKi9k9z8eNU3nJpTR1oAPf/aiC04880Ua+W+3oTLUojrwPOvPuniaws2N/OM+qYi8pPweD9ROTOwYO0qVxIT7YnXVXqVVsuw+D5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186520; c=relaxed/simple;
	bh=sPE4/19E6dXsRQeRp7B3nlioy5W3BoQ/f9E4wp+e88I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxwnKYP2nP8QqPX47m3+1ob2RT7YcLMxN2MEiHyzajhh9IsJjq5ETvG2B0NgKLkSqjxLlq2Pd4caSIr4m/K+AR63PnCaovHaNov4OPerRd6fkKW09wxabz2JdKH3cNkUmUhR7q74Xf77OrAI8rXRpxEtRt41/Sub9Qg5CsqVdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L+p+sqRm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 956C2EC0180;
	Thu, 14 Aug 2025 11:48:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 14 Aug 2025 11:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755186517; x=1755272917; bh=HWedBERlR+YAiHi12Wg0cESfgmpAGV7emp5
	s/9aFc5k=; b=L+p+sqRmWJGJAKUlB+s5YdknriA5o2sLx8DZp1i1tbvLjiPZpUQ
	ZKhO2OblmbKKJo6nOq53rKg5AeQqrsrVYeHHLUTaWdGHnGVuqpyCEeZkh1sw+QqM
	EGSJCcTIDtJZ1RCOb5T0YNuPwG6qVhPWG5Jxq1T6ayJPcIBRCzYGToC49/5BCVn9
	S4xe48PiOh1CCSOl4/BW0XiBVObc3mZbQlGSIvNdt/DfsZJ0+VkZ2rUgKge4O2Kp
	CsbaHAuJBU3mazq1SfFV3jsDhFf4BOwlS+yEmmGpib7t2iDBJdNUqkaNY4ynESF1
	aaZB2qe40hD9h7vDh1Dmez9NTH+nQ+LSGSQ==
X-ME-Sender: <xms:VAWeaCnE8gQNNVZLLkX6KX4wD4P8fMz9wDMGdzlBdxZ2PT2qkfilOw>
    <xme:VAWeaHY3qobzE0CIeifdAA3T4OIdYiXcIUXbPXZh4bN8vRv5UbFT1q00kFHfQkIBx
    nGjqex4tMloIRI>
X-ME-Received: <xmr:VAWeaHEPxUfLP48sHLgGHvEOWl8m3A26H9hdeaoUCQDbnh_CMh5fIylPG2oaJsHXsDT4xwA5iKbiDGTCfzxorrQWl5TFmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedugeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhs
    tghhrdhorhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduie
    efudeifefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprh
    gtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhvghmihhnhhho
    nhhgsehkhihlihhnohhsrdgtnhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihihuhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:VAWeaILtpxyMizftAP1kuDQFjhR97o9q4XbExMg3bwhztlPE24dxJg>
    <xmx:VAWeaCNMCBXHqFtnkumvi8GhSoEmJ40zvb00F1fzc3I6haOnFiKs6A>
    <xmx:VAWeaIk4DmcyHJ5a9z7KJSG0hTn_1EkUsE1rkx-t7HLjVWDuKXAnVw>
    <xmx:VAWeaG4jjiIghzbD2dlJynUzeiUEg-EpYG2lNH_IQGSOr8PurGNHjQ>
    <xmx:VQWeaGWZI4EE6EPRd27BHtUpMyLSM2axRWgH9P3lvzQAMSmIkz0NLc7x>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 11:48:36 -0400 (EDT)
Date: Thu, 14 Aug 2025 18:48:33 +0300
From: Ido Schimmel <idosch@idosch.org>
To: heminhong <heminhong@kylinos.cn>
Cc: dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	kuniyu@google.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v3] ipv6: sr: validate HMAC algorithm ID in
 seg6_hmac_info_add
Message-ID: <aJ4FUauS-3Ymarop@shredder>
References: <aJx9DPI8dbRUtfGA@shredder>
 <20250814063302.112132-1-heminhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814063302.112132-1-heminhong@kylinos.cn>

On Thu, Aug 14, 2025 at 02:33:02PM +0800, heminhong wrote:
> From: Minhong He <heminhong@kylinos.cn>
> 
> The seg6_genl_sethmac() directly uses the algorithm ID provided by the
> userspace without verifying whether it is an HMAC algorithm supported
> by the system.
> If an unsupported HMAC algorithm ID is configured, packets using SRv6 HMAC
> will be dropped during encapsulation or decapsulation.
> To keep the HMAC algorithm logic in seg6_hmac.c and perform the check
> in seg6_hmac_info_add().

The "To" doesn't seem necessary in the last sentence?

> 
> Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structure")
> Signed-off-by: Minhong He <heminhong@kylinos.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

