Return-Path: <netdev+bounces-119296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18E5955172
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9A728971E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADFC1C578C;
	Fri, 16 Aug 2024 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4J0mSn/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7021C4624
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836323; cv=none; b=tUZqlQicUrz9Wfb+uvAS/TXq0Q1VTDjAqNPWLehpMeweAkWvzUUo4J/AVBPdQ6GsKCzqHPS5GSbmqTjDP8wfy4ZG9v8NwkVmCyFzC6sMuAnI02euul1L/QjXskvQXAsOUCWT/y64mg1BNVG+98SU8RInlsOFNeh4hevGZ6g71Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836323; c=relaxed/simple;
	bh=9q3nZ+xHzxr5XUGYLZYNiQX6sQ+nlFwjeNOs35QAlWU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=f2W5C5/D2nseeWqAMMiRwRbLf59Y92Z9VseHOhzTWdzSyU8B7JTldXZ6dailLzAv/zDIbZi/tujmmGTZcu1xgfXdU49lWgXwsWiqv3CkkpWAdMzlZL372Qj/A8hqGn4Xp7zdS0p7P8Mj+/kuzKH/cqBpEX+qoeWz/xS9zlQKVf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4J0mSn/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1d7bc07b7so161718885a.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723836321; x=1724441121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11nkz21o5HeNT/A8QlSQcZsGnlPkaaKcGzoj1oCa1LQ=;
        b=R4J0mSn/DPjD6Y0wqPMQ3yH3L8UyUn4OXqgfkHRokJkVrSloAqBKjzY9n+l+bmtLP3
         43IRM9t0swZPksv/vGB+uI4M5L1o+r6PMiC+T/Psmyor+t5xbS2xJvNDwmGjV47kW70n
         DSR/Q75/uiWd9NVTzYo/TZ6mCr3Fs/oN6qM+ylmA692kMx0HTdNJ+Fva2oGm8wqviptY
         Be8MTpyzfuuwDdvkxXVMUgrm1Cy7h8LzYbNGwV1gnDI2qhK2fKvTvk2te4i+S/wuLh9Z
         S/isuxtAwQsGjDGkUUrvXY/5iKFgrgNcgD2ET689JPM03gE9jVAgNM5hsMs7MMAohNuF
         xhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723836321; x=1724441121;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=11nkz21o5HeNT/A8QlSQcZsGnlPkaaKcGzoj1oCa1LQ=;
        b=HoB5MCVYUJL2tn7g4zAq45DMioOjdt+b+7+5c0vXHvOETV9OtseTnZyYP6CrAciZ1b
         aGSQ5o3LUfGcNqOXgt4XBoS0fsJw5MkbxGcrrd542Uz677QBqrSBl6zOXqDDkXmOEZOT
         1lbnWyfw4qqWnTmsiwB9SJqM1JJZNU3buixO+LufhL8zRz/K+8RRZ5jNUTxpXFTkuqYO
         BOkgi6+geuhUe8E3aYu3zuD99bqE3azCMabA+O8Q2FmYN6D7nLB1OhKbapm7xEBcbFeL
         o1kevKSombfzZYOEFPYA0/UR3EOpvc0hvgZaUn+HRHN6cYORdss1jeLF5GPXNhXGlm4C
         q6aA==
X-Forwarded-Encrypted: i=1; AJvYcCXzWwconkM7WBq8g1J+kDaIatqqw7Xy2sHuOcwt4Nc9oMHhqK3YjWVUSaENYGE9h69wvDzDUUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznp11peWfYwt6XohDp8K1d3HCKVnd2ApSBC386O0xe/TAnrIEr
	yUtE0Qkxup2WyFWqptEsZe69vwcYsCiruleh1i1idR0vOpcRNxkE
X-Google-Smtp-Source: AGHT+IEpGvDoIRnydDPwP1Bw9Y7Ixofui7Mr7Sic4rVPGrDtIczs97pJpRLwBSEZWdW3GHyI1Qw5XA==
X-Received: by 2002:a05:620a:450d:b0:79f:8a7:eb8c with SMTP id af79cd13be357-7a5069cc48fmr412751185a.52.1723836321216;
        Fri, 16 Aug 2024 12:25:21 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0250b8sm208055685a.3.2024.08.16.12.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:25:20 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:25:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io, 
 willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66bfa7a06107e_189fc82944a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240815214527.2100137-10-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
 <20240815214527.2100137-10-tom@herbertland.com>
Subject: Re: [PATCH net-next v2 09/12] flow_dissector: Parse GUE in UDP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> Parse both version 0 and 1 of GUE encapsulated in UDP. Add helper
> function __skb_direct_ip_dissect to convert an IP header to
> IPPROTO_IPIP or IPPROTO_IPV6 (by looking just at the version
> number)
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

