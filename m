Return-Path: <netdev+bounces-280668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN3sKdfd6WmNlwIAu9opvQ
	(envelope-from <netdev+bounces-280668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:52:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC3B44ECEF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82C4930072A0
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A061D3DEAC4;
	Thu, 23 Apr 2026 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="pUZJ8S8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116B3DEAFD
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934350; cv=pass; b=WiR1XlEfyIT4wwQ5o4H7dU+tVcC0lhR9C4atdIBDIKwSZs8Xiu2ZBMwF0loXyhNDFymsFn96Nh8RlYNiFQGC2s/dKxPQPVe9EEmFmy11t4b36ZBP22SgPf0QZkqLnn1zFqnMaqzupHxpxTTh2Gr6fLzevEL8bg10GJFDuDCuShw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934350; c=relaxed/simple;
	bh=QjsImxEKuQXmmT3bV+BkuZLjlWzEvsEVFzbyIuMQhG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTe2+I7HpH31rntqYX3MP9U7eMmK5Jn6JMmVd4vNM6IEkBySr90MuOVWojZfsRDiHLVD7Tzs2krRoswgGfrGJYhSoDUBun/91miDPMSEfYhmlScClj1uO7LQBzsPJAqvaN36An/up/YkW9/JVkXFUuFPLgpUtr2gwdAA7GxoZJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=pUZJ8S8/; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12db63c6df4so3316115c88.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 01:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776934347; cv=none;
        d=google.com; s=arc-20240605;
        b=LJsqvBO/9q9jLKZpESdkPMd2vINwxVZic1DQEuLZOgTAMNVpeX98T8ZfnJpnLzM+J+
         QDR5K1UpwOTZPecbryX9IhoE2fDw+t0yqr1ydByU0MmmX9UEhHFmIoyd4QY7ji2+CC2N
         whB/WlJSDt3U1RA2u2AqgD97TnfFaSKdOI/oO5NLSNoCTZFDA9bVoyGDLZBiAYMY0Ncf
         hzV0bISwpAL43OPF5+cMdsuiqQqZrRXrU2OV/uIzdQRMJNfstyF5lT0GBI1ryMARlpcx
         aLPSbz3pBIdJm3lM0hEHXZtE1GGJP8iujr6d8EYTbkFo+sKvF8Up6uoV/gS95lOb+7O+
         wTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QjsImxEKuQXmmT3bV+BkuZLjlWzEvsEVFzbyIuMQhG4=;
        fh=ey4cE89rXVwc/JOIwvE5JuX1wWkmvlo75w1HIMlh3NQ=;
        b=OxAURWjn+BGEqLoWD8slHb8ukoboKA645B1gEI2+po9oc0+lxWhDguGeKeMmgqW+wm
         Q7ynig0g5gQ+yHViFpubmZVqWbFQdSZ+uQZccorZRcxyRcUAUxBm/uDauNzwZ0wUkOGq
         zGd/oVgdM4qP7Za9oYPnHtmm8exHoWBzhfQ9gEsli3vYU0Ng9jYyqLbiF4Pb1mztnflt
         Yg4Q/9qelCEtdZIIS6ARVIR5aSRO8pWD6T4uEO2DIDpN4WQ7VxwdYFLpNoyo/86gMSoO
         cGtw1ybBLERUQ+7gTdz5XMXEfnmzZ1HNzfmxKUiGbMYtEZKJkXzW4j8E+8UwbyyN78b7
         3v7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1776934347; x=1777539147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QjsImxEKuQXmmT3bV+BkuZLjlWzEvsEVFzbyIuMQhG4=;
        b=pUZJ8S8/ORkDJdutzA/cA5/yLYsm85LJdgN9hFU1NQCc5SJUIlAXiQnVE8uF778b36
         vcKGpdflRYQ78Bx1gY/J9F1WwKkMfiZNVsoF57Rn3yYSLEqp//ipqahbUhaUn43kl9dy
         AoKvPP7SYLy2t77vg9zVRcY0+sattdoMkyWm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776934347; x=1777539147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjsImxEKuQXmmT3bV+BkuZLjlWzEvsEVFzbyIuMQhG4=;
        b=X/bt6uS4ZxB7Me6i/jgBCrwRS+Mk/SaYNZhoUneB5yX/f/xmbQgHu1D8fm/fFBjoRj
         LkNHfM+BCTFn6GT+/AA1eOpcOFZ/vqgMDC4d7BD1uXePe3diZ2DuiapfkqH6g8IT8Ytp
         0fx82kZ9cEfOFYcpjRGJ14efMlo0EMv3krBXB7I92mNSImjguelmlDN0+B9Z4ouXuAhz
         kCUjNM9qutxAmG0ruJM6ot8OmkzGrm2z8BLVRUfpE5pzWlgZhtFKQ4bL8ChD3v2UgU//
         pUnrFv8P7o6JtPe3zvC+9xzaL5Qtilr+0mIsAQ4UlClMvAxCxMMoubvZKtW/Yikp8YZ9
         sExQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mmvw/ZLD02h3njDLJyHBfds3ZvMDLzCHOZKXUHyGeZazJqp1bSCMTz6hiWSATWpNuqXcAi24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69oAYVarf54kc4da1Dt50IGc+ZQuDLxVvOKXuxJHocGkb2u+m
	4P1/cIEAM4c0oYnjoT4WxK74GSttTIGlG1bT4cJM2GbqPSNAbpVTt8U4ojUbv+807vRnspi4pfK
	M753O+X8D5XvKRfA8iGwzhDkrGksYOuNAA3QNaWrPXw==
X-Gm-Gg: AeBDietq32PJD1sH3MkA7g5cOdbOn/viAEGUyJtxyeCW8R+u2YUFmUW1t37MZpRlje8
	NluElo0KeLa/hWxiq/ILwZV4jUZUJwaSmUwikLjrfMVy2pfppJjHrHZ+fXKXFCwMOycbeMh2WJX
	DkEznCccRH/YKFVompNgDom61Fw4fBS41+MZlvT+bB+8OnqVDW2gJbcnEzkhkofz9o/o9vTeXX0
	N/MbyqU4RSk9Dt1cgBdydNGRdIu8xcgG0F8/7z0g5IYI74GT6i1pz9y9YcEnBZiYRwlHKSonmck
	DUgNZnkY9Ccv13rVZw==
X-Received: by 2002:a05:7022:383:b0:128:d4db:447a with SMTP id
 a92af1059eb24-12c73fa73e6mr14286081c88.29.1776934346915; Thu, 23 Apr 2026
 01:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch>
 <20260422-v7-0-0-net-next-driver-removal-v1-v2-10-08a5b59784d5@lunn.ch>
 <CAMuHMdV-vF6sTvAi8kKzxGwZ9YUSBO1Qta5PDCRbA0zr-LEp_w@mail.gmail.com> <c0c80113af470b265650405fa24deefe2d82ea24.camel@physik.fu-berlin.de>
In-Reply-To: <c0c80113af470b265650405fa24deefe2d82ea24.camel@physik.fu-berlin.de>
From: Daniel Palmer <daniel@0x0f.com>
Date: Thu, 23 Apr 2026 17:52:15 +0900
X-Gm-Features: AQROBzCE5_am-yGAVd6HVGlMuKn48vLDnCtCy6OhnZNL7yJIJYBvslDU1PnlxZI
Message-ID: <CAFr9PXnECog56b+Jq9TBohhQ4oBB3hGV1pHj6OstOSLqkOpcTQ@mail.gmail.com>
Subject: Re: [PATCH net v2 10/15] drivers: net: cirrus: mac89x0: Remove this driver
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Lunn <andrew@lunn.ch>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Michael Fritscher <michael@fritscher.net>, 
	Byron Stanoszek <gandalf@winds.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[0x0f.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0x0f.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280668-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@0x0f.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[0x0f.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fu-berlin.de:email,mail.gmail.com:mid,0x0f.com:dkim]
X-Rspamd-Queue-Id: BBC3B44ECEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Adrian,

On Thu, 23 Apr 2026 at 16:10, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> > Macs do run modern kernels.
>
> Retrocomputing still is not well regarded by some maintainers, it seems :-(.

I've found bugs in drivers by plugging those things into exotic
hardware like my Amiga 4000 and Ultra5 [0].
So, it's not totally pointless. And having a shader capable Amiga[1]
is pretty cool.
Sad to see fun stuff getting pushed out by basically spam bots. :(

0 - https://lists.freedesktop.org/archives/amd-gfx/2025-October/132283.html
1 - https://gist.github.com/fifteenhex/0e5ce8c1614bcec20ed242045c11d1d9

