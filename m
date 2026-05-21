Return-Path: <netdev+bounces-290334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNByOnLgDmp5CwYAu9opvQ
	(envelope-from <netdev+bounces-290334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:37:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 455795A36C2
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3BDF30A4774
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F6A37DE91;
	Thu, 21 May 2026 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWP+s1fD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212E37C93E
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358089; cv=none; b=L1GPl1g0IiPkgQBWnxwHpQDqSeXkjaHF2YOxnADUdCwL+ofySGkSM2UAjxY2UxZ1knwJmts846f0+noGgTxO1srF4xbN/zmn9L2pQiCkQj1NITWQNo5Sf78rJVB5NzyuGCL1QS3yFFKEq0VFdaLIlO8GWIiTkN0DDbQFPJ0SG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358089; c=relaxed/simple;
	bh=8HPlUTLUEPHCnotL/RMKxMT3Q3j9pXUESqrm0jMSJSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIvpQkIH3WAOZi7H+Y4dAVCHxrKpirFPDyh1mLq+jxNvB3D1xZiZsb5lk7D3m0Ye/o04ZrYPUy7gQyhfXtTmHdAuufm7SEOhemVa/52vpAgyxzOLKs+39weQ5J1G8NIyCfEjwDOjrUwkjn8Xm8+L3PI2fm5FQf4TEcEo2JCkho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWP+s1fD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso48076815e9.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779358086; x=1779962886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufW7se9r2tjAwotKHVJInXowGJYWE+4jYJ0vi/0uHaE=;
        b=EWP+s1fDkVzgwGm93jsPtNiFvLdhOlQd5IAr+lxbxO1i8tFiCdZRXzzomUpliBSlZ5
         8J7ncoQ+CIPj6ixz+HNYKwWWMVtulxS2RSaNIA3oOiwvb5JJRKKrfZKl2ZlIoZ6zKli5
         SHyx0eYwktNVbgcvqiHhTJTdJw21RFn4+OCzFbyOhChq9gNN3pPygdP+HUTbpcM+HGH5
         z5GfQd5ZhrUi6cDrwa/YTDOl9ouJqZ7W1NWnhkxTmk0Cma35A8pnjP34FO+172yNm6zy
         CZH1HexWh9dhW6z8VOxqc/XGxi5VxKKRBFEa0tXZ/mbTBjihSj4pi8icCvhsRvkQrl7i
         f9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358086; x=1779962886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ufW7se9r2tjAwotKHVJInXowGJYWE+4jYJ0vi/0uHaE=;
        b=Du2S+cjKbfayT3FEncP3x7sGom3Ev+cPyLoDgwMO0A+R3UVsHKe3oGoJhOnWF04IiC
         IhJf8t/2Mc2JJqKxUZPl1n6bH7A1U7LLSmOGdLCB0nAP/nhaOTdlQyz/w3jEqAM8yuB8
         MqAWllGyGPMcWIfUwEg7E6YLxEjkpMajSkLJ06kJ6xW8eQcD05th90MlxkGr+3nexbpY
         I/Mgz1Ik7oXlD08cEi8yY5pkar3Xsh+YBshYMk6IQR8fGBw5y8ljFFYJWKDMXZh2Gley
         C/6IaTlQrzJxybmRFvw0ZA5fw9gve4aLQqKcziz5+pO6/sOOHEw/4fLwDlfk5xiDIRQA
         xQ9A==
X-Forwarded-Encrypted: i=1; AFNElJ/DcnL76XSBL/oC4m8Mo9960Wd0+ncP47Iqex0k/5FE6f09JVsQfDPV5MZilD44zqIspaiOWkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcksZ68Ls9fX5S+KbxEOmMFMMXM2j6SRAH+cHXjXEaVOtB7OQ3
	Ii3Y10ZKRsdRXrJ56Cq94v5ScrZzgbva4G90ZRz6QKqBVjjw73uiH6wA
X-Gm-Gg: Acq92OGuEpb56goJNOIaUht8898JjDo6Ni7SEi8G06obKHfTfbQmbAjXfiWv7jMQ43X
	BgZL1XLSLRjAY8kqyUc206yKLRft+zkAVoGSurk1mFgrAQcrdG2Pu8nk4qSHmrhgyk+Gu+XjfhB
	zweBcde4jRV4fXDTHUgmz8e2YeZ17oGJpKFYg8SMos0PQUrziwhJCPvrzd83+L4eDKg0RDSraFZ
	WKSmSo2x0oKZxwkSTb2g4c7auZ8TQXFN+alnSJZXQkDlSauyDYdqU+9gwadvzotk5Pc501sAW0e
	Z/yWHtcIIRmqyoLZHCgtRFiq0Rk2ytqLCwJJ9cj67ScF8yoBELd2gC/dH68/SvFVtfS9okVSDIw
	wSgTWj/6KmGKktuVbnJT5IH7CZlA77KA9V/7pKPEkPWia4Lq4POIdhrt55qZZpxrFi8IChFpeNk
	vXvxHlUxYg/Ow/Q+FVSIk0LHcvab3EcQAI+FIN9CrSzG5JLaCXPiEdQjS02K0xPBb7SDxTj8jiN
	fA=
X-Received: by 2002:a05:600c:a296:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-4903604ce69mr20506365e9.2.1779358086435;
        Thu, 21 May 2026 03:08:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035c29fe8sm17678515e9.2.2026.05.21.03.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:08:06 -0700 (PDT)
Date: Thu, 21 May 2026 11:08:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org,
 joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, jstultz@google.com, sboyd@kernel.org,
 willemb@google.com, nktgrg@google.com, jfraker@google.com,
 ziweixiao@google.com, maolson@google.com, jordanrhee@google.com,
 thostet@google.com, alok.a.tiwari@oracle.com, pkaligineedi@google.com,
 horms@kernel.org, dwmw2@infradead.org, jacob.e.keller@intel.com,
 yyd@google.com, jefrogers@google.com, linux-kernel@vger.kernel.org, Naman
 Gulati <namangulati@google.com>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
Message-ID: <20260521110804.654cf4b8@pumpkin>
In-Reply-To: <87mrxtwzz9.ffs@tglx>
References: <20260514225842.110706-1-hramamurthy@google.com>
	<20260514225842.110706-4-hramamurthy@google.com>
	<87mrxtwzz9.ffs@tglx>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290334-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 455795A36C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 23:08:42 +0200
Thomas Gleixner <tglx@kernel.org> wrote:

> On Thu, May 14 2026 at 22:58, Harshitha Ramamurthy wrote:
...
> > +	do {
> > +		*pre_cycles = get_cycles();  
> 
> This is a completely non-sensical hack. Why do you need get_cycles()
> here, which is a horrible and ill-defined interface that others are
> trying to get rid of?

ISTR that it has always returned 0 on some architectures.

-- David

