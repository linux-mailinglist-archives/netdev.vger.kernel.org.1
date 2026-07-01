Return-Path: <netdev+bounces-303552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZLDrGvPeRGqq2QoAu9opvQ
	(envelope-from <netdev+bounces-303552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:33:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BADE76EB9FB
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 11:33:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=AQ9ucjkA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303552-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303552-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6830E3051298
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D73BB126;
	Wed,  1 Jul 2026 09:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6608A28DB54
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:31:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898280; cv=none; b=kv5JB09OZOLvOYKjjfcWcydxIOZ2pERwm4oAQjNlknTupzRWJ8dLy5K+3dURr90PbCxC2K8TwL+xmMkDEgHZ73VM6G+aurp+Ur1OBOkvZOoGlG+aItl7S5JosDmZGjx4/yFIzqJTaHts+V3wNfqlP2IEIHwRRtJqJHnQiMlW+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898280; c=relaxed/simple;
	bh=4Bu7DWsBxSyx4e2vtkSpxLp0Q2Am/sM8AG1rEg2Y6dM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cmT+188tYWl9zpywUB/2EgeBE2IlZAKj2UwfhV0qJieNTwVPL0WaofZHY9ssbsC5fqC/SZLW9B/hi1YJYFsyw1vABcZ9LySZGR+1S+lW7SWY97oLztQbiPId4og4cll+eK3v0brn5JkS1VBvbBzjFq72wwL4lXHnP4d8ihUBTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=AQ9ucjkA; arc=none smtp.client-ip=195.121.94.183
X-KPN-MessageId: 984a675c-752f-11f1-8f53-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 984a675c-752f-11f1-8f53-005056992ed3;
	Wed, 01 Jul 2026 11:31:10 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 98490546-752f-11f1-91ab-00505699891e;
	Wed, 01 Jul 2026 11:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=tLwus2Z9SHB/2dEYbgbr6ka8rzE4SPYBz1p950DKNCA=;
	b=AQ9ucjkAD1nktGKQ4PEH183hlPxzCOwAXO9wSPpjRdEnfmyUCUcqHNxY+wsh03QmRhSXB+S142nyE
	 cidac8MBYPx0JBfImz1P5qQZCAwklY5w88TkDZHS7n21cD5EZTXT1i8kJrADObWP1F4TTTnJe+PhCb
	 DJ4TNg9nq48eZ7frva5jsbe5wcD+4w0qZNYv9ymNdJtgJmLHDCk2sQ2fOAwRi7kHNdQwWHh7aIm8Cm
	 km/hteWZvcQYMKg9a+YsW5n9y3SwEeJreSUL0dTpkgzBJwPWIWobvP9QiF+7CqzVKdpZEUH5C+2ERZ
	 KwQTU8VPWvsD2rUBlcfeKT1O8fvu6Kw==
X-KPN-MID: 33|YUU32CqV37goJ+ohMNXmFuus5fLBFklWXleDZmHWBhHrO3iY8e3T+7N7VuO0xrm
 pE+pIkbmk9XO7h2+2/heGhrbD1vqvRN2DvyWSPFdPdrA=
X-CMASSUN: 33|kv2oYt4LwQtno3a++u2D/ia5PC6BC0vMT133ArgPoj5L5wUohptDWdnl3ZwTI9k
 FhwAlzTjvakaAqQSCsQZ82g==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 983c0ba5-752f-11f1-916a-005056995d6c;
	Wed, 01 Jul 2026 11:31:10 +0200 (CEST)
Date: Wed, 1 Jul 2026 11:31:10 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <66991303.3605710.1782898270313@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260701-malen-gutmachen-stengel-2c70ad5d2971@brauner>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
 <20260629194327.2270798-6-jkoolstra@xs4all.nl>
 <20260630071701.6b583d1e@kernel.org>
 <1957659940.3537950.1782830112890@kpc.webmail.kpnmail.nl>
 <20260701-malen-gutmachen-stengel-2c70ad5d2971@brauner>
Subject: Re: [PATCH net-next v3 5/5] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303552-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:kuba@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,xs4all.nl:dkim,xs4all.nl:from_mime,kpc.webmail.kpnmail.nl:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BADE76EB9FB


> Op 01-07-2026 09:38 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
> > 
> > I just need some LSM to trigger the reject of security_file_receive()
> > and Smack was the easiest to get going. The series is totally agnostic
> > to the used LSM. I am fine with moving the tests elsewhere or porting
> > them to SELinux if that is really necessary. We could also drop them
> > altogether.
> > 
> > What do you propose?
> 
> I'm pretty sure the easiest will be to use a tiny bpf program to reject
> security_file_receive().

Ah. Well, that's a testament to how much there's still to learn for me. 
I didn't even know that bpf could hook into LSM calls :)

