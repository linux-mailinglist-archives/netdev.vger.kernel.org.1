Return-Path: <netdev+bounces-18209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE20D755CF1
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978CC2812AF
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE3B8BFC;
	Mon, 17 Jul 2023 07:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE3848A
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:32:40 +0000 (UTC)
Received: from smtp201-pc.aruba.it (smtp201-pc.aruba.it [62.149.157.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A94E48
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 00:32:37 -0700 (PDT)
Received: from [192.168.99.113] ([185.58.134.212])
	by Aruba Outgoing Smtp  with ESMTPA
	id LIihqxj2aTtzhLIihqB3wn; Mon, 17 Jul 2023 09:32:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1689579155; bh=THOYeaz0A7m5+PsRydB9K5UqlZzKhdELecEZlneVYhY=;
	h=Date:MIME-Version:From:Subject:To:Content-Type;
	b=P2bbpxtLtr7h4sAEle31Ews+fL9lMMSq91dZiAmZNQIxO60MpFLZebcuw9+tslihe
	 R36kPlHGbzdsVasosqB6hH8t2PzgCt+XF4NCooB9ov9yccG0WRMCk+xwpMkuVpPUDA
	 xAI1C6pkxfrKV/NC1HuaO7wnmWcacFDI9Y5rF/eduA67Za5SHI3GOJgE5d9lxhiBhw
	 i/qq7m/Fe9DBDZPc3RmQLB3x8VBebaCGUvXfLUOmwAtCKdjDU9Yh6BKcoqIQc3XVi7
	 D/6wz+P85i7sWw1ofAqIaXwuVoF4Z2L+xObuLEg22PbRwcG5U6oZX6OBA4m/sTDyJB
	 EeAs81LDHm82w==
Message-ID: <db7508ce-6e92-a199-584b-0a729cd767b9@leaff.it>
Date: Mon, 17 Jul 2023 09:32:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Riccardo Laiolo <laiolo@leaff.it>
Subject: Question on IGMP snooping on switch managment port
Content-Language: en-US, it-IT
Reply-To: Riccardo Laiolo <laiolo@leaff.it>
References: <a9d86e8e-2e7e-fe03-731c-ad4c372d4048@leaff.it>
To: netdev@vger.kernel.org
In-Reply-To: <a9d86e8e-2e7e-fe03-731c-ad4c372d4048@leaff.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBkw4jYHO8o6INYwfYwq615bTeEGuz22KBPon3KLh7yaIIUZ8cNeJWDr0LjzCle60JkKQ0SLK86VoCaRCfRXb9ifTN7/foa9DMzPQI0dANDZT7NND3KZ
 lpGPViPpVoivNCNWESqmweoIEEWnocp7P6XNzZR8yPym/jcdI01LBfvCG/MJcJDVLFIa2K9IkogYog==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I'm working on a NXP-based embedded board (imx8mp) with a Marvell mv88e6390 switch.
I'm running Linux 5.15.71 from the NXP downstream git repository (which is a year behind
the upstream 5.15.y LTS release, I think). I've applied all the commits related to the Marvell
driver from the 5.15LTS upstream that I was missing into my codebase.

I can't get the IGMP snooping to works properly. On front facing ports, it appears to work fine:
MDB rules get correctly updated and multicast packets get blocked or routed accordingly. But when
the subscribed is my embedded device (so the subscribed device is the switch
management port) it doesn't work. The first IGMP packet get correctly routed and
propagated through te network and all the interested node update their MDB entry list.

 From now on all the outgoing IGMP packets get dropped.


Adding and removing MDB rules by hand I found the offending rule appears to be
	dev br0 port br0 grp 224.0.1.185 temp

this rule gets correctly appended when I open a multicast rx socket,
but my device fails to answer to any IMGP membership query until I remove said rule.

What am I missing? Is it possible for a linux network switch to be a multicast recipient device?

-- 
Riccardo Laiolo


