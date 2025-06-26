Return-Path: <netdev+bounces-201399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914FAE9498
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 05:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB2F5A81CC
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 03:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3091D7984;
	Thu, 26 Jun 2025 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="JyUFICjq"
X-Original-To: netdev@vger.kernel.org
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431319F42D
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909087; cv=pass; b=tATcKPRjfVb0Gv6BursQUvvPXnwgwHED+q3mxIj5aDty1e9oGlUPahNHUkaiMigcoNuHtxGICQT8RRGaPIQX8w072d5i0v6npQBlfxJba6scVQRw75Comjm4PEEdlrJydkMhGXq+yRMLwZF5+LrSDtNCrknP2Au1pwJ6tjxuhLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909087; c=relaxed/simple;
	bh=Swq7boTMBmXFAxBINVMcM87Q+vzn/k+3jOH7eQzg74w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjS2pl8XrzDr+f0fGBNl2O3tnz5n6y9uLY+c1LhWdUmBM/VAB726zHgdCPr9snEO5sieWknIA4OSOEylt2UZf93yWaM7mpd8DDr/X8EhP1ZGFKIYt+CeErBGHFpMasjg2m8Ryy4YyYzhhKJwiDw+dRzqEn3nvsZUl9ZW0nc2Etk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=JyUFICjq; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4bSPXR16W9z3TFM;
	Thu, 26 Jun 2025 03:37:59 +0000 (UTC)
	(envelope-from kevans@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4bSPXQ0t8Dz3ls1;
	Thu, 26 Jun 2025 03:37:58 +0000 (UTC)
	(envelope-from kevans@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1750909078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1tKoSwrJQsbcYq+qY9jWj6OI+RYMT06LdinvFds3WU=;
	b=JyUFICjq9YUgpNaDXmZvlypC2S9PQta5kN/lC5idotuefEpjxoNwJBzJcqz+ajBUfe58pZ
	+HijlwwKWuC4sqNPK7cG88S+cnF0rYTsSVuQeThYxujssK8Ev9v73SnJN+EHOsOzeI8c7F
	CzR+Ix/1SUffe/fzc3vQ3RJ+eXS5O87dmiGdIkvw+IADrBO8QZsRLNZirIGXNPQsU/zuK2
	ijtSgCOv1gU252yBwxSxlm/3VCqKogRPgQ25wV8YEwKvLG1HaOfX4U5QMcdf7qC7pqEOPW
	44aOWKz9/qFFP2ohywaIQ6cQjFA6JwaeCQ1KRHuCpQZolr1vmAvjn71pRhIPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1750909078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1tKoSwrJQsbcYq+qY9jWj6OI+RYMT06LdinvFds3WU=;
	b=vxm0w4ASr8djym2evkXidfdpOMAyXDzaQih5K109swUSaWYfLZMJLukahRGaOBU86q8rMy
	jSkW9bJZe76ZzgSXggSR/Khv0S6FTmyhBXtau1U/1FN0nlhEWkra7ESVaIxKws96L4OdEK
	O45eRB0ZI3ZB3rhjZybgSGc+KJElgc+tZ6CwVtK3TXjnexqHYLzJeoP75rsjxfvqqBHyUA
	ijIDj+NHH/FqBHGNRPvWW5vRrYWN89ZoWfzoaVs13YmjzqXzPvP7i2AAy5bVwD1ldW3t/u
	df77sU7m0XNVafN4rEIGEd2mdzyXytzu8o/5YeXRH3jO9Ep+zVhjC802XeljKw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1750909078; a=rsa-sha256; cv=none;
	b=Imgy1gWmIix4nziuxiVOvDcZdxRBxBGIfTb0BEDscIA4uwG54yuok0h8GxPblgbDoA97vX
	pwDj+I8bALVoYaEv/gfnCceX7ukiu8Q7TdyFXoD+/FiJUReUWolei2Qheg5xFt1UEprUAa
	MNRCb5DV/ehW7AgJtBLGl1wcz0qZXT+mnqeuJb4/9oy4111FXrdITRCgrdU9sBJxf5lgTk
	YQAcov7txBwOjuTcqETpEBOv+Zyp62HkNxoryS8FCCc+wJbgG53cvMX3JiBxN12jtJXSKx
	w/i9wUe3yEVshNjBrdn49P2TTuT2c004GBxV4pErk6z1MjbMnrBkYJEG/kwjlQ==
Received: from [10.9.4.95] (unknown [209.182.120.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: kevans/mail)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4bSPXP0sXSzJJj;
	Thu, 26 Jun 2025 03:37:57 +0000 (UTC)
	(envelope-from kevans@FreeBSD.org)
Message-ID: <d309fd3a-daf1-4fd5-98aa-2920f50146fd@FreeBSD.org>
Date: Wed, 25 Jun 2025 22:37:55 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1 wireguard-tools] ipc: linux: Support incremental
 allowed ips updates
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Jordan Rife <jordan@jrife.io>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
References: <20250517192955.594735-1-jordan@jrife.io>
 <aCzirk7xt3K-5_ql@zx2c4.com> <aCzvxmD5eHRTIoAF@zx2c4.com>
 <vq4hbaffjqdgdvzszf5j56mikssy2v2qtqn2s5vxap3q5gi4kz@ydrbhsdfeocr>
 <CAHmME9rbRpNZ1pP-y_=EzPxRMqBbPobjpBazec+swr+2wwDCWg@mail.gmail.com>
Content-Language: en-US
From: Kyle Evans <kevans@FreeBSD.org>
In-Reply-To: <CAHmME9rbRpNZ1pP-y_=EzPxRMqBbPobjpBazec+swr+2wwDCWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/21/25 18:51, Jason A. Donenfeld wrote:
> On Thu, May 22, 2025 at 1:02 AM Jordan Rife <jordan@jrife.io> wrote:
>>>> Merged here:
>>>> https://git.zx2c4.com/wireguard-tools/commit/?id=0788f90810efde88cfa07ed96e7eca77c7f2eedd
>>>>
>>>> With a followup here:
>>>> https://git.zx2c4.com/wireguard-tools/commit/?id=dce8ac6e2fa30f8b07e84859f244f81b3c6b2353
>>>
>>> Also,
>>> https://git.zx2c4.com/wireguard-go/commit/?id=256bcbd70d5b4eaae2a9f21a9889498c0f89041c
>>
>> Nice, cool to see this extended to wireguard-go as well. As a follow up,
>> I was planning to also create a patch for golang.zx2c4.com/wireguard/wgctrl
>> so the feature can be used from there too.
> 
> Wonderful, please do! Looking forward to merging that.
> 
> There's already an open PR in FreeBSD too.

FreeBSD support landed as of:

https://cgit.freebsd.org/src/commit/?id=f6d9e22982a

It will be available in FreeBSD 15.0 and probably 14.4 (to be released 
next year) as well.  I have pushed a branch, ke/fbsd_aip, to the 
wireguard-tools repository for your consideration.

Aside: this is a really neat feature.

Thanks!

Kyle Evans

