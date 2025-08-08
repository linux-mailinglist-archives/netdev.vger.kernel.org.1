Return-Path: <netdev+bounces-212235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F32B1ED08
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E61587DB7
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9121B0413;
	Fri,  8 Aug 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="vz1x2GZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B54C9D
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670699; cv=none; b=ErpZuX03RrN7nNmhIj8NYIH1GbcAsl7xG4/o5XBZmVVKowS6/E/V+UuIMYTQKCWTyW8AY3+vpomcaeWpSDjAXmWdsoKjDo+LqxJv7T2Z5g4SvN8oe3qUhvZRwbTvEWRY/Il/jO9WATpzPWhYWAJe59ThldsQZYjrLtcGsbjfBf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670699; c=relaxed/simple;
	bh=9kzrq9GrFDEF6GU7mvIbRnIC9NJ05urTqwiXHeP0DPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqMgUVGzPuzUlbLgsWder+fD90oLdLpoNPUM1Jk3jGvaHhrVEYGZ+E2nN5M4OEnWUgqnkdmQ/OkX/2hqddEBo2HQ9Qbu+q0C+7SwAxALdm3g0B20umrejH9bUWl2SgA3pfEUaVoXRA54icA4zsrb9u+kZ61MXags/vtefAjueiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=vz1x2GZQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23ffd0ec2afso1891505ad.2
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1754670697; x=1755275497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JCFWcP86A7eTEiljd3udRp+tRBR/sDLdve/NAZvEAtQ=;
        b=vz1x2GZQxr4ryAj6M+2sRz4NJGrra8Qk62d7ykDRWuN4N7F/gx0wFI9sLtyknxzUt9
         Lb+jBXQypSK3vJL1pNZsLGYmVMomr2doDyqpfUrD2/AsE8jNKkSZT1ZvlLIs9nHvHOB5
         oi7Jj36HPGttnsQr6tCKCMiVQaBK1+1GUf83L+JItF6t0jtj3k0ZS7z8eeZVg20cvBHX
         bJRft1HBZc6qJY7LO7/dBBqhufZJRRvEjIdqhIrdfPLeTsksbm586+bak9aBFJJVYCZa
         UMz1qDf1Mc+BiIvMfcSSToRwfcaVTtApMCCjZgLxad+VxzjAjxS00Ya8lhsTonIW01Av
         YS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754670697; x=1755275497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCFWcP86A7eTEiljd3udRp+tRBR/sDLdve/NAZvEAtQ=;
        b=L8QoPXamLPSupPoyW7OX/3GIiJkVJn1vGCf66SSK/G+CkQ7Kg5asiE5A/9q4WbE5/J
         HZzKV2heiOiPeJmqg1EMKjYAX+ATvYhMWfJjV2GyRQeM/OIlPtqsPuv4QTm0d3nQQxBD
         LTc4v0T/aRtzbQciUsQSkiiTkCYdVhEjdxIHH3l1X7dwGOmorF51IhH8t4nJHE0xaW3q
         jPbDHTmO0SIEu6lMtdcXL5Lnt5X1cXKBv/Ra+ff1dsCeRO3b4S+jzGT6GMO3+ofn6Qx8
         QJYgQDnMDS82FXOky4Uaktnn+oU+sY7+D6htekXXF/usZTN+5UW/cXSnUFAchkhsPlqP
         JY7Q==
X-Gm-Message-State: AOJu0Yw9IC6VTLY4mQaY3N5DT/j8M4+NXsQ6UIpagrycVBiSgX73bUe1
	Z0gtwFaM2+RsHA9AT8r0GQWREKNNuQffxBq1ifZtmNb2NZpQ+pyvE7hdpScnfpbY2+DAESH8Ca7
	9ywzA
X-Gm-Gg: ASbGncsUkn5IrLEEZx/g985qTsPgv4/XLN67UliFi6301g+FSgzltpn2DwyvPilGAiC
	WkJwsPPbeqLSIMAB+LvE0hRhJiZhMGq+Y9J/cUMfzLTxT/gpj0OTgvdluShbyP1YZDKTnNTkX8r
	FaeD8oWWpN/ytygiB+79ps34aKIusaziBrNcliIOeX5DVQ6ygpCm5A4YmBRC9toLpDGN5lipbHs
	Z0JzCoqm8SqI+KBeRMqJhc7iph/ZealZvwgEbp/xEVRxE/JFcGNibvgD4+5sin1mYAXg2Ilauyh
	E2s79whfFTIMUAAu81WasF36bZdrjW05zkGYYjopytRHqGHFbh7C09g1tSCqlHSu7oskJlupCBt
	y1c08a20r
X-Google-Smtp-Source: AGHT+IEKCj1CzAjh1XfVUILZwxzOcCWvMWMP7lzTK5X9G2Iqvky75/K1LZelz8NnGGFZKXYIZ7Y0TQ==
X-Received: by 2002:a17:902:ce83:b0:235:737:7a8 with SMTP id d9443c01a7336-242c1ff1f6fmr25826695ad.3.1754670697311;
        Fri, 08 Aug 2025 09:31:37 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:a6ee:dea7:7646:6889])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e83esm212330975ad.49.2025.08.08.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 09:31:36 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:31:34 -0700
From: Jordan Rife <jordan@jrife.io>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 net-next] docs: Fix name for
 net.ipv4.udp_child_hash_entries
Message-ID: <3wlb5mtibfjokjbezbs5mscobgcuw65nf4ylptr33t4stodvyf@kzqqj2qphotk>
References: <20250808152726.1138329-1-jordan@jrife.io>
 <CAAVpQUCRL8iz5iz+8FBKr5rJyhy+J99gK54BO1B5y1-Q3qPUMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAVpQUCRL8iz5iz+8FBKr5rJyhy+J99gK54BO1B5y1-Q3qPUMg@mail.gmail.com>

On Fri, Aug 08, 2025 at 09:02:25AM -0700, Kuniyuki Iwashima wrote:
> > [PATCH v1 net-next] docs: Fix name for net.ipv4.udp_child_hash_entries
> 
> should be net instead of net-next ?

Oops, I can send out another version targetting the right tree.

Jordan


