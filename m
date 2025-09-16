Return-Path: <netdev+bounces-223268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8C8B588BD
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A291889DF9
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877E32AD02;
	Tue, 16 Sep 2025 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvC7vPkv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AEBE571
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980913; cv=none; b=Mu22OFnJhrQEkJVDwxuqUCAkB7XQgV/ZmJ1yMDK3rksrIM6/eP1z0qLqVd2DJL8p9z1hZHY2tJfTvI1oLg6bgzhpkmZ1wXK+888fzoAXsrq9W1tImNtCjHWO7r1FMIF3fmRo/jJm9sOvIBf0c3UwjhOOPfEWSbDbMpYzAS+9vuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980913; c=relaxed/simple;
	bh=OGGD+kObc2F8RK1KPO2tRg5YhSB7GSmN9r4+FXRdiU8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NFLQ2k4ajAFZPakzxoHx9cPnpn5PTsk7LSlBjd/XEb5cD5KZ67ReL+SUE2vivPpPrQq+bOgIdN0uCFmpnCLyhS/hK1XbomtytK5gBzr81G2bXKUTB5iBZQi5P3WUmOcMs+hWS9MavGMnkKD4sAeONY4opd/YVifE9yw3XUxfYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvC7vPkv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-82946485d12so166505085a.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757980911; x=1758585711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km5Y2enaETffJi393MZ/B/rn6VFmUTZwKRF4EtXN2SI=;
        b=fvC7vPkv+fNB+PWLIfgbo4FiMvrfAR0UjxOt3sCsShzX91ABaemqKhYagFtneLmyyN
         AMgkhxYlRX+Gk+2eFe8fFjVwOwTJ/f0kQo2+ZT6Ardk0jH6gVsfxnuIs2DNyvHxX/uJh
         tEoIwl6mXqRMNb8FNPiu4WSOWXDkFK9aeR5Yyqbq46Zbv8dgi3VDuw0HzzSDVPFV94K9
         7gt4zeuy/FjsdbDeqcoeGia+pBCPTH+AvXiPGYUvIqqY5PXKMTnTb0MjHwZ4YvUHKY2Y
         byQeEP8eXd/awD2+4ismaClURubSVQNU1hTcwfjgceAJfHnFe82MrDdTcJ+xPsWFO2WP
         BjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757980911; x=1758585711;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Km5Y2enaETffJi393MZ/B/rn6VFmUTZwKRF4EtXN2SI=;
        b=eBrCe+s3Adwy5iGoRhltAGeecTyJAyD20rxLi9rFjV5xNuqG+CzJFkhpWD1lQiAT5i
         NJOwmI+7gbjm7szKryZwT2SJPn1YlQxcbMBQD2TyzrjmbwTPH/Nt4gGHZi29hCsn24Gz
         KStybe/ss6wVSQzMjUl0Xf/b1FJ+ee4Ie/0tulbPkfMRSnp9IZ5O8Ntda1iwjiS2uzqY
         vixeQvimR2xY+5bBiWX5nHvJ+iu5FAk9x6UfSUiliWnGSB1HADEX4d5wmgeuHsbwaAeE
         7S8G2esMMiXgvcpRKTamZNH5342Z/DVln78vfm/NzO+uYi83ODDCh8RSU/8luwsNz8dq
         HaAg==
X-Forwarded-Encrypted: i=1; AJvYcCUI0X+/K0SaO0ky1n4vQ3lXUw/TD4EIi4TLxNs/eUxyFDOk2e8nvaxamacYTpTBjcX9UbczH0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfjvWnWXx2YNpWtcAwDjPFls/VYUz1TQzh2cFHno9gQfkg7x1
	wEj/KfM7VGSdHI7EUMZWQ20dp8nyE0XvDhBuq6jNxOT4DmqQYXOI91qx9PQZzw==
X-Gm-Gg: ASbGncuzbyYwulilM6u93y4ziJX+Nqu+aPsV3ChNnQexA4q+G7/DeYeTwIliydF5RAy
	+1s5RQeVtajy7mL7EaoPlhKB6tG3c7fWTr4g1/dz1mRavpQV3tJD2pAf9HwS5kOPOiWLptjHyAU
	kxELu64uFXOp9Qx1AV/wZ2vQiz7sGd1iRqtpgLSO9qRiOPwcolyMY2VnS0nYT7ltxyfiQaqU4n8
	qCw1Qw6e5QuRRr6E1BynOdpCqGog3Q1M0aVAgmp8XwO45Xmu6nWZa7SX6qqPWycFn50MyfF/bgW
	5lV+LieLBTyApu1z72Nv1vT7J5jyL+2CeIpoREYbl51mKG/cDBK20LmLmVqIZ2GGyVr/jCJuDlE
	fjrERp6Hj0hPQ527ZJhVCUnrjdeRxMs3BY6PReQbiA90g1O+fZ5tbFMzFYwIZ3w1Yelx5e4oeLn
	bxZkigynlXz5vy
X-Google-Smtp-Source: AGHT+IFqxyzlxIdJJRSkJ2g3wJFGm2A/PhKso66jv8vm3GpnTZZg0yc6FDwEhLZjKevphIjKV/wmHA==
X-Received: by 2002:a05:620a:1720:b0:81a:9d8c:7b26 with SMTP id af79cd13be357-823ff6db1a9mr1804763785a.34.1757980910684;
        Mon, 15 Sep 2025 17:01:50 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-783c85f16a1sm26696386d6.14.2025.09.15.17.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:01:49 -0700 (PDT)
Date: Mon, 15 Sep 2025 20:01:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.163f3efc42108@gmail.com>
In-Reply-To: <20250915113933.3293-2-richardbgobert@gmail.com>
References: <20250915113933.3293-1-richardbgobert@gmail.com>
 <20250915113933.3293-2-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v5 1/5] net: gro: remove is_ipv6 from napi_gro_cb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
> This frees up space for another ip_fixedid bit that will be added
> in the next commit.
> 
> udp_sock_create always creates either a AP_INET or a AF_INET6 socket,

tiny typo: AP_INET -> AF_INET

> so using sk->sk_family is reliable. In IPv6-FOU, cfg->ipv6_v6only is
> always enabled.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

