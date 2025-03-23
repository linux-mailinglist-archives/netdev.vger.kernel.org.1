Return-Path: <netdev+bounces-176961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD809A6CFE0
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 16:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157783B6612
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE71586334;
	Sun, 23 Mar 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BvQ9J25h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xryv/1Ce"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B553142E86
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742743012; cv=none; b=oIY6KyYwLLzqsSk5iO39CW/QVl1iCWySEQVzVKic9zEokVSmOwpXj/h56BoWu7KCYp3qiRvzxsAwmKOTZBzg2P5QJw95DwsIfB6YJ5Xgj2yytlSg2GlFyjzHIryEYBOwujfjNbIzohoitQQPP8dQC+ynQVm3a4y9MN6A0E5YEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742743012; c=relaxed/simple;
	bh=yTaZuF2SKjwiuSa8tVuZaUeR+hG4o2SHnFxN09PN2CY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+mFeEKvaIdcu0al1/4asEf5Cm0vuMAjU75J09hG2lz17M/zDGIoN0U/yC5W09wVQNdIYtM/Drj5XHByzkfObShl5g/rdLRjWNZ4CWermixebg3h7RUm3o1pFwxMqb/uuEL8J7mkwEcdP4sofyARp7rhXGqRfQ6J6Em2fDnkA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BvQ9J25h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xryv/1Ce; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Mar 2025 16:18:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742743003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T98q9jFnzzbdUQ7bdurg+XMNJJpY9e5JsxNKazKdTkc=;
	b=BvQ9J25hyefsSG8FiI5X3oKYKTAhCvRC7CngpM9UsdbNZn0ielpRq5cuQvt1NNV3amgTjX
	P1PVKlREXXqDoaF8/qADXc0t3ILuOC0PRMccXUWl6iGw3Doo9CSJ/PQhiOcYqLj8vjwW0I
	tVoBWsdM8X6Nqnb7HhRSHYUjjCKvnySLUAelkONYADHvEnmKGpjL5gB/T8i8CFiBYmqslK
	hL9k8ia7+zO0Zqr30nk5HMhl4iBJfMIB00Yts5K/QPb9GotQ5CxMwJOTWTl9mR8ODAb40C
	eN7x0AiBJdrj19HOQFBwaFw5IsRIjjBw0PuyIivZa5rlRuryoxTx6Et6mSKPRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742743003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T98q9jFnzzbdUQ7bdurg+XMNJJpY9e5JsxNKazKdTkc=;
	b=xryv/1CevWwzYVZNKZXOgZNHjG170HSlpYNgMV/P67J8LcL/zRB13l32jgRBqjDo/xqyzk
	Qnsef+w9r+u70QCg==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, MD Danish Anwar <danishanwar@ti.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH] net: ti: icssg-prueth: Check return value to avoid a
 kernel oops
Message-ID: <20250323161826.5bcd9cf8@mitra>
In-Reply-To: <89f81b99-b505-48ad-b717-99e5d4d8e87b@kernel.org>
References: <20250322143314.1806893-1-b.spranger@linutronix.de>
	<89f81b99-b505-48ad-b717-99e5d4d8e87b@kernel.org>
Organization: Linutronix GmbH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Mar 2025 09:19:35 +0200
Roger Quadros <rogerq@kernel.org> wrote:

> Did you actually get a kernel oops?
Yes. And I would like to attach the kernel output, but I do not have
access to the board ATM.

> If yes, which part of code produces the oops.
I get an NULL pointer dereference in is_multicast_ether_addr().
It happens here:

    u32 a = *(const u32 *)addr;

> Even if it fails we do set a random MAC address and do not return
> error. So above statement is false.
I doubt that. of_get_ethdev_address() do not set a random MAC address
in case of a failure. It simply returns -ENODEV. Since
is_valid_ether_addr() fails with a NULL pointer dereference in
is_multicast_ether_addr() on the other hand, no random MAC address is
set. 

> > Check the return value of of_get_ethdev_address() before validating
> > the MAC address.  
> 
> If of_get_ethdev_address() fails the netdev address will remain zero
> (as it was zero initialized during allocation) so
> is_valid_ether_addr() will fail as well.
Yes. It will fail to. But is_valid_ether_addr() is not called any more.

Due to the if statement is_valid_ether_addr() is only called, if
of_get_ethdev_address() exits with 0 aka success. In case of a failure
the if statement is true and there is no call to is_valid_ether_addr().

Regards
    Bene

