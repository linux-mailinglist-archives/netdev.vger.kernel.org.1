Return-Path: <netdev+bounces-72838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5563D859E8D
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65041F21835
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAAF208B9;
	Mon, 19 Feb 2024 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lOda6qdC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="51KM5Edp"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2D225D4
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331925; cv=none; b=i6/6s47eqw7ehi4qZr+i78U/1f649k9fMC7mOSDnHh0+WqpXNV6BrH0MwxlCMaE0zFbyPIiilQQM6ohOLJW+Erzme01nqGpj/YB0GgnnpIpKGbiVD9BHhiqZ7KQrLT0T3ygRnxsD5U2uwN05d7GIK2T2KOimyenfWnUtyIN/giI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331925; c=relaxed/simple;
	bh=zx08zyV/W/+pOe6mtk2PYCJK7IbBCR6oK0nd5KZrmNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CkEN9mw6TDsLOGmxKaPkBW+XVUWEz3fJvr++r4IWgGTXjxYZVtafx7kiT2QFGbkNC1msV9KaQScC/TJ5n2Ik+6k9bP7c3mjqN/wCLK2SazHvAnSCvdZ9KCwQ6CINSVFZNMVLrOIVNkxd8t04T61jj/uuRse1Gm6JC3y4LO/z124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lOda6qdC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=51KM5Edp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708331916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zx08zyV/W/+pOe6mtk2PYCJK7IbBCR6oK0nd5KZrmNo=;
	b=lOda6qdCzGaosLAUUd1NQQetdaPZLq+hL4Tk0jNFTBUOyThm9wCDwtdUhKaUR9tforhTkp
	Hjx2dNIKECvjUSho3UzI8baiQZuJ3eeZ7HlITyrIY2KCIxbbLsw7o0n3Jw/+a1dUWEVhSq
	Uf3JP3fg19nRvlkJcflnXzm2G8OXtar7+nr6pgawcXtWLYeEnax0hrdwzq1SwkvMIXOkhj
	O7SMdsaRupz7qi10RtHwfj1gp66VflPEMOMWA0WQbxE7Hblgy50FWVQOTxgO0IfV7QrO6l
	Y57nYTF/Kmftt9RG116qSYbtl85FrgyGK4cfbrkWv92QxGkK7e1N/Ds2hOUM/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708331916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zx08zyV/W/+pOe6mtk2PYCJK7IbBCR6oK0nd5KZrmNo=;
	b=51KM5EdpmV88DXV/1A1jVxmnd0MwxMQwWpTy+k+9JOY/9yTruuQFDu4U0vxemRAJZ5Rk3i
	/p4x8+ozf3QGmPCQ==
To: Ferenc Fejes <ferenc.fejes@ericsson.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Cc: "vinicius.gomes@intel.com" <vinicius.gomes@intel.com>, "hawk@kernel.org"
 <hawk@kernel.org>
Subject: Re: igc: AF_PACKET and SO_TXTIME question
In-Reply-To: <ea5f43e1c4c2403211f89ab014c88a7af4fe53ca.camel@ericsson.com>
References: <bc2f28999c815b4562f7ce1ba477e7a9dc3af87d.camel@inf.elte.hu>
 <87y1bn3xq6.fsf@kurt.kurt.home>
 <8b782e8de9e6ae9206a0aad6d7d0e2d3c91f3470.camel@ericsson.com>
 <ea5f43e1c4c2403211f89ab014c88a7af4fe53ca.camel@ericsson.com>
Date: Mon, 19 Feb 2024 09:38:35 +0100
Message-ID: <875xykalx0.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hi Ferenc,

On Fri Feb 16 2024, Ferenc Fejes wrote:
> We simply placed the ETF qdisc as the root qdisc and assumed that this
> would enable offload on all TX queues. Apparently this is not the case.
> According to the code, it was only enabled for queue 0. Another mistake
> we made is we used multiq qdisc with skbedit queue_mapping without
> bypass - which works since the tx action is executed.
> However, with qdisc baypass, the TX queue selection for the packets
> sent to the AF_PACKET socket looks like this
>
> tx_queue = cpu_id of task % num_tx_queues.
>
> With taskset, we were able to explicitly send packets to TX queue 0 in
> the bypass case, and that essentially solved the problem.
>
> So we switched to mqprio and enabled offloading on all queues and with
> that we always see the delayed packet transmission with launchtime
> enabled.

Glad it worked out. Thanks for sharing your solution!

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmXTE4sTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzghgxD/0S7kYTRMECz+VJFWvzg0QuWSmbXtWc
/DBbz9qTASF8U3236SUHdF7BwBYDell9rhe9cOUsoNlvICo2t+3XQOwOdiiNDVsm
FjQSoUHwF/uc4edrGNia4Br3mRGiugcS+qpuNkSJOjR+DOuCeSXbzNOY1KwXcb3U
bHtPbOc4SAMsD/xueMcFG+XLICCjo9ny5kghkyf/kHPHrSXtPYy1eMMv5y62dAWY
i3HlxPYcJS1oQvkHHzMl+wpcRn9WV+zts/LPa9I6CY1ZvO8sosrHkk4Sm92O7H7B
QkrNAfLM1EfaJmzwf/G/ug11pq8h9cZuygHnZ7L6bciee1+p4NvFZLTXtunr4uyM
dLrbjMbxqvsSzwAn9jkk1bFKGPcbkPzni591nCXsgxae46sfCXOiywivs2q6F3gT
Ijy0QEgrevLpuB8GkdYCQ2j51VnPm7fFY298xnk6ngPbqeSuyEPoq/Ov7Ab5TGh+
9HEkCxQMrg1ODR6buoz3Kk+YgTXD+CojJIYqhjStsCsvr1gM2VVI2Yvrcba5Bk68
GZNKJrpHSrbboxG1amymNVBBG5j83EA8JPLQNzsGx/pNB33lwom40B4yysxrKw8x
GfWCGuXuWwaEwuGHgGUMt78EmvOxZGkLzUOUXaUCMWnUOhiuzhHb6LYpqFfYnbx3
+hAqk07643E9kQ==
=U/Lm
-----END PGP SIGNATURE-----
--=-=-=--

