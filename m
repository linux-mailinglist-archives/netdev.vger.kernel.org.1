Return-Path: <netdev+bounces-217157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43312B379D6
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E41716EC19
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 05:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E7430FC39;
	Wed, 27 Aug 2025 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9wxMsUd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B327A103
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272650; cv=none; b=Fj6uR36rpVh1wL8zuFtREOsjmEEmc1FgnBVHeDt4y9DrMjS5jhu8BeptFzh1uHd/31+sG5hWoof7b+QC1kHtOdzsiBIgDjkxWzkrj/AZithhJrbKk8b7mTo3NtjZiK/3zQrZ72qRTeQl9UjYFzynPnWS7vvjSd4Ltyh5spYqTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272650; c=relaxed/simple;
	bh=ByoOnZL+8JPAW77pzYs7EM5xfsnB0pegzg5I3JWtwwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKRsNLwYAB9zYQjMZszEa8JeHX9OaesqwP+fHtNH6bf7Fpmgs/MCcd3VR398KyXfzyyoi/sLphyLz5XgPZtFILUadq0qLD+8trUWf9ojSxwpNJsJgsp0e9GdlcQoeFM6JvT6XEBSa+qBbzUKlDz2qwi8HJBTN9TjVGQZ/kHoFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9wxMsUd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2489acda3bbso2233005ad.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756272648; x=1756877448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByoOnZL+8JPAW77pzYs7EM5xfsnB0pegzg5I3JWtwwM=;
        b=O9wxMsUdARxlz7CkALGu9n92H21raTUT6x3ObI0M/D1uWkVX7KemA9Yfxaa00HSTmy
         ZWoU3tdT+clFDM298lxdbtmci+3PldjdMB9/TPtPhiBvziWWlPRhzBfGnz9YWGFyR7kZ
         rtx+EwG6rSY7s4s+IuS72w6nMIaA0Lr05q9LqCqde9frglYmxA6YHJC3nTW+TMVxhdna
         9hS7DQcWi11l5ekwYTsHC72uFnl68pIDuxEbynGZnS+LUwVn+IOngCLucl7rWu+12ReH
         /wX7eZXGFwAIMBUq10nX8l+4E6qX6ENayfn/C/V9QHZMvAT8yMHpcnk+91g4MWzDk0Cc
         C6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756272648; x=1756877448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ByoOnZL+8JPAW77pzYs7EM5xfsnB0pegzg5I3JWtwwM=;
        b=gfLp4icd8+gXvSnj6yVcuKoOVE1eXmqbuXXFKd3TGLL5B6MMhNIHI2Um1C1FptXzbY
         AvChpZKMgmH6nJxQDkIscPyZTqPUcRDBM8uneFiNy25gME1NLC4QepW28sCFpNaX7aCK
         XOs+N2Kym6mmS79FdWFzwhAsoszyMlTp8AH+qdS40aJbd3VXkThdYpbd+DEnilzOzm1d
         JsalSZtopBL/jd1x/kDxti//AvhmiYpJjSXluESQm7cpZhhvljQIFTwNXk7cUMEgj51B
         5VHDxKXMdAnT0U8wjBPDR5dQZm+nMPcda+WyjoPn1jaxPd8ohbeZfJZdiz+X6KdQ+3aN
         GhPg==
X-Forwarded-Encrypted: i=1; AJvYcCXdaH/bOij7RZT8rXyN+VSwOpNsRWiUSBr13WjGRdReH+AMJx9RAgndw6EvhEZxtnex3vTVOqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHC7zcvDMCxTH4Y9UBDJe9n06VYoZo9KpTaLuZrWGi+OnAFAn
	RMag2LEgXZOSN6qhvWozHKx3QjSFTH9z9SGefxSXGr/gGReOSMjN1OOTYWf8M+JoLEP4rxs4Roi
	ekkspTVJ7pTifERccOYFwaVIxf0L+3P+pGxWrI+w1
X-Gm-Gg: ASbGncvioYa5OdFR04Ap0G2p2y7amyWWh1zI3JiITdt4nIMbYY2NPu/v05oJu2/oMS5
	0Mfa9LZwRI2yZ5lcfCUPMMyHKBHy5EUWlckZ8Kw08LSA3utwduSkspiR1GVoKhkgmLRDZYiQm+K
	IG8/SnCb8EXnW1doLghKD31Go5K84x3QuZGxCaAw+wCwqev2JilSURlAQlAjhc1Z7UAYNcdC8x6
	zmgxYZQXGcmrK1NG5z1Zx5CcLDeMfIRiwL7yJqo7FlpocZKRVAVwzLfze5hZbDFQAtV7wZbby+I
	NZ/RwrEEsrT4eQ==
X-Google-Smtp-Source: AGHT+IFxOTIMr6WBK1uFmHsC8OHvTwz0f52JdkW7TBv0dh+6/ob1rMatZkVSjHGJCcwTVkNSt/EYjtunkptjGMQWV4Q=
X-Received: by 2002:a17:902:ef01:b0:246:4077:456f with SMTP id
 d9443c01a7336-24640774ecamr222799085ad.58.1756272647947; Tue, 26 Aug 2025
 22:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826125031.1578842-1-edumazet@google.com> <20250826125031.1578842-4-edumazet@google.com>
In-Reply-To: <20250826125031.1578842-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 22:30:36 -0700
X-Gm-Features: Ac12FXzQQZP2zPkGEs-LkNe4KDgWi-EXn3w0NHTt6PyPDf6bOW93cgJ4YhhwYPk
Message-ID: <CAAVpQUBQZiy=mAK6dpHsoMt5ExQR=f4qpY9hEV_X+r=+p+7nOg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/5] net: add sk->sk_drop_counters
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Some sockets suffer from heavy false sharing on sk->sk_drops,
> and fields in the same cache line.
>
> Add sk->sk_drop_counters to:
>
> - move the drop counter(s) to dedicated cache lines.
> - Add basic NUMA awareness to these drop counter(s).
>
> Following patches will use this infrastructure for UDP and RAW sockets.
>
> sk_clone_lock() is not yet ready, it would need to properly
> set newsk->sk_drop_counters if we plan to use this for TCP sockets.
>
> v2: used Paolo suggestion from https://lore.kernel.org/netdev/8f09830a-d8=
3d-43c9-b36b-88ba0a23e9b2@redhat.com/
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

