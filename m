Return-Path: <netdev+bounces-189270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F3DAB15CF
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31DD1C042B6
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C74292916;
	Fri,  9 May 2025 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loTPxasG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A415E96
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798440; cv=none; b=H9jynNbZgF2susoKPnmY53Y0xH0tKyHlTLuiGHs68WoSFb+LKAATa7FDMaZJszQBQCe6nWSWeiyYcnCb8JGYyzj/7WpjHy7orSTjwe18TJaf2M/qhHpUVPcH8ncqUCWXBc68xF7P1ObQogjtWsw7IGBKYpoGkp2xzeenqgMMUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798440; c=relaxed/simple;
	bh=19/dP4VfkNEVe2LcoQ05RVZZNWswiSYWxvRpKa/npjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnC0wyQir+lGj1oj4i9VjdrpbM+B6XAKNSS+e2b914B7F3pED+DOsuxisth3nn1oloS870EzEl6iw6PGrCuAYKwe19Xy0IYoTthz9NG5E5OMCnvvDEtgF2ZFGm4xDvfNSkMxG4RelHoaMcwSr7aZHDg0kOql+PyiOrBWmIEwyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=loTPxasG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e42641d7cso229485ad.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746798436; x=1747403236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urYmpWFWl6CDsuhCCFO1tExwtSh9HbDy0YPdVsGqs7Y=;
        b=loTPxasGSICoxGJLY+6u7z+4t4ScSZzs8hBNO5FcJGNcO9E71amT6Vex30Moy2XIKs
         VCzdNOLtaMbUdSHWThM577scTIdHKFGua3Y54zkKrOLmun9cyJe6t7nsinbGbnTuuSeV
         15MNF/Orgpln850sNHflFgtRZ3q2cEDu7OCcPqGmrKryAYZsNpmiQuyOGHhcdxrch2zW
         dARyLNJ7r+734wZ9G5aXntTOI8dHPLvfBYoVig2A6aRgftwwtHRh25mKSYwKwTDK87os
         Va9qzkAdm3SqyzasjpKjdRRIx+TXihHWEgKWfOPj5lXB3J23odG4mrL5hc/SThuvH71a
         oOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746798436; x=1747403236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urYmpWFWl6CDsuhCCFO1tExwtSh9HbDy0YPdVsGqs7Y=;
        b=mte6Xj6BPRDZ6Cq5/+9NH/JSKapT4XrcZdoI2GBoOKP7B2uk2/oEGMZrKKSEbG5/Wd
         x/pYNGflYYHm+kDPpoV1nKVodgY6qbrO2RummvzItE7o7nvydoFaU6fWvGQAc6tncLVn
         Hacb+3pzQ75pOjF4QrKpR2MX0IkU7BVCmv6Igf4hCzISrVtvcD/z0Gzyr2//xk1LbA9w
         J1V+dYuohQJCjcZ2HXnPAb909hnDTZe+K+aS5NrnWjJx/9cCW7Pjx0h0T14XcTGmYpK8
         wmy/nCpeVJTu788Vytyse8qm4T0dv+owrdfUj60oUNg+KeEQlfpZinA/yUYykX5+x2hL
         ANZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiqK5zfXb1KOmlo8cW/7qrRpczyjefzSSIjehYwwFoeIKisrbtntRUpDL+Tv/lnBE0N6KshSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxoU36C1w25U7VT5vCQpNzh7Vntirp3Li7oPqoaEnzpgCzB/6
	yJJDV0Jq4KmM+4ANW8hzvRViYpm5oSlCwYjX0SuyQfVEebvfYhdkluBBxZ7041hLVJkN4XZYXwg
	vVGCeEgJPOscsigVwOeXPS11757GM3Emc4iAk
X-Gm-Gg: ASbGncunwW0JFxj4z0V6nxBzquv3xPptiP0ZKkISZZg0sp5/c6jIkDuGTVwuifM39dt
	XL6SLJWDwgWXakm+GJ+QD8xMQuB6TpwozJ7yiPiIeYM+KArS7M+k9J0JzopfhxsXTpkeeAxlD50
	ARs+VyIyqa7nDUsBf2qtqF8Jo=
X-Google-Smtp-Source: AGHT+IFGki/GalQf4cuGdwsycPmdJYmOtIwwXz5djtoG4uzjXnLPSM+HE+TjHYTL4SSNm4jusi/2k1FCXOfBGZvzZfo=
X-Received: by 2002:a17:903:2f8f:b0:21d:dca4:21ac with SMTP id
 d9443c01a7336-22fca880a59mr2792035ad.6.1746798436384; Fri, 09 May 2025
 06:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509115126.63190-1-byungchul@sk.com> <20250509115126.63190-18-byungchul@sk.com>
In-Reply-To: <20250509115126.63190-18-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 9 May 2025 06:47:03 -0700
X-Gm-Features: ATxdqUENBVO5b237iXl1zx5MBh5FOCktoOh4mLpWuXNPgspC-UYrNQ0QGPP7tZQ
Message-ID: <CAHS8izPC9bcdb4-Urw7-1zhYaJzM1cAUJzXPpJp30hgLiwr0_Q@mail.gmail.com>
Subject: Re: [RFC 17/19] netmem: remove __netmem_get_pp()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 4:51=E2=80=AFAM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> There are no users of __netmem_get_pp().  Remove it.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

