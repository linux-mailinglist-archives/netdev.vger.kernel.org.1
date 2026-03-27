Return-Path: <netdev+bounces-272554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMiRLgeBxmnQLAUAu9opvQ
	(envelope-from <netdev+bounces-272554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:07:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D76344C2F
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9225631686AB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD5C3BADA9;
	Fri, 27 Mar 2026 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIdqEKxm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pnMWSKA+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81643BA224
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616331; cv=none; b=Hpn47Bdiios7bz5z/ld9G0Hbw7vilZwPcAINuFPcdCyQF1x699iMIDmn6qWbYMZGGjp4kwFZ93coYwp7m7/n/pvhiofser9j3WVKStTMmf4TK9ev3GlyL+lJJJgtj7PLdY8yE2LKa0l5fC+1pUUHBf1b18sK5UPA94csh71lsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616331; c=relaxed/simple;
	bh=T/MncoWZVwS48wLOvcaP5pmO5KoCebx4I8w5SbYrRow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/AmGjN0Wkj/QkjxzqZsXevRkPR/wNllFK5A3Mv/kDfTPGTuxM1gPyaFrpOgDQbHGUIRQtsaQDFBmQC/PWuCzl/Zj3yDGyvhWg69GGKKg793cAv+3AQJzHVhresvklHJ2LRPyRBQgQ3qKUN0neEhAqZBarz7UhtFgzfPUtR1WHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIdqEKxm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pnMWSKA+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774616329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xhz+6dozSsvrLdg2FUPvcHN2R/yxft2xWhen9c3tayI=;
	b=AIdqEKxmDPkW3skRUfHjMD1d7YcbSIIk1GK/Bcg2hEun3+s4GSrRCck/QUokTqnBY5P1xZ
	DFCJc93iVBn6R1/NobP08DlgLRyzMuMT95KMhEVvMfLvt1E68tHmVkCNmlnIMeSF2YxM+t
	q+SsykJX/f81f4zEdPkdLeGJptL4s5o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-ET3Hs2apOA6QvxeW93cfpQ-1; Fri, 27 Mar 2026 08:58:47 -0400
X-MC-Unique: ET3Hs2apOA6QvxeW93cfpQ-1
X-Mimecast-MFC-AGG-ID: ET3Hs2apOA6QvxeW93cfpQ_1774616326
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439a85832c0so648289f8f.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774616326; x=1775221126; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xhz+6dozSsvrLdg2FUPvcHN2R/yxft2xWhen9c3tayI=;
        b=pnMWSKA+hGjYZ9CoXOfasqoeJE+S767+gz7suvfWUIH0aNICqAJklTfoA2r0sPxt+O
         7PJwuiX+4eH3ORnI78TaUvzHrzoHlSgn3I7bH0fvr+qzdoH7NM47L3H8iIhP7BG+65mn
         9CWtFwv+jt1P0rdp0tuIv1TOIi4nKlinUqOV5eZ/SAI0uaCwMswZ+vWOUYp4+/7JwGbM
         cpKW2cUmjODk0RnKxbyHSEUtfCSSmQNkBxjLVDwvvmxyELOnKkNbyWBPK9VYCdoANI7a
         e2hK7f5nXfa3V/ppsfkhvJSbMPudcVwuH2Em29IWG7esY/aKkKnabW8FN10M51rfJNyN
         JEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774616326; x=1775221126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhz+6dozSsvrLdg2FUPvcHN2R/yxft2xWhen9c3tayI=;
        b=MxeF3ArhYa2SiVmroEXvm8DjzEShL6CW1YVEXUCpgJdpEDlV88mabRu7bZlH6mFlXS
         uv5LLOvs32dj+9WLmafsdWx00nlUbD/WFNS2kTT/xkDX0xhEup8yaqh2YSlMKZqlywrB
         sJ7vGeTD+Z8j5mhMQh4ynTw18vep0iqdUBGF0CYhDK5pUiM1DzdjpLX439g6EQG4aZtu
         fPtrfLrztDXH2nsHnYe1JG5g8D+1isOEeF2HBUjHGAClyIot3wkz1FtFPx61lk+pno28
         ut+Mj2sjUYbpiTj3aebX4Dj0tKkM3V4CgnsPKFhK3CX6E1mULhoDepZbnVxs7EDupUhw
         yvZw==
X-Forwarded-Encrypted: i=1; AJvYcCWOdCXN30iACTv/eIq1KmqG2CqgmHWzVThv8PSp2cja9qIKyLkTue0w+wSM1lTOUEFom/SL6kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfiiA6K9q7akyrFsWDhQ1/6+HO7IMfweJstRZiq+ls1CZJG23
	9qE26r8RmgbwJQf3ZZLVCzifqxMv6vktt+RH5mLyyHxedPCJ92y9lqjm6VPaja1Z0Z4VSjJUGb3
	e+Yfn5zPFRJ26iYsKuSbxDT2RYqmsoA03z7xZyOgACZHg/v3YVkEqUHBsPQ==
X-Gm-Gg: ATEYQzzPnHNJHfujHaIWcLbn/37rfZB3NDjxIo546QXscBIurd+I0WJXjhajY38NP1w
	bhMbatcfaU45pvEyahy039W26zvjqIdCrHHZwvb1vGv8UT5sfxv2pdy8qWqidZ0EMP6HpOLLpqH
	hVeOVp8J/4vAg1a3fuGGBmv8yrbk9A43rUIyz82wBkpfioMXnJTYWaa6ccYL120SnnSHPS3mjhi
	Wz4SvxvDQaaFVZRGic/yuWtZs8w9jXvrNpjV6Zd0d8f1ehPXNxGigHtvz9/d36yEuN49NwMykvs
	NMgs5ZHg7J9fHWnFhSvpPUW4Fd+dBV48Bfz41L59eRgoDpPN5+0CsXh0HsT84GbqvEtlXpD1gM7
	+DQa2cyhJ7jcbUN0I0ADPSJ1OZGRpE1kYL5S4jFFkfMwlbQIAoNp8LOClHfQHAxyDqmvihefetw
	==
X-Received: by 2002:a5d:6107:0:b0:43c:482b:afc1 with SMTP id ffacd0b85a97d-43c482bb099mr289814f8f.36.1774616326276;
        Fri, 27 Mar 2026 05:58:46 -0700 (PDT)
X-Received: by 2002:a5d:6107:0:b0:43c:482b:afc1 with SMTP id ffacd0b85a97d-43c482bb099mr289762f8f.36.1774616325794;
        Fri, 27 Mar 2026 05:58:45 -0700 (PDT)
Received: from debian (2a01cb05923c9a002e69015071700bd3.ipv6.abo.wanadoo.fr. [2a01:cb05:923c:9a00:2e69:150:7170:bd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919dfb54sm14881269f8f.31.2026.03.27.05.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 05:58:45 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:58:42 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH net-next v4] selftests: net: add tests for PPP
Message-ID: <acZ_AgXhJVyUT_yj@debian>
References: <20260326021642.29170-1-dqfext@gmail.com>
 <20260326081304.xKa7-s_1@linutronix.de>
 <CALW65jYdzn_rZWa2zwYd5J+Gd=kyaGMsVFyX0fMJfKfgULMO6w@mail.gmail.com>
 <acZp3gRUqVIbw9yb@debian>
 <CALW65jZNi3oA7V7at_Jr5Vr4AdL03JYdA9WeK5G7cNr-XS2Bvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALW65jZNi3oA7V7at_Jr5Vr4AdL03JYdA9WeK5G7cNr-XS2Bvg@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272554-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnault@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69D76344C2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:39:11PM +0800, Qingfang Deng wrote:
> On Fri, Mar 27, 2026 at 7:28 PM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > On Thu, Mar 26, 2026 at 04:26:23PM +0800, Qingfang Deng wrote:
> > > Hi Sebastian,
> > >
> > > On Thu, Mar 26, 2026 at 4:13 PM Sebastian Andrzej Siewior
> > > <bigeasy@linutronix.de> wrote:
> > > >
> > > > On 2026-03-26 10:16:24 [+0800], Qingfang Deng wrote:
> > > > > Add ping and iperf3 tests for ppp_async.c and pppoe.c.
> > > >
> > > > Oh thank you for doing this.
> > > > I haven't look in detail but this cover the "invalid loop" cases that
> > > > ppp tries to catch?
> > >
> > > By "invalid loop", do you mean transmit recursion?
> > > https://lore.kernel.org/all/20250715150806.700536-2-bigeasy@linutronix.de/
> > >
> > > AFAIK, this can only happen with PPTP or L2TP, which were not included
> > > in this patch.
> >
> > The problem was originally reproduced using L2TP, indeed. But I guess
> > that it could also be reproduced with PPPoE by using a UDP tunnel
> > device like VXLAN (like sending a packet through a PPP interface,
> > handled by PPPoE, running on top of a VXLAN device, that routes the UDP
> > encapsulated packet back to the original PPP interface).
> 
> Yeah I've thought of that also. It can technically happen, though
> there's no practical use. For self tests purpose, I may just add the
> recursion test into PPTP or L2TP tests.

Yes, no problem.

> Regards,
> Qingfang
> 


