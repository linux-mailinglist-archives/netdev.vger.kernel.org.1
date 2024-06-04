Return-Path: <netdev+bounces-100561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CE08FB338
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917B7B2AFAB
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97997144D29;
	Tue,  4 Jun 2024 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhAI4SSB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCECA883D
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506054; cv=none; b=jtjRK/IatZgQS7nThqg0dqrIKVfBrA96PaaMAHSwOzo9FUBv/MNnaxizxeiik2A+4VjmsjROnGxEPm6rU0FX2qGQAd/hILZ+ED3PDgU7lZr6g/DwqJFZiKBiGlYO+vuISuCtFhhMXQLJskyBbkngpUxaxpIfW84vMUQeNHa83iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506054; c=relaxed/simple;
	bh=4dy3C+S3hd0FPPkIUIJXf/k0sJaqJ81lFVoITncVzB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O5Ezcj8feBcuPrskLhVMfjbKLEOE1Qwk4U0jSmiWKFsjoV3cT4CXd5tH8p6PklK3dn+fVVPd4lNGyFmbX/yimoa1t6PRh1/xf3hu83EWoBQvOEVXgFElMBioTQi1IqsEHUBWCenOy85ZxLttrKcs215ju4MSLoOfnX5N1N+tf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhAI4SSB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717506051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dy3C+S3hd0FPPkIUIJXf/k0sJaqJ81lFVoITncVzB0=;
	b=BhAI4SSBl+ZfVtMQyCzCsTdStnVaIZvVsyJ4xGRyxIFXvFNfl7KjaQ3o74mDsLth3CE2JU
	QvV1vEkyPKEoCpy1LZ2PTesY6m0qcVMH/ZOksQq7RhLsO3qGMqG/pfGhsWZCynbWvf8dch
	+Tl8MCPDOazb0yGwYEEyzDXKdUnO2QQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-BaGRAD7VN6m41GxMO7HSLA-1; Tue, 04 Jun 2024 09:00:50 -0400
X-MC-Unique: BaGRAD7VN6m41GxMO7HSLA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3749b243bb3so21067685ab.1
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 06:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717506049; x=1718110849;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dy3C+S3hd0FPPkIUIJXf/k0sJaqJ81lFVoITncVzB0=;
        b=isQI3M/JUZvqG2a70PR93lKhkhJy4V0779Up4CY53D/3VsDR9cob/87sGIKpDL50Ra
         oPWyBboXZ0UT6z7WIw/S8IJqwuaU7dr0t2sPLsZRfICsEYFEmj8wu0kVIQECuugJTof2
         kTZB/YVDHFhVPP9fAObxjz13HeDiDrvjrViRj7zdWHOdVSoFxW8oiw/NrtnkZqSkeogy
         d6irUY41n3XXQOhYrwF2LcVubBCUhEvTEIJROA3QnVz0g6IqsNrK7TvM66Qm5STWorY1
         oBod1FDjXRh5/CSVweAlgGz/oo94XAknPQuCSN2u1mu/NBxnhE5Bn/cU0FxCZfWpek3V
         8+Aw==
X-Gm-Message-State: AOJu0Yw4urbogX5zRQC4EHRjeb0DVC/138VVKJXWAt3JNdIgeDfHvhl1
	f0GIcksMxp66iapw0/u2vBkEAgpagotEOtQFgl9BjiAnehSSkwAmfTQOgW4bNLDAFyFGx2C3e1d
	B7OuYwKBfQrKZ302D+WVhtJ4loaDG2CfprO8jK2zIqh2c68n0ZeV6yg==
X-Received: by 2002:a05:6e02:1645:b0:374:9a3f:d191 with SMTP id e9e14a558f8ab-3749a3fd576mr78408515ab.25.1717506048304;
        Tue, 04 Jun 2024 06:00:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu4tdlODuH+HgeJ8YEeB56aLveLdQ01tKLlIX0yQt6Yjr8rlxMx06CJUfGZAVzqTo15Og+QA==
X-Received: by 2002:a05:6e02:1645:b0:374:9a3f:d191 with SMTP id e9e14a558f8ab-3749a3fd576mr78407375ab.25.1717506047257;
        Tue, 04 Jun 2024 06:00:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35629c3a1sm7010330a12.56.2024.06.04.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:00:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EBE4E138544F; Tue, 04 Jun 2024 15:00:41 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [PATCH net-next] net: use unrcu_pointer() helper
In-Reply-To: <20240604111603.45871-1-edumazet@google.com>
References: <20240604111603.45871-1-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 04 Jun 2024 15:00:41 +0200
Message-ID: <87h6e850cm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Toke mentioned unrcu_pointer() existence, allowing
> to remove some of the ugly casts we have when using
> xchg() for rcu protected pointers.
>
> Also make inet_rcv_compat const.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Nice set of cleanups!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


