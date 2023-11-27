Return-Path: <netdev+bounces-51232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421177F9C56
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 10:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC5B28143E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B56134AA;
	Mon, 27 Nov 2023 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="sNcgMdc+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E267019BD
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 01:05:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00b056ca38so524363066b.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 01:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701075900; x=1701680700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HI0TOtQb9c447DbOQLQ1/RG9mFnY5yOZxPwrai0TcrQ=;
        b=sNcgMdc+JCKXIKSMPFi6NUk/N15L2yczsAzRIJsgqu0S5aOv1m8G6qIpAFiX8tMjVC
         4Wy8HhQDJ879kYAUKR+zPMNels22XSb3JzaUFxs2ZfCKcxEbvsivLWPY1ihbVXI2nw0q
         fa+YldVKngt8Ze08ZAkTmoU5Q3wIfQren2nY0/aTfEZNoBntbpRr/BmKKK+11CBiq+Ou
         3GwmEOMRz42Fc10SLihyW3D4wbdBrpKWt1b9PPDPgWbw3hgCT/LQpmi9vwoBwsXLHQZ9
         S3VA4peeeURBmD9DdudAEHZM/aJQ9ZnLTRQziZhiu5+R5h6j3xB67KKcl503gFv10SAX
         Mkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701075900; x=1701680700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI0TOtQb9c447DbOQLQ1/RG9mFnY5yOZxPwrai0TcrQ=;
        b=Ftu9AU4Gt7SfIU2oVSiPRAJnFd2gz2q6syeU9DDn1qA78kxwjDl1LeoEynn6H9ox08
         5ZoUjsIHdgXF+njXPOz1GmGPnzyA79uidXDuoLS36osuPQ+55n0r4wqLlb90xDKoFaMB
         c0ih9T0RBDnmXRvD+0n1HOMo2z0D6FeMT+UCO7RES+CZ0vjUzcrWtAAyjUpcIeOIK0S2
         qDHON0WN4ueZE01zKh+muaB4i+Wqbh4AxI5pxzVkhXBGXEZmaoXd/x6VeIVGLjz33ykX
         2TDIETC8Iufztot3FmSlDjOuORhbanOEBSWf87GvxiDWf8/39LhUKGQ/TemRx2P9PLAl
         9fow==
X-Gm-Message-State: AOJu0YxoqCNhkkMPB8dGnT1aHXttthwLeDjAEKL7Z9oHnq2dMADvxVwX
	7hiPPBByK7LquRSmqJdOajIFWw==
X-Google-Smtp-Source: AGHT+IGMN9QxP+tvYaW8enwn4HK0hNu5SbKLzvuHC5a2fj6GapL9xeT02R6kafwcgd/VY4ZU0ooFsg==
X-Received: by 2002:a17:906:9d05:b0:9ff:6257:1b4c with SMTP id fn5-20020a1709069d0500b009ff62571b4cmr6439371ejc.37.1701075900268;
        Mon, 27 Nov 2023 01:05:00 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906050a00b009fc54390966sm5508751eja.145.2023.11.27.01.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:04:59 -0800 (PST)
Date: Mon, 27 Nov 2023 10:04:58 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	David Christensen <drc@linux.vnet.ibm.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/14] net: intel: start The Great Code Dedup
 + Page Pool for iavf
Message-ID: <ZWRbusSZ4v0SuWmF@nanopsycho>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124154732.1623518-1-aleksander.lobakin@intel.com>

Fri, Nov 24, 2023 at 04:47:18PM CET, aleksander.lobakin@intel.com wrote:
>Here's a two-shot: introduce Intel Ethernet common library (libie) and
>switch iavf to Page Pool. Details are in the commit messages; here's
>a summary:
>
>Not a secret there's a ton of code duplication between two and more Intel
>ethernet modules. Before introducing new changes, which would need to be
>copied over again, start decoupling the already existing duplicate
>functionality into a new module, which will be shared between several
>Intel Ethernet drivers. The first name that came to my mind was
>"libie" -- "Intel Ethernet common library". Also this sounds like
>"lovelie" (-> one word, no "lib I E" pls) and can be expanded as
>"lib Internet Explorer" :P
>The series is only the beginning. From now on, adding every new feature
>or doing any good driver refactoring will remove much more lines than add
>for quite some time. There's a basic roadmap with some deduplications
>planned already, not speaking of that touching every line now asks:
>"can I share this?". The final destination is very ambitious: have only
>one unified driver for at least i40e, ice, iavf, and idpf with a struct
>ops for each generation. That's never gonna happen, right? But you still
>can at least try.
>PP conversion for iavf lands within the same series as these two are tied
>closely. libie will support Page Pool model only, so that a driver can't
>use much of the lib until it's converted. iavf is only the example, the
>rest will eventually be converted soon on a per-driver basis. That is
>when it gets really interesting. Stay tech.

The world would not be the same without intel driver duplicates :/

Out of curiosity, what changed? I always thought this is
done for sake of easier out of tree driver development and old device
support dropping.

