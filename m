Return-Path: <netdev+bounces-297137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tlixOsA1KGrgAAMAu9opvQ
	(envelope-from <netdev+bounces-297137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:48:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68672661F76
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:48:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uDyLQ552;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297137-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297137-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E80532DADB1
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8643CF02A;
	Tue,  9 Jun 2026 15:34:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC773812D3
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:34:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019242; cv=pass; b=XaxJvgFyl7UJC8qfUJhMmVryN8rGsVoHMzl/LlHCWa6Fq69h/+svol7SrknbaOTNZR4Obzn4nL9TK9wORV0ZBF+K4W5El7bJVnllRLIrT40ooNdojxNfVc9V3XuEfXMILV+rOmrQomnNmiWjZAX/jnrjtbBy3QPu5IT5SZP3khI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019242; c=relaxed/simple;
	bh=iUtvfyXgaDI5KnsIov4b9KjldMuCh8AdWzMWcmVt6ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzqGhAhsUqI8EkObFckMCvHiFVWOek80J2R+HH2ZhZnTpsILpgXKHKeiUtPffspYQDfyt5qHF+70FoEuKJIhdItYkr0ow+gH4B5ANhteipfWZjqMXxR2WE/oEcBJ5XSVZn50ayN1BQhoc74O9u1lomizmtQDtdQcEmlwCDTzCbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uDyLQ552; arc=pass smtp.client-ip=209.85.222.180
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-91563382bcfso653933585a.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019240; cv=none;
        d=google.com; s=arc-20240605;
        b=GxbGa9/tOWE0UuRcDiFh+wfcoJc4b8zCO483jdgD8oA8gLMTDgQu44CeKWbOzTZ7JK
         FTczjlGZEY0gfIVWmUuiV5euu8VHrUOCN253kk06l2ZUxpoDq9CxEfcmJyTmmZtjCiqJ
         PQ8xBxZsDfVrHPyO109Ce/ipsZmIazoczIUaDjeoEfpdSuTRQT2TweTZbQHYI9GdYR2W
         nLaS8czQybJkFFr4iSxT3wNLb2tsmz94jakl0GQ3QZTsocrJyfhlXPqFQR/Y8T7nXmsd
         kLxAwi5EpgQA9PB2ltdrWPIddO7ERSuIvF1N8tCzu8iTONqh96z1mjdaMRfM0GKXoFpy
         hlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iUtvfyXgaDI5KnsIov4b9KjldMuCh8AdWzMWcmVt6ps=;
        fh=osR2wITpj4S9+ehn1Hp0OpcrkiTCvEXBVgz3qqW/dRk=;
        b=EhSA8z2qbOeCH4s2JUqF8sLLwNEQdGh7vAW1YlKCPu25CiTw5XjJhQW+RFAotoMRgD
         46Cb829QHQ+aP7Vm7kFED0UZeLPzDF4DFozzrAT5LVpMIBxTLUwqTDW+8+euBACjkP4N
         X+fGOz/1lomRUlGMeJh/NURhwiOCR1aInSqZEOSeNEo51XbtR+KCiX7rDmojhkeDOdcf
         GF/3Lg9l4UNjys+kIyBQFURsle5e96jgNN0/AXewV10nJwwOhxnLuBILp+S96+0qZtH6
         aogbR7qL86zPYGDJvMxaqiQi2p1W1XdjPpdEV30rFWSNoDv25Bcu7J+j5zikwvmLDQhM
         IWnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019240; x=1781624040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUtvfyXgaDI5KnsIov4b9KjldMuCh8AdWzMWcmVt6ps=;
        b=uDyLQ552O31jsOxQJk3vPlwwHhtCQ6UtsjOF5HJ79KJ5tWc/Yayvv/mT1OyH2Q4Tpq
         aNAZ96YyqzjIkNtl0y8QIR/Nt3RpJrGeg7SIFIQeSCnGfUidze5a3Xb3RSKUrOvjC6aS
         0D1C/NwJNIZDvWTciN9yxNNUDGb/iM5GBck6EOsalra4y0XRk0TWr7chrXT+NlvI4J7C
         nMI9DKPV0YzObRuGYcuK870vNWuh47GxonDJ9iRbNh7h8MLnXllmc0c0dor1sCmC4d+s
         /lsoLQbCzCdnol2a3xH6Bf5fPy/a6l6tZXItUxu53v8fdIGCceEma4wlZ+2pU3LhNoSR
         74zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019240; x=1781624040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUtvfyXgaDI5KnsIov4b9KjldMuCh8AdWzMWcmVt6ps=;
        b=OH5kZ6AStgSIAto/xhs/JcPl/ouxDjF/LNYlajgUeGU3BNrbr93y2HIzoApAJeRKB2
         45I5NIdvnhEovfSBmAiMQdMEkric8gNQrQjovfBlFIckEPXpTNRZe8W8bGy2Fs9lK8VM
         O/i5dwT2hjhLe+QU218sf+h0i/NjKcM05sVlZbX1DycjLawf2p9Oux81WP+OE96+SbO6
         ULkp8ilBqV+vlR09kzx//BxtIB4K2O3LIaOw7Zby+FNSnKi6KTqLtwD2XsdJg2Jd2bEO
         hCNq5rIv+6C0Fxe3s4Z9oS16CHOJFL7XAafVupvq8T8ckgW/Xd+nU37CfY1VpdkdO403
         2+Lw==
X-Forwarded-Encrypted: i=1; AFNElJ9uoMVJJ0pXWaBcp+lq6ToluSd/Tr+nnwz2OISW+ucfsDcx/41cuDbnQIt+JB8GqhGrDqRkMmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1+AgvTNi5uBQI9HRyUmtOG+XSUMSWxyd2burlwzM+GANfSyMZ
	6yVU8yOW4+MhHfAlbnAFxCNMu1LRR2lkYzl2aR0OlpNUfFW9+xY9qkb7jpkhaT0WkkpzzwK/fQk
	xGXCAXLYrUC0ubqXC3EnoNPFthp4IyaTu1Pf5cCMo
X-Gm-Gg: Acq92OGS0/aqkQt/GkYYmBSCJQXdtfFV8Ac3kt8jeQ/JtqGiVXFsOUWWGmdpFQRA3Jx
	CE+mmWp9kP358u4Z+n2WzMd9sR/FQ+6Si4e3rt8FIQhHhHw4ZL2ebcZ6qFWglgOlwHSN88HtRN5
	F07LwmTNpTThkqFaxqLNLeaYxPI7rGuFoxPer7h+bZO/YuMFLzC8edBDcFuTTSiNnXZ7djdD18G
	Az58Qt1yifrUH9eMxW0yPB38VqjqUBOwDmaRqe2o7WDWDvTRg1Bjt/X0LK7Lvkw9ZwHW0owDdjT
	L8d1a1MB9lEBEdC2lWkrywTDFUtjQndcVFH2zhkt+3zBOvWDUjacDqafXcTMIvv/dL1cI90Uve2
	Mb/g77wJ88GR8ZxbzqsKMFJysEwQuRQ==
X-Received: by 2002:a05:620a:254a:b0:915:6758:24d8 with SMTP id
 af79cd13be357-915a9dea2b0mr3355951785a.42.1781019239064; Tue, 09 Jun 2026
 08:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-3-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-3-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:33:46 -0700
X-Gm-Features: AVVi8CdIeOuG_WsEGh1WRDFFFjdglaeeg3e5KDJT5nxr5f-aHJquXEoG4oUFIyg
Message-ID: <CANn89iJKLEy76d11byC7og=KmAf++Ozi2yOc4tGY-97C+LPyHg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] net: ethtool: relax ethnl_req_get_phydev()
 locking assertion
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	hkallweit1@gmail.com, maxime.chevallier@bootlin.com, joshwash@google.com, 
	tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com, 
	jacob.e.keller@intel.com, kory.maincent@bootlin.com, sdf.kernel@gmail.com, 
	jakub@cloudflare.com, nb@tipi-net.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297137-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,google.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tipi-net.de:email,bootlin.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68672661F76

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> phydev <> netdev linking and lifecycle depends on rtnl_lock.
> We want to switch to instance locks for most ethtool ops.
> Let's add an assert that ops locked devices don't use phydev
> today. If one does we can either opt the phy ops out of
> being purely ops locked, or do deeper surgery to make phy
> locking ops-compatible. I don't think there's any fundamental
> challenge to make that work.
>
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

