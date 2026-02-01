Return-Path: <netdev+bounces-255594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PvCOlcqf2l+lAIAu9opvQ
	(envelope-from <netdev+bounces-255594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 11:26:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A21C5709
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E282F3013860
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7381C2EF64D;
	Sun,  1 Feb 2026 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjWXVEIk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDABC2EBDD9
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769941588; cv=pass; b=joSK7+2oK7O0DDJblFywop/KU+nZNgP2U2hdmoXTYjXKvY3hH9JshbDFtYBzWWRPzMEm6cwrbeiKpMfSEuf3Yf3S7s/n0CLkT5u0h4E/6VIjPDpjA3CQGRVDNAZuiXuWK5spCU4RWOL59S3vZeKJs9nEJxbCTGZGSkoz/ky2BUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769941588; c=relaxed/simple;
	bh=amYpk8y7uZ17bXL/jYzc2DIrfTgbEjzT20gzakvuc2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPxjWMpZJB4LsTeJ9eJh6evd4vWRflhcMIzqe8xRlHxOAatTfnZktC1haXFAXFOGb4/INsJdlsI/wMnGSserNEkJAy6+ylZC0AywlVAUILzj+N0IDVlYrreInmO7AsSCLu76Qa7hg0hFRB79kktnEGbLZ+BpEIHuf5/w4GIR2P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjWXVEIk; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50334dd44d2so41404421cf.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 02:26:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769941586; cv=none;
        d=google.com; s=arc-20240605;
        b=h4aoXBklEw/EjJM6FEuYbLWSByddBWk/SHfsuHIYbW1RS3eJKPYc7G8EbvhBPaCSju
         uymw9W83/VYFlecMm/gas7DOKShLrkO0w17z0GH3KL4yuhVl6q9uwoMTDz26dT5ts6M1
         ay6Et3txtQLh5KJkzz8u2fuER1HWhKNoq1+uZFfVZDiQjWN8CsRjJaFbQuBBc4hREIs9
         IcBb9u70hFRWTDqAaiqobpeLT8+WzsfCeKERA4TOQt9M7zCHBTfC9RciMwd10E7xOjZA
         CBAFMaD8SS8zh9EhYnI6h0orziHMkFi2D5wfg6MnRniHVIZQCl+heK8tFBUKO/19P/aQ
         hhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=amYpk8y7uZ17bXL/jYzc2DIrfTgbEjzT20gzakvuc2s=;
        fh=CbvlHVePcdWzvJoFwQSr1jpGbYLftJl/nejdQyWYSko=;
        b=Vyo+xmMaJqRE+AJD4K7ckC+c3NFREEO4h/HYkcesekQeiJnm/CXMvCXVRDfofhD3OV
         Dvob+l2mcr79+pmxNwwjnbhtW23uSc9jy6+p1CvqC23rjUur80uCEDZqGW08WvsoFCyj
         aRySAvw1KbhuzPTvNNQ/Y1eQ6PpRFyfs3hPn/dqTRUCMOSiUW9i9O6RUTUjyBP1Cegep
         53I5Kl7ftVw0PBdpfIdN6pfDRXNuRuDM/BVmrFTCKtRBunmY9gmWK340xDpC+EnbNcQJ
         lL3zK51nDruhcuD2fO3D+g7QIihjoALf0ELhswFFZLFm+LCkKGci+gP9yJnhBN3pI/0d
         a/2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769941586; x=1770546386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amYpk8y7uZ17bXL/jYzc2DIrfTgbEjzT20gzakvuc2s=;
        b=tjWXVEIkwuWlA/YmIFxQycJ590x8iPoVszHh0oOmLhIj3YUMioygV1KM3fv92WjZ0F
         SHY5wx3LeG4cozL2PK8A3mbNvXvCenltELpXLUGtNCU+BuBeWX16hGri2tPTrLZ8KhA7
         NY+/rato5A/jMf5EUPWojk+ie8GJKNXyqrNyarsXyGaq2NqyMZOqHH04v9EnZ0d5O50B
         aBN+h5xgvWuY8k0S6atOqamEFKP/lARddKxU0NexaiEf8rzDo8icLpaWWeJvkRgM1ya1
         oitFZWauwURHO+nFbvtOrYPd6O6Bm2LyGhcwmgYMKRtTMt0fjP24A+hYD8DxfWyiDfSn
         bv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769941586; x=1770546386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amYpk8y7uZ17bXL/jYzc2DIrfTgbEjzT20gzakvuc2s=;
        b=s4XFgmm9TuqeA4SX4ATwd/i6h70cp4TImKlPES3D7ZTj8aMU+AzUbD+G1BLusj32vI
         ArFIqMLCk124fYlnnF+P5qTHtA/ybSNI5cYsfL1fDFXQ6DfJrQIoUe5Ccnp+/zCzLKol
         5YwoYI2cz3BowVAwfZSrZj1qcOqdXzowWUfSgOlK5LfTCfNxvUobsrzc0VWGPOwvtluU
         GISP5EmhSeaLApQKPKIsP73eVNpxgxGehI8YaAWqudg/Paio+HXkH74JAkp2BqT4/Msk
         FwPgDV/HR/FPV480qbZD7pp79vIdXqRZmYqYim1OII/ws/X34UMx61WcP11d6uae/cnu
         2i8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1xTkjK5DhGEY+I/QRrlR22YuWUHTzuy4KFuIa1ueOCc3ufpE0F24axYWjwWCGcX9Z71o+pRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNw0IRxHObP+BSMaHWw39u19M2jqVO1uTEVZQNal30LZy1Amyt
	9VR8kohIs6dGKAs6tDbh+OLEBjBdezlNyhsJ+e2JC5OlDv03BsxDlJeqO+JI4PTLcCxuvlDm7Fy
	m6EGZGkQLqDam2x6SXwzTxIW7NBugc34dSOF67FJHsRfpElgsQ5ZiapyD
X-Gm-Gg: AZuq6aL22bj25sEbWE0dSYOypvrBpUpmrf44STwkRetFsYcqIbXnj0F4dqVo55vf9ju
	Wsl2hQCmR9gFnikmeTttUvhUkQflS5vzVDEMVjti5udRZrTvDZM1l3YZDl3Uwmmsg9y288/OjoL
	tjgrUKqh3aCaOcr204kZXyLV9eaRlmEzRH1T8Z/PD8HdFIYyJLfTjGU90IKDQV06rHD6Dd7fzgR
	Ga9Z+U7j/nxJEGGY/zI/930felBLYUyYA3DUKit1DedI6u/WIksUlyjaq4RySzcd1H+urg=
X-Received: by 2002:a05:622a:1aa9:b0:501:3c88:131 with SMTP id
 d75a77b69052e-505d219e7aemr108573901cf.22.1769941585616; Sun, 01 Feb 2026
 02:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com> <20260131222515.8485-16-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260131222515.8485-16-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 1 Feb 2026 11:26:14 +0100
X-Gm-Features: AZwV_Qi7N4AZtgtvbxnXQyIYVraEeuRtL1qe-JczyTuupqULFqmqcdCuYubvvbo
Message-ID: <CANn89i+F8Hmx3-DoOBcW_tJnsyqeeKHZm+_jC1nk5hrnBWN2Jg@mail.gmail.com>
Subject: Re: [PATCH v13 net-next 15/15] selftests/net: packetdrill: add TCP
 Accurate ECN cases
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255594-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[33];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 66A21C5709
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:26=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Linux Accurate ECN test sets using ACE counters and AccECN options to
> cover several scenarios: Connection teardown, different ACK conditions,
> counter wrapping, SACK space grabbing, fallback schemes, negotiation
> retransmission/reorder/loss, AccECN option drop/loss, different
> handshake reflectors, data with marking, and different sysctl values.
>
> The packetdrill used is commit cbe405666c9c8698ac1e72f5e8ffc551216dfa56
> of repo: https://github.com/minuscat/packetdrill/tree/upstream_accecn.
> And corresponding patches are sent to google/packetdrill email list.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Co-developed-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

