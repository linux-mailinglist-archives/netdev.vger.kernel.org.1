Return-Path: <netdev+bounces-268946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EMtB6p3ummTWwIAu9opvQ
	(envelope-from <netdev+bounces-268946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:00:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1DB2B992E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7029B3002B5A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA593783DF;
	Wed, 18 Mar 2026 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a27dd6SW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXQ8AVt4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139893A6F05
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773827377; cv=none; b=uywupKmuJEIdj+5PBdiDE5mbpnorVqQFzhyzzpT+RDvrcNJmTduiK/P/uT9HVlxGMeYFzgXZbI2r85+rFJSCy7jbCRuDe6sCNuKCIUI4bakAeeQ/60xUbDuJRYjlECldzq7EcCi0Zl3Z7eVUYTQNe1XCvO4otHTXAuwG3A2cXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773827377; c=relaxed/simple;
	bh=cTCC7w9f8PR0d94N69YTK7ENPP3u+ePq7cM2OGA7y/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoN0OVJEZJriGdJXMPKAEtOhPq2pKzCKvEzZWBNieKVFvv3ASgXmLHISPFUTkt0fefZttIhJzihRdXw2g/C+/Hf8e4G3KHVw/J+OczNn3di7KG+Wogqf0vsv/1rU3JD3To/iOlg0gVhOGntCWTgJFhSrr2mG6q86XbVNRniCR68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a27dd6SW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXQ8AVt4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773827369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePMb9OZqcDJWUHQOQ+oipDwj+1eLe3lTWhpodjf3fTo=;
	b=a27dd6SWmswLr5ZEsGKCWYz5DqBDUDB6Ek9empn9dhrEe4Oh53BBdw2+p+T05GXeL5LW4i
	bvRuwShCQeHfS5NzDaOxqiz+NLGpmakLUG8794h7SztcUk7MsBxsL9G934noEiuC+YH4Iy
	Zrw/azJsplKVyMzKi/n8XQXyo26VIs0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-z3DifuHiN1aPgu5M8TuwnQ-1; Wed, 18 Mar 2026 05:49:26 -0400
X-MC-Unique: z3DifuHiN1aPgu5M8TuwnQ-1
X-Mimecast-MFC-AGG-ID: z3DifuHiN1aPgu5M8TuwnQ_1773827365
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439ae2cba40so6287634f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773827365; x=1774432165; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ePMb9OZqcDJWUHQOQ+oipDwj+1eLe3lTWhpodjf3fTo=;
        b=CXQ8AVt4DuiJqBz7apb3zNQkgIQYowd5/04nR9SfMW5SLMNFsSb5JJMtPRiRsvasaL
         dG6G1CDuz4M6Nymxt6lGNZiLcp16y7Oli0Uu3g+apKt2KQe7UQgm34AiA3YR3tJ1C5vC
         bkVaPREnKJ8PAbTy0A3TEvUNnyDyNNIcKXF4fxqI5FANEZ39Yy4X45ncea90ymBW6BN2
         VW47Sqs1ozzRTp9mJsFHxZRppi0P9ILbt+7jt6t/K0MVgs0LnnbHiCrcZaoYWO8TYsX1
         ruRucYWYR/kOVaNXTCkjAoGH6BGr7q56RT/smTm7daO/5w76KpOR7Moq8w19uIqOb0fL
         vPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773827365; x=1774432165;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePMb9OZqcDJWUHQOQ+oipDwj+1eLe3lTWhpodjf3fTo=;
        b=redxe080kS0RAFhBzkJWPQL2NhZp/1MiC2Xd6TVxA4G+X8wErLCimeFFhPRLFFEPUK
         NEcmqOagQWBXLACU86SWq3pCapAM+cOdAjQ6HP5quiBinhzFXTFWUMFmk5+UI5OjRLJI
         ec/NHI7fYENgeebKWjTMqNaHAQM99KoP4wCqwNsq96im1rr1sTdJwhzbNfHYZzj0oZAw
         eWjsIMexv/lsgUWiKTC0eyIu7oiw/rKnfmg7Kd0gRkof0amrOATPj7KDD9iuUVnuLOQI
         BoU0SmgkHDZ0EzdhTqBLW1xdEesvaI59wXJ0T5y2pqwIGII+qjGG9tVgEqtQgj9gndto
         /5nw==
X-Forwarded-Encrypted: i=1; AJvYcCWs8hAmtMYU9b1t5XEXvFKiXviEEh1Z3ddi7833/boWqmOEE/SRlBLSbqjZMCrOcnuXrkLhQOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytRItxNN1HtVRx0/RDTF5i5nncbZ/r/A63beC8919tUii+XrOx
	ZYEoiaQDEry39eWJnGPhI4+xwWGwFsnW0GR4H9PwehaoDBPFZ1B9ktnzJs6i6DylxsI4fnAChyl
	kMUAuVeDByIUGMbsqhL6hNPHPPumfDKc4HDFSk8+aM5LpOHJBTgj5UOywdg==
X-Gm-Gg: ATEYQzyzcefKbOL8ErI+KzoBv/ZA3d5I+4W6c0zVOrM2FrTVbspyH2l9eRDBYGKM6PN
	7zQ6OkOzZtc4uawPSDOZe3WJoI6uOPYlb5TBbZ5z0KK7vlFHCwm7C6UII3PDsWiQ4iF3sEOJRcd
	YjJgNaNdrUHerASUeuAoxQxTdegP9/2AzJDmG6ewNgbBRhxLDx6tQBRcd76fWjkiQfryKPwdiaz
	U5YlxNYtWeTMiPlBUiud5RA59WeKNwJOIXjBFGzOgqLYn0MiAaSZ1Py6ULTsotdZrksOBJ6IAgM
	PNC9Gt+pZwFvacjnoyn2Nw4PZLkBhzbyIOWS/nScCkzT+4sLRBxsHzolILzsIFsvOe5DRqoMgm8
	u1nCMm6IRxCtD4JlwXu9HlLm6zepA3/iQpAFMzEgepbFiNrSkBSKIE7g8SDg6Z7U70gJV94LXUo
	g5
X-Received: by 2002:a05:600c:450c:b0:486:c4f0:1a37 with SMTP id 5b1f17b1804b1-486f4457a6fmr44895315e9.24.1773827365114;
        Wed, 18 Mar 2026 02:49:25 -0700 (PDT)
X-Received: by 2002:a05:600c:450c:b0:486:c4f0:1a37 with SMTP id 5b1f17b1804b1-486f4457a6fmr44894965e9.24.1773827364655;
        Wed, 18 Mar 2026 02:49:24 -0700 (PDT)
Received: from debian (2a01cb05923c9a0070912cd5af4725fd.ipv6.abo.wanadoo.fr. [2a01:cb05:923c:9a00:7091:2cd5:af47:25fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4214664sm47282025e9.4.2026.03.18.02.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:49:23 -0700 (PDT)
Date: Wed, 18 Mar 2026 10:49:21 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Martin Olivier <martin.olivier@live.fr>, netdev@vger.kernel.org,
	linux-ppp@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH net-next v2] ppp: add IFLA_PPP_UNIT netlink attribute
Message-ID: <abp1Ie88QmHthYkR@debian>
References: <PAWP192MB2411A808BB36F0086A9B00B99742A@PAWP192MB2411.EURP192.PROD.OUTLOOK.COM>
 <20260318015937.239409-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318015937.239409-1-dqfext@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268946-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[live.fr,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnault@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[live.fr:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D1DB2B992E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 09:59:29AM +0800, Qingfang Deng wrote:
> On Sat, 14 Mar 2026 02:14:29 +0100, Martin Olivier wrote:
> > Currently, the PPP rtnetlink API allows creating a new network interface
> > with a custom ifname, but it lacks the ability to specify a custom PPP
> > unit id.
> > 
> > Setting a specific unit id is currently only possible with the
> > PPPIOCNEWUNIT ioctl. If a user-space program also requires a custom
> > interface name, it must create the interface first with PPPIOCNEWUNIT
> > and then rename it.
> > 
> > Resolve this by introducing the IFLA_PPP_UNIT netlink attribute. This
> > allows user-space programs to atomically request both a custom ifname
> > and a specific PPP unit id during the RTM_NEWLINK creation process,
> > eliminating the post-creation renaming for this use case.
> > 
> > Signed-off-by: Martin Olivier <martin.olivier@live.fr>
> > ---
> > Changes in v2:
> > - use nl policy to set IFLA_PPP_UNIT min allowed value instead of a manual check in ppp_nl_validate()
> > - use of nla_get_s32_default() to collect IFLA_PPP_UNIT value
> > Link to v1: https://lore.kernel.org/netdev/PAWP192MB2411A5E7D3BE1B55E155A92F9747A@PAWP192MB2411.EURP192.PROD.OUTLOOK.COM/
> 
> The patch itself looks good to me, but I would like to check the
> userspace changes too. Please create a pull request at
> https://github.com/ppp-project/ppp/pulls
> 
> +Cc: Paul Mackerras, Guillaume Nault, Pali Rohár

As far as I understand, the original ioctl API allowed setting the unit
id for only one reason: to allow userspace to influence the name of the
ppp device to be created.

The netlink interface on the other hand already allows to set the
device name, without needing to play with the unit id. So what's the
use case for setting the unit id with netlink?

> Regards,
> Qingfang
> 


