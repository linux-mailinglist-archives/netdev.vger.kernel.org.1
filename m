Return-Path: <netdev+bounces-53039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306AD80124D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB6E28145A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626A44EB51;
	Fri,  1 Dec 2023 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/OAMFXo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA72197
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701454231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fRXiNrNPKiDFgz8DPu1vSIm3CvEveXUVSSYy903F8ik=;
	b=Q/OAMFXoahbrNO9u2fpHhs8rg5ue8Q2zCpTM1NVp7JyP5XeXjZtF1bMeUqOey/NEh+BiOs
	zjuSdZPKq3ejfliVBVpYsnTQE9u2n2Qt8GpV8tYpWaB4AAdTlk8jPKfmjsd9tsI5EXDrae
	fyfQzyNcmoHqzHVC8e4DGLOjSMIhUYQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-AbvB7Vi9PaGeLJcx_kGZpw-1; Fri, 01 Dec 2023 13:10:26 -0500
X-MC-Unique: AbvB7Vi9PaGeLJcx_kGZpw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50ba80696b3so2704327e87.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454225; x=1702059025;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRXiNrNPKiDFgz8DPu1vSIm3CvEveXUVSSYy903F8ik=;
        b=rDCOst1aY5Hg/CaeyikacZHe7sB0g5HJSL5x3R74oF/mn5gWYN0AaoLnuWdv2wORsx
         +6e58uD2LqcJMiSSW0SI0xRdfqwQOQ6IN02Ow1Nhm2+pv9hsHfpVVG2krrn6MSmsw7NM
         MSmygzCcPGGiMFRo7fNYatFijpe6YSgQR8lu3iPXTBRPYwXifDFInbZAdcnTp4KzEduG
         9gb0vwZZSIZh5exE2MluRu07moNo6EqmdgDBp993FsfDLBlNjTCuetuPjxY8d7OhYX9h
         XLnZLzCL2uI2ksaxtqlglYWsB6XXHuSDmpgK0V9lpz8+zTFOXMlTOtTSwYU/+vA4eLjD
         uefQ==
X-Gm-Message-State: AOJu0YysWiYYwqg0u/JeVEukNdYbCgwYfLQNDcFRmOrFbn2H7fKOT7Hx
	Zow4weGCg3HN+Nopgtmp5ItSw27hXlohAUSTjmDT2J14JoijhmwtmpkucAwzQ/PPgjuu60sj++9
	6iND3t9vP8pYYFQKVUQ4LKdcKjj1Um6dG
X-Received: by 2002:ac2:5397:0:b0:50b:d764:6ea8 with SMTP id g23-20020ac25397000000b0050bd7646ea8mr1060542lfh.88.1701454225051;
        Fri, 01 Dec 2023 10:10:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK6xAnmCWdsT3pEi3Le8AbgLoyJUu4HvXmV6PO0aG4aZ4bIejXj2oLFb7iFDN+CEHKcWn3rx17nmFZjfcnBk0=
X-Received: by 2002:ac2:5397:0:b0:50b:d764:6ea8 with SMTP id
 g23-20020ac25397000000b0050bd7646ea8mr1060538lfh.88.1701454224782; Fri, 01
 Dec 2023 10:10:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Dec 2023 10:10:23 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20231201175015.214214-1-pctammela@mojatatu.com> <20231201175015.214214-3-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231201175015.214214-3-pctammela@mojatatu.com>
Date: Fri, 1 Dec 2023 10:10:23 -0800
Message-ID: <CALnP8ZaPXazjfq0KES6GptxX02que_FEDzNdpLq7Bw01neKXhg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/4] net/sched: act_api: avoid non-contiguous
 action array
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 01, 2023 at 02:50:13PM -0300, Pedro Tammela wrote:
> In tcf_action_add, when putting the reference for the bound actions
> it assigns NULLs to just created actions passing a non contiguous
> array to tcf_action_put_many.
> Refactor the code so the actions array is always contiguous.
>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


