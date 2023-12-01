Return-Path: <netdev+bounces-52954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDAB800E7C
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 16:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB62B1C2094F
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D384A9A9;
	Fri,  1 Dec 2023 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwqxs9DF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4109EF1
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:22:05 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77d72aeae3bso115350285a.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 07:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701444124; x=1702048924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8ls1W7Gyn5/Aftf11MTpEGm54/XPF+rxu50TK3/jhA=;
        b=Lwqxs9DF2dEr9+OBnPKLAf7CTgsmSlCcq9/yhRSnX6YPnDm/syi0TxiVilWQL8I/5n
         worre5rs9jAPGRJ28czzB+/rqdbPBbnRzCDFAV5OQD6NSdzLbp9kAXbpq9ZEnr8Jk3Dj
         hvIZVCwKuHNkTs+7r3yUaO+++nijpUUmLy8v84M2aWBXK47LB77xMioNe3WNSKj03/Ks
         /69ge7U5tUEzWmPu79fbf97mFpryn+vRK+7tPLAo+SB7AMg+lY+sFUNs/6qEo+I40ejq
         OBeSOe/tLsHeygAONWe4CWeOoDmzqJOuE8w8Q21yGd6l94feSpvblf23Gs8FIrm+hKaV
         70sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444124; x=1702048924;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m8ls1W7Gyn5/Aftf11MTpEGm54/XPF+rxu50TK3/jhA=;
        b=B/+mQx9c/z98vKVyOYE3ffUY71TYa8FhKleuWXFuTMSO9Mjn7ymqY2y5dac7CFKqfP
         4KC0HeXM7Z2zuR8lHsVrhqpeIU1/vLV3sNj5fCRd/6XChW1KOdIAhSY3BNNbDPu6XL32
         DCuio92Al6WJfZDs0XBEUm9KIX9N3LT0dVpyd0UmiOnzzhnZE0BDwRWWRXIU2P7rq6sl
         R/mLI+tS0VPLd5FHLWTyeJP+CjWfEPWrfN40T3ilw25Y0CaAoVh6XSkS1tiONDAcDBsX
         Qr/I7rly3os6OqlTDkos/7vf3obHUtPGWY9oVwS7rTJuv0w9w9q0p6TxAW+eT7Nj6LYl
         qB/g==
X-Gm-Message-State: AOJu0YwUPhBSLdL9G9wU2JXMBGpPfl3ulDBO17QsK00T48XKZp8hXIhS
	7LDCKNDkUWRBytWRzK/NVeMroFGpYUY=
X-Google-Smtp-Source: AGHT+IGtEiayluvEfDo7/jMXuW71S2c3qtidbzOiOQItzs4pP11OKEilu/xHRZtJeyrObtZLrmHh8g==
X-Received: by 2002:ad4:4e8e:0:b0:67a:2388:e859 with SMTP id dy14-20020ad44e8e000000b0067a2388e859mr20879317qvb.59.1701444124173;
        Fri, 01 Dec 2023 07:22:04 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id p8-20020a0ce188000000b0067a49af5ccfsm1568967qvl.119.2023.12.01.07.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:22:02 -0800 (PST)
Date: Fri, 01 Dec 2023 10:22:02 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: shaozhengchao <shaozhengchao@huawei.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: luwei32@huawei.com, 
 fw@strlen.de, 
 maheshb@google.com, 
 weiyongjun1@huawei.com, 
 yuehaibing@huawei.com
Message-ID: <6569fa1a427c0_1396ec2945e@willemb.c.googlers.com.notmuch>
In-Reply-To: <81b8bca0-6c61-966a-bac8-fecb0ad60f57@huawei.com>
References: <20231201025528.2216489-1-shaozhengchao@huawei.com>
 <81b8bca0-6c61-966a-bac8-fecb0ad60f57@huawei.com>
Subject: Re: [PATCH net,v2] ipvlan: implement .parse_protocol hook function in
 ipvlan_header_ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

shaozhengchao wrote:
> 
> 
> On 2023/12/1 10:55, Zhengchao Shao wrote:
> > The .parse_protocol hook function in the ipvlan_header_ops structure is
> > not implemented. As a result, when the AF_PACKET family is used to send
> > packets, skb->protocol will be set to 0.
> > Ipvlan is a device of type ARPHRD_ETHER (ether_setup). Therefore, use
> > eth_header_parse_protocol function to obtain the protocol.
> > 
> > Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
> 
> Maybe Fixes should be: 75c65772c3d1 ("net/packet: Ask driver for
> protocol if not provided by user")

Definitely not anything older than the introduction of
header_ops.parse_protocol.

I gave my +1 when it targeted net-next, so imho this is not really
stable material anyhow.

