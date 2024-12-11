Return-Path: <netdev+bounces-151204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820789ED6DD
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 20:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0522824E9
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B5204F7F;
	Wed, 11 Dec 2024 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PSSsoBVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4514200BA9
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947069; cv=none; b=KCrKd7AYH8bAnFOEjJMarlIKatZreQnGsu9qn4jyGwRlSan7l0fTS4Nr6zTZLPL6+J379OLJtINE95cp5WlruXMsTgK0xPqo/gXHU3T7TGRSPi0siW698GlJxN9It0KY3ugfYSOC5ODCe1ziXRcK2NIJv4cQzKChwNRv8AQxCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947069; c=relaxed/simple;
	bh=lZj3bD4Z/pQaDgBdcSdzNCiak3YKcyASpq+2ZOVMTMk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=he1EFe5R+sRxWMKzjABwTzLHS/63BqsW3lwnZYWUn+qJa5WZjY5m8/Xh0Ev//n+tK7hex/B4bLukwFB1Qk6NP4gALFPuVxq1K4jAOALwAX8mnNCDSSW692n8gjwuLkhVUszLtOXzHH2uH4d8pAKL5/3xEVBX3YOJe5LhxCuP/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PSSsoBVJ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d8a3e99e32so57247066d6.2
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733947066; x=1734551866; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTaez587g5IVeczOdimPFhZ223GwIl+VkkzD+NSihqU=;
        b=PSSsoBVJyCGFZGWaltC9lvuHiJclynRGWC+r5NdYdiRwxS4Z7wKI5xPSgcFJYgqtTe
         yLltHKmiSA634LrhXtfSKOxd8AR+L4bdRtYuTG14+FD+uY0J+tHEpSFSxUGDkG08T4XF
         ybbA91USziPFvtsDiwhsAU8cQRj4ffMO7sNzYksCoqjaIfBUd2tiMWe4YchnmZ8FuYnc
         MF1rt5c8mlM317+Bu+4pjENQUzSpMsZyCYXKEHqeHoxwZ0Z3CeQkKBuH95i0izcPsyxd
         Fg5G0sbbezyTzN+idxo7l0PB5G0UCmtUhVRXFeOWR/27vsFJQOabsIc/b86i1oXKjjbu
         VISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733947066; x=1734551866;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kTaez587g5IVeczOdimPFhZ223GwIl+VkkzD+NSihqU=;
        b=UabcZRE5TBqSKUm4/XPmHC2hbxv3EaQ2lHlselN5cdZ15F0LLC3/4+g9VtirgI+GTw
         ZIh1xZbwa5VbkLLxp71YJikLcxETbj5X4tqtlpIDRBzX8R5sVBqTI7Fs72HhOOo+KHDv
         GhLyh0F4N3JMGqanVbk+4AUrlnCZT2PSt9GATn7Vm7XeHbS9Opp9+fFGvOn0N3bUUoZp
         VGuA7Plb+/dj2xiFsgh64u8C7yuDhn1kZbp+JcbIs4MZ4WP97XDe4nw9lZdd/WIrYuXF
         qSCZtLSDELVgVRI5GfDZjCTvQ7zZ+j00KPY3eC86wUWqqLlCrEEK27ieV2zmIkGZ/lFl
         k+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFykDm4CMKoch7yfgkCGjnCud0ALmiO41YbKKs5Arqeb9M953K74Ew4Pv6j0zRQuJ3WArVRnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbvyGkzD9G66mhjx2W96d0Ht/GNYPoEREC9hvOJIm47TfUZOL9
	RT74QxioP3KsbRgVJ1inpJWMXbRDWRH2vPctR+HOGVxqeDYvJCL4hkwWR/celQ==
X-Gm-Gg: ASbGncsphZdZAasCSc49/oa1GO8uj2o5sP3NoIz76gofF7lj787AiGcUNxP30n3aPLz
	VpUKj+skhEM7OvUaZUJqtGPAxFSbqZoJPOFDAEutC9TQE+TwvFMNIy9IPk+43Fv5FtbsuVMkW9i
	DqvEqyBfklJsW2VqRHoAHf5Ad5sVUdrSYkxtpVSc1hyn2+yHuPhIwdUE0YKSLp6xSxbzLalnYwg
	2e/zx4DhcX0bfoD1oKRwNbRtzwyaCu0wi+wVq9crWRFOom2
X-Google-Smtp-Source: AGHT+IGBOUap8cv3SEb0cypjAet3rJA8zgKWZ7ah8T+B7ys5R1NUDfZ5hNnakEae+5HKZG4CIe3Nog==
X-Received: by 2002:a05:6214:d81:b0:6d8:8a9a:8d9c with SMTP id 6a1803df08f44-6dae39338ebmr9975466d6.27.1733947066586;
        Wed, 11 Dec 2024 11:57:46 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6c4bbb8absm472910285a.58.2024.12.11.11.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:57:46 -0800 (PST)
Date: Wed, 11 Dec 2024 14:57:45 -0500
Message-ID: <e24e5b0c4ea0c0ed3547d6bc4f34f4fa@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241211_1304/pstg-lib:20241211_1304/pstg-pwork:20241211_1304
From: Paul Moore <paul@paul-moore.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: <mic@digikod.net>, <selinux@vger.kernel.org>, <stephen.smalley.work@gmail.com>, <omosnace@redhat.com>, <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>, <yusongping@huawei.com>, <artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH RFC] selinux: Fix SCTP error inconsistency in  selinux_socket_bind()
References: <20241112145203.2053193-1-ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <20241112145203.2053193-1-ivanov.mikhail1@huawei-partners.com>

On Nov 12, 2024 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com> wrote:
> 
> Check sk->sk_protocol instead of security class to recognize SCTP socket.
> SCTP socket is initialized with SECCLASS_SOCKET class if policy does not
> support EXTSOCKCLASS capability. In this case bind(2) hook wrongfully
> return EAFNOSUPPORT instead of EINVAL.
> 
> The inconsistency was detected with help of Landlock tests:
> https://lore.kernel.org/all/b58680ca-81b2-7222-7287-0ac7f4227c3c@huawei-partners.com/
> 
> Fixes: 0f8db8cc73df ("selinux: add AF_UNSPEC and INADDR_ANY checks to selinux_socket_bind()")
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good to me, merged into selinux/dev, thanks!

--
paul-moore.com

