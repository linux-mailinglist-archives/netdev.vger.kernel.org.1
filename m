Return-Path: <netdev+bounces-224535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0259B85F9F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65AA1899826
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8727314D34;
	Thu, 18 Sep 2025 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BH8+S/hr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0930748A
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212478; cv=none; b=hHogUc/6AUJydiCkiuzvf6qBKjMYjpcX4h9BuxtyAXGe34+O+4EYTf6E8zrBS90x6Cqk8sFFRw71/fsK63WebgV0NbJpl4IWU7JM2V/qgTgEOxIh4885Fw+lX1YVr0zM4/pqE6eY416Y3PfBaH6YuGEfiwrZRjJLExSHFeAXCvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212478; c=relaxed/simple;
	bh=+6DWJ9V2/s86NKsZVHhjQHyxMst7QlpPf4TiS4jwR7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsPf1tysEoBfPta3sHT17JxGcf769I9oClz/byim6CajQAPwB/1zftsbnQnUzm+NJp3J7bwDnZ5GIyh1RDck7GghMxn9nBse9TN+F473UHNJHbRBTlvHK0LJnETUFfCDq1pa255fwt56iWf0/ZC+y7L7fVwYeLNeQ6xbMitNGxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BH8+S/hr; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd2so2398429a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758212474; x=1758817274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QBudDRqq0+IaBsPdP5gcYH9xINBuKzncv21Vz7DKv+k=;
        b=BH8+S/hrrTxUiX3MC1S6d7HVVPrpM37Z9+StAGHka8NsJkpMwCXrt8eSS0MfQzT8R/
         gM7g6GGTaQVuYgj+J4LS+ry8uCJ/soQsR7+a6hKWV22xoHBh7NCaeirmMO02l43uuOg+
         w0icgadUhO4EZjrOqiZBAmZhbrEDWCEpgNrkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212474; x=1758817274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QBudDRqq0+IaBsPdP5gcYH9xINBuKzncv21Vz7DKv+k=;
        b=je4iz/2s4WVSGNJk8Sq70BL5pl7uWard7GFMD2Qk3WfP0MMqMBQjbAby68awFUj7fk
         kPZtZwVN2Cg2pKUos41V3cETPi7+JBdn2m7/UCeMIWD7pd3CZk5a/mxVUEqZiXaXK/FW
         i7LjTtP0uVwDMl32WvSEZWIJ11UCklU4oGKlZQnT8KDnFL6a52VZ6Y/sdMp/Dgo0HYR/
         7yU7YrT/XDC4jES0RPfSUUNV3I+3Nxnd0mKVFGxk+i7RQWIdB5qA2ysdGwO1wgw4QD7d
         Tw5thGhCJtBhTNO4seiPGLeJB2iLvWeoksSnsbWNF1Vkj835hAUfXvN7Tx6L0OTHF/IJ
         ttLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0hCu0fcPeyOSm9eL6OHZk9w0MdyVTMlRfRXl18vJ1wVjlLWlITA7oWjk+77WbypBOlRVG6CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZz82k9KX/mu/EWUmEzIqkqjHsBW6eWrUX2N8X5sttoYsPCbG
	s2v4xmEhxUxbgOmwP72yjJDeJgsDJJZOqwJRgqAoXKAL3CpBuyeSbV3GZHUOF4qsN66jZj0jdbS
	V/yVKvl/tKA==
X-Gm-Gg: ASbGnctqNBcPsZ2/KI8fVrPmEx7wKWMINrwi4lvf5TGhxwA0XWKiIsjrBsyjxdeO01b
	AHn6WWzCqMj+YytTErioB/JvcDqB3v7nLEr3ZsldrRrHsEKSiDSg+EbbHVosCeFDvFxSdBRhK53
	zBzrU5nEMShKQ6RtZeoWSm517YSmo3FzZ0DrHaAzC9tgm2X0y/6PzwWssgfi6kJezMYg4zGVVee
	Mjt1iJWpGxFzL3sXpC+iCBsthgdVPgNgk3GLBhxKD10vRxlOYY8W8W+nMnWbRpROnfysSPgJ9Qg
	c/LcyDo1WGk4FUZcNCBYuQI9rO94FygDtuAw67Q8++a114UytRU1Ta2k13GM4pDDOp1ZeEncOWV
	PCrCGYudqZV1xiW/xnuDIItRQQDJjQPBnFWrWJselPihJ8/wsa945xcmkYuPQJMW2JS4wikOKEz
	SH6TNP1hwM7TWe8Yw=
X-Google-Smtp-Source: AGHT+IHXZeQD9v/dNFKEaYWYwLO/WXycMH5/wRdKeCuWFp2vxGLY0nYKiDX/rvznNOWhGSMVM9UD9w==
X-Received: by 2002:a17:907:84d:b0:b04:83af:b4ba with SMTP id a640c23a62f3a-b1bbad8abf3mr696935266b.52.1758212474408;
        Thu, 18 Sep 2025 09:21:14 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fba8d2700sm230552866b.0.2025.09.18.09.21.12
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 09:21:13 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b2381c58941so72770566b.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:21:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0uz8YuNOY4SqrcQ3hpoCW7gTFXJQrE/R6c/zbJFZWcV+JMSjZwMds3W8Fk3GHKTnBmSi6F+8=@vger.kernel.org
X-Received: by 2002:a17:907:6d17:b0:b07:c715:31 with SMTP id
 a640c23a62f3a-b1bbc545b7fmr610549366b.65.1758212471806; Thu, 18 Sep 2025
 09:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918110946-mutt-send-email-mst@kernel.org> <20250918121248-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250918121248-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Sep 2025 09:20:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whG45CvbpxG2dtWgAG31uPSRZ_FPw9s2tyH_8enuxYE8g@mail.gmail.com>
X-Gm-Features: AS18NWAmxo1DLd_bNcF9s-ZOOAwZnodu5o6p8OrqHir3EF-tNoG8mT_VioNWcEI
Message-ID: <CAHk-=whG45CvbpxG2dtWgAG31uPSRZ_FPw9s2tyH_8enuxYE8g@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio,vhost: last minute fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com, 
	hi@alyssa.is, maxbr@linux.ibm.com, zhangjiao2@cmss.chinamobile.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 09:14, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> OK and now Filip asked me to drop this too.
> I am really batting 100x.
> Linus pls ignore all this.
> Very sorry.

Lol, that makes it very easy for me - no need to be sorry, and thanks
for just reacting fast enough that I didn't have time to do a pull and
then have to revert later.

          Linus

