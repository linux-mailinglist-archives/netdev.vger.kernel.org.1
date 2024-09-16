Return-Path: <netdev+bounces-128495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B57979E41
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 11:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3742816ED
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5249214885D;
	Mon, 16 Sep 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsPfR5Ua"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233750284
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478308; cv=none; b=pBdcTvrvZWB3zUXHSx98NtSUkgzzp9ZtPe+ywkJfRDfrNps2F/j4fWLu9qv5AtVLaPQI5b32EoixsiMBVbuq5fakUNc+/Db9mCO46O8tOjSDB5aBVWZaLC97Ejb+Gpap0poWmUiOtn0urBCWaRHssjSUE8ziAJh1uHPkeNtSU60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478308; c=relaxed/simple;
	bh=4ObeC0BBv6cOiOS19lpCT7ucyqroI9pb5hRBLrLuehM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eD6Ky5RxaF6R07jl5XeLbKvSPXyPxw/JlV0LSqfOJgT4zZrCy8rPwGwNBsE//m0onH3QUggDX/X4LkaLjmtv+FlYyaYxK//h5DtYk0Qoy8fRwdJ2tApUFNGxTa2WKao6EaW57M5AoV26ue7cCQUGYbe0xuv6lrtbxzYLGWjc9qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsPfR5Ua; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726478305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ObeC0BBv6cOiOS19lpCT7ucyqroI9pb5hRBLrLuehM=;
	b=JsPfR5Ua6sWMkyzYXpy6ymHmJIJg7x4p3cmLnRubiaduKsw++vg7XFjqcg4y4EI6tEJKn8
	vi1VxzWveGkduhGBRGp9FguubaCmG1zjBGDZwdhaGxgRVXz0L5zfeQ/dSzQVYJ//YgC4DV
	bAbUHey0xpqXO/iUzbEW6xHQmcNOrrI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-uEF5_EKoPLC-Ks2J_Tkz4Q-1; Mon, 16 Sep 2024 05:18:24 -0400
X-MC-Unique: uEF5_EKoPLC-Ks2J_Tkz4Q-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c2486f1f14so3025524a12.1
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 02:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478303; x=1727083103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ObeC0BBv6cOiOS19lpCT7ucyqroI9pb5hRBLrLuehM=;
        b=eDzUavkqzhGhk64/HTVb5LKN2/jP3EyfU93gxEOSzjdg24peco6ufYXW95d0X8AXjt
         nEy3nCxZLcMsEXxXd/6s61bhDAdlBt/cwMQivamsf/92ZUwE6K2BYdmc0weXvO9OaT1x
         hapBEOIUWtQj14zqopAgffnGKm2Oy/2CJWVlUeR6wicOlinPah1wW5CLdIXLkcjL0sKp
         /ZDiy66hAylSlRAe0rwV8+UpZ2e6OAn7/fWHgiH3I7kH5vSM35TtKEXyMbRLqqr42aaK
         Hrl2rxPG2DreEjUgtS6LQO0xAVp3BitU/1KCt/CA+ULaQ6m529Yvw3/Nejr/MCs7dQC9
         91lg==
X-Gm-Message-State: AOJu0Yw3u3UQxKpHArUMY6rASSklV1TdH/m0L1VygSkouR/kIkw5BMtV
	8aev+dwc0RAdMP5yfzcXlLVz67HtMCBZFwAksMByyr5VkvalPJVLkpvkaCbNQyboz4d+xNVcfnD
	LLVCTHm8Ww/5pDiRM8Ds+tEgZYQQkdTPnnRPlHTADaP4ZJH+kjIWFw2x/l8YutETPA7cDmkvvd0
	ci/Gt0g3UnL6Z4AggJbPDyNoGEo0ne
X-Received: by 2002:aa7:c882:0:b0:5c4:b33:1f with SMTP id 4fb4d7f45d1cf-5c413e4d733mr12739725a12.28.1726478303151;
        Mon, 16 Sep 2024 02:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7CHBj/WGcfdYFerM4RBr9KBFC9knIUEaA4Ru9XZitNmJ4lRTBby8u4O8JF41ib8BoNrFxKUBrTcF/H556+tg=
X-Received: by 2002:aa7:c882:0:b0:5c4:b33:1f with SMTP id 4fb4d7f45d1cf-5c413e4d733mr12739679a12.28.1726478301775;
 Mon, 16 Sep 2024 02:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909083410.60121-1-anezbeda@redhat.com> <20240909170737.1dbaa027@kernel.org>
In-Reply-To: <20240909170737.1dbaa027@kernel.org>
From: Ales Nezbeda <anezbeda@redhat.com>
Date: Mon, 16 Sep 2024 11:18:13 +0200
Message-ID: <CAL_-bo0QJJJootMQysNSLNmu0Fps3dqjPE0F0_=R23h7GqAkfQ@mail.gmail.com>
Subject: Re: [PATCH net v2] selftests: rtnetlink: add 'ethtool' as a dependency
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, sdf@fomichev.me, sd@queasysnail.net, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 2:17=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Don't think it qualifies as a fix, it's an improvement.

Well, if the `ethtool` is not present the test will fail with dubious
results that would indicate that the test failed due to the system not
supporting MACsec offload, which is not true. The error message
doesn't reflect what went wrong, so I thought about it as an issue
that is being fixed. If this is not the case please let me know,
because based on the docs 'Fixes: tag indicates that the patch fixes
an issue', which I would think that wrong error message is an issue. I
might be wrong here though, so if the definition of 'issue' is more
restrictive I can remove the 'Fixes:' tag.

> You can use net/forwarding's lib.sh in net/, altnames.sh already
> uses it.

I see, the problem (and probably should have mentioned it in the patch
itself) is that `rtnetlink.sh` is using one of the variables defined
in the `net/lib.sh` - specifically `ksft_skip`. Furthermore, I felt
like a more clean approach would be to add the `require_command()` to
the `net/lib.sh` so that other tests down the road could potentially
use it as well. Picking a different `lib.sh` would mean either
modifying the `rtnetlink.sh` around it (removing the `ksft_skip` - lot
of changes in unrelated parts and harder for review) or adding it to
the new `lib.sh` and at that point we are adding stuff to the lib
anyway.


