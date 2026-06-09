Return-Path: <netdev+bounces-297143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u49yDoc5KGrkAQMAu9opvQ
	(envelope-from <netdev+bounces-297143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:04:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC716621E2
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:04:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ttCxL8Ab;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297143-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297143-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39C27317E850
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF348B372;
	Tue,  9 Jun 2026 15:42:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154C48C417
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 15:42:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019726; cv=pass; b=BYzEfDK+DOnBjCkamfyjCBv9mq194OTe1RbwZvm1y48GZupT8Y0PRkBDmaR8/ZInVsmTIJogvRY4HL6KC5VR8kNiIQ1Y17BiSGGZzP5QAb+EEEd7K/upszyGE13EAUiLp8gzdVnKYfiye5alp+o2pgnt2LweuCLA/fxa9HHzhJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019726; c=relaxed/simple;
	bh=ClROniq8wd4fg3idGbKVykUDJmXMfMJQFFf5yJt4jXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2noj9o25agRf/thmwLiARsEkX5fIDk7dHpthTuzEi/a7ZSYe18U7fyNQocJiC+QyxfjdTIgeGOdPPZycwMK6DePa2ykiGIUmIb1IVQSB2XA4J4p5cbtEANnsSJIyjpCCKCeKQ+wrrLGUm7kXBVrwNBz/F8rlr19jh09dguf5As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttCxL8Ab; arc=pass smtp.client-ip=209.85.219.52
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ccedaf0b54so37558416d6.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 08:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019724; cv=none;
        d=google.com; s=arc-20240605;
        b=PS9O2EvBsS9OgdmwNHk2ilRhBjHT/rG1ohQPauAxfKHqRkwWHabtUh/qY/Y+N8/Zyf
         hl+NwFjs+J8WQHuSzZSySMt7OF4xgxXso0BJqTptaZzLto6IfogVYi5EdaANo+y2UHpf
         /ugrpRE/qF+xxhDWAABXiisPq3566SPUyfiz99Jx6xx+P1+Od2aP0xXcFXtT5nTKZNXq
         KZg30xFTAeMFJ0I2JbaJtjqm0As4P2RZwisoOFB37iRSX4lMteEZMJqOgcmbrlC2vJCI
         XomorqBptaG4hpd7nbbEOEaz5WxmXppECxirr88H9CVxBTFZuRGXf44odAsPGlSswSoe
         Ha/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ClROniq8wd4fg3idGbKVykUDJmXMfMJQFFf5yJt4jXE=;
        fh=CMdT8H3M1ZsI/VoJfdZQPfzXPKE1FnxwFbnUYNa8lAI=;
        b=SINKl5hJRWZQX3+TPGWhwt+hNHco7aIrRD/CqAujJs9Yj/YHkOeFpdHs7RvuHN2hoh
         chNaAQy/dKYQC0SeIO/afsLmur4NGZojEsbGlW/xrL6/43w1K82b29cvGcnkaurvSkBL
         ncQHl+C2anND74B3EIbazNKPmVO2LiKFdLUtdDfiF3kISfQwFJhfVAoEXY65dhD+lONo
         2qI465yb2qjqsphCInuO9Yl3EMp80NPFQhdHIZDcbWiMX0GkQF6pRyx0rAWaG06jVXKN
         N1EXGI0mpMtfIK5NmKwfSVuevIwncoeLN3HX6VC3JOYl6VCGyUyNTfK53Hs0Kc2MW/nB
         Dyxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781019724; x=1781624524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClROniq8wd4fg3idGbKVykUDJmXMfMJQFFf5yJt4jXE=;
        b=ttCxL8AbsHW3yqPuxbsUR9lGt5pgUuHMKJzQaLXWO1/hk5C/Nuu3Fc1H4BhtPtKSAX
         R2PIt7sclhmZBIUu8DA9a9UHjcXHllx7splHpaYjW2OBZ+4jjkBP39G5IRtmUxEgLCfM
         IGqQFAS7WmDoRQ3TtliZ2hY97JlFd2gAyz9qrS7T2P02RZ0VsCq0JGSMQQwnyy/M9SS/
         VsYRQnPQAG1Le4EDZG3wJM+tmNIEEBhQa2nW8YvWusbRm5IhEDvl61YF2m+CmZXI/Ay3
         +p7ORU7Vz5ajN6EHGD3h5fA85BdiI6BT3VQ7ywu+/TF/RLv1QoqcNnHZjYTF3ssQ4sFc
         PQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019724; x=1781624524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClROniq8wd4fg3idGbKVykUDJmXMfMJQFFf5yJt4jXE=;
        b=FhUXXK4c3vQsX7oX97ibro8xDf+42vXsg19hMbAEC0vJTBX+/RhOEHFNnOBN2XfaYW
         6k6rwplMKJzRbdnDDebuUz0yzG6Y+eS/NKirTRsIGnDOoabElXjuoiAEjlODbU2Qat0Q
         XEthADvRN6IPWxkmXhSQbcdR0nSkk8BH3A+BrebyysB5QBQNOr/IiqFmJOwPl06t3B4U
         ZeES+Ku4gfzioDAYOJXjrgqLs29DbVCn/gy+Jfo3iibqT3n0+pHAMP86abEISFZgY0FK
         LlSR/sv+uULBMc5QhCEUWLwZCboV4HtQZChRZ3OsZrEt2Qs0eZFATpig7Di0ZBqu8HPj
         xHuA==
X-Forwarded-Encrypted: i=1; AFNElJ+wA5Bg0GvdFeGkiKaHKARFvsuiUe263ilthJnZi30kOZCD8VtsDmzSS4aoq3obVxGSnCPTzUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjP6KfxtgrfkUHqCynxcmLbIb7wvBCOHedm2wt9hDZlvQGcPZo
	HqjxIUGaBMq8bQCIRWem9Y+QWNWLypKPdSFiSpV+iekecOu8JN/rxIEjlh6RIbd0pe6c2u8ml81
	gewzHD0MPvk7SG+5W6K+ugHapS/ESBKYWqinL3IDHWU2YL70P/xnNi/JMPrE=
X-Gm-Gg: Acq92OFqfK4hxA9xKoZ10xa+QoQPyXCItNk+WCxqfpr1EX/DgNnY6mtV1DRnZMx2QdX
	CCDM0LN8FgqpvXaEPKkDFAaAjO+tv0/umrJ4rliPdbFIRjqBhNMLP3jUucvalxEn9UlN8tL7SuR
	3gxZEpM9/aPA2N/saEzMtbKSZvX4yFOOjyEFd9jXonrKG1tfU00XdC8/CGBq3FqhLcENekUenKS
	z8Od3BgSox4ws0dzHZ0J8+RCCGNce/GdT9o8mTSP4tOlBM6KA8w9GUQe1EEDm9pyg3f/9uRgXGE
	dvMEGNJpN+KdcH6QtCsV3G6UoCGeVQfcmqJrH+xDnxb4gv0Q+G8X0apYMdbo8P6CI2ZwNu6TTg9
	NiUV6/ZaX6rfuHZKH+hvucu2yKHH2Vcgoz/r4UCyl
X-Received: by 2002:ac8:4815:0:b0:50e:62ba:3ff7 with SMTP id
 d75a77b69052e-51796953383mr203753571cf.26.1781019723700; Tue, 09 Jun 2026
 08:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605002912.3456868-1-kuba@kernel.org> <20260605002912.3456868-7-kuba@kernel.org>
In-Reply-To: <20260605002912.3456868-7-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jun 2026 08:41:52 -0700
X-Gm-Features: AVVi8CdfrJkFBLjjDVeLZ33DLsCTNJHi2i34aGh21oTNCzAJ3BEmhK_6JOeMzkA
Message-ID: <CANn89iJ80LyP9HfRs2+7OkRzEdPgPQKjThY-dUS5y4A=V_dMkw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/12] net: ethtool: optionally skip rtnl_lock
 in cable test handlers
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297143-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,google.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RSPAMD_EMAILBL_FAIL(0.00)[edumazet@google.com:query timed out];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAC716621E2

On Thu, Jun 4, 2026 at 5:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Skip rtnl_lock in cable test handlers. This is really a noop since
> no ops locked device supports these.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

