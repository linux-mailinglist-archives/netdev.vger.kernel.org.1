Return-Path: <netdev+bounces-64741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B666836ECD
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09961F2F62B
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199FA55C12;
	Mon, 22 Jan 2024 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkPqPeVx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AD25577F
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944330; cv=none; b=syd7B6ZX6Y1R0pxx2+P0q34ZLngJVbaiJ5sV+ZsZ7jOlx2x+9BLjRqJxlTkX5AX3J5EtxWIRge3eqV8d3ptU1g7aIXpllSjsySCqAswMqKjCvRlA3AQdJcCh+ER+Yr+g0E/jTTKADhVoK+D9CZQRY7nQE9Isty9afHvIscsQI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944330; c=relaxed/simple;
	bh=itWs/mO2yYDeX0NrhlPidYc4nDXWAVsHs00p9f1Yy9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r28YbuiifxKLeDILJdQMx/Kf2s8ZH8iR5Ye6q951y793eLRKmZ1/GPQlbNrXoaa/M5g0ywhgYqswSMC/SuU+m+XZl8c6XEV8jdK6qkUYN0EG3JZe40k9eOb6G5xoTtkWWA6aWwOPRc1yU6nicGH4y3NQrAXqeTTyhxJrmA3e1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkPqPeVx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+UFVyQQ8sq7sHjbUcJ390C9cY3IuS2ixmyHtRUpPITE=;
	b=TkPqPeVxa+WpydIPDKYL161hIPizan0gETxJAeJsJE5VV56Q9zvulU6VCqJFWrf9QP28d0
	DfiziDOVNI9ZVdrTyIiI1VC29USQGAkh+FolEYKHiGaX2HOmUgfP/hHLV0Zb1bK87koj1/
	PA+v3N/86S2AShYBqAfL+ZG15//RGBo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-ejXRUDppOUax6Bbuqlgl6g-1; Mon, 22 Jan 2024 12:25:23 -0500
X-MC-Unique: ejXRUDppOUax6Bbuqlgl6g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68693529d68so10699306d6.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 09:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944322; x=1706549122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UFVyQQ8sq7sHjbUcJ390C9cY3IuS2ixmyHtRUpPITE=;
        b=mU9V5QqmmajEKOGXVJ2FaTn7SiESI/CnJ51YUAXNBT8SuTg531tFHzf7rKyDLUwRYu
         emXQX4te2Cjz5HEZbddosEmYYg+id7GPvcR8j2ENSgcd86fu65cGdYJlXfM6ihiqv8sk
         1YPwD17H6VDqsvL7iC9AVpG8GRL7Bal/OepRN76yuGJsO+CrhlgTnkgyMVZlDgX0cT3H
         yYDrGiFd9DSmwoqAPAQ0qJu5TZD0Ef2aVWxbQOtyPsfKNqg/eYuAvbrnxuuMtpLCJKGb
         cfWJUUlJs2R3C3M8bnzvkuvJyB1u7aj8OAFmJ2BLINI8OsjMaXDYJ3KCGMnaTVoXLusn
         yMqw==
X-Gm-Message-State: AOJu0YygHM2ZztDsSPWC3LSIBecT8K82eUCW9tvgDV9vIxzE61d+uwEB
	nyPkM35tWqxvzZBDMpjQnVDRWUCxK+9E4UzTw7/txqSmXmsPwolHi0nAEAPcwyIROI2GSPzOGFS
	Wxq7KerhNiaQjHkDYXcIMpICqRXFZhMx5xK2FPHvdHYKqIGQO2jiSYA==
X-Received: by 2002:a05:6214:76d:b0:685:ca51:bc53 with SMTP id f13-20020a056214076d00b00685ca51bc53mr4330197qvz.55.1705944322641;
        Mon, 22 Jan 2024 09:25:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEivHQ5IkwrnX7lB7KxW37vbiMpU851tM32FHKenJ98k4DtgZGLpQpvizq5IRVlo1nzGAtH0w==
X-Received: by 2002:a05:6214:76d:b0:685:ca51:bc53 with SMTP id f13-20020a056214076d00b00685ca51bc53mr4330186qvz.55.1705944322434;
        Mon, 22 Jan 2024 09:25:22 -0800 (PST)
Received: from debian (2a01cb058d23d60079fd8eadf0dd7f4f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:79fd:8ead:f0dd:7f4f])
        by smtp.gmail.com with ESMTPSA id l14-20020ad44bce000000b00681776be156sm2555108qvw.110.2024.01.22.09.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:25:22 -0800 (PST)
Date: Mon, 22 Jan 2024 18:25:18 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 6/9] sock_diag: allow concurrent operations
Message-ID: <Za6k/o7BQvtijUJM@debian>
References: <20240122112603.3270097-1-edumazet@google.com>
 <20240122112603.3270097-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122112603.3270097-7-edumazet@google.com>

On Mon, Jan 22, 2024 at 11:26:00AM +0000, Eric Dumazet wrote:
> sock_diag_broadcast_destroy_work() and __sock_diag_cmd()
> are currently using sock_diag_table_mutex to protect
> against concurrent sock_diag_handlers[] changes.
> 
> This makes inet_diag dump serialized, thus less scalable
> than legacy /proc files.
> 
> It is time to switch to full RCU protection.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Guillaume Nault <gnault@redhat.com>


