Return-Path: <netdev+bounces-98518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069AC8D1A3A
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50104B249DE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BE116C841;
	Tue, 28 May 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8BWyPP2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4613AD30
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897052; cv=none; b=aRnHwJDhKzEyI9jyx3jmwU9nR8pIKOy0w4ZRY1u+sx+2RP05ZRuNSZwdY5s4oTKKc4PMsKB1DUjOojz6V9j8m2l7T1wIWNs3rf6JNdII3Tb9YXte/YCpw9ih4GqUcGOvqub0nDdB5UEdQZWYWgCad6bJplpnFnqGcHfJzQ2mIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897052; c=relaxed/simple;
	bh=kHoYwVHEgA3BwGr1etYBEKBES50v8Mr/6195+/t63BE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AAAiuX/Z6QHVwlUgz6t4ookkLzObuOxyTzAZsda+rhxWdRhmQSy8kcSfu+9sy0mr3bgYlM5DTrfc2glNnTWpxGxCyf9uZLJMPqwdErtHI1yJNV1IDyqkjEzicY/v2lp6rO66eH3aRl15c9a7aRNtJRKnIj13OgYDscoADAuK5+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8BWyPP2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716897049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHoYwVHEgA3BwGr1etYBEKBES50v8Mr/6195+/t63BE=;
	b=b8BWyPP2+9vEz7bFBhPwJnBk0emCv8rKCp/4UcnWPCRzYqlOdxLE6ye7jcZAbBBYBTakgv
	ZOI/VlulVaRHPzpmnJ4qRZ0YdIzNgYVlFMLqJnGRz3cLTif/9CLR5Rgc8EC4RzFOuprcuJ
	BRTPIM9Y2/O4WESU5rh2LYzZpinNOUw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-1bztQPMLP_e6VUHNPH7-bw-1; Tue, 28 May 2024 07:50:48 -0400
X-MC-Unique: 1bztQPMLP_e6VUHNPH7-bw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-354f30004c8so67607f8f.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716897047; x=1717501847;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHoYwVHEgA3BwGr1etYBEKBES50v8Mr/6195+/t63BE=;
        b=r5Kcht2cDWpnrErfSC9DoTORoo7XW0nctDrj143tYCkIuP7gXqdq5FgLgnMklFavsT
         lPwpKmLllLjEru8JfG7YqJizdfBGrmWw91qDRY62F1gnZqcI7Bh+A81+pAdKRwf3dNJf
         WjRtnQDcMjGX5+Qi+OIPMsZokcBS5jluN+hl1ReSzcQ/3xZmWem/dvDYxfOBhHayNMQ1
         /bBCQuq4tzKGOE5JWcI2LEmpgTvn2gs+qlQq/BIKNRWCgxaUmO4Xd7P6iPatM/kmKUhV
         CWwh96O6xlSaQAJLq/YsJ0IimDk0Vrd/l6+NDqzaLrI0jhYji7zcOBQSDglvq6trlpPj
         MElA==
X-Forwarded-Encrypted: i=1; AJvYcCXQpYekY7DH5R4ku31rZGPPlCc+lbJrQMvue9w/aaOMw3lVg4b1XdH7nqjaeBQhPEdsiX1Jz7adiqIb+QUrxgS5LJgWOjP0
X-Gm-Message-State: AOJu0Yy/JLy/tylHAtWZNb0yo1WynANXzmOyvGFBREwfJQztYPj+m+pS
	gVcAb6yp/ZxIygOIuk/sEOsXoP3t+NfLiEVn9drNCgZqUmqmPhy6rGvoW3o3FdCTjjSihPSmFun
	SSa9KmX2XnjogQn7+GPgHHDe1LqS4jB1O6yx8vSNtotyylNcBirWXyg==
X-Received: by 2002:a05:600c:1c93:b0:419:f68e:118c with SMTP id 5b1f17b1804b1-421089e97d4mr89202605e9.1.1716897046890;
        Tue, 28 May 2024 04:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbhau4RvmYALIRmUt/j/Fuq7+AH6HscY1YAzEZL5NbnVyEKoIjJqSFVQ0rbDIoD2UeMiE1Rw==
X-Received: by 2002:a05:600c:1c93:b0:419:f68e:118c with SMTP id 5b1f17b1804b1-421089e97d4mr89202375e9.1.1716897046413;
        Tue, 28 May 2024 04:50:46 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210897c5d7sm140193175e9.23.2024.05.28.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 04:50:45 -0700 (PDT)
Message-ID: <4f0819a7032c52349bba22ea767eda103be650c1.camel@redhat.com>
Subject: Re: [PATCH net 1/4] tcp: add tcp_done_with_error() helper
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org,  eric.dumazet@gmail.com
Date: Tue, 28 May 2024 13:50:44 +0200
In-Reply-To: <CANn89iK=oYdC=ezujf+QOWsbVEXDx1vLLV4Cbd8bJH+oU+RDiw@mail.gmail.com>
References: <20240524193630.2007563-1-edumazet@google.com>
	 <20240524193630.2007563-2-edumazet@google.com>
	 <CADVnQyk6CkWU-mETm9yM65Me91aVRr5ngXi2hkD6aETakB+c2w@mail.gmail.com>
	 <CANn89i+ZMf8-9989owQSmk_LM7BJavdg7eApJ1nTG6pGwvLFHA@mail.gmail.com>
	 <cace7de5c60b1bc963326524b986c720369b0f1d.camel@redhat.com>
	 <CANn89iK=oYdC=ezujf+QOWsbVEXDx1vLLV4Cbd8bJH+oU+RDiw@mail.gmail.com>
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

On Tue, 2024-05-28 at 13:31 +0200, Eric Dumazet wrote:
> On Tue, May 28, 2024 at 12:41=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >=20
> >=20
> > Waiting for Neal's ack.
> >=20
> > FTR I think the new helper introduction is worthy even just for the
> > consistency it brings.
> >=20
> > IIRC there is some extra complexity in the MPTCP code to handle
> > correctly receiving the sk_error_report sk_state_change cb pair in both
> > possible orders.
>=20
> Would you prefer me to base the series on net-next then ?

Now that you make me thing about it, net-next will be preferable to
handle possible mptcp follow-up (if any). And the addressed issue
itself are so old it should not make difference in practice, right?

So if it's not a problem for you move the patches on a different tree,
net-next would be good option, thanks!

Paolo


