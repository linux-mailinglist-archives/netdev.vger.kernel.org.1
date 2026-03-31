Return-Path: <netdev+bounces-273695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIRJBR8AzGkJNQYAu9opvQ
	(envelope-from <netdev+bounces-273695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:10:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D40536E14E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 324BA3174816
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E1A423149;
	Tue, 31 Mar 2026 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZDUEejj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26A3FA5E6
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974936; cv=none; b=LTPm88vq+dkqzrK+j1V+QcpYRAfdcR7G5FyqtpO0+8WTB52v7USKKUFCkkKLi05gxHxu2GIr396h/Ys4Yt7MMoP4ZIDp3Lk4B5HI3Z7dyOzerwhwBYw8FSJ7b6uDugheREYGlrXYQWXSC/SoMaWwOGVoAs5QBqlfktve+AeN3RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974936; c=relaxed/simple;
	bh=bF5musvkrEAhCDCOuLjDhsPiAjPms2Z9ddSnfETKH5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sO5Glh1056v/ERGX8gz4JcrlUu8ChamtwrzlNhR7qAL6WSuEreybeGBzZbOE+hTZQ0GJWsaLSppW1naBB9uEGUGkersl0QYJ8qPpaHo77QaXt/oRAv2SBP9WpiEhHkR52nIbE6EoV1IWu9yKYhD6vtLMjGiep2N32pi8r0OTOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZDUEejj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fb439299so55456335e9.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774974932; x=1775579732; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bF5musvkrEAhCDCOuLjDhsPiAjPms2Z9ddSnfETKH5s=;
        b=WZDUEejjZTpysUBuNNYi6pcxa12xcPmm0szUvXOrIkeJPS1C0a5e6ve8JZtJUg+ENH
         CjEefej8+ntVZIdeWFvQ17sfBa2bf1qrt4KAlEc2JNI7I9HVeqhOMiZ9hEhr6AgVHsc5
         6G92LzW+Ow3FsBOuaN9FfQU/DUi6PMPfE/MU0kD2KxywqoxXgSDYanhQNFdIr2IOZp8b
         MR5wyXM4oup2JnmEDNAe5qi+9nbniUqir6KS5WXdSqiSgCGVc3tFdyUmsmXEMPP7A9gj
         itRIPFMS2jiLIgOoN0MeH0FPJ76dob9RXRub/Ld23tefw6f1EfuSnJUcjPCCWtJayfi3
         C5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774974932; x=1775579732;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF5musvkrEAhCDCOuLjDhsPiAjPms2Z9ddSnfETKH5s=;
        b=RuPQpz/QOr6cz0T3SReK3LYrb5+dtVe5N/cIUljw6o2qENWz413DYARPaNd8kT9J9V
         q7i7Kq8IBYoVYR7wcD9AuTQ5UwnngKbAMgbzJtCWp9siJGUeglQuSf511UiRRgzu4arN
         FqftLLSWEOlhQv8G1qGxb06rt+nwiDMf8SZGTtaroDQqC8apjWnwwXl85T2XEyev645F
         hiRS3JwnXIfvQ26dX8DibRkJy6afklXdHjoezlMpxoFsmhyfWhUV7tdwwJmuZ4lZ3rT7
         vuZAOwpGhADLa6gLpBHOQamKoGOARQjWoZ0FVo0M8XuHq/uKrdzg0udxpkbP+k2FEw0y
         Pk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/R/2Anf1YjWqx32f9/Or735eE4RBhVWXEljdEze7NBXz1lP4FIZOr+15uNJAWyvHoJkMtoCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlvqjxFRNg3ant2dIhC+cfu+GJW3Oky0R8P65TWIpwzACeZ/UL
	sSrW7Iy42irbsYUT8W9b+M0qK9/75EldlOLF4Oo8BuqTghGXkXmC2yOD
X-Gm-Gg: ATEYQzzM+BWUN8iuD0xJrjtDXIVSjfTf9iGjWRya4dR6/SGwH/PVjEb3r6bEmeq80nU
	u8zkE30/mQmNuTuscX1VplUQWCtQDUH3oXoZ8JANdLro77qa0TdFpT88+H+cI38sG8FpBiwnWdh
	X2ak/2nJlTOk+bj0ARa3z3zm4HB4+uVMW0RgYRH1nl4h57b8YZdRIMaHrqPZABajLO9kbl5DLOa
	BhaQaQCvBA/A5Cn/FkzZzGzGCq7XZvOZpCTvULIZiaMOVOeKznOBa/XEtRCXXZosFxHq3xZdiNL
	whmkRgrjYtv/KVBd1NIBOFc3Y04UCmbOmutuXipAh88CsyJ9RN+qtiYR1h2j8ygNIy3VebyRke0
	kuBByHvPWQXvNU9EPbiUhtmv3WF8r6zY6fXaN3+E+5gnLEQyp6dSCbEOPgZL40ddk+abH9askj9
	Lz4NwL9a+UVADJ6u3v64B1o7OapR7xM5eYVmOUplTCwjsawTAJAuET/2ieWPX2Eg+HXt6e0bUQo
	bthiNc=
X-Received: by 2002:a05:600c:8b08:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-48883572159mr594795e9.9.1774974932061;
        Tue, 31 Mar 2026 09:35:32 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adc5690sm34964075e9.2.2026.03.31.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:35:30 -0700 (PDT)
Message-ID: <db75d50bc333635e3db07a2ce0f3e23a5f62c3d8.camel@gmail.com>
Subject: Re: [PATCH] [RESEND, net-next] net: ethernet: ti-cpsw:: rename
 soft_reset() function
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Murali
 Karicheri	 <m-karicheri2@ti.com>, Grygorii Strashko
 <grygorii.strashko@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Siddharth Vadapalli <s-vadapalli@ti.com>,
  Roger Quadros <rogerq@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Kevin Hao <haokexin@gmail.com>,  Saeed Mahameed
 <saeedm@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
 linux-omap@vger.kernel.org, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 31 Mar 2026 18:35:33 +0200
In-Reply-To: <20260331161814.3725730-1-arnd@kernel.org>
References: <20260331161254.3450606-1-arnd@kernel.org>
	 <20260331161814.3725730-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273695-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,ti.com,kernel.org,nxp.com,gmail.com,nvidia.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandersverdlin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email]
X-Rspamd-Queue-Id: 6D40536E14E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-31 at 18:17 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> While looking at the glob symbols shared between the cpsw drivers,
> I noticed that soft_reset() is the only one that is missing a proper
> namespace prefix, and will pollute the kernel namespace, so rename
> it to be consistent with the other symbols.
>=20
> Fixes: c5013ac1dd0e1 ("net: ethernet: ti: cpsw: move set of common functi=
ons in cpsw_priv")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> I just realized that this patch needs to come before
> https://lore.kernel.org/netdev/20260331161254.3450606-1-arnd@kernel.org/T=
/#u
>=20
> The change itself is not important, but it renames a symbol that
> gets exported under the new name by the other patch, so either
> this gets applied first, or the other one needs a trivial change
> to fix the export.
> ---
> =C2=A0drivers/net/ethernet/ti/cpsw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/net/ethernet/ti/cpsw_new.c=C2=A0 | 2 +-
> =C2=A0drivers/net/ethernet/ti/cpsw_priv.c | 2 +-
> =C2=A0drivers/net/ethernet/ti/cpsw_priv.h | 2 +-
> =C2=A04 files changed, 4 insertions(+), 4 deletions(-)

--=20
Alexander Sverdlin.

