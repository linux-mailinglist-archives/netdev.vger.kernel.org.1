Return-Path: <netdev+bounces-37376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA187B51A7
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 13:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9BEA1283E0F
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 11:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408AE1427D;
	Mon,  2 Oct 2023 11:46:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4BCE566
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 11:46:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6D5DA
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 04:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696247186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRwrkzD0w10tCSUUzCWjRMQfbVxEDGvV47bbOrtZBrE=;
	b=hoOguVQ9+cVbU1DbcybXXWDBdaeXMCSSrjFkxwSCXXtDESkbEJfoEql20rAA34sb6mVehi
	HI/ABPtLwkQHeKcdvOyUn4li5vO4S7ZeBbg1Ad3dIT86DX9nHiaxcjRdwJAWch41SHTy/B
	Q5nLqacEg8zTIRco3uUIp9rWcSJJQZs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-pvJCDyhbMgaerEU1jVoatA-1; Mon, 02 Oct 2023 07:46:25 -0400
X-MC-Unique: pvJCDyhbMgaerEU1jVoatA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso135199855e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 04:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696247184; x=1696851984;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRwrkzD0w10tCSUUzCWjRMQfbVxEDGvV47bbOrtZBrE=;
        b=fdw6IWcO2fB8USEEYIWq2PoDevzZtD1fTFxpcbkfxJ1YFFCVukM+AeWzV0RweBZe3/
         d3OFkJqUGCH7dsgQM4PpudrGzpql7wBxKJASDdHKS0VgJ4+T6Yzp5tihWsvuTeNi5wjV
         6xAD2kz9SBEpkvQwXAvcXTExPzE/LU9Q1WDes5n56UUPaFvFBAy67meSGktQBHmMloy7
         T8HEI3LTdw60bpBZ2HVmnbssw3Pnz7MgYfUlesbWLpw8DeU+OX6BqSJYcCtzNWkq1zPY
         pJhi60cr1yIcPYpk9QueeQcUKNK1qdfbgwXvbdmT19Kf0KNH5B6vOtT0jOg0z6IusGrs
         mnSg==
X-Gm-Message-State: AOJu0YywiOTF7fnnR3moOWQczmFMntRVOX57Sx/OcozXCuqJTvZI3L0l
	wwd97TBIfAmPAkFmNKc1TCzHR3XGXbfcY7YmYzNBBkMWQfcEdOz/yG7XCv4LCUlCRFwnALQzeQk
	NSlN1TvLyeeaFtW69F5s083re
X-Received: by 2002:a5d:690a:0:b0:321:5211:8e20 with SMTP id t10-20020a5d690a000000b0032152118e20mr9264005wru.59.1696247183890;
        Mon, 02 Oct 2023 04:46:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESjntMUtABw82D/xyF9CTeslkvNAohuKEPygLaGQ/sFZ7H1y9XceJeJV91BzY2CJbZHGo+3A==
X-Received: by 2002:a5d:690a:0:b0:321:5211:8e20 with SMTP id t10-20020a5d690a000000b0032152118e20mr9263990wru.59.1696247183530;
        Mon, 02 Oct 2023 04:46:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bf18-20020a0564021a5200b00538538f1fcesm1808809edb.47.2023.10.02.04.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 04:46:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5861DE573D7; Mon,  2 Oct 2023 13:46:22 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh
 <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] net_sched: sch_fq: add 3 bands and WRR
 scheduling
In-Reply-To: <20231001145102.733450-4-edumazet@google.com>
References: <20231001145102.733450-1-edumazet@google.com>
 <20231001145102.733450-4-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 02 Oct 2023 13:46:22 +0200
Message-ID: <87edidgsc1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet <edumazet@google.com> writes:

> Before Google adopted FQ for its production servers,
> we had to ensure AF4 packets would get a higher share
> than BE1 ones.
>
> As discussed this week in Netconf 2023 in Paris, it is time
> to upstream this for public use.

IIRC, when you mentioned this at Netconf you said the new behaviour
would probably need to be behind a flag, but I don't see that in this
series. What was the reason you decided to drop that?

[..]
> +static int fq_load_priomap(struct fq_sched_data *q,
> +			   const struct nlattr *attr,
> +			   struct netlink_ext_ack *extack)
> +{
> +	const struct tc_prio_qopt *map = nla_data(attr);
> +	int i;
> +
> +	if (map->bands != FQ_BANDS) {
> +		NL_SET_ERR_MSG_MOD(extack, "FQ only supports 3 bands");
> +		return -EINVAL;
> +	}
> +	for (i = 0; i < TC_PRIO_MAX + 1; i++) {
> +		if (map->priomap[i] >= FQ_BANDS) {
> +			NL_SET_ERR_MSG_MOD(extack, "Incorrect field in FQ priomap");

Can we be a bit more specific than just "incorrect" here? Something like
"FQ priomap field %d maps to a too high band %d"?

-Toke


