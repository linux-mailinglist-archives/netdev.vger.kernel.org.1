Return-Path: <netdev+bounces-256195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA/nD+S2gWkrJAMAu9opvQ
	(envelope-from <netdev+bounces-256195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:50:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B54D6616
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 09:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0E3C3022908
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541DC395D8C;
	Tue,  3 Feb 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYTqh5e4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9371393DED
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108610; cv=pass; b=WOldgutWXSZlbi7rjh/M3BXJX9S11s2EfcjEt+OSrjkXVlOKG7MXR1kUTPpsYbpXQBO3Ber6gDPWt7hqTMusmiz+WIJKZh2KiU6ETsjbgkU7U5zfpYZ0oEkjWCPkIv/X1aJu7RgSCMPlN2hkiAg+GzGrKhNeuu6Yh35L41EvyA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108610; c=relaxed/simple;
	bh=i+dCt4DeKmE0vkJJ36XHq9U/eP0bq1C7KWOcgsKggKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eqt+42+W52ld/VEMZm4Zqau2o1PlFjw9Se6cckLp69Q/9A5Mw4bo9Kh5dbQ2hRYAtN1UO1gYbfY6HhUmSsgmJjkdGfNa9etMBWec9BLKhOow3V4SsYOsdTqEfr9XPapRnkCR5bjzW1hM33pIySUkkR9TH07KIMn/aa742f3SyLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYTqh5e4; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88ffcb14e11so74623346d6.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 00:50:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770108608; cv=none;
        d=google.com; s=arc-20240605;
        b=AYmDYSanzAjejO5HS9tMKVh2uH6ceCRH5R4hygcjB6Nh1U0eWBHE6Ecadx5EykoXbZ
         W9l3M65EAsxxm+KA+5VTQaGbmg0KdiSEM4QcTpViqyBDgsZoSYCoUp3RWEXlq0erhl7P
         1JA4SNY2pY67oi5iJvzw1aSMM1vdZkhJ++fRWN8g3QeotW2qg5UH5qp/rhUZiXcLO2lL
         Pqf6PY6Jo5xs87PfwGFa6jCq1ifPd0QfkR0SlLZ/lLs53QjPsULRWznVFjQ5ZVI7Ds2h
         FVADFfp5sXP3Sqshf9OTthvQqpNM1z9USCk5FxsUxvFnkUHz8ClxZeST/diTIOlQ9+Bj
         LC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i+dCt4DeKmE0vkJJ36XHq9U/eP0bq1C7KWOcgsKggKw=;
        fh=DMgw9SLMn2nBkTHvTdn6wIHE+IqrSQNe43UzrjjDBmk=;
        b=gx3Q0DC8n24xnlOmFSnaDK4Ty366+TXoT9C5tOpGQWBGJNxqZAfEdtVSRCOCoFi52c
         8CaZR/Cut0GDSLYSo14yGPHyP2amcJMFMbxQAIcnHI6N/vjbQfjMRE9m+8HHPi62x0Wo
         GPdOKUCqskYXbkCHbXjhcd2QZE3cqU7K9F85zgIJEUnyWMj+VnMA/1ea/3jrftsH+yDV
         TEa/nkuspKZJsxCduyiLV1iXtu6unyrQFFtQPkt72MYcZjnj3NbNs5S2nhVZ7x/NHzzM
         fc11YccuJY43qqqGragYXnfIE670MS6TkdxzucLzd0E4IqQiN6qqMiupdbKBRX8h8Pf4
         7ZGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770108608; x=1770713408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+dCt4DeKmE0vkJJ36XHq9U/eP0bq1C7KWOcgsKggKw=;
        b=aYTqh5e4gx8q2j0Tnslvr6tH6jp+WMgl2bSf15QPzb/B9GIBoDcRVVbN/8fOMr47Lf
         FhjYrSKtDs2+/NpU3IXJkGdhYPoEqN+qiKE1/UZ2HFerFAH8S1fWuu6lyt2WMCuXDu24
         uBczyOW1VTVHUbq/16gAXLkpM0nE0t8XuInwYaLRz41bjcmOjUerpzMi6AMxdHHfjuZ0
         /DagcOOHeIkL4How3/zP3+HaMEcbDI8RhHTkloC3/InAMOj4yuF/T0D/lJc1obrBN909
         fqi1N3VWZbCESIZIboxAuJjF88XC6ZTe4DMaL+Do6U3a1M1wt00XeqXa9/yb2qL+hkxB
         jHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108608; x=1770713408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+dCt4DeKmE0vkJJ36XHq9U/eP0bq1C7KWOcgsKggKw=;
        b=WDKIJtoUA8ocbAUmL5Bkuhlct0lO6muc/6V8iJQen3K5lCKicaKfPkAi79KX8Kw+Po
         70AasNSoAsW3hdRpy8T+8//F+ltyJ3nmKU7crBSjjLZJdc2IljPJwsZ9Mrl1R/uPjJqj
         EtjhTLYfdy8vIa/LJi3eTSeCQc0w/Ss5NUfkfBqZEucg4gTQh5ura+9VFZ4ediLk6GDb
         TzHqRIieE5/fWl+piYYr/MNlnib77mjj0IMHbGIF/qHDn1SEzbItIveIFSKP0uqaAKdv
         y5rtxcx8gIXJDZJt4RkiHlIX+HEvUquwGTbyYO10L4rv8+hc21mcIva7gIU+MtNc184W
         bt8g==
X-Forwarded-Encrypted: i=1; AJvYcCXoq35Fa3QLOuqh0juGtvqPRcHfLaLmtM6NXWDj4TfYhuRAVte6BbbCPPTE/RegBumP1CT5dHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Xxcbb0aTi3IRElS7JIuf3iZqZOPgqStn7RqsessLTFiRkhMo
	8Nqi4zNhmVz0lzJJbTkIxQP6z5Nr2nxplnjEWzEk07PU6YHlkzXM5GbcctmeekYJThQTut0/6Hp
	dexdD9etPtNIx6Tb2anPM3hNvx0bpK18=
X-Gm-Gg: AZuq6aIbeFjtrskFxu/oAFCuMVOL6iS3GbvrORObQNVAIW0hIKlIITQT8i2CzG+0/Ya
	ZO9kTF0uodeYw4a52gVOKthVA7bbFzSOZwpVUWKg1bAqqaWjHzySA6b11rTF/RhLtgPakxbtUHC
	eNAhi326opaWcORwZZ2mkrz80NJ5GyUJan8no+C4Onk43uF/2ppSaAwEP5yZ3zWTsWXiXettt57
	sFueh2Xkt1qVP0+Ub3Ze/EKYMBFhixu9wkwiQSBdv6vwUAG+Ka90AFTWbrIAVGUxBRg+ALGuYjJ
	7ezXawZlGqfndwnV8aieqNc8gwH3dnDkkbe5ufcGKgc41uQpjlXTuBmP
X-Received: by 2002:a05:6214:262e:b0:894:610c:3a22 with SMTP id
 6a1803df08f44-894e9f99fa3mr206356306d6.20.1770108607720; Tue, 03 Feb 2026
 00:50:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203013517.26170-1-enelsonmoore@gmail.com> <aYGw80IvE0TG7WOx@smile.fi.intel.com>
In-Reply-To: <aYGw80IvE0TG7WOx@smile.fi.intel.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 3 Feb 2026 00:49:57 -0800
X-Gm-Features: AZwV_QgXt7IS2wkY_QcWhvRgLnL-HnrRbnKcnppOhB9zD-eHSPXSoomX_beDp-U
Message-ID: <CADkSEUgmX1tk-qJ7ee=P3EYcvriW91nVJZ6AFDpVEVjj7O8pJg@mail.gmail.com>
Subject: Re: [PATCH net-next v4] net: usb: introduce usbnet_mii_ioctl helper function
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Korsgaard <peter@korsgaard.com>, Steve Glendinning <steve.glendinning@shawell.net>, 
	Oliver Neukum <oneukum@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Max Schulze <max.schulze@online.de>, 
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256195-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8B54D6616
X-Rspamd-Action: no action

Hi, Andy,

On Tue, Feb 3, 2026 at 12:25=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> > +extern int usbnet_mii_ioctl(struct net_device *net, struct ifreq *rq, =
int cmd);
>
> Do we still need to populate 'extern'? Can we get rid of this redundancy?
In my opinion, while you're right that it isn't necessary because all
functions (unlike variables) are implied to be extern, the use of
extern to indicate functions that are exported/intended to be part of
the API is a good idea.

Ethan

