Return-Path: <netdev+bounces-251944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHM8C2P0cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:44:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C78AE5966B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 479D6726D90
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F75D3F23DC;
	Wed, 21 Jan 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d28bk7Ss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE5346FB5
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006781; cv=pass; b=PLodcH2dynr1s6WXzxIsLqzL/5aaHIakaGBU+WqSXr5QUUipz1acThjvEKxXeiFqqDAvBj/8ydafkDnPfZgh97B3AJ2GJNrPEYcbCqpWIqSu03BNyaudsk4e4FDPV+VIuHeUYUevNop0bVRIBnACXaEGKoyMmoJJoagGradQ5OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006781; c=relaxed/simple;
	bh=8LkGGQMI+aFrxwwHHlu4NNetbr+QWG/yDGjZ/t1VPz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAMZGrDylveMsCHBUFskxV5monNfes9WzWi/mj369+1M5cJrpmiNSHc5eII3aVvIQOiIqSil+wkAKZBOgW/4E+lTUMa7EpytnxUgNdfM+Qu5/HB97cX7qACSa6QYplR6bw83ei6Fe/b1kIHbIGPNAb2gnwLwyoqms8oZDUS3g/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d28bk7Ss; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5029aa94f28so7962461cf.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 06:46:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769006777; cv=none;
        d=google.com; s=arc-20240605;
        b=LZZ3YNpW48rEd7jFfdxyYltKK2ce7v9DEBrTIK/Xuej9dz8Lm7yhd3yXx8MRH7oxTh
         6g0a4sWv5MjdTcOfaCL2hggNXPLz4677G3QN+ozUeUocZgSJM2YF0723g750PCmBZiDj
         PL2CM4ngx3/P3WJJpL2YvOnWXTMfakmgHmj9NwlEnIQDTsW73Kk+2I7eJTrHEUWMYEle
         GIxheoscpobHg+6SAI4R23KSeTM2AhYp/F3xz27+6v0Az4BiB/iSWiiF6qONyAJ85VBM
         y2ZcLxl6fNktiRLgeT+uKtLTS/Tl3tZWAhOe8OGyyAb3HIaK5KaC3KbYlxaEH29MO8PE
         VW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8LkGGQMI+aFrxwwHHlu4NNetbr+QWG/yDGjZ/t1VPz0=;
        fh=Wl5b63KQQXqqKgLtLhFtU+CUMgQMZIjEMmUr8vI5TOo=;
        b=HzjrRCWu9YkhRK8dqcbOtqoLnylzvzrCeP0joVeXGFVYPJiSOx6Glrs90dfRt9kgdS
         XurAjJSpp8RM896UtTVxW3kD+N8q6+n++0uRd6R7L9RBWUE1xO42gv682N0X2vlXzYbx
         kXRA0DIu+kloQKDYdRH/3qhzdRh3CFYnsM0k4MZn86QmXqgmB738lTJkgl2Lpvyh9ss1
         5zQ70pkYxLSbGwFIcQZtN2I7PgyXatkyHLoIkQJ7vpKJ6GawajxlZ/lcotcTX3AmInvQ
         NSNbKXogeD9+M6mgcrudBAH6594gUD9A32kh+AKZmVc0vM2sf5hcS4dC0d3XIttJ8l/J
         IzJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769006777; x=1769611577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LkGGQMI+aFrxwwHHlu4NNetbr+QWG/yDGjZ/t1VPz0=;
        b=d28bk7SslA/sFce7HOZK4TTDYBBQeo+OKAEYlM0vlhVpL65gsBLhCO6KPHMsWlw8Wk
         mosONMTxIPvFSicjHS9iTtQM4OuXCGSSByMIwvfm/jqbC1xRIweRK0J9DZZDDVZc7KOi
         EmcVdXOBxQD8DhtHknYdgtk9PMM+uk9lBU2xqL/xI0JVgR5ps/6oOTaoGf7VNMllYt+j
         O1xWMrpwCI2RrozBPlabGr/c3iw/PgxYCxQCpooAepiS/GQ1d4WfMn6pbMfVgsRNLVTV
         A4swtaueVj0Qi9NeCwr5GoGrM1LvcAoPI4J/2ZlREuJxFyXsDmEhmdKgH7eXfQE6oemV
         sd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006777; x=1769611577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LkGGQMI+aFrxwwHHlu4NNetbr+QWG/yDGjZ/t1VPz0=;
        b=W+nKeSGVo/CxHrtiDyb3LqrFgeweenL3SwRYC62CXIEip2+4T4IZV0ZsslxskqCSlN
         7Ln3YVwa4jAsvA6oXk5HEE2ttu1ja2iDRn/xDa1NT+q7QScx+aNBk5W+vJXJOv8ZwWuQ
         U6n2++S5e+LRpr0f0DOndPejRxPrSdagJpxluZIS7bofHjxYaF0CA8vNb4fZaTFIkBWy
         qB1FHaOv2D42WwVxoE2GUVaZn60jUpdHU0Q/+plzCgnIBD8gdNzphKpj+Thvu0R2CrxO
         NBGSnSlQYkQJwr9t0wawgktN0ldKy+feZQ1d2+j6TXUuMYazc7WMNVbhTDvqxNbD9o40
         tNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgW67fbD2SzHo1Tl2cezR5LdUChQiQ5rZanKvrT9TCcWgisMQiKaF6kHFa1XoSv3+7Zod9H8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKWkHSlKuztSQF5kChu0tKxaCdB/e1Ob57JLE1ErwMOujSd4Bz
	Q6vy3zJq+oztmspCWfP930yw0lO+JN+ldK5fxk9hTXWyKWEphO6CDb5jo1TjkoqAABiCqLMHjhz
	Q9jhb780zpl/wtGhd5qzSkaschI3Glp1FPOcuOb+e
X-Gm-Gg: AZuq6aKsPhqPQI6XcR5yUG/l+T/Wc7hvyxnX6x+M/Y0MA0Ezqi26SyOC8yQcsQ4RE5j
	MUjiwAA5NO2VSP+QKPBnfADSWW1rE5DrPVUY2P5OaZhnD0/h1U59SEsxLS3lITbVQjtVc06FVew
	f/t0um2mNH9mwzhz7n3pyPLxvDSDwsQT+ooxRrJJ9hL/10w/kBxHhzwgV2TRyDHeY8JDvvZxMXo
	RprrCEchPMQvXZVttYuFprsf1q5uzPJo4vreEwtZ+Rq5tjB6dTqVmXIrYzQcjpNoYkt3qg=
X-Received: by 2002:a05:622a:19a0:b0:4f1:aa52:878 with SMTP id
 d75a77b69052e-502a153b0d8mr241578331cf.9.1769006776632; Wed, 21 Jan 2026
 06:46:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121143215.14717-12-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260121143215.14717-12-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 15:46:05 +0100
X-Gm-Features: AZwV_QhmibL0dUAXLsxhUO5inqdEXXTvbJ-_96RoQaEHVZjV79Y0et9q-_yyNck
Message-ID: <CANn89iJ7O5+xjoHHy1RZzLMfTBke7nmh+YhHCJsdpyx=-ewbOw@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 11/15] tcp: accecn: fallback outgoing half
 link to non-AccECN
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-251944-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: C78AE5966B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 3:32=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
> is in AccECN mode and in SYN-RCVD state, and if it receives a value of
> zero on a pure ACK with SYN=3D0 and no SACK blocks, for the rest of the
> connection the Server MUST NOT set ECT on outgoing packets and MUST
> NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
> MUST NOT disable AccECN feedback.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

