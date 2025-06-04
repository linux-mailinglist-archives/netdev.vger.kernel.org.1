Return-Path: <netdev+bounces-195123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C70A6ACE279
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D6E177ACD
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059131E5714;
	Wed,  4 Jun 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPerEtw6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD21EEA40
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056078; cv=none; b=LL6TAwwooUiSVRm+lrXyo6YK5Xk+wOkesLdEmq4pwTIq+GCg11cB+Y+GV7OVnPhZLbWSmkRg03BLtMtoXoDFzDgS0PmMhebPjj0m2A0oMtkXOA+26MI3o5NvM4TeH5MKY5lQbi7oDDKjbTOqplPDPKDtXDCtcganSSQlQGhEDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056078; c=relaxed/simple;
	bh=tcd0Zzewl9fyLQbRjA4EgreSr8MAtbggVIRO6sDPbgk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p61aAGkhntgL/HP0NtuMtu1BQOqyIhSi5gsFq9023bpdVJQ5Y4TW7VXJp1E7j0yB+1UO/70nfWOlOSXLhjqCywuF3oJvJXzKKL8/pbdOd8hcCtRssA1TS7Zuseje9DqQ0AIGDFtRUpkLz0rmoGZsOUXrPbjd8iurgk9zP87GB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPerEtw6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcd0Zzewl9fyLQbRjA4EgreSr8MAtbggVIRO6sDPbgk=;
	b=QPerEtw6abZYCLFWTCNtRaVxfKkQZfzzrW+fSj+Ov+zpbFVesZVmWgml+oakAlafszWpvd
	WBXp3CRuLf915GQdxcWA87GD8EA+VZgKVuF5ZggyCVcxW9JQwcuVsGjwNLMkuWXC9QEt73
	YnFTEJ6W5v4pOvL4BebIIvO1M60GWsQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-iC5x65J8MXaC8-iPnz05Ng-1; Wed, 04 Jun 2025 12:54:35 -0400
X-MC-Unique: iC5x65J8MXaC8-iPnz05Ng-1
X-Mimecast-MFC-AGG-ID: iC5x65J8MXaC8-iPnz05Ng_1749056074
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-adb3e2061c5so124993566b.0
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 09:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056074; x=1749660874;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcd0Zzewl9fyLQbRjA4EgreSr8MAtbggVIRO6sDPbgk=;
        b=jfBgQINIoHaPGijNZaWDWb4JiQO3/FDxs2r/s8cRDk+vnDpXFFYrh83buIlM44y2/n
         ht0yElsjDOo/S5uX2Np76Tus3x8o3uxSmjUDMESO/jBSJM8GBcZDG20OKSzhQuyCYkx3
         SndixJv8IurPA7ejVMMyVnohKhYB7YDPfBiUJixow4ykFrCPil5WBUPdpFqAT7EYNMJV
         6RCwdJkxy8upGWMzin+1UVAHKP+jhnYw15Gp8ByHNFAYKAbwaHpKBHX5maH7GwMXJcv/
         6cY4nLznbXX8zjwobu4NVQ2sOErwMUfguQN11/mBe7dhnJiQGkhxovXRVHuvpDVTMQNz
         6L8A==
X-Forwarded-Encrypted: i=1; AJvYcCXdrJmmHMx00iOjfWLXJbYfIb0X7FQY4hfTQmC8MfvZmHIr3RNNMAXYhHFEp1bT6xYhZMVp0HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG/0PAJr8ZuM+2xa4Omh8iTwiZ70zgMjc5CmnuDDvNz149vCqr
	JotlQYfHzBv/bOEp8sootsRHpdeW4r2+Z1tfgu0wJhl0zh5d6IQiWfobTQjZYP9CHqaVmgCJZwJ
	kEKuortZ+QXB95txjydEZLCgmyNE1MVlfGqv1CA+uLUwiClHkMT+6QmhbrA==
X-Gm-Gg: ASbGncu45vt/98SteJVE+pSZyRyoMF2CvTRROwq7WZACkrwHh1lVnz2Ndx7KR1VjmDD
	elGZHoe9nmdKj5fhPh7p5a78MahiYWMuPeyq88liAmuvjOWsmpXfpF9wFI4yHj9ihFOhpgokC1U
	rV4fFn2Ypm4bXXudIalBcHLi92RdiTRR+XZY9Qe8LcuUp0m/iHIG8N05Mwxjvbr76V+iz0cBPGT
	uOi/kPxQPvDWmACQuClOSSC4ONR7WTQcYZHGx7EUwxJrLH9paZ88LeV3P93Jz4NrVb286n3ZISz
	TazFWG4k
X-Received: by 2002:a17:907:2da4:b0:add:fb1c:a9c3 with SMTP id a640c23a62f3a-ade078fb9bemr25782666b.28.1749056064071;
        Wed, 04 Jun 2025 09:54:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+FyEzbRQ7ljsnYaqZEY9RyRG/Pit4hUmUJvWYN4/otGwuEi027SbI5iZa7eBk4SkzaaVb2g==
X-Received: by 2002:a17:907:72c7:b0:ad8:93a3:29c2 with SMTP id a640c23a62f3a-ade077dafb1mr27934766b.14.1749056049265;
        Wed, 04 Jun 2025 09:54:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6abc2sm1124547566b.173.2025.06.04.09.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:54:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9A0E71AA9158; Wed, 04 Jun 2025 18:54:07 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 03/18] page_pool: use netmem alloc/put APIs in
 __page_pool_alloc_page_order()
In-Reply-To: <20250604025246.61616-4-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-4-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:54:07 +0200
Message-ID: <874iwvwiq8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> Use netmem alloc/put APIs instead of page alloc/put APIs and make it
> return netmem_ref instead of struct page * in
> __page_pool_alloc_page_order().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


