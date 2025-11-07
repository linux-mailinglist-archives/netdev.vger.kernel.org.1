Return-Path: <netdev+bounces-236766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBAFC3FB98
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86F404E7E79
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36C7322C67;
	Fri,  7 Nov 2025 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdgCWylW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifl3APrA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2039F321437
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514648; cv=none; b=YFNFFSe20E+uk2QIBu0ADZkh6VODkr0TbKDjaQAAW/sOt/ax66jxUBYUgjagcvLZg+zk47LsCX4JQPiK7LPCWHl0Hd7b1upla7wXDDCSsvqKj4FurS+SjYtjdPMU4bJ5Jbzjt1WqKe7y82pB6C6kuc9UBPB+wlgLAIKEKFNapb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514648; c=relaxed/simple;
	bh=jgEKF4JVAz5aeZZWTFE0J+YyRg4UZsglaqLpKtXX0ws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bHwPqSlwL0z14BZy5WeTr/A5D1ZtPcrPTpN3+FzOn4jpu1QAOPhwG1/+EeLrMokdNHXan40lpQ5e+ryOZnA3Vcmq3sQcp6Qb/GYTMktRUA21yRxm/DgTBRmquw7ft7ZWuUTnPv9PPW9JR3DpKf20KFksnpxdOpDhx92c2WVdhSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdgCWylW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifl3APrA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762514645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgEKF4JVAz5aeZZWTFE0J+YyRg4UZsglaqLpKtXX0ws=;
	b=YdgCWylWPTWpfIi5OU8Ud6OagJfnauEHCsJU7zZmd6ICUEu7vAl06ohoawZWuR/SYo1wuB
	r3bebcfX/GbQdZRbqojM8RpJkYrMUZPlCI1otOKiokM9PjIOOBbpz3ikeolYoC7IZXYD4X
	mpB+KwHoFJzXIPxlGXLEWURVJkzPaEw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-4oSvqvt_M5GLxiBxbOowpA-1; Fri, 07 Nov 2025 06:24:01 -0500
X-MC-Unique: 4oSvqvt_M5GLxiBxbOowpA-1
X-Mimecast-MFC-AGG-ID: 4oSvqvt_M5GLxiBxbOowpA_1762514641
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b71043a0e4fso64926866b.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 03:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762514640; x=1763119440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgEKF4JVAz5aeZZWTFE0J+YyRg4UZsglaqLpKtXX0ws=;
        b=ifl3APrADHM6TRE1Faq8Nvx55wr5B2zxB20+r+xEQ0gB2x09SsgR5WkX4ztBQU6ByW
         7YDVgTPotJEBcHtpILUGxiZHjp5vMRqODuO7ZFXy4S7LCdo8VFbqNNDq7+8U+Jow5N5E
         KApbopdBq2Mu0HHA0lP2ZIL3tGcoqMa/wXAcqOGRLt7m4UPUyNOai93cIpCE8k/uXePk
         UbpltHh46FRrzSe/4ZcpR1r9TDjmjuwhHg+EfkHAQdLygJeEUBM61gY8NMI6S4cB/IGv
         4g4aGsyctwohZUz4ZEnUtgM6HW9SV5dYckmMtNsGoEIxtVQRzdtn0/jW1oqTHd1jpzPp
         eaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514640; x=1763119440;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jgEKF4JVAz5aeZZWTFE0J+YyRg4UZsglaqLpKtXX0ws=;
        b=tE88c2ZqREjqE9H3PI0f7PkJtIUE1N1eERSZhkjosPWrLcyuKG+DbleBpORCtyeyzc
         WmKskLnN3IGhHAXTB3Pm4BEIjgjNgbtGAKHX4SC4UxclUVNNVHCL/jQJJ2S7Kwqnngw3
         zcdK2hZhBVibyv8Jju42Nr/LUhLqv2PrNy2uYarXLn9PHg7fHmE6slJHsj3UQpc8X1CX
         8SZFRV7yyqK1HT8S6mh8Z/pWnSp1GLZsJR35HoPsCBqHB8N3OtA7YlSOVA3UNogNg49X
         uHZE0Et+8m4jzmjzBUpl6zW9t5iS6CCMI8m/BOr9nWom7NEx5wYGVl029MpLr1sSoPbc
         90pA==
X-Forwarded-Encrypted: i=1; AJvYcCUw8pCZ9wNKscAfilDiC1OcyhcuARzbCYCSKdDQ6lXi2JGZyiv5B4ZnZO7+uAUHFVqu7tbCQak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFoG9+mgI3pEkRoNDw+zaYDsjP/NKc3j4tWH8vl0sird3eA48M
	M29LRZhhykHQHb6W/SIpsvZ0RT5WrgFxs8Rqo4QGKaw0Iwl7fT3uRkdBCWTNTFJZEFNuGL8UAam
	bXGXii2ikVtv2/Qu61mIJu26xRYLxmZo9tTnrz5w4+FWFLnTnaXbhYycOow==
X-Gm-Gg: ASbGncubaf1JvGlLoAN75GyyodY583uHzWZqIHuHexSm5yh6gfZ8zjsnlTBnul3mBtf
	21OUjiXVSc3h2eecHQSHybVyBGk0WEmUPUuHLF4ouL5z9KySPquceQCIZOXkG+ORjKDWs4a51sP
	H/I2LermoMjHvpSjQHIe4nQ4xFn75anycG4EvmQfYq5njxAXC012uTKDRBYx5qssyD6hDjiGHvR
	JQTWJC7SDf82Orw/q1B9u4+UZY1vQ/ADf6SqgyBFCT8hve7EVXqOL7DsiDVXPRPMY+j4vL/5jwN
	jtWKbgS9INZQ8JzB8B3FS5zhkon9o2yzPtbs3JDn2Q4P6BAWi+IM+3WBCq9YXql53vl+zqw5O1V
	Mkby658grOUyKMkDsqJ+KyByD/g==
X-Received: by 2002:a17:907:da3:b0:b72:7732:3d3f with SMTP id a640c23a62f3a-b72c0956ad7mr293108066b.26.1762514640593;
        Fri, 07 Nov 2025 03:24:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMj3mbtnQKKde4MpzxNgF1JLFGM8qZuZ6e8svUar+LZSBBg2EdSGer2uei3IF0Nx32JV45BA==
X-Received: by 2002:a17:907:da3:b0:b72:7732:3d3f with SMTP id a640c23a62f3a-b72c0956ad7mr293105966b.26.1762514640234;
        Fri, 07 Nov 2025 03:24:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bdf21sm216362866b.59.2025.11.07.03.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:23:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 17842328C23; Fri, 07 Nov 2025 12:23:58 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
In-Reply-To: <20251106202935.1776179-4-edumazet@google.com>
References: <20251106202935.1776179-1-edumazet@google.com>
 <20251106202935.1776179-4-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 07 Nov 2025 12:23:58 +0100
Message-ID: <87fraqnl0x.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> skb_defer_max value is very conservative, and can be increased
> to avoid too many calls to kick_defer_list_purge().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


