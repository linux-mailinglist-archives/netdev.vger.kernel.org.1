Return-Path: <netdev+bounces-293886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONHfIOPQHWqjewkAu9opvQ
	(envelope-from <netdev+bounces-293886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:35:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DC56240E6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 20:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10F56301E55D
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E053ED3A4;
	Mon,  1 Jun 2026 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9/oZ8oB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195953EDE48
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338895; cv=pass; b=kYeYuuD63VwuCV1PcQgUAxwG+WImOO8uGMPOV2gnYqdDMHjhW8ZMMNwAMJMSwzrsu//LkcWaePgrCd7e0WO1NTftxULhdHQgHGNhKbMzFwXyQbwPWBWo4CQWDK1A31RGt4engbETW+pAFMk/0/3/gg5cKIDt7XJP7QGiTVyUSSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338895; c=relaxed/simple;
	bh=Y7rbauSvwHuIXCDkVEi2kpfzA62UFWFPrOulviX5FSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OslGcg9+lYpOCh7odjCkceS/6fSHqLXkzNAWeq4lK1Kk6Pg/D8QCrbEFBMxUprhnaqRoZNdZL/rWFB57Pm6q3tYZ5og8Pjht47RI4kezXo00BqXMZIEAjvaEnVf/2qlRBKyf//WV0z3UEtZ0K3MV/mlbX76j366CUQes6IorYX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9/oZ8oB; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-137e75bcb5eso1603032c88.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 11:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780338893; cv=none;
        d=google.com; s=arc-20240605;
        b=LXJN+kPATSktcn/dqAAiGSWEMhwe6TKdsp6dVN8Q5oY9t+QjdaE3FosacT3Hh5FPje
         7XbkUAkL6DwiHP2Pozb1SB+X0jcK0uNCkZeQe0/9DJqKbeylkWrCjaAlV9/OU7ueCKHj
         lHAb7Af1J0ayM7dHv+xSFVPRt4KHqw1zor1fwyPleOkFSqjQe3QiIfcGql44PMYmIwAV
         urNQrFOt5apBvHJ70fVbWajloADLBky4nqQa9zJWBs+H7UXbqfzHDH4syc+IpbTXMJ4i
         KjqVSAqjphpSd5g3NniPvqf0hQhaFCTCIA++w8WgBRwxDvtJuZdctkX7ymeWp/s9NQQt
         Ddww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y7rbauSvwHuIXCDkVEi2kpfzA62UFWFPrOulviX5FSg=;
        fh=pUq4NWLVWAWNQhbDUyI31ecazrAG193ZhTnqy+5tuZM=;
        b=NjGs3ZvPnlcbguYCCV7s8CyvSVS+v74h6War86qwIRJA8Pw1LOVCQntjhbYEVmvKT/
         satFJddO/LjOcSHBuk1QkY+Dgvvu6+4U/f6ADz8rlnVYarrMdIixUievXaF+KhpGqlyM
         nY/YesPwdYj+RPwoNrTXEVIc/eUdexoI4KpnTzEMd/i0YJnDFVytR5BOUlzwB7nd51vR
         iGsfOtp/sL4Xmx59Q4Fws1MIsTlu9/Yk4VopjX4GHLpeRNp8t+L4pl0doiyIW6TOlbvZ
         zMIP0N3ZJfr5/+4wyEVZIlAPZsaSCuxJyu98FnDsXTIl+wahQIAr039gkzbUHaE5Hx5V
         6OWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780338893; x=1780943693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7rbauSvwHuIXCDkVEi2kpfzA62UFWFPrOulviX5FSg=;
        b=P9/oZ8oBIPJq91h5LCf8MC/g6hpDcSTs1Z1MfAoDVOQWjw9buWlRIwTVyCl5p2rJiY
         qEhslsh9Zp2BZyLx47H0cs02+wmaYPJZisnBkcWrfw/4TiSXCqpdBpH2NegUjgGjucp6
         FOV1EaPda+YTlY837M9Y09cqFhh8aFgqAVXMJl62zeuODJVqpaLwqWEUX+ZzZq1Ie81O
         oBoLz0Aj8XcQDKdu4G/ejMemGA5JpUU72zr7tK4GrVomXIP8YO9SWm+LW9h808Jvm6K1
         88PreAGCGtaJgBTeaWTDtE0D6X9Zpj3VqSceLT0cQ2AceeZN5pACAb1TsQsgkn0zwp33
         nIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780338893; x=1780943693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7rbauSvwHuIXCDkVEi2kpfzA62UFWFPrOulviX5FSg=;
        b=mluyNtC5l/tKKFORLL4s19mjYBrc8IK73a/C1z9VdRQvF8QI9nvQiu1LRng7dnq5aa
         dRdSbIuzRYuatPnK9A7QOAsSvrTybiGN18+gxYxxeQhwEbNPq2bV5qFjOYjY75fFyx9o
         PADjvRrexoTnipyZltd8ukXVBlkQ9jyTDJ44dovKFix1wfXAuzJR10kht2IVaDJ/e4/O
         Sb8XDVmaqwj+fAChukBEaI1ktJLGMVmtnzI1j32R4oxMf/DsDWWEsKRkVEOvJvrm1qd5
         sshhyW41ycAYyEBLfzVVJl3L29W7ibQKUGyo13Dj0ZwHKo7Ba5rp92Zie5N0R+Kx85l/
         Q7XQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7Xz4xL4SpMGhOwraGjk1dDMXaLIhelAIcOueIV6Fw6j5i7DpzHzrcXNQJPQHkr9TKcmmJl3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhF5XMyv2u4Dz1THrv1clMbZ7yEDuI+a8ctcq1+P6FcifRI2pq
	kweyjjenyK/V1S6g83oY4z6nkpfx18x/+7sZRm+wa4DpuM6Qi2O+uvM5X7FS1kjYFqAK+Ln+8qU
	z/w4a+PpKBYLLwkLUw9wla/dWGReaGiH7QZWt24Gj
X-Gm-Gg: Acq92OGXCgTD7MOIap/C7Hjvz2Ud3d3ZV4j6OkyTBL00MDkj8EcuyTcOcFWZmGL8Rks
	7QCK3iNtJctjSE/OYJ3nBiBPdImpaJMSHHOe07q01qoCI+yHzdXKcsEjPLGHUBD9lRw21b5BSNw
	OUSom9akXRvrQ1R6cO/EZFoMtyd+DKD8MAxwukmD2FgWEyfXL5OJQePLLSFaQ3Ke290aqX/rTq9
	cszFMWWnRPIFfVwe9XH+U2HOxiIUHt2zQzDTQu3+YeMJSYquzGmaEC0c0GyN4p6mUOhqV6tEElK
	7W/07u013BKXPipUmlJaupiYqpm9f2keK4L0v38RAreJdFREqZpT7K/dXzlHZBhErCGGReQfkL8
	/zHrbbQkk64aJvzOcVdq0Jf3j8L+Pkp4L52Q04ROXxa7uQCc9DV4si6D1p+4U
X-Received: by 2002:a05:7022:f8f:b0:136:777a:1dfa with SMTP id
 a92af1059eb24-137d413308dmr5412050c88.10.1780338892494; Mon, 01 Jun 2026
 11:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601113640.231897-1-jianyu.li@mediatek.com> <20260601113640.231897-2-jianyu.li@mediatek.com>
In-Reply-To: <20260601113640.231897-2-jianyu.li@mediatek.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 1 Jun 2026 11:34:41 -0700
X-Gm-Features: AVHnY4KRn1ya_dpCxrGptmMZXiQNsfE9yQOH9C6V_CTgbsPugUKkRnBB6wNVBvk
Message-ID: <CAAVpQUCbKQFvz6wj_REoRvWx89r4x7=9YE1nim0XuVxMzWpOKg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] af_unix: Fix inq_len update problem in partial read
To: jianyu.li@mediatek.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, black-ch.chen@mediatek.com, 
	ivan.tseng@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-293886-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 42DC56240E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 4:37=E2=80=AFAM <jianyu.li@mediatek.com> wrote:
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
> ---
> v2: Improve lock usage in unix_stream_read_generic()

For future submissions, since this patch has no change
since v2, you could carry my tag from v2.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !

