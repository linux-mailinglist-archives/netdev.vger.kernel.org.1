Return-Path: <netdev+bounces-255998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLISHycBgWlyDgMAu9opvQ
	(envelope-from <netdev+bounces-255998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:55:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7B5D0DC4
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 212D3302740E
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992203090DD;
	Mon,  2 Feb 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ye1Qq+td"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4073033F9
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061802; cv=pass; b=F1ESnWaC22gSxgryNAnYphRhHsRofwIZkvl7Mf2rYQPfllk7KU2sG82OMcgI4FzaSxc+e/0E9LnMVZ+56glVTpEMZmhU85Ye8VqDwAZybSD+SO4v3k9u40NaZ0D0ntYYLV2mAjnluR4O0+jo0yfPujKRHTAzLEdLa+oV3AOMQEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061802; c=relaxed/simple;
	bh=+3Ga/gxGjsFjWDgHlYzU2K3vKUZ6cQ/OsNqBxa1njXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQJ4nIA57wfzMVXFDJ5wftDQ1Vdn8MpT8lh+Cn+UKuejoyJmhrxfcWHyKed6Kw1VX46JDp4z8owl0impGFxx6W4ZyIS2l978wFwe9lHC0Abz2GNxnxzEoY319Ex5Bzjn/zlhvzt01WBnT9S3qDSxm4hnTO+ZhrDDs54ef2hzBvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ye1Qq+td; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a3d2f3299so55256096d6.2
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 11:50:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770061800; cv=none;
        d=google.com; s=arc-20240605;
        b=Mvmt9Y5vjfUi3FopPEC/IMhU9Bar73XH5kmZsMgLJr9o2v7kRuhTUXiz/1OHgDb+zP
         +Mb5JZ6HdjXQlKC6BvRI8k0vjoQFMYHD4pKULh6jE6RynkjDZM4ZWDEkiWjM/sX6b2a/
         cRJCDT2MzCqIcElP2/PzQsAlRHxL2I+G5kNVgHPHXHzO2l4+LZM+tWqqhtOUf4xDspNO
         dtvTGMNZpbv68B9V7zN1vCg1b9aDqmjHQpp4l6dPqUjZ5HokE6soeAc4bfKU/rEEa6jE
         K1nQPb3SVJgpIebmPYLBRlXB2FtI+jreS6GLiZ+gv2dUFcprtEYIHAItLyaNs8ZjMW75
         8mAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3Ga/gxGjsFjWDgHlYzU2K3vKUZ6cQ/OsNqBxa1njXE=;
        fh=5/MXhKUXAWSGyZieuCAtbRworZTiEAxf7048uKhtswI=;
        b=TZgeYmiF9Hj0ZwmjJ2syP1vzluPPCtP3b9VUjiFumxGcVNuE5hoE+0ttF2sFeoaYBo
         IhxsPlSlVZKc1RvJxNoH+i9KDjeKRVrabi2qN0hRytQc8vM7l1909+qk9YbrFQJtuOfL
         fSQxmfa86nJHYSo7MxtA7TYQIGNQ6JGMX21DmaO3v5n0SGFPNshQySkISTXpujsyC3NV
         MFYEiY8B2CSs1KMMNiXDTJ3T7sNq5Sveu9mmWoUpawWICs1vgTAaJgJRWWcKxNnmmjXI
         3ddy5CYw4sfAAkEb0q5BcD3Sw0alXe2QMzJsAC0LxmZc8NfF7gUgTtohpYx/x7jMN1op
         uHYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770061800; x=1770666600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3Ga/gxGjsFjWDgHlYzU2K3vKUZ6cQ/OsNqBxa1njXE=;
        b=ye1Qq+tdCwT+ypKU3xxKSvawaXeqfQe4NpritsJOTyATXncfBpfAHNmXG6uq6DSFCx
         5xFjOfaWgiYtBE/EBlcOyvjHtzC7EqrF0vFYB8XsCKET9auHYDF2ivNfL0x7ED2DWkHY
         FJKNVukndHq3P+Cq0qKx/gx2yYrWTMtwZd4liR0phHNR8CdZDAtpkuNlOpNgb1f8GdDB
         UoGpz3pgleeRa3RfGrHzbuDbT5B67P8ZeEGbdr1DTNYbYCsx2LdmfaqlftmVzBzUcCU/
         UvGfVoshO2ef63B34/HaENJcyHgEMNPkNJyqr1GIFSQK6DTHxDrk75nQjMZoJ1KcTnQK
         Ru5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770061800; x=1770666600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+3Ga/gxGjsFjWDgHlYzU2K3vKUZ6cQ/OsNqBxa1njXE=;
        b=BEDvaS//Or5d36cKMEQm8lFPBZKg0xBGb22K3NTqjaMVlarj0re7SXp6uX65TloFc4
         JTjEW8FAkC+oh4stdElZRMM1hwrf+YMJZJIRaoNQbuD5u/XETDbssct6/qWKN+0yc8RS
         htBDhpoYuj7eQq87yvkN+lGt+Pl+BfKxcTbOxO3r5BuwKiJ4oStQ1xPAxBgAxdjqJGUU
         h77JYwJa/2SryUL/0SQrkF+WW/Ky2dH9ZG3DVUyWWrqVzCbV8d9UR3jWr9aEb6IcVswT
         ej/gj8Oe4ECFQM3TREKzCMWfLKhHBLOLkuV2ztYiVsHTOJuPQEBz6/EZ2fy/tWCAaoVa
         Od6w==
X-Forwarded-Encrypted: i=1; AJvYcCUYBdhb/LQEPZf+2+cjDu5AiVFKBYVknRoWsu+7K4HTyDBK8E8PIvEe8IGh3yZwrFYVbkdHhD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykimlNKA/v6utkgryDQBgVtx8KyC88PfXrzTWSsQhxv29R1BNB
	ln3FtJTyXZgrvzR0Dw6xasiaVvemum38hDQ9rTzqKr/DOIjqsyV1x2IXNZDuqPFE1JifJHYu2r1
	Abz+XwT2aIYZuOtYlFsTqyDA94QpwTCD1cV1hJBgb
X-Gm-Gg: AZuq6aIwU38r5RnAdEC9e07Qico4uXElcoiHl1rDyormMlbc8GPqSdN4nfn/aLu2Ons
	uShIgg07ssCLcJH7Wpeilx11Cf6Gcxap2A7UakKxSPQPuR/tG0O2+3iDHQmLqBInjK3BPZ2jUwF
	hbOLO2JzfZ4PXictUXB9cIfU9zaYdcmh1kOrKPmjFLhNfLE+O9ZsJoME9jC7l1doPcRTjolspFC
	2E85yYjzTT5t7Kgea5yiaBooTE/uZe4kxRoKHOJ3wy/IyE3X+kBHQo30eXfs4iCp1xVtA==
X-Received: by 2002:ac8:5a82:0:b0:503:2f41:abaa with SMTP id
 d75a77b69052e-505d223e866mr165261021cf.40.1770061799330; Mon, 02 Feb 2026
 11:49:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202192338.2373930-1-alice.projects@fastmail.im>
In-Reply-To: <20260202192338.2373930-1-alice.projects@fastmail.im>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Feb 2026 20:49:47 +0100
X-Gm-Features: AZwV_Qj0Uka69JXyUTMlxZMZv2Xi__KA7ZV252aZ6HPM5S3qBsbr2TYJoZPH32g
Message-ID: <CANn89iLrZH8pPc46Zu-H-0fd6H0+BgnD31qGwtH0m7eMdgsjJA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 00/11] BIG TCP without HBH in IPv6
To: Alice Mikityanska <alice.projects@fastmail.im>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org, 
	Alice Mikityanska <alice@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255998-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[fastmail.im];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[iogearbox.net,davemloft.net,kernel.org,redhat.com,gmail.com,blackwall.org,vger.kernel.org,isovalent.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:email,isovalent.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9B7B5D0DC4
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 8:23=E2=80=AFPM Alice Mikityanska
<alice.projects@fastmail.im> wrote:
>
> From: Alice Mikityanska <alice@isovalent.com>
>
> Resubmitting as the tcpdump patches have been merged:
>
> https://github.com/the-tcpdump-group/tcpdump/pull/1329

Absolutely awesome. Thanks a lot !

Reviewed-by: Eric Dumazet <edumazet@google.com>

