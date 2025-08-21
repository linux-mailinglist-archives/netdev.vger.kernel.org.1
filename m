Return-Path: <netdev+bounces-215773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F59AB303E5
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B8C1CC52F9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF82350839;
	Thu, 21 Aug 2025 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYIYoMlW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9734DCE3
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 20:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806843; cv=none; b=tIigitbjneXs542bPR+8Ve1X9C4JBB7DVb/rX0JQSDfmHMOuNVkdp8X21CtS32Ou4eFIy7+6CULtmA5yP8S3/5F+/5+gxdL6Qpy8Mbg6DOQXbC7IFPb6HhNr7EkdtDnkA/cuHjkfhKFhJHrILGff9ZoBgatj3QS8TFwV9jclTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806843; c=relaxed/simple;
	bh=Cw7Tggvlta2Xmlg9ZVygUv1C92bk8NKTD0n9SH6aeIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQPGC5PwF/94uwQojqVNYjeTWoZ0VUDvJsbT4sfoXES/48FfRZVlwWriTf8jylGmDIUCKKpO7eN0FWZeUpWnA1/OZ51kKpCg0Cv42yYhDSVPBNnrsk3lbQj0umRWU4HLljfWquEOxhyxtreHdiO/mZoAX0h+SRTeLsnkLMGiDns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYIYoMlW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU84NUWejaBSUFBs/T0/O04YrYLlq1RcxZMywEFGjU0=;
	b=WYIYoMlWacp2r7qNmwcpi1+0At+LSwhjqbQA/jXa0bs/nyO9JlTkYZwDqUnePI9k2s7ANo
	dh7FppcVyrJTlwPunLc/qw9melOsZxQg1sqaVcroQMVlKCbypmteAHrvgPMjDaL6C2WRFq
	Q1hxU6iMy3LaqBQ4CtK2xvmsqe31hvo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-fifIPxwPNhiCg0Fr3_y7Tg-1; Thu, 21 Aug 2025 16:07:20 -0400
X-MC-Unique: fifIPxwPNhiCg0Fr3_y7Tg-1
X-Mimecast-MFC-AGG-ID: fifIPxwPNhiCg0Fr3_y7Tg_1755806839
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0b2b5cso10135145e9.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806839; x=1756411639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU84NUWejaBSUFBs/T0/O04YrYLlq1RcxZMywEFGjU0=;
        b=KLM2F6gNnND1+QTSYLC3It444s0iZSAPyINtYu9m/mEz0Bay7va+XTouOgR0sBxJUB
         fIU/72mWfIxIn9xKYdnyCzITEoVXAUb7QO0LP/HTYuqG4OjltA5hgemum+5FH7SrkogH
         9NQ1cwe3afR1ptKZKbqmwegyY2MDfkDMkqC9ArB+X6YgmCdQUTc8YOLgXH6ErBz9CosT
         Z5ANlucDYu6E17osXVly297fWnlAE2qdwwQBR3E6/UqK5Cx0ppfwb4PJSNoZBLCaBBK+
         1bF6HiGyBs/sJ8tGQBCio+cjk5hjnK2AXlsPCxZVh+8eiaSMz82CsF8QWaic5CiEh4dW
         dSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG7hlAfa51jtjLdbV8Mbze+Bc9BTILar4GusFR3BrpPf4vKnx9Dxkcb5IiDe3odEgiIek59C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHpE6H3HbPTWxAOgMtgrB/mBS/9Cey//gpURFOWVeAxvjcZSKS
	2WXP7QxcbpLR/xbS1+ygNx1cXTnle9UdhC9Ot4jR3q5yDpy9RyBbIy6/TvNyosU153VlMRbMoAw
	zYAqK4NjtLG8vil+VL4pPOgHIZD+ZREAVkCBR+aGuEZbn+HE/o78OP/cCbw==
X-Gm-Gg: ASbGncs+SK/YMxNziZySVgLfMlqQruXrf3Nwfq/xdNl5ZtujSrDB9g0PUNOWCg0/O9Q
	P9ffTZfIG1cu6yI3R9K97OUDbxLTZlcDfBkYOpuSdeIw44BNuKwQlT4FuI66N0U5zlcG/kokGnc
	pfaphpO9Fxd+BtN5Kfx/TX+nIqDR/TJS1FQolxYwKR6Infj0gZhbkxtKsZHlmRKJAuCpe+Y421s
	9w7dLpTQaJ16kjCfQiyhOPN+kUQblVV+gIziVe3nShb0lsNIyB4I9jK6nXcuFWTrV5yMwkkmxHz
	ekqyyRFaIX6L8t1uzQR1Y/BA6VLedYCCmppfURwiGnk4vWjIhmf9iTxI7jrNqfr2PozXy3xAf8b
	VvzuiWpibHYy+Qk/TdPbifw==
X-Received: by 2002:a05:600c:1f95:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45b51799428mr2845545e9.7.1755806838961;
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMhnqxttMNkrL8PAxIX9Mfq64uKkvY2MjzJ39LtAH2Yg7PxwVl8kOZ6CXLaaMF5rYTxrWwyA==
X-Received: by 2002:a05:600c:1f95:b0:459:db80:c2ce with SMTP id 5b1f17b1804b1-45b51799428mr2845125e9.7.1755806838506;
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50dea2b9sm8988005e9.15.2025.08.21.13.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:18 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 04/35] x86/Kconfig: drop superfluous "select SPARSEMEM_VMEMMAP"
Date: Thu, 21 Aug 2025 22:06:30 +0200
Message-ID: <20250821200701.1329277-5-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now handled by the core automatically once SPARSEMEM_VMEMMAP_ENABLE
is selected.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100e..e431d1c06fecd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1552,7 +1552,6 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
-	select SPARSEMEM_VMEMMAP if X86_64
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool X86_64 || (NUMA && X86_32)
-- 
2.50.1


