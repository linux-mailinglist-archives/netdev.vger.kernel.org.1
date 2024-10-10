Return-Path: <netdev+bounces-134056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89895997BC5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6541C21EAF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1558E19C549;
	Thu, 10 Oct 2024 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSMiD/uE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF91139D07
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 04:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534346; cv=none; b=RfAPE/wNG0Okn7M3GNMbqII78N5O2izkIuEJObmI2wnyGK8v4ipR4CVXy39VB65+0v4JNBlxUByvJf7C8kQtkJP/Ce19NgDjsYG802ENEfw9AhCFJ8dsEWPQNTzWHKNiWRbIGxABKiEOaizZqBG+fAZQXilxs6bEyxrsPkhXV+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534346; c=relaxed/simple;
	bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwLIagFbUe1sUNttud2eez1bK1gK5NGno9uTv68jcn26mSsWfq/+K6vPmy6wcJQJ+PN3pRfpexkjE12DtIkOq7dc2mT4pK7OAs0Rt1NWsWK4j9be3+F1CRRQzi9SAPz+hygjmCtqDixial3HwvCIW8F2z3vIAqL45Q+mJlC1PFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSMiD/uE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a993a6348e0so31704166b.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 21:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728534343; x=1729139143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
        b=KSMiD/uEaRT4o0X2yCuKbsPvE5jolm/KfNmTKqiottd06Q3lHXeEgHbjIjDili3DTh
         C+cryc862veQackWPcDwIO4z1mvMwXqsh+VSJAugO9apJkpk6Yd9eF66H0MVmj44QBqr
         n2awzu4IJ41e4b01smEo+20MsnM9o1ZlaHfItSqpqsOGGy4OpU62bkDCgeoDJBOUvI/f
         pGTcU5LJRaepf3TXJQLZrP2l7CtzEZE/1DH6x6fyGquv402JyoMJ77ca0xzTTauNrQvi
         KGGOyLcrkmfL7hhrhTntvWwkwmYje4LA9TQecxI6THPE5Lw5xIOVLcqUYV3lI4l0J8TA
         tymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728534343; x=1729139143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
        b=pi5Hma+KVowrDEkxRye4YTdXoWl5vwfW9tFeaBAZdapt7Uj65TlmrVGD1wa9RjfbTE
         q9lNtE2+aaUQwWwqSuRCZ1g630r5WctIGhP5JqeE81ZdvUZwkHHO0Mo6JlCGQL3FSLb2
         QL2jK+vsnVBYRpT/GwBSMxF5t2GsPkvcSaH5o1x/hpxXISclWABfjLbUsmELolL8G3Xj
         CymNg5loPHHeJWAfR3t7Jdq5fSc8DWD9dTh8f1T8O2d8Ka1wFZtGDCsWrvJZWwYigHgs
         C+nhS7mcnzJhVH/Y8ettesRVifxt48Db9BdfzPxvL0jybizv1eOu8OAUa4vAmvIYGvE0
         G55A==
X-Gm-Message-State: AOJu0YxCPEM8XXhcODQXE65C4zZf3dXCwt7N97xuTjBzmcsF9a2qi2Y5
	Swr8zC1y8IJBN0gQnN4zVHuHaXKUPxAR6dF8VYjZixVBLE0pn1wlW3TFHogx/Uc4hc9S0c+Bs7+
	gyDtVMgVQye3YwhWFPM5NGu2s0Cg17/eYaqLKssmcnvartGIx3g==
X-Google-Smtp-Source: AGHT+IFz4pdgZupNhn7in9zPhzp+j8ykgz7dxdPdgdBGTBuyCZjJ2XDwrC9kDTGTqCNbuhaIvTnqfMsflbbfqtgcbxA=
X-Received: by 2002:a05:6402:5114:b0:5c8:8cf5:e97a with SMTP id
 4fb4d7f45d1cf-5c91d6507f5mr4628607a12.33.1728534342434; Wed, 09 Oct 2024
 21:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-8-jdamato@fastly.com>
In-Reply-To: <20241009005525.13651-8-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:25:31 +0200
Message-ID: <CANn89i+vXeaSWP3EVtBC0RgmvkDy67590k=bXPjHenoHwFM8aw@mail.gmail.com>
Subject: Re: [net-next v5 7/9] bnxt: Add support for persistent NAPI config
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	Michael Chan <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:56=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Use netif_napi_add_config to assign persistent per-NAPI config when
> initializing NAPIs.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

