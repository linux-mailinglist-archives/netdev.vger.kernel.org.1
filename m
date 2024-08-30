Return-Path: <netdev+bounces-123731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A964966506
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1754328349F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2D1B29CD;
	Fri, 30 Aug 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngJVwrpQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73E1DA26
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030644; cv=none; b=W1JCnNyJf5MO69RVCQtNdXz5+6+3qGMThBDewLvNZjnc8OTnFEbTfdJiG9Fr41QWIv2jSkKIy+YjhcLO2kO2HePgzwEybfe6AGlaN31X6lwtn5bnJmh4nxiRurKcyyb81q1CW16QwTdBLjtBLt5k8UpXCYU9vDoL9rpu7tsdcgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030644; c=relaxed/simple;
	bh=aMhaA53YuVWpBYUxWgfWGofWbTDUfzmhOm1C8MFfIiY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=g3O+cRDJBiEf31drle9jYSBS75gfrK+0vHRhQH3cSiXypQ2dKh9O6LuVQFWISfg9Cs2HGuJOK+Kr6b0TZm5SYftO8D3sLU/6CPntLM690v5/ZasOYQjfcRR5FMOjeaMk288KnlN7N9ARJWIqnUL06ysWIizOk/DP5mXRNPLkZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngJVwrpQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a81309071bso47668285a.3
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725030642; x=1725635442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNUZ6By2EgWBMnsF0cFUCesRVwOlXKmiAkyJApR7oyY=;
        b=ngJVwrpQVfqjSmeEFqZWjV8ppVbG49H2D5jaW/0IT3W4nW4nIP9BaXucDWEgG2sFK9
         PFZ8YcadjY34oyzahaGZTBRfn8de4VwPK6Atm5p+ILhR2hbykeRS/64x31DsoWRkVWb5
         9776w//yRSg0w3EcgfdNYDoCIk9aotAdBvQJlyWI6m0b6zw3qohCz8mXgoM7WD92BDL/
         sa8MKCYtc95MdWM7sHhrWwSeW+S2Xch91Y5uoEHAdNYWbw6YeM41VFzdJQ+f9kTMf28i
         uiPosx3xp2rrqYinhBWlwFwxkqk1KYE2OaqbS3jN9yQgsFzRW/fioKNs0JggpTmkEoRw
         OK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725030642; x=1725635442;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VNUZ6By2EgWBMnsF0cFUCesRVwOlXKmiAkyJApR7oyY=;
        b=oRBaubCWxn/U0XNkKZlhqPwX+qYUm8Rnkx7HioA1GbjK6A0tGzu8g7k/T0FVnJuhYa
         xeSdQLH5q7IxBSbx93Jhd6qbgTaIx4nEclJesJSNYoef1vaZ9U/bXKGiujK4yaSd03Cg
         QDqkbMkN3SGU4BDz+A4YuKOn69iKUjNLtKw/ERVA2e8xHbIxiKFUA3z8UEoG2A65sjQ1
         b3UXY1j03YhsxnJKNPWRGRvxlV8qinmrVvkWrHMkyPMVubSQrJJFiHk9msKYPNG6Zfke
         Ozkby82VsL5h7fhl0piBrZ+KUxMS/b3w/m74HGXNcZ1HILPYcsS018YAdTCHOGaum3h2
         FYTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5C2huSqC8+VlQhLztcPx/6m8BCzQykVzIkvqzDShTH8fuKF5I5b5Emd58zeoHrpvlcmfJceA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPoeiwMJjwy7NEog4yAlQr6XOr7LKDd0M3e0dd/UUhIU9oTmdJ
	mqgQ1+bdJ3fV1j8U/AicXvWKZ/zCp6T0yC0g6Ie9UPjJKQBIL1Ir
X-Google-Smtp-Source: AGHT+IEa+YjFZNk6nCHh/+GI+1iYiVJ69Pgv27Oub9D8ZfBNd8Njv94TjGzJiKY478KSqMHkaBDg7g==
X-Received: by 2002:a05:620a:462a:b0:79f:44d:bafb with SMTP id af79cd13be357-7a81d6a3f47mr15566485a.38.1725030642306;
        Fri, 30 Aug 2024 08:10:42 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806bfb8f5sm150875485a.12.2024.08.30.08.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:10:41 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:10:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, 
 netdev@vger.kernel.org
Message-ID: <66d1e0f19cbe8_3c08a2294df@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240829204922.1674865-2-vadfed@meta.com>
References: <20240829204922.1674865-1-vadfed@meta.com>
 <20240829204922.1674865-2-vadfed@meta.com>
Subject: Re: [PATCH net-next 2/2] selftests: txtimestamp: add SCM_TS_OPT_ID
 test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> Extend txtimestamp udp test to run with fixed tskey using
> SCM_TS_OPT_ID control message.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for adding this coverage!

