Return-Path: <netdev+bounces-31723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D2978FC0F
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 13:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F49B2819C6
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 11:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC85A955;
	Fri,  1 Sep 2023 11:06:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D8779E6
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 11:06:02 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFAB10D2;
	Fri,  1 Sep 2023 04:06:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0783F2185A;
	Fri,  1 Sep 2023 11:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693566360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddEY5hmSfZEknJMt5BoR/ARnTSJr3qAhZpAWd1WA6sQ=;
	b=tujk+flZ+MtJfbZ24Hkdo/mLpNv2iBxplhrqI4DTvD6ardJEvbGN22FLMMCdL1JwkgG/+2
	UtbMU0SLpsAzeGbt2SGkU+oRBWyJZMPKhiBXItouA8u5TvNXsAjaTVWGhDEKTmWJafBmr+
	mvr9HU7Gna1Lx42+GAwrO4n0IKjZfYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693566360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ddEY5hmSfZEknJMt5BoR/ARnTSJr3qAhZpAWd1WA6sQ=;
	b=1DPIkngrFTwgdEMkgQz8P5Y0/tY0WRXCjjRLeZLK4EnAC4eVNM1mjOjg5Xf9+aZecC2jQu
	62xXsGSJRgmApRAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAA8F13582;
	Fri,  1 Sep 2023 11:05:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ODsjJ5fF8WREdQAAMHmgww
	(envelope-from <dkirjanov@suse.de>); Fri, 01 Sep 2023 11:05:59 +0000
Message-ID: <7b8be7bd-baf2-15c0-2a0c-ddf64839a451@suse.de>
Date: Fri, 1 Sep 2023 14:05:59 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] fsl_ucc_hdlc: process the result of hold_open()
Content-Language: en-US
To: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGA0LAg0JTRjtC/0LjQvdCw?=
 <adiupina@astralinux.ru>, Jakub Kicinski <kuba@kernel.org>,
 Zhao Qiang <qiang.zhao@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <896acfac-fadb-016b-20ff-a06e18edb4d9@csgroup.eu>
 <20230828121235.13953-1-adiupina@astralinux.ru>
 <20230828123849.69466f0a@kernel.org>
 <977826f0-3289-53bd-b3f6-90977a4e0ca0@astralinux.ru>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <977826f0-3289-53bd-b3f6-90977a4e0ca0@astralinux.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/1/23 13:48, Александра Дюпина wrote:
> Thanks for the review!
> 
> 28.08.2023 22:38, Jakub Kicinski пишет:
>> Don't you have to undo all the things done prior to hdlc_open()?
> Yes, it looks like I really need to undo everything that was done before hdlc_open().
> But the question arose - would it be enough to call the uhdlc_close(dev) function?

looks like it is.

> In addition, it seems to me and my colleagues that a call to hdlc_close(dev) should be added to the uhdlc_close() function, similar to the 

yes, take a look at the comment for hdlc_close()

following functions:
> 1. drivers/net/wan/n2.c (n2_close function)
> 2. drivers/net/wan/pc300too.c (pc300_close function)
> 3. drivers/net/wan/pci200syn.c (pci200_close function)
> 4. drivers/net/wan/wanxl.c (wanxl_close function)
> Tell me, please, are we wrong?
> 

