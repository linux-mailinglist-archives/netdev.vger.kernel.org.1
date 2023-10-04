Return-Path: <netdev+bounces-37869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C57697B7714
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 06:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6FD5C28124A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 04:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA710F8;
	Wed,  4 Oct 2023 04:23:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C67136B
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 04:23:07 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F179AD;
	Tue,  3 Oct 2023 21:23:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-693400e09afso383414b3a.1;
        Tue, 03 Oct 2023 21:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696393385; x=1696998185; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mdh6W1N1Pc5uEkvtWKu2b0D4c3j6GY2r5pUlMYcimSo=;
        b=jq95pEc4AW+JB4eQhrSmo/akvA/Fb/Bc8qXIH7Gnsgla/4xCWKsS40uxDhA86Ctwd3
         f1G3IDNZI/BadIlH458HTmnYHtIdKM7eyqAeRy2nxjfXN2ZRws26sWDJI6eVtqqLgrB+
         QUd7aM7n8X5AQGaNrW1UQJdL/QFqykSCoTY2Nk0uMJZoHdW+TiKx9zkk0mfiqhESDv+O
         a0YenwwXfin/lAK7uaGLGjLnv7evruHqLvIbKRRwqxUpC4/DvWrxgEe+6egPS0V3RD3l
         QOhXwZi2MiERyGaUVZn+LMbrBpYKxdYYfYwWXEAQez+i+xaNsyngOG6o4lqaQOruN9Hi
         YVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696393385; x=1696998185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdh6W1N1Pc5uEkvtWKu2b0D4c3j6GY2r5pUlMYcimSo=;
        b=dplVvoQ2Ke33cx7QPjx7qlvDAhYeGmwORaf+wNj5BSPyyqvVNk/CmH1b7SrzfQUOYS
         CnSJGvEJOgAeWcvJq4YQa9gUVj9Yvqfgw17AiIH2ZilEWSzM55y0a5RBvlIkF9ZPxPaJ
         ErCDMlDU6Vq4aoEkHx+zjsu8JrIGaMhXxJ6lLdbfaGb10i8Gr02SSlpIgqvEmwHYGD3Z
         s7W457qtWbL9wt0e9e+t7C/2o4oS33HlPz2BitnQnM+rkI56BPp4ieDPZKYh+MK82NPD
         dfg4iaqG4Le1mquFo3+wFDipBTGK8V0HLNwzoqh+U6+cU4GaeJOCqpC3O7YVws58Hero
         VYDA==
X-Gm-Message-State: AOJu0YycJoreLCgYFnTCPA2MuBjX1g/I8yAIu3Zf2hdmPzliViGA6ZUX
	iv5rYXCQ07qoTNaQ+F8gmOw=
X-Google-Smtp-Source: AGHT+IFiJoeta9M8uZxfsYLguNw2WHIfFzSL0lORiY6JAAsa+HGRxv9RsKq/xYxkQMwD/bPRKw6+6g==
X-Received: by 2002:a05:6a00:39a8:b0:692:ad93:e852 with SMTP id fi40-20020a056a0039a800b00692ad93e852mr1470821pfb.2.1696393384991;
        Tue, 03 Oct 2023 21:23:04 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id j25-20020a62b619000000b0068fe5a5a566sm2252035pff.142.2023.10.03.21.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 21:23:04 -0700 (PDT)
Date: Tue, 3 Oct 2023 21:23:01 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar =?utf-8?B?KOCkruCkueClh+CktiDgpKzgpILgpKHgpYfgpLXgpL4=?=
	=?utf-8?B?4KSwKQ==?= <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>,
	Yuliang Li <yuliangli@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH 3/4] ptp: add ioctl interface for ptp_gettimex64any()
Message-ID: <ZRzopem76msVVFCB@hoboy.vegasvil.org>
References: <20230929023743.1611460-1-maheshb@google.com>
 <ZRiSQ/fCa3pYZnXJ@hoboy.vegasvil.org>
 <CAF2d9jgWpwNye89qrANfngG2+NQPDhpZQjXMKBDG6x7e32_cOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2d9jgWpwNye89qrANfngG2+NQPDhpZQjXMKBDG6x7e32_cOw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 05:29:58PM -0700, Mahesh Bandewar (महेश बंडेवार) wrote:

> The purpose of this API is not to compare clocks but to get the width
> of reading the MTS value (offered by NICs) in terms of the timebase
> that is selected to essentially improve the accuracy.

What is MTS ?

