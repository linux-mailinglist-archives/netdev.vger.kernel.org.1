Return-Path: <netdev+bounces-257023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAA9HZ5LhGm82QMAu9opvQ
	(envelope-from <netdev+bounces-257023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:49:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D0EEF966
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8EDA3015713
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA5C35EDDD;
	Thu,  5 Feb 2026 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="U1nnWAIk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F057F35D5FB
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277718; cv=none; b=gIM1WWHC1fGdYJ+dQfNSE8r2p55Qg2GPNGP2fzzPNFTSPv6fVezGIxiKdqBI99voBhR7bU+UZoP3Vqyy3UwFWmAcI91svozDcorPArw1R3FmrAmNFCtuRd2EU0IKUbSFRFPINC9TcbU8kZ+VOxbehyB14o3JAhFp+Q1aKhH6NVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277718; c=relaxed/simple;
	bh=xfavj9aCHhLn8Hp5R+LSA8Eatvuwc4NVLQ72hf8UqtY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QSgAWdSoiuAsdQ0DiMhYwXQyGOpHMbBAcjmcMgH7a4LsoQ3iopVJsEXnF/xWYlg3ARuPmodVcvtF3ODjC/G4sLd3C2bBQ45QSWQXfH2fCWPsxNYVdGJxUi4rZoz9TlG6B3SULc+QYSJJ8+m7XoKROJMm/Z0yIKgE4yw0DJ8m/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=U1nnWAIk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so5975605e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1770277716; x=1770882516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a/E+NUfMQ2EQYN5sJynuEdS10VC13iHG9rMiWgb3dls=;
        b=U1nnWAIkNzOMlu4uRc7RDT8F5Reh9nGWBUyiJtFVisnTs6A24XIaBLPJEc0fE/Orfx
         Dg3/lnuU/BJN9NNHgDTkYtwYka4pjhu4x/iNnNsz0KS/qf5PdJauvf0MMTFPLCNZAE2X
         fvWhq1GUvZ352nWXhrdp3rnBFbET4/hCKYQvxHZjDOdEI1kV1wXiu9woYMXILEkgpP9j
         ntTS6g/7BNGEL25kLQ6/KM18UJ9C41cFCmRo+eywXAxG0WqKWdw+ULz555IpHM+mil5q
         XTiQV8s3W+KAymcqxKeYBE29i/PsZiRHN29gXln2m5bqSRO7mybf2oGJVqrh5MGHLHRz
         Irag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770277716; x=1770882516;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/E+NUfMQ2EQYN5sJynuEdS10VC13iHG9rMiWgb3dls=;
        b=C9yHvZHp7fVBzYS1PoL8/GTU5ahhxnb5EN/i2bkBhKA+mGi8h3f82NvRTmBm1+7ewv
         sB9Chqx1nm5loZC73vUsHcO+k7+XkXc/pJuyos1n+pz8JYsIcFC5jWzFWDATskgCw7KL
         31DJHVOJ0nJHcLtn/e+5hGnKcsovgBwOdUTsLLZsy0plT8HI4ed4OQHRjEgLL2hjY8OM
         xh3ZgaUWrqTcbvl8YjJD939J/Lgj7iMZFMn01cGo0VlN48q4pJa1GnRX7XK9sFzBNrNr
         n8odgU18Vg7HYlaZGUd/FCIXKBgKZfWpVs71QtNgoL/U+kaKIWqdUBSQMpv/C5GAAlrm
         tcbA==
X-Gm-Message-State: AOJu0Yy/9dVTHz7jlk5xnG4EuU6DyrX09pPGd14kP+lFPVzs8j+tCj39
	xrVR47pg45nFs25ZbzkAFyH3IKWHE9K40xCl6WGO0lF2Mwb9GeZfOAIGM6k7d5KmzHk=
X-Gm-Gg: AZuq6aLSpyfgo7sPSq46omVrvNbLe6i+9aNAYFHOfzg8nZ4jP22RjWVhQ77jzV5sVEW
	l93zCmolZ3DgU3AOYZkUtR/DyTKY+u1UIPgL4eE1XljnEN7Pa8dnQetb/EPOpMcGJQvVJbFcqP8
	KOD8RXOzl0JL10LBLkO8eqfCNYYD/E2cDBmnwmNvUsagd5nkDX/s4V5kpOrBII3DqZktwfyIqzX
	fqFpjxtOvLllqiXUx4lMrjicEvdNJpOcLVPC2IstZ7pl20dhnRlYf5oA6y1sXKTvqHH27uDNo2Q
	dDDRxpgd4vwxhh/sfJbtWGaj7Rs9ZUlVAQ4m6FAPmAdgjN6ohVAOouc2EKKOskmpH906ckJ7Kzx
	/K4HQF3lsgzpt57AX8ZdmPNca7nqybNGiaegumCbZISBZweOrjvq6hUyMvejHp86KT8YKAFvAjG
	Hr9YethVib64f5/tbnXf2NfZ067brGR2s98Nwi
X-Received: by 2002:a05:600c:35d4:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-483179a3ebdmr29550575e9.8.1770277716388;
        Wed, 04 Feb 2026 23:48:36 -0800 (PST)
Received: from ?IPV6:2a02:810a:b98:a000::b3d5? ([2a02:810a:b98:a000::b3d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d57009sm34108245e9.14.2026.02.04.23.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 23:48:36 -0800 (PST)
Message-ID: <7bbd8e96-c428-467d-8d12-cd5c60007891@cogentembedded.com>
Date: Thu, 5 Feb 2026 08:48:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: renesas: rswitch: fix forwarding offload
 statemachine
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260205-fix-offloading-statemachine-v1-1-640224a531d0@renesas.com>
 <3b1405cd-6c7f-4883-95fb-151cab223a68@cogentembedded.com>
Content-Language: en-US, ru-RU
In-Reply-To: <3b1405cd-6c7f-4883-95fb-151cab223a68@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[cogentembedded-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cogentembedded-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-257023-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[cogentembedded.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikita.yoush@cogentembedded.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cogentembedded-com.20230601.gappssmtp.com:dkim,cogentembedded.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1D0EEF966
X-Rspamd-Action: no action

>    rdev_for_l2_offload() && rdev->forwarding_requested

rdev_for_l2_offload(rdev) && rdev->forwarding_requested

