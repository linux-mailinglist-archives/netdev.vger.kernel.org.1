Return-Path: <netdev+bounces-293349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WALXCv7/Gmqn+QgAu9opvQ
	(envelope-from <netdev+bounces-293349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 17:19:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF40C60DB31
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB2F63014803
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9732E2DD2;
	Sat, 30 May 2026 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTvUu843";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8y4xHm6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8D23392B
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780154362; cv=none; b=Uqs4y/AEff5Z7codvP1vgYoXjiI3ZPHVpZsFh8NE9+uLDKus5igybjRngwaU3pI7WOdj3QlpmIaG6AITxBdNH8yQQkAXixTKZ72pcfVnpo+1hiGZj23OQH88+64x7wSupg7GI2kwi4GGjSwVgtnaiCDwznxRrOSi41XOLDew8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780154362; c=relaxed/simple;
	bh=dKEZUiL2uRBe4sxxhKgEmKRLXdf3Nh8h47SQUzm1zY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J7vVfz+khk5r38b1kpWeVHa5TJ26o6m3jh/VhP/ZewfFxEqtH2uxKNWMQCS79nKrxCJovCq7CdF4tKGKEj0YW2QO6mRsHOuF87NZdSLfgjS/wL9HooOm1tppLlB22aPPGG99w6pkUuxFJ8kOTZ2/qeOgJQ110gJOfI3c3AKx850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTvUu843; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8y4xHm6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780154360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aE7Th1lp6TsxWlZ15cMU3n+klk6qhPVCeyJ3BKf8a08=;
	b=UTvUu843cmFhOKNRdNTkRs4vmimzISQq2ItBKEgTkl+juO/dDIL6nkIrW2tCNLQ1IHXPcM
	mhw60g9yNUuknOc9AfadSZH7LVRSMG2Qq4Dj/McU19lfh6UDezzu1AxFOE91iGD36PyvY0
	ai7bTSs8IaXYcIwMB7NBGBtCeZaNzhY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-dykBCSa5Mb2jLeeoo6gV7g-1; Sat, 30 May 2026 11:19:18 -0400
X-MC-Unique: dykBCSa5Mb2jLeeoo6gV7g-1
X-Mimecast-MFC-AGG-ID: dykBCSa5Mb2jLeeoo6gV7g_1780154357
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef0af9517so1461271f8f.3
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780154357; x=1780759157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE7Th1lp6TsxWlZ15cMU3n+klk6qhPVCeyJ3BKf8a08=;
        b=J8y4xHm6cA3mNdueb1j9V51DKKJ5UYaddzSVBZp9AnysCSIwxstyIlFOXmvOBSOwcA
         Bz26XXBgrPIUApIMJOKIGYrPb4waczPN3zBcU7IMyVscqTPCtVQm/GCnVC2H2ccZzxca
         nL4eUNB3dh5vicC7cSrtkytIybcs3mCz2wNtH6ErAoZu4Hw3ELqz22gNQ+SnRZAkBQmB
         spWToGAlBCUEvFkls8vJO4K3MrYkJcOrtfA7rA6ET8F+oklXNoJgFm6w/JUTGHkc88j1
         A7MybJ+LjtQtzplQgoe7+x+QSRlZ0v8rBxSmPFP8uCZlJNDBklBb43vEsaOmYzMBaTI1
         kr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780154357; x=1780759157;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aE7Th1lp6TsxWlZ15cMU3n+klk6qhPVCeyJ3BKf8a08=;
        b=eSkW9eGu5sIQP64UACb5kr2GcsxWXRNkRVhE9k1UQOTfEAf/jktep6iyzYjziDzc++
         oR5Vmr7Rtua0AsaH5ZZR2azNk1CU+KQFGoyqSkc9jVOupA11UthPNNjM6u+zIHkBKaUu
         7ZYlRGKO86gMsa6f5hNdSFdh8i3pPOFqrmbal4fMe+Pp66kbL4//shYQm/FJ9wzaduoc
         ebfYwW4LzJe9cNG02QRtvwusaLO3ypPZ/u3kdVDy+o2Zx9sUijxDQk/lzZHxn5vli8Mn
         h7YRnkn0KAVtcV1lHTWjyHbZ2NWswTKZDP7sr/JlpGNeCmhyvVekuXDuFyITi7gfkEDw
         x92g==
X-Forwarded-Encrypted: i=1; AFNElJ+6/Aw8dL2mzfPF1mXvC+lace9SB3eoaPhe8C0rUGfxtem48lxvSamx6XpauHBpA5kvUNZ5tOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+mvtQu1GzZYG3pUB47RpOmvpzd0lXNmewG/ZbsXt6dW6tFUL
	a5oGnv+Iym3KEpcqLNfLyH2+HmMlu6H81x2uhmV9WbcAPodPGY6NapPA5oRFpsUKKeMvujKzoRT
	ZmZeLS+E8Iu7hneU+UzUEeSOHPluQlg/LasykxaICSHYi/OL5ktqQxooTpw==
X-Gm-Gg: Acq92OFBB+UDFJNRz4nwa5NBrP2JreqOh34MKS2UeOYn+JsCXrFNuxQ9nj4FJB48azw
	3YfKxm5qg0tgK6O7IHvgYmsg0jTjUJn5FecKdWcxGjqiBcD6G9GHremXez4ZmWu2HHhgoKKyzVn
	mLmZnfzgxkg3RSvKPex1n9JNpvZytPqCasTtskFkp0fpqrw1gRYZ1pR13BsXXo9Sw9/nPRoDC3Y
	15TjVm7kiTgvXeJtF4wWqVSYyXn53lNkrcObeuUtnnmJK5dVIokEeu3/Q301F8G48W6qVjAJSqC
	2Rcg982yH/Uy1S3dlpmCLe+zIoeeAM+AN7VEO0lstHwBKHjGoTdw1c0T4ZPIuS0xImsNutfdVVs
	F142lWVs/kmfYUqDbSQf+sdw/oyAlHjUH7RHbNc6RrqYLUl9VZHAsAoVNTp8=
X-Received: by 2002:a05:6000:22c7:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-45ef6b19b8emr8296177f8f.17.1780154357285;
        Sat, 30 May 2026 08:19:17 -0700 (PDT)
X-Received: by 2002:a05:6000:22c7:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-45ef6b19b8emr8296124f8f.17.1780154356857;
        Sat, 30 May 2026 08:19:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34bcc30sm11630958f8f.12.2026.05.30.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 08:19:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CF8547BA5BE; Sat, 30 May 2026 17:19:11 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, david.laight.linux@gmail.com,
 yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com,
 rollkingzzc@gmail.com, dcaratti@redhat.com, security@kernel.org,
 linux-kernel@vger.kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net v4 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
In-Reply-To: <20260530080643.1345521-1-jhs@mojatatu.com>
References: <20260530080643.1345521-1-jhs@mojatatu.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 30 May 2026 17:19:11 +0200
Message-ID: <87bjdx2ads.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293349-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,vger.kernel.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AF40C60DB31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
>
> tcf_pedit_act() computes the COW range for skb_ensure_writable()
> once before the key loop using tcfp_off_max_hint, but the hint does
> not account for the runtime header offset added by typed keys. This
> can leave part of the write region un-COW'd.
>
> Fix by moving skb_ensure_writable() inside the per-key loop where
> the actual write offset is known, and add overflow checking on the
> offset arithmetic. For negative offsets (e.g. Ethernet header edits
> at ingress), use skb_cow() to COW the headroom instead. Guard
> offset_valid() against INT_MIN, where negation is undefined.
>
> Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writ=
able")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Reported-by: Han Guidong <2045gemini@gmail.com>
> Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> Reviewed-by: Han Guidong <2045gemini@gmail.com>
> Tested-by: Han Guidong <2045gemini@gmail.com>
> Reviewed-by: Davide Caratti <dcaratti@redhat.com>
> Tested-by: Davide Caratti <dcaratti@redhat.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> ---
> v3->v4
> 1) Restore the Fixes tag which was accidentally deleted in v3
> 2) Remove tcfp_off_max_hint as pointed by sashiko [1]
> 3) Fix a boundary condition identified by sashiko [1]
> 4) Add unaligned access support to safely access ptr support to compensat=
e for
>    removal of skb_header_pointer() / skb_store_bits() which handled it fi=
ne
>
> [1]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260527181731.116=
6373-1-jhs%40mojatatu.com

Re-tested and LGTM. Let's hope this is the last one ;)

-Toke


