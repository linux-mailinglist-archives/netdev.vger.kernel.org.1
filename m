Return-Path: <netdev+bounces-238772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE737C5F458
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491E73BFF31
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44942FB0AA;
	Fri, 14 Nov 2025 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I7SD02dd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9F2F6906
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763153356; cv=none; b=OWVq0DwEmKio7g8EpAjUYIBEwoajicRZVFrsXOoYrHAmKuDhPqGu1QlQGiUXvcFKjm0mfsz/SZYPKJGOLB39x9Uf8B3xrny6MjMASD55aRoiBLs7uI/n2/lJPvIBb6eUBv0f7HhwBeCdn/ds46YzrmEi2rRqY64yFC4dFGsd1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763153356; c=relaxed/simple;
	bh=tE7fP22dB2vlNTuE6sh0FMu1Pi5aw/zDuijOpLixHCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3S1KZbmh7xzgVAWicpO8gvyBoPWQEhkEaGTRjpL97pQiny25Tcj8ABaxEprByeUwqk+gCFKdw8kJoDMUJY/AjKrJOnLYwZvi0AFxKR9TOuvmcaufQ+itTg7i7zav2qN8Wl3QmC8jnPpNfZwpM1EL+Ib1jmw4eIZskbscV2pX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I7SD02dd; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so3492047a12.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763153353; x=1763758153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nIotG2TBVJHtLyVkQ1nV/V4Ve4TP77XPvYjhlVaFGps=;
        b=I7SD02dduulIMTZgiOxk+ct4qf7IEh6W4XivWMAxhtr3sxMNqrHJmNX+bGNvXHn5UH
         phsHPRW6Gy2dI04H2xefZRIPWOX5IHZkmr24zzGMWjQjaOjwX3c4eH0qp50Nt6S0NwXE
         bBt7B8PWmmvQB7mknjzZNkYPoR5wKGqx6bWFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763153353; x=1763758153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIotG2TBVJHtLyVkQ1nV/V4Ve4TP77XPvYjhlVaFGps=;
        b=RwwPNxj8ltAFYN9FLnS5C/V4R8nP2b8BtRaBcJcBCIfcUg6qGJ7GRnj0u4kzZpTvZk
         2Pyfj1nbJPdRF3z8ybfRI4HXuacebcQx8eCyqLV70X/4MjPBJQAkTjr+8Kuc249rOTbS
         hHFiMl7zXsORo8XIiWAJjLUwKZ1mMRa92AlazN8TotuPjwnjfH3YKxfyE+fNSHZ5WX3A
         ecvsPisLO6WWbEmC6wZmZifTtQ5gZUGWTG3FX5nnM3gczekSdKnMdDyHgtyE850K+yGh
         Tvp1nw2b36n4BE4G84WYhsMvc1APKedO2UAvWlONlA+IMpRVMVMs+cqf0qi4+xQl6lZx
         +ANQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWfwi1oHeOH2tul3DBDIEXeSZK41Dwx9VorheX72A2HBAJjRCvkYTK1RZBji7ajphURIEPDIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypw5JpLMhcdgae1xx89A9QAtfnW9o6VMAgT5OxrZF7WMuT9CgK
	eyT+EKsRKHwYuhu5b3uerP7nP1l1ZA3wTPEFbu3ZZgUqE4C1pGFEFrF5ldioNrA9f5+kAWBvR0V
	Oda6Oiao=
X-Gm-Gg: ASbGncuq2fBJTz06wYxMyNOnWpYQtLxrwRQzt7FklH0aUJuXwP9PzuVmBaRPDBwp044
	om8sjRZDYwmG35rOwHaEi9Sow4QSjct6nc0pp00yLL0GUg89PW2Fw6EMn470s0o5pjqA8hVEyq3
	FnbkOGDuylL6ywMA6OW49dTwrUGQwVUVXrntahFx0iqrWl4ZFB7wp4f68ap3DiERHHIlaDxejDi
	M33HNE6Il0PYoJwmhWdDUJ1yVGFY6iqOono479cP/lJNaVNT4sBrWeel+zTrpb6b9ELeX6HfEMr
	TBI/OYjnz1s32OhOQrjK+7WAt2x0b/Fn5Tr6odfFKiGYY2ydbQmEKTtJdonWaz/ax1mqzfdS/Df
	EYkmhftqtCsIpKn5thzds8k8j2f0GXsfkDGrJ4Iosa/uwwB9lvaQIarVh8SvqXjOE1JjWb+nUh7
	Azpa5jlGSG0aIJcprehKAobffqHM+Yd02xdb/2GQHrFFBG9o65kA==
X-Google-Smtp-Source: AGHT+IEq1J4TTM4lMn29vLx3pg/TBGwCXrx7hHBuZ+tbRkia7MCiX+vsF9QXhS99Q14DJIhUl6HGcA==
X-Received: by 2002:a05:6402:42ca:b0:63c:690d:6a46 with SMTP id 4fb4d7f45d1cf-64350e222femr3976746a12.13.1763153351619;
        Fri, 14 Nov 2025 12:49:11 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4c5834sm4290952a12.33.2025.11.14.12.49.09
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 12:49:11 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so372128566b.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:49:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWduqLngQR6Hl/lFGOzURGGM0uv7IkC6p71YQweLAkjKjSJGmm1Z2tqatwpzsWW0A7UBeKpAnE=@vger.kernel.org
X-Received: by 2002:a17:907:1b27:b0:b70:bc2e:a6f0 with SMTP id
 a640c23a62f3a-b73677edbcemr485389666b.5.1763153349232; Fri, 14 Nov 2025
 12:49:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113005529.2494066-1-jon@nutanix.com> <CACGkMEtQZ3M-sERT2P8WV=82BuXCbBHeJX+zgxx+9X7OUTqi4g@mail.gmail.com>
 <E1226897-C6D1-439C-AB3B-012F8C4A72DF@nutanix.com> <CAHk-=whkVPGpfNFLnBv7YG__P4uGYWtG6AXLS5xGpjXGn8=orA@mail.gmail.com>
 <20251114190856.7e438d9d@pumpkin>
In-Reply-To: <20251114190856.7e438d9d@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Nov 2025 12:48:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJ0T_0SMegsbssgtWgO85+nJPapn6B893JQkJ7x6K0Kw@mail.gmail.com>
X-Gm-Features: AWmQ_bkW5f2iQA-30H7SfZ-1SPQdVwpCHIQwF379qtfjWrYcgYHuVtfQQYOnQPg
Message-ID: <CAHk-=whJ0T_0SMegsbssgtWgO85+nJPapn6B893JQkJ7x6K0Kw@mail.gmail.com>
Subject: Re: [PATCH net-next] vhost: use "checked" versions of get_user() and put_user()
To: David Laight <david.laight.linux@gmail.com>
Cc: Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Nov 2025 at 11:09, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think that is currently only x86-64?
> There are patches in the pipeline for ppc.
> I don't think I've seen anything for arm32 or arm64.

Honestly, the fact that it's mainly true on x86-64 is simply because
that's the only architecture that has cared enough.

Pretty much everybody else is affected by the exact same speculation
bugs. Sometimes the speculation window might be so small that it
doesn't matter, but in most cases it's just that the architecture is
so irrelevant that it doesn't matter.

So no, this is not a "x86 only" issue. It might be a "only a couple of
architectures have cared enough for it to have any practical impact".

End result: if some other architecture still has a __get_user() that
is noticeably faster than get_user(), it's not an argument for keeping
__get_user() - it's an argument that that architecture likely isn't
very important.

           Linus

