Return-Path: <netdev+bounces-13196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D373A936
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 21:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F343E1C21195
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF3D21081;
	Thu, 22 Jun 2023 19:55:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A8200C6
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:55:26 +0000 (UTC)
X-Greylist: delayed 110408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 12:55:19 PDT
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8B11BC1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:55:19 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-ABNjBXxtP72N4mZmt67qWQ-1; Thu, 22 Jun 2023 15:55:00 -0400
X-MC-Unique: ABNjBXxtP72N4mZmt67qWQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8D64856506;
	Thu, 22 Jun 2023 19:54:55 +0000 (UTC)
Received: from hog (unknown [10.39.195.41])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FBCE2166B25;
	Thu, 22 Jun 2023 19:54:54 +0000 (UTC)
Date: Thu, 22 Jun 2023 21:54:53 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES = 0
Message-ID: <ZJSnDZL-0hLxbDje@hog>
References: <20230620091301.21981-1-carlos.fernandez@technica-engineering.de>
 <20230621173429.18348fc8@kernel.org>
 <AM9PR08MB67880BD6AC346558D62C92C8DB22A@AM9PR08MB6788.eurprd08.prod.outlook.com>
 <AM9PR08MB67887483EDDF2AB7B11BF14FDB22A@AM9PR08MB6788.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM9PR08MB67887483EDDF2AB7B11BF14FDB22A@AM9PR08MB6788.eurprd08.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Carlos,

2023-06-22, 11:49:44 +0000, Carlos Fernandez wrote:
> Hi Jakub,
> 
> Also, about the double look up:
> I know it's there, but I tried to only change the function that returns the correct SCI in every case. Also, it should be a 1 and only item list. I do not think this should be dangerous or slow.

Why is it a 1 item list? Even if that was guaranteed to be true in
normal conditions, we could have a situation where lots of MACsec
SecYs and RXSCs are set up, and packets start hitting this loop.


And could you quote the correct section of 802.1AE? I can't find the
reference for the behavior you're implementing in this patch. All I
can find is (from section 9.5):

    The ES bit is clear if the Source Address is not used to determine the SCI.

    The SC bit shall be clear if an SCI is not present in the SecTAG.

which doesn't say anything about how to interpret both bits being
clear.


(and please don't top-post)


Thanks,

-- 
Sabrina


