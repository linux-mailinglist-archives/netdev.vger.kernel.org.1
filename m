Return-Path: <netdev+bounces-247135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1195BCF4D72
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C3D3245691
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32092299947;
	Mon,  5 Jan 2026 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDbhuYD+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfTT5jWW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D62749DC
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631437; cv=none; b=IbUmWuj40XCRZiWBzV+yc4yVT1Z7/KAQAx3HG5Y1v8dRPUKXo3yrX4V8jUlwxAXkfscku3O+B54/b6KPrrTP4ShS1Qaq3arEwKcxCvK/zi+dZSquHPId7s729ZQbk/XEJInwCaECba6YKGfmoH/H+EqDQdWRPgkfiYYwfQSGjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631437; c=relaxed/simple;
	bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VPFTpmRtPLYwwW8L52BdtjBTqHc6aixCRzRhKKZSpO8SOlL9KCWWCsSeJ2JArYfJyepVkcx1yUCs7VRHP3ZGhGJECodZAcx3oLcrPqn1PqFnIsEQjmHivPHkdVB69ztvDschVsi/q5XuvHZ4eF5mO0nKWe7ygB1vmhC0YNybrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDbhuYD+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfTT5jWW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767631434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
	b=SDbhuYD+zHAUYkGSI0OlEWCSzGeUpnfl+AiymGcVacGPTMAobII4Qs2vwmFG0ymq34KyTs
	Hz95amezKtI5AQeU9Ribddsw666lmJjh+prizyutxZKbyScT2/mD9LVXENGbCnUhgLla37
	x0IYEBWm9o2PBcJPeKpe78lGzIvM6PA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-UAfGvuwgPWadyaVznIz7xQ-1; Mon, 05 Jan 2026 11:43:53 -0500
X-MC-Unique: UAfGvuwgPWadyaVznIz7xQ-1
X-Mimecast-MFC-AGG-ID: UAfGvuwgPWadyaVznIz7xQ_1767631432
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64d1982d980so93990a12.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767631432; x=1768236232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
        b=BfTT5jWWW9XcWvj2mHWxy95/dLJmljmH225nTzmf9u01uoo+9HWhIKFHWalLCZq+Oo
         XXcCsC3sMvGWfXDw1G3idF6qakzRnpWdKQn7MszfbcmtxleLFQVdi359RqvqUmtqOWeM
         Zdmn5A9D/SZKOYilVIQWPq4Y+tzG6GtgU0+/OFC5dN6efNxIuXhLEopShYsuDXWUqwJB
         kaRjDqLsHMx7CK41m8C7oa2wLcez1cYUFD1nqeG3pmjGCi46tanzzjphD3bXCqvsfqNt
         udlNwWdAiOVT35KkUM0bus6VfS9XUXeL+u0u0dpkKKOegkhFVnUhuWrki729FpconX2d
         7HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631432; x=1768236232;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
        b=P3B2HLnqwGD7KTnOcmmLa4X6Gc83utBRawdhdBXk3ih0IYUTxJTCv71WA9S/st69va
         u61J9ejlhZ5g3EthY91OoQr0yFWiqwZ/LItlwd2F0Qnz5T5Q7NkgXY+G92eSJQIKQjka
         gYCjILUd3mmHgYJSRN2c6O8qeJNgx4x8qDCIyoqq3UT4iJeMeAv8LIrbOyweWJ4JMsAr
         ZzvQZr3hX59dC19wHk06ts/ZqFzWMwZlsHUCjdhOXxiyxzm+rJQlcrkqjaJ22nt2WGVv
         ejCF4J234NaWu4uPrFg3BE1SSYS+1o64iTCmSTf1XS3xNQ4rzXrCdh2yvo68t8GI8suc
         RYPw==
X-Forwarded-Encrypted: i=1; AJvYcCUbU5Wpwwi4g7n/TPsNYwZIz9Avn/uXCrq0ivlAN3+4AISQ9hi30ak9LH04xIr/WmeaghxvHZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYb03RPLx2hP+FsxL9sr/QKT7JxzabI9eZpUUAjnrR2Gt2HOv
	ttctZ5DljATLNviHUHCDZnfnFLm0yZBiZ1RCWS83HMrdlFUbHrcl9atW7+uDF7bJQKpiMEVp2Qd
	JUjK9pgd8W9bQLcjZu+3EVaY/s4z1o3Fp+OSHe8785DGqrP7kkoNfF8dMHA==
X-Gm-Gg: AY/fxX7y4VOtYT9CkhLvzOxLla48fHR4+3gm/19WT63bEyU9du/vPS1EYeN+uuaw+zi
	jFEtc/QOEophSFkcFP3aESjj0THLv8m4/oJt/VcLBlHQhzwCLUusN3lXvtsM695DY9Z/VTp2rBK
	3rD/T2LXpbWsKI0IM+LAwY0akrg2zRbW9xfrZL5beUG+/WTIkR+sFeeGDUum4tNMV40Xd4PKwPo
	871TAxmwSqwQkQYOUdRqYXkMAvTiC2heu1iPeVy6h/3RCUN5xFvqM1DKYvx8YujiHdYFjry2Pi8
	IER/GYH5nw5Gw290b5pmkvX0xyOewWQLLA1fjxwIUwLT3xgCEcZitwqVkvNolrJiBKejDgmcaFq
	q3MUqv2OoQcM0y3FFgcHH5zcjqBCpNCQs/VsB
X-Received: by 2002:a05:6402:4414:b0:64b:ea6b:a884 with SMTP id 4fb4d7f45d1cf-65079561d9amr39794a12.17.1767631431859;
        Mon, 05 Jan 2026 08:43:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5+CYTAwrLc8azSOHqieZ/AYKr+pOh1WCTsnwOkUqmz4srueS6d/oRRO9LBMmPRJORe96YbQ==
X-Received: by 2002:a05:6402:4414:b0:64b:ea6b:a884 with SMTP id 4fb4d7f45d1cf-65079561d9amr39766a12.17.1767631431378;
        Mon, 05 Jan 2026 08:43:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507618cc31sm222081a12.24.2026.01.05.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:43:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 18D1C407EDE; Mon, 05 Jan 2026 17:43:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, shuah@kernel.org,
 aleksander.lobakin@intel.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Fix user-memory-access
 vulnerability for LIVE_FRAMES
In-Reply-To: <38dd70d77f8207395206564063b0a1a07dd1c6e7.camel@linux.dev>
References: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
 <20260104162350.347403-1-kafai.wan@linux.dev>
 <20260104162350.347403-2-kafai.wan@linux.dev> <87y0mc5obp.fsf@toke.dk>
 <38dd70d77f8207395206564063b0a1a07dd1c6e7.camel@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 05 Jan 2026 17:43:50 +0100
Message-ID: <87ms2s57sp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KaFai Wan <kafai.wan@linux.dev> writes:

> On Mon, 2026-01-05 at 11:46 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> KaFai Wan <kafai.wan@linux.dev> writes:
>>=20
>> > This fix reverts to the original version and ensures data_hard_start
>> > correctly points to the xdp_frame structure, eliminating the security
>> > risk.
>>=20
>> This is wrong. We should just be checking the meta_len on input to
>> account for the size of xdp_frame. I'll send a patch.
>
> Current version the actual limit of the max input meta_len for live frame=
s is=20
> XDP_PACKET_HEADROOM - sizeof(struct xdp_frame), not
> XDP_PACKET_HEADROOM.

By "current version", you mean the patch I sent[0], right?

If so, that was deliberate: the stack limits the maximum data_meta size
to XDP_PACKET_HEADROOM - sizeof(struct xdp_frame), so there's no reason
not to do the same for bpf_prog_run(). And some chance that diverging
here will end up surfacing other bugs down the line.

-Toke

[0] https://lore.kernel.org/r/20260105114747.1358750-1-toke@redhat.com


