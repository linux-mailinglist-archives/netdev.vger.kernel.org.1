Return-Path: <netdev+bounces-129180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BE897E23A
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 17:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462DB1F20FEF
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CF2C144;
	Sun, 22 Sep 2024 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2RWZ9A8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E81A95C
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727018035; cv=none; b=c9E2lfcKJbac+IDHAfGv510zSuAG+dHmuDY3xeVCxjqOsoY3hMIe/E3PwWh4LYO/hpQJkMXSmz1ZzpLj4HKOXq3uTewWWsQSlIDBCqYsBLKqOOUGhNQaHLCe6hxLe7R6jX43ZEQIbcSuA3jDXPOXcXQJkWt7sB/PziyGjyMyG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727018035; c=relaxed/simple;
	bh=DITuMDZ/je2j00C6gikU0EBY+BfjNP9apIvwpojVw7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk5ivRuP9tD8pIU54zJU4FjEwIaB9Uj5NFRML92S74epsP6HQ5scra2KRO2ZXVbZYXTPVY0DgkWfysF6P3npFrJrEGv6qIkwuer+81vLib00VZHYA6CPW4VEUtSKfssAPGcZCEL3VZHa4re9yWhgYXFR+akr+LgmruA13DHqzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2RWZ9A8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c5bc122315so732783a12.3
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727018032; x=1727622832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DITuMDZ/je2j00C6gikU0EBY+BfjNP9apIvwpojVw7o=;
        b=i2RWZ9A8ksABZGI4ZrudJKP1ugMXTai8CHWWDdxWbFdPUI8WjaTxn4k60MXWIIszBv
         ef4lCNPYLCJCydJSdcFGmMSrEpyIy2eyBMMiDK2QuywJpJhRk7AYUnVf5Q6Pl65HkXkP
         pm6j8pQaQBdK3M3Cp+tQmIoLiI4e9WDH2+02OM+C8DJdyCSgRvJpwlkR2Jyld8Q/XsE9
         e9DDCRVe+TuGOeugtLJCOeXwNjkPGMUs3xGN/Ximl9Y8r4wae0rod6F/ouk66byhUvf/
         IvOUNLc3DPYmPbXiqHaf3Ih1I6BVEyjhPY300ZrE7SHqXWzllCzHiQQndDmK7NwnyXEO
         0A/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727018032; x=1727622832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DITuMDZ/je2j00C6gikU0EBY+BfjNP9apIvwpojVw7o=;
        b=YVXsB3RpSZ0ATRPpEeV2p0Bqv7rp7BEvcvSQDfdI04/RiK8pYKbo9bTnDEY4Gao/7a
         en59euXOmpQ9lINHGaJkx9flP4t54QT0vW0A75gy9BtFgbFCEh6xJDiyVcgwUYlV/1VX
         NbffooQ0Ag1oVCFb4Ki/+PJKu+4C5fpvYNtXL7U0qCCVVJM/Zh1NrHR2N7EZJUETanFZ
         o+R+rcqzG//yEnbXcqsCo67NgtjR0mH4bw8Dr3xWX+NvWdzznuUZKzXqu3nvcklDlTGJ
         e71wpQOCG9rBtuB0xZYljnMPbYv3aUT7vHn+bXh4O5Ztin/PLGKrZzMRCyZVSqJhk9Qr
         UWBw==
X-Forwarded-Encrypted: i=1; AJvYcCXTSokpnQaw0+SAuihmGwBvirB1ThtzweuCE2lQieWTbaPr6CLtpohADZxnNUcbZCsMzLTgbEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrx1QgfB0RuEX8JQzP0VHGXGQzhH37/AlKded+OYGypHEOa1kH
	Eezl0pdw1aIecqNMVl3YajA8P2GpCQfdM19R15Mp5yZH+KD5dGBom4rmY+rU4IM6mCl+ZGAggy+
	ckfJg2gLAzBX/i5B5edsczUkWdun3H9xZ6JLC
X-Google-Smtp-Source: AGHT+IFO1Mw95Td1RElq1v3vq3/nV8brRo0pqFdb8Cva1USzZhkv5rOQbsNWpaRtP79wO8Eyt6TbthYA0/Kagg5IUOo=
X-Received: by 2002:a05:6402:27d1:b0:5c4:9e2:a21d with SMTP id
 4fb4d7f45d1cf-5c464a3e4eamr6433238a12.12.1727018032149; Sun, 22 Sep 2024
 08:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922150746.185408-1-wangtaowt166@163.com>
In-Reply-To: <20240922150746.185408-1-wangtaowt166@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 22 Sep 2024 17:13:39 +0200
Message-ID: <CANn89i+xbEwk4u3jzO42B-583uD1NiC39k+foteHr6pT5vtzMA@mail.gmail.com>
Subject: Re: [PATCH] netdev: support netdev_budget for napi thread poll
To: tao <wangtaowt166@163.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	bigeasy@linutronix.de, lorenzo@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 5:08=E2=80=AFPM tao <wangtaowt166@163.com> wrote:
>
> For napi thread poll, we expect the net.core.netdev_budget to be availabl=
e.
>
> In the loop, poll as many packets as possible to netdev_budget
>

We do not 'expect' net.core.netdev_budget to be available, we have
better cond_resched() calls.

Please provide reasoning, and keep in mind net-next is currently closed.

