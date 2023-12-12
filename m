Return-Path: <netdev+bounces-56375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D4480EAA7
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8AF1F21BEC
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A0A5DF0E;
	Tue, 12 Dec 2023 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhsp2ghc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60945EB;
	Tue, 12 Dec 2023 03:42:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-336210c34ebso1976794f8f.1;
        Tue, 12 Dec 2023 03:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702381372; x=1702986172; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9w4b6VRQihocHrlRwUQgB3XxXWsq2m7i8gO53J6PyFA=;
        b=Mhsp2ghcVeiyD78JD+MPKJKWOROqDPWtUTg0togTTqeXLN4xgY9Fs/I4YGEycVSWT2
         aw4ubJxIq4V4pJGO05UoQ/paVMGZoj7KBJfGw+4hs43FpqaUCJxnqDHIs3nmlhvxu3qK
         JHrTgc8N2ldorIGovpGINRveqFXUADub2XhsOSXdudSLsaGBe8qWkSwMZSNtyFQvymO5
         EBKy2oI+ysM78W2V2/+2eiUn1gWoerRBtIQBxBhf5Xn1OywNwvcbos7gFJodYLfATQU7
         lAlrjs4AIjfU2YndHEDoV++ZLUVTXiXPuHFVucY7UiEq46sNP39ar+hkisli9OO7wiF/
         LyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381372; x=1702986172;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9w4b6VRQihocHrlRwUQgB3XxXWsq2m7i8gO53J6PyFA=;
        b=imawi067iWEWQnknrNlhcDkKqacCbD+ZJ1Ku6NKSmVYPi7y4ZoIkgekUTJJuqu9lcG
         nvyPKarofYA5Z4cgYS7+d2ZYC5cRxFdGCqVitnsMTCZR0UwotjFH5r2PAlQA2KrxPCFF
         qH49Ihoixyd1ED2CEiGCIxSerBCtkAU6T6kIHEtCBh/w9yxrrAGGhrbHwO7TNputf4Yx
         UBcwn828xFr+wRHyYy9oXr1GDLe3v/FoVrrmeKHLB+HE4+CrhfXaN50kAu9VbH9NGJsA
         PQGUJ0lnVTG1ag3+yB9Dyt5fpWPENTLbjg+9DfNriJwHJeTRZFBdffCRUFH/27W3SfaI
         KXGQ==
X-Gm-Message-State: AOJu0YzVlIwN4uo8wKrpwLb19XsimRJ7zY9lzOitlpDFpiFeWf1nL98T
	NJPATZdGp9hgYhHLR99sjk8=
X-Google-Smtp-Source: AGHT+IGDtFdmNf813idpm19eK2m4ePkyDcLf+Zl0FzWbESq438U2OLcXzt3sBM+N2nnLtERPAFV+8w==
X-Received: by 2002:a5d:5088:0:b0:333:3c1d:5aa6 with SMTP id a8-20020a5d5088000000b003333c1d5aa6mr2466058wrt.72.1702381371626;
        Tue, 12 Dec 2023 03:42:51 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b0033335d9dcc5sm10700513wrq.64.2023.12.12.03.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:42:51 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com,  leitao@debian.org
Subject: Re: [PATCH net-next v2 02/11] tools/net/ynl-gen-rst: Sort the index
 of generated netlink specs
In-Reply-To: <20231211153000.44421adf@kernel.org> (Jakub Kicinski's message of
	"Mon, 11 Dec 2023 15:30:00 -0800")
Date: Tue, 12 Dec 2023 11:30:11 +0000
Message-ID: <m2cyvb8xq4.fsf@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211164039.83034-3-donald.hunter@gmail.com>
	<20231211153000.44421adf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 11 Dec 2023 16:40:30 +0000 Donald Hunter wrote:
>> The index of netlink specs was being generated unsorted. Sort the output
>> before generating the index entries.
>> 
>> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>
> Please do CC Breno on tools/net/ynl/ynl-gen-rst.py changes.
> https://lore.kernel.org/all/20231211164039.83034-3-donald.hunter@gmail.com/

Ack, will do.

Is there a streamlined way to apply output from get_maintainer.pl to
individual patches in a series, or do I just add specific names by hand?

