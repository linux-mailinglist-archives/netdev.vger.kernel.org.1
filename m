Return-Path: <netdev+bounces-161073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D48CA1D314
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611311887E6D
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165591FCD09;
	Mon, 27 Jan 2025 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXWdnJPj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED614D28C
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737969040; cv=none; b=sitHm07QP4XGFa6TYKB64DtjvhVIMC/GQxoEQyx17QeDgUAbySUDR8hx5/nFY3Tj5YrcRBTmRrdZLlRkFZA4nm4KrJ14DPCGgywGQ1n+wF57QV7DuH+mX6shy1JKKDjevXU9088W73jyj/wghUFNXbSI0PWdT2J+xGLjnBECf/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737969040; c=relaxed/simple;
	bh=Fx0hftQxjQH+OA4pUAaTnpVQy7FufPHEfu2+Ds3/DF8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fEPi34ANkPVYMBUxBen/KzZBK6iXora0S0NgE0WiYqNcwkkIuOPGyAVPb1xBE1DrnirxsP2owIdPEQjtpMsuEo+IuT7BIsg0nGV/ybjxrBBAvVXjoCVrUGMIr2PB4XbAzpecacmliR4GVxMZHrmoJLrH8TMDuNZ+IwnShdRRXdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXWdnJPj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737969037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Gwp2ErRHN25QzHUBSfC6o9tk+AkL5iClS16luN1kxLM=;
	b=cXWdnJPjKq7OWkzLwMFMB0JValXqMeRhVNXoeRFqXGcrGOl7QKg0Y+/gVQtxIikICnHmFJ
	ByyY/I+2s3QlclbvfupGx0jFGC7sO+UqgQy+rX25C66rpBRbZjQTSzzE6RPqtuUUgNISrp
	wBDgNnki9YmoLJfRMq77VoVvDSK3BZU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-dDSQW3SGOZSxkqY3RNcdRw-1; Mon, 27 Jan 2025 04:10:32 -0500
X-MC-Unique: dDSQW3SGOZSxkqY3RNcdRw-1
X-Mimecast-MFC-AGG-ID: dDSQW3SGOZSxkqY3RNcdRw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee3206466aso9753937a91.1
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 01:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737969031; x=1738573831;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gwp2ErRHN25QzHUBSfC6o9tk+AkL5iClS16luN1kxLM=;
        b=mDvdpHHKES5JZ8jiYY4hjUZJQTLnbClaSfHlu1PKTysZJQH+2/cA1lm+XI8YrkyVs6
         OLM2g0OsWE5TggdW+/D57zjHwSaqOLWlA/Mv/YFrU6oJCruawC2/9N1rqwJ7VIGXI/GJ
         jPpuCPP18kVx0JFfKbig9sMwIObn3o08F/MrB0pxFjlX3Ud36OCNwB/Sr5/4Z9RhGtX7
         rrKjzCP70Llal0JU4k/uVUNBZEqN6zktA0XYoeMM42lIKh5HfG+aWiVEDlRyn3ha8SG5
         kEVkr7o3YlV/rsorQEc/XTMeSo3jgkH0Sms5h7PMlb07KvfRBascvNAsrBrOoVW7FOju
         R65w==
X-Forwarded-Encrypted: i=1; AJvYcCV0R9eDbYaJ0yoGlu65oh26jFwdKl70V7mf52jSFTHmayCjfpK1ox4LpKvG/3rI1oXqOAIKhRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGb3MqyGEA2iOHgTFdRq6AAOlL7ZUrRZIXx34qb3nWFERibOu2
	mnQ0QjFWYqOEGF7Bot+Gs7jK78WxY81yeLKxA1ZpYsCE90Musx312vJj47NcOJUuxtsc1DHwv96
	aUtUyYgFSsWomUkZfibYRFIYGRvkcD9fDkM+aGG+vH/RtU3x29NZ2Zujs617qhKZ8su3P/KzJlm
	10ynLpNd+j0g6akr7ueZUIOzmFE3v7
X-Gm-Gg: ASbGncsEeZnOEwZiTQUmgo7mA8Iwl+No3KY/8gpxXjO6xBiH1IkKc/n/ZX475A02K4o
	8h2/7xsuQaVuM6R5dtN2rDK9LQ6kUIRKlP8ggBpnMlUs7KyQFVK5F/y+DTz0pfw==
X-Received: by 2002:a17:90b:280e:b0:2f7:4c7a:b5f with SMTP id 98e67ed59e1d1-2f7ff2574e6mr19936678a91.2.1737969031484;
        Mon, 27 Jan 2025 01:10:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2AUO22esWP/nMztcVYFDxN/JjQ3c/z9eP3DGIjhv6kh/a7NKlgjY9QDegkDnWn0ZTMiw3QZuE5pSKHaz0i/0=
X-Received: by 2002:a17:90b:280e:b0:2f7:4c7a:b5f with SMTP id
 98e67ed59e1d1-2f7ff2574e6mr19936653a91.2.1737969031212; Mon, 27 Jan 2025
 01:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 27 Jan 2025 10:10:20 +0100
X-Gm-Features: AWEUYZn-ZxFRojTIs7YgjthZOQiPBt-34IlHaFiIPdvHK4hhLsus_0rIAMhWgeo
Message-ID: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
Subject: Possible mistake in commit 3ca459eaba1b ("tun: fix group permission check")
To: Stas Sergeev <stsp2@yandex.ru>, Willem de Bruijn <willemb@google.com>, 
	Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

It looks like the commit in $SUBJ may have introduced an unintended
change in behavior. According to the commit message, the intent was to
require just one of {user, group} to match instead of both, which
sounds reasonable, but the commit also changes the behavior for when
neither of tun->owner and tun->group is set. Before the commit the
access was always allowed, while after the commit CAP_NET_ADMIN is
required in this case.

I'm asking because the tun_tap subtest of selinux-testuite [1] started
to fail after this commit (it assumed CAP_NET_ADMIN was not needed),
so I'm trying to figure out if we need to change the test or if it
needs to be fixed in the kernel.

Thanks,

[1] https://github.com/SELinuxProject/selinux-testsuite/

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


