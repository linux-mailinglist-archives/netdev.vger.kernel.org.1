Return-Path: <netdev+bounces-149251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B359E4E66
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEF6286A13
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503901B3946;
	Thu,  5 Dec 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHaidylg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216E1AF0DD
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383890; cv=none; b=AG3HaiRHOMbh0Z60E5nraeHG/eIhWutLmon/MeKxM308abE+e3DUVo1eIKsLmlldqm4yC6uPSGKK5TggrGnhk1tw2AMOHg2IJep6lyXNVUqxghBMpjNB3zIztEF+T5ulsaDuTOaW8nki2K4xlclMEXnYAPpCKOtmR1ct2cu7JRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383890; c=relaxed/simple;
	bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gi2Omd1Q+YHb6XTxe6ZPvE052DLBnguknCJd9R4mIzQY0Ub+wFpgxWT+Dls1mGGUOTg2sdd2WLtlpwF39Kn5JkELwqNhFdJzxGmCcJapP0R3UKo9Y8fkQ2Bt+iDVcWwIvwpsj8I+H9fas5/V87S/uKHRGcK/o7ru/8qWFRQ/Ko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHaidylg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
	b=eHaidylgv+DotOSaDLvT9TEjVOqCChpM7kzwxY9jt5HVWbqGMeSCpjTRRc7754L2LGzmr0
	S00dwI+rgjj193W5raNP4S85N3HwUGdFKwyPsumk/8TSwxbNHMyo0CDoghojAhdUSi4MYK
	K4KRZU8Dp/A2KnsrUCZLdzK+t+fJYIA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-F4uFMzbEOBaBJhz8Exj1xg-1; Thu, 05 Dec 2024 02:31:26 -0500
X-MC-Unique: F4uFMzbEOBaBJhz8Exj1xg-1
X-Mimecast-MFC-AGG-ID: F4uFMzbEOBaBJhz8Exj1xg
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7fb966ee0cdso500755a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 23:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383885; x=1733988685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5hrOPbOPNUVXcOQEyuWhzf7VhtV4iCnBFUR7CPiUA4=;
        b=dhsAwSqYpucz5JHmP+NHc3xwu92tONGeNuaAmUO0jIEpK+W5vyc20vVhbFonHXIqby
         s2LWkhBKLCEV91tz0SpuwAxzE2do5/IecHJers1GnYmjfX+9HsLa5iqi+tYTQneEghyY
         OOv3HDWjlipTD3PH4ORuAVZ7XtEDOOZSiuLgl3o6huHzBIF+j5hYsMIKTbfDmtvg+qge
         DlG5sIE/82XpSKemdndmy1Il/0HKdXeVZIUwEbfspw4CzD1U+uTl98RJdgFjhNh5u36P
         l5bdKhTRKtvj0N6lJlG3O8UYLi3lBdzXOe93s33OFJ4W9jIrk7zpxSlB+rDWrwS37azQ
         Kizw==
X-Forwarded-Encrypted: i=1; AJvYcCXhDxmK+y3kWPBrl4XEKSvyjiQBdegI1syULPB+yfby9mk5IRgxSNjZhb3pEruaGwvbG0HkIz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweAutvzXhxPUnDNyxRBzSRKxV54WsQdwEZjjxxVmkYUHJ/wvIx
	FVOPHMGjauTHPCkd+J7njieaudlNGfECsk74k4F48BJF1EETAn9g3MY80FsFVoZ4pzn5us1bYfY
	ZpLsohhLjQnAv8ZH3sSDfwWyeM+XiN+Cp8a5uhkQpEi45w5isiewOwVTAVGLYEBpFqywAjfZB4k
	dPw+l3ikZdp4LY/97W6JfZpgIor6Z8
X-Gm-Gg: ASbGnctWjDdHNlkbtGFMc3nHpHi0kI8FcasDDh6qEkMA9u+h8PnuarrCE6rqhn6kSD/
	FiH98tBuqvqNq7IUrS5Fe+IsuR0JLrVBq
X-Received: by 2002:a17:90a:6346:b0:2ee:4772:a529 with SMTP id 98e67ed59e1d1-2ef41c99386mr3511957a91.18.1733383885276;
        Wed, 04 Dec 2024 23:31:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Uz6s1s92mheWZ482J+Pms58UfnRdPDzgkeV+DuxdzrY+WXQ6wsaWOBD+r2THsCYKuaICd9UQwkstxAvMEhs=
X-Received: by 2002:a17:90a:6346:b0:2ee:4772:a529 with SMTP id
 98e67ed59e1d1-2ef41c99386mr3511918a91.18.1733383884870; Wed, 04 Dec 2024
 23:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-4-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-4-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:31:13 +0800
Message-ID: <CACGkMEsmAtguhDbYbgzs0f_ynsDy2UwYR3jun+J_OQQwuXGWSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/7] virtio_net: introduce virtnet_sq_free_unused_buf_done()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> This will be used in the following commits, to ensure DQL reset occurs
> iff. all unused buffers are actually recycled.
>
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


