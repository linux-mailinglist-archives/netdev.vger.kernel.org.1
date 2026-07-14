Return-Path: <netdev+bounces-307614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dGLpK8jAVmpPAwEAu9opvQ
	(envelope-from <netdev+bounces-307614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:05:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9C6759504
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 01:05:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=giNXFjhk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307614-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307614-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A057B301A1D2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD36364941;
	Tue, 14 Jul 2026 23:05:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E222DB78C
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 23:05:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784070341; cv=pass; b=k8TghhHSbJN/C93fyQ7W21QXboDVOn/u/Snf4a5MOK3l1L8wXfhSiwp64Ra3M/zA+tuncH2ABccV4cM5eVPwb17QiT8sh5tqMGsNR27nWZGa+CoNCf+5eMc7i8fdfGE8uP4ehm/iLfELUPZtwAXhNctkyCuS/kBBLnn2XbaoraY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784070341; c=relaxed/simple;
	bh=5yS0n4m24nQ7cS0uAO0etHXioBeE2HNrxAIlQrrccBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EA2k3k9SWPJW5S8eTI88jAIHsJsB3MKoJEMwOa3kX3V4pp80NoySQrPMVQYasvMcCsdAP2W60M7etqopFdAuraCEj0WnYzefkhB2cY7h77MDQ/XVhnF1ipQHOIIljeGtRp+phYP3DvVqXuqrLkfZ8OR1KZrx7QNNnUdRbn/6bSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giNXFjhk; arc=pass smtp.client-ip=74.125.228.71
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-69c42e7735eso3102523a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 16:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784070335; cv=none;
        d=google.com; s=arc-20260327;
        b=fkD8ZhzazdVmdfgcQiwgiEytBl75PQi8COLogAwg38zejrXPUNcb+XsJ7bhMr6MFho
         Bn/EWyvo3AVDwKvAbNRgnxVSFMxuHmckbKqHxienCLQoJhuCQwSOoJCnaiqEbq0ztiQ1
         C2p6/BcDB5w2BcjGkFhSdTHsk/xHD4RebI11Wf9WQi2qhv7Ae+DuEH2nBUQ7L0kCAjuh
         qfuqH/uW7uy7R+PZ62EgXmSgcEe3uuo2KqNk5J7SjgECxPU2hlos8Vo/ezRma9AaLbxk
         J0/vyJrb+e9sHlWn1H/P/cIj52IXzl1NQ0esP5eXCRyCUmRmSVgLbK3uyrgdwShvxQYB
         b3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5yS0n4m24nQ7cS0uAO0etHXioBeE2HNrxAIlQrrccBM=;
        fh=Y85pxgoALYip4pByQ/gSxgo9n1DyX26z7BUGVvp96LY=;
        b=ntRzU3mH/AZ+JvRTcAvq6w0VmYa/Kt4b7LUIpfsmiM17cpD4Oqu6+b/HfTwIDWdUkv
         GDX5KHiKgBfJOXPJQmPgevaj9CsbWXR/OonLKtFBSAMxTMoxHnWQXzklS+ATFR3s8H0X
         u3AA6XiwGzY4oRWWh7fW61nY9jd1h6wl/nYhSDcZCUiwyDpXl5wMq/zfcc6/Xd02fZXo
         bVB9nsDmA6efjvj9M6Qcsyg0EbdUAT2T6/QVvDDmEYr69DRmTm36sawG3UX/ibfBirIX
         rdOLEsL/f6mcMTQe05CUI41GfHb1aHL3fKLOQ5ntt4cf/YWAYz5rPTWlLBW0SqB5hk6s
         FMpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784070335; x=1784675135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5yS0n4m24nQ7cS0uAO0etHXioBeE2HNrxAIlQrrccBM=;
        b=giNXFjhkOYFjP/Borbg7g1Di2AB1wYPs5C0L/U6XAXhYfljCu9W18TUM/GlVFOVhVf
         em/N1+e6IsrCyk8dBRtS6WzTI3XZNskM8ShwO1ftHoyHZRFk46tdmLDrs5yc/77LIG5S
         jm0Y6OlZv2tHnts1gU/kYjuKdoacFH3Jl048PxRCqS5y/O+WeOVeV3MyvbFR1omlsQQx
         n5FhmLSnUbAu5C7O7q0J/1aZEYTyNBmtKeBzFp1w0h4fJ/TaC08bikjhYMXvWABA1LjV
         sdk4VGsORzgaoIdSHuUpvmOI/mv2RE9t/4RYtF1S/3VqPRrR8YxpqfwnbGiVFhXQC3VI
         xnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784070335; x=1784675135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yS0n4m24nQ7cS0uAO0etHXioBeE2HNrxAIlQrrccBM=;
        b=L3TP0UEDvTsc4oHKJmjCIG+X19g6VUCpteqNxb/Eo1DNvdhhjTIu1YFaG1eeJ1HpV4
         VVPbW434SaGkKfQA/s67zWAJNe6TLiZGnIvsaV0wCh65tyYM+Z0vXDLzmSLXMN5Qdyci
         ThHjnxR4ezOcG4rww7DXve4wRx8EbFhivsbxq8DXq6D18DORO9aX31DktVqVzUHPEQ5m
         6xs3lHR3gbHqlhMdqpveLu0LW8MhZXkDpCzYGWzzPOsu5zjr3L3IC6AAIwpDEHJMXHKp
         +UIqvtB2YiLUm3QH0FU24ilrmVUbZDN1BSJcuVqUr7unAuQJA/nd9WcDGnKPU0W/7OMP
         7vOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpHTaBdMH1AiqopIyRLp4g33SKGqdwUdJMgLe/bYdYud76bpbfdP5m+jH8nw5reNCvbT42lhNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMS1PQOL5FGqfQ6Dpmm3CurLztxFqxgijuAu3uY7T8uFetAJk
	9eoe0q60oKtcinJPZb22GV+cLz+79QDewqtRG4xISrePVK19//l1ymzwOG54z0q++7wBrNAsVY7
	eKiKBu5DA7mw66Ew1+5VpgH+XUnYxZSQ=
X-Gm-Gg: AfdE7clSulcUrQnNtLsnhnP7V1bF29MujYLzn+cqVsvU5qtEHSXyAWNJnlLo5q0Lm5G
	DcygTRMLNvP1b2tDbDX8NekiJRq1Jkml+1NxdmC26tN9dkgakcmYEWDFMD6D7Mwcb30Q17erPVY
	1HruSAGCcwuXuESl7cPR1WovJcrU1DOvOBJ9KHiWHII/jtOUIU2BOaBJxX9Dp5eC/11NvsdXnE5
	GETgzYmQH9iE19xWiarE6pIbnCK9lLnyCRnhX4f9veBwOIFPIaKNDpFx53JnphXkGebEJi7q6bA
	oTYQ/JQrrQ==
X-Received: by 2002:a17:907:3d55:b0:c15:efb1:9ff7 with SMTP id
 a640c23a62f3a-c16616ad29bmr332320166b.28.1784070334544; Tue, 14 Jul 2026
 16:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714191341.690906-1-coiaprant@gmail.com> <20260714191341.690906-7-coiaprant@gmail.com>
 <464cbdf3-2e9e-43ea-b30a-75b3d1b8a188@lunn.ch>
In-Reply-To: <464cbdf3-2e9e-43ea-b30a-75b3d1b8a188@lunn.ch>
From: Coia Prant <coiaprant@gmail.com>
Date: Wed, 15 Jul 2026 07:05:23 +0800
X-Gm-Features: AUfX_mw_zrKoDsMO8kJR8iRpLq9HGKaiImf5TsHlB4TM3nCjyfFFksGlOJoy3Z8
Message-ID: <CALj3r0jdkDEjpO+7NOTGs+wgukKvD=fzFn4ewpurxxPswCE5GA@mail.gmail.com>
Subject: Re: [RFC PATCH 06/10] net: pcs: xpcs: improve SGMII AN state handling
 for Rockchip RK3568
To: Andrew Lunn <andrew@lunn.ch>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, robh@kernel.org, krzk+dt@kernel.org, 
	heiko@sntech.de, netdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-phy@lists.infradead.org, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:jiawenwu@trustnetic.com,m:mengyuanlou@net-swift.com,m:krzk@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-307614-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,get_maintainer.pl:url,lunn.ch:email,net-swift.com:email,trustnetic.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE9C6759504

Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2026=E5=B9=B47=E6=9C=8815=E6=97=A5=E5=
=91=A8=E4=B8=89 06:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jul 15, 2026 at 03:08:34AM +0800, Coia Prant wrote:
> > Commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode=
")
>
> You do not appear to Cc: the Wangxun NIC people. It would be good to
> have there comments on this change.

I apologize; the output from get_maintainer.pl is very long. I=E2=80=99ve
heard that having too many recipients can cause the PATCH to be
rejected by the LKML mail server.

I have added Wangxun maintainer (Jiawen Wu <jiawenwu@trustnetic.com>
and Mengyuan Lou <mengyuanlou@net-swift.com>) to the CC list.

> > Fixes: 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode=
")
> > Signed-off-by: Coia Prant <coiaprant@gmail.com>
>
> Please don't mix fixed and new code. Is this a real fix? Should it be
> back ported to stable?

I am not sure if this is a specific characteristic of Wangxun NICs, as
I do not have any available for testing.

The behavior of the Rockchip DW XPCS IP core matches what is described
in the commit message (even though phylink brings the link to down
based on the phydev link status).

This appears to be a bug (at least on Rockchip platforms) or Wangxun
NICs features.

However, I cannot confirm whether Wangxun NICs behave the same way.
Therefore, I have kept their code as is for now.

Could a Wangxun NICs maintainer provide some feedback based on testing?

If we can confirm that this is indeed a bug, I can submit a separate fix.

I would greatly appreciate it.

Thanks.

