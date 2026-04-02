Return-Path: <netdev+bounces-274454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIPjNsFCzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:19:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4722B3879D9
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8553301CCEF
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C33D412D;
	Thu,  2 Apr 2026 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab3lWxkr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F83DDDD7
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124801; cv=pass; b=HArprNzHTCgBG45rAjAuWnrKm5RsjBBxxGIrMk0HRiXG/gbQPXq1hAs81oUizGOYuyN9aNR4D+VXybz8rSWrW/yTDj40NlVzqThdWV3OBoYNAYUF6zrDu1ne5l4Q9Y3RfQB1HY/bEJkrrt3cfmm0oj5P71//cKf0IqatHXgat7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124801; c=relaxed/simple;
	bh=UHRKW7d/gI/agzapMah+6q2m1siwp6pLPB48km3Iw+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyROv21OlgBjDGB96G5/uptTMyEKCgi//S989Itgauyq9W7XXx716WdhU1UenwSJ+bPEItkHBKN4Mdu7k4eITBt21hdGX2h2Ja5tPFqbxe2EYj7JbjgjyJ7Kpd2B+bRG0RCWt0sGKRwQ/NE/nvlKYJRJCD7KSLMMQZlTh9Scn6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab3lWxkr; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79827d28fc4so5886187b3.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 03:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775124797; cv=none;
        d=google.com; s=arc-20240605;
        b=iV2yllfD4TP7fYkNlHu+QAmYFNKg/Al1vup4fSgdFt5BKXJRxi9gmXSy2lxVaROyV1
         Xx92wDcuD1X24k7Llfz/QWkLqqpC5kPnELpzLhfwIq5l8CHfoph4yxAL4QShmoVa9OLX
         9fd/uG8ESrpgssF1JcPxONuoKSysvKDq4bQoblH7/4liAzOYmMEJhYvrRx4PSNlbkekn
         iVALM1p+aMXALt20KvwzxWstUalSsq0DXWphOjz08fJJRzEVPMZimkGQ6HauAlH4PtN3
         4bNZ769hfKpZ88ly+cBWaRTHYf9/yJob3ThNkxT0Z7gT+SpgiHZ4UKEPKxinDTIGZOWp
         k9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UHRKW7d/gI/agzapMah+6q2m1siwp6pLPB48km3Iw+I=;
        fh=f74LA2CtwSsI2sUhMbjcruzGQnP4Iwzs2v6FOCU22Ak=;
        b=FFK+rvz/Zzq+WyM5GPxW0EnBRtbPCNZvI2MpxIrrtfFFMWO/ZoeB8AS9P4CZOKC2k1
         2DF/PKvr/1jnRCAPYiE7UvV2NtA1l17sP7UV+c/ovJ/O0c/Bb7mu6EQ33oO7Kp7P8AuE
         zTD2SHr/PzZ5DCnJL9ixN0+EJai3212iBgMQqpmGAuRRxkQuZFE1YDO0+fowp78D5FJI
         s0G0O8uMg3+6e3sSYCrrjQL8/itIKwkmN7QC7vdEbfAevK9EP6vtWssHunxY+BFu2lR+
         9Nq2u2DzQZNFfkh8Cj91Wt1+MunkINISWWDJsmZBNDkq8SMNQvx3ZoExi2VE311wlqOg
         +A3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775124797; x=1775729597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHRKW7d/gI/agzapMah+6q2m1siwp6pLPB48km3Iw+I=;
        b=Ab3lWxkrx4atMVO6dRMkxBOrypILc/ouLfaq77lO1TYP/ZcSruZzGaxuLWoC+pa8zF
         aiMsI56tnneL1uDBRajVYW1hz1cI9z635+8cuGtaP092Oqyde7pO/1WjcI4m9c/yiHsY
         hvXPDUYi8KGOHWTDO5WuAD2+ubmaIMAtWCInb3D8oW6aIODDNRAgwajwVGTuu3Ol+t/x
         sMMGmGJiNx1N7z7VtJN1e/fhH8hFDTV3oX11BEQ/lQ8YT36yN153CP+jMGheEhP9srcB
         Dxhl5cC9XcO892r+YHCUDE9T6ieL+ni4ohqrW7OQRZYxqiB5iPvl3n7fPCggVH64AhOo
         RFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775124797; x=1775729597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHRKW7d/gI/agzapMah+6q2m1siwp6pLPB48km3Iw+I=;
        b=rxCO9gl6YiUI2gO+069xNXyPEg9MnDUA/MMt4Ew8k8Ee6GUXRVxW/nnHiJ3MD8OpIt
         QWOjrd5MS2JGbXDQs+MFwPkhQ0FbYZ+7rlfoo9XFnv6uh08MJCJwwwXt2uiU115YbH0m
         1t5sZ/GbZl0T0PyIdDk07Mz7kzXXmupnUUS1k/e7EYQ0KicLMz0Dy2cMWao05hLYgWJ1
         IX7uGbYB49GW5jMRxkM5WJ/2UU/nZwgVsfodrprnjHTpDOaB9eZoo0DUjZBlQ5juoCdT
         bfCGjx70P18w82O7j/PBKTm657TpTNzVrycYhdjkZ54Ucvn14CAeuWruQSVyWFaORVWS
         TOgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlPPaOpMNm3srlakaV1gAnpRw4PYYzw2fmdQwNiwfuMcIlMEsH80vllnAjOQPToZb3OUWdxdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnpjMTc24t/DRL/EmRAia32MzDC9+gi3myBP/LC3pPEMcncQ4K
	OEzGhMjEw7nlvJ6HzSNGHIhiG79ALjAih7kfmlmS2uUXYYNMam0jg/HycNt5XVQKB8wmRGkJ0lS
	fZgzJNZ/en60QqFH9AHrJz8XVbBVfAGw=
X-Gm-Gg: AeBDietHYwhiZDau5yaqnAXwolCHYHO9nS7HtcVQPn7m54ag3DdcKBC6246nTcK3W7K
	3K88zYO/4t6DWMgY85+svYUfdVR7qgPTIBSJVZNFPU9LEUUZhwu+m2o7/QLf6G4o6RujWx3gFdJ
	kWBlqyFxowQ/DALnwAizm6mkSNwfuvrUaK7Ts7RW4ujCBjsLvBJq9/ubIBSRS3/Sk9eNBYisdF1
	CHKQuYT3TVQUmzbMbwBKMhkNLyA+zJTF3evBNYrBrHL5vJEK3THo/cIFUhzPpIsbTJg4NJdRPJo
	pebmK1GmcDmT6ygc5Vvrfu5JRYJ0YUlOdvIlaOML
X-Received: by 2002:a05:690c:38b:b0:79c:a09a:e59a with SMTP id
 00721157ae682-7a210a8c012mr71187397b3.24.1775124797268; Thu, 02 Apr 2026
 03:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330035604.133073-1-dqfext@gmail.com> <20260401081030.29b050d5@kernel.org>
 <CALW65jahWApDnVmFReW+Y3HDxBEmCwzsT1oyh03SW7X5ry6PzA@mail.gmail.com>
 <20260401175621.549c492e@kernel.org> <CALW65jaTbaosbO8ypKZ6G37HxuxXabeTaP_Fhq72xTovmDj+8g@mail.gmail.com>
 <50ae3c69-2c4e-499f-a46a-cbd207ff5f09@redhat.com>
In-Reply-To: <50ae3c69-2c4e-499f-a46a-cbd207ff5f09@redhat.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Thu, 2 Apr 2026 18:13:05 +0800
X-Gm-Features: AQROBzAyy1DnZFo-szwYlk4Mp8iFMyQo5jot_GYlouwlaNbxdnQyOVQ65zMkKtE
Message-ID: <CALW65ja1FV-OcqSazgKZhQhKf3oqr=kcGxyGkOGbhurGLOJ0-w@mail.gmail.com>
Subject: Re: [PATCH net-next v7] selftests: net: add tests for PPP
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Dianne Skoll <dianne@skoll.ca>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, Jaco Kroon <jaco@uls.co.za>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274454-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4722B3879D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo and Jakub,

On Thu, Apr 2, 2026 at 5:48=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
> Note that similar failures in the past in other test-cases were usually
> due to timing issues. i.e. the pppoe-server starts in background too
> late for the client.

I don't think it is a timing issue, otherwise the PADI negotiation
won't succeed. The "updetach" option on the client side also make it
wait for the negotiation.
It's likely that the pppd instance spawned by pppoe-server fails to
find the "rp-pppoe.so" plugin, so the connection fails when handing
off the session from pppoe-server to pppd. Note the naming difference:
the client loads "pppoe.so", while the server loads "rp-pppoe.so" by
default.

What distro do you run CI tests on? On Ubuntu 24.04, "rp-pppoe.so" is
a symlink to "pppoe.so" in apt package "ppp". Maybe an additional
package is required for the distro you use, or I may work around that
by manually creating the symlink.

