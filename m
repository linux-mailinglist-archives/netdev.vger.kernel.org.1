Return-Path: <netdev+bounces-237932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22695C51A3F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC8B188B1E3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A51302156;
	Wed, 12 Nov 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B5GBRHqh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="diklBLL1"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AD30170A
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943052; cv=none; b=incw6fDQYMBu1EKJqVZBVulesDyiywLB4jjNRXbCu6se5QcDc3e8no6eovzNAXCuu3qCRJUuqosFznj5lwcHgUzdyTEQSVT+C51nBKKeKFKMAT0CIp1EdSZuVLBGGtM9O9hZX4xcCQyYRElKu682ujtrccbSYe2IldBGdix1uV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943052; c=relaxed/simple;
	bh=lX6XbPhF1evI5d1vueUreX4QPIK2w+BsmVzD9Mf/esk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IR1KDmA/ngcgRGovRgVwa1z3cIUzQO+CSWzslppLUgco82UkkHXWZeMQkeuSIIrMM7wrziH7/pBZXj/Bdm6JGsOZ6j6WIL3NIXoF929joRry6NMj/EBLgf/GQ7ZaBtfF9Sa3EcTFodWHNyK4SDehA9HxqIH5OSRpySl2vL6wxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B5GBRHqh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=diklBLL1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Nov 2025 11:24:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762943047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lX6XbPhF1evI5d1vueUreX4QPIK2w+BsmVzD9Mf/esk=;
	b=B5GBRHqhhEpkGDXbhVoVqV1b6ReGng32bkkVdWSjLa4uwwp3ogoOAfhOkcVvNpLbGc47WK
	1cK48/IzHhOK/pYA3tHrVCY/yrsGMdtIfF4MfGYxidR+8YIIhcQ8esNrULO1FYjDBIfQAe
	O06oB70YYBMULkul9kLw1SFHXyVPOtdbvtX7IVK/KDNZda7lS0keRaZF8WIDJpElyjKvdE
	0kTo6u+5N50WoVvNu0YDPfLbZFZeDIuVud0KHSzc00inOyeLiqlE7PhZaXIO1MRQKD2Lh2
	0qmoee6h7QrcRm2MedRjNZ0Hllj5SJ9eQYz4GuUlnR80tmFLEjxjazf24a7mZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762943047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lX6XbPhF1evI5d1vueUreX4QPIK2w+BsmVzD9Mf/esk=;
	b=diklBLL1k1X9ymKUzbz1lSyybvHKqzxP4GFa1WK59ikOodtlT7bRAaaoWvksFGxNUvDAeS
	3dL6kXl33J8hOrBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	liuhangbin@gmail.com, m-karicheri2@ti.com, arvid.brodin@alten.se
Subject: Re: [PATCH net 2/2] hsr: Follow standard for HSRv0 supervision frames
Message-ID: <20251112102405.8xxcDBuT@linutronix.de>
References: <cover.1762876095.git.fmaurer@redhat.com>
 <ea0d5133cd593856b2fa673d6e2067bf1d4d1794.1762876095.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea0d5133cd593856b2fa673d6e2067bf1d4d1794.1762876095.git.fmaurer@redhat.com>

On 2025-11-11 17:29:33 [+0100], Felix Maurer wrote:
> For HSRv0, the path_id has the following meaning:
> - 0000: PRP supervision frame
> - 0001-1001: HSR ring identifier
> - 1010-1011: Frames from PRP network (A/B, with RedBoxes)
> - 1111: HSR supervision frame

Where do you have this from?
I have here IEC 62439-3:2021 (Edition 4.0 2021-12).
From the 4 bits of path_id, the three most significant bits are NetId
with 0 for HSR and 1 to 6 for the PTP network and 7 reserved.
The list significant bit for PRP indicates Redbox A/B while for HSR it
indicates port A/B.

You say HSRv0 while I don't see this mentioned at all. And you limit the
change to prot_version == 0. So maybe this was once and removed from the
standard.

Since this is limited to v0:
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

