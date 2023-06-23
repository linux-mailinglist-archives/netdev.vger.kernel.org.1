Return-Path: <netdev+bounces-13352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF8D73B538
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A98E2819AD
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D4A611C;
	Fri, 23 Jun 2023 10:27:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B27610D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:27:08 +0000 (UTC)
Received: from ultron (136.red-2-136-200.staticip.rima-tde.net [2.136.200.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 556C9E9;
	Fri, 23 Jun 2023 03:27:06 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ultron (Postfix) with ESMTP id 9FA581AC5046;
	Fri, 23 Jun 2023 12:13:55 +0200 (CEST)
From: carlos.fernandez@technica-engineering.de
To: carlos.fernandez@technica-engineering.de,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: macsec SCI assignment for ES = 0
Date: Fri, 23 Jun 2023 12:13:55 +0200
Message-Id: <20230623101355.26790-1-carlos.fernandez@technica-engineering.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ZJSnDZL-0hLxbDje@hog>
References: <ZJSnDZL-0hLxbDje@hog>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
	HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,SPF_FAIL,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Regarding ES, it is only set if the first 6 octets of the SCI are equal to the MAC, 
in which case SC=0 as well (IEEE802.1AE 9.5 TAG Control information). 
However, if ES=0, it is incorrect to use source MAC as SCI (current implementation)

 
Regarding SC, as said in IEEE 802.1AE 9.9:


"An explicitly encoded SCI field in the SecTAG is not required on point-to-point links, 
which are identified by (...), if the transmitting SecY uses only one transmit SC. 
In that case, the secure association created by the SecY for the peer SecYs, together with
the direction of transmission of the secured MPDU, can be used to identify the transmitting SecY."

 
Therefore the case SC=0 is reserved for cases where both conditions apply: point-to-point links, 
and only one transmit SC. This requirement makes the size of the reception lookup 1.
 

In conclusion, if we're in a NON end station MPDU scenario (ES = 0)  and SCI it's not in the SegTAG (SC = 0), 
we need to find the correct SCI. This can be done by searching it at the current (only) active RX_SC.

Thanks
--
Carlos

