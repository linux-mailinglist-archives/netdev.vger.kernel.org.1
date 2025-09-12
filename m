Return-Path: <netdev+bounces-222615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F60B55037
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 753DC4E32FA
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932433093D3;
	Fri, 12 Sep 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l53DPv4j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8B2C11E6
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685716; cv=none; b=kn3dPcSCyuzN64uVhRHNKJ9cz9tEd8rj3LVK9LIVTQIcPCliTrSKbsRvoWBUPAUyXgjv+fAOq835oqyb3iv5x4Mhocu5oolUmEnprU80OPSVl/x++I7nNTYC2Di6lddhodTipnzAZDKt9UihZvt+L+NSeXYsR+NZRIebofRueEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685716; c=relaxed/simple;
	bh=7rvcuIfSUk0LQQCXax61QkLh1aDxQ2GxeV04u/xOeLs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=hiEItli8ySLFxYl1ncwTIRgw9mzE7GvMrL0yVgZZGQMurMPNeneAjI08kK6XfJsLpfXkK4foH8UZkmVCqgKA35nTL7N1YDcqWrk7ZZolwng4HLLnLmCFE2wQYAFnnwmF4Xde0zvMoPIa3r507QEkZdeA0t9bfYLYCbtAg/5H9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l53DPv4j; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32de096bf8aso1474137a91.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757685714; x=1758290514; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rvcuIfSUk0LQQCXax61QkLh1aDxQ2GxeV04u/xOeLs=;
        b=l53DPv4jNYtrmAX/f8v/XCF2JCWuz8llnuOBx9UWQNeADMCb8NuusWd/xQ7ODL774j
         zKvwB+cVvx8UFuBe1wSctSv5SHYujp2qP7kDIT4b+p+dDzJx4Gvh9IYslHGuvdjGmsOw
         /AQlEqgQ2EE+TK0DLopA3khV4R+9RIBbj6U5JNxyfFkv5KkITI3TNlcuLithU1P1AFDL
         6pjQEXOA0BAfytNSscV5emKruw6lrOGMrdFCbwAVvOHuHd+AFiG2HTKYHOfCHbVgTRgz
         N2AFcPEx0d5QicwDwpidIlCVS11euzuA1Gce0BMUA7GAuWkDjU9u1QPojHzDzYtYsVz7
         KX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685714; x=1758290514;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7rvcuIfSUk0LQQCXax61QkLh1aDxQ2GxeV04u/xOeLs=;
        b=u8IvWJZtCSzVx78fr/3Yzh1c7CeUPe6JWzhK/GVBPhWlsfJ2hV7etPpaWo/uhGk3Dl
         JyXZLFAJizIQC8pEGJ+46Xtiaed7ZzG5Cbo5SZKHDUkzTDht2D9KmqnHiBxLY5JGC7bO
         Tbk3Xb4W+i3qPGM+SlMY/+3BcPE2u5wA5p69SDOvrSaNzhY3MNZtBEcocsiAkCBd6M/Q
         HbdzsKZpRagBM7cbwi8qQ9RKRgMPfp+dWylYyNlxsAnB5kqli4Y/E4ZH9wT9HnJyftD7
         QeopZunYeEQS8zWNUbfNqjcUTDdANKxRs6Y2+43M+FAzm6SK6OvMWAKdqkB+PrhhIeAD
         iM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqab0ZVaRHVBpbaGzoTMNWzwFtljIBuKh65IA5ktSDbXEuxgVpQeF65ZXDUk8BqcL8tM2GYDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+j0P007i+dk6Uuv8nFShVfw2OYaz6tJRExtricwvA2IMqQMF
	b1OeMp9sQ9MocoGHM3juvZW8B7gR0+i89Jv8QjCHi1MmU7bL8QiaTgL3
X-Gm-Gg: ASbGncuvtSzrT0j4tJmb0POEKtVn1SN7ujo5ijs6fLlU4iSBZxtUNhs5e7jBsdtIExs
	L6zUnTTaMuNhY66tlWrwK1si9tPH7B+6LaUytrbdrUo49tCx9wIv2p9VSAuTEns5m3189s9Aeyk
	DxaJG/Fo0O5OrQQJiy9ZGZXTzlHbkzlrZnnjXqCYrLHh2ivUfY7Mc1sZsG8Ol5ZHiP7WiE2nN/d
	SBy+GA5WeE2rF9mnwcuAL+qIFUvNTAjg+pG1BA37/Y0GBXcXYpCtnqQap9CPXVCwCkDrNdEBpBu
	Q9qGI+6kRMSeQB/Vtc7zWWK7Cg3oEziduKkhe4vK6tYSShqJplh/eaumgMprX+jjIyzxbjlweNG
	3AWUNxFZB2CsmoQhumUHwpsVH6Uxb7jXecQj+Ru6VYuGimXM0YJW/GGoHBmUNJJo=
X-Google-Smtp-Source: AGHT+IHWSz+w6eoIkvhvgrVNiWjU3LYGlW7OOlG0NTY3CL+0l389umh5tpWV5rzuBp8pVkhE0o6IIg==
X-Received: by 2002:a17:90b:3504:b0:32b:51ab:5d3d with SMTP id 98e67ed59e1d1-32de5165dfbmr3662440a91.37.1757685713515;
        Fri, 12 Sep 2025 07:01:53 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b3e8fsm5885506a91.17.2025.09.12.07.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 23:01:48 +0900
Message-Id: <DCQVKZ3LKK11.50FS0CMR7ARL@gmail.com>
Subject: Re: [PATCH net] net: natsemi: fix `rx_dropped` double accounting on
 `netif_rx()` failure
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250911053310.15966-2-yyyynoom@gmail.com>
 <20250912132123.GB30363@horms.kernel.org>
In-Reply-To: <20250912132123.GB30363@horms.kernel.org>

On Fri Sep 12, 2025 at 10:21 PM KST, Simon Horman wrote:
>
> Thanks for your patch,
>
Thank you very much for your review, Simon :)

> Thinking out loud: Adding use of ndev->stats to drivers that don't alread=
y
> do so is discouraged. But here, an existing use is being fixed. And I agr=
ee
> it is a fix. So this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
I also noticed that many drivers are still using `ndev->stats`.
If I work on related changes in the future, I will make sure to use
`struct rtnl_link_stats64` instaed and post patches accordingly.

