Return-Path: <netdev+bounces-146837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A99D6307
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 18:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84509160EA2
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA7814D452;
	Fri, 22 Nov 2024 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzpftI8M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393B15AAB6
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296422; cv=none; b=jnW4uq3MpzgZMeS37rg1xQLsT+KMljWU//nLr+XOsBGvDcgKbucrb+vmknDSUQ3w0C2+pERBniGv5SWC4YBcDBRgja24KqplRJ4doHC5NoBe59Ph7aZjG9kb1a6i2Z/cZHZ0lIBJROSXJCXXP+7zulcIRI7Is3tapPNGfhXb1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296422; c=relaxed/simple;
	bh=ClLKHDqr6PkmVcgcEQS26XuKU5WAQb5CRj4MznEbpvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2nDZlvGm97qV+Fz9mmE9fAmttOKEqvZMhPsWL4hZ4JwYTWlgos/lIVI7/5sGKnj1kY+BLuFh7E2h6Wb4gigVV9oRQo/UGbGeGuaHyr6av3jncrXg+HvSMBB13vYq4W6iG0E2IgbWCRXugIHxEa7fRGnU+nbZJtMo3iSkJl7Ro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzpftI8M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732296419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bonjTJEsrDIaVijnWhdP+tUvaZ22+wg4ayk5WPuEpAc=;
	b=hzpftI8MVcQb9YtSAjIo4mF5YWKYGV8o1YZv7fIamFPtYviYoRrNI2H73j5eDYeCpUrerp
	jWXsev7LyKgmN+AA4JQ1siibAQjoS/bVvnlWYV3GHelTutpeT+r2+uegNYp8+fmH4rmckG
	IOMmDFVwGkWO8berNWTHeaz7lcgTrho=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-6snNoTOyOFezsIJafYaBgA-1; Fri, 22 Nov 2024 12:26:58 -0500
X-MC-Unique: 6snNoTOyOFezsIJafYaBgA-1
X-Mimecast-MFC-AGG-ID: 6snNoTOyOFezsIJafYaBgA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-382412f3e62so1159809f8f.3
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 09:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732296417; x=1732901217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bonjTJEsrDIaVijnWhdP+tUvaZ22+wg4ayk5WPuEpAc=;
        b=CNdTQAszIpS94oUioU+FZoUiIwv+layEQdOghrRVTN8XfOzA3DYpsxJjiX51RW28i/
         /oRa8zyAcXy72ojUNqP1lsHQacLKTJWeUFNLKVUh4UzBH6vpez5+fM04bEmR8O5KLl6j
         fsfOH4v7M0eKqH570RPdo7p8ixTW2G+NLEynkksOfKemmBVBs17sI6xQ6Upsqto/AXeQ
         crSO65gU93AO7R7gZO3gc5BbTJbiJYOQo+WtI9RkzHcV6G1Mxhfn63NegjrD7JfeeEJG
         ZlVmld/hRsy6wMzqnGa8pNrFDCUTPKVW260222+YjDIhRSCW9xuT3USPP3vXt4IL5Or6
         neqA==
X-Forwarded-Encrypted: i=1; AJvYcCVzXmVCI19OJL96nKvxy5/xIm8AxpViUch4wz0bShQc01rX8Et97hl10y62TNo4LJCqBd5sDK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ajQhYnjoDvcOSWE76idoiegUaJnZvjVUbB42kH1kWiJqaNfR
	0yJ0LirwmJEGi1OTzOZlLN9rDFyVVmWol/aAfjBb+6j9YI88Xf/8Jyhxe9mSo9YAaCpC21BmCtb
	O6Kf1xFEfweKcJPACtjzXgxMlw57XL94QGFQ6xqgF2t/xPm7RH07pAw==
X-Gm-Gg: ASbGncvhiQZ7UibqN5jX5b4Sr1S30fJLeEZU/lH9FvnuaOcbaIbEkoiEH8nrqwnkydB
	4cHjC6OtYBYjf9UrgQfoQ2S6rdiWMkcjZZAVPwuvwUwZcMQfAEuyyYyPjjMSB9Q0nnZAHtlP8N8
	GiX4tgcZJNLcKkryFcumszCqnS0ZzfXsHzcrxAlTN5/54rNYZSuCEcVi1g3qSq4Atpxvyp5d9cz
	yqe5N/DVw0TbCLyq1Lmv/JFoUxeJG9mAJ9zq0GfPeBHLlzd5o6Oat/ei0tlwY2aJxneooVkvezw
	ArkfDA==
X-Received: by 2002:a5d:5f8c:0:b0:382:39a7:3995 with SMTP id ffacd0b85a97d-38260b5b5a5mr3051883f8f.17.1732296417173;
        Fri, 22 Nov 2024 09:26:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJ8cnKY3PHy55oSgMvuyy7GftnO8GWR0CeQCP0dYaT9/4MetPL4C2V96vIO3UU3FglDdAiFg==
X-Received: by 2002:a5d:5f8c:0:b0:382:39a7:3995 with SMTP id ffacd0b85a97d-38260b5b5a5mr3051859f8f.17.1732296416829;
        Fri, 22 Nov 2024 09:26:56 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.22.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3557sm3016023f8f.81.2024.11.22.09.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:26:56 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
To: mhal@rbox.co
Cc: andrii@kernel.org,
	ast@kernel.org,
	bobby.eshleman@bytedance.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	haoluo@google.com,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	mst@redhat.com,
	mykolal@fb.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	sgarzare@redhat.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev,
	Luigi Leonardi <leonardi@redhat.com>
Subject: Re: [PATCH bpf 1/4] bpf, vsock: Fix poll() missing a queue
Date: Fri, 22 Nov 2024 18:26:29 +0100
Message-ID: <20241122172629.62588-1-leonardi@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-1-f1b9669cacdc@rbox.co>
References: <20241118-vsock-bpf-poll-close-v1-1-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>When a verdict program simply passes a packet without redirection, sk_msg
>is enqueued on sk_psock::ingress_msg. Add a missing check to poll().
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index dfd29160fe11c4675f872c1ee123d65b2da0dae6..919da8edd03c838cbcdbf1618425da6c5ec2df1a 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1054,6 +1054,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		mask |= EPOLLRDHUP;
> 	}
> 
>+	if (sk_is_readable(sk))
>+		mask |= EPOLLIN | EPOLLRDNORM;
>+
> 	if (sock->type == SOCK_DGRAM) {
> 		/* For datagram sockets we can read if there is something in
> 		 * the queue and write as long as the socket isn't shutdown for

LGTM, thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


