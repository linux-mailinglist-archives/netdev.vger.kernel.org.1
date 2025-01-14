Return-Path: <netdev+bounces-158101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B22A10766
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B847A1887855
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF9E234D0C;
	Tue, 14 Jan 2025 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3l6V1Ovv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D203229633
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860184; cv=none; b=LxMiNWRAP6Yiy1sZvN/qIjsbDkkDzBkf0W/bWj0luGAkbK8/xGt0Hp2BGxjO1C/tmYVVuDsJ/MZEzNmcHryVOyc0XiaMeKVezWE0wiSoZ6myjdxF4URWj2PeDTMds6A3D41YK198ElCZZ838Ii5Da3FZ9deYz0rvX2RZr6pGJkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860184; c=relaxed/simple;
	bh=cu58+RHbxEX23RbLY1FEFDqsVZtzN5meujD4rAyPyrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWWgPqCvPnYvFBY1qmu28gc2owjNPhep4TVYyKgoK+u7GVtJjabmpw/1e9q3uHlwhdtgQr2mpbkmEQ5FkMHWbCP5eQyRKpe6w5VmiQhKgt4DzMQj4ibzjNo+vcLdCoUIcPg5BQDUTbQjRrebic8TOK/QCA7yD/0FHoPMiQQeAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3l6V1Ovv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso3108105a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736860181; x=1737464981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu58+RHbxEX23RbLY1FEFDqsVZtzN5meujD4rAyPyrk=;
        b=3l6V1Ovv5DGmHtTnGzjGF9JwD+P9gtyF9rEx4cQkg2a+4hQEBfa6D808/c8IlIPe+k
         3FnjchKYaIe+9R+AgUWNsl7cObMULc9w7WEzytFdn/BdwL05v+0Oyu5Qf0h3OgFYMA1H
         dHPbCQf7QDt9I/hxhUayyTPWKiZmHH+ucr5anwVGcp61oEqp/q3jUUSI7P2STjMFNSMJ
         VuwIgc8eHIQrer89in2FdetcEyIorUVh47wDTGIwJcvACQEyT7hedTpmrETmJhQ31o5J
         CNLtnY6/IPIF/kR+lCzv1sKp8TGB8QDhULMmq7LzUkuLrN8kqlofm3zyumD5obFeCH8J
         Ay/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736860181; x=1737464981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu58+RHbxEX23RbLY1FEFDqsVZtzN5meujD4rAyPyrk=;
        b=ISZOhWi/3NmNtUQXqbLsezXiFFdGO6e7DlU4HUVfjyBa3Bxm4fBE3oe2AjAf+ev4mo
         MsqShEDYW/m/Z/Y7c0K0YOvPq2MJcOvCLv4K/MKiHjfiUScgSQhDUOiF1bkOZgJMda9L
         cz51t5jP5zqXEsp9JgKa614MVBzdHEOzdbg4OenShoG+Zgqc56Kuz/i6lvIPlQdPNDh8
         K07NnSKaey0+iZSg93O7MQCstzO1gATvjFM52mkH6EqHf7ZqySkjbIm6JQ8PF16TEsch
         skSZC5qZqcYFgbNP4KSRC9nTVOww6WNJeYnJUDxICCa/5Em0JIDJF00uxCunIEJ8XR7K
         LZjg==
X-Forwarded-Encrypted: i=1; AJvYcCXKu0QxiZ5HhSvauSSiXeF6zPjp6+V0qbYU4l2DL4mUdPVjbpCCC/+FlzhPAMRCF4NBi29YlKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvjL4st3571+wAGB8rrWRnMTLUQueqSBP0JKOXp99qLmxLfmAM
	2oyU5g3SM72d7nopUgMcuQesm4mWAN0PKkibRUhdEkwNCuP/GEyUHpHqGDI8HZXlyrn229YXgxC
	0Vzoa49qg0wDp8raAvF30Opi3eMWfNp1c/Bil
X-Gm-Gg: ASbGncsA7BFmnjiE9AzUgqIjzcllwPqtpxKEKOpN5uPj68jKX/Om+SVDON+x7H9rvbe
	70bjmRZiJr6t1NMtXc1TpRRYuyypD8LrYGEa4Yw==
X-Google-Smtp-Source: AGHT+IF/5HIrScN4UZ75K5L087qv5LAtvcoYT5uz2Qi7EVOftASnEneciMKqKHFHzzx73hVuCpTHDQCKmoJy5OLj9O4=
X-Received: by 2002:a05:6402:2749:b0:5d4:1c66:d783 with SMTP id
 4fb4d7f45d1cf-5d989b0c9b9mr18435900a12.0.1736860181308; Tue, 14 Jan 2025
 05:09:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114035118.110297-1-kuba@kernel.org> <20250114035118.110297-6-kuba@kernel.org>
In-Reply-To: <20250114035118.110297-6-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 14:09:30 +0100
X-Gm-Features: AbW1kvbujRh8itwbX1KtNjV2PI0fF3I82ELX2qwLeBmrsKok_rHAFFNi_lp9FEI
Message-ID: <CANn89iKwUjgU+OiNtvZjH6eLzhR0rqV-64owvy3UJ9F1tfEM-g@mail.gmail.com>
Subject: Re: [PATCH net-next 05/11] net: protect netdev->napi_list with netdev_lock()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Hold netdev->lock when NAPIs are getting added or removed.
> This will allow safe access to NAPI instances of a net_device
> without rtnl_lock.
>
> Create a family of helpers which assume the lock is already taken.
> Switch iavf to them, as it makes extensive use of netdev->lock,
> already.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

