Return-Path: <netdev+bounces-141000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9E19B9098
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B191C209BC
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0846E19B3E3;
	Fri,  1 Nov 2024 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAangWgP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030C166F16
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461666; cv=none; b=fBMr5NsQcesmM1/gyWgyCxxpWkhUjXSrLVahHxBX41b66u0NA3ho8wv98JB5BZ7I7MQvs2mxH1Jxrqpau/nZx0jzEphsxD1aLvOkdegy4LR5UgshsvM2p5im1iQYUHqkP2g6Zbto3CIMGyFwJ4sHlHhkfO9zFnqCk3VepcTv0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461666; c=relaxed/simple;
	bh=rFzzuYAv2SKccWouLovsdeghCh1s+OmcwrhbhkmvI6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GWFMszJ1Hqg/rw6U24uolAIqheUKxKMDVkFtbVWUW5RcvStIZ6mBKiBYcX3bizHN6Fmwjwzz44+okW0HxqACL8RrEj60lLpFVfizVNvSXU2Y0pUle9YIGJR9Q5U8JkxR1xiaZhqeQtPz4/sEPM7QlwDxJMjLNJ/ZIp26Zj+eb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAangWgP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730461664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFzzuYAv2SKccWouLovsdeghCh1s+OmcwrhbhkmvI6g=;
	b=IAangWgPB6bLrQjWV6qgxesAOFyZKGAXCpJlv6vckDaMA+t+qThi9a9zUCkp7RdRSlJipI
	3Q5giknJe7esyIymB/BywYYGKlzchpX1dSIRc4PQY3xPw69K1P1wkzvY57thZHmb2E32m1
	zt9MdvHgIKE4eM++B+wbOMmg4ictE6w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-8Nuj20csNDKcsctCSGWNPQ-1; Fri, 01 Nov 2024 07:47:41 -0400
X-MC-Unique: 8Nuj20csNDKcsctCSGWNPQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43152cd2843so11745015e9.3
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 04:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730461660; x=1731066460;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFzzuYAv2SKccWouLovsdeghCh1s+OmcwrhbhkmvI6g=;
        b=SU4EyZqCtjs1gC77e0W+iRBkjzCNWs9421ZXdXM26Z2EuUqE7kertglPAMaeowJdRz
         ncolgWEucsKzQyVoFVKYipqyHucVW0R+cXbR/MjiIi0jh7gPLmz+lBcRGRQAymKa0fjR
         E1MPKSxSpOP0oClYh1Y6PVOEH9hpa0Nq1TUBXeqa+vT8m0iF4LBqRwGBTY5OnBG5XNYV
         JVtK67wDgX6zuYZKhwb2dafmIrl/Uaphbx+gpM+tVdR+lC4uZEvX71kwjaxQdxYeUtRd
         Cf7VveU0HhSRk/tZsaJiAY28V0IY21MoohNbn/1S/MhN0xROiB6mgiH7idVCCO3gSTkd
         vcKg==
X-Forwarded-Encrypted: i=1; AJvYcCWk8dVw1HwY8ElzzlPLC6OvSlrSCC+TbF0i9sUZdNLgNyb6QLqgXX/Tqti82Nwb01855ztgiZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SJifC1KRvI1FySa1qDEZew20gMnYHrW5az5JYnMu+SSM/P5w
	9vbTeMaOOrT/YSMWHu0X30Xl+c36FjV116w7pnrOdhxAK4Ld8Rg74mjsbRyPk1mMvNNbVq7L2yp
	RnxvTd8jXrHOcsTV9o7bwBUH1t0tqF/+ApTs+LAZdUYmkbY7Mbbkk3w==
X-Received: by 2002:a05:600c:1d97:b0:431:5459:33c2 with SMTP id 5b1f17b1804b1-431bb99053bmr107786655e9.17.1730461660612;
        Fri, 01 Nov 2024 04:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNlCYVzQ8SAbhWfaM5n3nvXcLZFSRiXEpUvQ8tFWfAU9tvUBvRq0rnYNEnYa0nWbeMoxReGw==
X-Received: by 2002:a05:600c:1d97:b0:431:5459:33c2 with SMTP id 5b1f17b1804b1-431bb99053bmr107786455e9.17.1730461660233;
        Fri, 01 Nov 2024 04:47:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7365sm4783523f8f.54.2024.11.01.04.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:47:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BA4BA164B94E; Fri, 01 Nov 2024 12:47:38 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 05/18] xdp, xsk: constify read-only
 arguments of some static inline helpers
In-Reply-To: <20241030165201.442301-6-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-6-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 12:47:38 +0100
Message-ID: <87v7x79nvp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Lots of read-only helpers for &xdp_buff and &xdp_frame, such as getting
> the frame length, skb_shared_info etc., don't have their arguments
> marked with `const` for no reason. Add the missing annotations to leave
> less place for mistakes and more for optimization.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


