Return-Path: <netdev+bounces-57497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291A813317
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D214DB2142E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF70C59E50;
	Thu, 14 Dec 2023 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJcbGw6q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462929C
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702564162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YfFhoDq7fFwsJo/Sa7wXXhSK/Yxi3J00ymRdToGDQ30=;
	b=gJcbGw6qOlysETDveJOVCn3eanwweFz2HAvXec9h6nnsSzR9Te1I1FTv8eQXNZ54DDyCOd
	/Zpf+V5k1cRHLf3g/CoIPMaOqtR+obfq8QK6Ut+gEcajlB0uS85GHnq9VXaF/qyUdRNEL6
	HDo1VeOGQeWkYheRNt41l03ENhX21tw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-v136PeI1Ni-rKC9VGaWtoQ-1; Thu, 14 Dec 2023 09:29:20 -0500
X-MC-Unique: v136PeI1Ni-rKC9VGaWtoQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c9fa16728aso64964831fa.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702564159; x=1703168959;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfFhoDq7fFwsJo/Sa7wXXhSK/Yxi3J00ymRdToGDQ30=;
        b=QZv4X9rixWd1NqzHZDb7WmeE/YtjLpRbaQcroaredWFSnlBX/1+sqSe1h96wjmbwbU
         dzaFjFIesPIAi+3rNZKB+GNe8wMfgCln7euJ2bjXAZ0d19htBt+7mgyD/5YfleD6NgMv
         mtUxx+2dHUa3b4Q2yC6QnCrRYSogvdcacvIdw5u+oRWCPrb+VOFAcsgy3vgcozbJU6AB
         Rds8bjrHOT7l7TFU+2uSkj3lFagV/5DqHnQenxRnZ0CABpoN0KoY/M0YaYiP0FkKoDg5
         ZPEJGSzeeJHh1Ds+tEDoX1i/WZjqJ7wuJ8QBcWRvq4ikCFantx1VgQWSB28JXRKfpZrh
         9uHw==
X-Gm-Message-State: AOJu0Yxun0BJ6r+o/mFeqHK44JmOtuHf9W++sIDZdYutx1Us2Fu9q39w
	p1iRzX4VhfwMjOQWMu18MP6q6r/Ww7ghzanQjKLU80N86FpDMjr2fGr/991hroyYnxReaDELJeY
	AAp+RuJ1+JcVw2likTs0uit8hzC6Q4aE2
X-Received: by 2002:a2e:a492:0:b0:2cc:41c2:9b94 with SMTP id h18-20020a2ea492000000b002cc41c29b94mr634372lji.70.1702564159423;
        Thu, 14 Dec 2023 06:29:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlJACUjHbSEQlcvSweafW/oT/8jL05bpLUHMiT3DWYxEAWsx2vrkN/koo8wVXPA8RGuNOx3IFVFk3oo4Uy9Qk=
X-Received: by 2002:a2e:a492:0:b0:2cc:41c2:9b94 with SMTP id
 h18-20020a2ea492000000b002cc41c29b94mr634362lji.70.1702564159075; Thu, 14 Dec
 2023 06:29:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Dec 2023 06:29:17 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20231214141006.3578080-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231214141006.3578080-1-victor@mojatatu.com>
Date: Thu, 14 Dec 2023 06:29:17 -0800
Message-ID: <CALnP8ZaFy9ZGbaeB1r6H7a1VLBWjgg9De5RGExnw9-zYSEtF1w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/3] net/sched: Introduce tc block ports
 tracking and use
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 14, 2023 at 11:10:03AM -0300, Victor Nogueira wrote:

LGTM

To the patchset,
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


