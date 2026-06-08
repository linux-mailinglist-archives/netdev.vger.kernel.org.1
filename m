Return-Path: <netdev+bounces-296354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KcnEH/ArJmo3TAIAu9opvQ
	(envelope-from <netdev+bounces-296354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:41:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2966524AD
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:41:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s8lPYEYd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296354-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296354-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02D0B3000521
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8B931E846;
	Mon,  8 Jun 2026 02:41:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDF92772D
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 02:41:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780886509; cv=pass; b=qjBWsaXzFv8QFbSmVdD9NkFPOoOqaFTYcIgHeK8CiK1yYKj8CVM4vg5ODYYg7WpcKhXE2vlBIECijKAd9QiOom5HAzxyxYAj8O7CVHf6sUOKCI2xypVLCKju4oyaN6ZoMec+kYNAT7wZDUENtafFCytj3QxUpMfGPE1TLRmvw5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780886509; c=relaxed/simple;
	bh=Nh7ZHpq/XNJFdqwO7lhwAzLTRleO5YExf1Y7bkJCOWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiHhJZpkRZ+mic7fr9BvabG4liFcOvOpZxXE5k34Hj3nGMp+Kst2bhID51IjpwYCSh6f3De5XBB0RE1N8SvtFIZgT29gepKWT8TWptQ7VuldqHRkJhxhrbnxKyw0NLBivk7oJh63ZN65v+bdyp6XtVwme59j4eVdAvWKMvLQcbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8lPYEYd; arc=pass smtp.client-ip=209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bf0170c80f7so610412566b.3
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 19:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780886506; cv=none;
        d=google.com; s=arc-20240605;
        b=OS+k9O4gupaeNeCSQdblHPvSoqVkfT1Bnj36mvwL1XVNOluRQ/aJt77mG/IOPl0kcR
         BkB3HAjE69xaN5flLyUFhTKD2anL12aYLW5qSsiTQ9B3m2Q/HfmXkxRW7AnNXeFrQ2ix
         /T4A+e6GvsAZEo4OjFlF+MQ6oGcMqGeLEbaZq0QW4q2CxbBrGDpn7lFpwpAvvyZ8Vt9X
         XcIAcE3VzUO7Is6ZaaP10QCijRMvRuP+gW7cNQ05Urh7dzga88zmn1HQ59wxgM4kK/gZ
         Ec9bleTMAPF30/HpPSJI9A9+MsqZ1HiRK7hqjjplMYjWpNcT8J8OALKkvIhM9gBlbYkJ
         J4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Nh7ZHpq/XNJFdqwO7lhwAzLTRleO5YExf1Y7bkJCOWU=;
        fh=Vn3Qu57EU56adbqPBHc/tDK1r+NtNjTrX/UCn/kdGU4=;
        b=gWhB2vSlLTYvLOOOuiIaFUVe706iwD4ujD/qGW+JcQfiCD/WXFp39Ia96faZmLrut1
         isHSnr9+wVLpk9/88NC0hQYao74l+xEX9WeE+VAPx2lEVfEAMD7QBeRhiuRwnnUbn3fq
         JszogVhPDu2jSa0CoBFd5/fnA1WB994IQlR9rOWKibD3i8Sy4GyPYRlZbkIZKqErTn9J
         F/7vfLwKs+lFk+oQjRkIjzc8lHydo4UlSUYH4YKdvvTifkaN6snhvYy5ZKK7v56h/yuZ
         XQ++P+MJDoZuutcw7OrCl46sPe5Memqy+b9zRx9NMpx7uodQo0J/6KLJFWBEoieZ/puC
         c00A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780886506; x=1781491306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh7ZHpq/XNJFdqwO7lhwAzLTRleO5YExf1Y7bkJCOWU=;
        b=s8lPYEYdSUpotTeS4lD9DjfPaCiw7SfjIm5hlKnQiFuFwaZmde+3Y2w0NcukwYbNy8
         pP9wl9bZhvaB5s9Df/e0XufbOHjfXcnxf7E7NbeBgNS/Wgg1cIfUVwEbTm7P2H/dajO6
         2YbgM20ZZEC0icHEDoYXACJ5xTLwfxXluXNfI8MEB3a7ho/yg0AUD1dkLSvwJQ+XRJwt
         weoEgKaGpLoEySpSYoypWFDNZw0SEnhsEvk0DhYWn7Qi5vYw3lRop/mYoWtYDldZdnC9
         LXUOnkjw8+W5fiuFU84bZ+8YIxlR3OugoyOUEAfkLEL0EYV3PNa7UZOIA1wP6jAybn5o
         h0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780886506; x=1781491306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nh7ZHpq/XNJFdqwO7lhwAzLTRleO5YExf1Y7bkJCOWU=;
        b=N/efEi5sAfy7j0W40i7FJlDH8QklZlngSIUzdVnA0r7XZkK407R7WsJzCmjl79iz/D
         jzdau0DZtclO9fx+bosjKqwbZ5RH641uTTQQZPkyyhjIxORpIgW2QZ6pLeLVXwQhaeDC
         sBPwb8YZL/psdxqmlsIkxvMRCUJRS5jKDHb2Ci1/EsyKjx69LUEzvzAQ6Sc3pdQ6qQ8P
         o1IXDekSxoKHt0+Rb/yiA76X9B9E6vfAaSd5q9JyXPlBibhhrHsXBjq5888S8AG1nKEl
         aQe8Gluft/rxKCi0XBAGOfQ/CEKLTVUMSoWmuW6aep7IhBhur+n8O69+cRJcaf5fR2Qi
         7jAw==
X-Forwarded-Encrypted: i=1; AFNElJ+VR9If1fW7LJ5ODcGfrfWmLXrSyGqyN3o6zEyogeYdhqpvFrmeDjL2Qbq7PC0GDwk5+uVAi8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYe5ALopT3o+WMsJzkI5HVj7E6dUfRC3rIZ5C+VecfCGTAR0n
	0yqJEOr7f0a03RnuQsQgtMvmkP8F35I+TIDiNOD8dCBuMa6fwNojnkVf2szb9vZF9j85Ds3X8J6
	B3TeJfDnEEFYuUsFc6ZtQylIH2/K8Dfw=
X-Gm-Gg: Acq92OFkd38et4sFzcPx9y7S+CBO2nVVOcZBTyI8ul0ogu15uDq1gQCjeuOd/PWa6sh
	R5y6V/coAo6NkGqE9NSmRlC/NLY7dgRmqt0BIrTyjBSx+OMJo+wE/WxZAfcrV7yQy6sjRTLSwrC
	8p8pcZBa9uFaxgvKslJYg536dDOP4GtScAfPC6dLoEv+pAJOPQ6BLWs74Ntx2dyVARoEr7KmjoC
	Da+gRgT3nTh4l9AEtpO2TkpbdvWyPJffjZmwEj944raNu/hUKqPavcqnrE4qawJFAHjZiDFZw9L
	hr8GXwSx9ZwATN+tPs3uLFMakpZI4yyfxNh5k/kCueoMoEIawas=
X-Received: by 2002:a17:907:7b8c:b0:bdf:bccd:a7e9 with SMTP id
 a640c23a62f3a-bf36fba39d4mr553056166b.2.1780886506096; Sun, 07 Jun 2026
 19:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
 <20260606-realtek_forward-v13-2-b9e409687cbe@gmail.com> <617aa489-4f0c-4fe0-8cf3-55c98f4d4d9e@yahoo.com>
In-Reply-To: <617aa489-4f0c-4fe0-8cf3-55c98f4d4d9e@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 7 Jun 2026 23:41:33 -0300
X-Gm-Features: AVVi8Cdy2z9Vqfw4og3Kv21K7Vl64diqsXfUe7hpXdRDKjFHG4YNxhSZd60Rx3M
Message-ID: <CAJq09z5_q2Pjpb3XBJiyzjt=KTCqcVF3FkcQOz5xtryKXVkpWA@mail.gmail.com>
Subject: Re: [net-next PATCH v13 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[yahoo.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:namiltd@yahoo.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-296354-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA2966524AD

> Sashiko reports a potential deadlock around stats_lock, however I couldn't find a call chain reaching rtl8365mb_get_stats64() from softirq context. Can anyone point to such a path?

Hi,

This patch series does not modify the stats collection logic itself.
The analyzer likely flagged this because the series touches the loop
that initializes the stats_locks, drawing attention to the locking
structure. If this deadlock path is valid, it is a pre-existing bug.

Regarding the softirq context, my bet is that this path might be
triggered by bonding or TC. Both can invoke dev_get_stats(), which
eventually calls rtl8365mb_get_stats64(). During tests, you could
inject a larger lock window (using mdelay()) to increase the chance of
a softirq hitting while the lock is held.

If that is indeed the case, we should replace spin_lock() with
spin_lock_bh() in a separate fix targeted at the net tree (not
net-next).

Regards,

Luiz

