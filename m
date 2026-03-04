Return-Path: <netdev+bounces-263554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cZS9NnSYp2kCigAAu9opvQ
	(envelope-from <netdev+bounces-263554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:27:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B191F9D8E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99FBE301EA25
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911A524397A;
	Wed,  4 Mar 2026 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBhY+9Si"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525BC182D0
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772591213; cv=none; b=pGljmNjPJF0LehGgc7xqo4wVJ44QKCDhgad45pdjLLqilQHBDQN0nOyRiegnlfeQkxQgQWA00iFlMQJukdskHSVcXC5A+vhJOsTIaPULf3Ujxv0PA8a5Y/QR+9q7ENs4itFH74pKlSKbrar63ffHqLQZNRXJbr1FdePSycD3/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772591213; c=relaxed/simple;
	bh=tItAaEBxnPoXpRdqS9mLekf9V42u9kRKHs5G2MwVvFU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kd/bCw7BM3OPtmIZDsjlOWn0MkVzUtgTeKLiYPACwtFne4+M06TQn48x5hdCJCeLTdc/Slv9LbFpLYwmlAnkDh8KQ49RNgVCInLQXpKuduPOCqzDn50SIBj+AaH2GeqyB9mKwpkwXpxzBecDSdP1trBs1XPDld+om3fx586wxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBhY+9Si; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7985d11da10so63920727b3.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 18:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772591211; x=1773196011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tItAaEBxnPoXpRdqS9mLekf9V42u9kRKHs5G2MwVvFU=;
        b=TBhY+9SiCrGyJHABmgYziOjULMPvMHPR3xOJzbnncLBzwwogcFEb7WsoF6++qYQMsA
         OpK9QFiIUDPV0wO3t4rggDk7ET/wvffkUV6FewU+PfxiyN/MQ4BYN58CnH7OPI8rUQDQ
         Hs4SCQ+JNkUllgn++pR1F5PGW4kOrhs9hteypx1dWoN7O5kWPFQGAFk06VRPCd9jaM21
         za2l38dX9SKczs3s9K2gc2wnzxXVDaa1XG4rJoykk4Q8PE6Meg4eroUBFcOOL/1VCEBJ
         5q2SEAdUVPLVEPA14VnkdXlGwmJ98H8bUoaX09KtIOU6V7KN8RlaTR8Xj8wwszz0TkJh
         p+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772591211; x=1773196011;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tItAaEBxnPoXpRdqS9mLekf9V42u9kRKHs5G2MwVvFU=;
        b=V4eDIqddjNW7tP87gdFEFBrvChu97658DALfPMkvkFTdhEi3UHhNUmcg4iBbHnd9dB
         IgYrOz0YUr6IUtK4SeNxEvEBrkiJDPJxU06ywaea/yurcIneVvKR3goWYgkideJ4g1Ns
         ndN1NmdHDv0/c0H5lwl1bUgGZyj9RUxjQICW54+kigI6jKxGgkSxNslX62vY29ykz7va
         yddZ/kl/b5V/LMCBrV1qGBHQpkyhAe0EMNgE91c/oumrgcunA15nl9TnZ5Q6JskRHXxW
         xxCtWcctF+aHEIfC8wd4MN/NlqBOxyoqUE84ewDUqa9Z9R6czR1XoUo7w+xXMSNmI45b
         ZcbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7pUMrq5WB1QFGgypw1aeIxNY9J3HtrfONN0SC56LSiwucw72Wu0zAABa+rXzy/v4wh5scno4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPEIaF9qWvU8QKP0xwqzowOX/D+TWhj3zWGLW6iAIuQJ8336y
	Hw1TB/Ts4p8Nb5k4nEnPD3xvFyRpvfWGXuKnoxgIBzc1+7cPKqlTnteHkztDvA==
X-Gm-Gg: ATEYQzwLx9fZa1iF1nm0Edf2siBQon8/in/fbmmGvBNbQ+9okLZiLyMihvuGEqjHNS1
	q5W9yZF65yLg3eyEtLy/jB2A2pDzJtBZmWuOFlGhDJMra+8M/668KtZ7dcsjcvtH8eiNemzplHI
	MUgoQkj/KJHlOcsWcui6ANWiTE9WTSZzaaY4fkwE/dQfuoDmti0tSnHy9sOCjbsOAsrRqGkSnBX
	dfZoxQut44MhNHTXDJwjhoXN8qjZnP6S3ReQFKgWc3R2BHwVMJgADId1LX5I2mGmg00E3Pl1ss9
	Tao8/YQ8tXYOMwfyWuhvCwLF0TEKqHO/VYzsdoezgYc+Zvv4jmInQ8irN7/SJOdRs+6JyRrobxh
	UqIjLeQuqR/aZH7fOpkPHvyWFETwe/vlZApCoc4XSZaW/Bn6BrsN2xxAyWYpko9gTNCVSp8wG8E
	HmFGtu9ym+yoBYaEd29suEngyHTJb1FYyGy580shevbQabTISJmxHpBfPONtD6Rpx8R70ej1s=
X-Received: by 2002:a05:690c:6e87:b0:798:6e69:244c with SMTP id 00721157ae682-798c6bdf2damr4697247b3.25.1772591211425;
        Tue, 03 Mar 2026 18:26:51 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79876a8ce3esm70390737b3.10.2026.03.03.18.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 18:26:49 -0800 (PST)
Date: Tue, 03 Mar 2026 21:26:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Neal Cardwell <ncardwell@google.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.2d3a81ea23fb5@gmail.com>
In-Reply-To: <CADVnQyn30yeYsdu03Nw2037Vp=9+qY2G4yf1PSLD7JbgwoA-tA@mail.gmail.com>
References: <20260304015640.961780-1-edumazet@google.com>
 <CADVnQyn30yeYsdu03Nw2037Vp=9+qY2G4yf1PSLD7JbgwoA-tA@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: sch_fq: clear q->band_pkt_count[] in
 fq_reset()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C9B191F9D8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263554-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Neal Cardwell wrote:
> On Tue, Mar 3, 2026 at 5:56=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > When/if a NIC resets, queues are deactivated by dev_deactivate_many()=
,
> > then reactivated when the reset operation completes.
> >
> > fq_reset() removes all the skbs from various queues.
> >
> > If we do not clear q->band_pkt_count[], these counters keep growing
> > and can eventually reach sch->limit, preventing new packets to be que=
ued.
> >
> > Many thanks to Praveen for discovering the root cause.
> >
> > Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduli=
ng")
> > Diagnosed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > ---
> =

> Reviewed-by: Neal Cardwell <ncardwell@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>=

