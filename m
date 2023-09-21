Return-Path: <netdev+bounces-35551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B499D7A9CAA
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9320B284A58
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C6D66689;
	Thu, 21 Sep 2023 18:34:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34183516CC
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:34:36 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EF4D9D0A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:30:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31f7400cb74so1249571f8f.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695321041; x=1695925841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=je3lP1GqCpTp1WJIazL9sCEzHC84Hlh5WUKnq4wtUQQ=;
        b=XlulifhbCFajWGBJyUp5ueWde0aAaVK4pzUc+F3lS+RxIJRU1GKc0zQCk/S5ClXjge
         3LukVAfwxTiAYsNBEaMaEX4bsMmOzlBhsKBzy/j5FSVqGTmsxd5SMBeoyZOkcNrXEgPy
         vj3CmKHfENTPmC4aAgI6GZm0gqd72MdWV8sf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321041; x=1695925841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=je3lP1GqCpTp1WJIazL9sCEzHC84Hlh5WUKnq4wtUQQ=;
        b=Ukk/SbRiNvklQv1RKfC4piWTOgNtlrbF+OUAuzxfBH+hCjFIarOyjmTosq4cpGsu2a
         84OD+0pTC3i1uNwYxyB67XvBxHLfrjhghnxKTynfCd308JIRpKPacsG605JlAIK/EUvI
         gMRrJU9ffE+URTkhF+PRR8FOIyyP1OVZ8vhYZBuNAiavq7fq8qeD+Gp9MyPV84aNMGxG
         YoERD2j/n8NH+ZtTfktuWb5JMj3xHPt8+JgBs8bUlzm9FGKxOO+Nkb0vGcwGnvdrzfc+
         prEOz1394DN4IvZ56sd9HPW2z20mT4pcih/oA5525lzXVj+yH8SLo2m4uGY1Grd3gRIS
         4u7Q==
X-Gm-Message-State: AOJu0YxEUYU3N9xqpF/UCnaF6pe9plERmlnBIcicOqdsCGhET0qaE+ml
	H0NZMZ7AvSCLfEfo7ltvulbB3U3LiyOQMaJvy6xwkO1m
X-Google-Smtp-Source: AGHT+IElO/+qEPSqYAZJWwQC/FbKN+ycchxgR7d2NsOA9RrYCOvQR7KGzsEt+9h2lBuB3S2j4+gxUw==
X-Received: by 2002:a05:6000:1b01:b0:321:69ba:d851 with SMTP id f1-20020a0560001b0100b0032169bad851mr5841286wrz.5.1695321041280;
        Thu, 21 Sep 2023 11:30:41 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090671d600b009a193a5acffsm1381400ejk.121.2023.09.21.11.30.40
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:30:40 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-530bc7c5bc3so1608996a12.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:30:40 -0700 (PDT)
X-Received: by 2002:aa7:d4d7:0:b0:525:691c:cd50 with SMTP id
 t23-20020aa7d4d7000000b00525691ccd50mr5853774edr.24.1695321040242; Thu, 21
 Sep 2023 11:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a15822902e9e751b982a07621d180e3fa00353d4.camel@redhat.com>
In-Reply-To: <a15822902e9e751b982a07621d180e3fa00353d4.camel@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Sep 2023 11:30:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsTjLdt7RX-f-sFxqu_PieiBz=2OTjBF1CgW4j+OHfag@mail.gmail.com>
Message-ID: <CAHk-=whsTjLdt7RX-f-sFxqu_PieiBz=2OTjBF1CgW4j+OHfag@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 6.6-rc3
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 21 Sept 2023 at 07:35, Paolo Abeni <pabeni@redhat.com> wrote:
>
> I'm wondering is if my PR reached somehow your inbox and/or if I have
> to re-send it.

I got it fine, and just merged it (still going through the build test etc)

                Linus

