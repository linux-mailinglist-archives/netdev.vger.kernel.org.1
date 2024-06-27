Return-Path: <netdev+bounces-107404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED36E91AD5F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 19:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912981F25E34
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C419119538B;
	Thu, 27 Jun 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="lBiKWsw8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B95918040
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507904; cv=none; b=ajZQGoXuIIv4HgHKkhmfJPU5RYvpLxko7MdHlsVwapyzZC6ncWMWoMe1ysnbEGoxaKm4iFx+MXzqW5BxP0z82zdwlI6x+U062abXtCEbSGQCRLrKvWtxnt4DG/Blc1vqwj6iLu24md59IYWZ2rZKclXBs2oBuKbhvvKmUq44hkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507904; c=relaxed/simple;
	bh=DCvOgqSuW+Dnx2cRvlSPJjeK9KOE2aSSCceZuPhfBvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZuaWbBJ5/Gu584w1z824t38WVKZQdi1fPfPhH2vIaI13ELOf1urfuiuiY6JoEAfHfT2lauZf3NQWc/eeMWr4I+8NkI/DMqCjjvMrTUtL7cusmN7zbJTmWkkvIpHf/IdhXknf30U5dVcY2R1Cs6fUzBnHnCPvPDIwSwFaJMdU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=lBiKWsw8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so5985287a12.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719507902; x=1720112702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc63SCmWH6J5kpT+q1ke980/PHqFL1T4oC5QzkCIAGg=;
        b=lBiKWsw8DYSNDjJ20MGRif17XvR/wAXddbSJ8cAJotfZqyrJQmo0UGXWWUz8CqVOx4
         c/JdXyueL0+Xx8cyYoWC7sZmexf/aYv+XC6bXqHcQw/FyqC7V2iKW0tFVN6h63X7rTlv
         n9te93fesugdjLvRNQ/5TcVTvrMVay+ohupomLRbiemoQUxLX9vVCz3K99WwRJhuS05B
         sNCF3/U8LEGgY+DPkmgBzpJJ5GxYfozk7CKNhGouCB44AVd4QzuJ/8EglPM1jK5WZobS
         OaCx5D/nfJnBRUQ1zJVrOCZSVaoXtwkglk2qmpGQ9Fm3c+UoXv1rjoX9I2UkIeTOMDVn
         n/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719507902; x=1720112702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc63SCmWH6J5kpT+q1ke980/PHqFL1T4oC5QzkCIAGg=;
        b=BaCIbmcdjvpz05NsJZGQdM72P90ZuDelpHD/EVgdKolZ9/c6RltAghsFmf8nyokEVV
         oe2OL526MqFn7vjuUuno0lIKL+VOT+dCu8M8NbMguYza4fC7p/XJn2edlahPaSPy0yjt
         VaA9P7503e2XBPQyDjdVSteQm09OZBViwBp/8Wa1zAHBeL+1wIO1HY9IEjZiOXzXGeaA
         lVsLfsparBFCqtJtOT8nWKt4gjTArVdLQxse0M3/+RBfY9wKB6CR0ulhm4133irlnLzd
         hD5WdMOayL8K/dquBa6B2QO4VJ3Qk1alv5hwwuMqMRfV2/ehoxetQ7tiE9Q6oPwTXdFj
         cfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+t2yH2MqzISpWqvp3LoGDOXyCL1CCwL4DxNNNm9nSow16WOmzUZueH44tzW8CINkFHsymEnYsCA4t8eFU/UGwiTejPDBV
X-Gm-Message-State: AOJu0YxYyr4Ei4x1WB6hV0+KSN5l3fF03Wl+/fXYNNHUpNlXlLAaCXTO
	rZ567C2ielcs0kdT7caH3f57Lfo0CAxMdUSo7bkxG8f2mgSuRL3G94fynTz9ijI=
X-Google-Smtp-Source: AGHT+IEpQLLXCbQzhInDFOORHkOtHECj7y2Er0jtaiHSlMi0UOj3WeSE/B0Kh3v4iQ7KLPTuP1d65A==
X-Received: by 2002:a17:90a:4b4e:b0:2c7:c6c4:1693 with SMTP id 98e67ed59e1d1-2c861400c20mr12868468a91.21.1719507902270;
        Thu, 27 Jun 2024 10:05:02 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bc99fsm7292a91.41.2024.06.27.10.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:05:02 -0700 (PDT)
Date: Thu, 27 Jun 2024 10:05:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, David Ahern <dsahern@kernel.org>, aclaudi@redhat.com,
 Ilya Maximets <i.maximets@ovn.org>, echaudro@redhat.com,
 netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC iproute2-next] tc: f_flower:  add support for matching on
 tunnel metadata
Message-ID: <20240627100500.3134f6ad@hermes.local>
In-Reply-To: <897379f1850a50d8c320ca3facd06c5f03943bac.1719506876.git.dcaratti@redhat.com>
References: <897379f1850a50d8c320ca3facd06c5f03943bac.1719506876.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 18:55:47 +0200
Davide Caratti <dcaratti@redhat.com> wrote:

> +		} else if (matches(*argv, "enc_flags") == 0) {
> +			NEXT_ARG();
> +			ret = flower_parse_enc_dstflags(*argv, n);
> +			if (ret < 0) {
> +				fprintf(stderr, "Illegal \"enc_flags\"\n");
> +				return -1;
> +			}

No new uses of matches since it leads to abbreviation conflicts.

