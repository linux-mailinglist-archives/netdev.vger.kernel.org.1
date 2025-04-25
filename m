Return-Path: <netdev+bounces-186706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5376AA0742
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FF11B66A55
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F6D2BE107;
	Tue, 29 Apr 2025 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeJvn7oh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71292BE0EA
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918855; cv=none; b=Dsi4/67/m5yE7yhtdMhoAAettZaMNS45/MtafWwwZxdEYMcK0MKjBKHql505crCUL5W4UbbsJFIm0E/d1fGBMylyk7zkEMoKJ0KR7CG0D2KKvYoFXsgBB/LYXh5LfY8ctKQg6qNqpKircExL26Nw5V0wxs3f+pYqjF24p7mUGnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918855; c=relaxed/simple;
	bh=bPkU7DlnQjuEUtePee8Adf2zIOwv5UDSyIBV9qaEkRQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=dW7tEJfceBmZEwtxW0AlUk2+cmJafT08ism+5NzwYc1vypaCsWIi/Bkt+tgpq8n2ucxfUHFYDh2YdxGgz7pIOz37Q8jEZvYUCDKLASK+4G/kZ5WjL0STsUUd/WFmvJa4j9MH6MRgcQh/NCIqaDNjxpmFnG8gy+V9lNJg6t7lDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeJvn7oh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so54185375e9.3
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 02:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918852; x=1746523652; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPkU7DlnQjuEUtePee8Adf2zIOwv5UDSyIBV9qaEkRQ=;
        b=FeJvn7oho2jOadnEE4D6Wgk5ZYj+mjuvQl++Dk6V5z2jueu0V2H2MZUrR1VAxbwoOC
         5WEgdsa2RuPGcVEbGjEhyLBB8dfwXcHVt5DLBEkmGlDWdHxYtKm8SO5ryauc7pdzYTEX
         ymjglUj/39ye841XwU3heLPo5GWKuGRI846icsERV3fhPK5CtREeJVKLtldC3Xg44dg8
         Yr8x5RpK49v9eu3iPdAt4WSNdrJ3i9CvloBxxL6HiWicrkhIJ69PEfRawzVVJYeq+WJK
         +gfbpCaYjD04Ord7tko8DGO5MD4ZsQsFMPYiGRygew7k/qvFwJvejdIPnmb2E2S2op6H
         sdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918852; x=1746523652;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPkU7DlnQjuEUtePee8Adf2zIOwv5UDSyIBV9qaEkRQ=;
        b=wOYNvLGZxoQLJdnt3gprO+lxnaQCtgpdq3mDqMfW4Z9xVkN7jhoqDDaSwu6nBcSi4o
         EDAPORAext/BouX24gCHQ5HLbFhTmZQvF1onSKiDSw3JXM4tEK4HO9R98xpPbhk63JBV
         dEbR9lnvjrJr1yXzwnCGtDmV6IyY3hIqnIteSE3U1+67O1ToLjO2aCp1CUe2zp2GdgGM
         Ur9rDrGbDPSpEzu6CydC66l/5IBmn1ZNFJ6Le1jspsZ1r5D0tZdO5n3qxI3ilfLJXk0N
         fc8AGO4SDimBdiLN+w2V0ifVrRC/hj97ozQSqOZGzuCf/DzONykXmR+qRta7jACJxdvP
         TS2w==
X-Forwarded-Encrypted: i=1; AJvYcCX38McsRvuygdWM707or4OSpXEKQKDYl6dpOD+MbritibbTyeDftaZbCjidFkXvYbFSh88gvRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQDmYuPbdXDSgyLZkFS+inbWfmXvvNwD0e3+EMRAwf+nGWHqY
	Dkc8fTVgilEITScz4QYw9w6ZXksRyyoYF3xqwNOI63ZUdSBh8pHe
X-Gm-Gg: ASbGncuDkoEw5QaZSiyL+ObbrBCBiu/jW2Bi/eS6ebrR8EgjFEXL9nkWg0CUxa+xGtu
	Ksf0prgDjAtjQ8L9C5GkNARKZtm+D0pXHJjH6IwX6VVhnkNQjJCcOaU9Np+xP7ydDxZFNL8GGnR
	138enKrAzF3tQA2tJZFeoyoLp6XRp7ufUE8GG3K8vVXpRM08PsjTvb9o9GORw4wZub8lYrvyOJv
	+WdOCeoNsnz5B0iFHyhch+kI2WnQ2JQNvYzqQDcSnAgbA+qzmHymW2FirvPbJUVOK9MY7NsYYjn
	19vET7+mbvodUeEhAZ3REF8a22K6XT+mj/2/63QRbu7bVPjMgDsUmQ==
X-Google-Smtp-Source: AGHT+IEa2S+qo4iLpQBYbAzfYD0IDyiIr7LGXxVQhiytzzay+0PoCwfcxSu50A50fB1HNmXCheDB1Q==
X-Received: by 2002:a05:600c:138e:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-440ab7a0266mr109655525e9.14.1745918851711;
        Tue, 29 Apr 2025 02:27:31 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:251e:25a2:6a2b:eaaa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a538747esm149024125e9.35.2025.04.29.02.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:27:31 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jdamato@fastly.com
Subject: Re: [PATCH net-next v2 10/12] tools: ynl-gen: array-nest: support
 binary array with exact-len
In-Reply-To: <20250425024311.1589323-11-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 24 Apr 2025 19:43:09 -0700")
Date: Fri, 25 Apr 2025 10:56:33 +0100
Message-ID: <m28qnor2cu.fsf@gmail.com>
References: <20250425024311.1589323-1-kuba@kernel.org>
	<20250425024311.1589323-11-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> IPv6 addresses are expressed as binary arrays since we don't have u128.
> Since they are not variable length, however, they are relatively
> easy to represent as an array of known size.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

