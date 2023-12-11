Return-Path: <netdev+bounces-55767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEC80C380
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DEA1F20F0A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 08:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF96820DF4;
	Mon, 11 Dec 2023 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRvzhjNn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48DDB6
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 00:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702284279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LWTtRj4KzcXU71hLoOO86zVSMhjA4YYS/eymtJ/IMY=;
	b=DRvzhjNnn0g4bqrQsckei0AEBr2UA1Bai4MklJLlWfZsdeO/G6DCVdoFjer/lBFW5vBPYk
	PzYxMGufmCjXBhzBjt+r6dOsUPusJG5aX+MJD11DsEevsws1fj4vCQGbLBL0Y30domWFo7
	jFHWFGY/pZ+Y7l/WPFkJwDsEmY0Plwc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-jmgkH3U-Oa6O1i3Q5hxlZw-1; Mon, 11 Dec 2023 03:44:37 -0500
X-MC-Unique: jmgkH3U-Oa6O1i3Q5hxlZw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1df644f6a8so75340666b.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 00:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702284276; x=1702889076;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LWTtRj4KzcXU71hLoOO86zVSMhjA4YYS/eymtJ/IMY=;
        b=Ry0ngjWRde/WjHKsso5T3NlBIkgTrmyy15JXw7K3zNyuJo2f6IbCLV7w9VcMwXHnLh
         UiVBanGvAKR1O/34o8SjxnHeFZGXBWQEKWGxwd/3elY9R7bN03SRw3X9TbcLIa8123Qa
         N3TuQhd/YvSrWXkQlMApXlyKhyBxgErpswBnk7o4o8i0ml+ak6LIexor+HEnl48duaE+
         UfE6na6BZa2P8Vj1Dyuk7XTEitZC97OSBhNM3Y0qQJsbSZM0qIFhsEKpdCvJ1ko8wYwa
         aCLHehU96eLBH3Zjh4VdSwnut+0QCXBMkmM8gArJkUodbuQWy/F4m/922hFd7M34vAS7
         xa9A==
X-Gm-Message-State: AOJu0Yxc7aJKKWBwqNcIoLsD6pgt1M1jgkUzQ3D6/ze16mtsVqoJovx5
	R8o9Zy0modtgCU/kz6y7Gry7GreysuNNrClcM6suivsFByl8J+VBii7MMC/dUXxcVvnTk4Yka8u
	C0iLkfepg1M6GTkL+
X-Received: by 2002:a17:907:c207:b0:a1d:7daa:4efd with SMTP id ti7-20020a170907c20700b00a1d7daa4efdmr4169687ejc.4.1702284276121;
        Mon, 11 Dec 2023 00:44:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNBRffJXrCxYOfF2BE+lbKihjhGNMeES2n78bLLuyerFEqjYofvkFyNmZteUY/bpceg17JIw==
X-Received: by 2002:a17:907:c207:b0:a1d:7daa:4efd with SMTP id ti7-20020a170907c20700b00a1d7daa4efdmr4169680ejc.4.1702284275807;
        Mon, 11 Dec 2023 00:44:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-253-165.dyn.eolo.it. [146.241.253.165])
        by smtp.gmail.com with ESMTPSA id cb6-20020a170906a44600b00a1e2aa3d093sm4387337ejb.202.2023.12.11.00.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:44:35 -0800 (PST)
Message-ID: <83ef2da88811e616b029c50a66ffdfab52493e2d.camel@redhat.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
From: Paolo Abeni <pabeni@redhat.com>
To: Siddh Raman Pant <code@siddh.me>, 
	syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Date: Mon, 11 Dec 2023 09:44:34 +0100
In-Reply-To: <aa9e49a1-7450-4df4-8848-8b2b5a868c28@siddh.me>
References: <0000000000003e8971060c110bcc@google.com>
	 <aa9e49a1-7450-4df4-8848-8b2b5a868c28@siddh.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-09 at 16:09 +0530, Siddh Raman Pant wrote:
> Final test
>=20
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master

Please, don't cc the netdev ML for tentative syzbot-related fixes: it
confuses patchwork and increases the traffic here for no good reasons.

Thanks!

Paolo


