Return-Path: <netdev+bounces-302132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GVTeC8dIPmpvCgkAu9opvQ
	(envelope-from <netdev+bounces-302132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:39:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB09B6CBC18
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 11:39:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KaZbZ040;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302132-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302132-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFF40304B666
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6B93ED3A3;
	Fri, 26 Jun 2026 09:38:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724C3EBF16
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:38:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466720; cv=none; b=rItq/banRdZmj8TF8jXO5oie/HUrUQJAiRJWd9Iul1vnAFhmm2YA7wDvdW0BRzsqebhvfjmkIqS+UG4LSvH+CMfPNSNIOuAz29yCDz15A5U0410lSKetgKwweyPCZY7q4A0p2S2oQpEVI5sP12GLONebtyJvdcbl4IfN1n51siU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466720; c=relaxed/simple;
	bh=JLAIROYePggFfJJH59UH4ireJPYPOsIoeVi6uJuUcDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maAl9j4IIiL2bmcWA967EWSqmvgYHh4smuY+JwtXVvMNEX4hgJfywAtXys9xHwKJ4lKi6X14Y6EjTVzY1Bc4QTy7AOz9N0b1g/8vzdkxe3CwlRFnAO2mcuhTYmGKBaIGi5lrj9n6eDpGBgtLpaTF9MRVB3z07jcFyBCSorl9VHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaZbZ040; arc=none smtp.client-ip=209.85.167.42
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aea4cbeb94so567384e87.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782466714; x=1783071514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLAIROYePggFfJJH59UH4ireJPYPOsIoeVi6uJuUcDg=;
        b=KaZbZ040pxAKh8WZxDgx4yp9V4lNiyl+iVVJgEfWGPZFj/DjnEnMYvV2Y8bwgOpjxp
         DSpV4zHeZwAxjXayA7nA63Egupll8AkPjC/WHn328Muot8u1Mw4Bt1ymuslh3DPIyI14
         vcHiFnVCO3+hjU9a6i9wwWsE/IUjwy4IDSi0woWe3eGdbz0rX1JikbB30AYCb3AT+oNE
         SnhpvseloeIwY5UPnfYGUFbRrih9XCFoqivD/O4I+qeDpkK+H9We0D24W113PrQ2+XLF
         t1HJgGs1esDe/Pb6IHRBbscO899huux84H+GMEN87NhwJBTI7G25cpgQ6y1WBblMKNRE
         Tr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466714; x=1783071514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JLAIROYePggFfJJH59UH4ireJPYPOsIoeVi6uJuUcDg=;
        b=cydK6D/yFThRtJ8wwrnWpZDMynI3Do4fCnyFu1GH4ciYGClpGmLgonAWwlg90KgWjW
         7qmOvcWZkdr2X4rXvl6THB29h78nRFSPg8PMiqwV2ZdsfW3iNy7XMndyzqYuf61mdL8O
         UVn/4eCGRtvH0iH0QCpmyhGvs00cXI/8tWVvatrk7JB9vvex270P+1FD+yfRyuFGTvpq
         8MXRb/WyhhSfo70nj9VBvDwZ7hSWtJ/b5wMuVOaGhxfx3lb1fk1WvICOXl95xihtk0rz
         lsRGEy1NYkrVZSWa0rkoEBdVCmb7l+TONxW8Csl88MUfPjCowZvS5ouTfNPYIlwfWVi3
         dYSA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2n/NElT7wlHjnE1mAEZPz7IX29weA7mxny8OQ50GNzSTMp0ETC1J1u7qtuhyooB0XH5qgvFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+ALUQ5NbNHdH5qXCFWHhYrts6BA5mcNcl5jLs+p4a89k7WC3
	ApCFXCY5J8oej6r86gEGXbk1zMNVIayk8WTW18i2wX8/wbjr57RasN1D
X-Gm-Gg: AfdE7ckMgRu/2hK37j3T9mK+dZL02DbardlO+R80x3Q6c/t/6UrGdWO+SPSNSXKzafM
	4ddG7bq0ss0Oy5bRGvmZZQnhko3WZyYhh8BctPxqrCJYmTge6u3FK0uyxAFBbic9hsSboZsWacC
	l18uOaXCMxQM4GBla22R+zuQj/dDSPqW9H0kGC40Q2IhSXWYw2ptIV3ppPs1MSaae9nBHTddLL5
	TwxSUbAcLQdolSb40o+RV7+RLUg4Qq2M4Qip2YXM/t7pOBZPT6f82g1KFV/rNXnBLW7dtnWgtG7
	u6b7JK/KiLHRHFGjRn/pic+KsfHa6ZSQUmK4pQP1ZxD3OrXwSu3FqJ3qrZwpNZPMZUTcNTuebbN
	/pqZyxfaWagztV9rPSa9dZaC6wBukW98iS73Tt0YekJDa5jqKLZ6JQn0Je310AsjGBKnj5lbPSG
	AkUad97BmHtVTakXEbnby/OnKPRa/d
X-Received: by 2002:ac2:51c7:0:b0:5ad:49da:67c9 with SMTP id 2adb3069b0e04-5aea1f48c2fmr1756704e87.18.1782466713996;
        Fri, 26 Jun 2026 02:38:33 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6954a5bfsm3270613e87.4.2026.06.26.02.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 02:38:33 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: gregkh@linuxfoundation.org
Cc: alexevgmart@gmail.com,
	bestswngs@gmail.com,
	coreteam@netfilter.org,
	davem@davemloft.net,
	fw@strlen.de,
	kaber@trash.net,
	kadlec@netfilter.org,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel,
	pablo@netfilter.org,
	sashal@kernel.org,
	stable@vger.kernel.org,
	xmei5@asu.edu,
	yoshfuji@linux-ipv6.org
Subject: Re: [PATCH v2] netfilter: nf_log: validate MAC header was set before dumping it
Date: Fri, 26 Jun 2026 12:38:20 +0300
Message-ID: <20260626093820.196664-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026062658-pregame-buggy-ccbc@gregkh>
References: <2026062658-pregame-buggy-ccbc@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,netfilter.org,davemloft.net,strlen.de,trash.net,kernel.org,ms2.inr.ac.ru,vger.kernel.org,vger.kernel,asu.edu,linux-ipv6.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302132-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:alexevgmart@gmail.com,m:bestswngs@gmail.com,m:coreteam@netfilter.org,m:davem@davemloft.net,m:fw@strlen.de,m:kaber@trash.net,m:kadlec@netfilter.org,m:kuba@kernel.org,m:kuznet@ms2.inr.ac.ru,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel,m:pablo@netfilter.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:xmei5@asu.edu,m:yoshfuji@linux-ipv6.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB09B6CBC18

> What kernel(s) is this for?

5.10

