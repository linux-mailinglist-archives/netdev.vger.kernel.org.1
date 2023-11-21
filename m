Return-Path: <netdev+bounces-49626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58DD7F2C9A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE24281C90
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919C948CEA;
	Tue, 21 Nov 2023 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJjRVfnN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E52138
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 04:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700568666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUFtFB9/4q4gpI1y/9fsg7wSq63KYPuBeyRHJSkbC1k=;
	b=MJjRVfnNdP3+iF0MSP7EHZdyKJlqWIZWYDrkm3RsZ0diOPGDa5lNEw7UyGc42UsNWqo9xA
	KFGpOwrlHS+8t6ejgANLn3XzVett9GTmECvwu8/AsZG2OLFcDBP3cE18nEUyU/zfkHH/0F
	M4TI3mZXu7rCva2Q+LV8b2jpmuV3NG8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-k0PkLSEyMueN89HOj5-ClQ-1; Tue, 21 Nov 2023 07:11:04 -0500
X-MC-Unique: k0PkLSEyMueN89HOj5-ClQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41eb42115e9so17294021cf.1
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 04:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700568664; x=1701173464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUFtFB9/4q4gpI1y/9fsg7wSq63KYPuBeyRHJSkbC1k=;
        b=NKEIkbv02cngebbk9/dGjTzO7NjRfhTnGUC+8Zfxfa8tXhBpFdja+xt0R95o0cXdVv
         jC7MHcChpJ/7BN1WlVUyZupETSAlJJNF8NWCb4fLNE/arTf8oYgtk5qL2NVi53EPxYpw
         XHP6iqhe1bJZgcQEWnBXkFiau46a3E/1m+hGKQ18Gi4k7+7j4AX2t0G55cSAlLJXqMqn
         TTBtxexUk4HDQCKam9ZLwqr9U3Y3LNipcEWAA8ZUKlHTufEBrKuP/mgHiZQO2HFGcVg1
         AQhp9E7BMm2a51w3y3UtFQOymSYvBTzPsG2HwKLayAWSMLMgF2filzAWyN0jfdTlokDN
         ADPw==
X-Gm-Message-State: AOJu0YyxN/oqUBqQS5EVn/EhG5l4MNBqHyDsnRW43VCT3jWchmEdTGIM
	jIYpDpfxWVXq+BNdGcUSpvFzULb8gSGbBfqB0ibnJHen3etlD9UPcKA1zGUEwKrLAnqxeyj9vGg
	ijcfaQ8kbJnLII1Mo
X-Received: by 2002:a05:620a:4542:b0:775:8fab:8c6d with SMTP id u2-20020a05620a454200b007758fab8c6dmr12651342qkp.1.1700568664169;
        Tue, 21 Nov 2023 04:11:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaQMamlsB9+OZOddaRinOvjEZo8rBDxBsfZUrGETZnBUh+F/A1r2U50deTAKHYwyYGkW1afw==
X-Received: by 2002:a05:620a:4542:b0:775:8fab:8c6d with SMTP id u2-20020a05620a454200b007758fab8c6dmr12651317qkp.1.1700568663786;
        Tue, 21 Nov 2023 04:11:03 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-2.dyn.eolo.it. [146.241.234.2])
        by smtp.gmail.com with ESMTPSA id bn44-20020a05620a2aec00b007758b25ac3bsm3570065qkb.82.2023.11.21.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 04:11:03 -0800 (PST)
Message-ID: <7948d79d8e8052c600a208142755b7a74b4aeee0.camel@redhat.com>
Subject: Re: [PATCH v2] ipv6: Correct/silence an endian warning in
 ip6_multipath_l3_keys
From: Paolo Abeni <pabeni@redhat.com>
To: Kunwu Chan <chentao@kylinos.cn>, edumazet@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
 kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 21 Nov 2023 13:11:00 +0100
In-Reply-To: <20231119143913.654381-1-chentao@kylinos.cn>
References: 
	<CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
	 <20231119143913.654381-1-chentao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-11-19 at 22:39 +0800, Kunwu Chan wrote:
> net/ipv6/route.c:2332:39: warning: incorrect type in assignment (differen=
t base types)
> net/ipv6/route.c:2332:39:    expected unsigned int [usertype] flow_label
> net/ipv6/route.c:2332:39:    got restricted __be32
>=20
> Fixes: fa1be7e01ea8 ("ipv6: omit traffic class when calculating flow hash=
")

This does not look like the correct fixes tag, sparse warning is
preexistent. Likely 23aebdacb05dab9efdf22b9e0413491cbd5f128f

Please sent a new revision with the correct tag, thanks

Paolo


