Return-Path: <netdev+bounces-209197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90EDB0E9A7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 06:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63336C6A59
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 04:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2565188CC9;
	Wed, 23 Jul 2025 04:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg29ups+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D795464E
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 04:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245278; cv=none; b=T14yX2YpDtEYh513KQLiY/l9oQls+Qc6+HiE+dGiZI2czr4pjOyp04jk733K7o1PO7hrPHOvboJaW6/qzwixPe2EyMl4rpjtYA9AQ51Nx0rjCtCsXR5MPTbAeYxuCYyl7fBIaum4s9o+FW276o/Bd3Dq6es/ZGagbccN5rLTE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245278; c=relaxed/simple;
	bh=UUEzf0Y1R6e/Vpg/RhQRnIML8rAx/rLPZcm3T1mpxdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRMTnN68ySZ7HpUQbgeZhik5ts2mpyPOICThk2zP5G5KHfsAK7YSbFc5a9baAPZS39zFDqOt5Ap5SJKz18B7LQDbp9TxKlq4q43d9pFimWHX2ZlIS8mZTbNcrI/dDzyp1d/SHHjTgTVneaKYIso5xF/m8t4Pm8p54c7URl/NdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg29ups+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so5258684a91.3
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 21:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753245276; x=1753850076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckaVoQbBD06UR6SgG47FgjoeE6rDa1/6PKKXeMtkuy0=;
        b=Qg29ups+uPCBfcFoA2df48cw6YLxgIHVWdHLprvY/+qWeKBMn7aYF0EQz01ayjK/rq
         zsagl6k6t/swkm49DNBR2uOhfhjTR3BKkqFPAXpv0xIirGu7hFqLseL9xbC610ipLYV0
         rUizFLUu7kkSCoYQZWb4IGP0LZckwK6V12hFtJQFXfG8kDCmlzY4vLz6ljQCgQWWuDQ2
         F+OZcdq9Vh+dBBQNfgHplrDKaqFwf6Aq6VLVtdaYEP6ZuCHuX9gMgfIqevMF2Rf26hx0
         /cJjG4f5W9Kq4z4z75mKn6lYvZU5aqrRUApMfcWCsaQbgdOPHwh1TdOheapgst/tFryB
         Jw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753245276; x=1753850076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckaVoQbBD06UR6SgG47FgjoeE6rDa1/6PKKXeMtkuy0=;
        b=uN8xNBuWjzzM8+Gyy1L9Hd443NRtAE0zNFJlNUuqIpWtH4e8ln5fCDjRFqfTl1/CyS
         KEiBCAHY8JFT6PgZggmVkj14a07FqBAwKhDCG/oH+Anvfo4FvWiYJLjpeG7EgnGyTaSu
         z5dFkMMi+aw7akDVXA1txdZ3MBtQNZGb2O6BuO+OSJntb3llxGYyibGm0cFjXwalDx7P
         p8tTDz6iY9D0msrbMlmkBm3rYlUsuoyge4BpEgMTNR5rmmnoXgipVpCAeNgHEGmXZ2yA
         Op8GWyuAcmRcTn4lyT0Nys9izTI1b6qEKfXiQ3QnKg9LYD1SzK1g4syNfi6KGHRdWIcN
         lQxw==
X-Gm-Message-State: AOJu0Yw5o57bTpOGkQ6VI/7MeQCBl79QHdC21QUGzK5lOWnFzE7hrH89
	06zCKnU7KbRGIZOrV3KsRi3kCsTDMe7cUFybiTc/YnN46y08HRvvYETYLD229ZszIr8yIgyp4TU
	aQe8g8xik9IfXjAovGGhK1G69apT7Q6VCu7iJR/0=
X-Gm-Gg: ASbGncvYPHuFklbDlaqaQIwYyqLri2BNfT+cdMb+pMktvtTqSb2yZd93iV+KzBZ22qR
	KOud0k7s6s1EMrII96jnwSVgORrmLkouCXqXX/pz/qbPWDRIH9heZZpZTiMniZxmS9sE7xcp8l+
	qPIUM6d8POlgbHxCSG5hWXPo47JIm9+61u2SnW8+x+Sk3Li28/DpEkQNy10qE5ZD8rj/JaYeapK
	gG8ryM=
X-Google-Smtp-Source: AGHT+IEEchMv3dHWOasxr8oeDvt+mh+0nZXdpBrOZ1x3ZElORIBeC0/CC7ETwnCDfcJrw15Q6ciPTfYtHOdxWWpoVE0=
X-Received: by 2002:a17:90b:2b86:b0:311:c596:5c6f with SMTP id
 98e67ed59e1d1-31e507c3e8fmr2750478a91.17.1753245276342; Tue, 22 Jul 2025
 21:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721031609.132217-1-krikku@gmail.com> <20250721031609.132217-2-krikku@gmail.com>
 <CANn89i+vhTeqgTPr+suupJNLMHp-RAX89aBrFhiQnu58233bAw@mail.gmail.com>
In-Reply-To: <CANn89i+vhTeqgTPr+suupJNLMHp-RAX89aBrFhiQnu58233bAw@mail.gmail.com>
From: Krishna Kumar <krikku@gmail.com>
Date: Wed, 23 Jul 2025 10:03:59 +0530
X-Gm-Features: Ac12FXzkTUn1EM4ku_x0eMNpTpooec26y7ZSMo2akQqm-V7Mvxe56oijtutxKGg
Message-ID: <CACLgkEYaJiHCc_XdbuFynujWcza6q5TDdX+mdCZPiCQV6Js8vg@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 1/2] net: Prevent RPS table overwrite for
 active flows
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, tom@herbertland.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com, 
	atenart@kernel.org, krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Mon, Jul 21, 2025 at 1:44=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
> >  struct rps_dev_flow {
> >         u16             cpu;
> >         u16             filter;
> >         unsigned int    last_qtail;
> > +       u32             hash;
>
> This is problematic, because adds an extra potential cache line miss in R=
PS.
>
> Some of us do not use CONFIG_RFS_ACCEL, make sure to not add extra
> costs for this configuration ?

I will send this fix today.

On your point on making the active check less obscure/costly,
my understanding is we need last_qtail for in-order processing
and add something like last_use for activity detection. If that=E2=80=99s
correct, I can send a patch for it after this.

Thanks,
- Krishna

