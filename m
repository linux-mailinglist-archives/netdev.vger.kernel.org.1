Return-Path: <netdev+bounces-304478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +q2qM72FR2o7aAAAu9opvQ
	(envelope-from <netdev+bounces-304478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:49:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E14F700CFE
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:49:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YGXFgAOo;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304478-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304478-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C49BB3007505
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76020357CE5;
	Fri,  3 Jul 2026 09:49:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D037BE7E
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 09:49:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072186; cv=pass; b=l46SOzK8DscnBr9a7FIllc/GGLaC60CiBZbunCSt7V8KDEgDASKb/P3tkHOGYHCOJcJUB6rgJcw4PIRyBlLWjzWgU0T2+L4hPd7M+5VkVQLHfduvg/IO0ilK6UOr8g2vKEdX9RZnxHmFpT80ExivxO0Eh6CVSZgeBXdP+ySCGcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072186; c=relaxed/simple;
	bh=I3zdDowGBRn9VWAaWs+ZwXIN+DEa+lcvT7ixcQo6VRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdUGPVUIfdfNDUOTTtEPXsMBBNk07W4OGbTUbJkvsqL509OinUmEI/0aZNwPQvyiftTP1ANDmWrC+73IMQtCaRqr0PRBqemc3gxQ75STUletC6ZXAzzhPqkmDW+aMT474kj0zw2dfWCd1RMA+NriNo9pGWhWx6uRoCK7g2JMfLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGXFgAOo; arc=pass smtp.client-ip=209.85.218.54
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c12a430d71dso33969866b.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 02:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783072183; cv=none;
        d=google.com; s=arc-20260327;
        b=LtPVE5HPn/mRXn7SAVe/VMAC3bvLmPNO8Q+ql4p6WGrwbD9YSX1tKeNQQ/eNhAdBBW
         xO8LxmV3IsqY4SNkxwKiiDtvjmN2XnhKgpAyal7TEZcXLPScZKlxAocJ/7wneeGyrr+K
         2xfdZY5bNoW8jrUXaKTTf/pcPpMAs6SB0wVsFOvWvCT94odMYNAZIM5glgKF3ilFWHke
         WwibujJ8WZh+s/lYtylE3JkaRBfGPXcPYmh5juRdsRJbuCB4D324JVFYH5HLJuvCDBBu
         7kLpmg6nnvFLCXP2wza9oXjdTSe9cUE+LeMIigXMxOTpG1sAXwDkjCo9b22Ha4hWKgqb
         M8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I3zdDowGBRn9VWAaWs+ZwXIN+DEa+lcvT7ixcQo6VRU=;
        fh=7g7oxySdstfnEovTL3b3mXKvdfaO9WE1tJ1vKS6DJLU=;
        b=rnNS9G5sEMEsXawArTSs4AiMhPQB+zhD7e91RpxePES8HBHQRPAx8AmcSe8fBuwou5
         PggwTVLm3f/gGkgPeds2pBVdhmDsZrpTeoUfuEPdyd1nR7uYlOWt56E2KeKcL5vfo42Q
         vCrt+xLgZF+/bKJq8IVbpn70MNr5OlsUYc0oYM8QvHEX+fTWTEXOB0Nj+M39pDg3nN5X
         ntfNmhF2r7BWSunjV1bg96sfgpSasTBQwOH+nD8m3yl2syIE2yQoNMtK6Iqken1GA76I
         Ny81hyNI81tqwygOoX5u9lURD46/xDz3aKVzGCW9dP4+5vTqejHHu4/30ZsuMGay0Db1
         Db2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783072183; x=1783676983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I3zdDowGBRn9VWAaWs+ZwXIN+DEa+lcvT7ixcQo6VRU=;
        b=YGXFgAOosuSmyej8uhtNzQSWGas879LCfBcizMwp7Y3jTbTu98AGzcs0ERte499hcr
         1CBNZZpuf+drhFpFbikYO1DtySymvc+Zx7JNcDWZhP3RMT6JaFXRDUj1So2ORUANCtVa
         csrVwWLXkwbispYnRzkztbDh8CSPJHEQnxhyr+D0D0vfrXC+vSRZxVnyt0bcutnTQh7r
         OODTDLE1PsnI+jn/DWZDV0wTUQoJVOwwKLm2G/BmJI9L5Cc09CSkZ6q6f66BkPBqzOhC
         um3anJ4JEP9m1DN1AtB449HfRgWfv4044mGajXydnPV302eRh0LNtddqA5Mi7SHfcG4g
         1RdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783072183; x=1783676983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3zdDowGBRn9VWAaWs+ZwXIN+DEa+lcvT7ixcQo6VRU=;
        b=nMSwgh5Kg2Ur1BuUisyaRIgkR1yb3yJlkqs/aHHwOrhV/IFYZYdJumseYcFbsD7b4D
         dAf/IQy7m0m5Hgxxi2F2efffONv6bR6QaDgRp0rYX4rgkLA+u0KUu5ScbykP6BLDzK5v
         nH2KJeCiKJvvz0y+Nu/D+oNX4YWmg2t6N5DyWjiJwSNm7Q4bAwNX7tQzShOxG2L+nqTw
         pucvyOx4EU1ugS1bwivEF/HuSAzwAZt+9EBRl1ymmNvNyn5rRoqiepXGZww3xc7KJ6Ci
         Mx5GMvXlzzuQEymKqnncVFeWJX0RoM3/WQZA2QgoVe0izUeBGMH5oC1XH3usFm/zgh+G
         uqZw==
X-Forwarded-Encrypted: i=1; AHgh+RraiirtZfDTsg6kxjU+iu4j1UkH+XSCB7M4OJ3rbEjc8FexX7Gr+BrQ3A4+ZyWFgKcciYA7l8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBm/XUKFC3IcRwS+LUEN0S6IC+AI9/uUyibHiaBGBUG8gSc4EG
	6QX4mijhsKNlD1vsFvFIob/BvJjrR1pG+VgCQUcVBiFn7poH0v/5SxUsP854nyfuOluoZLUR69z
	Oze8mbRjAR7Km4xuU/AqO6FutLaSDZZM=
X-Gm-Gg: AfdE7cneeZmx9kx0IcJtwzE1rFyO7C4rAxuRldABanPtOgLKWpOyj5Kk19PqPkG2Ge+
	DyKra+Krf05Pfp/HedW0D4NFYR9pTeA06CiO4CDqQnJFlSCBHJvXaSks0xNoiiWApPyWkM0g6+I
	oR/0T5OJ2DiH0XIo6HhWB1orosna1TyMrK/WfUOLVKAHrtcYkeQaA1OPCRC3agU83Z+/nHgU1lY
	j7e1kChRO5xj++UDf4Ad08jGyBgWyUMGsXf8Fqz1EYyDqhUlHM4Y8XTPkaFT8NsLzGC6QDzOQ==
X-Received: by 2002:a17:907:ca85:b0:c12:8f7c:6157 with SMTP id
 a640c23a62f3a-c12a9d38175mr393482966b.8.1783072182340; Fri, 03 Jul 2026
 02:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703084244.59077-1-running910@gmail.com> <akd4sLY7qR0597Si@chamomile>
In-Reply-To: <akd4sLY7qR0597Si@chamomile>
From: Zhixing Chen <running910@gmail.com>
Date: Fri, 3 Jul 2026 17:49:30 +0800
X-Gm-Features: AVVi8CcTVVhVoXiQyk2qh7ewOWUlOAKk-M52Jm-DtZeSiT1BAfUMT8x5_5Zs6qc
Message-ID: <CAMyuFdVFb4h368_nthLhPsPMOfgptOBU5+hmDzQnFQP9JqdzkA@mail.gmail.com>
Subject: Re: [PATCH net] gtp: parse extension headers before reading inner protocol
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Harald Welte <laforge@gnumonks.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, osmocom-net-gprs@lists.osmocom.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304478-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E14F700CFE

> Missing Fixes: tag.

Thanks for pointing this out. I have sent v2 with the Fixes tag added.

