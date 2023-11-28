Return-Path: <netdev+bounces-51801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA4F7FC380
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 19:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5161C20C63
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8D037D11;
	Tue, 28 Nov 2023 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XIMrjsr4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6FEDE
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 10:38:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so7559976a12.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 10:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701196682; x=1701801482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8DwRGEPfz1X093s5ICMQwVtUB8eba3JYShlmbbCybPs=;
        b=XIMrjsr4mnbG0OT7LSqkRp8R7Kjq7I2sxiMDGFsjQUvteWOU95Xs0T+W9OX488EbbW
         EKFYC+pNzA93v5GdgP+TAQB2eqsTooqRcPKY5TZMbKsz92/JdQXLuH3cnWh434mx6zOs
         Mipwrsk2fTrdMIl/y1IDeceBu7+S42TCcOTxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701196682; x=1701801482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DwRGEPfz1X093s5ICMQwVtUB8eba3JYShlmbbCybPs=;
        b=ZY6xZkeXbNGaLLdbhDAmeP0vT0THsQZcFZH3ZiylZx8+PxRhk9Y0DNULjiLI8onqm4
         TARDaITLVMzmuq3jmfcidtD5JMBY8bKfXjCaq9KSBIoKhoWN15k+6koQVhveeeBnxws1
         a4wRxcj5tQaPbDdxsRq2S9L65X2hdVp6lAxvpj1NJqG1UP4kwvJB4gd5QKMixgj7PZYy
         cGZXk+s0jLDqDKh3IGtpaKvyRqzB8J5d6JhuVt9498uLa2g8NN3kgf0kGfBt7kt9LRmy
         lLqNgkAT0xUVuL5jOBvVtm5yiLUMfyqch8iD7IsQgKS7MQmQ2FXxzXBku26uAAwA5TFW
         9Epw==
X-Gm-Message-State: AOJu0YwtbKCcv2DkAKHytCIYgVrI2zeX/C2iHi6ub881QldBMa2S0Pp2
	35ASQu7tIgOGKYl21vuExG4ihI63IE705MBMPN1Vu/S7
X-Google-Smtp-Source: AGHT+IHOnNWLO0VeUyFnI2y7En9YzP/z/eQSLiaDHYilw3rvfezXl9cFeIBdEYRRJA3lb3eRdc9M9A==
X-Received: by 2002:a17:906:dfcf:b0:a04:937a:f8b0 with SMTP id jt15-20020a170906dfcf00b00a04937af8b0mr11404726ejc.28.1701196681962;
        Tue, 28 Nov 2023 10:38:01 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906455000b009fd7bcd9054sm2456201ejq.147.2023.11.28.10.38.01
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 10:38:01 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso7582211a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 10:38:01 -0800 (PST)
X-Received: by 2002:a17:906:d7:b0:a16:88e8:2de7 with SMTP id
 23-20020a17090600d700b00a1688e82de7mr1294528eji.23.1701196681241; Tue, 28 Nov
 2023 10:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
 <cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com> <CAHk-=whLsdX=Kr010LiM2smEu2rC3Hedwmuxtcp0pYtZvFj+=A@mail.gmail.com>
 <f1673f31-b1b4-2c50-92ff-c6b5e247586f@marvell.com>
In-Reply-To: <f1673f31-b1b4-2c50-92ff-c6b5e247586f@marvell.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Nov 2023 10:37:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDMAXiJ7E_KQFnDRmYzD-Mt803LMEwzSTA4D-fngGdSA@mail.gmail.com>
Message-ID: <CAHk-=whDMAXiJ7E_KQFnDRmYzD-Mt803LMEwzSTA4D-fngGdSA@mail.gmail.com>
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
To: Igor Russkikh <irusskikh@marvell.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Nov 2023 at 09:54, Igor Russkikh <irusskikh@marvell.com> wrote:
>
> Thats already with the patch applied, so no panic and next "ifconfig up" recovers the device state.

Ack. At least it's recoverable, I had to reboot the machine when it
happened to me (and am very happy that at least all the logs made it
to disk).

> I will submit a bugfix patch for that solution, but will also continue looking into suspend/resume refactoring.

Thanks,

                   Linus

