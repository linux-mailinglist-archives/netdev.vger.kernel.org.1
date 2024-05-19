Return-Path: <netdev+bounces-97147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9548C9754
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 00:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D71F210B3
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 22:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72144AEC6;
	Sun, 19 May 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Qe1OnrGN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E961101DB
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716159527; cv=none; b=gYv+hl6lmNu5vnRk4uhIzKLKlxQcCJ2HqjXBcFKWhODsDDPhZSiioLcYqj/Vcp30NuATctghVrHW5WbaOV81pfMg6TTFnX3K/rWFX+HLKcVOYLBxkVE4P6SAkegumCj/9OzWR8F5oiw3nbJB/QPyHicEVVBir69FxaNgB1k5cD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716159527; c=relaxed/simple;
	bh=CkpDPMC2Fa+wBeGzSyP/1UANCGURuqQIDYFnhQpiNOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAcLjSHDlwnCv4nsJj1kpSMzYGnAvfqEM5JNGquFgNpGAUAUL1XWNyuUZCk6J98Ktigb3PapiOQ/hJr+CVYehP9BxLyWC1o8AzcSiWGtMR45qSuQjNwbsy0enxgeR1LAwqb8iQsl8apSEwewgssHFaNNm6Wb1qsGixpIGahR7XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Qe1OnrGN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ee5235f5c9so55678725ad.2
        for <netdev@vger.kernel.org>; Sun, 19 May 2024 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1716159525; x=1716764325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPuJpbnWMMW6QgzcmtexpV3ldHkM5KgTcxg7ObCIUKk=;
        b=Qe1OnrGNO0oL7LM7CT7dYYGjjo27hNAFCNsEJ9IXDgqkYY9UmjXErKPipwIoy7CEyo
         ConNiVzzXgrCGgmZj39qED8mFVgQQ+ysW9ac8P8x+CZhU8ZIxY5CQYRiZRsrA38/ctSj
         tp3D2Ps+EVJ6z6nfa+jCE7gYo81QaTvrS7OGsz2dQdjGUD5zmldGmHYpJV1uLKRz8vGC
         0USCq/hKKcwWMzd9YssV4HvKp1EEOCW9o4p1RLmn++ZssJfifm3xW/hjHMf+tIacCWJ1
         Lqe5dP/LfQUlY3qq3WayeuOtMJSHE6mEv4H03MqKDEgkcC4AHtGfHkgbxgsTfXgako2c
         h+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716159525; x=1716764325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPuJpbnWMMW6QgzcmtexpV3ldHkM5KgTcxg7ObCIUKk=;
        b=H9FHQ4vBYTlY+4uAu+5BuQpbmpozfBLWjMUJavqb9gsc/EE3Tes86T0itiZ2G62xNk
         Ttn9MqCMm2aCe6/p2Buk1aNTysR/vjUzSQRmDXHUipn/uG+KHddy93rlYdrcHh4Z6WEA
         XfZoF2FQXTdrg+XFe5ZwFDL/RaWBvEM6ckDVK/ek3tjTSQSp8jgwOgBcJRC5lUioyGT5
         TBmUY82pp4U6kfbaUbJmFQ/ak040FUeoyGYtowzQwgdCKIK+Q6oa+s9Ek3FR0HqcSeqJ
         8BKecIxICW1TNZiSg1sSKA+jkGI8mPPfBMLapw+uoOPEmH72GIkRAy2/sI3OH3BZc9Jz
         xcpA==
X-Forwarded-Encrypted: i=1; AJvYcCU+j6FnWNDlg7KHl63ugDKCHIOfR+kPbQWIWE9toBlI3Uy+ZvyXujYq67xeReyI/57wMGNhJeaXYGasv6y2SEHEB9/GciNu
X-Gm-Message-State: AOJu0Yxo+lXxIxzjevpTtIBYw8U3//gQOibDqr9++r2LXYja3f5BU9zx
	dmEkChXC1mPBVuVBhXnrDCMk0838uwQNjluftALZhke8mhlTeBdPZ+A/qIrjntY=
X-Google-Smtp-Source: AGHT+IGs/eybZsnCmFIPd/d4mteguD5EGy1FrUY55ZxGR/TsQfqqJggA+YuRpqzGuhqGxjOXuIWEcA==
X-Received: by 2002:a17:902:ec8c:b0:1e1:214:1b7d with SMTP id d9443c01a7336-1ef44059ae4mr315434025ad.61.1716159525191;
        Sun, 19 May 2024 15:58:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad61c7sm191178375ad.68.2024.05.19.15.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:58:45 -0700 (PDT)
Date: Sun, 19 May 2024 15:58:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>,
 <devel@linux-ipsec.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
 <nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>,
 "Christian Hopps" <chopps@chopps.org>
Subject: Re: [PATCH RFC iproute2-next 2/3] xfrm: support xfrm SA direction
 attribute
Message-ID: <20240519155843.2fc8e95a@hermes.local>
In-Reply-To: <3c5f04d21ebf5e6c0f6344aef9646a37926a7032.1716143499.git.antony.antony@secunet.com>
References: <cover.1716143499.git.antony.antony@secunet.com>
	<3c5f04d21ebf5e6c0f6344aef9646a37926a7032.1716143499.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 May 2024 20:37:23 +0200
Antony Antony <antony.antony@secunet.com> wrote:

> +	if (tb[XFRMA_SA_DIR]) {
> +		__u8 dir = rta_getattr_u8(tb[XFRMA_SA_DIR]);
> +
> +		fprintf(fp, "\tdir ");
> +		if (dir == XFRM_SA_DIR_IN)
> +			fprintf(fp, "in");
> +		else if (dir == XFRM_SA_DIR_OUT)
> +			fprintf(fp, "out");
> +		else
> +			fprintf(fp, " %d", dir);
> +		fprintf(fp, "%s", _SL_);
> +	}

JSON output support please

