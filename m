Return-Path: <netdev+bounces-137925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD299AB220
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02621C22731
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A70148314;
	Tue, 22 Oct 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsaYfPUm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDCB13D899
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611039; cv=none; b=LT2BM6PHvEoldPIEu9MQ7fCojoxsejbgC8z5bgpM0ZEW49SqU6LHogsVv7DiJFx+Ncm6xfue2XOkZqqzZzKfe4kl6kiuYq5iUyt/RFRwwaWgJCduDcZCfwuLduqM+OBN0rvPV+U2ilk1qojKcOISsWZNOUfvWdaL2zwctx5n5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611039; c=relaxed/simple;
	bh=aeNB2y0zQoaicGC/OFWTx8R6AjoXO4apTD26syH9b1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7TZZhbBS3OwK7J+EC8WZScFEZqaezhPiC4JQbAWOw6yEE8w40IqttAIV+/6e7i0EJ5/ecsl26ZshqISyHUqKCx9pncc/i7GuXxJngBXiXdoWGMrAKgIATgqG15ejbUkzuEP2RhHypQdNHmJ/ggdmnfB7D+ZkgyJeP5cFj2CRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VsaYfPUm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729611037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeNB2y0zQoaicGC/OFWTx8R6AjoXO4apTD26syH9b1c=;
	b=VsaYfPUmHV+kUK/5TNgha1YXjtBbmg7467SOY6ryRovBr8Ug/dFE8QSc8htusmdw/PgBw8
	Y0Gvs3GbyP+UYvGCcIO8ZCUmveNP87ruotGIbnl+8f/meBJgyQf8nYM+xUtnw8lEhF8l5E
	8UgYbr4FreqMBmPdnB5sUyEBB/X51Kg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-nEyi4yIkN1CT5lR6qjY2Ag-1; Tue, 22 Oct 2024 11:30:35 -0400
X-MC-Unique: nEyi4yIkN1CT5lR6qjY2Ag-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5a3afa84so3052100f8f.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729611034; x=1730215834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeNB2y0zQoaicGC/OFWTx8R6AjoXO4apTD26syH9b1c=;
        b=wnHZDOSxIl/HEFlhywf/pGjSQrIvrJfJYnzjsEkl3CwFC6DjHC74w0Z/rWqMJA8U3a
         3mSoLYnP+UECKE4kvNmJOrevA3YPiTBrnFfb+PkyWPie1+1begvdOEv2zG42OtBXcQ9G
         4ZZ8x14weVnbbCj/oF4ns/Y5lJiPo63R1D1syW54wd0h/y1+3Z7+lxIDfpgplLyLzh1T
         Fm8kZEMArTe2R6pAgmE7kFkohBEPaTiIRJDsDVJJHFmDxC1fMVFwNXaj32JbD4UeDEBj
         obQu0C52mtUsr3nPK6H+DApiTz8hm26hvGb1WkPUVH6aqPFYXPY0+hLv/ypIzcsIISXy
         Gotw==
X-Forwarded-Encrypted: i=1; AJvYcCXgHPB0OutkoHuYUeIt4l5MBteBhWtIYLvBIMgaKDUSG8Li3uKZxNqV5MJN/PXANouoZd+48nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7ohsW/mZxxUYWjxo9o9u945vUq5DAoJt2gWMKmLddlFsuHM6
	jLgkKxjObhVmZrk2R+Rb5KLODgxpUEEjeKsYJalJaOC5Nt7wDUK5LF+gu0z/bPH52yhisYmQGtj
	6g3XzhGXQOuv809xpAlD3SnVVO/nR+sq+Wr7QYBez+1c0CvtoQyKZgg==
X-Received: by 2002:a5d:58d2:0:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-37ea21370eamr10229403f8f.9.1729611034099;
        Tue, 22 Oct 2024 08:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0zz73eNEgDwtK6KpTgteNC4JY1ou4UN+CqrAjVjAKfCV29EIzHazgxXKj9Qr93aNf7MnbxA==
X-Received: by 2002:a5d:58d2:0:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-37ea21370eamr10229386f8f.9.1729611033728;
        Tue, 22 Oct 2024 08:30:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a488edsm6862221f8f.31.2024.10.22.08.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:30:33 -0700 (PDT)
Message-ID: <0b779b4d-d2d3-499e-abf9-4eae4806316b@redhat.com>
Date: Tue, 22 Oct 2024 17:30:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN
 infoleak
To: Daniel Yang <danielyangkang@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <bpf@vger.kernel.org>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
References: <20241019071149.81696-1-danielyangkang@gmail.com>
 <c7d0503b-e20d-4a6d-aecf-2bd7e1c7a450@linux.dev>
 <CAGiJo8R2PhpOitTjdqZ-jbng0Yg=Lxu6L+6FkYuUC1M_d10U2Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGiJo8R2PhpOitTjdqZ-jbng0Yg=Lxu6L+6FkYuUC1M_d10U2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 03:37, Daniel Yang wrote:
> Are there any possible unexpected issues that can be caused by this?

This patch is apparently the cause of BPF self-tests failures:

test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
[redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingress
[redirect_ingress]: actual -34 != expected 0
test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress
[redirect_egress] 0 nsec
test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
[redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
[redirect_egress]: actual -34 != expected 1

Before submitting an eventual next revision, please very that BPF
self-tests are happy.

Thanks,

Paolo


