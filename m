Return-Path: <netdev+bounces-257822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOfPMrp5iGlTpwQAu9opvQ
	(envelope-from <netdev+bounces-257822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 12:55:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 519B5108948
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 12:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03EAC300A76A
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D935502D;
	Sun,  8 Feb 2026 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fm2E+Vqy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGTz0pW8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B230C353
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770551736; cv=none; b=jVG7UF7s5yS/Cf9liNQS0VoSut4Kq+p4tQLZheNAHGkpTn49rEeFpWElbB2gBIXASCNBRXaZLkiSciNcAUwEo2b0+UkDqIgUUzokLLWYviWJTKlRmWbkHtRka1jWEq2pOgnbxOqC3SyFJLhyhzI3ZJDLZ//amawX4AjDVxHcFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770551736; c=relaxed/simple;
	bh=C2SiIeGc0fc4JT8osnVgKzv3KFzn9+HInliVRVkG8KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCF64FNJy7hPyrk1xKarpismkTL3wJAU9FYgj5USFajPabeelviXS4gcdZW6dE++SaNqz+wl8x3EBQJSV0POSYG7pVXG/VpP5SDgy1dpDZFVlgm+cK//+MMogXIMRWMu2TglDqYVA7WopvTmx3JT7VQ1DWh1SRIDfBZcM4+icvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fm2E+Vqy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGTz0pW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770551735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vaUt4fCaJFu3DVhgxoFsiUS0J+gHh91/ueXneDoVYuQ=;
	b=fm2E+VqyuyEQSS96YJy68r9q0fU6EJ/01zn+GkahX86kQTvd+JGfaax19su7IdycTxIZjg
	aUqaaWHvovEAGMKnzoVcsk9PTxYRD1ErgWA9T0ugT0mNhJiYyacK1yi7DZUJuRDY+AVYRx
	lG8OrtEPtyGUpW33kkmYolCNGCwuV3k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-fVyMIh6eMKeHIHac6RtLXg-1; Sun, 08 Feb 2026 06:55:33 -0500
X-MC-Unique: fVyMIh6eMKeHIHac6RtLXg-1
X-Mimecast-MFC-AGG-ID: fVyMIh6eMKeHIHac6RtLXg_1770551733
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435a2de6ec0so1012346f8f.0
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 03:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770551732; x=1771156532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vaUt4fCaJFu3DVhgxoFsiUS0J+gHh91/ueXneDoVYuQ=;
        b=eGTz0pW8HDySbSVV9lLSVTWJKw2L0tU28NKNVouOZX2cFxIwyzczmNeKCUJRJBajxI
         xkEJXWpYcrW8d20fYLuQnoq8hBbXMzq045yngXTBx5MU4xXsqI3LC+lVHey0kuCUEgIy
         yo+GMOCxW3/uzgjMlv8b4jE7H6PaNeglZuBhOq+LAd4V1DQctiI15/CQZxjK9/zisEAz
         pF7PFP9OUWKi1bO1rzkIexXXuMwpin/ZBTR5V8Ay8iI6cTflxKxbiKhqfjzwQTFQStmY
         ycNFCL/F1FZM+2AR5b/MlpQWUQVOWol8hZR0wkp2U/8+o+1+S0R7KeuMpsd5c7gjDWtn
         R9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770551732; x=1771156532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaUt4fCaJFu3DVhgxoFsiUS0J+gHh91/ueXneDoVYuQ=;
        b=BCs1nDtPKmIPL82clp1lggDoyTzWTzRxxhFG4rQtcFHPw4zyOKCW3R+PvgB5mIxoYg
         n8KyXqmXwcuCGSMKqx6D3PXGcZdrY3VyhQonscqLv8vmSLH8c2DND91lAZ6ZLzACIakJ
         oZnWIl8pHVsVIkRLOOM+Sh2d/69yo0/3VYb7GMPuoYjNm0Hm2URWZGE7scxHukKT/k0O
         DpL2AWNqtM3PYpAh0cK089sXgT6N/VkCGSZQEMMv2Cvrtd7srIcjvMZv+7IRovAcPVXV
         e8wMAgkMU9C/v4MItUMuR3aPRFuhV78Cs/hltUh2n2uAerKJvkwrvB6CjazPVGexU6yk
         P1xw==
X-Gm-Message-State: AOJu0YwUqvbsH0DkL3Ws8cyPsn0cT7DvrXrxj9f0ihvHzU21goGef6iq
	Q0FxMrSxPEWJaXHdySFiRYdNUlSbH2pdDtWEXLh7JfbIXpFCUGtwtfgmOvN/7Ff75/BJUH/8J0e
	RCecOdRyHmLWJH4doti/YodmFNiTJHnOQQsTl7Qi0Srrpu0m5ev7C+/ZuPQ==
X-Gm-Gg: AZuq6aLTsdmzPa7p9tAUnDWPMsPPhX7uJXcE1MYCgEOhlXpzj6csups5EBLZhHf7b1R
	UeYH5JX21tNrB16kdkrTamufEIbGnNg1v2xxuL5/2uNjWpwlB0OPXAKbfJWMsI8DrbPj9Tln94R
	J1UlKZNHjcI2qCd6UoBeTcgvFjAXIu/iRJX2GS2oLSfHbcVtRY8WK+uhPqtnULNGcz/L9M09Jii
	dqXFf+r/CSCGDtXdUhFDyC2rU+a8Vfv3u8gNAUcQQvcq8fzdVZSYY3J7H75jfZobyLct/l1f1KS
	d4S/pPRlz3SuMktKfaJ5NXN9cgOFuecznMV5GwzoY1QmnXkGCNbJjah2bMilnFXHHvkP7NwbOIV
	yTE88G2Zwjq1kEuuKjsKxr9zGXLK3UGQspg==
X-Received: by 2002:a05:6000:3101:b0:437:6c1f:de27 with SMTP id ffacd0b85a97d-4376c1fe075mr1070794f8f.37.1770551732445;
        Sun, 08 Feb 2026 03:55:32 -0800 (PST)
X-Received: by 2002:a05:6000:3101:b0:437:6c1f:de27 with SMTP id ffacd0b85a97d-4376c1fe075mr1070775f8f.37.1770551731952;
        Sun, 08 Feb 2026 03:55:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43768d07fa7sm6062112f8f.35.2026.02.08.03.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 03:55:31 -0800 (PST)
Date: Sun, 8 Feb 2026 06:55:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20260208065456-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205224707.16995-1-danielj@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257822-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 519B5108948
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 04:46:55PM -0600, Daniel Jurgens wrote:
> v15:
>   - In virtnet_restore_up only call virtnet_close in err path if
>     netif_running. AI

what was this AI specifically?


