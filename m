Return-Path: <netdev+bounces-285178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHVBBaVH/Gk0NwAAu9opvQ
	(envelope-from <netdev+bounces-285178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:04:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA844E4789
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B999E300683A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFF633064D;
	Thu,  7 May 2026 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaWDqwn/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5432D9797
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141089; cv=none; b=H6SBP5RJwqDwS33h6JznL1eFBoohuNGcv9+S1iV4Nh4QHrs/30QVWV6TLZMXZ+4I47QfEmjrj0qIXDHPWSvnDxqpwbdhcqgWAFxoGxdAJcV65dJzrznJBWnRbOZxF0f3JEOXgBHz+AN3WN++4NXNZPGTWTElNf7VmSgJv2OtCI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141089; c=relaxed/simple;
	bh=0TdBK8w34M/TlCdppsTgo0f00DpgIJVuhmLY0JYvBrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeuTkbJ0+HpntM3HReQE4aAN5TbPp3H+cGXSi7L6/YkAxAkeRWsNEIU8VbTXamgeDsW8YPzOZEEHeIWWRtM00t+dA2nUQh3eAo76hH0Z9u4A7BdRhm3kWEuNkg4LO4U0ZpuYWr0Da6vACFWFhPnelF7lGPCEpX2C7xbxfAXHEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaWDqwn/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso16806835e9.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778141087; x=1778745887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7YckadijkDGQ6TtrrNwULTfEdvjDLhXzpW91JVQJ8w=;
        b=CaWDqwn/gxfYNAvw7BRXJUW44MDzNkl1dXZR1kP6Mn4tAwcK+cPHtXB+yIlZGyZYor
         0OV6mFs2EykCUoPUzueLBe61g/2q3o3PVysIdRCARRBkiV7XKVFaZ+KpB7BJpohlhutU
         MKOAjyIHiYPPybznoiKE10SqhiG8nZmgkmdEfvdLD66K/a2fTd5svDrkPM2G+JJebDsZ
         6Mzb/Guu3POkolc6TdMGLFpHWokDSeUIyab98IRM0YBA8PgoxPOox4etqvt7/JWbvaB2
         i5u39rkRanmkUSAAhuES+g2QjkcpggSuotX/nC6MJYHN/WeQSdZraehcyLZh2Xo7yVFq
         WqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778141087; x=1778745887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7YckadijkDGQ6TtrrNwULTfEdvjDLhXzpW91JVQJ8w=;
        b=dyDtHYgXM+pqTFbc7vgfHaWEonF6BEZXYsjxsOUoHN3fALan5miLDQQwtWK4/nbhkt
         pkHMic/N5Qx0sjs3l33S9ESpAkiGCqAcqslhMVH/ztfsLQI25sB1UYAWjWi4zuqnUbwI
         /EcuITTeJVI4wTjHVFLnTnxrnNCY3EmvfhKl7ASNcZWE1+6ZK/o+0GdEKx5iyFEXOtxa
         HaTmLnDt74CsfcbFTfUA9vecd4tI7CfwvpC6b2pVnsdVFIAHBjlPKQ0eaLzt+FBypgkG
         9Lfpl19VqJMeqHrm5koePfYMaQINoZSNoQGdfaCQaFWPKsBs1ggQE0WT1XJC7yDRukgW
         qYXg==
X-Forwarded-Encrypted: i=1; AFNElJ/En2sp0xFXE4zZM4E4//prNroPLAAcWbtXTtUupWogS7bac8mkBX8gwBB3bKxFHEP/Hdkad6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrcJoUNS1nhEs18F2/mJKvY6w7/FDSt/QYabFHJCp9XxjWDKVr
	sVHKykw1nbW5OVbUG/3ERCfJ721eUIOoWzaKAsQS7Ar9UynNbS2m0Bmz9YIkwVLc
X-Gm-Gg: AeBDiet+XelWoAYmWlTY4B2/21ZhRH0jKnyA8slW8z62EFgIqeQKXrCIcyGzBqHXBQT
	NCXs1gCGvVcfQkjjGZdiy9nfEi2sAMVNefJqimS6+yPkR3PzYqFwAod+4B4uiUSSCjbokO450Uu
	0y13yAoax+e3pAvOkJGCqd3LVoAyEA8WDefvtk6jlaPFNM0D6JSxKaMgAQOuAvI2Z2uqo4/46h7
	QY+LihD23+8qmNngGwvCtrbOTn6jpj2/JSnLyd4xWGcIyhjcqcJVA/Wjf2YDrtJrRya+aZeRXkm
	3bWlZaS7RB0z9QPod06WB1hyp2vfcmT7aA+hjqbNMWYqhr0623HuGE3U1ns0szEEKNh09AhnAgY
	b6ufeJwqHz1P2+mLmZQLWS6L3WR7cVeFDe89i0Cyl6WIkxrftUieVaK5jLfGT72UDK949Yzo2Fn
	4gV41x8/0DYsV3l2T32RoV2/s530LkOrcMcFZItgOeFkY2caLfXI6pstLm/LUaxMF9heTWbQyQb
	VfyjRCLcA==
X-Received: by 2002:a05:600c:4e56:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-48e5dfd6508mr27365125e9.5.1778141086701;
        Thu, 07 May 2026 01:04:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a4878fsm17608283f8f.9.2026.05.07.01.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 01:04:46 -0700 (PDT)
Date: Thu, 7 May 2026 09:04:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?w4FsdmFybw==?= Costa <alvaroc.dev@gmail.com>
Cc: jiri@resnulli.us, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org (open list:DEVLINK), linux-kernel@vger.kernel.org
 (open list)
Subject: Re: [PATCH] devlink/param: replace deprecated strcpy() with
 strscpy()
Message-ID: <20260507090445.3448d536@pumpkin>
In-Reply-To: <20260506211415.16343-1-alvaroc.dev@gmail.com>
References: <20260506211415.16343-1-alvaroc.dev@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BFA844E4789
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285178-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Wed,  6 May 2026 18:14:11 -0300
=C3=81lvaro Costa <alvaroc.dev@gmail.com> wrote:

> Replace strcpy() call used to extract a string parameter from param_data
> with strscpy(). Since strscpy() already performs bounds checking and
> ensures the destination string is NUL-terminated, remove the string
> length check as well.
>=20
> Signed-off-by: =C3=81lvaro Costa <alvaroc.dev@gmail.com>
> ---
>  net/devlink/param.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/devlink/param.c b/net/devlink/param.c
> index cf95268da5b0..26695b7e2861 100644
> --- a/net/devlink/param.c
> +++ b/net/devlink/param.c
> @@ -536,11 +536,9 @@ devlink_param_value_get_from_info(const struct devli=
nk_param *param,
>  		value->vu64 =3D nla_get_u64(param_data);
>  		break;
>  	case DEVLINK_PARAM_TYPE_STRING:
> -		len =3D strnlen(nla_data(param_data), nla_len(param_data));
> -		if (len =3D=3D nla_len(param_data) ||
> -		    len >=3D __DEVLINK_PARAM_MAX_STRING_VALUE)
> +		len =3D strscpy(value->vstr, nla_data(param_data));
> +		if (len < 0)
>  			return -EINVAL;
> -		strcpy(value->vstr, nla_data(param_data));

The only sensible thing here is to replace the strcpy() with:
		memcpy(value->vstr, nla_data(param_data), len + 1);

-- David

>  		break;
>  	case DEVLINK_PARAM_TYPE_BOOL:
>  		if (param_data && nla_len(param_data))


