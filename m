Return-Path: <netdev+bounces-268244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F4mIvxFuGmLbAEAu9opvQ
	(envelope-from <netdev+bounces-268244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:03:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C2329EBCA
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD2F130021E4
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8633B945;
	Mon, 16 Mar 2026 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O07WQe4D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23CD4C6D
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684215; cv=pass; b=tYxXIeNvJI5L0JKPNFeKDkWgeZBlH5vApw4JtTDbz/rPil1J9nj9y+Gdq1cFq8x9pW9bzrDhMH45zR09O4IEC8avFjc16fspIrQIGaGAUFbHxzb/EPnMlcp0+kGcca3sp3/snlFHO6omdrIROLE2VzywzPsuKn1i9EQfxthSQP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684215; c=relaxed/simple;
	bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJHV0UvQfQy1bC6y+RVF0QTzBO+7H1OM2JQmiJIIcdHGG/MlInkIGaBJE6iorVaNohUyfiTbFB14wL1Y+t2TmXA8Z+9BF7KRf4AYR0kK6cvytf/rFy92oe5oXxflEZTGunQPdV0n2GdHq4neM9BgCnuBZZaWRXOWtp44kAWgzUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O07WQe4D; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1271195d2a7so345378c88.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684213; cv=none;
        d=google.com; s=arc-20240605;
        b=BdUVKfjEvo4n9ZWUVllEimD1j0UIKgb/qvWcPzuE+V1H4bwM4QCG+a4qgKpDQtEasx
         VX/+/5vc7fDKj/XaUi7+P1sTJHc/pnnY/MCzAz39RHFpkYjgzuhiiyTQSmRa7a7D3zvN
         2oVL36IRaxqga11voVUExm7hrzg8GBsRJxDFeW2d+jldsMJgJ8Q2pKiQB4MzUmeb+lv/
         1+dIoOGLDIL/CrR5Ca2coZfsCBMLN2Ib5gQjBbh+5L5x/NjnTQSIEhMsNrcX6u9CFxZ0
         kjZIHIAmq/CJM7I3RXxdN6HkB6KCZao4jBTsZ2dWFTG097ITDHN29dru+HLHQtuVZa69
         tZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        fh=c/ArPb5ozjWSZSruHrj9eVmhhV8yJnZYBoB2be6juC4=;
        b=PnevOt3QH8qv0VRqDQWyIEW243yfThVoWdD+c3oxuOoJj2G6wQlUDMfVYngSMIH6lv
         06z6YZr8ALuM7FPry4kjZYpCheeG/QjX69ZQ3mW6uuUb9PymKddE5vHtyHDl9DKMID59
         iv81dqdHsBWVrXrKT+egtEsSa6Ihluv/ok5tLIPdyqW4JdFVUw1GWmsf1DON9XJfsyPL
         R7eQkis6EDZ60sd7N/SQHfByP0v4+cbWxhB57TYhTsn6hrPfcLJvnrKr+oivHWxoSjoa
         ms5MVMPSIsfafytn4AcZsNYnYh8U3mmHKDg1phcDetdWfzdUJsbXNZY8BodQK6qL9uRz
         Jbrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773684213; x=1774289013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        b=O07WQe4DY8rR2TalssFliMhJMUanx8+Nj7/aoptmrFfrw6TU5RopcWFn1u2FSG5wj6
         WJdIdUVc/Jz6eCnjmFHsBrDLej9HM6xxU5LSAYT7wY1Nr5J1bsnTeGfQSWq0kfBKqxrp
         XvwlEB7du/N87ct4LCBjpa9pnRhybUocVzNtb6uI5T8kJQanDtMKVR8UhHxsl/SADP5T
         mzxmC+H2Cv7X9Hwrvl0HMDq4KajhQK3qoZVZ+9UoKOeh3YY8ehoAS3oRIrSqQ7/gFLMW
         2kRGTnGFAmkfbrRP7PH1q65ynTPsQ0glkjdQYpyB7zlLTEroJput4cJbSf77Ec7xTZ/n
         vr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684213; x=1774289013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        b=M1ucon4Si1zRv8pThbwNl/6d5ISlOc+jYzyeLaU3ELxCRugP3Bu2r2Hc5wdSHSOfTu
         8JGvFvndEeYiAqD3iiP3zDuHs7zvRFY1MLzwRmYltNyvM79kqZtXghx8Bz5AF62sFFdr
         Ce9+MpRVlPcBAtDBRslGcKkmBRcYuvErHmQy1THcRFOfu3lFlzKA4JqUFTgx3hPCXDmq
         oWVvqxahSLxt+lxU7ZzTXnd1BHR0hNNKzKHjW66KLM8YwEGqP5eXXZfdaTuM8d29Ybh/
         dE6fC8kEMCjhsF5E0dGxOMfILQbaaEcZtqUuqYMXDcoAWYBffB8jhpqpuK79a2q6yxOR
         eZ0Q==
X-Gm-Message-State: AOJu0YyHGWQtKMrsRzx7YYW4TFxfvLw9RXgdbbpMwM27MWRJy2SL6gZr
	HSqLq9sRvp+FHkV04WZsoAKiS2TKelG56pUnGG8ir9V/vUggEQVRikZ+sQacAY7SRobegVDp8J9
	6ryI6lGAZrWdIy4XkrZf82KLA7O5Hp3g=
X-Gm-Gg: ATEYQzwkrJX3BEk/J45I4OpSfjLnzJqhtByq/lD4HmF+hbfETu8pZczQvpqnptXnSdI
	X3D64VfLtqm4p6BhuAXhREptDTmKyWvF5qcwNbzn/O5j1aTsgWqMNQBU7vo39XVu8/B5K1N7ZFe
	zeikvH6NiZfleAw5vpJCvKGfsVuo1GUaoeKg6ZHxApsnvR8uHfry7p8MZ2MAZ2gYU4bbE1fx0mV
	2qb85XOP8JO+tWacIZT1n6BBiw4UfePoqd6XUqxU/DKWGVfac9+QuD316QDpdjQB/uoRK+pDJqN
	ckhr/Q8HKamt85MiFdtFXQyY+slGtBYB9rpyWdHU
X-Received: by 2002:a05:7022:e1d:b0:128:d786:8aca with SMTP id
 a92af1059eb24-128f3c6b032mr6448350c88.0.1773684213034; Mon, 16 Mar 2026
 11:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314201348.1786972-1-atwellwea@gmail.com> <b042de90-79e3-4976-9bbe-b6df3266caea@redhat.com>
 <CAN=sVvyNpkyok_bt8eQSmqc4f7g7QoZBUmRmNRLoFz1HasEzMA@mail.gmail.com> <e93ce797-4153-4e6e-89b6-3839a0b8bca2@redhat.com>
In-Reply-To: <e93ce797-4153-4e6e-89b6-3839a0b8bca2@redhat.com>
From: Wesley Atwell <atwellwea@gmail.com>
Date: Mon, 16 Mar 2026 12:03:21 -0600
X-Gm-Features: AaiRm50ReSwavo1j1ssacOUbWxtcgznlHmGlPHkMg2HYVcwTt0DGLUUEq90y36c
Message-ID: <CAN=sVvx8jNC-OAMkv19Wv13jTpV5_wVEabwUCjPLMwTvS4czow@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting
 across ratio drift
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, ncardwell@google.com, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, dsahern@kernel.org, horms@kernel.org, 
	kuniyu@google.com, andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, 
	jasowang@redhat.com, skhan@linuxfoundation.org, corbet@lwn.net, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	0x7f454c46@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268244-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,lists.linux.dev,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2C2329EBCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo,

The link I meant is the netdev regression discussion that led to:

026dfef287c0 ("tcp: give up on stronger sk_rcvbuf checks (for now)")

The report/discussion thread is here:

https://lore.kernel.org/20260225122355.585fd57b@kernel.org

The revert posting itself is here:

https://patch.msgid.link/20260227003359.2391017-1-kuba@kernel.org

I should not have implied that there was a separate prior
regression report beyond that thread.

Thanks for the note on formatting. I will keep follow-ups in plaintext
and avoid top-posting.

Thanks,
Wesley

