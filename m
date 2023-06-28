Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EB8741655
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjF1Q1p (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 12:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231536AbjF1Q1n (ORCPT
        <rfc822;netdev@vger.kernel.org>); Wed, 28 Jun 2023 12:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687969617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EcGVCtGLLiVH4d4G2TnsoMdFkZEx9BvdbEaOJarqpKk=;
        b=ZYjaUhAKCypHQLZSyfqvArNj8gZIK9EjjzmTcwpVaayNzoNyfxo8kYWApk1sFOQQRtKcBC
        fBfvg3/S56W/qbwVif94iN8ENDFtgt1W22acFzAIPhTnvA9Rvei/mEPjhkOCzqglGrNyU8
        KuNh7+Dqce+tF8VUuNwC1hIMkKpnwGc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-MNv6Yr47PWqLCVNywA4qBw-1; Wed, 28 Jun 2023 12:26:45 -0400
X-MC-Unique: MNv6Yr47PWqLCVNywA4qBw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f814f78af2so442175e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 09:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969601; x=1690561601;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcGVCtGLLiVH4d4G2TnsoMdFkZEx9BvdbEaOJarqpKk=;
        b=J5ub6ONIJeTIBzex6vVVQdHz5WC3RK4JlS9wlwVfuR/kr0k6wVeepUf3qJ/iPr2cLv
         g5LNWNpD9dE1ZqtFUfl38PDBZMePNpPuSCOnxJLersB/lRQwXLwp7lMvn5LLAQJDhSfA
         5we8+AOOCpdz2Aau3rb953+Rw4NfyHZprWrF1qCmgo6kdKdjJwzV7VwnLhW+WColbCkM
         TUR65ML2IHKr9oDfZ+0PaFLNQpRI5DvZg2cnyQhe492r/nVR2j03xHkeSP/B63/jTZnS
         KXHWJ79L9mi7yPBdmEakMsJ3DW0f38CenkjJZ7GwskGJdnroS0mIygdSnbvUDflzyUXo
         pcaQ==
X-Gm-Message-State: AC+VfDwjsKd6aAMWDWct2ehQ29HwI3qwg8v/SqfWrcwZoKG9L+EUxf6/
        SluLh4fnpmAOU++xCzzm1DhnCLpV7Y5Cc0MgVfJrsDtZLH98UHrhdYpyf9XiELgzziRFgIa7rd8
        wZnDEKPM2dx/5iBRz
X-Received: by 2002:a05:600c:cf:b0:3fa:d167:5348 with SMTP id u15-20020a05600c00cf00b003fad1675348mr6503410wmm.1.1687969601450;
        Wed, 28 Jun 2023 09:26:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Vzo+uBzc/JyYSGFXDPARP96IlylziRcnJBcodWbyqa26TFS+86d3xF7w087Ia6ljj9palEA==
X-Received: by 2002:a05:600c:cf:b0:3fa:d167:5348 with SMTP id u15-20020a05600c00cf00b003fad1675348mr6503399wmm.1.1687969601059;
        Wed, 28 Jun 2023 09:26:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y23-20020a7bcd97000000b003fbb2c0fce5sm1737784wmj.25.2023.06.28.09.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:26:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3E8BEBC01DF; Wed, 28 Jun 2023 18:26:40 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add
 bpf_program__attach_netfilter helper test
In-Reply-To: <20230628152738.22765-3-fw@strlen.de>
References: <20230628152738.22765-1-fw@strlen.de>
 <20230628152738.22765-3-fw@strlen.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 28 Jun 2023 18:26:40 +0200
Message-ID: <87h6qrh7sv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Call bpf_program__attach_netfilter() with different
> protocol/hook/priority combinations.
>
> Test fails if supposedly-illegal attachments work
> (e.g., bogus protocol family, illegal priority and so on) or if a
> should-work attachment fails.  Expected output:
>
>  ./test_progs -t netfilter_link_attach
>  #145/1   netfilter_link_attach/allzero:OK
>  #145/2   netfilter_link_attach/invalid-pf:OK
>  #145/3   netfilter_link_attach/invalid-hooknum:OK
>  #145/4   netfilter_link_attach/invalid-priority-min:OK
>  #145/5   netfilter_link_attach/invalid-priority-max:OK
>  #145/6   netfilter_link_attach/invalid-flags:OK
>  #145/7   netfilter_link_attach/invalid-inet-not-supported:OK
>  #145/8   netfilter_link_attach/attach ipv4:OK
>  #145/9   netfilter_link_attach/attach ipv6:OK
>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

