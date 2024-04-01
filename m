Return-Path: <netdev+bounces-83808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB8894561
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 21:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D1E282996
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BCE535D9;
	Mon,  1 Apr 2024 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ek29hGDr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34A53384
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999055; cv=none; b=orwjsbhF+EhT4k/YpOkozamKhGrRNSifEkpl8BrKwwjcR3tqnXBIe7iTpvgtDdx6NXpzYE52N9PnZAKGlCiIaOCPGv4r3lS1iMNb4CnfPVivFlHlXRW1R1Xr2nDf1+LOay6EsGohIafTeT2b0GGa7lqlTVPWRiaXdVXJlw0GXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999055; c=relaxed/simple;
	bh=HulfUPQNpC+qxMLkipOzHkdsDRCw8iYcUldG308ddGU=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KagQJ54hsjqlo8CFoWNJ0qOi25+Ai4l0ykIOFBDE2mH2JcD6zaoW5qqL4RPM0HKnzUaoDgHfjBPcwMAh9pQc1NjUaY2nCCXHfAdyNJ7s+l2hdZMW29mc7OXM1zOMTKxtTLRXe1EZPQhMC69ETi2PImH+BdsskUpPbE7Xc5DAj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ek29hGDr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711999052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HulfUPQNpC+qxMLkipOzHkdsDRCw8iYcUldG308ddGU=;
	b=Ek29hGDrNpk2WFzJZhdGGV4jL77cNJHxibJD1Y0P0FwzBrXtEGUt1sUlgf3A/+cfWk+qeH
	t16cfNvtDay+PQH/YzeTuc1ekhRY3tk7PWVBKNP9K3FwM5H5UyOkgXrw4pdlylpWxmKzoY
	e7zOFXs4OiLC6Ej5TwrU5cdgV4nzX1Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-y16fSVlyPM28rXhr5GV9PA-1; Mon, 01 Apr 2024 15:17:30 -0400
X-MC-Unique: y16fSVlyPM28rXhr5GV9PA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5681b29771fso3942969a12.1
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 12:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711999046; x=1712603846;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HulfUPQNpC+qxMLkipOzHkdsDRCw8iYcUldG308ddGU=;
        b=valzd7Np1tw81jZL+5lDRZVEGd9tJLjDkva75lzfi8y+w9zBeWK1y8WE0oeNb0xJVQ
         RTEV6wB1IWShjf8VNVm99NAG5RHRJX+rkBrp76SSWjEsp+/hFY//IriXeYambZhDJPww
         DYfB+oGl9KXxClfeFLyX/dBb/fERRNt/prCnUAkPVyRlA6j9xKuITkaUe1OmBEOdM6lY
         Ml54v1nE3XWAMtRTDhtfMqoqJRAVGgdXUA4bxRbSS3QRiWQT29d8WR7kvs2LpHIHIml0
         n8g6JiudBBvoUjF4YiGTEuc5bXU97VuHZ7S26onhGmjzGZeQ3WWvJER7YYJylf4XKnsJ
         A6cg==
X-Gm-Message-State: AOJu0YzbQjoMf1nCKujPIYYwrmDb8pc+w9823spu23PSm5UMIcK8sCn0
	bJ0mTBtiRw153JZhydXWXKhgYQC7fCr4JGovw6Lv4cFdZ73sOEmbH3HCUitdNAlNZMYOTXoQUpY
	9lf6htZWe9qKkz5ADSqqVuwhE7QXbdfvIYDPoYWw+lAzhV0whNmP9L45J1cBmxJstfyDe+4rxTG
	I6C96Ess6kP4FtgDj8eChgDhX9MhL2
X-Received: by 2002:a50:d48d:0:b0:567:824:e36c with SMTP id s13-20020a50d48d000000b005670824e36cmr7000220edi.14.1711999046051;
        Mon, 01 Apr 2024 12:17:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOhbBukYqXLYWTftwKRHjLG6yHJ6cBm6u4VvEtvFvKjjF1MpNgvkMlxNSn0UPDrgNIES0COK4PcDqRIbFVSqk=
X-Received: by 2002:a50:d48d:0:b0:567:824:e36c with SMTP id
 s13-20020a50d48d000000b005670824e36cmr7000186edi.14.1711999045687; Mon, 01
 Apr 2024 12:17:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Apr 2024 12:17:24 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240325142834.157411-1-jhs@mojatatu.com> <20240325142834.157411-15-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325142834.157411-15-jhs@mojatatu.com>
Date: Mon, 1 Apr 2024 12:17:24 -0700
Message-ID: <CALnP8ZZYF45uST4S68Y_-Sx_YirSfY9eNY8=bombEXm8+3W1Zg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 14/15] p4tc: add set of P4TC table kfuncs
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	Vipin.Jain@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 25, 2024 at 10:28:33AM -0400, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Be noted that I don't know much of eBPF code. But otherwise, things
LGTM here.

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


