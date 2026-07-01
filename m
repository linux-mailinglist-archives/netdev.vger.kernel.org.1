Return-Path: <netdev+bounces-303859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M8xcDsCLRWojBwsAu9opvQ
	(envelope-from <netdev+bounces-303859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:50:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B798F6F1F45
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:50:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mf5Hgkaj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303859-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303859-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C2983009F70
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C43C0610;
	Wed,  1 Jul 2026 21:50:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE03BD651
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:50:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942650; cv=none; b=Kx/l6i2hXl0GD/hz9BLmcjWIeL1ZKN9uPnKW3QiwIW4AP+6akH6UNzoAuQGG5UW/DDdWnEJM4t3dZCAC8ntxjRnCSDRKP+QROT5u5CmX5oL+Un2wgoeMENqwuQMmg58H97Hs7qW2YvPwsG07E6pxIHL83r5SARTgKN5MasK6ss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942650; c=relaxed/simple;
	bh=lPY2QwEF/A4RrFxmeDEXKjTC7yfbOe2FA4byDLUu4XE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ak9JPNRPj8ib1XBOvzD9r+KT4VA+Zr9TVgK3ul5qX+WE/mpypLzxTa127VLkifOSkLrO/QRfBqjOWp3BXn9NFnL/95An5X/T/ZkfVtjkRZ8lTBYmIfGqaJXsUlW+0+6lOTXALyDS7UUFhEUHVNg2iKJQgcg+m/PyhNjKf9rvnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf5Hgkaj; arc=none smtp.client-ip=209.85.128.181
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80b9993928dso14788517b3.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782942648; x=1783547448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUzJS7YLrMLTfDgictXRy5FJUzML23tRi1dxlFAvrIc=;
        b=mf5HgkajPVjoDVxVCRqCI4eKZ4iV3Cb1EJ0KoEbSjg8t/9XZlJ2H4EG3vJ01WY6QPk
         AqgJoQDA5065f0mrnn0z4WsF0X5dRrE+O5ZorV/lCpxp6Dnq0pg15GhgRce4QlkdDKPn
         KfBQHbpxa4duBPofSeFX8TZ18oHm/kXQBmZNBQJm2GBMkiKkTQPOfiTh+ZPFYWU/QKML
         zfQ5OxG8btuD+HOGNna1QcHPz3fCJThjYAIZ172hoRFOLSiGO+ALsggSjZEKc7nllxHg
         yhGj4NSUw9zbgfOnTMu3piBwhmo4HLBbKSOP0+nCEaZfC21UBw8w8hF5MdfRtxVL3fY8
         bYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942648; x=1783547448;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUzJS7YLrMLTfDgictXRy5FJUzML23tRi1dxlFAvrIc=;
        b=OYGVrdEXG9Jp9sD7F4bioOMjOVd4sREp2JbtF9ErDokRMkQtsh36ygmV7sH/k8RvlV
         gua57bSIN3DyayG+SETM65iEzJAXzFpBlL4k9/hlXEZmygbKICjHQhmbFSbcdaWlqKQA
         aDymoh5R0SyZpWykxMWD6TuseJYq3e+dbBz895xpNliu+Hdc2MKwUg9LDeJqQ4OO4A/q
         FDMD+BwOBpIU8WsRAHAI57PDIpobZzFeZsFKmxZVCAOHq8jUuDdEAWz0gVfHQghfkX5K
         d6l99dnfaIzEEp1LNHXkKggwYnZyWrsFIqMhGFGzi3ioiIQ3p4Sv9QASqOn4kd5cxN5B
         Jdbw==
X-Gm-Message-State: AOJu0YwN2M12eBB6iG97xN6sNozL+xo8j418jNukrBJdBJ7mjxNFhghH
	Lf8gwFsC61u4kld0UExwx5EsxZ/ZdkQ7264Le5KZfTehCltNGJLdvK7F
X-Gm-Gg: AfdE7cmk5gbdWpefWswLyBu9UnlbDuOVO9M6z18eleLsOJBaPmH0AoXMBw3Eioj5PH6
	SdApCN7z6RcPt6iz4ZnuxCbueKxwQQZb/CvAnzlaxt7ov1XEyNMhUEjySTq9w0fiG4Ly47VkVx8
	1l0rr3P9FsOwYyXJNYBUb9KH3A5S8xgbOgvEOsvUEeLRhl9HCdvefp+yzew8UBdqGafFpIEScoh
	1yajIDy6WCttltQxs9ODifFjx7W0n3eUxhYma/AjrZ3eAqwD85B05WRe8iTTqVawtlzFmsS3Qs/
	t5o6YPjPChxygbD50uQ4KzXe1Q5gv27ldt6fJCUamq2s2OLy4dyTd57+chDVn8552ATk8T52PXU
	TeKB/DW7q2+qDI7juieepN1UoqSSCKYeiAJcYexlNRrOjeHjX8Isvg6dJfvhpHveGQeg/et0w9F
	rz6bEkz5p7E1Aq/6sg4U9/NdmrTQ02Foj7KYsmZlcsIM9j1QRvsbBVB4bMDhfHlGz3+w==
X-Received: by 2002:a05:690c:4c06:b0:808:f9bb:3848 with SMTP id 00721157ae682-812e8dfa30cmr38172297b3.13.1782942648546;
        Wed, 01 Jul 2026 14:50:48 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144af4f427sm5173057b3.29.2026.07.01.14.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:50:47 -0700 (PDT)
Date: Wed, 01 Jul 2026 17:50:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, 
 sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
Message-ID: <willemdebruijn.kernel.14619b0e23d1f@gmail.com>
In-Reply-To: <20260630-getsockopt_phase2-v2-1-193335f3d4d1@debian.org>
References: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
 <20260630-getsockopt_phase2-v2-1-193335f3d4d1@debian.org>
Subject: Re: [PATCH net-next v2 1/4] net: add sockopt_init_user() for
 getsockopt conversion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303859-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[debian.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B798F6F1F45

Breno Leitao wrote:
> Add a helper that initializes a user-backed sockopt_t from the (optval,=

> optlen) __user pair passed to a getsockopt() callback.
> =

> It is used by transitional __user getsockopt wrappers while the
> proto-layer getsockopt callbacks are converted to take a sockopt_t, and=

> is removed once the conversion is complete.
> =

> The goal is to help to convert leafs. Example:
> =

>  sock_common_getsockopt(... char __user *optval, int __user *optlen)
>       =E2=86=92 udp_getsockopt(sk, level, optname, optval__user, optlen=
__user)
>                =E2=86=92 udp_lib_getsockopt(sk, level, optname, &opt)  =
 /* needs a sockopt_t */
> =

> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Willem de Bruijn <willemb@google.com>=

