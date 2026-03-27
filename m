Return-Path: <netdev+bounces-272352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UExuLGb4xWkjEwUAu9opvQ
	(envelope-from <netdev+bounces-272352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:24:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE38633EC8B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7452D3013FEF
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1F436B06C;
	Fri, 27 Mar 2026 03:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAnBAain";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHmhNfjW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C335C1B5
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581781; cv=pass; b=Ki/OilXfjhaynYZbF1FMDOKJaZQySVrSgzeFs1mcNYorRKlHxGxaUS913uPCIea8r1BFMNjv5AwhU9zNtuyzbHxNF1W7KX45PdnFmHM833NBBDPmHFqOK/GM3o9c17/Y6B6NGSig2negn1Cu4QY89GzPl9q/9Fwg8L4G9Zn1i7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581781; c=relaxed/simple;
	bh=C36kZHRM+V1llXfOdIsMdSubkfgVK0RS45pfG2iUJ2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/HIal3EFpMoz563Cs70bhNTdMfKVS7r2lgNs87vqao7pG2Rgx4LXjituwFlWK7EGMWWZn7DfaKUdh/maX3i/6Mv1KMAIqwJujO5QAsixV61smHryRZU0vWqshWVguhIzun0CzZ0MDMZnUIV/OuiYs3D8WjF1oF1auulD5eOleY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAnBAain; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHmhNfjW; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774581779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C36kZHRM+V1llXfOdIsMdSubkfgVK0RS45pfG2iUJ2Y=;
	b=NAnBAainGyyiLZPUN3Ds/u69hUYdkuzILlN54uVBzSjt1UCwjKuJX0S+l0jboPnQt0swVw
	yZ0xM7DYCE2f+OrlqwW4k3UkJ9TjI5IsJXmVTdQ24lL7JSZ9rplGGZAvLMYUMG1KQSX8uv
	1ZOfQBhPHqKvXJHrm9Bar4ChlO+POXI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-6Im7Z6VcPx2UBYg-q0j9Rg-1; Thu, 26 Mar 2026 23:22:56 -0400
X-MC-Unique: 6Im7Z6VcPx2UBYg-q0j9Rg-1
X-Mimecast-MFC-AGG-ID: 6Im7Z6VcPx2UBYg-q0j9Rg_1774581776
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b630753cc38so3926316a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774581775; cv=none;
        d=google.com; s=arc-20240605;
        b=jcKPNVHtpzZmXGleSVv2JaEYH1xjYnYZrcB6JgO/JVdyj2w4IqJ5qZ03KhuCFLU8O5
         oxBJ2BY1a50Kb2NyIjlFskofCzOGWEYcK40CCJ4VxqDn7id7GnFifVkx6Iss1O6fLpXT
         FjmF5EGvDn2c5w1t7AJitycR4vThJy7ZQqOD+aWOt08lIvEDSheT/+hd4vIfjqI83jg4
         d+kHwmOyqFhShI3MGr9xUch0ip3pKxhxiVeI+YaUQP7hjCecMCFjR394zqYZ2KBuoGSO
         EvEZQi99SBcy3n203SCKXHBwFuwKNcLivN24/l1oWIepux2KQI8gBLGGkk+yJMH1QqTE
         M+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C36kZHRM+V1llXfOdIsMdSubkfgVK0RS45pfG2iUJ2Y=;
        fh=J+ObmqCtgVreS2xQC9dc3wGrmrORdkgpBZdE92IvsqQ=;
        b=CP0OwYS39Pn1Ipj3RANP/TU7N05j6LdzNN5vs2+tsS1sKqWp7bFcJTN62yctjnnpKS
         kEy4ASVxFiW/VxVZsKjN5L4phj9W9xd2KmXpuaJImfRRbVwbErEfJ93aD8KwPTQWOGED
         W5uY+7QOwmTvxYh5cyLn+tnEccYC/B+Fnyy7Pl2IDaqfWWtDblPwy9Yos5e5ixSPqwAS
         qEuSHArutU7FSh2ngOqQ2oNpFNONBhPSnFHnUPXIP+ht5zeaYYwxh5OPxALybYvOqQod
         xcBFtg73qLDLuPMbHIOtP4cn2jS4lF0jTRqpUAfApHs9n+238RcuGXcwDgT9c4SX/I2l
         tCyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774581775; x=1775186575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C36kZHRM+V1llXfOdIsMdSubkfgVK0RS45pfG2iUJ2Y=;
        b=RHmhNfjWghkKhXYEyivLDOOVUKkjZ+3Az9/UF+0fporXGG4OPl9eUiJ6C9B8OSi0Ts
         CSm3t/x/mxr2mpOH1MHJy71oJ9pVjMV5mtahP/b/P2MuTXNJ9hv9zQh15yFsF5JfLh3N
         fkIggVbxIuJgfTboIDgHyKVUhMOhmAP0Hm6MMTY3nEHrc5Sb2qQH/w24FEsTeBo9EzRm
         5GvwHFM8wXNh0dqd/AHbvsl1arvIFSlWJ9ABZ6qtXOagCtfXW+ksbyGvvpqQnY1JRmM4
         4T6L9TlH7eK99JTLiWJgl3UCc0op+5W9r2Ou8sDnEwEIGF2nrqBL5KhJEQSTMxfxEkzH
         vCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774581775; x=1775186575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C36kZHRM+V1llXfOdIsMdSubkfgVK0RS45pfG2iUJ2Y=;
        b=Tj0Vb3x9XTzgSW0XqQG+Of8ANWVzC60VsQtx1eN5lErC3ZJhegKCzmZN0kWlyzomfX
         tGLobIQR40Or95FDr6bZMnJeVB28+OtjuRTuByVK0XUhbzz5E4hZCsJP7XNQJn0i7gvN
         qQZpjW2CtSXbqt8sF2TWRLwaCk9KvA/YVjZrAZpgobMWkbM5GBlgUYZf6krwxD4hH8Qd
         LSanilYUf+NzNb9Jt50AgQBqqwXMhQGrSLl/BPz8IPB0W2xzv0bdVdeP98ASKEgbbgmC
         vHikcCD+/RI116gAkTGR39G+owSVzLabTjHJu9jGSxPuGtgaiNOY0DRTekGhqn9Q+hNc
         1lCg==
X-Forwarded-Encrypted: i=1; AJvYcCWLvYU0Rz8qJaYH+VRfpdr/m1V6HgrUWGDqnTbNl18b/TvOj8nUAnbBTodr2ZsaWzyaCdbY5xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVrv4qMqEFLAFqSe+4teGm3Nb6tXuq6/FfwzyNl5IdH44cFUuw
	/pES2J6CZ445NnRpusX7lbTpNuMIRJcst9JnqTKYsm0+Vcn/Hj7yRvNCObkrz2RYOyi9X02p1Xg
	7dbYxyDT2gDq1eIY30KArXvNyASWCt+/zTvnxnWWmT8ySMANxhtx5zWLzmc3VED30r+AGN77C/G
	FOe9tczji7hSUlfdWxlvkOlxLC6mcN1OIr
X-Gm-Gg: ATEYQzzU9OYvW1VLF5SNQZLwBNUMPQqzJP8Qh1SKgswNG8nQGMRH9WV/YIgckvdUHhZ
	hlfZFuZL8WWXm7DuMIxYU+w90ZCIXNeEX/a2JUpR7PkIS/SOmo7wCLjFalTP98rwo5uxxihg4RD
	B0Gxbo9kaIZz6eKI0pSI88njqIHBxZqO01z7N0Oo+LWzvQDAQNOCvJD2U7esgrgWJjBjYT1KdD1
	h+vatU=
X-Received: by 2002:a05:6a20:3d83:b0:394:518c:eb89 with SMTP id adf61e73a8af0-39c8780b641mr1212509637.2.1774581775592;
        Thu, 26 Mar 2026 20:22:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d83:b0:394:518c:eb89 with SMTP id
 adf61e73a8af0-39c8780b641mr1212462637.2.1774581775042; Thu, 26 Mar 2026
 20:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323041730.986351-1-zhud@hygon.cn> <20260326200346.438702a6@kernel.org>
In-Reply-To: <20260326200346.438702a6@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Mar 2026 11:22:43 +0800
X-Gm-Features: AQROBzBPA1qr4Vk13kqcA9kah5M34BuAu0Zq25NCKCV0BTGn2cAu7ih_M_IJ8HM
Message-ID: <CACGkMEshcxj-R1Ek1dRykBTQ6NLS11jt-9NAu8PbcmtzobRY0g@mail.gmail.com>
Subject: Re: [PATCH net-next v4] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, Di Zhu <zhud@hygon.cn>, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, willemb@google.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, lijing@hygon.cn, 
	yingzhiwei@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272352-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE38633EC8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 11:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 23 Mar 2026 12:17:30 +0800 Di Zhu wrote:
> > Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
> > allows control over offload support, but the offloads that can be
> > controlled may have nothing to do with GRO (e.g., if neither GUEST_TSO4
> > nor GUEST_TSO6 is supported).
> >
> > In such a setup, reporting NETIF_F_GRO_HW as available for the device
> > is too optimistic and misleading to the user.
> >
> > Improve the situation by masking off NETIF_F_GRO_HW unless the device
> > possesses actual GRO-related offload capabilities. Out of an abundance
> > of caution, this does not change the current behaviour for hardware wit=
h
> > just v6 or just v4 GRO: current interfaces do not allow distinguishing
> > between v6/v4 GRO, so we can't expose them to userspace precisely.
>
> Michael, Jason, does this patch look good now?
>
> https://lore.kernel.org/all/20260323041730.986351-1-zhud@hygon.cn/
>

Yes, I've acked.

Thanks


