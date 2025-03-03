Return-Path: <netdev+bounces-171116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0E9A4B95C
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4176C3AE043
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AB61EFF82;
	Mon,  3 Mar 2025 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSRy+ul+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91C1EF0A3
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990516; cv=none; b=CXZ4DWNex44Ncm2Zh2VuwPH1tFDbBbbnrKuWLiNc4Q/eaQtz6OEvdq7vNwGlzWjFmSdKsfXEUnLTJjp3TsZ9tvJB6rrOhPk7centKtfvsLQ8ywWCzdXEqNGOe3mI0A1DI41C5uFAwD7QRGeGqCuM0diYTpdylP4mq5FhYlnVB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990516; c=relaxed/simple;
	bh=17WU/vH9aHCfGSpScMmdp2rp+45c0QI5B8X33drirlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ6/KJxbQn1Wq1Oit1r15ww3AgOq7SgzE59MZbjmUwuuCBMuFN0ieVDCGc897xNhv74apEEdrGUq1DCMHU4o89szs5rnZuqavd5HJ5SsKClSZvLePgP3/MIfr0wsI8boa5/+NId5Q3M7Syc/rLRU7Qla6rvFERqJtH5oDtGx7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mSRy+ul+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb379so1350603a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 00:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740990513; x=1741595313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3GVS4Gx/rVoQ468as/SRsaUG7WhV9vxUwVHJFy+CZ1g=;
        b=mSRy+ul+qpvSr/yDInfA/iZF1XHAHsoejAB5qBP6mI7zryP1CLNvjWrPXszFRm+AZv
         tSooa1JyE2H06PCzI5pzUUTVtty/ne/ouq1/TVRE0Fr06s/kjukRqrfG9iTJYwUbFK1+
         DCwZlmDCM9pZCJJJ12kkUqm66/CzojVkDhbmKFPZEVbr/g2EchpgTYhxhr+nq1eaaIPC
         2Q34YbCPd9McWcFL378WXhx/0nqY4TG7s1fg+Pffp40bsCdoJzeahr7w8m6ow/FVf8CD
         19EMMeozA7Jw2FnTyO1nRI56AKMuy7FaCQdKcgLRb4i2JbnPzIWGFWy26asgP7UGMd1p
         vrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990513; x=1741595313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GVS4Gx/rVoQ468as/SRsaUG7WhV9vxUwVHJFy+CZ1g=;
        b=I2foEe+ca6zTOfZWYkqgHBgj551zHoRY9jECxyIAAmdfx4nC8fQEIp7u5MIXedwGN7
         t6rMGMpLBEXWJBM4DJwYqSNvcfvEw3zvdpnyOw/SiOG57NyrSslLI/w2OmaxIy0Zy6sz
         1NRfQTJ6GRedLw3dFUeJI8gvNf8o0/Z/KakfZknb/FBC76y9FuP3xSQQu8zVM+Swsj1f
         bH5q9AUTykxQxgtG3/c7wtF3icvMstWIM9syxESJFqKuHPorB3fvaeXNPyGhfyWKsVwQ
         nY86Zn9uvgYI/4d+25JUZr1yxeyfurHyWIcwiT59xCakURVYtB+3IsFEwZp7Kw1jfLUy
         cFvg==
X-Forwarded-Encrypted: i=1; AJvYcCVXIcxedNhp5+1HAtUnD7jvbt19UNEqqH+g9y0PKjqqZw/CsGZb6hTJJ3VmtSNxtv+vAoF9CTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymd7+bTwaSQ+8O9IKXkRhTSslDwuklHPo/EI/cDOi3ZoCXZx2o
	ulWHWxoXr7vTMrDUr3+upjad8wFTywZLCie5PsvNMXcK1NyTMPxiqwUQjHS3LY8=
X-Gm-Gg: ASbGncsuAJIems/zBCRC+b0HLr9fi57aL8C0hy5r4NsUmo5yqSpyNOOFawf6Xqoc9n6
	xnJdDrMEjvfx61NMw3A+cyLdpKFWQczQBqkhn6l0Q1wJF2o3+DK5GR3C9pQU7lsgp7Mx3Z8h53x
	TlOj7nobhi4V+qSF0/Ld8Bzy6/uXUhyIKHHxBXsQF6/46a5Y+0pdetDXb5yBl5ZA2okPZ3FD0Tr
	1fswW7gj0KIbdqfOClpq86zq8UqRWlq01+9ubGD1XwLsiklGNdME6Ogr46Ft1gdZ50gr9TOJk/s
	6J4oylggjl9Up4CU6vvy+cXeK/aZQxhnUJKrkO0SGYKgjsdy8Q==
X-Google-Smtp-Source: AGHT+IGw3jWZzmT57/dnLc4o23VsN9vptXaHinStqoaL1K9VwYGdN1PlwZ1rxWVXdJbPl66BSv46Bw==
X-Received: by 2002:a17:906:135b:b0:abf:3fb0:8c01 with SMTP id a640c23a62f3a-abf3fb08ef3mr1023217366b.6.1740990513299;
        Mon, 03 Mar 2025 00:28:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf7a3ea634sm145845666b.174.2025.03.03.00.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:28:32 -0800 (PST)
Date: Mon, 3 Mar 2025 11:28:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ariel Elior <aelior@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ram Amrani <Ram.Amrani@caviumnetworks.com>,
	Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] qed: Move a variable assignment behind a null pointer
 check in two functions
Message-ID: <a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
 <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
 <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>

On Mon, Mar 03, 2025 at 09:22:58AM +0100, Markus Elfring wrote:
> > The assignment:
> >
> > 	p_rx = &p_ll2_conn->rx_queue;
> >
> > does not dereference "p_ll2_conn".  It just does pointer math.  So the
> > original code works fine.
> 
> Is there a need to clarify affected implementation details any more?
> https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+null+pointers

This is not a NULL dereference.  It's just pointer math.

regards,
dan carpenter


