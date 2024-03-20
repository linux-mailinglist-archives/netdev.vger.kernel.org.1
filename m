Return-Path: <netdev+bounces-80814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE78881270
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A29286842
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13FE42065;
	Wed, 20 Mar 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIijF2lc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852C41233
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941941; cv=none; b=KuFBiK1t0I6qhJ6lDmhaLHGst3BHNrqybLWhAyAZRFMrggsf8N1hVL51+fbTucGv77BaWk1gzvdHSAXqlcMraa/KVOBRyU4oVaY235/rtscx4tXCDtR7E84HqZqpoNnTGaLDM5Kb9fGe488x+YjlssPpdT+5tmbe3rkcstG3JZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941941; c=relaxed/simple;
	bh=8HG3lMRM1eo4wBzIUV+zS7eMBAvUauYxIjL5f0ACs14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwC0IJp+cUtffXAFRotDeaUMuINswTn+U/lD0tA3l6dBbmmedzt3XeMYjz7Lh47yVngBMpK9ijKgC4uIrFNfY9AlCvu5GjWrk0hlZNbgPqawvNxqmUIertorMSpeEsVQw/HCIRdF1ikm8FE0gw1QgkllPlbEK6kdX329HH3gJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIijF2lc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710941939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obHBarWxk+ROrmEnXbSe1lZadfgNP9noxnJHktLqcg0=;
	b=fIijF2lckeV7fXJY13IxInAZukYg67xcO5Jjv4B2CznYXToVOUrhYz8sRefYuABL9on9Yg
	FkwzPuQy8eF6ekxBAch5/SWxuhXqBjRXsqpZy0Alz4J4QU2ZwKPZcQYb6oAmfNaNA+1rS1
	JDrhKoHOY3oILG4FApISHtFKP/J6TIA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-pYPacII4OECEEpeoufjukg-1; Wed, 20 Mar 2024 09:38:53 -0400
X-MC-Unique: pYPacII4OECEEpeoufjukg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D412C8F4121;
	Wed, 20 Mar 2024 13:38:52 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 713721121306;
	Wed, 20 Mar 2024 13:38:51 +0000 (UTC)
Date: Wed, 20 Mar 2024 14:38:49 +0100
From: Artem Savkov <asavkov@redhat.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Xi Wang <xi.wang@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] arm64: bpf: zero upper bits after rev32
Message-ID: <20240320133849.GA142600@alecto.usersys.redhat.com>
References: <20240313140205.3191564-1-asavkov@redhat.com>
 <ab5e6307-8d80-4751-940f-4faa5bc41d82@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab5e6307-8d80-4751-940f-4faa5bc41d82@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Wed, Mar 20, 2024 at 07:34:46PM +0800, Xu Kuohai wrote:
> On 3/13/2024 10:02 PM, Artem Savkov wrote:
> > Commit d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
> > added upper bits zeroing to byteswap operations, but it assumes they
> > will be already zeroed after rev32, which is not the case on some
> > systems at least:
> > 
> > [ 9757.262607] test_bpf: #312 BSWAP 16: 0x0123456789abcdef -> 0xefcd jited:1 8 PASS
> > [ 9757.264435] test_bpf: #313 BSWAP 32: 0x0123456789abcdef -> 0xefcdab89 jited:1 ret 1460850314 != -271733879 (0x5712ce8a != 0xefcdab89)FAIL (1 times)
> > [ 9757.266260] test_bpf: #314 BSWAP 64: 0x0123456789abcdef -> 0x67452301 jited:1 8 PASS
> > [ 9757.268000] test_bpf: #315 BSWAP 64: 0x0123456789abcdef >> 32 -> 0xefcdab89 jited:1 8 PASS
> > [ 9757.269686] test_bpf: #316 BSWAP 16: 0xfedcba9876543210 -> 0x1032 jited:1 8 PASS
> > [ 9757.271380] test_bpf: #317 BSWAP 32: 0xfedcba9876543210 -> 0x10325476 jited:1 ret -1460850316 != 271733878 (0xa8ed3174 != 0x10325476)FAIL (1 times)
> > [ 9757.273022] test_bpf: #318 BSWAP 64: 0xfedcba9876543210 -> 0x98badcfe jited:1 7 PASS
> > [ 9757.274721] test_bpf: #319 BSWAP 64: 0xfedcba9876543210 >> 32 -> 0x10325476 jited:1 9 PASS
> > 
> > Fixes: d63903bbc30c7 ("arm64: bpf: fix endianness conversion bugs")
> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > ---
> >   arch/arm64/net/bpf_jit_comp.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index c5b461dda4385..e86e5ba74dca2 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -944,7 +944,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
> >   			break;
> >   		case 32:
> >   			emit(A64_REV32(is64, dst, dst), ctx);
> > -			/* upper 32 bits already cleared */
> > +			/* zero-extend 32 bits into 64 bits */
> > +			emit(A64_UXTW(is64, dst, dst), ctx);
> 
> I think the problem only occurs when is64 == 1. In this case, the generated rev32
> insn reverses byte order in both high and low 32-bit word. To fix it, we could just
> set the first arg to 0 for A64_REV32:
> 
> emit(A64_REV32(0, dst, dst), ctx);
> 
> No need to add an extra uxtw isnn.

I can confirm this approach fixes the test issue as well.

> 
> >   			break;
> >   		case 64:
> >   			emit(A64_REV64(dst, dst), ctx);
> 
> 

-- 
 Artem


