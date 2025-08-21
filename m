Return-Path: <netdev+bounces-215457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A246B2EB4C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9E51C85F6B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2A72472B0;
	Thu, 21 Aug 2025 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTT1nHvG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B31D6DB6
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743906; cv=none; b=EXo7d0Hj6y3hREgxjmjHn5zWk9fuCAxNAohRqjjfvktkD9eC1ymJTghnOjF0cDMo/71Hu5fv1ILACeXqr8I6414BQDlYIPp9/5MhC3uMXdabSRESARrwU+cs5La8EEzUIaE6XgN4a/o4+iP4VCD+9V+sxBU0NnZnP4akPNjwl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743906; c=relaxed/simple;
	bh=KsjIV1/2ffYaz0hJfNDVfMd7CKSxa6EV2XwVrwAxZ4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uwFCIKRfQskoOuYNE3FFmrOM5S0efQQsCVGiKs1Du3OdZZRUEhMpP+tgXUsHH+PBX7zM3VH90sKVzlUU5y6lKUx2iLU2JmXAcS+iLc9BHKtHShmaCcQfoMBfMVlm9Gr5WcGLD95M+tKBP3bOJ0/+Wp0Qw37MHg0rJRIzlFO0oBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTT1nHvG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e364afb44so436142b3a.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 19:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755743904; x=1756348704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ejQYYMpApIp8takWWTTEX4NKCk+aESE9rdeLB1U6ec=;
        b=mTT1nHvGpYA7BysQVZ4ke+HfaxtQFHpwBMYFw5fuz/g7RpqWMEraRj0tluDK4+21Zk
         YR5MWxNbqZDfHZl1VtphrrRm/OIHBc0dmr0EsHyyzgGRpsEAzD3gXYIpEiuFRIW6y9Tn
         mDQCKlmubyNbfAWioYRRU/3G8CZ8dqytJfcvGU2npI482htxrDdADxn/csWobl1Uxajl
         P5QtRq6StDAETcqSL7vy+MeblZzK9sW1W7qoFo1Vuz0BBB1ZZRnOVZd/ablIhEf72sNj
         Ct6JFMVeM0ss3wkMn8uqn8ahBjgGEuPW0fV8Q0nfDV0+LXmDkWdQpWbUOzHe+3ARM4NI
         vFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755743904; x=1756348704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ejQYYMpApIp8takWWTTEX4NKCk+aESE9rdeLB1U6ec=;
        b=cB42SLk3gvxrNM21QOQ+7dh7+cqe9UJiuNMYG8NRthRL+8QdzgzjZakE74xyl/GW7S
         Pc2mmCK9UaOwp5KUoH5/W2m0kFzmflSXdnsqj8FfSCNOkqgv5WwBTQXzLgiDqfd91Lfx
         psC0RpOkr2GjSpEp5cPdjQVhur0y6gs/cPzkugrEgtSBVg9c+aOMZs3ru1RhGN1jvTr+
         bKwBb1LEPGfHJLMfVFE7Q/OV+k/GPYzkcHD1z+GT1gQI7YtqHial59HrXQrCVMSOJjB2
         fD9BbTSylH27TO/xvEqGn6jwNLvraZXY+rbJoF977HeXMJ+TrGpPIGihF+YPLc64edI9
         rDfA==
X-Forwarded-Encrypted: i=1; AJvYcCVFvfDfQdaOSvjtFCmgOJpxfEOywssYUZQl3S+Pvc94s0mR/2YIJdKSg4oTN+YKVgeYX9MrLjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb8SsqjxDm78zmgpir/qdi04vSpZGewrpy4jY2WrFu9tK+9oSG
	xNcLGiZkAcZmyH6SZ8NgR1EF7z1jYCU1iUAASCi+vzwhTW4711rWNVIAO8YfFLaPUp/+Vdy91+4
	tLYikbw==
X-Google-Smtp-Source: AGHT+IGPSm8s1qklyNWYrVBIjUvwJMNjYyV6tksvmWGvYuUNfdk/A/0UMMr2HBVxhLeFwG0+FUD0anr+dQs=
X-Received: from pfbbu4.prod.google.com ([2002:a05:6a00:4104:b0:76e:7b1b:137d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da8:b0:76e:885a:c338
 with SMTP id d2e1a72fcca58-76ea328cae8mr866640b3a.30.1755743904297; Wed, 20
 Aug 2025 19:38:24 -0700 (PDT)
Date: Thu, 21 Aug 2025 02:37:37 +0000
In-Reply-To: <20250820174707.83372-3-takamitz@amazon.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250820174707.83372-3-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821023822.2820797-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net 2/3] net: rose: convert 'use' field to refcount_t
From: Kuniyuki Iwashima <kuniyu@google.com>
To: takamitz@amazon.co.jp
Cc: davem@davemloft.net, edumazet@google.com, enjuk@amazon.com, 
	horms@kernel.org, kuba@kernel.org, linux-hams@vger.kernel.org, 
	mingo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	tglx@linutronix.de, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Takamitsu Iwai <takamitz@amazon.co.jp>
Date: Thu, 21 Aug 2025 02:47:06 +0900
> @@ -874,8 +874,6 @@ static int rose_connect(struct socket *sock, struct sockaddr *uaddr, int addr_le
>  
>  	rose->state = ROSE_STATE_1;
>  
> -	rose->neighbour->use++;
> -

This is replaced by rose_neigh_hold() in rose_get_neigh(),
then rose_neigh_put() needs to be placed in error paths in
rose_connect() (and rose_route_frame()).


>  	rose_write_internal(sk, ROSE_CALL_REQUEST);
>  	rose_start_heartbeat(sk);
>  	rose_start_t1timer(sk);
[...]
> @@ -680,6 +679,7 @@ struct rose_neigh *rose_get_neigh(rose_address *addr, unsigned char *cause,
>  			for (i = 0; i < node->count; i++) {
>  				if (node->neighbour[i]->restarted) {
>  					res = node->neighbour[i];
> +					rose_neigh_hold(node->neighbour[i]);
>  					goto out;
>  				}
>  			}
> 

