Return-Path: <netdev+bounces-170418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C3BA48A6A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB563B6245
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86A271277;
	Thu, 27 Feb 2025 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSr4jJsr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192626FA77
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691514; cv=none; b=ub8RzxpCnGdDvzRquV1n2cfr2T0rvVUDVD8gNTaXkQa43bSh/KptRbGuBOiS1S30feDYK9BYNTF0LlQqTuumiWJM2YDWEUkHfdojuXP1uV6CsGeSSQiSi6YpNPKJDhm5Uuw8TQacitywbcvSCYr2QuSw2twTntP2lBv3m+jy3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691514; c=relaxed/simple;
	bh=lzJuj68IPYELNEwepv8cKovi68A07a9ryFLZ7YUT620=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQohMoCYf1w3QrNrlsNoubRSTVuhF/HxM9t+RU4ZRBifPSAB/y9hp6d+hMnifOy7BnNk66JdbXdeVw1aXZRS/ticrm1C0i7xnKLvdYtNB12C+nBbQFPGpUsHSlgn2sElFFjjpXYTxKm6SiP/L67/yebfVD/ygRsKOPJMS+pNRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSr4jJsr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22349dc31bcso26946035ad.3
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740691511; x=1741296311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPasBJtfA1A6r+ygxWij1B6VOAarT8bcVJ1UsJBCOVA=;
        b=YSr4jJsr8f6wYqWFiRV9qNusW9GB8PWYQ5IN2Ei6+3NEAcV/xNUyfZ5V5S/9neJUSp
         TjTkexNn7u8LfMK79w8CnYZH8pBQNvC//R5ZYg2PUvGxZUHswPJz3CaTRjX1PNtn4SWn
         WlocuQq+svWCNk1QU14FCUO90LACbM1RYN45+jcusYPFcnCS1eVQJtP7y+9wS3TimkiG
         Z9rQJn3WvFYy6tFUe+DNAfLiHXVe15NU51mwUPRNwdbv9sY+DULQ3V2lyVnGcu4n7sFB
         NIx1alDu0ex7/COJwyOLF09e/k38fX2ZVDvcaDMkUxX+RzFjXHP5dhb66Y9M8RAi3STL
         FZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740691511; x=1741296311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPasBJtfA1A6r+ygxWij1B6VOAarT8bcVJ1UsJBCOVA=;
        b=jqZclEi62sHPmfwXD1pOTIXeOqWa2kXBe8Yf0CinE9C8xT2jsd7yLDW+LTHqLbVmcL
         6GDWxwEiygv8stMLxfgWSmcrkg7bYMvyf3tQGCc6cBy5+S+96FyMV5U5i7BQPYhMjERo
         MYtqfqH/RJRKJ2wUHp1toiRJf2z4beePGqM+zq1m95FI0ZzGsNapNxyRr3xOdwGjiGmn
         wbC5Z6HK2n9kMpGcSDJkgcj4rGSZD4pQo+K1+gNDVLg0fkfP5uei4XPbs8UFBC4Xti9s
         JbsuuWlbFf0G+7kbo5vDFilNkew5ECd9TUZnk7uvu3hSmjU5r1vKdAw8I3meWziGO7fr
         T+Yg==
X-Gm-Message-State: AOJu0YzybsyyVc6AHxo3xB59cBGeBHvHdtKKUG+vjFowp7irtrLUhZQh
	1Z+EqdQ697jHQUl4mX7Ti5lApXm4S/rKsVV4uZptDxdu6uC+PVPARNs0nM1m
X-Gm-Gg: ASbGncsLvG/a/xypEJ06sOrhSss8QkYhhRst5IDoJJQDNk1ibPAOuT7qHVBLT6QJj5l
	mqDLOptzEgJKyoJyTY7NAeKuN+IXnX22+wmXRi1sz2GvxKZAhDuTrPPuFiPrqVrP7lKNNRJbvFD
	puBgTkI9A1p7Zh8NDJTtQ6ju/fvUh+a25hVzYLuGk57i5BRvB911dMYr2RevC/bxIvu5JBhItFr
	5p1PNtqbVHalGS4k46S0vlWBhOu0EaC2Q76Qonyhp9vIbRuk0BrTSHaUfu7syatx3FB0gO9GakA
	elAH/cotX9SZS8zi6nJ/FJx9MjJeQjd4Ok68uQY8at+GJJoDQLJ6nIrOCw==
X-Google-Smtp-Source: AGHT+IGBHq1s0yxlGfMCWYPgfiqJIRDa3hS7rAXHcG6G6Vcvw1+v3Kh3nPvhIl0+ny6yu9e75zJzBw==
X-Received: by 2002:a17:90b:3803:b0:2fa:20f4:d277 with SMTP id 98e67ed59e1d1-2febabf1a7emr1399582a91.24.1740691510953;
        Thu, 27 Feb 2025 13:25:10 -0800 (PST)
Received: from google.com ([2a00:79e0:2e52:7:8e35:ae3c:1dad:1945])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825a98d8sm4299464a91.8.2025.02.27.13.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:25:10 -0800 (PST)
Date: Thu, 27 Feb 2025 13:25:04 -0800
From: Kevin Krakauer <krakauer@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] selftests/net: have `gro.sh -t` return a correct
 exit code
Message-ID: <Z8DYMBlzcK5sFG-M@google.com>
References: <20250226192725.621969-1-krakauer@google.com>
 <20250226192725.621969-2-krakauer@google.com>
 <67c090bf9db73_37f929294ec@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c090bf9db73_37f929294ec@willemb.c.googlers.com.notmuch>

On Thu, Feb 27, 2025 at 11:20:15AM -0500, Willem de Bruijn wrote:
> > ---
> >  tools/testing/selftests/net/gro.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
> > index 02c21ff4ca81..aabd6e5480b8 100755
> > --- a/tools/testing/selftests/net/gro.sh
> > +++ b/tools/testing/selftests/net/gro.sh
> > @@ -100,5 +100,6 @@ trap cleanup EXIT
> >  if [[ "${test}" == "all" ]]; then
> >    run_all_tests
> >  else
> > -  run_test "${proto}" "${test}"
> > +  exit_code=$(run_test "${proto}" "${test}")
> > +  exit $exit_code
> >  fi;
> 
> This is due to run_test ending with echo ${exit_code}, which itself
> always succeeds. Rather than the actual exit_code of the process it
> ran, right?
> 
> It looks a bit odd, but this is always how run_all_tests uses
> run_test.

Yep. I could change this to use exit codes and $? if that's desirable,
but IME using echo to return is fairly common.

