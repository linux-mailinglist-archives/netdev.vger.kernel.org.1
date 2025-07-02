Return-Path: <netdev+bounces-203246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8F5AF0EB3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29ADF178B31
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9839123D2B5;
	Wed,  2 Jul 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6fk/H7g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D123ED56
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446910; cv=none; b=PvhxMP9OkmBZ7xMZQw5U7d5RmiEyzW4xCl152S0LImSJovjZIlzLL0XzI2qMOyjIXIw5YcRoaIxsKufDQ2z346E+yGJgHsP7zja0XIK9TDoetsz8jtIVNoDaGeqppDDg/qfleH0rpR9QIbOn7qbm3BOiB1dwPYT7vusKro4tsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446910; c=relaxed/simple;
	bh=rT/1yTCUYgsKJSyTh5ACsF+g/jBCPapT4DPjXtyBeC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P5pC7GviE2qFpJ+b5pomq8HjBTudSQ6rtkzSETxWHoHHo0e/YgTxQVxnNaVPIiUGB70Ki0vAKCZ1WsaXqfQqDElCUEwW54cV4PJ9JQQqpMFvaulhLrmWasbf8rwY0fqAdqtC8wcGUwhVbhS7JInVONyNo4/JUf8Tqwl/nkucB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6fk/H7g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751446903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rT/1yTCUYgsKJSyTh5ACsF+g/jBCPapT4DPjXtyBeC8=;
	b=b6fk/H7gtm8IyYp9H6svKea+cpFQ1Sk7G44ya6qv1MaM6TQLOp/DJec4d+yCZMKftAl6Lk
	XX/ZKvvRQtJYdNpH4EUokdx0YNNNTsqf/LRyPhSjs7F6WCDcBZww7IlKUBXlSSy5l2G+QQ
	Vgxbivo6EVdM5U0qzzzRuTtkIPmqR+E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-bsadKT4YOPKgaph3G6vc1Q-1; Wed, 02 Jul 2025 05:01:42 -0400
X-MC-Unique: bsadKT4YOPKgaph3G6vc1Q-1
X-Mimecast-MFC-AGG-ID: bsadKT4YOPKgaph3G6vc1Q_1751446901
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5551093dd58so2544569e87.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 02:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751446901; x=1752051701;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT/1yTCUYgsKJSyTh5ACsF+g/jBCPapT4DPjXtyBeC8=;
        b=C9igaTWY5PxwxA7bZ4uiyw3oj/LA+oRmiFumcpHIzquoeKkPNs6ooyYX4P9LIdZdjg
         SqQCsJN0L4mLrfXLjdyadmjtko9NlObGwUFcjRbkBBwkwNNCRPokxqp1VStSqCLYzJDH
         Usyh6t9ZNTXwwjqsX1enpQ11QyEk8SbmgT3xgeDMl5itGMHlnf5krYDIvs5jGbmJxbpd
         L27Rt9vE0FfmSe864+Cp9c+UvyMblbfk5nHFGfsoLGI9N0dLxgKhkMzM70Fo8emkcXEI
         HbzEd+9k/Hqa7m0lcWSYmGyfOHRqEDEwCwmVR4oHJM2UiwopZIJZMlts0BFPPhd6ecba
         R6HA==
X-Forwarded-Encrypted: i=1; AJvYcCXEbxVacg+5HKZ2b+qTFnt2hy/OO/51RircfSZkNNPL0HY1BFBbbBEOu0UL5LBDrJvkkdL4lGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQw+fQ+z07o6ii5Z/ZFQM9/LNVVgYySB0O8L2ZxYC8jlkCSZI
	jvCmvOf2caKOzWmrUaSFrvlW7v2s1oUlM27aE0JEHwC8XwAQqcKWFFBOiltrnL8/uKMJSYScP9J
	NKn5J0tTTLmErdVwAXzLWXG6c+u29z318s4NXhXowAWgT934Zg+jMNikBNA==
X-Gm-Gg: ASbGncvjNfMJv3h8znqPnFbsH8Ed8rC/JLEfBk1Jz691Xv5Paq+5cq80mDVmxLeyxox
	4o0899IwW0SJ+O4WRFh5OWrRUKMCVnCRuutnCVTQ/Wt1E0hwXU6vjCc6xsS18YQK7c+WZJaHQzW
	QxxpZu/WLY5RVBmJ8CJstzUNHvGseFoa6E/SsbV6vsJLV2djmiTR4hEjFeJXNmtkMzzg39kg1Ba
	tQzONQIKb5fYKCFzzoQEZQGwymPmE4xnlJDlKFkxa+d2aaK+aINtrAhPN0ALauTQh/HGLWWO/n2
	4SFt+WWhGFnvI/8C7qs=
X-Received: by 2002:a05:6512:2245:b0:553:addb:ef5c with SMTP id 2adb3069b0e04-55628372cfamr635089e87.54.1751446901062;
        Wed, 02 Jul 2025 02:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4L3Lr7zlS5Q7UNzNUPT3l26X2dNCoG8GtYzZzEmFsARCZIaKREcNHDzAIVt/eK0EazCxBZw==
X-Received: by 2002:a05:6512:2245:b0:553:addb:ef5c with SMTP id 2adb3069b0e04-55628372cfamr635048e87.54.1751446900110;
        Wed, 02 Jul 2025 02:01:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b24046csm2071324e87.20.2025.07.02.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:01:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C45C61B3803C; Wed, 02 Jul 2025 11:01:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2] Documentation: xsk: correct the obsolete
 references and examples
In-Reply-To: <20250702075811.15048-1-kerneljasonxing@gmail.com>
References: <20250702075811.15048-1-kerneljasonxing@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 02 Jul 2025 11:01:37 +0200
Message-ID: <87plejezke.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing <kerneljasonxing@gmail.com> writes:

> From: Jason Xing <kernelxing@tencent.com>
>
> The modified lines are mainly related to the following commits[1][2]
> which remove those tests and examples. Since samples/bpf has been
> deprecated, we can refer to more examples that are easily searched
> in the various xdp-projects, like the following link:
> https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example
>
> [1]
> commit f36600634282 ("libbpf: move xsk.{c,h} into selftests/bpf")
> [2]
> commit cfb5a2dbf141 ("bpf, samples: Remove AF_XDP samples")
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


I'll make sure to update the document should we ever decide to move the
example code :)

-Toke


