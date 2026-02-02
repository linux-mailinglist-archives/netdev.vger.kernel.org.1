Return-Path: <netdev+bounces-255823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DPzEO57gGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:26:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE69CADFF
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD3EF304E617
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8E7357A3D;
	Mon,  2 Feb 2026 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkyEPkwj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852EE357707
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027273; cv=none; b=Xy7tl8kdu4PsPsfMOSgof8rSNcHhYKNcbhg523upmmtc7S24uUcPNQeWld9pli1Wq8lFhkEVVcqwuMa2JrMRP94K3XW/72FTHzW4sFUYi5lwKA6harfc2MPfSlX6hHdIttnrcGbdTBcfoKKtcDW7YT2EwEVgpFcnQpDSk+X16KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027273; c=relaxed/simple;
	bh=8VzmCD6zmthbjJ6e29NsFnoebW8tRXPgQWLhoogWYDk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dEe4xZKNz2wFkNjAoFpV2GCREqpZOo9ELpWvIbi7gV9mT8PZss2SArLZ0Jl+kJIi8nyGNJ+Q/xcQ4m40dnLQIHeSbP8z9kWJfk7gzHXLknrQWKd4PJ8WQ8fDmOIJW30NFsJziikgEQZIBBIefwMmbdwyZTy+5vOr8jTpU6HWaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkyEPkwj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso31759265e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 02:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770027270; x=1770632070; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qrYZR6rjkuzxmU3P4nDHzp2Z/smbaycErCPCyN/9Pdo=;
        b=PkyEPkwjq8nlF8HnND3XJr8eZb2DGW/dH+4Q/9AI6w4qYoXJH+N4aChpBvFQFl2EMz
         cgtmu+2oIhrwyIOuj7B9M6rqURKzA2t5TQkGHwIEQzpfV8zFeXMYpTiiBZF7Vc1TkI1x
         LuzaUEJRQkYADLzeCFyfFyaFg7YvwpCJ/P81b04taF4YNCo9GRGJurGcJkUVpf4wZvzI
         0HYgyPJPZCWZusyy9X3ZUXz+wjkEeBdH1EAJZLepfLKdDXKQUWrBzbW2KHa3cjQ9HUvq
         oY/Nh8IqShYySpEuye75Lyq4YMz/aGg4LPT7Tjg116r+SuqT8H9N0mxoegD/+inlTr/T
         ytzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027270; x=1770632070;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrYZR6rjkuzxmU3P4nDHzp2Z/smbaycErCPCyN/9Pdo=;
        b=LHJPk9mWliE3eyOOvZzHlmYKWPnReSrqmWNfNwgtU2dChqFwRiGswAWZH9kVSgckU4
         0NnK2ktuBzHxaaTHaKe1J+wR2X8tv7iHf4AmWpbiL2k+JiMsDVIjwMtjFGIHVd1D+EXj
         S1SUuPpt8Pv/GeR+Ere6ZrFoWQqlrzYVzntVqUugwyB+Hn+QMVRHrvEmZm38t1ITI4un
         sQOCnrYO2nyKev2wGGnsih1WLBMdc8W9o7GX0qiQHaIRH9RfF2KTAqCsnFcqAc8RQv/2
         839z9myLDqhZ+J0FzBvKOnRrzs5WyS4bjPgAEIyw2ZQDRWTrLZd5/n8sdsfrBRvPMj2H
         pYqw==
X-Gm-Message-State: AOJu0Yzo5DiM+CDvNrBxe7xDJfL0xtlH+iYPZJbalEnidxNwaHZWodz9
	wzVEZjBos6LUgxesGZgPLDOH3L8GcYZMUtQY2NrCzmPdGokp55mS+0pc
X-Gm-Gg: AZuq6aLAI31UbfBzZDI5+/MT3KkJenZT+2+XLTPa4X4GgqUzS+ffFkG+SoCDY1vtc0z
	LADdG2HG2CmHpYXsaQCl+rBvegKIl8oYyn/AlVL9N6F5st6RI9GOpxLa+tiFLW9KGixi6W2wrX5
	oMB4lyLouNar5//+BtVPbU9Z/BpO3WBZpzg3+e9O9tRwnglNG8Wz50TDYbL2uuIU+zJpiUUqND0
	jBVQGNQbSV9pY/PFtd3umO9OG1q/ONdLZ0QvYCFodDK0WjObSMedWW0/MhUrayRo0BTKJcxbKFU
	C9O8+jBBwXLKhdGDcXKg8nh+ZdO8CBtG4Z2J7NaCdfYar6++FhSI3S9qSr9Z6Zk50s/5izikzSX
	6sIc+IB7mnPxv2ZZzUowM2BWZVhZm0qf6W/99AtGCna8R9cNAOp5c4ow9u+IeyjmPz7k0P27lz7
	o62Eg1vV6jHnBTCERrI3U=
X-Received: by 2002:a05:600c:6298:b0:480:5951:fc1e with SMTP id 5b1f17b1804b1-482db45fbf4mr141852155e9.11.1770027269821;
        Mon, 02 Feb 2026 02:14:29 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da8eb486sm109926285e9.2.2026.02.02.02.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 02:14:29 -0800 (PST)
Message-ID: <d1ce010411a0acc56393dde86cdec38cc4866e09.camel@gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: adi: adin1110: Check return
 value of devm_gpiod_get_optional() in adin1110_check_spi()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Chen Ni <nichen@iscas.ac.cn>, andrew+netdev@lunn.ch,
 davem@davemloft.net, 	edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@google.com, 	nicolas.dichtel@6wind.com,
 alexandru.tachici@analog.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 10:15:11 +0000
In-Reply-To: <20260202040228.4129097-1-nichen@iscas.ac.cn>
References: <20260202040228.4129097-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255823-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:email,analog.com:email]
X-Rspamd-Queue-Id: 5FE69CADFF
X-Rspamd-Action: no action

On Mon, 2026-02-02 at 12:02 +0800, Chen Ni wrote:
> The devm_gpiod_get_optional() function may return an ERR_PTR in case of
> genuine GPIO acquisition errors, not just NULL which indicates the
> legitimate absence of an optional GPIO.
>=20
> Add an IS_ERR() check after the call in adin1110_check_spi(). On error,
> return the error code to ensure proper failure handling rather than
> proceeding with invalid pointers.
>=20
> Fixes: 36934cac7aaf ("net: ethernet: adi: adin1110: add reset GPIO")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---

For the change itself:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/net/ethernet/adi/adin1110.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/a=
di/adin1110.c
> index 30f9d271e595..71a2397edf2b 100644
> --- a/drivers/net/ethernet/adi/adin1110.c
> +++ b/drivers/net/ethernet/adi/adin1110.c
> @@ -1089,6 +1089,9 @@ static int adin1110_check_spi(struct adin1110_priv =
*priv)
> =C2=A0
> =C2=A0	reset_gpio =3D devm_gpiod_get_optional(&priv->spidev->dev, "reset"=
,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(&priv->spidev->dev, PTR_ERR(reset_gpio),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get reset gpio\n");
> =C2=A0	if (reset_gpio) {
> =C2=A0		/* MISO pin is used for internal configuration, can't have
> =C2=A0		 * anyone else disturbing the SDO line.

