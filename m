Return-Path: <netdev+bounces-196816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C660AD67BC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0981BC13A5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 06:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B651EE7DD;
	Thu, 12 Jun 2025 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFo7PDvY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717891F2BB5
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749708771; cv=none; b=YBQc5+YNDNC7DowYAXzSvQS1rcC9Celyxj0MZv37pxTCI3DN1q1MtLENur6eAVid10uDVuvuYq8EaRkIAOa6D7g8y6G2VKhm5at89svb6Kizl411bryZLGfjfXjgFkUQIIxgC+dWRiyNs1hKHOBDhrHEuaRUB+1IkoOi9M1BerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749708771; c=relaxed/simple;
	bh=MlbQ50o4f6u5pnc00CzQIFi2h3qEcGsw79ewAeB7PF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5Gz52h514clhtK2XtzwsQfCrrqpMs6CZhC/9ECc+2eygZkCrhAQGo0jny8Rjzh1VCvzN9AQfOK80e/I2Zg2t2v5i2Ufmpbd5ojgRmBwpk0wOG/n9/yFd09dFPfjIifdrxxYJuTV4XaBhIm1Obfpe030dEuaV05IGcH4T7FtI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFo7PDvY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749708768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MlbQ50o4f6u5pnc00CzQIFi2h3qEcGsw79ewAeB7PF4=;
	b=AFo7PDvYF2NK0MHYckJiofc4sBFl/b9wToNdnDfXkP+f57M57IoIEocSIVYHqkd8lAT3ro
	nS65bv8sQ6iKhWMUGSJl5/1+T0byvB3Wop+cCaJkt9tX+rHgsjxkPWsxeVrCHAo2tpSVa/
	uHIuV071aUA3+VmhuvW3hi8xBjR4jO8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-8jgYw-z_OTyAKZ33-T9K9w-1; Thu, 12 Jun 2025 02:12:46 -0400
X-MC-Unique: 8jgYw-z_OTyAKZ33-T9K9w-1
X-Mimecast-MFC-AGG-ID: 8jgYw-z_OTyAKZ33-T9K9w_1749708765
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311f4f2e761so619905a91.2
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 23:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749708765; x=1750313565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlbQ50o4f6u5pnc00CzQIFi2h3qEcGsw79ewAeB7PF4=;
        b=gzs4vBZveEFxnjfba9F8GH5jVCw5d6W9nNyMYuov8EtzT13PlwWbvu3bqG9O/sJFRL
         w9rt4/fxrWfsTEO+NHbS8lBQhHgJsvUg+bkkAkwjmr0vgo0sw6sxcI9imM3TvftigSgL
         nx86yHHygTlO+iyty6hFpxRlncVXaxC/0XuKcRHN1YEiTr6WAkDVhuv6wrsEJKv0npEH
         yVBoGIoyAmAZXkaQLCZQ0YJZLtc23mQOFehzJfdQ6y4TaI0hIVdDRjwPVZHXeWttQXkt
         6DVwJqdeZq+AjRSdK/c+XCk/eTPqvUS5DfPfpb9lDypsdyQJTbZZAMOMonotbEEw0M34
         IQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCWm5EnVgXpHw0fey/kasJBrv3kh8DS1d1Ctj3eHEQjl+EUx9XunYO0p50F0bigoGJ4AFCZDFiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzffe+k4ePk8fs3cO4EMIZlKPaKD0l0zfWGeeJal4SY+ABHUXco
	Zqq5SuE712wZAJEZ92pGelJ8VhV9AgKwzwBlteZPSGX6WbiqmeuuKFk4WCKur5auGotbWmaVW4I
	3DUEOV2om5vOXal1vPkMf4V/s52GCVgIzZbPIh+QU44LYGOWTL7UgePq+UNFxeW1bBcJ39X00Nu
	Dzwq/QgcQJiYb5RNVhoGyyAuqCsh/GpFD/
X-Gm-Gg: ASbGncsMGraKtgiOFu77DA+jSPb7TYPWX+A+I+ey5fP8as1cNf9UcfbF/22Tx0lq3DE
	P9mMAfkcUk5yzrfhko5RwmXc0i2/WUNhP//Oz6nTVDnCU3uUDyx9QmC8wYEXQ/NRf4gY/GovfWQ
	JmXMnZ
X-Received: by 2002:a17:90b:5628:b0:311:e4ff:1810 with SMTP id 98e67ed59e1d1-313c0668326mr2584712a91.3.1749708765356;
        Wed, 11 Jun 2025 23:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8nEsPFjSfYppZCrGBwOZj2EXvMsBbci1aiHbuZSbde5qDOX/uaEqUZ1HZNfewkqJpsnTzU7HSRHu/P9/nbYo=
X-Received: by 2002:a17:90b:5628:b0:311:e4ff:1810 with SMTP id
 98e67ed59e1d1-313c0668326mr2584680a91.3.1749708764934; Wed, 11 Jun 2025
 23:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609073430.442159-1-lulu@redhat.com> <20250609073430.442159-2-lulu@redhat.com>
In-Reply-To: <20250609073430.442159-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 14:12:31 +0800
X-Gm-Features: AX0GCFua3qf1tKF-j83aW6duXknVJEBpOabQNRyFghC9nw8Dh5yPS6CPiPjCd68
Message-ID: <CACGkMEskts7y7bCxRLoZvDbg0YZbdF59b3Jzxkgpg0KCCY+TiA@mail.gmail.com>
Subject: Re: [PATCH v11 1/3] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 3:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles, it confuses some
> legacy userspace applications, therefore, we are reintroducing kthread
> API support.
>
> Introduce a new parameter to enable users to choose between kthread and
> task mode.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


