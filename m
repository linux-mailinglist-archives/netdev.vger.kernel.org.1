Return-Path: <netdev+bounces-21310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1197633BB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CE22819C0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058AC130;
	Wed, 26 Jul 2023 10:30:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85606C12A
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:30:14 +0000 (UTC)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD472127
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:30:12 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4864992dc37so405576e0c.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690367411; x=1690972211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CTp3lWOa4enqnnJtPatmpsbCOMEyt2QR5UoDl0egg08=;
        b=U53wjrNbnX2OBR176Yur6xYn3E/JYdgMSR+16BeKehlz0f5fhbA4/Eg+atl6iREs1s
         3hd1bGwS0oYOzjB09zMamrTE4lmrgLW5QinZEx0HkqXXHB6+U0DeoMK4QtsOMtoslD42
         1m2x7JeviSkT+6a0DDmtk3352V5vC2zODwSo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690367411; x=1690972211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTp3lWOa4enqnnJtPatmpsbCOMEyt2QR5UoDl0egg08=;
        b=ZYqkHRaxud0KkIfxnQgnqvYdM8gPW+mF/NG8kXmcVdLdY7mNIb6QGFvvf40cYoSNgr
         whxFHb9PCcgU2nMp35M9b/3yC6ZXUy/1GRMTM7nO1ZMhYNXWMHXAy0nAwKfuh1B5PPh/
         hgSlevftQqfK0n5SF9i08dIC6hNR1nG+eqsVIBRFxEsQRgB6D2j+Eax9ZWG7fsNkXZqX
         6DgscttfF3rUn7i2t/ibIItiKAr9Nr6Jyzeaspmzqm4e5pmrNkTgvN4mJuI6R/eJUS6P
         kOBUzqTVy+NyjYuNVUTSHS2Q7+4Cxoho1kkoRhw7fOzD7kcKpZZbRXY9KXCYRL/Qn+/q
         8jew==
X-Gm-Message-State: ABy/qLa//QmxmebTXyBtywvIEA8DN5eMJNbu0nNsh1qL1pqJLhZ3PfJg
	REbfE9wTVmg4lKRS0kppCPINqQ==
X-Google-Smtp-Source: APBJJlHQAi72WGV2GbGe8wvaVLOW245nW2auiZg9IEQZ6jnW7cUxgb+TrfgWpmozA/5rJdkpi3JzsQ==
X-Received: by 2002:a1f:4ac4:0:b0:46e:7558:a45c with SMTP id x187-20020a1f4ac4000000b0046e7558a45cmr836922vka.8.1690367411455;
        Wed, 26 Jul 2023 03:30:11 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id h9-20020a0cab09000000b0063019b482f8sm1479020qvb.85.2023.07.26.03.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 03:30:10 -0700 (PDT)
Date: Wed, 26 Jul 2023 03:30:08 -0700
From: Yan Zhai <yan@cloudflare.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jordan Griege <jgriege@cloudflare.com>,
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Yonghong Song <yhs@fb.com>,
	bpf@vger.kernel.org, kernel-janitors@vger.kernel.org,
	kernel-team@cloudflare.com, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf 2/2] bpf: selftests: add lwt redirect regression
 test cases
Message-ID: <ZMD1sFTW8SFiex+x@debian.debian>
References: <cover.1690332693.git.yan@cloudflare.com>
 <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
 <3ec61192-c65c-62cc-d073-d6111b08e690@web.de>
 <CAO3-PbraNcfQnqHUG_992vssuA795RxtexYsMdEo=k9zp-XHog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-PbraNcfQnqHUG_992vssuA795RxtexYsMdEo=k9zp-XHog@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Apologize for sending previous mail from a wrong app (not text mode).
Resending to keep the mailing list thread consistent.

On Wed, Jul 26, 2023 at 3:10 AM Markus Elfring <Markus.Elfring@web.de>
wrote:
>
> > Tests BPF redirect at the lwt xmit hook to ensure error handling are
> > safe, i.e. won't panic the kernel.
>
> Are imperative change descriptions still preferred?


Hi Markus,

   I think you linked this to me yesterday that it should be described
imperatively:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc3#n155


>
> See also:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc3#n94
>

I don’t follow the purpose of this reference. This points to user impact
but this is a selftest, so I don’t see any user impact here. Or is there
anything I missed?


>
> Can remaining wording weaknesses be adjusted accordingly?


I am not following this question . Can you be more specific or provide an
example?

Yan


>
> Regards,
> Markus
>

