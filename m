Return-Path: <netdev+bounces-82693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD2788F435
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 01:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2121F315A7
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 00:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47B62D03B;
	Thu, 28 Mar 2024 00:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTz3BIx5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ABA849C
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586810; cv=none; b=JPAZOOHfeL8B2hLjQECKoG4lPmvLtEY+rH6PC9of1jSXcH/TxfSANyAxN7D4fwgG2cGlE6U2Deuor+pxwqkEEZfW82IZqKBQBD+jzpodC5BJupLQxwGXry9lKMngTfXK/DZqH8zVYIwX34xDsLDVRZdkex6KtpeEzYwZZJlYBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586810; c=relaxed/simple;
	bh=e+4ifJmlrD+8SKr6HeH4k1UtmM7jreqdC8keZHdQwf0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9oEokKW27Qa6RnkysMbL2zbYxZCUEKDo3RNnPvuOZ9YYvQ7TbnrE1ODtor2ccbJXg51NQvncxOSs//9Uhmfp43k7QJXmJJPUoXG7r2t39f7kEdMnkniwVfWFEnRyvrncJ2glqKbk3+7VBbSBFSdiFvzrMbXjdUVXz5MRsiwwW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTz3BIx5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711586808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+4ifJmlrD+8SKr6HeH4k1UtmM7jreqdC8keZHdQwf0=;
	b=dTz3BIx5n7iT6iNHKxxjsqs9A/CC8xhrxxDsP4j8XPfqnANYS93o7olbs/JG8QBafq2olx
	Fc2NVc8lYyiCFgYozKC7EMvSfKuzxsLhwF3Y6Oh8w8mdfY4Uzn1YVmA5V8avdwTHQcyfxv
	OmmrONLql2QcH+uv4+agdclSe+/+d2U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-q5corqLBNOG4ZS2vKHjh7w-1; Wed, 27 Mar 2024 20:46:45 -0400
X-MC-Unique: q5corqLBNOG4ZS2vKHjh7w-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-568728e521bso319696a12.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 17:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711586804; x=1712191604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e+4ifJmlrD+8SKr6HeH4k1UtmM7jreqdC8keZHdQwf0=;
        b=VZzrr8NOqfMhdKmew6BG9j2Wjn5MoF9MPX89jSY3JLijXI+n+VbaL/ClOMX4SBhUPf
         Vrn1p+NyzTqj8Bk4UNOJDl3Y3i/0NJomEb1qdZJEJBc0Ifwr1vTGIF9aabYuCwifkPKm
         s/1redxCaPqRr5fcUshbXxRZvBAoOzkYEbgFtUDyGCk7bZdTGWZXYEZUboIyp4LHhTqN
         z97R2WidSvqC4fj4+LWGqpxA39xERY0Y+QdIt4nG/SzQlShOQIqBiqroHKrN7gTnsYcp
         KRlqdbeyFXcm43MHfJdLSn+6HZtHRapR1S8XPzOoVKRWE+ASP+J64H1LVcT4Zos2wFWp
         EuQw==
X-Forwarded-Encrypted: i=1; AJvYcCU0OnNIJsP3x1IqLsUJxYoVD+Kp+h/sXEuZvoaI37AVMkZFi6XV4buDIWNDGPoYkU24ih8Svcy0TFozF6VeLahVp4kGPESg
X-Gm-Message-State: AOJu0YyfRmZU6uu+KWiaZyyZixVhdkIDkoDjfw3ctjV7k7xr9JazYTcK
	wTzD2sTZtekHQKOZBzlc1oYbM7GDOW2cpETSud8yT9b/BtUqUdi9gqoVlg95RkSs5EtTwQX8v4a
	gSULJ6UAENzQwptzNZMvd7ugAsBzDQZXwcehGljKcaSEYzvnLwOpGX1/zBipOQDkRqZBc2a6isS
	Bp3poPQoYqqwfVlljwx+7vd0mLOpXf
X-Received: by 2002:a50:9fa8:0:b0:564:5150:76a2 with SMTP id c37-20020a509fa8000000b00564515076a2mr925410edf.4.1711586803885;
        Wed, 27 Mar 2024 17:46:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo7MTKWsxPOWCY0sh5A+mehC8NaHptcM/Ec8NiDt6wp2lZwJVSnB6nWvqHv/BpBW9t2V7A+CiPQN6cuEBTVXA=
X-Received: by 2002:a50:9fa8:0:b0:564:5150:76a2 with SMTP id
 c37-20020a509fa8000000b00564515076a2mr925392edf.4.1711586803521; Wed, 27 Mar
 2024 17:46:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Mar 2024 17:46:42 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240325204740.1393349-1-ast@fiberby.net> <20240325204740.1393349-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325204740.1393349-2-ast@fiberby.net>
Date: Wed, 27 Mar 2024 17:46:42 -0700
Message-ID: <CALnP8Zb0US7-BPKm9nYSR2nKMrCknw1QnQGQbSSWhcz=ro+raw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/3] net: sched: cls_api: add skip_sw counter
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vlad Buslov <vladbu@nvidia.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llu@fiberby.dk, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:47:34PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen =
wrote:
> Maintain a count of skip_sw filters.
>
> This counter is protected by the cb_lock, and is updated
> at the same time as offloadcnt.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


