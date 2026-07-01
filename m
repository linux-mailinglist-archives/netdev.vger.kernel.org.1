Return-Path: <netdev+bounces-303863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4WlrOduMRWqABwsAu9opvQ
	(envelope-from <netdev+bounces-303863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:55:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 642036F1FC4
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 23:55:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="bNAIh/wJ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303863-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303863-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70F69300F175
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 21:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBA73C09F5;
	Wed,  1 Jul 2026 21:55:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3D3BD62F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 21:55:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942935; cv=none; b=jgnHl6fGH4M8Mj1cHxYXhybtIAEydzCJ+lvLKSxygiGGDKa0UWRzs3bTkb1EREtbSIok3euU+6dbzgSg3OKecdeDv3q9/Op1bSjCIOuJX9DoQ5zP6hlxQIoTuwTIUc4dRvVNkwmVFvFrp5A2pksLllicp9YMB6EDEohQXm61lBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942935; c=relaxed/simple;
	bh=c1GDdq3quHyTY8zCZnTyRm9TRMaTJSeQbkdL9Se68SA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=B3lniYuXQwGWrCb0h04rAYa4Nr2wK7rWcL4kMje+Ym9gjqBoL7NNQ/5jOOlef1jaJCMR5O5UJUeFrPx24E8G9P9TA+JKhHrYR3E6frKUSkqu/cHLSdM4CYio99arkDcN90NUVlKBcs3YTZeCkfsRQH7OidFmPJD92tP7QPFVGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNAIh/wJ; arc=none smtp.client-ip=74.125.224.50
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-664a09bc459so1536829d50.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782942934; x=1783547734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkZmqTv3KeZXc25LYl9MzDOS+9fgYgJm6HBDG+664lA=;
        b=bNAIh/wJaCJjB0LYZuaamhFA2KcsKQQ1Uel5n8Ha7GcNmoAQegWHaLFqmjmXCf0BOd
         0GU0HiX0rYm9bBCNb5G7VsEP0XdytDyQOYnvdzueocF1uA0VeisREVXmaVILVTwEfSFG
         0Zr+qzAoRod6gDlV6Zo142ktRZ40fSc7OVDfnt//qSn2Ipn3mb5inlvagNZXoMi4FmZP
         ng/3AAJE9Ih84Cwub7y3dCR30uiJf5Z9iCCxRF0r/GFfrn8uViCNE6dHnYqCKrfaFWqG
         tfSRw0vBuXhEAtMa2DHDj6WDkiO+1T80f58fkc8xHmS98dR/vPJQEHVVq/fZ8tG1pM/K
         LRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782942934; x=1783547734;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkZmqTv3KeZXc25LYl9MzDOS+9fgYgJm6HBDG+664lA=;
        b=e1syVO/qAuy60Eh+cH0CUQjirxxSJNOqOG0KT1F+GocJchuw/AngoyKZxzGoVVqyVy
         G0DTLtTrdOcjyEr4dfw9TklUUJyo6IWqd4Mjc2uNI8za7BApm0NYRaI2J9+uye2C958Z
         fhKft038faAmg+I/E0kOmDYJu1hZC7FXQgThzawrFWufoQg3sctq7GAjwdIT2k+g8KIk
         vgHSYXY3e0cAcBZUByBnRAPm391AUNbkU/Zvyup2dY0GTaoPVCOSMr+CFxugCO32ikFO
         dyzXO4ceDbwAXaB6WeO37mZUMMaaKJL/BEjDfC550M9F3Jdyi2/UAYU9wO6zUT+qd7uf
         AoEQ==
X-Gm-Message-State: AOJu0YzDIpicKdJy2ytjCrKv302ERV9EEtRTf8j1Uxd0byaA+58ZUHtC
	zODgQ48Fk4YxDXZrPiR28dJ0zLBjkpzSS8gFGAwZQqFbH+CdT8LyV4g/
X-Gm-Gg: AfdE7ck2asuBwtCF9m1kPf2CyGEy1mG099H7DVDWVVWp/0EQZdZNdInPZ4a0OIptFZX
	aK32jQ6H+hYDDR0sLnVbb8SPpzNjAKaoTl1MbrLoaKFoS2KsBVuKt85UvGDyNoLvgc23gdCNtv5
	5qUycbY8su+puCmBYeifoUSjMG1p3m0D6G6iKmyVYXwQJQm2tIM+QC9/Z/B8aI2uyjOYemsb0ZW
	6UU9gC8wtnnK1TBOo6e8P4anYMNyn6Mb5n7pO9XKix9+aPIlAfwr45IdFOGc0+FeAyeQFilObo3
	Pi3HclXLmpgVVdPl8100kWwt63OOg/5FmmvioW8M6QPvnXwA3oXMDokR3mvEatm1wnFe8QwXpo7
	WuHDEYy9Tr3Qrv0LL3Xl0raDGGl4Uofm3QLvTBG7l4bEmCDSHp5aCdWoCEgZtBgB0DJgEVZ3T6e
	ZyhgNa24w60IKYxcRy+e2PvNVdqgTb4XrJkrG3IbjteTf5hOd1/wwOnsUUexfKJZsk+/VgjfqOC
	0Q3
X-Received: by 2002:a05:690e:4004:b0:663:593b:e30d with SMTP id 956f58d0204a3-66521b04946mr3485910d50.34.1782942933438;
        Wed, 01 Jul 2026 14:55:33 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66624023d0bsm262809d50.10.2026.07.01.14.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:55:32 -0700 (PDT)
Date: Wed, 01 Jul 2026 17:55:32 -0400
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
Message-ID: <willemdebruijn.kernel.1dfa2d4f930d6@gmail.com>
In-Reply-To: <20260630-getsockopt_phase2-v2-4-193335f3d4d1@debian.org>
References: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
 <20260630-getsockopt_phase2-v2-4-193335f3d4d1@debian.org>
Subject: Re: [PATCH net-next v2 4/4] selftests: net: getsockopt_iter: add raw
 ICMP_FILTER coverage
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303863-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 642036F1FC4

Breno Leitao wrote:
> Exercise the raw getsockopt path now backed by sockopt_t. ICMP_FILTER
> returns a fixed-size struct and, unlike the int/u64 options already
> covered, clamps the length down to the user buffer on a short read
> instead of failing, so check that semantic explicitly along with the
> exact and oversized cases, the -EOPNOTSUPP path on a non-ICMP raw
> socket, and an unknown optname.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> +TEST_F(raw, icmpfilter_oversize_clamped)
> +{
> +	char buf[16] = {};

Not a reason to respin, but instead of a raw constant, something like
sizeof(struct icmp_filter) + 1 is more robust and descriptive.

