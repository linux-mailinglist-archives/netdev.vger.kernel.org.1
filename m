Return-Path: <netdev+bounces-50488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625117F5F0D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF41B212DD
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E194022307;
	Thu, 23 Nov 2023 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBFf5fkf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E871AE;
	Thu, 23 Nov 2023 04:34:06 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id 5614622812f47-3b83432ca31so558170b6e.1;
        Thu, 23 Nov 2023 04:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700742845; x=1701347645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPPy8qkiNT+1iKGdPsvtmA/DwzmWepFVMYHd5NxRPoA=;
        b=HBFf5fkfl79sX19AJ8pQ6fy8HAmcTvaQCrtlqRUPvk7RU6Z1N/F7ZqSPxaU6daNFRc
         QXv3lx8Uxvlk/M3L3E9zTm2lBdJelQ2Lxn8Vart7NywJPmmKuyfu/Vkl3A9R+X8g5LUC
         hbzGeJu5VpL3jaqbDKL+a22xSBxYgw9u4v3NYDT383XBmOO3FrHQyso93XIPj/exGsS0
         JwQHni0OBBtU0Bq0qReFdOQB1ciLM4+cBQVzD1o9EOxU7I803lz6dUS1FksKsPBrfRbc
         y/I3TDnSWJVB/lUmj48hnUFg+6eldFaC+kdLbJYMkE0pIPppuSq8w7zHI6IYoWKnobSZ
         sebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700742845; x=1701347645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPPy8qkiNT+1iKGdPsvtmA/DwzmWepFVMYHd5NxRPoA=;
        b=np7oQANIRt2EiZBtDrrYnrRua8ZsUn8MgngiyV9CO6b6PvmPs7IXxdqa6C8e05D+iH
         ChXdA2EBVdiWC7hjf3g2fp3LOrW9blBmgecV2sLpNqTy3qnP0hpo+IfJeBSBTZuhBsfe
         Oq+K2Ca7/IO+eSHFrYCWVkVuU8+hMa8NcQtq620OU0rGekFUNHkuXdwg4tNhrPWy2Voo
         Jn1oSVCbPkpbjex2Nozb3mW853D3OcLawGgdF3oTaCExhIlyg9HHEFKx/KorlP2Du+Tv
         DHGGCqMFuqYiIFwVm+sRZKrCuj4gaFoSHbdGkEaUybNqa47WSbf04YKFbCPAPBRBxFGw
         zzOg==
X-Gm-Message-State: AOJu0Yy312OZEpCcH1+kUBNsTi8Ei0YOM0L999G6fNs0OJJuoEX3akyr
	62AQw5iGbrGR4cIJ1rwN7Gg=
X-Google-Smtp-Source: AGHT+IHVrufbh0WNZoNRW7ZcGYijS+QgKpuuOgTShTbtMi8aLnm/tGCjyBJFpC5nICL55RW/DIMtuQ==
X-Received: by 2002:a05:6870:1f14:b0:1b0:2f63:4ff6 with SMTP id pd20-20020a0568701f1400b001b02f634ff6mr7317095oab.1.1700742845671;
        Thu, 23 Nov 2023 04:34:05 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y18-20020a62f252000000b006cb4379061esm1102059pfl.205.2023.11.23.04.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 04:34:05 -0800 (PST)
From: xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To: tung.q.nguyen@dektech.com.au
Cc: davem@davemloft.net,
	jmaloy@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	xu.xin.sc@gmail.com,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	ying.xue@windriver.com
Subject: RE: [RFC PATCH] net/tipc: reduce tipc_node lock holding time in tipc_rcv
Date: Thu, 23 Nov 2023 12:34:01 +0000
Message-Id: <20231123123401.2040138-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DB9PR05MB9078EEC976944CACEC531C1388B9A@DB9PR05MB9078.eurprd05.prod.outlook.com>
References: <DB9PR05MB9078EEC976944CACEC531C1388B9A@DB9PR05MB9078.eurprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>>>This patch is wrong. le->link and link status must be protected by node lock. See what happens if tipc_node_timeout() is called, and
>>the link goes down:
>>>tipc_node_timeout()
>>>   tipc_node_link_down()
>>>   {
>>>      struct tipc_link *l = le->link;
>>>      ...
>>>      if (delete) {
>>>         kfree(l);
>>>         le->link = NULL;
>>>      }
>>>      ...
>>>   }
>>
>>Happy to see your reply. But Why? 'delete' is false from tipc_node_timeout(). Refer to:
>>https://elixir.bootlin.com/linux/v6.7-rc2/source/net/tipc/node.c#L844
>I should have explained it clearly:

Thanks. I see, so the root reason for holding node lock before tipc_link_rcv is to protect
links from being reset or deleted when tipc_link_rcv().

For further discussion, to balance incoming packets (the same links, different ports) to
multi-CPUs, maybe we can try RCU + spinlock here.

>1/ link status must be protected.
>tipc_node_timeout()
>   tipc_node_link_down()
>   {
>      struct tipc_link *l = le->link;
>   
>      ...
>     __tipc_node_link_down(); <-- link status is referred. 
>      ...
>     if (delete) {
>        kfree(l);
>        le->link = NULL;
>     }
>     ...
>   }
>
>__tipc_node_link_down()
>{
>    ...
>   if (!l || tipc_link_is_reset(l)) <-- read link status
>    ...
>    tipc_link_reset(l); <--- this function will reset all things related to link.
>}
>
>2/ le->link must be protected.
>bearer_disable()
>{
>   ...
>   tipc_node_delete_links(net, bearer_id); <--- this will delete all links.
>   ...
>}
>
>tipc_node_delete_links()
>{
>   ...
>  tipc_node_link_down(n, bearer_id, true);
>   ...
>}


