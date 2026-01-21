Return-Path: <netdev+bounces-251882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOzjLVfYcGkOaAAAu9opvQ
	(envelope-from <netdev+bounces-251882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:44:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CCB57BA4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16E0054B6F9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C657C481675;
	Wed, 21 Jan 2026 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xaESdTrH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC683ED108
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001934; cv=pass; b=XBvqhnfDZCnd/PVnngfLZY8xIPO9D9Q4cmYyGiNSKmaihnl+61e+8tkR1F/cs+aSUzsCYTe2pn5XbIjJz8/Y1O1rV1oHAcfCyLWu1YSnNKNKAp1mH2HkSJ0Fqfle3jvBtiDJ4N/dOg/qu2cs1a9iIaskqxQAxWa65HVy/gdAguU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001934; c=relaxed/simple;
	bh=f02HHK5xaFa+IVn4ZBSqEjh06+Q2Cs5toRGhg0b38zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nj40C+sKDCwkT7c3YcCMQZe3Sf09WW+DBEOBektNKrJB10r4cV6Av2/goI94i+UZBIcPCWkUNckmNUMWkRsYu1fp7ppGVUNYFJqKHNr/XDgnn+8fJB7Qxs9AKT6tiQuBM04lUB7l8X+zwtvoe+obZ3sdsJVR8HUe9xfPI1x4R7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xaESdTrH; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c5384ee23fso705028985a.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 05:25:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769001932; cv=none;
        d=google.com; s=arc-20240605;
        b=GunM+3GSBkUmsQoDMZ5O0ooO/+pJuIGFzO2TyEHT1cUQljQltyJSNckirBbAO9H2VJ
         RsMS69NXMWbOQpXTox8et+kLrp6KGu6M6d1Xq1uzpMYyt6kDdt3tir4Lf5uY8THh1jjW
         47T4HLd9zfmRyIDPQVUd8FCuM237vLb2p+R3uDy4M2LqbaECq9hHAW2Ske9BjqoJCSJv
         aNSc3IZTBKr4Nh+dWZ9SLnEn/j/fdL0+4Vnhya0Jg8vZqQMghRzxl/NfQw5V24CmwC1n
         Sg+ti6w5zL4FkpFAwt8VSJX/qHqO7gdwrEiP5mcpQEB5YZLPzFFmAwSc8jE4IGX4cKvr
         DPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f02HHK5xaFa+IVn4ZBSqEjh06+Q2Cs5toRGhg0b38zs=;
        fh=IpzcrSmtkeKabWHPYZDrW9m2DQN4Y9K54CPvV9TpZ90=;
        b=jK3YoE2wjUgZwuZwCDzRhtO0XACqdwkFK405fB5RyRlqeZdktQ5oV0Kbsp51vd71oP
         BcmphBrIjn11hiMXzPcFYmpC+Vi19OcuISjJnPMKT0BVgwHsFyVyMGRoviw4Me/3Xted
         dtXNuGmJhF2rUL6T1POaYcstLdIBg9ZqVpIX4RoHRONovvgaaiAOWtS03Nj3fcbiPEYW
         fxF7RjmzOQIn6oGuhYKQs4QzPKDVxkm2v/Oo8rdyXLjiS35Dm4vbBkHtFxW6aUZNDaRg
         em+YNiDT+0ED9EqkI3cVbv9YIXZNtF9CSB1heX8y9lfJSThlP7+NXq8GMz93Q9kk2sfd
         MGuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769001932; x=1769606732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f02HHK5xaFa+IVn4ZBSqEjh06+Q2Cs5toRGhg0b38zs=;
        b=xaESdTrHLodf7O5HIEv2td0RDPCAEHu3lRd0c1LZdvJ+3ncfcMYVq2J0HcdxyfedCA
         CxBXpfrtpqhX5dHMlT6wNnxfmBLYNftDIO9EtrwpLajVUD9REzWgmcxKEiMtvn8pwTe/
         v177C/krp4JLCzDJMpc8mJ7+orDvbWTJacsHmFdrzi+bCCdu6mTrmAzHFD2Rr6vQIcUE
         1SypTQWf3IqH7tB+SR1noz/QH4kW1XpT8634QUSNDhTj9pA2m2NuTZ+9UIc2scNKUSCq
         /gKkIObrK3HQROe/uFNxeBJgA2JoL/axvoX4tLBURDKqmm8ymdLQMB8ukDNNIFUdyGk0
         sbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769001932; x=1769606732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f02HHK5xaFa+IVn4ZBSqEjh06+Q2Cs5toRGhg0b38zs=;
        b=u1HEw7rVzH1TXexoLaQotsq9071pSuTxbcamyp+ekP+o+W1DacmtTaFqKncpQlOElf
         u55UVF4lIa4ds6J7cku32AuWxXNw8Gb68CHwiGhZbjSBE94S+rjiWIQtpzGThH8KuTqN
         EwI4kNJJAK9IOWx8vKvBHy7ytrCBX8zfoWqDzpWpVNG1yTL8BUuNu/LC5Odw2FlbJIaP
         RZlYLkmO6stgDVwBU58EIM6GkEzn48VYJA1+2rhWaRL2wSsnDbD98okcOmIZmowMT7eR
         xu2U2uV/YNYJ/XZudPmrcWAsltBn+bXknob18zfSj0MPdX67wEj/I48FBa8kj+eyhlh+
         qa0w==
X-Gm-Message-State: AOJu0YyQC5Hvxl6bdAuck7efk0MSExUpNQzdpMpW5FfYJ+z4kkemWJK5
	b/fIYUn5khSsZbZSN19oEmYHG9CT/r8Wu4SdYn+E95AYer8O0L5+8mRdtDAGKPjpsQqMr+LseVz
	fUP/MGtT7Q7jhZnpLtrhlU+89iBUfF8K0/37PAMhE
X-Gm-Gg: AZuq6aKXA5xGSxRnChfHvLgO81H0vfSa0HCvF2BVLg1+3az3UQ6yhRCX7Ao7h/6g+lw
	RTPY8t/xdr0r4hHByj1VjITtJcQop0dKopynGx+TZKo3IckcshOiUtHDKBxSpGhLUcWsYZm9RtL
	1CO6lURbIpz6Bd+wd3x//syByWpR34Iz06oOE5EGl8hTotTadFoBURn46CP13agysaKbazzI9kg
	DrXaKrPj3+cXqVyrdxxZx6SU13779nbA67wpKF4SYLTu0MZZad22PFqfx/ZoYk0bnGdd7c=
X-Received: by 2002:ac8:5a48:0:b0:501:4d61:f02b with SMTP id
 d75a77b69052e-502a1f33411mr211159971cf.59.1769001931639; Wed, 21 Jan 2026
 05:25:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-2-p@1g4.org>
In-Reply-To: <20260121131954.2710459-2-p@1g4.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 14:25:20 +0100
X-Gm-Features: AZwV_Qh5xzzuPHPucGa6c8FsRbqoTm1le321JrFwUbW4p5vrfGzEM-uvOYLyB8E
Message-ID: <CANn89i+8_ZDxVGwQmo_44iCRs5Wexwxy1Wfhw4WmYg3qA7_t1A@mail.gmail.com>
Subject: Re: [PATCH net v3 1/7] net/sched: act_gate: zero-initialize netlink
 dump struct
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
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
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251882-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 65CCB57BA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 2:20=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> Zero-initialize the dump struct before selective assignment to avoid
> leaking stack padding in netlink replies. This matches other actions
> (e.g. act_connmark) that zero-init their dump structs.
>
> Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---

I do not see a bug to fix, current code is fine.

act_connmark problem was that "struct tc_connmark" had a 16bit hole.

No such issue for struct tc_gate.

