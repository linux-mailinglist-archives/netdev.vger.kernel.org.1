Return-Path: <netdev+bounces-129510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7E0984388
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36615282894
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D38C17A5AA;
	Tue, 24 Sep 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfUQtSvP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D3178370
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173249; cv=none; b=UVSTmlCvDksIMfTw45HJ7YHeNNgFKknpFxz/XEMYnA78wHyc7mYliQOGpreh+UOX0aNSkX0i5tqUlx9ygbBJVuBxtGZYkkb76u44Fpg+kC4vqmKB+l+IiJhCrKpbsExf7A9LOkjK67Q8R1Yvnrv4TcZNksLzR2ZYjz+szS3ZPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173249; c=relaxed/simple;
	bh=cZMktfwpKMy/jZFqHbDB6IPPRTqIFSjCmZOIoG1DTe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbQPP24StH3RUZKn03iWGmvn26o4ODL0PZgAL1ihlufbpfQUBjJI/rk7LLNqbQXbfbTxF2bM6GTySOYH+BT+cg7NzCY1AuQ+K15WvayPUWYcjlnvgUvr4u6O+8XrjClfiJP1dq+etR31YsoZxl2L5KzNSy9xytf/Fn4ANxlfYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfUQtSvP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727173246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGP+qBzp5YIh2+vU8jaw02F6pIrgJtrZ3R6SSohio/4=;
	b=ZfUQtSvPmjh4aZAIu+4M0ZdTU9LipZe3OSzU8l9rXSh53DxF0E0Vg/DfxB2fq07/Y7lFDh
	ikOfeRSVmmKaKkcqmaK9KcBC1XB3R5Tgxz1wXJ5PqVkCwXZag5uPDewJD6SJI16WQT8w6g
	ze1x+mQmjAOkUUfn5a/h2FnjIeQhhgo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-had1QwQ9PxO0rjGzjw9u3w-1; Tue, 24 Sep 2024 06:20:45 -0400
X-MC-Unique: had1QwQ9PxO0rjGzjw9u3w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374bb1e931cso2960550f8f.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 03:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727173244; x=1727778044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGP+qBzp5YIh2+vU8jaw02F6pIrgJtrZ3R6SSohio/4=;
        b=e7yNEQdL51YJK2silbs1wj7xPcvU2lvPXH2xcIXy082H5rIzagwDg99mHwW+1F8eng
         iJouLwQlPML21cLCyuvS7jyH9GlrJawEWmx+yxF8gW5L6X3bg8+C/F7jw4qnePldQQcR
         l/5OKlc6ruZgOaU3tgPMgV1gkib3upgd243urejo8ihB6Qh6AqAH+j0aA4cKZy5zAOjZ
         Kv7i6tRN0eXhzwp4qtrlwzz4gyUuj8/ZXcv9eHhiOUM4lGkFexzGlF/c5D+1w0uxA1lz
         qfGC1Xwcj/U+qNg2YinBLna6b/eLBxPJATQw5MJ+7XwOBdwh0V52HOapQzOjhuNxKzXo
         ccoA==
X-Gm-Message-State: AOJu0YxvXtMpGJoT4BWyO/ButdOjc6oh/zXyGmHw/H3XepKNIPvlwIsT
	DI63eg4wpzx6Agx4mnlj7q1eJ5ikVnBH71Ds40kz/+0sRX5vMbKTBxIxOxJJ4jDA1g9x/7xDDn8
	72zMjAzlViCVUWVLPgUYWIPA/59bkW4hd9yBgDV7rCottcskM/Xzlpw==
X-Received: by 2002:adf:f950:0:b0:374:cc89:174b with SMTP id ffacd0b85a97d-37c7eb999f3mr1485992f8f.4.1727173244395;
        Tue, 24 Sep 2024 03:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK0T5NfhyZYHiYDGJCXn8/4ZzrsjJgHASw3QcmuXmf6v0BqvMhuiyKu8gyWtFKxS9OMmD77A==
X-Received: by 2002:adf:f950:0:b0:374:cc89:174b with SMTP id ffacd0b85a97d-37c7eb999f3mr1485969f8f.4.1727173243987;
        Tue, 24 Sep 2024 03:20:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc31873csm1164742f8f.93.2024.09.24.03.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 03:20:43 -0700 (PDT)
Message-ID: <29ef00f0-57dc-4332-9569-e88868a85575@redhat.com>
Date: Tue, 24 Sep 2024 12:20:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] bonding: Fix unnecessary warnings and logs from
 bond_xdp_get_xmit_slave()
To: Jiwon Kim <jiwonaid0@gmail.com>, razor@blackwall.org, jv@jvosburgh.net,
 andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, joamaki@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
References: <20240918140602.18644-1-jiwonaid0@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240918140602.18644-1-jiwonaid0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/24 16:06, Jiwon Kim wrote:
> syzbot reported a WARNING in bond_xdp_get_xmit_slave. To reproduce
> this[1], one bond device (bond1) has xdpdrv, which increases
> bpf_master_redirect_enabled_key. Another bond device (bond0) which is
> unsupported by XDP but its slave (veth3) has xdpgeneric that returns
> XDP_TX. This triggers WARN_ON_ONCE() from the xdp_master_redirect().
> To reduce unnecessary warnings and improve log management, we need to
> delete the WARN_ON_ONCE() and add ratelimit to the netdev_err().
> 
> [1] Steps to reproduce:
>      # Needs tx_xdp with return XDP_TX;
>      ip l add veth0 type veth peer veth1
>      ip l add veth3 type veth peer veth4
>      ip l add bond0 type bond mode 6 # BOND_MODE_ALB, unsupported by XDP
>      ip l add bond1 type bond # BOND_MODE_ROUNDROBIN by default
>      ip l set veth0 master bond1
>      ip l set bond1 up
>      # Increases bpf_master_redirect_enabled_key
>      ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx
>      ip l set veth3 master bond0
>      ip l set bond0 up
>      ip l set veth4 up
>      # Triggers WARN_ON_ONCE() from the xdp_master_redirect()
>      ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx
> 
> Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>

Isn't the above issue completely addressed by explicitly checking for 
bond->prog in bond_xdp_get_xmit_slave()? Or would that broke some use-case?

Thanks,

Paolo


