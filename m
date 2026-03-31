Return-Path: <netdev+bounces-273507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIuyDbqAy2kxIgYAu9opvQ
	(envelope-from <netdev+bounces-273507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:07:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEE5365C6D
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 322DB3064890
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E346A3D5658;
	Tue, 31 Mar 2026 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhdyR2Y4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A624396588
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943698; cv=none; b=ZFfoEdqqZnZsXBnJphmBWfsAW06z+Nqh6tUX2sS+gEcVIkXsjwYvAL1y6jAVm5ni2kfz1JRREjXuWQmAU7qrepe7FSGeRkanKdT+FahnYoPBKWZIPju2tUij2gIH9QITcZ4oUsCDuBSWcsy70XGq+Un0ii7kkhyqH6Sud9VsZbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943698; c=relaxed/simple;
	bh=5rBDUC5cYHdY+1pIOriXhYRIpO/C9pp5od6462pKwEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4hsq1jfXnC+7ScMd/vqSr72JQFhjRzLLVT+kJZGBkmdo3oOGrauqWYYgK+m7SWyxmvAl4DQumSRjYYkiZQa6wjtjBpDt87y2mnIWJLVi696pHx9qByQJ6ybUdMR0iWfisxVpaKK7248In9Cak+3P5VI0NHhgaCeH7LohhMFmSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhdyR2Y4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66c5b2e41c1so231865a12.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774943692; x=1775548492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRlU1MXJnKrSea5cC1P8mFGQwko8gNNHu89pJ5ho6P4=;
        b=OhdyR2Y41IDuv0z9CVYVfeqFKe3Ev1uZM2qJFxVvdFnVPxLGFRCuw57qJ3aPPxMB4g
         XHobNFmXuneNkLj5S8P4nJkXzwKyyb3cG3VQ4nkaN1ZbMHjC+z02bWzO6LdPtCZLl2VB
         ls7mygAeyN4ubmNWF8RBDarwl/LiAsp3tk+2RhBFvCP5qR0EpiauqqVCuZuMomxODTGb
         bZV0miQwcOxcVVcdpC4tsgHGWHaBLOiKalegm+2xIOxRj+RDDOcSKp1EU0Zb4DqLHTVt
         ABmN6wsJ/isnJ69LyLGK5pWfz91HQEYChC1cUW0BoNIufbjpUNGazFTH9tXTcwjmncyx
         yGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774943692; x=1775548492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DRlU1MXJnKrSea5cC1P8mFGQwko8gNNHu89pJ5ho6P4=;
        b=dUw6Sd/Ngc5xQl8uJUWqvUMPm9DdRNo1m0hyUUQIfjri4MxBP6t/vLzKxDKXssG8jv
         LN7aQn6+hsJMMTnP2uuPh3Gc8e5dRx9lF6IutMV8LWkRC/ISEt/mCCqpEpJU1fzmXoh3
         NGPDiCA+qjlTfxl1BTGz+H2+aFm4XuOY1tsRQlltbciTJINq7PuVwSGnot3K/yoma1fS
         5CaAvHD9mxVFvKoAj/I+n2HqfCrcCsCoEDHTu9hP2cERuLXfOXO8mktEAT8f8KBhWghe
         JNa7GvdwTzO6ultibeGq4PLBTkVRmPg8BELDfRMJXIwWvxlbKBG+DWYNJTPjqme+M24/
         ZCVA==
X-Forwarded-Encrypted: i=1; AJvYcCV2cPUzC/B9HduCLVxE3zVc2IueYaWPoh0l7fqdhFZD7RF7oXpHC3lexopZ+neY1/5SifXXGnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgFLOcuqRMEbckNg893cNWnT30npPQMeuHAP7GDKAau74DF1c
	84RjdRnpbOVHGDlRb0XWNbf/xQQwqOxctcPaSVzH6uxMX95+4g9ZMMfx
X-Gm-Gg: ATEYQzyydZrkaRejYVjdMWaS+g53RVjl0tM/+tlX2MwgVqj7mC1BWQJ9THsOn2AjBTb
	87T3C7FZAcD0Gor/KT9uId+C1dcSYfauAimSJ9mufWuMIMqgTfWJ4I4lqxfJV0hIzsw2MFIAQQ/
	DluSxdhOAZ9GlygUd5Nqv1hTS6U5sB1aiVFkSvP7XxxwrkFHPy/ko+Rp7+y4fFY++YMwFgLMKEY
	/jLMFegbaFVGoWGo+kfvRVECY8dzkeuBZ5j1VryLKvUQSX2iiBBVAL+heVA93/G7YnIhx9E/xgw
	ViCZmomrwUhZkSbhMz2jSMv7vU9vR6qPN0qeypTi0GkcxoJS26PRR1GyFsCA1FaOoGf9W6ICeLI
	N1Rwu4Hw7Hg3NyuDiBJtYWvprbKQuU+2v2d92ruzv4G/Jzg5ykhCKmc5Za4T9WrWIgfa/1/40gZ
	fGrGM+ltTWbx89Qb0kfw==
X-Received: by 2002:a17:907:d048:b0:b98:7f7:50f1 with SMTP id a640c23a62f3a-b9b507cad61mr1015080066b.27.1774943691739;
        Tue, 31 Mar 2026 00:54:51 -0700 (PDT)
Received: from gmail.com ([2408:820c:2708:af80:8182:8384:8586:8788])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9bfbfc63b3sm21407966b.37.2026.03.31.00.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:54:51 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Jaco Kroon <jaco@uls.co.za>
Cc: linux-ppp@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>,
	Dianne Skoll <dianne@skoll.ca>,
	James Carlson <carlsonj@workingcode.com>
Subject: Re: [PATCH net-next] pppoe: update Kconfig URLs
Date: Tue, 31 Mar 2026 15:54:04 +0800
Message-ID: <20260331075438.290119-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0aa6aa20-0e2a-48e9-8273-53b2fecd287b@uls.co.za>
References: <20260331033303.5664-1-dqfext@gmail.com> <0aa6aa20-0e2a-48e9-8273-53b2fecd287b@uls.co.za>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273507-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:url,skoll.ca:url,roaringpenguin.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DEE5365C6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, 31 Mar 2026 08:21:40 +0200, Jaco Kroon wrote:
>
> On 2026/03/31 05:33, Qingfang Deng wrote:
> >
> > --- a/drivers/net/ppp/Kconfig
> > +++ b/drivers/net/ppp/Kconfig
> > @@ -122,11 +122,10 @@ config PPPOE
> >   	help
> >   	  Support for PPP over Ethernet.
> >   
> > -	  This driver requires the latest version of pppd from the CVS
> > -	  repository at cvs.samba.org.  Alternatively, see the
> > -	  RoaringPenguin package (<http://www.roaringpenguin.com/pppoe>)
> > -	  which contains instruction on how to use this driver (under
> > -	  the heading "Kernel mode PPPoE").
> > +	  This driver requires the latest version of pppd at
> > +	  <https://ppp.samba.org>.
> > +	  Alternatively, see the out-of-tree RP-PPPoE plugin at
> > +	  <https://dianne.skoll.ca/projects/rp-pppoe/>.
> 
> ppp now exclusively has the plugin code (originally from roaring penguin 
> I believe).  Latest version is no longer relevant, that plugin has been 
> available since at least a few versions back already (at least a decade, 
> probably closer to two).
>
> That same code has recently been dropped from rp-pppoe, which now 
> primarily focusses on pppoe-server, and relies on the plugin now part of 
> ppp package itself. rp-pppoe is only required if you're running a 
> pppoe-server, and I don't think rp-pppoe at this stage will function 
> without ppp.
> 
> Most people will never need rp-pppoe.

Thanks for the information.

I just checked pppd's changelog: version 2.4.2 or later has the PPPoE
plugin.

I can update the help message accordingly:

	  To work in client mode, pppd version 2.4.2 or later is
	  required. To work in server mode, the pppoe-server command
	  from the RP-PPPoE package is also required, available at
	  <https://dianne.skoll.ca/projects/rp-pppoe/>.

What do you think?

