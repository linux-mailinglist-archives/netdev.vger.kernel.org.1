Return-Path: <netdev+bounces-229516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26EBDD56C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56C4189F0D1
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2512D24AD;
	Wed, 15 Oct 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3kjdXQO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18312D24BB
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516270; cv=none; b=Sa4YmZmkZcr50IRMeKT3y2rB4hWVUHGgok8NULgF/aRDJMFsvP6+kclB71fvQnINASBptnVpXb4oPMxdmoV+lPT+tG72393Z1fuzwecdk5NdItxA9NOon8FYtEN3JS4XqI8VIyUzsSTApa9Xor86TJXFfgQzWacH+0dDdnpJwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516270; c=relaxed/simple;
	bh=5mN1b4Wy5T6HmJkKDTSGuFV7UA15AW1ViCWzpYms7HQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aydZV8NWgOb2TaV5IFK2yhAfpaTu15MFRSAd6bNYsXhZrTB+GT9WgxhMTx9aLnP5RlDopqU1fchrNYCCa2krEScc+4y4VWBGjpLSi6bgCQy/EbGOMCgRLk3pRos9V97dWRBWsORSBZwFA51wo1jRqtZtgvWECmW+X+oqymnJ6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3kjdXQO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760516267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mN1b4Wy5T6HmJkKDTSGuFV7UA15AW1ViCWzpYms7HQ=;
	b=O3kjdXQOFr9nRnEqfQu3iMZZhVEdk5Q/DCmZ3vQ1brbBPslzmnxKHHBEIN9KygsXnITFbd
	9bjt4bcYLS4vhI/bgFxlT4iGuElRCnfYcNVAxpAew+rpHZwgzw6fk0EQEN5/OhwqHY2V7M
	MggxWhkbKOrEEBQjFWOwKmMeubdcCQk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-dZU-vV9cOF6OUdLmOrxoVA-1; Wed, 15 Oct 2025 04:17:46 -0400
X-MC-Unique: dZU-vV9cOF6OUdLmOrxoVA-1
X-Mimecast-MFC-AGG-ID: dZU-vV9cOF6OUdLmOrxoVA_1760516265
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-632c9a9ceb1so11562963a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 01:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760516265; x=1761121065;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mN1b4Wy5T6HmJkKDTSGuFV7UA15AW1ViCWzpYms7HQ=;
        b=vCi/BVTIIqnbTa3ifa5JpDsL95FYG7/l1LKnALL6GpmsJZUR50PCkFwzF3iTZn0On2
         TYj+tXrqCOM90GKjEMJN3YoiwWFnBOM3v5yUWCqXAo5aXYHYhd922jOa/2Ena3ozqjw3
         PutWn+WLjGe54nTRJAnG5PNoZpiJqWNLPBpXXb/l/Cy1uHonoojqhN8x5CTmXLK5DP10
         f1vO0TY4ozXSdo2TtH4m6bzWdS+zCxO/YvzzhZAr0waeuVr7Q7Ii6xqSjzYv9ySLZE1i
         S+2FE+DN5ExdI9X1KLEEVq3UWhvrqJLof9Tal6UlG5ZCw0nraGXjhsGCJOUH2Je1SFIO
         P/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVhnz4Cd1UV9hD/hHYSv4d+9atZN3sTxSN9o3lp/qvwLKpfdGy546WIF7KmJc/vzl/kyKIae0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNki/FnQKGKDqqNHYc/X75Si953gDyPlxgnV2Y4d894Pm5sWT
	ZFdxQv2TBz4h7/k1++Z000OibQzja5b9bbHMvCUPDd95zmrwnwoIQsF0KS0p8QvG02spo3kWWfl
	MOJMMGQoQ7UzMZa8Q1oNJXuZEpK0XjKrNw+lGxnTt06uCPbh/rRIXFVsbpA==
X-Gm-Gg: ASbGncsYj1WIWJGFNlUpbWhwRXe0LXNKw0mt9czC9g9SqY7hNjSOhR0jmlIuhro255p
	07cJAavnAQtDOB+g2P0yh3q7DgVOwYr5ZEkMRikgkjWHTGpEMjLm1/jAmCyFueB4OsWuK1nfQMr
	LPZWVp+gVuxgVUFDN7vOixfytkgrpnsvNzUkDgb5HVxvktFEmCyDPKM4+UDw0vppsfQAb1i59il
	dRadUWQrYR3Cjf43FPZv0+uelTIW3JaNeo/vE6gEoBOn6GSD0B9ZDn2yfR4k4/qbosi4ZPSmdO9
	yv4I3lvktAQM1TtI2KGD9f7uUYwgyp6uBvLCIy4DipvQHeJNkH1OAGosBeVpRrN4
X-Received: by 2002:a05:6402:210d:b0:639:e712:cd6c with SMTP id 4fb4d7f45d1cf-639e712dc48mr23749577a12.13.1760516265335;
        Wed, 15 Oct 2025 01:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQKO2ultEx50eqPBZ5ofVjIIT4Xtv7petK6+6xVKMJsKoZQo3IbiR6G3R3QU5+T6sPGeydSA==
X-Received: by 2002:a05:6402:210d:b0:639:e712:cd6c with SMTP id 4fb4d7f45d1cf-639e712dc48mr23749555a12.13.1760516264917;
        Wed, 15 Oct 2025 01:17:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f358sm12747533a12.10.2025.10.15.01.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:17:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D65DC2E041E; Wed, 15 Oct 2025 10:17:43 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 4/6] Revert "net/sched: Fix mirred deadlock
 on device recursion"
In-Reply-To: <20251014171907.3554413-5-edumazet@google.com>
References: <20251014171907.3554413-1-edumazet@google.com>
 <20251014171907.3554413-5-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 15 Oct 2025 10:17:43 +0200
Message-ID: <87plaofujc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> This reverts commits 0f022d32c3eca477fbf79a205243a6123ed0fe11
> and 44180feaccf266d9b0b28cc4ceaac019817deb5c.
>
> Prior patch in this series implemented loop detection
> in act_mirred, we can remove q->owner to save some cycles
> in the fast path.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


