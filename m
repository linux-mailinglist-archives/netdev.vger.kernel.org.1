Return-Path: <netdev+bounces-294796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y3pRGl1IIGp/0AAAu9opvQ
	(envelope-from <netdev+bounces-294796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:29:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A713C63933B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:29:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZAuSxtdq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294796-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294796-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1503051C47
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B9384CF7;
	Wed,  3 Jun 2026 14:56:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60833A6E9
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 14:56:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780498604; cv=none; b=TYvs9ppYWoGwPyET1KvlCF/ZFoKzAmMrdishwYwEbY/TzR1LNfgp+SuoW41ncldJAvoo7jPV2HdT841Yc7Ob0wlLQSxkdGuC0ifQa71Qyi/g9uDGXMlOTTtit21ieFlMdOMPx4agDUFtY8rixeujBLQ/qj1AqZoAWklPKg64jbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780498604; c=relaxed/simple;
	bh=ImhruFXE9Lbro7dva4U8BROB5jOXgaN6s1GZsu01hbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNWwOllvnWiFa/AzgqcqoHpPIlO0wSsQ9UOsp0nxxOjt3FU1kUbj5GFzvdBi8djqCOiLt49jX9UscgUr8Jt20DeL7ZGw6zwWWMmN+wFYicmzjD/fFBHCnQ1lLKzMladtQsAHrRSl1NA7V8Nio0zGFM2NPtvpSg2YppEKIGcPB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAuSxtdq; arc=none smtp.client-ip=209.85.210.195
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-842338c18e0so2602007b3a.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780498603; x=1781103403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zKJn4y6UdkNefa3K7Wo+4bo+F/TyK5NQRV75EX80JCY=;
        b=ZAuSxtdq1TIqXzqjMcFLYh/Wj2sGrWlKpfVPWxxBWA7Kc5kmv7huKVIJLidzDe62BT
         YvKclP7MFNUzAqrqBcWhMRHegm7tOiwkYmdswxybSB7j0bo6HYhAOiHZL8HSJTslGWfP
         9SsLk1KdbIGyriJd4Wch6ouo3WOBLcP3zIWftozkZC6eHVu86CklE6Pl1bEIKC8eb7sm
         WjSU5GLX4YvtkrS2UcXyiA4baqnN3uvCJ7nVliRHTHXVxrFATD2Ocj/CB6wOcs//NC0Q
         o3FgJn0ixs4mPcZJz41iq1HVxKRQogHIAe796UexM0xaYPTDV19z5MsFty5f3fakFMku
         vTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780498603; x=1781103403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKJn4y6UdkNefa3K7Wo+4bo+F/TyK5NQRV75EX80JCY=;
        b=ITIMU0M9yUtSVWsCqL2zUZtfHWDt995PhddBfo+/EVbHvaLxAaoT8kX35L70SajKX4
         TAbK0lMMadZ8HtEUetNOcJ1Mjfyzw08ZdeRvl4bC6gHucZdptSl87PIXuJDXAL6ge1LW
         aDifP46a8AsR16E7gjVSQvcIgGKjyVZM9W9Gg0YTVGjzWbGvGAA8u+DGmT603tuD3ReE
         rmAjq7PUKjQRTRjoBVPuk1jesuXUdBcmH07xCkC25OBtC2eNOyGtrvgdHLCjwsNTLwkI
         CMpFHCP5cUsaU0/bjkv8nJyqLb8jxHLlX9oHsMLycJQAyxfc9PaHpLV6JNDdUPD6TX5H
         ByZw==
X-Forwarded-Encrypted: i=1; AFNElJ9lf1cfNDlZieLbsVSqY3eNrnOtupvvMQ4zuF+6rKF5T/27y6j8aaMbsQE/stBUvku3w1v1VPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9htghQCXr+gyqlkWwNBhvX2eDi+awQ5AAsTpaRIuHy90qeezj
	tGm/WIS+51XkyUdYNzG6Z1HVRoqHBS8nCD2KfFrxut8Q060KHp3U5736
X-Gm-Gg: Acq92OHV9qN8im8tL9ecjSIJlVBkt5KEWIrmO02zxhaJCb7/GKzj0FD6EIdm9NwjTXw
	yZUFTMsoqhVAtPGz9HaZRuGLASU/MJ9rNlC5o+B94IALa18CFwCzvF2o+LffHueQvkwf1OV1YoN
	s+CFNnrJlb5+SYEerUkkC0BL0pA6HKT2l4WAcGaAXose4IXilIN6XP+YVgJGcwvL6LGRgt8ZBAi
	uPGC6Q02eE434FIjuHJ4yapFXIHkLdM83pX8P2/Yb9sSCUYJokSOBYY16cUk9G0s79vb6BfqymW
	BMpERMKqZCfuCTH37lHRMk1TdttqEL3Ms6TvSBoDI4DLxpKlZOFseGoiM33t7x5fQ6/ThWWE/4R
	2biYMOY98RzYJO92dgI5lSmz/jmIRAZuFY6zu12CMiG5A+Jo/wJ4kYJmmCQwQaejtvGvbreDI3c
	pFMiO+8yIRPZjcDBEjklXmjCf4S0w=
X-Received: by 2002:a05:6a00:bb01:b0:842:5a8d:303a with SMTP id d2e1a72fcca58-84284ec9692mr3998628b3a.37.1780498602943;
        Wed, 03 Jun 2026 07:56:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:57::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282915fe8sm3390839b3a.54.2026.06.03.07.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:56:42 -0700 (PDT)
Date: Wed, 3 Jun 2026 07:56:38 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, daniel@iogearbox.net, 
	matttbe@kernel.org, petrm@nvidia.com, dw@davidwei.uk, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 0/2] net: devmem: allow bind-rx from non-init
 user namespaces
Message-ID: <aiBAna4cr1KHEQx0@devvm7509.cco0.facebook.com>
References: <20260602-nl-prov-v2-0-ad721142c641@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602-nl-prov-v2-0-ad721142c641@meta.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294796-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bobbyeshleman@gmail.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:almasrymina@google.com,m:daniel@iogearbox.net,m:matttbe@kernel.org,m:petrm@nvidia.com,m:dw@davidwei.uk,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,vger.kernel.org,fomichev.me,iogearbox.net,nvidia.com,davidwei.uk,meta.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,vger.kernel.org:from_smtp,devvm7509.cco0.facebook.com:mid,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A713C63933B

On 06/02, Bobby Eshleman wrote:
> NETDEV_CMD_BIND_RX is GENL_ADMIN_PERM, which checks CAP_NET_ADMIN
> against init_user_ns. With netkit and netns support for devmem, it is
> now useful to let workloads holding CAP_NET_ADMIN only in their own
> user_ns issue bind-rx for a netns owned by that user_ns.
> 
> The first patch switches the flag to GENL_UNS_ADMIN_PERM so the check
> uses the target netns's owning user_ns. Init remains permitted.
> 
> The second patch just adds test cases. They are identical to
> nk_devmem.py tests, but using a non-init userns.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v2:
> - some pylint fixes
> - fixed import issue
> - Link to v1: https://lore.kernel.org/all/20260601-nl-prov-v1-0-9bc57d6ca3f3@meta.com/

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

