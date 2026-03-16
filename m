Return-Path: <netdev+bounces-268032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AtsKv2rt2nkUAEAu9opvQ
	(envelope-from <netdev+bounces-268032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:06:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55754295635
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AECBA30065DD
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 07:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D6334D4D5;
	Mon, 16 Mar 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8Q/6rNa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891FC34B1A1
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644795; cv=pass; b=uP2Gz+W1cweWwZjOe5KjWdqZT/Tj2q/xoc5LL14DhjvWqCz2qUIYfd/JjvHQp9JpXXjj0apZ/0UNNHFR/4RZTeY5ef4IVdRgHimkqOSAFzCrWEZJ1q4zKvmdwzNiH3reUJQhvTUELQHasCSsZQn/CsJPso3kSPklN5xBxTYC63U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644795; c=relaxed/simple;
	bh=M45sBGuXx9ZIfy8zbdGgn0+qmokS165cbytWc3WNWWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuhBNDueJCZLWSWTmpwDurO3VtVfL37infzCLhGVYw+LwsZRDMfe4kSDI59N1QJ0DSf8YKaOT9bmIBCeVb/uoffAK1uFaD2lf6WUqSA6LTQ43q8zLI/M6nuzsEmhphYwkMscRyTcXmU/2rih/d8CjbVO/Y4kC871px8GPpDQLRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8Q/6rNa; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ca1ba0089so3983121d50.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 00:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773644793; cv=none;
        d=google.com; s=arc-20240605;
        b=RCnCFjetRq2zRPThMjz88AfW60t/fJ1mxw8hqpcN1mBd2/O/957/+onLu8HTexR1pK
         GQBaHNYxsj7zcnPTg+YNph1FcYlV1QEJVL6OuspFMHFrkupaUHSygaMLEFcWGKjEYB4E
         LaQ6bYf8dadLuF8UvpS9YqDRgJ0ITGtpo6Qa1lX6/4nlsHm24VFt/4K5GcWIKEqufJt6
         RLDpS/SxoW5Hh5BRW9hb8JULoNQwkfVZWuFSl/VlvgbNOw5n3q9/eWUV2ryTP9fd0Gow
         EX18ZhWJmH0DEPqERAvF3Gv+JKGTM0kdeqODrY26K/CBbyxiwxWe5sFMmHV9D1xVO2MO
         8BZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M45sBGuXx9ZIfy8zbdGgn0+qmokS165cbytWc3WNWWA=;
        fh=RxDy16+9ozVlQ5AyFeUTJqjjjm2IJ+GuFn2znuN1Q2I=;
        b=j5nCQQ206c5R4VBe/AeCGf7v7K+6B8hH+DnzUG/dD3Qdi9JKiOdmPIGGc9Lzy6TrkQ
         aVqYuiOspYc1q0ZFJg+6nkdPt29PX77HIcS8bRuD1wsWP9hItbR1CRE+ZEpwgS4EZ+2c
         8HuADJ+vZHmtDQGzdSqKhfHjcdtA6hXXscc9saCl1bWRYI/juPPwAG3ooqwMcVbwBF2y
         DqO/HCigsmhwD0kr5PuwgLvgLvXw/csF6uy0/pCGMjKfPOP5DkZW+2pk9AN/YDXNAHMs
         a+oGuYAb67IcHQbO90si4K7mf0pKiocZzUUY8XcAhoIxDZg4+aI15lCRhrFD1npDASTY
         c9/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773644793; x=1774249593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M45sBGuXx9ZIfy8zbdGgn0+qmokS165cbytWc3WNWWA=;
        b=A8Q/6rNak0ZtW0jF9+Gru3NmQe3KYxhA6qQeHFMBq3ERKGcRLWZphuTwUtzJK/rl85
         uWtxwYAlo8LUSxbvcEbUNAz0YO3ND91eo3wHm3jgeKRVMNkU1NMXvr0QC53SFAHaALPa
         CgsOwu4gYlLLvzvlmxRCIEIF1jD9HDhKhOrVHsiv2UoaRZS4VetHGKdz7zTGaqHDmIbt
         9I6wEAZDqBPl3ypmcUZywKgeonc1pgWl7Z8BQfyh6Ymy0Hyw76TKozzZuw8jkNsiYRBn
         BCWqCC/tGZx6GupIz9M1o2Iz3X4TsUGyZ3MDgUm+DP0YIJ3mmLtJ1ITObdSYwOf/cIW2
         9lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773644793; x=1774249593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M45sBGuXx9ZIfy8zbdGgn0+qmokS165cbytWc3WNWWA=;
        b=Q4V3tHnwrj/UV5YKXBqtcWcOgkEYcCrpgVQ//4hWPv1F5SyW8MrtXHPpQKse8W+sZh
         wg0rAYmM3z/9BDpDBeUy8mnYavGU47LsAAWvoPb7nqQmSYEfG0ibez1CBSPsyxqHRgwK
         0i+1Qm0AMw05RLkUecIRq2204ZOwhCRg39NMOx21+cJL9Pxo7dog7eMyPbf5gU9osFdG
         G2hHiolnn0kGw0BOPRe85dVhI9wF9qh53JfRnnc6hnHKe+QMq61gYnTpq0C/82bbTFu1
         MHeIiCxmUyi4j5m0IekDFZFL/sgsz0+wZSbF7FqYg2JbLJOV413DT8e/flgEinhLRc5h
         MLGg==
X-Forwarded-Encrypted: i=1; AJvYcCVcADxa99TAxO0cb7ZZpwpUDPSuMG+Guqq/QCd0pg4jTh+tNZ/7T0AOuFyCiKrZ0bCPLLZF6mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Udm2NmX7/lHwP4iX3P7ZZ66quknM10bnUOz0x6mVgjm6Fw4l
	8Z3bqvJr3OpCVWewjwjotoxJ/nUhA5XJjbcms11CZdqIfzSrIuMTwnNb1c7YTgF7kN2pxRyQgyT
	GNE+X8wIGo2DjDaYD8EveJRD8F0Hr0oc=
X-Gm-Gg: ATEYQzy7sclEelMb0nmLEcDh1NuFTpB98zFE01Rly2+0i5pj1h1oHB5FjcETIlwA1pF
	7zmw6alZAQvqePeoR7mLMqnzg6JHUu23SpiHV6TxLRLShe8Per5Li3Y80bOmJIkAFctKyVoYo+8
	A4CQUcdC/1Z36i6URAq7UCKULAZ5X0JOtro1Z4OTbDMaKvZj7tFGoCYv55e2imZ0Lgop2TUB00T
	fwSFwwJWMHnUi1DwkdqxcBePEa1sCYbiYxuEIvY7dCIbBqOm4oja+w04ElhrspJ82h5c1X0RJZe
	LHorqA==
X-Received: by 2002:a05:690e:2485:b0:64d:d0b5:3f35 with SMTP id
 956f58d0204a3-64e63094ccemr8396230d50.67.1773644793583; Mon, 16 Mar 2026
 00:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314081112.177669-1-mohd.abd.6602@gmail.com>
In-Reply-To: <20260314081112.177669-1-mohd.abd.6602@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 16 Mar 2026 08:06:22 +0100
X-Gm-Features: AaiRm52iXiCgWq6FS5szdS2zq1jjm5Y_4FpTJlvryv2OmcZBSvJBYzk6d0b5y9g
Message-ID: <CAOiHx==pVOOtvOb3eooRGt8EcwjTtkY-33Nn+Cu_m3pu2gVtpg@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in
 error paths
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268032-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55754295635
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 9:11=E2=80=AFAM Anas Iqbal <mohd.abd.6602@gmail.com=
> wrote:
>
> Smatch reports:
> drivers/net/dsa/bcm_sf2.c:997 bcm_sf2_sw_resume() warn:
> 'priv->clk' from clk_prepare_enable() not released on lines: 983,990.
>
> The clock enabled by clk_prepare_enable() in bcm_sf2_sw_resume()
> is not released if bcm_sf2_sw_rst() or bcm_sf2_cfp_resume() fails.
>
> Add the missing clk_disable_unprepare() calls in the error paths
> to properly release the clock resource.
>
> Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>

It's a fix, so it should have Fixes tag, e.g.

Fixes: e9ec5c3bd238 ("net: dsa: bcm_sf2: request and handle clocks")

apart from that

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>

