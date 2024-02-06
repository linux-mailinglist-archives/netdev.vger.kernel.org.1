Return-Path: <netdev+bounces-69573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC3184BB63
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52211B29FD7
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CEF17C9;
	Tue,  6 Feb 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcNHPe98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D66FB8
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238269; cv=none; b=bf4gaJI6MqTieB3wViwWyjNUFGzJSb2zrBN0GZ7xYw4plqhK7+aJA55hca8gXFqAXUJPmWvumhDhvbB400Cqjf4BdtUfaL+oqT+d/1pLn6LID1sRNP+bzGyft3B5Z2viI2VnIGlb1O3flpi/fqFIEji58+eobIJSNKbD3E65KLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238269; c=relaxed/simple;
	bh=8FdDaVqX6JXQ471u74PFoUoq11r3Q9AVs8SCn3bvnV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7qUh/VotsqgvicysdbM7Peata55/Pk2VWmuWzOj1ete9Fi1+hQA1lNflvhnvxlWOfN7pf+F8+W7rbrLJ7EOCQXGDcjA7Azb0rAs3BT4f1SOSV6gr12UmOVpT9JA8ZkNun0dK6Kdf351rPUp9rCGJrl6KSIEEvdZ2YfVF4AYIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcNHPe98; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so12244a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 08:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707238262; x=1707843062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FdDaVqX6JXQ471u74PFoUoq11r3Q9AVs8SCn3bvnV8=;
        b=HcNHPe98sduBvz+SKv15elEV4B23UtqvkH/RiZgcSsPj/AcS5OoutcdN3RaFEUpo2K
         T5JQtAsdzjWZUvt5dkRn7XCwZ9wQ4Yhh1WB3xOiBtjoOUFN47EJQJyjdn7t67wTtaB2J
         bdn6UDAewiEJahDQPP1piQF8a5WmqDHgE1zM87MadDjVo9QrFLWGZHOd95353O+Esk41
         YQybVZva+lPmd5LG4Rzd3G70rbOOfkK21FWr7D68m2TmitGH2/n4pLY4QlBUju2dxJp5
         eWWZ+yS4mtyZW8D96xrWE88cwbTBK9jc9DFVLPkz0HPPNkhCANgh+jJEjlplrFiDmo/D
         IUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707238262; x=1707843062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FdDaVqX6JXQ471u74PFoUoq11r3Q9AVs8SCn3bvnV8=;
        b=oOzu5n+XrKNglqM1e0yeW8acbpEza+4Fv/+rLwrmJJUK22CY2bfoHKfWYqeYWYhBFM
         KA4h+rT/DPTki3xxnnFcqaDXaCI/16VyINYNK2n/RaIhk388qyppShVgQ4gkot3i87vK
         KnKrmATxuNz4+bhyWJrQaHX6iEeD1ugZVUzq0du0QAKAFf3ied0NADt/V8KEMrPWZf09
         ZoDtpulXREJ9CAWBpIOMo4gBwVIZladlVhYlKOW0Yddm+YCduvZinIwdHm9KxULoUYZ6
         qzD63eZvAa2ZTdiQGNTt0z8l+upehOjM3qlRRlM4c8Pn0XZmRoTX3gew00EgVWkCC2JR
         fXqQ==
X-Gm-Message-State: AOJu0YyYGBBKT6doEQjRGFiVBCRIkP8HOAh/N+d+rRtjS6cEd2F4cOBO
	KVtJExjVSEvculoNWJ00t+eox/CP5aMpbY/+LaNN6O9pMrYtXR1YPr5DlS7TbfsYaKNidxCqMzb
	mHl9Scc0RRbke8bf+gqWkPEtbSo/EJYyRh5FA
X-Google-Smtp-Source: AGHT+IGHO5RME9k0gNMoSkVAGJF/9iWfjkqGikShoKNT1rU/RTQBQqM9tA61jrgvnW1cjib/1M4iftje1+YgYmJRszU=
X-Received: by 2002:a50:cc81:0:b0:55f:8851:d03b with SMTP id
 q1-20020a50cc81000000b0055f8851d03bmr176184edi.5.1707238261538; Tue, 06 Feb
 2024 08:51:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com> <20240206144313.2050392-3-edumazet@google.com>
In-Reply-To: <20240206144313.2050392-3-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Feb 2024 17:50:47 +0100
Message-ID: <CANn89i+tP20g2YSb-9rELT3s4Kz+ODOGTsbKf9eYH0JkzFcYSQ@mail.gmail.com>
Subject: Re: [PATCH net] ppp_async: limit MRU to 64K
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+c5da1f087c9e4ec6c933@syzkaller.appspotmail.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:43=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> syzbot triggered a warning [1] in __alloc_pages():
>
> WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)
>
> Willem fixed a similar issue in commit c0a2a1b0d631 ("ppp: limit MRU to 6=
4K")
>
> Adopt the same sanity check for ppp_async_ioctl(PPPIOCSMRU)
>

Oops, sorry for the duplicate.

