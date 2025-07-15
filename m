Return-Path: <netdev+bounces-207148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2156EB05FCD
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B18E97B7751
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527492EAD16;
	Tue, 15 Jul 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTZQQfjL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F032DEA96
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587561; cv=none; b=B5ZdfkfEDSDFUr7JhOqUkO+WmvPdsVRmoO6CI7JtZIwB4D5a3BoPwJEy4p9GOhBwFSca850RkmjCB5+YFLioPnFGlOc8A3W9E1RZHZRquxq3bHEzwbggp9pE8tAPnyMmfBLQh4vfliSIkdFYRNZMZwgV3+QzQ0Jp8yN1lJ+d58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587561; c=relaxed/simple;
	bh=P3JIZ5qbOTadZLc5BjAibIZW/NsLfqXM4FTTczMP2Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A60xQT7BY486ZMJnuA+SRJF1Fv3Q1GnGat24MmeYtKGgbo22KouRzA245o9+KQ+vcl9sdrc80Nkg/BTDcXVg0zQ0E+jV7YoDhoEawZH8KjZ/yaSdd6RGrKIWtcWO9vg92oD75eianl+Hua0++2zzX0RRrC9mBH+2pi71YBv5s4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTZQQfjL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752587558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rml4NgE58c+dYY1M8tZptltYMyOZ4J8CLbr7zfgbjTk=;
	b=eTZQQfjLVQ1fQwYlrxTM9w3woJBAfm28+0tbVqLuKaweOfVSgDLOs7CyZKvlGrT+0D58xY
	FFRb2PiI2Xk//XCE2ruvdZCbhAC3UixcW3PWPIaPIm6LeteFWQIbh4HlTPJ8lTcNV0xaf0
	i8cK0BjD4BjELuMVYUSaxDpja2bbtz8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Niq6iKETMK-B_mQGlE0hpg-1; Tue, 15 Jul 2025 09:52:36 -0400
X-MC-Unique: Niq6iKETMK-B_mQGlE0hpg-1
X-Mimecast-MFC-AGG-ID: Niq6iKETMK-B_mQGlE0hpg_1752587556
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a503f28b09so3460237f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 06:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587556; x=1753192356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rml4NgE58c+dYY1M8tZptltYMyOZ4J8CLbr7zfgbjTk=;
        b=Flw5HSDoAufQpSvUVadp2uZkYlJCzm/istr/VlwZvB00V23PHOeT//NJhOseugGhrF
         zj3TMqALRCpGgvax0+RQciSP7DnaXT8n98GJOyF0BNrz2X+ke3g0Zas3IypJHCojijY/
         xNA9+UtTX3f1zcLnP2n7J1xHgbZOvGoDZi+0hfgttzmbdkOa1LqQoJ/I/s9z5f7LYJ/E
         ZPwU1lCIk0mAasmW80KRq9gD0cM/NKju8DYAivgrLsTab35Fryq4d6BZiHi08Wa6BCZa
         V13y+7nJz6BDq7ZQSEhIDjCD2e/ccpl7vC+sIgSN7LdU2GLJPHRn24wtGUpXUVfwi8eu
         Cc5A==
X-Forwarded-Encrypted: i=1; AJvYcCVi5NBVtMgVvQlYKjxTcX9TQ7jIz9s2zML8d+8K9EzC5tsLwN86oKf8N1znU8riTJZgxmQHuXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97NQM51vxYfiBD0GQQviPmb1U2HtLaK8ZC8RbrNTUzN/sdPRQ
	52FsYOzXYHfcBgjJ05KhXMcFj78rQ28YCQoFanj1zhJ009XvBcsF3xUPwDYi2w/W9D1h3DLgW8C
	Ui+ArHABJzh3GEoxFYseXT6HCKzxxVz50XwUrEseR+mtQZCcJPHtUUuY4Tg==
X-Gm-Gg: ASbGncuQGrOXzh6pq+nq5s8BMtkON/ftZGxz3zztP/XeG+l/K5Z+ZuoVk0mqNmm78lv
	dGCiwh1bN0yegnaGWYzc+dyCVpIq/Ux7Z5Ww5ICpHEZdStuFE+h2K7gZXIKt8Njs5qX3sBxt/nb
	7rf0KEJ2Eq05KQ8E/fp4/rKAFCQAPjzbB+sfegOW2/K/kx6mab151PBM3KxJvtkB3CqCGbkMb49
	+IUuqK88+LUqO3wK1VYUnhX/9Ta+RDLQhM95YwZmYUIhfKDk91MUdI7ysIylAIgdexSZmvESCx7
	K2eRpFMtrd406QGwD0QkUxQvr6BY6pLKYlBv9a0LXuL2Vz+z+VDcuTzfALJ0mK4LGf1vbdf/zRM
	RqvNfluvxT9U=
X-Received: by 2002:a05:6000:2307:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3b6095201d8mr2559663f8f.5.1752587555545;
        Tue, 15 Jul 2025 06:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF75t4n2E3Vf1XlrJFeJe1fltesaxAiRtA/Gswri/7RKaxH2M76UxWmZ1MMHayzOZL/im4SbQ==
X-Received: by 2002:a05:6000:2307:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3b6095201d8mr2559640f8f.5.1752587555084;
        Tue, 15 Jul 2025 06:52:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45614aeba29sm76977055e9.11.2025.07.15.06.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:52:34 -0700 (PDT)
Message-ID: <9fb159c3-0151-49ac-91bf-1be8301bdf18@redhat.com>
Date: Tue, 15 Jul 2025 15:52:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] tcp: receiver changes
To: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, "David S . Miller" <davem@davemloft.net>
References: <20250711114006.480026-1-edumazet@google.com>
 <a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.com>
 <d0fea525-5488-48b7-9f88-f6892b5954bf@kernel.org>
 <6a599379-1eb5-41c2-84fc-eb6fde36d3ba@redhat.com>
 <20250715062829.0408857d@kernel.org> <20250715063314.43a993f9@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250715063314.43a993f9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 3:33 PM, Jakub Kicinski wrote:
> On Tue, 15 Jul 2025 06:28:29 -0700 Jakub Kicinski wrote:
>> # (null):17: error handling packet: timing error: expected outbound packet at 0.074144 sec but happened at -1752585909.757339 sec; tolerance 0.004000 sec
>> # script packet:  0.074144 S. 0:0(0) ack 1 <mss 1460,nop,wscale 0>
>> # actual packet: -1752585909.757339 S.0 0:0(0) ack 1 <mss 1460,nop,wscale 0>
> 
> This is definitely compiler related, I rebuilt with clang and the build
> error goes away. Now I get a more sane failure:
> 
> # tcp_rcv_big_endseq.pkt:41: error handling packet: timing error: expected outbound packet at 1.230105 sec but happened at 1.190101 sec; tolerance 0.005046 sec
> # script packet:  1.230105 . 1:1(0) ack 54001 win 0 
> # actual packet:  1.190101 . 1:1(0) ack 54001 win 0 
> 
> $ gcc --version
> gcc (GCC) 15.1.1 20250521 (Red Hat 15.1.1-2)
> 
> I don't understand why the ack is supposed to be delayed, should we
> just do this? (I think Eric is OOO, FWIW)
> 
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
> index 7e170b94fd36..3848b419e68c 100644
> --- a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
> +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
> @@ -38,7 +38,7 @@
>  
>  // If queue is empty, accept a packet even if its end_seq is above wup + rcv_wnd
>    +0 < P. 4001:54001(50000) ack 1 win 257
> -  +.040 > .  1:1(0) ack 54001 win 0
> +  +0 > .  1:1(0) ack 54001 win 0
>  
>  // Check LINUX_MIB_BEYOND_WINDOW has been incremented 3 times.
>  +0 `nstat | grep TcpExtBeyondWindow | grep -q " 3 "`

The above looks sane to me, but I Neal or Willem ack would be appreciated.

/P





