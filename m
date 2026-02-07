Return-Path: <netdev+bounces-257772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKe6OvuKh2lgZgQAu9opvQ
	(envelope-from <netdev+bounces-257772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 19:56:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5464A106E90
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 19:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD695301174D
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8002F745C;
	Sat,  7 Feb 2026 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anonaddy.me header.i=@anonaddy.me header.b="JGKBezFk"
X-Original-To: netdev@vger.kernel.org
Received: from mail2.anonaddy.me (mail2.anonaddy.me [185.70.196.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507D23EAB7
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.196.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770490617; cv=none; b=aMXm46riMM5nhlw64M+vaYBn3+XwZSe6B3NO/qhRbJXFt99nH4gvObKRmQfDDWyERo1J/OxNF22BAH2W7BrALf/GNywm3cqaqec3X+hLnyFddYpwyfz9rofurn5cbPwm3Sun8g32RgePRq+BM+NPqOaqedflMx9rAEtIFxzO904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770490617; c=relaxed/simple;
	bh=1aAyQJcOKpZDGOatk9b9nQPWTt5XNCehrKz9upPAILg=;
	h=From:To:Subject:Message-ID:In-Reply-To:References:Cc:MIME-Version:
	 Date:Content-Type; b=LT7x0Cewu5apnzvr5XiF6W7d/oixJRZcW2LMgYEem48kn/GjtDeBnqLnlIIWi00Y1rH3u+LyKfaRwkI6Fm6w2mglowi0zyHfhZ8XiKJzDEv7JeO5NtHoc70U1XTtzaqv4oDBDXnMFgiAN9PU2GIBft+ECuK6kUojkQRptveIvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=anonaddy.me; spf=pass smtp.mailfrom=anonaddy.me; dkim=pass (2048-bit key) header.d=anonaddy.me header.i=@anonaddy.me header.b=JGKBezFk; arc=none smtp.client-ip=185.70.196.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=anonaddy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anonaddy.me
Received: from mail2.anonaddy.me (mail2.anonaddy.me [127.0.0.1])
	by mail2.anonaddy.me (Postfix) with ESMTPS id 16D06FA469
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 18:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anonaddy.me; s=default2;
	t=1770490609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1aAyQJcOKpZDGOatk9b9nQPWTt5XNCehrKz9upPAILg=;
	b=JGKBezFkUespYbcalD8Hc1rSLO+X51BwWeUgryMaBewaDyM4meHgapyYbS0slDtX7pzQ7z
	+6O3AOsSUnGWnWYz85L0l6cVRWP4XV3A3chs6liRthj8kiKbSAKJm2U46xp1E1K+EISpxQ
	cBTBZFE+6RNm5i0alwpbYhKUAn354h8xS9uPzl194oKMBKRykI7CnuGnne8Nwybk/+duac
	77LBH3Y6/kI197mMxDNbVd5D/+WVl/8mdpzcMk1+qUtbvggGl1UtZcuMtElg3zN7Sqk6yP
	LsVBkeQKEKX0fl5ewF/KGcsb8bp80CuO0Q3AWQAbwWwIdcRDGBsVR8NcAK+9WA==
From: agpn1b92@anonaddy.me
To: sgarzare@redhat.com
Subject: Re: [BUG] vsock: poll() not waking on data arrival, causing
 multi-second SSH delays
Feedback-ID: R:d17f588e-5717-4190-ab1e-7db474f4dce6:anonaddy
Message-ID: <833d4550f9f6436ac8d61919e05272ba@anonaddy.me>
In-Reply-To: <aYYTder4-zvgOfV7@sgarzare-redhat>
References: <f3a801a1a32670294d5d703cad8ab609@anonaddy.me>
 <aYYTder4-zvgOfV7@sgarzare-redhat>
X-Complaints-To: abuse@help.addy.io
X-Report-Abuse: abuse@help.addy.io
X-Report-Abuse-To: abuse@help.addy.io
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 07 Feb 2026 18:56:49 +0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[anonaddy.me,reject];
	R_DKIM_ALLOW(-0.20)[anonaddy.me:s=default2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[anonaddy.me:+];
	FROM_NEQ_ENVFROM(0.00)[agpn1b92@anonaddy.me,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-257772-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openssh.org:url,anonaddy.me:mid,anonaddy.me:dkim]
X-Rspamd-Queue-Id: 5464A106E90
X-Rspamd-Action: no action

Hi Stefano and all,

Thank you Stefano for your response and skepticism=
 about whether this was
a kernel issue - you were absolutely right to que=
stion it!

After extensive debugging with strace on both guest and host=
, I've
determined this was NOT a kernel bug at all, but rather an OpenSSH=
 issue
specific to vsock connections.

Root Cause:
-----------
Th=
e 10-20 second delay was caused by OpenSSH's sshd attempting DNS lookups
=
on the literal string "UNKNOWN" (the placeholder hostname used for vsock
=
connections where no IP address exists). This triggered two 5-second DNS
=
timeouts during login recording and audit subsystem operations, totaling
=
~10 seconds of delay.

The strace showed:
 =C2=A0 17:11:14.465 sendmm=
sg(13, DNS query for "UNKNOWN")
 =C2=A0 17:11:14.465 poll([{fd=3D13, even=
ts=3DPOLLIN}], 1, 5000) =3D 0 (Timeout)=20
<5.005s>
 =C2=A0 17:11:19.472 =
sendmmsg(13, DNS query for "UNKNOWN") [RETRY]
 =C2=A0 17:11:19.472 poll([=
{fd=3D13, events=3DPOLLIN}], 1, 5000) =3D 0 (Timeout)=20
<5.005s>

Why =
I Initially Thought It Was a Kernel Issue:
------------------------------=
----------------
- bpftrace showed ppoll() timeouts while data appeared t=
o be queued
- The pattern looked like a classic lost wakeup race conditio=
n

However, the vsock kernel modules were working perfectly. The delay=

happened in userspace during sshd's session setup, specifically when
m=
m_record_login() tried to resolve the peer hostname for logging.

The F=
ix:
--------
OpenSSH 10.1 and 10.2 include fixes to prevent passing "UN=
KNOWN" to
subsystems that would attempt DNS resolution:

- 10.1: Skip=
 audit logging for UNKNOWN hostnames
- 10.2: Don't set PAM_RHOST when rem=
ote host is "UNKNOWN"

References:
- https://github.com/openssh/opens=
sh-portable/pull/388
-=20
https://gitlab.archlinux.org/archlinux/packagin=
g/packages/openssh/-/issues/16
- https://www.openssh.org/releasenotes.htm=
l

Workaround for older OpenSSH versions:
Add to /etc/hosts: 127.0.0.=
1 UNKNOWN

Apologies for the noise on netdev - the vsock kernel impleme=
ntation is
working correctly. The misleading symptoms (PTY-specific, ppol=
l timeouts,
state between connections) made it appear kernel-related when=
 it was
actually sshd's login recording code hitting DNS timeouts.

T=
hanks again for your help and for maintaining the vsock subsystem!

Bes=
t regards,
[Your name - don't forget to update it this time or you'll loo=
k even=20
more stupid]



