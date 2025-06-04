Return-Path: <netdev+bounces-195129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3197EACE29B
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C44189974E
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EC3139CE3;
	Wed,  4 Jun 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDNhrA2t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F2F1F2382
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056201; cv=none; b=XzoezVyvBoFQ3cx+P/DlCa2EfjWpzzuaryEhPT0RAUK2za7LoF+gUVKUD+NYxo8Z1qNgd7iBi92TCzRXalaG9kAwgvpsdjfrzCyKAd5de1/RODYNkQWU5hX8HQdlhd2yf0jHsGwaOrIwfhIpOdN7ZWcour5AVY++orwMUF9J5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056201; c=relaxed/simple;
	bh=hHWkN+1W3r8pcWm5IykqgahYA5ORV1Tz/OpKi1g0bhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pxIucFe+lH6zE96OJMlZ4t3oo8AzriKVBYiLqyh4QYM9xmY1Fk/p64p3p/gdJgBAaj9qWJb9ysLPVp/9RTkPiPasez2uaF6c7L1pOtAjzBYRZGMgyOzSzfj9vDMvbbJuroN5JCiOTUYNE3uzLe0qnUSzesUu1sM6wfP8h4eAQSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDNhrA2t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2I81AuUlYQ9366SJCkTTKCrVJZ04owtIVy2X3Og2iB4=;
	b=FDNhrA2tBSuNsYVdsr+ntslc40l//cJPdwjELnunNdTvwWlzRmLXNJr0/pNnoqowpA0f2/
	ExQJ4rQ7dyXaEKSKYZTbTjQrLB5h+2Ou2f7AyhHdw9/LOBR5gITCF7Fu/Z2ndev4CS2eL5
	fVtJEo6/sYaXDw4vSdJXJ/kkqp4rXlI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-B8DF-BTjNiqGqdlaINxfPA-1; Wed, 04 Jun 2025 12:56:37 -0400
X-MC-Unique: B8DF-BTjNiqGqdlaINxfPA-1
X-Mimecast-MFC-AGG-ID: B8DF-BTjNiqGqdlaINxfPA_1749056196
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acbbb000796so7706466b.2
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 09:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056196; x=1749660996;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I81AuUlYQ9366SJCkTTKCrVJZ04owtIVy2X3Og2iB4=;
        b=pJWYfw/KB6ZbghkB/zkDLNP8VgB47K35BdYF4aKX5Vef1lEwylG27jGnFe82gTk9LG
         pZW9swoIMh8ZOlzf3ODBPW86K1IHje10X6X1VvmEvjNO0SS95RiOuMQBP2YSSkOyBAJx
         ql1K7xpcrj7IUC4v290pp9w/cQCsEBjd1gxIcj/P/NIwswBWPChOcHOUZxAo+KKE6www
         TTXJJi/eLxYE3tmqmA0TLbGwb6/81wkCZ3C5K3TkHXM68HuSYH5H1NJ4ec+ajtkP9psP
         rlgmslomB6bk5H99jtSjd2TB4JZRjpg+3Hqez89Pda4gZhpRuFEEw1XRfZEzNCMq7Bl5
         Ezzg==
X-Forwarded-Encrypted: i=1; AJvYcCWM2KDr+SQjZdqPbSye3moUmKDb+H3UFDF0fJRGf8MsQcAaFhNzcl2jHA6Of7jQgAzhfPDYg54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjMH7SBtYSSJasO5evA86ncxNveMSCZGzjqzzQkjhlmJ3nSx+y
	NtFPbkrMmQBv8MsSNEZH7wRG3/pbUg2IzHaN8/GG2PKoQVLe3udUlC4zvBQenDFjybnFuDFjLuz
	HFhpa1sySDcqAB/BYYI/vXMe0N+wZilStF7Ul/4NCOdf7JKyOBbBXLJel0Q==
X-Gm-Gg: ASbGncv4e/uCcfrgFhPpk/CJRG29tPxBji+bti15rWmFozl0n7aI9l6nunFCN3segjx
	lO74AAue/4obS/RfNVDRGg2r/9OihqVymVAaIyTf3VhyxJy3rSdIsC0Bw1d2gzLG6sXpDLEidOh
	wXs1ic15kKi0gbVW4kzugpP0j/UGxF+ixhZ15n0nPMt4Zi1k9+uY9UIa/yJ6Dg/vMm+8I1w7lcV
	jmtC2bZffeOKwgUy7vFLQ7+Of8IWnHIF3NBt2d9KNjoaRJPIpESLWo+GlpBXCw+Q0SPxYLG2uaf
	CSuiZayo
X-Received: by 2002:a17:907:9410:b0:ad5:eff:db32 with SMTP id a640c23a62f3a-addf8fbbcbamr374234866b.48.1749056195783;
        Wed, 04 Jun 2025 09:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyDZZleVWiVesfO9YTAhzLK2xLG6f1Ssys6/5lTY37/ymkAbmNiWcQtPEP0I7NoOuKWqtMkg==
X-Received: by 2002:a17:907:9410:b0:ad5:eff:db32 with SMTP id a640c23a62f3a-addf8fbbcbamr374230266b.48.1749056195333;
        Wed, 04 Jun 2025 09:56:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad39f08sm1135981966b.144.2025.06.04.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:56:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 06E6B1AA9164; Wed, 04 Jun 2025 18:56:34 +0200 (CEST)
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
Subject: Re: [RFC v4 13/18] netmem: remove __netmem_get_pp()
In-Reply-To: <20250604025246.61616-14-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-14-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:56:33 +0200
Message-ID: <87msanv41q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> There are no users of __netmem_get_pp().  Remove it.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


