Return-Path: <netdev+bounces-202422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA65AEDCDD
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D9F166410
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23451289812;
	Mon, 30 Jun 2025 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rf795Doa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5412853EB
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286838; cv=none; b=sgz4gWj7+0oSQqQIXWqoMS2AaezI0cEI6EL2S26K/KEEZqFGVBKonRUiiThvIp78bEpSoVFDWNqjVpSDrAQL0Vg1niNNqKQV0zCcGdubLEHQPWn+5xQJJ/iVtogLI8IUPzDg4gUNiKlmAOyu5C1O5qPWZ2l+7Zy0rmMr3RZ1rqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286838; c=relaxed/simple;
	bh=gJ0wiD3rWl8CogZdAiED/KOkAPi3Q/uO3S+KjMDCmBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PeDF5WGJYXVnU9lN53pIAIzsQD+47JweEHSGSoSmJmFOG4sutyHle4RhL0mxWWBsAmeVtQ94xGhWaJMUvXTi/0EnZ8bodhIy1tVue7TEAZV/E9TVz64xdHkOKPw0wzsmGcLjIzQZX998MlKUhhr3iEGtu4PptFhKxklcdwtreCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rf795Doa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751286835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJ0wiD3rWl8CogZdAiED/KOkAPi3Q/uO3S+KjMDCmBY=;
	b=Rf795Doa4okwsmeuQYg4LADxRBqEQKaSmtTR0mqfXj6zjA954NGYn7HcrllBMAXzwCcaKS
	3/ELOsVCAl5cG2tV1kTDHZ4mav/SE7g6Ax3P922z0giglL9VuDNplJGSrQToruhIJ4pFz3
	IWzQMXEqR4MNOapWHin7P3/b3leigG4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-ijaALfbEOeuQIRmke3fIVg-1; Mon, 30 Jun 2025 08:33:53 -0400
X-MC-Unique: ijaALfbEOeuQIRmke3fIVg-1
X-Mimecast-MFC-AGG-ID: ijaALfbEOeuQIRmke3fIVg_1751286832
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ade70c2cfc1so382365166b.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751286832; x=1751891632;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJ0wiD3rWl8CogZdAiED/KOkAPi3Q/uO3S+KjMDCmBY=;
        b=AIMeNcBczehM/ndocFYMLP8bvJCWe2a6FbfXYyq2NdqcWRA8NdkHMQStr20kcCydnG
         NCPZZcN/4W3AbOppHbimmtVlCalhq4erkH4UzFu7S15/9I1Koo2MEcSxcsmXpb6tI1MT
         oJIVd5v11tEhGAtE2BXjfaTanr70svYH9JkxqsDHl0go8z0JIcZWsjoh+zYHTCT3+YCL
         bNXHkwVMBlgqUV7zrEEwf/PaM16Z3b5GUSderAOA7/QIbwkW4P7jHZE77fw8IX838ol7
         a8swt3UB7g56w+abeZvOj1RKEP3CcdPAwLtquvmtqh5mvR4b8Zcmm38Wc89RmE9YziEd
         WDjA==
X-Forwarded-Encrypted: i=1; AJvYcCWRp6ghB7MNDAwxamQbMJNirhjLCh2/YkQ+6Bu9EAKUSHW1dSmKiRHP1JgCjxHejR2LXSesil0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4pqb8dzhvDGITXsLoeM5SWBcBqAJ6pjGTygIYmvXp66p1HKGU
	8Q9DrHweWcY84i4sekxFtd7sLGp2k1pqHJczSgGDOExMJlgthGQjycFCCGaOYUHA80ui4+UDxAE
	uehiZzH7/PWXK9w+m+c3aKou2EXjNbPlTv86RIcds2VjYAMR6japdjQsDxA==
X-Gm-Gg: ASbGnctW9TFm+eHMsCaBv/l74DXmiR3bkrQ96MwJ6RFfOKIZ1XU90ty4kD6NmPLZs7z
	QLoh7inRIdW3Tcyla8+9n5jwVG89PvZS36PQmRhvBVraZ+hpkggem6xxlrvY/Q38+7Dgvw7Wfo3
	zpzvfDEIl2GMCBKRYDJezBQV+g7Z+zsswIzcSt9EyUbZ5J6XIXYYxsDohi0Dm71l7aheLHwFlwb
	gtbDcAt1oxSFgD3yiSEZNPF8232d33UvlUGb51duerl88Q8m8fbLYTYcDqf9Johor49RXAycBkY
	Mov5zJ2JqS+L1gJrQsY=
X-Received: by 2002:a17:907:608e:b0:ae0:a351:49b with SMTP id a640c23a62f3a-ae3500e02a9mr1046996266b.34.1751286832236;
        Mon, 30 Jun 2025 05:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcjceK9RvEHC88OQB5r6+jBRwjCnSu1XO6IF/59hEXlyuOAfoc1Cs5C8c3NNtvik13ennRiw==
X-Received: by 2002:a17:907:608e:b0:ae0:a351:49b with SMTP id a640c23a62f3a-ae3500e02a9mr1046993066b.34.1751286831785;
        Mon, 30 Jun 2025 05:33:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01237sm678103266b.98.2025.06.30.05.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 05:33:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 14A7B1B37D1B; Mon, 30 Jun 2025 14:33:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v1 1/2] selftests: pp-bench: remove unneeded
 linux/version.h
In-Reply-To: <20250627200501.1712389-1-almasrymina@google.com>
References: <20250627200501.1712389-1-almasrymina@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 30 Jun 2025 14:33:49 +0200
Message-ID: <877c0th0ia.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> linux/version.h was used by the out-of-tree version, but not needed in
> the upstream one anymore.
>
> While I'm at it, sort the includes.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506271434.Gk0epC9H-lkp@i=
ntel.com/
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


