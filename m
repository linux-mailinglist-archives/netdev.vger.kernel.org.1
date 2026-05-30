Return-Path: <netdev+bounces-293300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Oa3DXVlGmpo4AgAu9opvQ
	(envelope-from <netdev+bounces-293300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:20:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC5A60B3BA
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 06:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71E02305A273
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 04:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8549234B40F;
	Sat, 30 May 2026 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqAeZEKD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CF74503B
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780114794; cv=pass; b=EHmc9KnBv1RmDi9hBwCgA5Wb+MRjYgZ7CMSKC1YHcvJypcNPmNvCaExSN1M3SuzCQDaVld+hGbC7Soi86Vl+qQOWH83LfBB5VT6R1OOhV4rvGU6oiqlmm2zf+TcLK1V1xP2Higiy38+Bn4pU3kRVOgrCUj/MqyoppskszyBFS8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780114794; c=relaxed/simple;
	bh=y6+tPv0/NFd5I9h1ILRWGG9wyaX7TnDdfsxN5Wpp3M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHUEua2X1W7LJ9BsfE5XDrqQZdPkvOgUnj+v8yuH2UIxoATEDmX9a/OuXI+d1v0fYaBeM+s1YKz6g5TGxoVY2rbg6HPUUCeZ2iWVmTHRenbMb42oMv4oVg1I4ySvd7E6s+eWc/ylhsA+Q409HJhwqNqWQaPHz68Uz+3NQQqktgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqAeZEKD; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137335bc3caso6223848c88.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 21:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780114792; cv=none;
        d=google.com; s=arc-20240605;
        b=SASz6hzJnXN+AfmsjZyY0NdQROoTX9PFAzmYTyuvd18Ev1sweTJOpL55yzyeY9EJoB
         lThRSRhDvnFao04dGRPrqtAOmVvNKiJWCQq4q22Ae64NA39GOJpt/V0EJnQGe5DBvQCi
         pstqAwAmpAUBUxeifynZfo4pX21GmuGMziTSkP2f+z03PH1PAt1Hpg+ARpUfxvr+d0cx
         o33A4N+4ZbgtmEMAkBP+g3N2LWnhbOcLP+6DaOviUihRwxtjYBbmY6COP4FV2WvFE3d/
         bpb/5Ixpe96x5xV4APrObOdv1CQJSI3j6Tjd5fQzL4xhuw9fCojSNzzm31va0SedHFok
         janA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y6+tPv0/NFd5I9h1ILRWGG9wyaX7TnDdfsxN5Wpp3M4=;
        fh=9ffEoRhZjwRRqDRzooxQCimogUDxrZdOGrSd2UlVXZU=;
        b=Rxch7uNt8xfmgPHZY4ZW1LhUGre5PDs5/C3857PPaUoahiy9rvvqDj1eG8BJkDksof
         klQ9uKwsiDUCBBBpS5lLBe3v3DZZheWgESUlWESDPfqYhwAOLXd56qTQUr/tjEkAZYtv
         0AyDnNAKfzoDXkc79vCduChR3lSY/LcixUonmI1ORqPK+YMbq0QesZ9efy++SGpaC9ME
         /dPppfgoMX/77Q3huumiqFDUjzmE3s59qlq5vNADNsYkjuLMtoFB+Rp9MjqrE8vCSWc6
         iwKPZaFL8tyZ9uFcE/ajVAiMcB5Taagp4jhjkBsBa2dP7OLW1hOg25CU/mwhXPlj90HT
         2UwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780114792; x=1780719592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6+tPv0/NFd5I9h1ILRWGG9wyaX7TnDdfsxN5Wpp3M4=;
        b=tqAeZEKDZuf+WiDkx4N+FU31XT6zj7gJxIXzC8jPu14abrHWAz9x7hOjdUSriRm7M3
         7w1AQdiil2lXKy1rv0Z7B8DdgGiE5nFAjirxu7xHZVGM1WpUaGzDvqb+17SdhaJ03q4q
         ilLK2sxVgg+ORmi+xlNpERkX/BmERdMYsBaCzUlXDnVBEVpIg6MPH1Ma6JCSP0dM0I2z
         orbbQEN4nMMTftwNBOBi9wtIGG2fmeVkd7rqHY26kQs37o9mukD7g+rBmxfYTziNbIaU
         mAFmlOqZRsxEsEia5U+kRZNgjQQepOGIzSSoBMg1dpS83jhf2yHdQX1qjrWRmSTemIgw
         yBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780114792; x=1780719592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y6+tPv0/NFd5I9h1ILRWGG9wyaX7TnDdfsxN5Wpp3M4=;
        b=b9NDEghySbpeMLMEFerNM1mRHlm3snIfoc9TSgQSSBryz4rvhMq+Q3ptNeTYJ4RCze
         WwWdgQf5sI8cl23LGoKWXxOZfEKOf09Np2hg0mGzMkYIdUPPnB7ljkaxUmf3cMt6dFZI
         3j17jE59ns7Yojbl/JutNmrCV8E3wpHi/BjJe7LkTG3OUo0ylTFmeA0+tWJ8Dcp/l7KQ
         Vmu2rR08URjgpj5Z/07RmbInU9tMPxfJ1l0lpisBFPAnVVkhbVGYQ+OIQnf9PXPSk7vw
         45ZtepmZD3gyDN42cXqcgEY+QDvkvW/fvzq2BdmwMtmA1P3HeEmIYizFcyLtgkfnmdlj
         0fKg==
X-Forwarded-Encrypted: i=1; AFNElJ87fooJKQihkCNRstLzo+wfw0TGHd2vXPek6XwH2hRwTDZ+ncHnUJXWb/900sz+HyldhLMAb+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4FIHx/f4p962gSRZZEvsNdlrfgw+lbLbqK6E0H/oGNW/cVP8
	U5ECA23UFb5ClmWf91WAaK337xForuyev5EzuDPMcfOZqz/3aMsYMYAbYM+tWvEhtgHOv8am3za
	v9OVmsr8K/zqLSNmQIMtGyN2ONRcAr/2YX57xNkRF
X-Gm-Gg: Acq92OEa6anhzVUHUBqeNdXM9WQ78J3OXw34rcTIY+BnbsbK/ZKyl8u4A1eP2tds40C
	00R+5G8X6YAOD3xTVoccvHSPUkxozwjArI9NTuozC5liYf79KQSpHDMedE39xDIZ/okAK1UmG16
	jSgKmHAx6FdxdcYZ2eCwBylpiY9icp7mshpW9q+N1FgvxHvvMf8JNAq33Xpa5GiIdMBWgzJBXGS
	96knPGHjdeFn7zL4VKgrrEEYacSrUAA9YrdV6PtyaLDt9T2tkcpnNw6SEarJAiQ1kYK1ZJAfDHd
	mbX1Z37tDHxBpWu2RqtsL1y4H8uqz0OSu227VaFt7AuGMCd+qF1Liuic1PXF5nJXpLx7jkeeO2o
	EjM2SWAjjMG9CakqgnI7r5sIKgv5GncraChF2loS9aZZC9NJXwDTbtMSmtNXH8ns=
X-Received: by 2002:a05:7022:527:b0:132:f27:5302 with SMTP id
 a92af1059eb24-137d3f1828amr1066714c88.3.1780114790957; Fri, 29 May 2026
 21:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528110033.3327744-1-jianyu.li@mediatek.com> <20260528110033.3327744-2-jianyu.li@mediatek.com>
In-Reply-To: <20260528110033.3327744-2-jianyu.li@mediatek.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 29 May 2026 21:19:39 -0700
X-Gm-Features: AVHnY4L5a-LiExw_embK4yJcCcNwv-WDKQmOgBI8bi2hCQN4FGiWysaeNn5pP6c
Message-ID: <CAAVpQUBWHiesqw-suO+-MhAEzy11YkkrihjKkn5mMMJgj-B7NA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] af_unix: Fix inq_len update problem in partial read
To: jianyu.li@mediatek.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infrade, black-ch.chen@mediatek.com, 
	ivan.tseng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293300-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8CC5A60B3BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 4:00=E2=80=AFAM <jianyu.li@mediatek.com> wrote:
>
> From: Jianyu Li <jianyu.li@mediatek.com>
>
> Currently inq_len is updated only when the whole skb is consumed.
> If only part of the data is read, following SIOCINQ query would
> get value greater than what actually left.
>
> This change update inq_len timely in unix_stream_read_generic(),
> and adjust unix_stream_read_skb() accordingly to prevent
> repetitive update.
>
> Fixes: f4e1fb04c123 ("af_unix: Use cached value for SOCK_STREAM in unix_i=
nq_len().")
> Signed-off-by: Jianyu Li <jianyu.li@mediatek.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

