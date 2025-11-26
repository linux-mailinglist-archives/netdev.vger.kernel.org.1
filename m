Return-Path: <netdev+bounces-241777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A40C88177
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11C43B458A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65D19006B;
	Wed, 26 Nov 2025 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2kSimxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE4F9C0
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764132533; cv=none; b=qo5ZmfQJeWo3vHmYWNsu1TNgKbxdGN6WiHJK/aU4YVA+3qVLrM8hx5w4zgXxr5o6hPqcSewLkj07A3qtZNwGSdKmCcQpCwcBK4Qs4vZp2iYVW+/XRWkNBoPlbGWc21skSR+jtJniXZuA7MeShz4Z1MdiqmlHUnW2b2418oahyA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764132533; c=relaxed/simple;
	bh=XIyEMlTAHRUL65UANJtEyeP/JD8whikZN4FsZfDziSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWnWQ6upTGlb4whVfy98kuMhh0CxSH9wXZgObSH0sDtofl0xf4hsIISW/IDz3F0d/Z0WMj/ztgCJgAIgHrGi0ug25fW/vgSr6VoWYCSVKg5kmCHWTiWqjyNLxfIwCd06RVSo8zopaa3tcNakQ6vO3IQZFX1u2b4Pmd955wqTTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2kSimxO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ade456b6abso5087164b3a.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764132532; x=1764737332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QiXAl5T41fV8u91RxgFyPCavmc/kJPFAWAr+Y+SPIEA=;
        b=Z2kSimxOseOeL76ne9e7YoBZGRmuQ/Y9YQ4AMkZV915ovhQpvQq5/jXJGuE7ccDGYe
         9u1/mA1xICvYHYM8qWkStKKRSUxYpLz2BOU1ERN7Uo3fa8BFTtuD1zVGscUD1v3bkwZx
         YCaLMn7PMtjlikqbuasyQPQb2gcqSkS02qqHK1ilDWdsgD0cj+neSc65xtg3YqG+1WbF
         4xeaBlik/gjXp9T+6Yn5eiJ4zHQ4bRixr33hdC10sGvPoIKQRa5zivaLxRaNgbsSjZ9Z
         XPcoEFllqR5waEH0wh8TlakH7zkY6Ux9vfXJOkNWYHx9CRWhmZs8qCXDpnNcFZXu6f6e
         ZgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764132532; x=1764737332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiXAl5T41fV8u91RxgFyPCavmc/kJPFAWAr+Y+SPIEA=;
        b=MEYHERwJfwlnHhu+vNYVg9Z0o/xO3qzD4t2qgp1NXapdQ22Kvkxn+NJHqWc1b3SX01
         G6NRuPdEr+TmMKbLPPo+rjyIkb3gvC0OrdcP+gY2gDn9UcH0JVt9sqcZK6TNextJ0TeO
         tvLRZB36A1P48AKkF4rYP9r8UBLa5wEYvF20kexCvmGbdrgEM6suQCNPLVcxRXLtiuXu
         FN62woRDbEdFl1t8vkOgFghsbn+JvrqAHK5/YuvXr0hnmwwrK2H89zbpcec1B8zCB/yP
         JpRi2DONrvsrnzU33vFRqlpsqRPDw4H1W3h6md6H4Gkj+IlmYjHffn+pRXPRF4uyfVtO
         QqjA==
X-Forwarded-Encrypted: i=1; AJvYcCW2Rv92ONOXFSiRs8RpQbrLVHH4FBhFLWwrQdWNwp2IOGYnqibUrLyiLH/o6lNw5AgV8Dr/QTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsniPkL9IrLHuIC3im7nqmfPDIwLKtEFxLR1pJeitGv2mu0R2F
	dyjaru3dLtDw7csbNn+CfKavEc9gQq7xSwSWJ5sF9ertFx0a/JUSCWrXFhIh/LtN
X-Gm-Gg: ASbGncuHbXZznHbBJxn78PNEKps/KiL2gvxWcEGaSWNLDW+TK+sk6xxPJjObCOTHvHK
	AH7v2PWrGmMaU8O0LNx530L6PiGwsjYK8ddoPO0kVbkBEeYY5F7iJ/fZfN9Umq2v5diAicGPI4y
	bJya3PokxnCEi0cCndK+HdfjWD0DEryotJqTwRp3pq8mm3BoBjyGziElzTY5SXNsE6iyeGeks0/
	7hz39wXMDCjROdPvLKGPuuerNK8D3cPd2s+QuRmgJnlxiP15ZGElN03QUrTmFyUR9IHiNmJQpn3
	sUbVO2V8/9eTBf9XyU/RCmDujDpeXNltAJTxTAtFBkgNLH2IwohqmPDvSRumfOYIqkvkXXe362c
	hrwesw8ZT+CvGSu8PkIDF7awZgq668/KZktggqiePF3dGIC2mMLhUuUfZE0UArgK32NR7TXGQMr
	KD2RDv5NfDXmHaeBsN
X-Google-Smtp-Source: AGHT+IE9Hsd8VUdCCHY6YB7JpxSFzmFaA4oItK9SOcNRrtKKTgmYBqkWJ+3CjM0GhWa21Ic8LR30Xg==
X-Received: by 2002:a05:7022:ebc2:b0:11a:e610:ee32 with SMTP id a92af1059eb24-11c9d85f282mr10217764c88.25.1764132531521;
        Tue, 25 Nov 2025 20:48:51 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:a2cf:2e69:756:191b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11cc631c236sm19636334c88.7.2025.11.25.20.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 20:48:51 -0800 (PST)
Date: Tue, 25 Nov 2025 20:48:49 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, will@willsroot.io, jschung2@proton.me,
	savy@syst3mfailure.io
Subject: Re: [Bug 220774] New: netem is broken in 6.18
Message-ID: <aSaGsdNk/h0TuB+b@pop-os.localdomain>
References: <20251110123807.07ff5d89@phoenix>
 <aR/qwlyEWm/pFAfM@pop-os.localdomain>
 <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
 <aSDdYoK7Vhw9ONzN@pop-os.localdomain>
 <20251121161322.1eb61823@phoenix.local>
 <20251121175556.26843d75@kernel.org>
 <aSH9mvol/++40XT0@pop-os.localdomain>
 <20251124191625.74569868@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124191625.74569868@kernel.org>

On Mon, Nov 24, 2025 at 07:16:25PM -0800, Jakub Kicinski wrote:
> On Sat, 22 Nov 2025 10:14:50 -0800 Cong Wang wrote:
> > > I guess we forgot about mq.. IIRC mq doesn't come into play in
> > > duplication, we should be able to just adjust the check to allow   
> > 
> > This is not true, I warned you and Jamal with precisely the mq+netem
> > combination before applying the patch, both of you chose to ignore.
> 
> I'm curious why we did.. Link?

https://lore.kernel.org/all/aG10rqwjX6elG1Gx@pop-os.localdomain/#t

Jamal just denied the use case and let users complain.

This strategy does not work, since majority users would need to wait
until LTS gets hit by this regression. (IMHO, it is also unethical to
knowingly break valid use cases, regardless of purpose.)

Regards,
Cong Wang

