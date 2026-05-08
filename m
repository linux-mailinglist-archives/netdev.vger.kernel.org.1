Return-Path: <netdev+bounces-285826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFiLIO7g/Wn0jwAAu9opvQ
	(envelope-from <netdev+bounces-285826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:11:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5DE4F6D0C
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0BA8301C90A
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C37347FE1;
	Fri,  8 May 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuT5yuJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4743512CDBE
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245866; cv=pass; b=LUGhaNUcAjz/8RXLKEZm7wmYP+/Jg/3W1kRGjE+fB2TN0fXejpS0aXMff7NUSawLVUmCWUxP1PhIzVklEewRopyRG4EA2rO82Zbq0QGlgPk4Qmj9nZG0I7jToCXr1rThCsTLkTzauiacxHjftqU3aV+QL8ivMx3Kac8rPnXlQUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245866; c=relaxed/simple;
	bh=Q2p6RtJ3zfFJHYB0dynXXwUzBesfE7braw4qjAb9U4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUkN+DAD4hmQx2xRbCDqcHhFrmh2XnfcL87EnKYD54jYDqzSf9se3X5iXoWsSO56T/rOq+w3REVTdrgz2hbdT8dhzuADwonwYbpZQEvMnJn9LOhzvwlUxsWr3QUA5QCC2Z2RsFj/kHgVWBI6H/OB16x07DKLiz2TkAREwN4PY8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuT5yuJL; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67c3cb1433cso3302370a12.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 06:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778245864; cv=none;
        d=google.com; s=arc-20240605;
        b=KQ0PBNmWnAWL0K8me9SW7AFWRh2SK98MCPyte4QZKP/PHuBGY3pLx16S4VAJrRodwU
         sHFWz99qfKaAdWO+Pzv8YAIAgD/lQzIFCVw2REGN4mmxodrXOahWRiR4qnXgg69jRelL
         vvAoMifxQDlnmhf6IXFkKesdvg3W2T88ho/Likoip6l6HsQcAos6GAq2dOz10oHUZspj
         gHv8R68R8VX7wp8TTc8NAve75ru/Uh8WAPd3vMfmElNhPMcWbQkj+KDav7YsX6YYiv0n
         AQbhgFWybcBwS2qGP1MB/d8soasRJ+KdcDjgLD+O9drcQn0B3X56FK86g381HNNivxm3
         QyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q2p6RtJ3zfFJHYB0dynXXwUzBesfE7braw4qjAb9U4M=;
        fh=u1iPs+udEhcQv1O+mYQn5KrmvdjyO9dWKBHin3YB0co=;
        b=jiCTxLJPhUH2jxqYEP+6k4tGzIk6u2vgUw1YT2k3Z07uQj0GtF5IVj4wV5H7bhRYZO
         dB7sbom78yGqHumcBZ/4U8/iIyUV0/j2ulIq2c7l8QMUTPHQj/fqVN/fDBWaq4Cg06Wt
         I2KfKLxBbPg6egBJjmDr+y3He8HxD5JfFTtoY/yaDYshvm6jrDC/FmB9gPzwzc/8DzNx
         1kRIHgNnWf+oS5x6Vy/3iSF/k91/Z/l+qFXhHl6SYSrXNtyG8AOhApluLCf6gsvSMW5u
         70+ffk03yd8wzx0lE/2U3iyYNp6GKykQwDTZO0Tmi0UxNF+5gBXh645zYTPXHredoALz
         5o6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778245864; x=1778850664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2p6RtJ3zfFJHYB0dynXXwUzBesfE7braw4qjAb9U4M=;
        b=DuT5yuJLknczffYtbCoymLJ/2cUnSxA63jdiVUSJ6SPh99hUzmRL8uF0OVzQOdVnHx
         70wsen5F73RyLH0AQT0ThVAP4OF+i//n6o5hOzXnnLYhyJ780TewW37VvuFligoT4pZB
         aoNbE+uuCBIITWX3tl53HddcUgoAi3Kf+HIzEVpp6XRmjbJDOlanRMspRusKDkwQQBFc
         1s8c9jq0NX9NHsTLlEeKfdtUjbLPFOyhBGArr4Q0Ls90Q5x8lN/oQkt5whWRrBC45pXF
         zpkLDK7B0/CEOxEKAyyvRFzPOAI0xPdIYbwL1X9F1b1Nfj8A1ZrF3Tb9gOa67gz+hlQW
         TYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778245864; x=1778850664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2p6RtJ3zfFJHYB0dynXXwUzBesfE7braw4qjAb9U4M=;
        b=W+0g22eHLbO3e+UZEb5DYWh3oioAocLee+1CPUynSX+VQdLIifY29ooDo4GdyZM14C
         WLPZNYBMUpup1An+4KjxfN2dybTT8L/hGyQ32wWcXW1pede1kqBtq2W4+CzzrgA5Fqoj
         i98D56Oolf3trRWUOz7kiptZFcH8yxhlvnQEEtBR7TUxLZctzxCTonKl+6xMj9gcsCZI
         mDSJdJExPTu5CKNmwv9v8fc71EphsNKFUsk8Gm+TK/RxJTchn6iM2p4a4OY+61xX9nv8
         AxxfIzFgPALNgfwfB58cT7YB6L8TtXifUIkR1Mh+VftD+ZJFI3Qv4MRr0kdjUb3Q1/wo
         Po7g==
X-Forwarded-Encrypted: i=1; AFNElJ9t1VBKfazmWA876R738Q8D4u1gp3nXuxsngsirCqPI67fm0+ulUeh2xklNdPoGfONb21EoYLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8UWeVbdMwzYLoBY5wjETUoy1jLyjfA0CFDiyZPgKblmkcTIW
	yRE+R9HP97D1YdBAhT2ICk2vTnOjnqct/68+norB7My4rR6Bjnnhk9dBeuSb/nknTaEK41aXGPS
	35XTn474eBB3OakQHNHRKdZcCcPlaHdM=
X-Gm-Gg: Acq92OETM9zl5Q/o9Tp4srThcoIMMWRc+d/ubNemS3Nhj0DNGniK5HOLshPs5nzwI0E
	AjhwodBVRNAfRA94e3sKc/PxZaVdfuqNs+tyKmuQUULBxj/OhWDGkipr9w0IWOynKt3MEbyKY4m
	QmhwD69VcjCYJZq/BYML/o+FzHwNSluPunSVdmhD5oa4fEtfVXF1a/6Qa5oWWeZj46h0Y//K2BS
	29ofzM7z6FTfiq6QotR4b+JRczd8nrRkh7n+l1RgIGpzmcx5oK/OII+bCVtvnGZXZmLVbxdB0dM
	2Riww04=
X-Received: by 2002:aa7:d50e:0:b0:67c:7ffc:c4b with SMTP id
 4fb4d7f45d1cf-67d642c35c5mr4852121a12.19.1778245863303; Fri, 08 May 2026
 06:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2a52d7a8-3a39-4dd5-a0d5-c746122a9f73.ref@yahoo.com> <2a52d7a8-3a39-4dd5-a0d5-c746122a9f73@yahoo.com>
In-Reply-To: <2a52d7a8-3a39-4dd5-a0d5-c746122a9f73@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 8 May 2026 10:10:50 -0300
X-Gm-Features: AVHnY4KygSHwEN6JQafxG3zT-YLOiU_k7CQWEMc90CVie7UxuzLB_IEviR89JJ4
Message-ID: <CAJq09z4vjb6+7QW-CBHecZsLQUg91cKd+9xo4FxPLjOiOUEorA@mail.gmail.com>
Subject: Re: [PATCH v3] net: dsa: realtek: rtl8365mb: add support for RTL8367SB
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EB5DE4F6D0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285826-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

