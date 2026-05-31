Return-Path: <netdev+bounces-293383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Mp+LM/7G2rFIAkAu9opvQ
	(envelope-from <netdev+bounces-293383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 11:13:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B21615496
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 11:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F173E300D903
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C4C351C2A;
	Sun, 31 May 2026 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayMuswFf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D97833F5A4
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780218763; cv=none; b=mSxE/tT/f+QDAM6/s7sVWKYTpAmvdgFN7ekys9Pt2M5WFmVV3Wdmhs3TStRI+eIj9woMjLaB/cz2RSwxCkCvyn772JcdZOLOm8A2quWKO0O2hSOVh81fBSzezziNb8kj8nLtU0LYWMCQx29Ymxd08u86WM/TKW0JgwUv0OlrT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780218763; c=relaxed/simple;
	bh=GtWMjgWA4XR7ByfF2eq+aSGrsmcmeBHRweSqRyAgCGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocUsCfnVMe3pAvIz/aRrXA1ku+xVp100NfIwLjHlbMb4H1aRjgc9t80ywLiiKZwQMwhvHoHDE/kEKHAuLcv9q3BfjHwyHM90fvSAP8+NFMXm8J6p7pE5HE50hXDs3u7N3HuMl3zqmqZvgCtbv6KBlp++vNkbyoFxO/yT+DB38YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayMuswFf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a765f2feso3795625e9.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780218760; x=1780823560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLV/vlYx4oGCZhyGn9UGnBK8+0cqBecf0ZxhiQjsrL8=;
        b=ayMuswFfQDL5u6RSHtpTCOLwK/KiXK4ouSKHihZEUlQEBGrwMy6oBGFjsRr1tKPbVc
         XWz1r0dMujZbA/HkyxUNma49Oo6V4uIiMCzMgOtNrxOliytRx/Xjx4sjCPDPuLLphbYW
         xmDBB6yMZk2rEIkiurRXPHpGQT+LSAprQUPstNTcC3F+lD8JBG7gMryHKUa/zP8KcH6H
         cKRliEv2QMkdCzDhZVgy/l8Z0+Q6GLeHzXnH8KUoizPHW31hQW7tYmriZYhVPo49Gwn/
         69xJq5Jo39EOe/mcKw2mpgYguyzulKMF+lbpuNh6jWjrtpEoHUYWnrMj2qYfr2S0lMjL
         ThEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780218760; x=1780823560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DLV/vlYx4oGCZhyGn9UGnBK8+0cqBecf0ZxhiQjsrL8=;
        b=DReyicLvvQvdp/2cG3N3ues5giv648gVsZZ4zPkZGnFkN3aA+pPaczMfK2ULnTVUyH
         GIxz8bvwp9cT/3N+LTyHNmjPLHPU3DkV8nXYaSMRnDG+atPdmoh+S+AjrwqVU5TtOPG9
         NbVaAH6pjsQrci2/tJUXF7DX6VcRFQoDHITdOiOnP/NwFJox0FcYaaVtAkrl1lulvqWc
         QTRmYEIAR4cRRsq2/xXCyLErtwCA5C5C9nMM0TDRsjvwS9u+gmi+2qq38j9ievuneYHK
         1/yd5+kYGYUNefLlotSMVyzV+aGpXm86xAmbOHe5Nf+xcvjTppdmuQgmhplrYjQIlO6G
         PJqw==
X-Forwarded-Encrypted: i=1; AFNElJ8DnL6etswJeUeZlaRpsRzAJbUsJ5WIZpGcyrUaTSmdLvnYLag44dho1LsX1aspgkWAzUbOHGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbFD8sD5E9P3Jitk9UwKVsOp/J0V9vXkyOiNkE71eplMKtt6nY
	l3dUFeh+p5VJD6VXPOgNAWMIJ1I44kxFnZtP8Rz1WH3Q3x4uXX7oK5Zg
X-Gm-Gg: Acq92OE4YOkBGlVm4GrdbweS4b9DeRvNaWHRitQMxlBAn5tJ+ebmqSK3nB8mVJRLTv8
	JWbkkoZOofnkHKm32TGJqnNGGzx3lX44Sz1ir+DpeQz84nKXYGyWLl0nJ1+oAoodaVSdp3pLWcV
	WqCkunvED4bWw3I6mhPOQ0k22GALiPRWOpjlEajx90sR0DBIo4Eqk/i662fbZ6FTHtgo6pGgOe9
	3zG3RI9HkiGowvStpXuLiM5vnLflXhAAenEqwj+eWGFfBH876DVjbXGnyHHQIA0QN8DGh5MJlhJ
	kBYp0CWNspwj38BEDeLzlvj15UVmgDqlwSW1ezDpHiPMPQlcMiDY52PqlKGDtXW6yef5diswC8W
	+ZduqXQTXQRPZtc1SD3sjVHFbDaZpjEkit+Bq7HJO7AR3PzOf1SVh8g3Vk6BtMe3/ARyCeNMZMf
	R9rj06nsSPkDnqF4FyYEkVxH7QG4Yer/wOX7cN7n2pFROgqli/5ZaloQREIEIOrq0qHGZf2tE=
X-Received: by 2002:a05:600c:3487:b0:48f:e1ac:c94f with SMTP id 5b1f17b1804b1-490a2918103mr129996915e9.10.1780218759434;
        Sun, 31 May 2026 02:12:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f3612sm168254415e9.12.2026.05.31.02.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 02:12:38 -0700 (PDT)
Date: Sun, 31 May 2026 10:12:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Manish Baing <manishbaing2789@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mctp: serial: replace memset with
 zero-initialization
Message-ID: <20260531101237.13c5580d@pumpkin>
In-Reply-To: <20260530224646.160777-1-manishbaing2789@gmail.com>
References: <20260530224646.160777-1-manishbaing2789@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293383-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 21B21615496
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 30 May 2026 22:46:46 +0000
Manish Baing <manishbaing2789@gmail.com> wrote:

> Use empty brace initialization (= {}) instead of explicit memset()
> to zero-initialize stack memory to simplify the code.
> 
> No functional change.

Isn't it also entirely pointless?

-- David

> 
> Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> ---
> Changes in v2:
> - Fixed a compilation error caused by a duplicate variable declaration caught 
>   by the kernel test robot.
> 
>  drivers/net/mctp/mctp-serial.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
> index 26c9a33fd636..df721ca4e07b 100644
> --- a/drivers/net/mctp/mctp-serial.c
> +++ b/drivers/net/mctp/mctp-serial.c
> @@ -536,13 +536,12 @@ struct test_chunk_tx {
>  
>  static void test_next_chunk_len(struct kunit *test)
>  {
> -	struct mctp_serial devx;
> +	struct mctp_serial devx = { };
>  	struct mctp_serial *dev = &devx;
>  	int next;
>  
>  	const struct test_chunk_tx *params = test->param_value;
>  
> -	memset(dev, 0x0, sizeof(*dev));
>  	memcpy(dev->txbuf, params->input, params->input_len);
>  	dev->txlen = params->input_len;
>  


