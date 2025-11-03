Return-Path: <netdev+bounces-235263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E2C2E5E2
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323BA18908AB
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6876E2FD7DF;
	Mon,  3 Nov 2025 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bGw+++mj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707752FC861
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211090; cv=none; b=SH3AnTzNk4BceNv8c4iQWcXT/XPTFww2zSp3+axdlGoKYbURr3BKAoVOOtzJ4TWvXXawDJkvpNCjmtpAS5jlVg7uYfOK8xYtBjWpQJuGaDBOZBptiAjIDP9ZRVDRB96iRZYhyqyTTUrXI+/d0kEjycGdTzJHiDje+zVeCCIH9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211090; c=relaxed/simple;
	bh=qFJb3QTz/3jg/L6x2lbG2psgJfjIQh5q1KW1+nPPaBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2QBXwAFfQCDt6nUR3Ttqhr7ijuK5cGdly/j3K4fQW/6RRwyBiAnoYqYuWEAhKAiKkRliXe96mHZ+lK1CcK1DX58hdaje+gbZHjJPNRQMke/rdL8pEuVpCwelRISK7PJkR8VV1buPzcJuqJWgW2/aE3+ijQmRhM68GUbQW0zXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bGw+++mj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640e9a53ff6so166843a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762211087; x=1762815887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=bGw+++mjPYnWZOYiS6EcFjJzEyuTPJUQqXmW4FOvtqPBOG+AEaph4a7eceAvZWI8sN
         R74TLprWSn9DqgtcHyPzPf4wf8FG9rBlSIZbYpVeKH91J9lQiGihNuLD2YemdmX+AfI0
         vxH9nHyZHQoa5N9Z3rudNTHD7bXvZuu2Kaums=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762211087; x=1762815887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=K/3rwee1ofMgawN4oFWCQnoAhqES8cow8MBbNqwOSgBccO4/CHqlLro1QEU+WVTzNr
         LAiXx9ya+UV+S4tpsLYHun0rWh/TlZtvzKKJ4X9wEYlRQxoynvRbx1DM64JtvkZTKsB0
         1VFVTxRKjFm9+d9OkcjU+znbyUxcSNJwaAGkkyTOMBdsBT09oOIXJ71X5f9dRZ3VfpQq
         ho8t7uXjoHY78rMULPhri4Nj5Ga3EJioze3OTSSGybXdTYqPEzM0l7UUkDRkPjjawD2K
         z5sHSylwmKW+pVZ9nTJvq5Wfs6pMo4TIfWKAGkEGm4jO3nUKx8DY1VrNDkJE0l7Vqdzg
         s1WQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0IRe2sR1tP3G4G77WkO+UdfUEcLFwmdWNUbOUb/Lr8STa1UIAotwKEw7PU6WyYOzDlQC3i0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHJHnzfa+VuWYcf3ORrgsZqo5SoaeKYccK4UrZMKsw5fdsSZRW
	6lvCTpGlWMzaf3S6YS63DrxsyA8/Wh2ktzQLuuvwWNjc78Fg9dvs6doRVDU++6MdDefr/O7HXT1
	ml6k/NohVVg==
X-Gm-Gg: ASbGncui59qqF70bPeA8pmvQ5pnb8Kf/11vvnU9W2y+YCsVBjbW0LaTg0WY0d8IK21i
	aNU17HPcU8/22jcgoht1KQAk0t19lRfuo5+c9wt2Ni1f1IKXUafJZrPyc1RiW+HoysecwlVQsSW
	kgfs+7lrKXVlWsT/RcS2NfoWR0jnZu0EJ71wcglia8tBI8Ku1copckvBqVizlRjwa+fIs74OuNo
	WbZ4g6hWiLwUJm5KnJqlnpiIYaSfOLXcXY6XEES9IzYERqJTrbezsnG2JpZDxEFKvqZgay6dpLu
	m8KMLTtnLjtdDs0kd+OfcRHTBipB5TL7BvDjTbYHTyVb5fO7iary24Ir7eaYBX385uTn1KBORQe
	VAtHddlLXm5i47EBBwFFJrtlKM9ctIng97kAtxprOIOpR0/wwSBi6R2hp8/spEUDVr0xscOH92a
	cpidlb2P23By0ttuje39JA6ROtQw2iXai+d/uGiF8g1we25L3MyVz4tl4OB4ud
X-Google-Smtp-Source: AGHT+IEl9jPEzc/xeBXiXGgdjrNuxBH4tk4ZptTU5E2N5LnENoKTD30ewFAUtk+8ksErTf9PHoXDSw==
X-Received: by 2002:a05:6402:1ec5:b0:63b:f0b3:76cf with SMTP id 4fb4d7f45d1cf-64076fe6c82mr12038503a12.2.1762211086586;
        Mon, 03 Nov 2025 15:04:46 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a7f1besm555125a12.33.2025.11.03.15.04.44
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 15:04:44 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b70fb7b531cso232815566b.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:04:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZFdr6SQqesbWeymjS3oGOlQAizTOhe+LIO8x63Fa3mLATyTld1oL78R4wE0NkmdTm0Rku2Gc=@vger.kernel.org
X-Received: by 2002:a17:907:1c28:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b710854688emr499540366b.56.1762211084280; Mon, 03 Nov 2025
 15:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org> <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Nov 2025 08:04:28 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
X-Gm-Features: AWmQ_bmQaBgs1Hs2Yx75LVx_L0plRwfdpBhmjm5wyWf-G7aoJOGX7gmwXWEf8f8
Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote:
>
>         /* Perform file operations on behalf of whoever enabled accounting */
> -       cred = override_creds(file->f_cred);
> -
> +       with_creds(file->f_cred);

I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
have this version at all.

Most of the cases want that anyway, and the couple of plain
"with_creds()" cases look like they would only be cleaned up by making
the cred scoping more explicit.

What do you think?

Anyway, I approve of the whole series, obviously, I just suspect we
could narrow down the new interface a bit more.

                Linus

