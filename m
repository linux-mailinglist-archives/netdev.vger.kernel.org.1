Return-Path: <netdev+bounces-255223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL/UFEv+fGnLPgIAu9opvQ
	(envelope-from <netdev+bounces-255223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:54:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71542BE004
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED0A3013D5D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A613859CB;
	Fri, 30 Jan 2026 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWRzxukW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6C32E120
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799238; cv=pass; b=X4VkqWRCWs2mDgDXzgM1pDYJMar/ItzIzojxbnw52I4GikVeBkNG4JzfOhv3X7VH5lDNqMNotQs2zvvHfHE05WL3zNRXRlKsueaThDtT/s3NZkf578aAxTjF+2553eY2yZAQFkXQ2jTdOBhYBop4L3zD+cynxUoBgUkEO6aSA38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799238; c=relaxed/simple;
	bh=Yn9/aL/X+9O7klMy4Ik8tAl6jzXG8GOxnYP5QqAkigQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0K5RVSV+/wIK1yzDzM8s7rgVYZdAoRtBXZ8A7hPG53MUMJ+TrKmc30E4dHNZ0B1utFyTdZLan01gt3vDlHazpalkZSJHXpQxqlR8NMEr1ITN9rzVGHbKRrSX9jHA9SBjIsS6DcxAvcrgOcroCD4BR0u0/2P1dMMElqPFXpdJRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWRzxukW; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8948273f5d0so34807746d6.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 10:53:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769799235; cv=none;
        d=google.com; s=arc-20240605;
        b=WPDkgC8xsZxMUP0Av3s7Nk+S4vTuUcb861ePMNLERBY047FDIT2AP0aYrgWD+SfxTy
         AEm5GZ9MjgC3nXb8D09LCUQGU87GGQ3LvcI01uB6Wy2RDyBUK5RX7UAPp3Y7oPZA2ytH
         DxsoAKxwIszi3z+7O9epaqYII+Hb+QeBgD8ZcAJ59aLSpCoiXS8UrZBcjF6FtEyXv9Ad
         C6up62y57udKnc4v7jEGUT00S2GQM7cAy/dayxkoXUpTrFa7i8wGYiNl7wsc1IjGIYrB
         8mliElCPFaEv8QzIBiGbd0PNpMvsiR3pu9CdRzZDpck6nRIR/tyA4jBPpfTcYcM9mmof
         +OpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yn9/aL/X+9O7klMy4Ik8tAl6jzXG8GOxnYP5QqAkigQ=;
        fh=wVCrfiq8uuAzXwqejJuK6kQabxrRqIp3C4MGlx31wZA=;
        b=U+se68959V/vDEvcMsZMhxLb4/aBeo9B1g2IzDErKuhIi14HoJJUxf2t6kTfWJtj/5
         SsyY/FrU+uSS3h9GHQUKXqpiWIhSsX6MU7/jCLd9hwSCPNlKAWnW07cKiXN073/+6LnM
         NN7p/FprGpw/lcBPHQKFuvgUYRM4+nAj+Og++mgNZ/fnJUB2KcYv7iY75pttGcyWQvp3
         sNh3Ei5tBixAIHCiyHNZpkEpq3GV0YQJg+YjHQo0HxVC0rXjWlIhPtHGJxj48mImSTVT
         l8rvaX8GyJB4o4I2Yk8307U8GFgaseDR0pYcEzxMXdz7xrQAAeC8/tGQWLOyczRTlam3
         zmrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769799235; x=1770404035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn9/aL/X+9O7klMy4Ik8tAl6jzXG8GOxnYP5QqAkigQ=;
        b=lWRzxukWeQrxA4V5TRyZQhJXbvLaUCP3zBXkxfcVwKiAIc8s4j/ShRk5Pt4SIVPAg8
         KBqSxACJYbQ+HXKvRhjWl4NyZ0jfBOW8oLOCqx6bcUPsmqcQwMhRvgjwpvcYNndnG8aM
         Ie2eAzaalNMp+OeId0BIcbLFOmGKqEAMgQPAhiCIADjhnGc0GUky9+A8C+Luu2mvRJLZ
         8RyfQrQjZ2QN6tr+v8FJxz/qBcbQ3HVcdgNI4vYf6va+oyPnCr4RkvIYKwWbWqVzVcJm
         zNiBGhweKK+3WIAATyTYECUAhvaSLV0np6aEIrnTUoR2lkXG7hgtlUzXBT3zJxP/wPkt
         oocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769799235; x=1770404035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yn9/aL/X+9O7klMy4Ik8tAl6jzXG8GOxnYP5QqAkigQ=;
        b=STU9HiZozvNymaZifVaHQJgAJJWNnp7OJenk5EM0yOFgWUkyOHMSevEvNEnt5evqDH
         QU9X7P5guDc/J5mpgvFtbDwfavgoXlIqzWfDKz5JEiG+p8LKuAZMA7lNZ2S4Q122nPBi
         59G/AwXCRqD0Mfnc2OGYWMDZKQiCjRTcP8rQoVGVYWWzARS39bjtGq5ynJQX+sWImwoS
         mujIFH/S1bVQflkGXMJsve3J9+7W85FFZ+co5YLeihYGT4JWT8D8pBRpowH776K4L6CC
         Ki/u5aQbUfG6G1FQI4xcSP6CqKcjPQynSY0wtAFYJNsxPnH+4/4D1eDkNHV8Ys827ddI
         lnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Eb6gwHI3XzCv2WqqEpPfQNdr8fc7jfB+1WtMkgeXZRTRXJMJvUM/XW7LnwWkht5RK6BE+og=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPEBJGUeTzOOUXNBUIalZg0a1ziTH3XpjqDIWFXnIfId9j3X97
	+deRCjHgej4LRedCETBdjHbQbW4y/z8w26YQAUJUR1exz3DRrELKoQXZs4ZpskiGwyUlBUrPbdh
	pTUyX0og3lbC220nBiauihMec1TFh6KChACMaJ7g2
X-Gm-Gg: AZuq6aLLTY3D5MDshzBepgs55FNUv+d3KiSojFKUK4tzrhnWstg0TC0CqUIXEU8al6F
	IYXxBmsqnnXS2mcv2XAJIRaOceOUVLHasfdolk5Ho7F+2et5HXFRAVHkK1ggYJLA+DwvMPNTVro
	U6ULq2imjxS1h5hX8cTIiGfDfUKp6caeFVW2PgEWWdz41ufm/u+2uVaPCgxrovf5LR9dZFqgUW0
	rMeiyrj6OOI/ClugWj2kZREB8oMQMGs8y0wxgZGsVGe2C2aFoIgi3ok31rZd97PstHs0f258KQ6
	h8OVnA==
X-Received: by 2002:a05:6214:d8f:b0:88a:2ac8:9b3 with SMTP id
 6a1803df08f44-894df98d504mr112725116d6.9.1769799235004; Fri, 30 Jan 2026
 10:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128185548.3738781-1-edumazet@google.com> <20260129184844.195df52e@kernel.org>
In-Reply-To: <20260129184844.195df52e@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 30 Jan 2026 19:53:44 +0100
X-Gm-Features: AZwV_QjXfBouIlUMHEv_fN9TOPLqs6vSaN9XWMAsGwnOdB8wQiTh_nv2eLENMLo
Message-ID: <CANn89iJ_b9_wWggO1XAhML-RbJSsK7Lbrn2iDPfokN2QR2vM0A@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: optimize fl6_update_dst()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255223-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71542BE004
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 3:48=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 28 Jan 2026 18:55:47 +0000 Eric Dumazet wrote:
> > - * Returns NULL if no txoptions or no srcrt, otherwise returns orig
> > + * Returns NULL if no srcrt or invalid srcrt type, otherwise returns o=
rig
>
> I'm gonna take this opportunity to update this line to Return:
> in accordance with kdoc rules, hope you don't mind. Applied.

Sure thing, thank you!

