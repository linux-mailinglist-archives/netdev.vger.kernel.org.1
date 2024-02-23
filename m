Return-Path: <netdev+bounces-74452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D068615BD
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA2428355F
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA282839E9;
	Fri, 23 Feb 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp3qGkTg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69D81ADF
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701954; cv=none; b=cR3R2qs+KVARyKtX/Op5UrJj64N+u5KE0/6R4qBDuEYaKYleZFNLu2UukuP37SW6vIyjVsYsTLhX4a0fcX8mKh4nl0viW7cGcXFpbz8xOCryEvfUJ+ZOttvHyVIrQnBtLFuIc/OC4cKlUoQxJE1U7Sfd2+KnLBn2Lph6hNrtyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701954; c=relaxed/simple;
	bh=tI6NsdqRlcWj1R+YVCqtpGN3CBj6gJicdjAqM+OlB9o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=X4X9de9m5sy0uz2n3IzXSY8J3jOmdqJuUow2GH6j/4XSA1UWVzSZhqUSN5Q5K2eKF7T6c2NA/cXLecROHgFDncHz8HcKSeFjKf0bXLK0tC2cxe1gGnX4s43rrvC7AVn9QDeEMW2QJDOloN2HKnJtn+zUybxWs0O8YrJ38yufojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp3qGkTg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4125e435b38so3484465e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701951; x=1709306751; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tI6NsdqRlcWj1R+YVCqtpGN3CBj6gJicdjAqM+OlB9o=;
        b=Wp3qGkTgaYDChpUgaMQgKTzIXvlOg0X9zZLg1pRuQCCfd4aWA8tFrnUv6LIPMTR5US
         rLAY0IfSIOWG0CaElgx7XQpk3LtHlKMkHwjv7e2uaVidF72j8fwVtdMCQ3jjwAr/AZqs
         oLK50ZS8DbIcvFnAvb9w0B8T8gCdSp+JJwVFXpoHo6RPlqFa0TBYc6jDOaamKVth4Ds+
         lp30/etaCPhm6z5TqpQXQuYRLcQtX60UpAxQhbO96FWSlwI+YCIUmghq0g0JrN5NGJE8
         rR7uwbov0334xPOicr9yAs/10rOuoZT0NhVUngH0EFqhf+IE1+vNdwGAzLw/gDRrYFbh
         1Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701951; x=1709306751;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI6NsdqRlcWj1R+YVCqtpGN3CBj6gJicdjAqM+OlB9o=;
        b=RK2m7wmV1ag3LPGosRqZipqDZ7cWoGxb7JNQa5DGhp66KRjkpn0JjF4wL8F+lmFb7I
         V6QlkOhnrRo0kAqtxwLa+9sX+UxvaEToKp7pgO+cUx0DRt0y6PKyh8RVk/4YdJj5y9yW
         m7qQ6og6xZvT+lYstANKnrRg+rFpKhmwWXDfT0j1QEsKNtWHre6K2iOBhY4zHt6r9ZDQ
         VUsWOXlw9LQyppuYDX07N9cZQdVYF0m2OPB9kug5FKUU6EUyd408mcE48WGGvbtx6GDk
         HeKYtNAyqbiBQc8ljXdJa78YizV0ffZ/9hAA25ZCCYDf3ixuGE7YbZ6Xrl0eEJR58Uhn
         ckCA==
X-Forwarded-Encrypted: i=1; AJvYcCUdWbe1HIdU+QbLBv3FVAUqA974oHz4+kl6En+f+gqiQqbXJuEZ1KpUix7WuN6tf29oKEfnDF/7SBGsDnG+RUqwTGDD/uhB
X-Gm-Message-State: AOJu0YxLc2zao0hKoIG6vg2YQcN/wCzS/Vx0244s0SThu5FYGfljogMq
	dtcqtYCo+PHe/CGrE7N0b/N6mBWmvr4YlOFWuqZEjdoimkRnbABK
X-Google-Smtp-Source: AGHT+IFal/HCGWMHMmVK/S92xunxTMTIsxyUGXUoKCZqj442ww5UJ0WchIBtC7WA16nkqUpwcN/wDw==
X-Received: by 2002:adf:db01:0:b0:33d:ae69:715d with SMTP id s1-20020adfdb01000000b0033dae69715dmr73274wri.27.1708701951241;
        Fri, 23 Feb 2024 07:25:51 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id h14-20020adfa4ce000000b0033d56aa4f45sm3124648wrb.112.2024.02.23.07.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:25:50 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 08/14] rtnetlink: add
 RTNL_FLAG_DUMP_UNLOCKED flag
In-Reply-To: <20240222105021.1943116-9-edumazet@google.com> (Eric Dumazet's
	message of "Thu, 22 Feb 2024 10:50:15 +0000")
Date: Fri, 23 Feb 2024 15:19:14 +0000
Message-ID: <m2h6hzqkct.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-9-edumazet@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> Similarly to RTNL_FLAG_DOIT_UNLOCKED, this new flag
> allows dump operations registered via rtnl_register()
> or rtnl_register_module() to opt-out from RTNL protection.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

