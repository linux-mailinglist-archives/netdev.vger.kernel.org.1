Return-Path: <netdev+bounces-225363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C05E0B92C68
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D019C1903DB8
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A717531A556;
	Mon, 22 Sep 2025 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUQQxhfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234B1DE3AC
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569329; cv=none; b=D5H1LZ1RJB2SzoLAHzJTbG4TdDkdLDE97dtYBeC2ug8uvkcUEID1UsZaNG4Zw306TdNTHtLTI3F+TeNlfdildXsayrATv+XLQ9cSCJEa21irXRHfIuevDYuuc13ZPuPdVCS8RBipLWy84+vXtvVbGNWPD2TYztMoPOM44kN7gao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569329; c=relaxed/simple;
	bh=zSkwFxdawuhzp1rpRWhOyjFp/r0ht9I8B+KlJS0Nahs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cYyL6F8Xs+3HayU9XjeyQTKdbzvKScG1Sj+O1pY3KvYoAtExSRj41zrc/0ssd09A7KvE/80WLYwvJukDXNwIQn9w6WNSLaHK5h/ntgRelxmUCXMPuw7UNYJQxRVltpxld7QaaJUxGJd0rE3mq3Of1dDQV4LAmeLIoxKbISdo6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUQQxhfy; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-799572d92b0so38052646d6.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758569327; x=1759174127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxb0la0Xz6K3HZRfHiufAhiCg3Bf0VK65WFpq6/jGV4=;
        b=AUQQxhfyEGIQJiv/zp4tpSpnjN9kcWbkpfMo46nL2wkEc1fFdwaay3HXYkNW11oKE2
         cyDLHglZ1dgKvzmQh6i6JERPQPXCu34zPRv2r27PwruDVkK7T65gtSYnyjZfKZHqWtrv
         F6P0WZ9OPSUTht2UOYIyr8WF0pkl2mPaCAxBwbtVMSrvCJ0LvjrPOC+1v6HJRt1PGw0i
         eOMNOTn9XjnMwHO5DqnmmGcKmv61s3iZOTYPyNHV+NTq+2WkAc5kJJzaJfj7pf236nGx
         YiOQ+WufyqiEswo+s0+NVc7t5RaBW0+MfDn7nQUrS8f5aRbEWrYv/eJejljOMYWLJG2B
         iMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569327; x=1759174127;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fxb0la0Xz6K3HZRfHiufAhiCg3Bf0VK65WFpq6/jGV4=;
        b=WpqB6DiMmPmtQ+XWL+Je7Oh6kdD34+dXUTMmKBHCwTMi72+Votaw/hRH2MrsHmKH0Q
         jngFDMV5uBndjinBM5GJKrNhCZvR+dnZ6WXUcgYRJ/WeV2IPG/+SYR3z3zaEdR9bY+Gk
         aNau5sa5O04fxYQLzxG8YIFIHGul0lwxlIzkKLE6uXxxrZaKlV4HNc6sLmzQq0L5aatQ
         Gkx4+UFm91i8j4DRItF1haw3xS3QxTrKSpyyH/1y/HwIhAMc6M1qXS/K3TvLpZN4Lh4U
         pAeWSpAbK27iO7Acl9nRwHJMfYxlqAbjsp8+zE87ReGeTQIGhe5+Ffip81oNoQJM5M/n
         DRUA==
X-Forwarded-Encrypted: i=1; AJvYcCXUcIL2IhKGQXVtIXZQvhdg7V5im2hDD8Xp7turb72GOkr7UtGGp8tiMJASMLAgKdeEppkBjj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGa4nMQfppRVWg1pY3vthPFk3xZzDkjz0YVYj+DkuZGf8e7uyW
	jYF11ht/4T+kb4WAxyOMBAatKoKA4yzCWjxkd8W2KjLcA31s26Nqu/KF
X-Gm-Gg: ASbGncvKpnoTZOcAUUJhjOWEUzhpinLcmyKFKNOyGNLsxOvoQMbKeW797rZ7wwxRBn6
	jTqsnJjjRrdsK3j8fHgAt9cpam0/6hoP9YCZZeOqbYSebksimM6KdjuY1CBmcy0110IRD8M5Vo9
	/2uNsNlj1XtmkuXS3q2qxtBCfQBAszyLO2dkLYIorUtn6A9JS4lRdd7g5CEvDY+Se1DZIqWEuQw
	4wKYajq1gW+EATQELAt7cDFpvfwwwE5vWRsTzl7VzMztz697jy+gxSmOPYQsaQm8WJUPHyhXiD7
	uWELRXXAUUww9VK9BECL6Xdr2mg2HL3cF1fah6qH/yOYU7ZmfkWh3z1IAtaX3CSxSqMZUkAqBXN
	TwlqRfIW+LQZcFijwjB2RKIg6oP9zAmuF5IP1iDlzdmC+lIY9NUnBXv60Zf0dZeOCU9ikYA==
X-Google-Smtp-Source: AGHT+IEZ7ogsjwn/ejt4gpuz+nTAp6KlpElnbRIi//vPnug23cysGIqoyTYI3LYBuPZHPV+abeZSlw==
X-Received: by 2002:ad4:5c6d:0:b0:783:cc80:1770 with SMTP id 6a1803df08f44-7e707658d4cmr902906d6.25.1758569326786;
        Mon, 22 Sep 2025 12:28:46 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-793516d7c7dsm76243486d6.35.2025.09.22.12.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:28:46 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:28:45 -0400
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
Message-ID: <willemdebruijn.kernel.259fe4b84bba8@gmail.com>
In-Reply-To: <20250916144841.4884-3-richardbgobert@gmail.com>
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-3-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v6 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
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
> Only merge encapsulated packets if their outer IDs are either
> incrementing or fixed, just like for inner IDs and IDs of non-encapsulated
> packets.
> 
> Add another ip_fixedid bit for a total of two bits: one for outer IDs (and
> for unencapsulated packets) and one for inner IDs.
> 
> This commit preserves the current behavior of GSO where only the IDs of the
> inner-most headers are restored correctly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

