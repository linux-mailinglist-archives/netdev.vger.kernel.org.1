Return-Path: <netdev+bounces-147337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C09D9300
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50527165A84
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592941917E4;
	Tue, 26 Nov 2024 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I35rT2WP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828D4156F5D
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608112; cv=none; b=apOt4laioTPy2xUyqsS/VGaGAD5OneUDEf8/OfHLxL7md+Q6PUFR3EBvV9Mag/SvIYlXX5428TrLvYJpC7+q9OJjlStsm4VXMy5CGRXovjf8UP5Gzi5dfn54/+yICeotJDciOly9F74+KzQCp7grEVnadyOESMqzKRiplaI+aXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608112; c=relaxed/simple;
	bh=HClPhchoZHieJ4PXk0ZPMDdo+jy31usGVuk4vyKuzbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8ezrb0Y+fQGcGAa2OSXHwCkE7v8wvUuabJzYNyFgEA1EO4Kdcb0bdNUMWK9bk/FlNdN5uCXN4Ax/XevohUzwvZ8lqsn9I6CZ7j+E4j7cdlcViYjKat1STIb1Cf2ehpUz943cSVFvLj4I/Bc81dOtHLsPAz3AtMU6UIRCMk52TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I35rT2WP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732608109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAfqafsxwrqLArJ1cwO4NK3iIDoMu1BiTOyHhDVtA1I=;
	b=I35rT2WP5st8oh6fMLR4DwWfPbPiEJ8ZmVH+1gnRBSnkhiEWkpZRcP0rW2hO+nDspNI75j
	6igcNdPzFIIXt9OXYHCSAKLRj3R2gA/rDD8pLdqVl9XTxW+DBUp+M2M/xfxCA4h7IY5EXK
	EamCkQPh7LC556GxoclOR+Enrf67FUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-3dYxGymYOVeDek5f0bri-w-1; Tue, 26 Nov 2024 03:01:47 -0500
X-MC-Unique: 3dYxGymYOVeDek5f0bri-w-1
X-Mimecast-MFC-AGG-ID: 3dYxGymYOVeDek5f0bri-w
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434a876d15cso67545e9.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 00:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608106; x=1733212906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAfqafsxwrqLArJ1cwO4NK3iIDoMu1BiTOyHhDVtA1I=;
        b=S1WKI1xws3DoT6N019IJ2Nz5x0AUYiebHnag+gIeZtUbrp1O1QjS9jWzHnZ82lvRAu
         mQFME2kJbsvaAc6ndEejXLL+lFqvs634yXB5MRK7jQTFwEdyuLad4by06LSiRY2odPFi
         3qYysHgrWI7tYVI+/tWTpsZaAduWL6jYt3frxDelcZdwrzIK6gRADgH2hVS8ps2sGCDt
         obYsf+yxYVzycQ8cgIR2npHC11NrMqsNZf0tdJqNVf8xcPMS7yPnB5YwvOB759631Py0
         YVpzGuy+pNYsT16xSv9atg6TBGg8USWl0BgeHrB/5B+qeESNo19OcQ7cjlorKea0V6rh
         ckCg==
X-Forwarded-Encrypted: i=1; AJvYcCXdU4mrPrbpzqEYNSnbA29KHDOF4dznII2t0FBNrRxgc1ru0OvT8uzvhwr2ivr+j9KmTvt8Zwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeRYEVgjfWzieng8/XN8q/bVJnBlE5ssDDgtstjJ7jYRMYFQQG
	6c+rcADAaTwHcSXwcKa15wUsAu/qe50u35S4Z2kl0ku4JUCnPr9b9vAH72OzcQVWuZWCyUUT8Kp
	C9GifGZCWHNC0cN/YEjIKp8kYsxXjeA/Q3acNc/jwO/WokwOWNaAb/Q==
X-Gm-Gg: ASbGncvMn8Gsg4S4MJErg8b/5QIMWHRy7UM2x+BIs8FcEdi4Qo/JpMJlhwmzek/j3AR
	4mN1e11iyIp2LH/Vaemd6YgEAa19GQBEw6EK2vC37ioZwH5Q10ATWdvzDbIBT2PHJjBtZ8zMQYP
	/U2N0XtazPP9VGHltb81n4xhAWaGA/wfDNC7YG3OzOgSfhfgdKHYP1d82qcrzu7BDD2DqjiJ9xB
	7rFgOX05H2p9aveiQtFC5V+5eY0jPEopdiJM19R/caJWHfq/gxXplCnNOeka8rraj1l4XOxpghK
X-Received: by 2002:a05:600c:5253:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-434a4dfa99emr15576605e9.0.1732608106708;
        Tue, 26 Nov 2024 00:01:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3Zs+v/tKW0ky58iJbPzmLtmmXAe1KS/DiR3119yAT3rtX8xL7zpJ9OBnWLqLvIaKIGk8HBA==
X-Received: by 2002:a05:600c:5253:b0:434:9e17:190c with SMTP id 5b1f17b1804b1-434a4dfa99emr15576215e9.0.1732608106313;
        Tue, 26 Nov 2024 00:01:46 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafedbcsm12725815f8f.41.2024.11.26.00.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:01:45 -0800 (PST)
Message-ID: <afe444bb-5419-47db-8b2e-b51945dae752@redhat.com>
Date: Tue, 26 Nov 2024 09:01:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] ipv4: reorder capability check last
To: cgzones@googlemail.com, linux-security-module@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Serge Hallyn <serge@hallyn.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, cocci@inria.fr
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-6-cgoettsche@seltendoof.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241125104011.36552-6-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/24 11:39, Christian Göttsche wrote:
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  net/ipv4/tcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6c41..bd3d7a3d6655 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3406,8 +3406,8 @@ EXPORT_SYMBOL(tcp_disconnect);
>  
>  static inline bool tcp_can_repair_sock(const struct sock *sk)
>  {
> -	return sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN) &&
> -		(sk->sk_state != TCP_LISTEN);
> +	return (sk->sk_state != TCP_LISTEN) &&
> +	       sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
>  }
>  
>  static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)

The code change IMHO makes sense, but the commit message looks quite
unrelated to this specific change, please re-word it describing this
change helps capability validation.

Additionally it looks the net patches don't depend on other patches in
this series, so it would simplify the merging if you would resubmit them
separately targeting the net-next tree explicitly (add 'net-next' in the
subj prefix).

Note that the net-next tree is currently closed for the merge window, it
will reopen around ~2 Dec.

Please have a look at:

https://elixir.bootlin.com/linux/v6.12/source/Documentation/process/maintainer-netdev.rst

for more details.

Thanks,

Paolo


