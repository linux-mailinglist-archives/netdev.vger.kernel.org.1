Return-Path: <netdev+bounces-270730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNwfEi6iwWknUQQAu9opvQ
	(envelope-from <netdev+bounces-270730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:27:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 741032FD324
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E11CB300E1B7
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BB13DEAEC;
	Mon, 23 Mar 2026 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ai8JpGUz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD413DE45F
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297622; cv=pass; b=gGlCV7Lf4JuBWEAPeBKCDON2InuATN5mBn5aY2cl+yBmibXAL8EkokJlW9uMk8kpIn5fnWtsBTI1fkMRKBarb4X6RntFfc2Wzr0dnA0EPsVoJ8TTVsW1eSX3KvBaTabj8o066oNwt3HiSTJOMvCAGz5NLs9ubcD9NOlL83YRx8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297622; c=relaxed/simple;
	bh=UHRNSR/Znkl84N7M/0cd+OulIZWBWecvpme/oncGlAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkxkaMMS7JO6Lb3Arz9MLW03lsnx6UiVrbSqkEbthR7ZB/TgRxeNgxHm9Z8zWXHk2/3QsIjWbgCEqT9ZXd72M2JhI5kZ+0Cbb5w3Gw9wldswPpRjc9x1Q0CrVMVbTLCfXeOrU4bu3zMmTV6U8gOwIwS5JIP/qV98AQwdTcXaJeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ai8JpGUz; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab46931cf1so47114615ad.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 13:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774297621; cv=none;
        d=google.com; s=arc-20240605;
        b=NDkZ3AyH5fMfJIUpDVxNBn+KulWpfVrO2aV+kFGQ0Rb6XEMjrAmDCBNN1O87XxlJic
         2xFAMEKx2gUMyFVapT89qUGzcBG1O99TQN7LtYw2TUYC/iF1+89zOsNwerCbTKMwNmEG
         jcWHtp6Y1n2OHF2ZTsIqZiRPjEz87uIubJkLrwe3YgGXSKiBk1E6GojoB23SlambtZSD
         hdRhVr8JpATaLiIbpaz8NuYHLXwbCqx4QkiHkFLQQqlEi7KvED1U7wThXK/9v/0WjT4N
         lEPomkYkucuKQ90aB04iNENK6xMXpbjEwN/9nMO4qg7ylK02ss8RCYFiztV5EaRQ9kFC
         JbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZnSiO6nUBeAvL7zsJIx3NN22KTDnl+zg3ihQoV58SNo=;
        fh=ED+lOcuijnt5pO3MN3D39MCnJ1LUZ/N1OOSOTpnoit4=;
        b=kGn1zEqrVmqTIuqHKOtR6QfG6GGSwzgwNS9j3byVw/7RnNd2ncv3Kj5XaO8lIudYs2
         HiBe40WlJE5umeQY5ASVt+hpfyMvbUFDAtA6T4VcVR8yW+V0jwolZnQZmF+qODJAQef/
         dmDsA6DNNo/FWSVJSxmU4gvxc52oDA81NwpMradaa7kHGR6+9RYIrbGkuxzJ2JEhlZce
         i0G1+hl0RxknJJeGme9nrMXqcKeg6/pmEKKlx8emLbhHMQOyEWHJ/cfaexl3s/YeKpl0
         DJAks2LgjFngeoY2kORrcbPeIfsoYxLBd4sSg+4wOpEPAxdLYdQkotGfFld4rKiCOKNf
         K+Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774297621; x=1774902421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnSiO6nUBeAvL7zsJIx3NN22KTDnl+zg3ihQoV58SNo=;
        b=ai8JpGUzDh4wEN97Rwn2orkMMxRddfpLxwlV6T46cC027BBLYwBQPiDJCy2qdbDVGy
         cJ0P2zTk+ShP39YJOJ9FH9s6/oZVuRZPARnM+aXU2TXXACT2r3y8UoUbNyHa3u8HSUlQ
         aKqqfsHoNKqIhI7LLQU7pDtWu75QMmDLv12EI55sNWktKDOAWmp49IbhgeBJCfz9eghD
         65zpBbaHMvV5dnO4pKkCh/a1l7cNNMIpAP/yYg1eXcyJVmkAefdR7w5JiAOB1NLh6Gd8
         3jqVoiq8oaJUd9DCM9oCOOPNfAo58HloHZVZRqKI3YfSV1agt/j9GGKVmJutXp7ye7tm
         qOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297621; x=1774902421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnSiO6nUBeAvL7zsJIx3NN22KTDnl+zg3ihQoV58SNo=;
        b=lY09T7xH75kI/vi02pk6KHUiJwxrT7I7i/p81UoPN8VSI2BMnH33dONzGk1Zp+lfO3
         ixNmi92HQ2k3oKFP67B0BxjqMF1YD6YppDPHZTERy6NuIzYpC91KPW1eEaF4zVS/IvqJ
         UrtvAizxkku4Xxu9OKhQ7un+7o/L0rG7+yIKDf3h1SneTIxpJW4xFGhnWu4W6vRgkWJ1
         nglN05HLVAUEjyO5WH2GPDpIkHVY0E71kZmtO7smC9f+sq+3xmBwxwUVgNkLewwJVHzX
         VKVUfq9Gq8WFUGlC32Suwm9BKPZXue/5kLDlV/6EScFtWqvw5vbNucO371mnYm6N2Zwj
         tnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuvoeVrmcotW9T7wOdebkyc2NHKFKYesyBtitrKJOxQZRLPr34GNJHuVzFEgcdf81VRxtEhxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzetTh4Gk69XamjB5B1V87AHbQA5V81rtU2qWSULxTJ8Nw4QcRD
	FO2jxHakltH7HYt5gaLA6wsZkblEQu8zpFUYFLSAHthxPajwJBRcaMvxyTrNVuMK70qYW3TDRzf
	e3QEcx4RXwavmUrpismxkcz1TnlJT9N8egRKmc4OH
X-Gm-Gg: ATEYQzxeysck7fkctRbfJkeYfQFW4NIq1HLn9fLBRtAHHcolugo+Shh1cT0+ybhrcYn
	dHLNVe0svbPy8n8seeWjCKPc4D7TNkMV+Wq4N2BotOEAmszWkpK6WijovKvV+bH8ssR72Ydat5l
	Oyw4vHIXeMgJo9CBMOjIVFrYhJdAbffSR0XBTCkDHNfEUbYN1s8FEWfGq+OoAorkM8VUqiktEQA
	rqpKjlKZsCamt8IuOFjy594iIeVBX3NIqZY4CACPN/ZtB2aXar8Qq7Fp3nkK0B+611t2gp7DLp3
	yPtLtrk=
X-Received: by 2002:a17:903:22c9:b0:2b0:6488:4957 with SMTP id
 d9443c01a7336-2b0a4e6de6emr6779955ad.30.1774297620908; Mon, 23 Mar 2026
 13:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323165654.193957-1-gnoack3000@gmail.com> <20260323165654.193957-2-gnoack3000@gmail.com>
In-Reply-To: <20260323165654.193957-2-gnoack3000@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Mar 2026 16:26:49 -0400
X-Gm-Features: AaiRm51p_92OOnZQnlg3seLDMJD1HFGdB1xy5D_9YA69tuaEOd66nQudPa_lIxQ
Message-ID: <CAHC9VhSovqp5wkB0Lkj14kR_WB2PhBNN4h4jXwXZ9=eCDSrNNQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/11] lsm: Add LSM hook security_unix_find
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270730-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[digikod.net,canonical.com,namei.org,hallyn.com,maowtm.org,gmail.com,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 741032FD324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 12:58=E2=80=AFPM G=C3=BCnther Noack <gnoack3000@gma=
il.com> wrote:
>
> From: Justin Suess <utilityemal77@gmail.com>
>
> Add an LSM hook security_unix_find.
>
> This hook is called to check the path of a named UNIX socket before a
> connection is initiated. The peer socket may be inspected as well.
>
> Why existing hooks are unsuitable:
>
> Existing socket hooks, security_unix_stream_connect(),
> security_unix_may_send(), and security_socket_connect() don't provide
> TOCTOU-free / namespace independent access to the paths of sockets.
>
> (1) We cannot resolve the path from the struct sockaddr in existing hooks=
.
> This requires another path lookup. A change in the path between the
> two lookups will cause a TOCTOU bug.
>
> (2) We cannot use the struct path from the listening socket, because it
> may be bound to a path in a different namespace than the caller,
> resulting in a path that cannot be referenced at policy creation time.
>
> Consumers of the hook wishing to reference @other are responsible
> for acquiring the unix_state_lock and checking for the SOCK_DEAD flag
> therein, ensuring the socket hasn't died since lookup.
>
> Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            | 10 +++++++---
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 43 insertions(+), 3 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

