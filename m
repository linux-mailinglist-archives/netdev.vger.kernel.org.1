Return-Path: <netdev+bounces-155826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E1AA03F34
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854D3188733E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A161F03CF;
	Tue,  7 Jan 2025 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4Eyai10"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19B1EE7B4
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253153; cv=none; b=Oc9afdnY31Rq57W9PqaMiQB5AxRwxhWrSGi8KaTnYZbI+SrDFhS2rgl1gR+Ks3wFgArujU4VqBrLbrS6Nxxf+ZVc80iBs1gHGctC0e+GjPZBMZHtzMC7TZUchlHER3ejA6N1rfz931mbfbR+8hOAyfKSQh6NLaRdSCnJyZbzVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253153; c=relaxed/simple;
	bh=FWw7/JvYDOnTAPJ3spnd7HmzXeSGlQd3iZJqPBHv788=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUwJ/7qMnGJAP/n57edONrYKunH678xYeuwAtV4jcbuY3eJbjiQnd9H1U+djUfnocpPF8XbXqqzatqsmRFmgfuaf5NeR06MqDIGeeD4oBtP03VIFivhCSdvxnASqnPcJJOXU+3P17DAdFsi3lIHZhOFnfR1VV6DBuHdTJFS89yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R4Eyai10; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736253147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FA34be2teYEYsr2t/72VryT2qJhAIzW5Ui7xESwTB6o=;
	b=R4Eyai10HqoaMUdBDVIUyJjc4IuKUxcpttZPKYO3+GWatBy5qm3ENaN9JXSSQf9k+dk2gJ
	JGbxdqYOZAMc0o1zJEAKvJnkP/5tTdeGBbKnAZAticGX4SGmKYCQZXNC3giJSK6pHw2ZK8
	7zRi+yDrXhIO8JvoLXC14f/rdeh7qvk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-JcPK7UP6PWGUtBAtNnaLOw-1; Tue, 07 Jan 2025 07:32:24 -0500
X-MC-Unique: JcPK7UP6PWGUtBAtNnaLOw-1
X-Mimecast-MFC-AGG-ID: JcPK7UP6PWGUtBAtNnaLOw
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef6ef86607so21536102a91.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 04:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736253143; x=1736857943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA34be2teYEYsr2t/72VryT2qJhAIzW5Ui7xESwTB6o=;
        b=HryqgB+fnMmLCr0n8NmF06EKSltcEGGPZN3kGqI+giovm69cEPc+LVttbqjPI9n8Oq
         sx2C1+GiX854EnysCerd1FzT0jg+cAuNaMfhILzpgPvpKVwgfTtBxzIrhIvtoGjiUboT
         B6P61265OUk56jk0EpSYzF9o6EV4EwBt2WinGcjFHm0E757i16pBPfvfheCtJdHf6p5g
         S8RY08oyYJ8uuCIjh/lDOYBnhRe6skjMDzYpcZMTEmEoVhO2pt4NH0+y+RfY+nKxNmY0
         PSeW031ng5LLjARjsXmbH9KeQSNjMZmX5PyAqLQEM3/O0+swLvSKKh6QQUv58iR/jERb
         mtCg==
X-Forwarded-Encrypted: i=1; AJvYcCUPlC1/2sK77XbQ8MJhcHxIuzjM3dB2RrKfvgJbl4CPWa2kV9jZLYLaS2dziRziWSUxu6slNFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5R0t/k4KlS6mHby0Uu0wZPDpDj+SIKOGL3N88D4VTp+qDSZKe
	7FPGm7w48OQ8RcNa48sCl5YZXiGwAB1dAB2jK5reHPzZlY/DtZ9sLuDrzuqHfCgrlqsL7WcYb+r
	YpNHdmBtNRA0HlRN+mxwLK4x8eBKGiy+ne8VmbG4/Qzt4DM1FffIg6Fo9yBKUO/XWwcRA8gyYFO
	ncskHXeUGlrDvYQBW1mZERXAl8drWh
X-Gm-Gg: ASbGncsVFkEDJ6JCKc7dEwe1XxAIh0yJtbu+3GnYH8rN1pHN7q2LWtp/X6UzvjcQCTJ
	tLd2GETGNcYAVcy6SI/IgjuiqBA3R8aUPIJGVzv9RkArpAmUVzwF7JbjQHez+HDXAbJAIdQ==
X-Received: by 2002:a17:90b:2f08:b0:2ee:5c9b:35c0 with SMTP id 98e67ed59e1d1-2f53cc0026amr4449308a91.9.1736253143207;
        Tue, 07 Jan 2025 04:32:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXEm8Tpwx9R6D9Gw9QHyKE+GR3tsYiiCv4Ym0+gd1Cz9oD6CrSF51bAc0DLA4TAYCA4UkwcBAPiOxCypE3SI8=
X-Received: by 2002:a17:90b:2f08:b0:2ee:5c9b:35c0 with SMTP id
 98e67ed59e1d1-2f53cc0026amr4449278a91.9.1736253142921; Tue, 07 Jan 2025
 04:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103-airoha-en7581-qdisc-offload-v1-0-608a23fa65d5@kernel.org>
 <173625003251.4120801.586359106755098449.git-patchwork-notify@kernel.org>
In-Reply-To: <173625003251.4120801.586359106755098449.git-patchwork-notify@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 7 Jan 2025 13:32:10 +0100
X-Gm-Features: AbW1kvZ_ZjT4b_8fuDBZTcCBlMZd_2JVzhsmZ6fS1Bss4oQKv0WT0sawYektIcY
Message-ID: <CAKa-r6v0bEjQfbSG75E9kV1Qki-5eAbrqiy2maB2iG2O4Wf5Xw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] net: airoha: Add Qdisc offload support
To: patchwork-bot+netdevbpf@kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name, sean.wang@mediatek.com, 
	Mark-MC.Lee@mediatek.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	netdev@vger.kernel.org, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi,

On Tue, Jan 7, 2025 at 12:40=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
>
> On Fri, 03 Jan 2025 13:17:01 +0100 you wrote:
> > Introduce support for ETS and HTB Qdisc offload available on the Airoha
> > EN7581 ethernet controller.
> >
> > ---
> > Lorenzo Bianconi (4):
> >       net: airoha: Enable Tx drop capability for each Tx DMA ring
> >       net: airoha: Introduce ndo_select_queue callback
> >       net: airoha: Add sched ETS offload support

I was about to comment that ETS offload code probably still lacks
validation of priomap [1]. Otherwise every ETS priomap will behave
like the one that's implemented in hardware. It can be addressed in a
follow-up commit, probably.

thanks,
--
davide

[1] https://lore.kernel.org/netdev/CAKa-r6shd3+2zgeEzVVJR7fKWdpjKv1YJxS3z+y=
7QWqDf8zDZQ@mail.gmail.com/


