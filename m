Return-Path: <netdev+bounces-264318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMPZAyZpqWlN6wAAu9opvQ
	(envelope-from <netdev+bounces-264318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:29:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F73210956
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DD123013D72
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FBE37B014;
	Thu,  5 Mar 2026 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="iaQYZEYI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29607317141
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710158; cv=pass; b=nIbtSaak3qa6JhVLXDVE+/EhPyiTCnYuQNmzSWRoV1FcNuxOFXNWrbdHDE/OWGnHhVNpVhunSh/Z2lgS6XnjZcjG8CzCa2BqsW7sk3+8pG3g3Dvrdq/jFLtTQlhjTmO2wOCvLCPM6BMiP3lAmb5UIAQxwFMYSSjgehim78ZqLQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710158; c=relaxed/simple;
	bh=Nys8raayuVlcxVzOcXi84kM39y7/W/YKbDErQB+LHiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1Uutu+ukis1B2KXaaezSrYEb93uqJUD+97tvOqM8t7lRPNPYh0CATxNRf59DDPEg/q7e0d8lGQEtnNx7QOYnxrSuWhpAlox4XOja1doxSBDBrkaDEMl2vsclE8MNOiP054WBPpivVYNWb8nKLHYFWAAmzyccHgX0rWIB9A48RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=iaQYZEYI; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so90145395e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 03:29:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772710155; cv=none;
        d=google.com; s=arc-20240605;
        b=FHyHuJZw5SKL26xe572i4HCoyGWWZItsasVDLk+MqHXenSOvK1cXLPkJYvHw/bGYXT
         rV3sZrdhOu2YTN7dv/PY2kWu+DwwmG30RYy3iRHFEu2teT283DE/vTdNH6nh/P/01ec/
         AjhykM8u+u2lE8aYk3batkFS9WkBqSSmxmLO3dUUqmsqMQ5TjhB8hMzV7Nt7hCw0SET0
         C/XtwmGyT7w+qEStEE7iAtoyx/ncEx6Lilg9xd0PHs07g57egxLfgfkc9r/wdW9ubo2L
         FjPNP/eYMRtPs47Xp1jrxyjxMI159Gq74kmQgi6qWhSxzM8cPvOEhXiZpbYQ9MULFquo
         /lbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nys8raayuVlcxVzOcXi84kM39y7/W/YKbDErQB+LHiQ=;
        fh=kro+c5z375bDk4XWbyWVf+sf16huHOXPkLW+L3efB5g=;
        b=VB5ECWIP9M2c1OdXWfHwOSbNkkWVRFn8VGeS583XUSFO0pA3EBd+jJ57PyEPqFLW3a
         W1TjrEJ7kTRZNdiUjiBN+reMrAeUx5L/Dbs0RjbmMtSj+PU8x6Yorn+xSGg4grgjhZe8
         vpRL7BGHPa23fNcVkEixANCgai4BSnGqOmTi1C0OTwVE3P6lTL4hyBnAZvyPZSvfpsCi
         jDB2o1x3qEA7Rm68yTfVnzyRmOJorGVd9H0WjBL/5laD8a8ePfGUQGLg8clPohYXpPnY
         L5djLDHDd4p+JbyQBNGrPtBs/YA3P3NzDNUpsZhN0GCAOr6ECbVx8SwK8tKQdHwaWZKg
         Jf8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1772710155; x=1773314955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nys8raayuVlcxVzOcXi84kM39y7/W/YKbDErQB+LHiQ=;
        b=iaQYZEYIAutXzqwpfNDuyTxY4Lok985hU2ea5hYXt//QRV1EI844EeJX6j46E1Os8B
         1QU8v4N0kAXyMQZfwLRtM2jx/o5G0Dl+8N1fW0CSPkMAAgoR7n/OvYk7OX2V7Nggtydn
         3St0uBXNRAMaEa4PvM+k2LeJmStQZeNvwecjVK8BBf3aOZSj/aHR9mS2sEGUhnZOJ3Dl
         03sHSfp2YNiKM/QLtRAz+/okOp8OOEnA3KywmTtzwkNdGhji1yer3RsC9B65moINH6JC
         1XxRMTlfl+Q3oh8Ysx86B5nfh/aIA9bqgCVrkz34MOV614UpFnvq2D1O5PPJV2gzVLGi
         VNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772710155; x=1773314955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nys8raayuVlcxVzOcXi84kM39y7/W/YKbDErQB+LHiQ=;
        b=t2drYs2c3iUxz0VYqr87B9ZU1KAxgLj+8Wfu7r2t+i1T+CiQV9MzkV+2KZUyI5AUQ3
         XoIkxw1PU+G6s0SnLihTP3yl6aaa4qSuBcUW14b0pkfvpAFIb2ojIgHf3/vSEgT8bXXa
         V4R9/h9042yNlbwTxT3Ieht7wXR+QKK1zbbYb3GwwHkDoAQFthSlOBYD5Sa3YMUzLMsc
         XOXM9Y8kBw+/i1uemBixXHvDL/Guz9fk7oESUfWSnbMH8a0I5j1q3XLs6XhK0ETYA/dm
         SJZ8xC1AM6sg+kAOdnTqLRZfNpAPR5p0QUCzK/sOFErJNWmc1SzC2do41dZOHllzzMjt
         JeTA==
X-Forwarded-Encrypted: i=1; AJvYcCWsqTw/Y1dwGFZHVVeYKqezQC4I/LP8iKebbIUKXovwSahIktYO9eD7EArWe37nAXjkuNkoN2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TTqoHxXO2S9ywvB06auqT2s6YGCkylQsjl4ZOuxu6eY43TUP
	u7q2MR5HNbFlCaOPUscyNc6ze3fGItsgZJ+g3e8Xa5CqBRnGFeqvD3oBlP0xWgzTckLwmSfnwFr
	EPTROgnm9d/FwuI9JN8Bh164jfS00kTjoUpAwrKPjxw==
X-Gm-Gg: ATEYQzxSWrcGTJigu3vGsry+7JH1fbFUi4jvQtatO2xhAO3xS/csS/XlZwIBR8z9/4w
	wPabLBLWRMa7PNQ0tHkQhJzHxciNe7uCQn9W4lbxeVivYFg+6XEXKJPBCeMQpBtKlwSVZdgdkQZ
	BB/8YvajH6IGlNFcMc0xMIHzB7j6Jyg2H54t1ZDeglg6pCKOrKomvVK8AVG6nEWKoDhlwwrAUK4
	SbQsIah7DUC35lT7yuslBkh56zJdnNZHH9vt+fWOH+Uug/sjd+v0BPX1k73QDH9d3FKqH7VIpaC
	dGY3/FhhVA==
X-Received: by 2002:a05:600c:4ed0:b0:483:6bb1:117 with SMTP id
 5b1f17b1804b1-485198a5a49mr72430015e9.32.1772710154892; Thu, 05 Mar 2026
 03:29:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305092706.145085-1-kota.toda@gmo-cybersecurity.com>
 <20260305092706.145085-2-kota.toda@gmo-cybersecurity.com> <CANn89iJ_NGSQkSZHNh_vuk9ftex4YCXJ0TMEooHMk4c7ejsjtg@mail.gmail.com>
In-Reply-To: <CANn89iJ_NGSQkSZHNh_vuk9ftex4YCXJ0TMEooHMk4c7ejsjtg@mail.gmail.com>
From: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Date: Thu, 5 Mar 2026 20:29:04 +0900
X-Gm-Features: AaiRm51aHTV5Md68Iqa1exMpOoPPRKpn9cxzRkAqu0c0U--SDGHWDyLfioMBDUw
Message-ID: <CAA3_Gnp9y5eHP1MPk=jR3V8Fs_vhsQUb_T-BjLFTH8HOHjBQvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: bonding: fix type-confusion in bonding header_ops
To: Eric Dumazet <edumazet@google.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 65F73210956
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmo-cybersecurity.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmo-cybersecurity.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264318-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmo-cybersecurity.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kota.toda@gmo-cybersecurity.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmo-cybersecurity.com:dkim,gmo-cybersecurity.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

Thank you for the suggestion and for taking the time to review this.

I have sent the patch series as [PATCH v4 2/2] net: bonding: fix
type-confusion in bonding header_ops, and I expanded the changelog in
patch 1/2 as well (not only in the cover letter).

I would appreciate it if you could take a look.

2026=E5=B9=B43=E6=9C=885=E6=97=A5(=E6=9C=A8) 18:32 Eric Dumazet <edumazet@g=
oogle.com>:


>
> On Thu, Mar 5, 2026 at 10:27=E2=80=AFAM Kota Toda
> <kota.toda@gmo-cybersecurity.com> wrote:
> >
> > Add two members to struct bonding, bond_header_ops and
> > header_slave_dev, to avoid type-confusion while keeping track of the
> > slave's header_ops.
>
> I suggest you write a detailed changelog.
> Perhaps get help from various LLM.
> Do not assume we have the context now.
> We receive hundreds of patches per week, do not assume we have
> infinite time for each of them.
> Help us.
> Please ?
> Thank you.

