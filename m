Return-Path: <netdev+bounces-57475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F89813248
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E1A1F21247
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFA45789A;
	Thu, 14 Dec 2023 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAPEuWb1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82499A7
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:57:00 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d9f8578932so4910440a34.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702562220; x=1703167020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2yKAEncwRm3uBvSmdHVhBg2GFoJmldNAoOXza5tMHY=;
        b=YAPEuWb1T0F2TUm038Od00ihv3slnJofKxq/RExKUhn/rfhpE7YcC40GGMrqrHqeZe
         1wSzW5Xl+sCB8XuBylEEnxdIuxuRJ57Z2Xou1QO6Zc4CmQXxWgLu6vQgHmsi+gg8OU5H
         3gOdlUgHIQAA5aD0GfZSjd13gDj4wvVZS1KQEqaAc8vNuDBVYvpBwlODjBS6Zg0mHGlz
         3HwALkhPG3X2sn9kL/ngU0IWFaIAty8R09dH/EQRRDZbeMTRwYsK3zlQDRK+uXMDVdSd
         VW5k9Zcis26NO9eLrlnk6WEUJM16V8jJxwMkCtWoZj4BZStpM96cfHENQiCW1Gli+CgO
         W/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562220; x=1703167020;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2yKAEncwRm3uBvSmdHVhBg2GFoJmldNAoOXza5tMHY=;
        b=RyiqoRGLUGczN+OH2FYZWrIVD1ppRXvnAWXEmI7EXiWmjr1BGGk3c4rYhmCq0liMat
         V1rajRwSNYEvL92iSazlMyQtiioia1ESgdIYUKUETJ84Hq8kh5CIdzQxqfC39v2bwVfq
         eU5ViB38/EajDqu6vAvkyp2G4/J1TExXkZdeYwc8Z2w4/KpdJYrP7pZjQOMJybYnPxTr
         8VYpEgo2kAt/hU8x5eXkB9qkapj3kuVvROyobxvHJ7PojLf5kypPO/3Hc7yX0BQ6dwlu
         LTqcDwOR5x0yXgdlU/fBE2QSg2z4fpUmccbduvPGEWgaof0hLNTDqaqJIx7N715YhXiw
         18vA==
X-Gm-Message-State: AOJu0YwCB+C4kqCfvdnDf9JVVUwf9YXvRX1ojgPBfRgWijE/BXFDZQEu
	dVXXSV8rkD6Jmbci8eoQxiLi16Es97s=
X-Google-Smtp-Source: AGHT+IHqJ8LTeqgViowx7ONMeQtyEQZbod4maj3ayeoZwMM4LvCr0mARgT9MAtigkVG4QNd0R0tipQ==
X-Received: by 2002:a9d:76ca:0:b0:6d9:f650:d7a8 with SMTP id p10-20020a9d76ca000000b006d9f650d7a8mr9171995otl.2.1702562219768;
        Thu, 14 Dec 2023 05:56:59 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id m26-20020ac866da000000b004240481cee0sm5805166qtp.58.2023.12.14.05.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:56:59 -0800 (PST)
Date: Thu, 14 Dec 2023 08:56:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Chao Wu <wwchao@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <657b09ab4f6ef_14c73d294b9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231214104901.1318423-2-edumazet@google.com>
References: <20231214104901.1318423-1-edumazet@google.com>
 <20231214104901.1318423-2-edumazet@google.com>
Subject: Re: [PATCH net-next 1/3] net: increase optmem_max default value
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> For many years, /proc/sys/net/core/optmem_max default value
> on a 64bit kernel has been 20 KB.
> 
> Regular usage of TCP tx zerocopy needs a bit more.
> 
> Google has used 128KB as the default value for 7 years without
> any problem.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

