Return-Path: <netdev+bounces-110602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F43E92D628
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 18:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BB528AF0E
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 16:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAF4192B96;
	Wed, 10 Jul 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzGj5BDG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490D18EFF9
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628374; cv=none; b=i74ORLbY10/0ioxuJ1oV4W2fKj0elLpgBas/8+ibqi8dX7ZmZT3a/UXs+AaRdX8ojA5idCtFPk/coUMfaG5wL0QIztPzONgw2EDFYsPZfRv1TM9XglXVJ++xKxb/cd/COOTQshmb+anuK9CdbMqSMwgR710NpWUinSvASgI8zRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628374; c=relaxed/simple;
	bh=Chce1rrJY0BnzM4+QZlqMrwKVqtoRAIWdssG4Erh0g0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tDASf9wUkv1iTaGfJ62UR/w3NJinyuQzWW5zealaA4Zl6SXYUhGOSQws/8xumqep2S4SknR5Jh5IRLAwMpO1Uk4GSkuuflenjiF7gjzf14ZaokasB96/aYKTiPBZkFq4yKTw5cYxnAzv8tIbYi+bB79k8lCQLxCMMl/XZ7GAfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzGj5BDG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720628371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Chce1rrJY0BnzM4+QZlqMrwKVqtoRAIWdssG4Erh0g0=;
	b=GzGj5BDG3TFd4MmhG78ORTUM9GYLBac9BIy4UFJFOtQ/k4gh8o3QzxJTdoXr/+qm8/XLiS
	xxHOX9OixBH8vxR2/Mz2WTSbvRBKU0e9hlRbJuFkZysGlXQuoQLSIIpnrg8Ct5aLYTkcoA
	yNULHD/VWAxL8mE5zqa7WtukTpLBE6k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-GWNA_UPHMkSdwKY9U7GuEw-1; Wed, 10 Jul 2024 12:19:29 -0400
X-MC-Unique: GWNA_UPHMkSdwKY9U7GuEw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-367895ae92dso1344916f8f.3
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 09:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628368; x=1721233168;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Chce1rrJY0BnzM4+QZlqMrwKVqtoRAIWdssG4Erh0g0=;
        b=HYCR/rHh/AgYOTfzPPbJrm1ad2HXQe/fPAlClH39K7WkPX981wdqo/HRnrl+lfTrSQ
         xNusT4CO9+8mroaCYPEz3SeSQ+ex/hlLmCWxBGTo8JCVQC2G7GdDnGWub67ge69Q5hZE
         vPkyA2eWD1TWlfREVX10ANI+WsCr/vgLWSIcLhIdOD4blwfOPeBuO/kvNbCk2ZMdeGuV
         kRw9KurDWyFFCQZDy33suqVOxUh+9scEcKkj9T5nLJRRDmE6ObMJKTYgTdRk1mgAeyAY
         WKfgF+9ZBxQXZ9u82pHlqYiAdp3jnfI5RrsWzZZzf8xDb+cWIc8oYu8GhVlktCZRAx/4
         doGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuWPBFK/xd5x2qsYLMwBfp3f1IBOgTzZ5vLqWv5dc73i/fy5HkwoAWay28HZOIxCJIg15z//ZKb9fXXyrQUSNsfGxj4d9P
X-Gm-Message-State: AOJu0Yz7ouMu+JHXZld463fNnFn+wbtcWgTeRvgSUIW3XiiXcLHd2f2w
	YKJvDRmyk6ArZzSNaLMqI+0z0/2Sc6HODtAIh6S63tHqg/MkuVhvs39VZGUPSH1IDx4fqHJ+P/8
	EPpuk8sYIJ0jK46p0m6MwQ8DhUcrC1OGSSE7XbtUJxCo0xXvDoDNVNQ==
X-Received: by 2002:a05:600c:1c13:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-426706cd15cmr41873405e9.1.1720628368521;
        Wed, 10 Jul 2024 09:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/lyWkP69+kBEZ1ugjN8BD2Qu3nh72MQIQtaAAVD8PVAje3AS5s9VBYJ66XkqZYUL+9qmdTQ==
X-Received: by 2002:a05:600c:1c13:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-426706cd15cmr41873085e9.1.1720628367835;
        Wed, 10 Jul 2024 09:19:27 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1710:e810::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42663f049e5sm153412275e9.35.2024.07.10.09.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:19:27 -0700 (PDT)
Message-ID: <934ac0b8491ec56dd35b9f0ab7422daa1926c4df.camel@redhat.com>
Subject: Re: [PATCH v3] net: fix rc7's __skb_datagram_iter()
From: Paolo Abeni <pabeni@redhat.com>
To: Hugh Dickins <hughd@google.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Thorsten Leemhuis
 <regressions@leemhuis.info>,  regressions@lists.linux.dev,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Date: Wed, 10 Jul 2024 18:19:25 +0200
In-Reply-To: <66e53f14-bfca-6b1a-d9db-9b1c0786d07a@google.com>
References: <58ad4867-6178-54bd-7e49-e35875d012f9@google.com>
	 <ae4e55df-6fe6-4cab-ac44-3ed10a63bfbe@grimberg.me>
	 <fef352e8-b89a-da51-f8ce-04bc39ee6481@google.com>
	 <51b9cb9c-cf7d-47b3-ab08-c9efbdb1b883@grimberg.me>
	 <66e53f14-bfca-6b1a-d9db-9b1c0786d07a@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-10 at 08:36 -0700, Hugh Dickins wrote:
> X would not start in my old 32-bit partition (and the "n"-handling looks
> just as wrong on 64-bit, but for whatever reason did not show up there):
> "n" must be accumulated over all pages before it's added to "offset" and
> compared with "copy", immediately after the skb_frag_foreach_page() loop.
>=20
> Fixes: d2d30a376d9c ("net: allow skb_datagram_iter to be called from any =
context")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> v3: added reviewed-by Sagi, try sending direct to Linus

V2 is already applied to the 'net' tree and will be included in our
next 'net' PR, coming tomorrow.

It looks like the netdev bot decided it needed an holiday (or was
fooled by the threaded submission for v2), so no notification landed on
the ML.

@Hugh: next time please check the current tree status or patchwork
before submitting a new revision. And please avoid submitting the new
version in reply to a previous one, it makes things difficult for our
CI.

Thanks,

Paolo


