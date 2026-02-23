Return-Path: <netdev+bounces-260261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JNAKUDmnGlNMAQAu9opvQ
	(envelope-from <netdev+bounces-260261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:44:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0220A17FDA2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDD9F30F75BA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B6537FF47;
	Mon, 23 Feb 2026 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="crOfaB9K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2237FF66
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890189; cv=pass; b=ZoU0uwNq7rA7x1iDK+zf/uAeeyAQ9q3wqlHiKvsxYlbibMfIvrQF4ZparbLHI64+sc8MV7ov7cEByTVMGmc1Yhd1yppsmYHMAWyA0LGHMk2GQdCOjsCdzls7Ns/rcWKP0jrBiww9Y5iNO1gUXrBqsCQu/Pu+ncZV4X/dxEXRwAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890189; c=relaxed/simple;
	bh=+jBBVPTRzLXPo9cNckFowfGFw09g+mEPMeSwlB5LDhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYkfxPqqoS2eIiio8dcs2Mkw1ftll4LCnQXWQF/livizt+OuPbwS93HDYHHHQjhMTV8GS8XrJ9Kba1qTVBtdHyCgKHnEaubCyN4SjQpzNHIKpbqldrt4rOemAjs5Tr7jZJptf98gFoz0oXS+Lmd9o9OB1/CzqMQ9s6CRZS/I4pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=crOfaB9K; arc=pass smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c6e248aa446so1965905a12.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771890187; x=1772494987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8DqRTy5SdR97nmWrGUSUS5UJzBt9XQOKnn+GQnX3yI=;
        b=DRWjQ73TqnC4+Guu0jijwctA0HuyKMAhP2A/hAqm4xZlfL/x1FDlm1IM4PNGZ8yrQF
         NIqXEwP7PSJpzGZ0j8MeuEzA3nP/vC8eY0B9cVRwMuQwm1DRwShm3bf0+Q6tUeRTTXDf
         VkNU54iC8W95AmortRuoW21L5Gt972y4DPtj3ALkwXowvDHVYwpSlDFrYTVL+29KgBoQ
         QvW01Mi8xB9dg/Bg5K8dwgnSDrjr90rAjUxMRzdP2H/77T4zEUjzmtbIiFh18nsWfy+X
         ZkjT3+ca96FpjzhCyhfTMLsOn+ZId+MVvsqmOQKHEY/tGmlx7ha3kv576ZRPZXFmGg1j
         KY/A==
X-Forwarded-Encrypted: i=2; AJvYcCUbFGBN0Ae+4u4QEcDrvoKFbFqI78Jbwr4fcb62VXkoZi+JINdP5nQcoIXpM/uAw0sVqXtbEu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCKYWJYIk8a6vgsJ6Wlknm9+8JFwqeWhWMqo1nIgJNh1p+i0uc
	FZgnblsIDCLDEgNbyEhX/J41yFbvpK79LcaRWXdBxRdBsNhH8a7BEVEdEOw/C0SSER67a72Llp+
	PprvKXSW4Lle4BGebaiy3oCToOatkB1qGUT4C6AGC2uICACa+Nhr3yZwLkhcC/H08wZEXBonOz4
	rQfet+Pudso3c0EqWrWuSw2+d7ZsvVMUiF0MP/bq2IxYjUxzQtfdFrnJ7WB6imTs/4tlW2MeHcq
	k043UKjiog=
X-Gm-Gg: ATEYQzxG1YqD4LZBczspWwQe0w1+4RURxYYmUoiyKthxWZBdbS/L7cvUaf74viSEpC2
	T7KDeuM1XqOi01Inr0ZVidolt46TiZplhKxQug84HBwKxbNOJ8N1TWmyFEKv7qFnMJgjeRcTIHj
	fjW+hC5ak5eSsKPXdPN5wfh5kEefRRm1DpiHMxBWHTv5zAksjONH5t7GN7Q7KnPeQIHaCnb9BPn
	lh9eGyI+zr4Vl0HIUd4reO0oiLbmfiVGzHcEIheQWnZco559kkeVaZE8/25+0JRRoAIJtFYwk7T
	d06oFrU04pHi2w2HZDpGEzak4/lcQlpWH/4QzSqI7KvOVPgR8ZRipgC/JIxKkyf5OLk5qJavP1L
	Ozh/vXaI2fSbg2/bN/erfob2Xbs4EMzolvuORC0uKrgYm45XmuQG1nawdZXJ07/Pst3wV5tBLWC
	1AxN5fVB9cyCOaj6B38vTRabMzUTQquCtWJdWxel3WHE6QPmnWgW05e+eELi0=
X-Received: by 2002:a17:903:3d0b:b0:2a7:afca:fd1b with SMTP id d9443c01a7336-2ad74455a49mr72763975ad.13.1771890186856;
        Mon, 23 Feb 2026 15:43:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ad74e0402esm9575695ad.6.2026.02.23.15.43.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 15:43:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-65ab315bfffso354700a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 15:43:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771890185; cv=none;
        d=google.com; s=arc-20240605;
        b=BfOplvFmkjhcwjZjg0o24d9cKo/GIVttnrR1plXvafzHlxu+GH+HvywtHEQshaY930
         zCauF08HXz4yF/cvXir7jKSqfz6XIaE7hqShFJ7P2Hncf5jH+ect+TXxT3G0TGinXIWH
         ilYzZAsYb9MfrN1frbGgElQndC2jMR++IOKGReGtYAuwFJKzbx/mQRkDxgYe/OgZ07wN
         BkOe42Q6eVdsQBgwdzIcS4uIHDiQweU5iP2eAVpX5//4AlHoq6ov5JSThSL1Yv2x5Kr6
         Wr/epW52Fe0+p+/zZrVY3kLG0kHDREDegXHHIWFA0reHLOwz0OW1Urdm7lwjWLkrQt59
         BsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u8DqRTy5SdR97nmWrGUSUS5UJzBt9XQOKnn+GQnX3yI=;
        fh=kTebTbxNXrzPbda7J8eo7sQRso92/QcCnh7SjUf5MOA=;
        b=d9Yd6QkHqVEf89LwwxcAZWzV0LCCK6TGTi+B4IDdSFfCr7D5BlZeH0qCYNLFEuzDhL
         oduT1SPbSriHKYp6YV98gD1GSYegLFiEyJW//MAGIO+Buc9MyJakH/N6gzYzLWw7Ss6o
         AjPUIhI1wMSxw3YPj3D/sio/9agD1QQTPakmX5NwWe87t2SJTIr0qjthZeOnn4u0jxA2
         PqFpuVIg3nwzxyrMauICWTb0xtjZAPiHr9L9nxHaO3yYzqeR+1hk9h1b82lHsfIbyN+O
         azznkmIj/FKO0j1iaKSBq3bYd4GEnLCzPmgXw1hohMO7G/H6vIcy62j3uDGmr6e4mtya
         mp6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771890185; x=1772494985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8DqRTy5SdR97nmWrGUSUS5UJzBt9XQOKnn+GQnX3yI=;
        b=crOfaB9K76dzfUlRlfh/Gn5N+29eH5FScfl9Z62x2FA2JA5GEuIL8u2hKzXU/MY5I5
         rf25LV1vtZbkqLhvMBVreQX0e4Nuwz7jl2F0cPfNuxl4fEFPuW+XlzUWh9Jw/gxzoAur
         lUZFe2CTelCU7JA4w5vmHjdID2AFOzNIoP/uA=
X-Forwarded-Encrypted: i=1; AJvYcCXYz98tby1RUvDckod20sYNhQ3Hm9Y0fsUWUxxsE/N4mpiEnAe4wAAkgkyMyqmYPs8WP7g4PKc=@vger.kernel.org
X-Received: by 2002:a17:907:7201:b0:b7d:1cbb:5deb with SMTP id a640c23a62f3a-b90819e4474mr733261966b.27.1771890184720;
        Mon, 23 Feb 2026 15:43:04 -0800 (PST)
X-Received: by 2002:a17:907:7201:b0:b7d:1cbb:5deb with SMTP id
 a640c23a62f3a-b90819e4474mr733260166b.27.1771890184220; Mon, 23 Feb 2026
 15:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223214950.2153735-1-bvanassche@acm.org> <20260223214950.2153735-19-bvanassche@acm.org>
 <CACKFLimX0PPJGeJMG-nycNMufbFsJ4YUTnGbLHC_20xF2n9OQQ@mail.gmail.com>
 <41c375cd-5c23-407b-9e35-8779f899ad09@gmail.com> <CACKFLinqWm7wbdgES_gpYNhQiZJ0cv=w0zpra8rXF=3jMQ+BdA@mail.gmail.com>
 <637edf98-64b2-4a04-8fa9-4a4b791d7d53@gmail.com>
In-Reply-To: <637edf98-64b2-4a04-8fa9-4a4b791d7d53@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 23 Feb 2026 15:42:52 -0800
X-Gm-Features: AaiRm50NAa1I6s86LZWSsP2T7Q1mfHSuz3HF_H6knmM4bpPzD32jOaq_RnupZ30
Message-ID: <CACKFLikK4aPasvxPBkr=KWj5e6zhxC-aXPCb7q=Yv2_dJLwZdg@mail.gmail.com>
Subject: Re: [PATCH 18/62] bnxt_en: Fix bnxt_dl_reload_up()
To: Bart Van Assche <bart.vanassche@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>, 
	Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260261-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0220A17FDA2
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:56=E2=80=AFPM Bart Van Assche
<bart.vanassche@gmail.com> wrote:

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> index 15de802bbac4..aa7ebd1426ed 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
> @@ -562,6 +562,13 @@ static int bnxt_dl_reload_up(struct devlink *dl,
> enum devlink_reload_action acti
>                 break;
>         }
>         default:
> +               /*
> +                * Other actions have already been rejected by
> +                * bnxt_dl_reload_down().
> +                */
> +               WARN_ON_ONCE(true);
> +               netdev_unlock(bp->dev);
> +               rtnl_unlock();

This is better.  It makes it clear that it should never get here.

>                 return -EOPNOTSUPP;
>         }
>
>

