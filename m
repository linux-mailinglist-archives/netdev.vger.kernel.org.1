Return-Path: <netdev+bounces-256422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEyEKJU/gmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:33:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D435DDA6A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30C3432082EF
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394353D3008;
	Tue,  3 Feb 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElwPQe6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3BF318ED4
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142964; cv=pass; b=Bqz40Iv2+ej8RL92ukQc82zSIUx2CPIU+z00FMrsd6RKKprGF5ueHCsZGVEo1tFkiewreSVFiaeWTYYgesEF2dQ4RpLEunpsawcG09Cp6edYPT8+w+rAxW6TqhU2Bssq7PIhFp10IT/6VPjBtXjfKtEpYxAIZdbrpE+uuRVC5TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142964; c=relaxed/simple;
	bh=72IAYlfThYiEG2aFjGCNshtysLaZbuOWDG3tEGy1mzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndqm+w4FVwjTkzL7bZyv+P5xYQnEBscq3PuxWlgHfsApCDRZvMaxN0iVhbwrWrs1kDDSj68ILVMMS1UwKoAZBXbpTUAHr9a6niDoGZafOirfnaoOQW7mLTqzJL49YP3k6uxdp58luqkMfqVKg7cX5u0UuCCD7YSkkfBqiXohGgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElwPQe6s; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79274e0e56bso58509477b3.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 10:22:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770142962; cv=none;
        d=google.com; s=arc-20240605;
        b=gt6FRHEm5aGGifclZW9YYOPB6WlR6iAxQgdYqV2ZRsjgC1eL2qbnAuf5r/hp0OH4vn
         olNy/3CtJolvHf841oyBxenanwJ4DHAu3U70hqRrFM+mHmmh3s21JJ+iunu5V1Wb2eXL
         fXuEGpYFDtIWd3jn8RmJX4zRTVhlLgIj49SUy+3OV3HlM18cKVGBm4nmE2Sg3oZUlHHw
         8eIjMtPNfglVX2OdQRBA+RcUo84UHhzC6BmWQfuSIiLT4ymedb8uynApHnFUvx6p/GJv
         O3JDlAV2VBDhWMdKiUeSYARLWRjXfyqlX+mWPA1Xk/y1Fmuh/+YTjHK9hD2lyRmggpA9
         gSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=72IAYlfThYiEG2aFjGCNshtysLaZbuOWDG3tEGy1mzE=;
        fh=HYpyPRDHqJ/vu1lFECrTD0cYKgvNQmRM2+F3kpxF9us=;
        b=MJI2OcOlcJ+N3JyKYxQSiFrQxBdBfts9DohV4eWzJT0OLHKoxWkRNDmzqTrxxOO/N5
         2v20cmneKlm5UMDMDBCSB9u2ceJpIFADDg8q/ztK5E1EcEx0jeCLnFOKOyeBlgCiYsDV
         iD78bN3sF0gbw7vL4FMW4qp7eXzqhiYHEbTbviOAEjFXgsgcn1CaUhpFBBOCyvO0VeyA
         kSwF0bemK/KULlQxAAWechq4kfgMAwMjV5AK8+qc8P8+RavWLdAH8P0sJTi6VAe2WAJh
         YIGPdl9wwGNX0EkpoPdrWYcsrQY4cn+Qras9p/drCOwUfzoIGWddBKPdiI0LKv1d4n/H
         vrPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770142962; x=1770747762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72IAYlfThYiEG2aFjGCNshtysLaZbuOWDG3tEGy1mzE=;
        b=ElwPQe6sXKaLSZVgNv6Z7x8iDII43pslvRtD/wbmBNe62FcJiwjRNhYdalw3KgD+tK
         yurdy8B4U0Loe98zqoEKn0flJ+q+m6gyMja/i4gjfIDHR7/kwKIjk9AADSYAMqB38VKi
         ssrd6KtKpacT9wQbXjeFNJHRRknKIVVP6FIGe3aPDTX1LYDkH7Tu+ulrS9AN0Garmm7F
         S+JuxHjwE+0xdNjuoyuCrCKf8Sj+aPGXfNYhMuFsYvr6jyW0K5oUoJiBX6V/ROsf2XM5
         qJjypJo5dPsw60p1WVq+kaNcY3KZ8fTSV2ABapwsasUY6yYNX73WT1uRlx7dwfV30Lkw
         94/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142962; x=1770747762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=72IAYlfThYiEG2aFjGCNshtysLaZbuOWDG3tEGy1mzE=;
        b=KrFqIZAgU1iP51/Slb6PIy0oAc471jlx2sEHFCUZSFNAIeJT2A1N4fobGYibkJA74v
         uWOfqB6KEGdIsdoTlqGlRBAAJOSt1R1pwT2SCfHsLtgloMgzXIy00wL3IVPFgVZ4qFmQ
         8jQXO852lePoBrjHOm1vtwFjljXd//mqgm59Eg4xNC54mO1hWkOkZAMFPCt4ZZfOG2GA
         HPqrY0Yn14wXtYJB5JZbzCBswwqpC6pIfkHVnm7fD2E+aTPqBfjNA9E1NToGu658sbNK
         ltM/l/qQodNBOeKMym8To+6yulzcxYEej9DgNwWmcGCmRbM5AdUaSi7A1vvuunmmdMOB
         WNqQ==
X-Gm-Message-State: AOJu0YyBoSHxONHdwwRD/DPPQoGDKB5jQl95/Pp+sZNyUowanD132eqa
	mSjrxFqVfpzJkt8g09z56sJtSALfVLcGvWcRVCOBH8Auwd4YRphlI1ElpXKsB88G6aJk8ElHSl0
	PHxvjaWXT4By8N3rhAaeVpKxf31TNKQ==
X-Gm-Gg: AZuq6aIVs3ZU+VeusGGazi4nt+zYAU3l6RAuR0l/HzA6PR9gNzwPWT8Xz67XBiMHkVN
	g0Twj+EjoIEkmNCWDG5Z8qFkW0h4RM3EBQmO3xhnVQLCYFncwzCc0nz6R/QQriKW4sQBjn1SZJ0
	MawANAuk6RilTAEjQ92nq9nknojyWdeymyRp3CTCGQ+AN9oI8Iu4V5nldUCY3+hAaaVnb+djUnX
	I4s4walLFtPJspVqkuULVpdMCFC1Fi2KSzsjzptkzEgB1XqyRkBYa/mFZBUgnn4QWQfUpcFnLHG
	EUI82YhAez2w3bEQRszjXg==
X-Received: by 2002:a05:690c:39b:b0:794:fe8f:ad8b with SMTP id
 00721157ae682-794fe8fae16mr4373667b3.29.1770142961756; Tue, 03 Feb 2026
 10:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130102301.477514-1-tmshlvck@gmail.com> <4819ec3b-23b4-447b-b10b-0bd93a40dc5a@kernel.org>
In-Reply-To: <4819ec3b-23b4-447b-b10b-0bd93a40dc5a@kernel.org>
From: Tomas Hlavacek <tmshlvck@gmail.com>
Date: Tue, 3 Feb 2026 19:22:30 +0100
X-Gm-Features: AZwV_QheORJ8ICtVU_dJsf5jOCxuVCH5tMEhwxpjksgwa5Kxeq4aCWYRoHfnm_I
Message-ID: <CAEB7QLBE8OQtvasbDvaeCownALqMcavA2TWOQJG0Sx3Q_-KShw@mail.gmail.com>
Subject: Re: [PATCH net v3] net: spacemit: k1-emac: fix jumbo frame support:
 manual merge
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dlan@kernel.org, wangruikang@iscas.ac.cn, 
	stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256422-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tmshlvck@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D435DDA6A
X-Rspamd-Action: no action

Dear Matthieu,

On Tue, Feb 3, 2026 at 10:39=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
[...]
> The conflict has been resolved on our side [1] and the resolution we
> suggest is attached to this email. Please report any issues linked to
> this conflict resolution as it might be used by others. If you worked on
> the mentioned patches, don't hesitate to ACK this conflict resolution.

It looks good to me. Thank you!

Tomas

