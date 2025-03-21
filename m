Return-Path: <netdev+bounces-176758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3C5A6C03D
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B10E7ABAC5
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365C22D7AD;
	Fri, 21 Mar 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKD4ARu5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401B22D4FA
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575202; cv=none; b=ebnVxvVfnseSPcWyfuTJYqhjg1U5zJR5g0ufACYpXxEjclRbK9DZTTAHWXxg1tcFppa0YseeZrpSY/g4XMZPKN2YrueDlxN5jCJ9wzRnnlcbxV6qus+Ej7gagtnRK88qexDHdjPrhl0XRFV9kBGEwK37Tzkb6gGNiBCU25IBC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575202; c=relaxed/simple;
	bh=7GKGBLWguxSB17GISMNCbY0yjLuLuhHIMMX5WpM26y0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bNMyZDtxmrUIyWKML06FMl7uiV3G+UwTLqDYV+C2FKy8QHKiy20KSdYeVPzkDR2XCLWwuOjiZIeU2nK12zI9+k7UUK5xtEr6NMOQ91CuzZgE0YXu9W3D7mjnL2IGIbEz57d0gpl+b29WXRNDHX5aTydehwK/3SD+9FCyAG/8e3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKD4ARu5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c07cd527e4so211977185a.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742575200; x=1743180000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKpzgUXaxOJWe5jGFINlc0e7HYmDagFpwzbJE7PXMrw=;
        b=RKD4ARu5v7pPd0ei08Zn2agCBdc4Q4P/kL0GbvqTDmY1XEd/oIB/q9iX0b7wXOFNo0
         8+z5iJ1YZMB04kUN/eL137zMucL6dekaBrgzxOMopu3nGiL6DSYj7bj+vEq3LshChyVF
         ywxY8GBhFfKsHl9jneNE7e7ubSBAU4/lec56dfi/azcPkqYvLJTyx32yFUqDcXq8bYbJ
         iMbs0kr3SnUdBkv9+gqRusKGGXHv5Tq8DHIQkHsnrfiq+LgWmEidXN6+S1VloMiy8t4Q
         2+bVAtHk97aPkeDJbclevgSiW6enIQTG5E+COyW+w4jSqnXmLivk0myBPPkvAHXZzXze
         foKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575200; x=1743180000;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LKpzgUXaxOJWe5jGFINlc0e7HYmDagFpwzbJE7PXMrw=;
        b=gnLpOwShXMwUYPn8N570K8ONVWlEyKz0B+MZU37B05zbX9VNTH7xE/AgvjiIEihv96
         AQPsJ3IR+XfzUjcEGsTFulIndJatCmpIobkjXhsHGk55ABd7rqEp0MlVqqNvLz/4j+jc
         MfGlQDBAyGdU2B440hDvfFqfgCbQm5IUAA2iy07eTL2Hvw5ZN/0oRsHlnV3YSmMd6mI4
         cq8OPIIyNGgZpceKsxmL05R7NN/DJoNZFFhk6ynSwR3vhHRD6USmp4IO+wUgMMHY+/+s
         +l41TOAO5u5VILCdNu3hUFvTa/adNszHTXWQTZKBYlal4KhQIFyfSPgp4FTuwswhwk1T
         +pnw==
X-Forwarded-Encrypted: i=1; AJvYcCUOgwCsNMuhd5rESAKy2DvFPuEREBpElgsoul/+9b4UWC7yU/sGjms7PzXZG4/hWD7FFN2eum8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2NUXeIBmLpsH8KhGpgdxp8QNfhSo7XVlS2b3c67wJXrbVUpkI
	a42+geUHbxGYJHOYXntZL7iUIFbLQuu1RCtccs8xpn3GbznS9npn
X-Gm-Gg: ASbGnctY/MZfUCCy46snPv0oWgZOoqQpFrpxNTIdrXJ1U+hWCNU3sXswnSqlCphyLDP
	7fMkNOAQkC7KaGCCSYjw+06UTP0wpKHO9lo7EcinPbhpLM7xk0+v2WlI/Mh+T/frrOIxJYnnqCx
	JnFAhk0qpdM0vgaWE5LHfJr5v5HbMVbi+GuTfgleQYLm6M8wHNPK0tJQYofd6aahM8vFjE9mGQC
	4ghOw4MW1TKBRl6ZN6FeogV3YrJqwNkgtMJY0NFac0Qs0pZR+Hm9vMnxJXHmoFr7XxKflGmm/yv
	Sg7NB5NT1LDI29ixe69HdCI5ja3/lUt62uVRursKza8vVZYY7WAXpGBQ17nfOyJAwLRjlbWAzjz
	c/GrFAY4j3eKHj35vJgOZ9w==
X-Google-Smtp-Source: AGHT+IHIzZAK2/RUdYe/JbrgklF8qyQFDcvWkBTVM8m6+h6zdwyYwshwSbI6W6qzzlXGqrBqz5t0lQ==
X-Received: by 2002:a05:620a:2685:b0:7c5:3cf6:7838 with SMTP id af79cd13be357-7c5ba1fdea8mr653425485a.49.1742575198924;
        Fri, 21 Mar 2025 09:39:58 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b935596dsm147557885a.107.2025.03.21.09.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:39:58 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:39:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>
Message-ID: <67dd965e2d986_14b1402942d@willemb.c.googlers.com.notmuch>
In-Reply-To: <0d33ffb4f809093d56f3ebdffd599050136f316a.1742557254.git.pabeni@redhat.com>
References: <cover.1742557254.git.pabeni@redhat.com>
 <0d33ffb4f809093d56f3ebdffd599050136f316a.1742557254.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 4/5] udp_tunnel: avoid inconsistent local
 variables usage
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> In setup_udp_tunnel_sock() 'sk' and 'sock->sk' are alias. The code
> I introduced there uses alternatively both variables, for no good
> reasons.
> 
> Stick to 'sk' usage, to be consistent with the prior code.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

