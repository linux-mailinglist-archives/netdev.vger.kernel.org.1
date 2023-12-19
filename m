Return-Path: <netdev+bounces-58808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5573881843F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BF2284DFF
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 09:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9609012B98;
	Tue, 19 Dec 2023 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HB/xOs8J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49F134A5
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702977556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHyjrBTzzv8hgHUAyTnHinUm2FdompoSEVgOa1MaGBo=;
	b=HB/xOs8JAuKeFkxctB9rKLfTh/89y10+Ni1Xq5GTepi6UcxUy22KHGmZpF2cjLQp8q6uiw
	2CA7llZWMvJo/AwRWjXqqRJDzqjZ5IpZx6zXnUlyqhO4j+E/wnp+T1w6lnKu0JwdSc3knh
	EEn5rNhL5UUh4VJJzokINu05NfmV1q4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-syziRRiXM3iV97dhHym4kQ-1; Tue, 19 Dec 2023 04:19:15 -0500
X-MC-Unique: syziRRiXM3iV97dhHym4kQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-552ab0a61d0so501378a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 01:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702977554; x=1703582354;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHyjrBTzzv8hgHUAyTnHinUm2FdompoSEVgOa1MaGBo=;
        b=UNVItzBRjAUfpD9rdXKnC18BTuwh4ZLPQmxEW5d253UakebcOSSBWDqlWkl/VghzuH
         h1LAgmrSlS6Ol/qZLjiWPhrb4Nu7+gO5rAbT6VuqRtmgA4/SppGK7WEGmGTCo2N4Va+s
         ZULk0RERiH5WqNnq0zexZF0QZM4Cbn0NZwA4LMirut1NJYVC+tm7NHxsDywDIMh5EscW
         FsGJw5IcA7Mj6mUnBsuLMByBrzyXjf32kjh4FwOF0efCkMIJKSJUR3kZnY8RfVlXXNuD
         3QBoT3MhUISJ1DVEBbAcZzR5yxFyBiEpFxLndfQA2FzenVmcIvzXOm7WaUU/ejN9iYMD
         tRTg==
X-Gm-Message-State: AOJu0YyGG1tzveaOc3IT64lcZdehtSg+eWZlHOFMk9DW6rdN82ofb4X3
	WqwLaezlTYXk+FQC7fOWmDKrWKvtkbOO1VU1YsEqbEYlnLN+p2pM+CC5U3WLN3cIfHSUCjAEHl7
	7VA3m0goOswElp+67
X-Received: by 2002:a50:9fa6:0:b0:553:1f7:7387 with SMTP id c35-20020a509fa6000000b0055301f77387mr5639703edf.1.1702977554698;
        Tue, 19 Dec 2023 01:19:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7d4mpHOiz14mHEHcX8qOxC6qX1Gv0owpqbGC1A5Zys6PvNEyn2xG+HLYZwZ+mq0Pu03opJA==
X-Received: by 2002:a50:9fa6:0:b0:553:1f7:7387 with SMTP id c35-20020a509fa6000000b0055301f77387mr5639682edf.1.1702977554343;
        Tue, 19 Dec 2023 01:19:14 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id i41-20020a0564020f2900b00553854de928sm721798eda.36.2023.12.19.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:19:14 -0800 (PST)
Message-ID: <f91f45a72f789a1f31646a5d7ed579194807b102.camel@redhat.com>
Subject: Re: [PATCH] sfc: fix a double-free bug in efx_probe_filters
From: Paolo Abeni <pabeni@redhat.com>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Edward Cree <ecree.xilinx@gmail.com>, Martin Habets
 <habetsm.xilinx@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org,  linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
Date: Tue, 19 Dec 2023 10:19:12 +0100
In-Reply-To: <20231214152247.3482788-1-alexious@zju.edu.cn>
References: <20231214152247.3482788-1-alexious@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2023-12-14 at 23:22 +0800, Zhipeng Lu wrote:
> In efx_probe_filters, the channel->rps_flow_id is freed in a
> efx_for_each_channel marco  when success equals to 0.
> However, after the following call chain:
>=20
> efx_probe_filters
>   |-> ef100_net_open
>         |-> ef100_net_stop
>               |-> efx_remove_filters
>=20
> The channel->rps_flow_id is freed again in the efx_for_each_channel of
> efx_remove_filters, triggering a double-free bug.
>=20
> Fixes: a9dc3d5612ce ("sfc_ef100: RX filter table management and related g=
ubbins")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

The patch LGTM, but could you please update the commit message as per
Simon's suggestions make it more consistent? You can retain Simon's RB
tag.

Thanks!

Paolo


